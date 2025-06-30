const user = require('../../models/User');
const UserDetails = require('../../models/UserDetails');
const UserLocation = require('../../models/UserLocation');
const OrderDetail = require('../../models/OrderBookings');
const Suggestion = require('../../models/Suggestion');
const UserRideType = require('../../models/UserRideType');
const PickupType = require('../../models/PickupType');
const Notifications = require('../../models/Notifications');
const UserNotification = require('../../models/UserNotification');
const OrderHistory = require('../../models/OrderHistory');
const Insurance = require('../../models/Insurance');
const Ride = require('../../models/Ride');
const bcrypt = require('bcrypt');
const moment = require('moment');
const Favourite = require('../../models/Favourite');
const jwt = require('jsonwebtoken');
const { Op } = require('sequelize');
const { v4: uuidv4 } = require('uuid');
const PricingRules = require('../../models/PricingRules');
const axios = require('axios');
const FormData = require('form-data');
const UserReview = require('../../models/UserReview');

const JWT_SECRET = process.env.JWT_SECRET;
exports.userSignUp = async (req, res) => {
    const {
        mobile,
        email,
        password,
        firstname,
        lastname,
        gender,
        dob,
        city,
        userStatusId,
        userStatus
    } = req.body;

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!email || !emailRegex.test(email)) {
        return res.status(400).json({ success: false, message: 'Invalid email format.' });
    }

    const mobileRegex = /^\d{10}$/;
    if (!mobile || !mobileRegex.test(mobile)) {
        return res.status(400).json({ success: false, message: 'Mobile number must be 10 digits.' });
    }

    if (!password || password.length < 6) {
        return res.status(400).json({ success: false, message: 'Password must be at least 6 characters.' });
    }

    if (!firstname || firstname.trim() === '') {
        return res.status(400).json({ success: false, message: 'First name is required.' });
    }

    try {
        const existingEmail = await user.findOne({ where: { email } });
        if (existingEmail) {
            return res.status(409).json({ success: false, message: 'Email already in use.' });
        }

        const existingMobile = await user.findOne({ where: { mobile } });
        if (existingMobile) {
            return res.status(409).json({ success: false, message: 'Mobile number already in use.' });
        }

        const hashedPassword = await bcrypt.hash(password, 10);
        const user_uid = uuidv4();

        const newUser = await user.create({
            mobile,
            email,
            user_uid,
            password: hashedPassword,
            firstname,
            lastname,
            gender,
            dob,
            city: city || null,
            user_status_id: userStatusId || 1,
            user_status: userStatus || "Approval Pending"
        });

        const generateOtp = Math.floor(1000 + Math.random() * 9000);

        const notification = await Notifications.findOne({
            where: { title: "OTPSignUp" }
        });

        if (!notification) {
            return res.status(404).json({ success: false, message: "Notification not found" });
        }

        const otpUpdate = await UserNotification.create({
            user_id: newUser.id,
            notification_id: notification.id,
            user_otp: generateOtp
        });


        const url = "https://wtservices.ackrock.com/api/send/whatsapp";
        const secretKey = "f3b630127a407ae9dba5206ad454dd2d88ecaae7";
        const account = '1749049350aab3238922bcc25a6f606eb525ffdc566840600606b57';
        const recipient = "+91" + newUser.mobile;
        const type = 'text';
        const message = 'Welcome to Godago signup OTP:' + generateOtp;

        try {
            const form = new FormData();
            form.append('secret', secretKey);
            form.append('account', account);
            form.append('recipient', recipient);
            form.append('type', type);
            form.append('message', message);

            const response = await axios.post(url, form, {
                headers: form.getHeaders(),
            });

            return res.status(201).json({
                success: true,
                message: 'User record created successfully.',
                data: {
                    userId: newUser.id,
                    otp: generateOtp,
                    id: otpUpdate.id,
                    mobile: newUser.mobile
                }
            });
        } catch (error) {
            if (error.response) {
                console.error("Error:", error.response.status, error.response.data);
                res.status(error.response.status).json({ success: false, error: error.response.data });
            } else {
                console.error("Error:", error.message);
                res.status(500).json({ success: false, error: error.message });
            }
        }




    } catch (error) {
        console.error('Signup Error:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error. Please try again later.',
            error: error.message
        });
    }
};



exports.fetchUserDetails = async (req, res) => {
    const { userId } = req.body;
    if (!userId) {
        return res.status(400).json({
            success: false,
            message: 'userId Required.',
        });
    }

    try {
        const foundUser = await user.findOne({
            where: {
                id: userId,
                deleted_flag: null,
                deleted_at: null
            },
            include: [
                {
                    model: UserDetails,
                    required: false,
                    where: {
                        deleted_flag: null,
                        deleted_at: null
                    }
                }
            ]
        });
        console.log('foundUser:', foundUser);

        if (!foundUser) {
            return res.status(404).json({ success: false, message: 'User not found or marked as deleted.' });
        }
        foundUser.profile = `https://zoober.ackrock.com/upload/images/${foundUser.profile}`;
        return res.status(200).json({ success: true, user: foundUser });
    } catch (error) {
        console.error('Error fetching user details:', error);
        return res.status(500).json({ success: false, message: 'Server error' });
    }
};

exports.getAllUsers = async (req, res) => {
    try {
        const foundUsers = await user.findAll({
            where: {
                deleted_flag: null,
                deleted_at: null
            },
            attributes: [
                ['id', 'userId'],
                'firstname',
                'lastname',
                'email',
                'mobile',
                ['user_status', 'userStatus'],
                'city',
                ['created_at', 'createdAt']
            ],
            include: [
                {
                    model: UserDetails,
                    required: false,
                    where: {
                        deleted_flag: null,
                        deleted_at: null
                    },
                    attributes: ['rating', ['wallet', 'earning']]
                }
            ],
            raw: true,
            nest: true
        });

        // Use Promise.all to wait for all async .count() calls
        const flattenedUsers = await Promise.all(
            foundUsers.map(async user => {
                const userRideCount = await OrderDetail.count({
                    where: {
                        deleted_flag: null,
                        deleted_at: null,
                        user_id: user.userId,
                        order_status_id: 5
                    }
                });

                return {
                    userId: user.userId,
                    firstname: user.firstname,
                    lastname: user.lastname,
                    email: user.email,
                    mobile: user.mobile,
                    userStatus: user.userStatus,
                    city: user.city,
                    createdAt: user.createdAt,
                    rating: user.user_detail?.rating || null,
                    earning: user.user_detail?.earning || null,
                    totalRides: userRideCount || 0
                };
            })
        );

        if (flattenedUsers.length === 0) {
            return res.status(404).json({ success: false, message: 'No users found or all marked as deleted.' });
        }

        return res.status(200).json({ success: true, users: flattenedUsers });
    } catch (error) {
        console.error('Error fetching user details:', error);
        return res.status(500).json({ success: false, message: 'Server error', error: error.message });
    }
};

exports.addInsurance = async (req, res) => {
    const { title, description, termCondition } = req.body;

    if (!title || title.trim() === '') {
        return res.status(400).json({ success: false, message: 'Title is required' });
    }

    try {
        const newInsurance = await Insurance.create({
            title,
            description,
            termCondition
        });

        return res.status(201).json({
            success: true,
            message: 'Insurance added successfully',
            data: newInsurance
        });
    } catch (error) {
        return res.status(500).json({
            success: false,
            message: 'Server error',
            error: error.message
        });
    }
};


exports.userReviewAndRating = async (req, res) => {
    const { userId } = req.body;

    if (!userId) {
        return res.status(400).json({ success: false, message: 'userId is required' });
    }

    try {
        const userReview = await UserReview.findOne({
            where: {
                user_id: userId,
                review_type_status: 1
            }
        });

        if (!userReview) {
            return res.status(404).json({ success: false, message: 'No review found' });
        }

        const riderData = await getRiderDetails(userReview.rider_id); 
        return res.status(200).json({
            success: true,
            message: 'User review and rider details retrieved successfully',
            data: {
                
                rider: riderData
            }
        });

    } catch (error) {
        return res.status(500).json({
            success: false,
            message: 'Server error',
            error: error.message
        });
    }
};

const getRiderDetails = async (riderId) => {
    if (!riderId) throw new Error('riderId is required');

    const rider = await Ride.findOne({
        where: {
            id: riderId,
            deleted_at: null,
            deleted_flag: null,
        }
    });

    if (!rider) return null;

    return {
        riderId: rider.id,
        profile: rider.profile,
        mobile: rider.mobile,
        firstName: rider.firstname,
        lastName: rider.lastname,
    };
};



exports.reteriveInsurances = async (req, res) => {
    try {
        const insurances = await Insurance.findAll({
            where: {
                deleted_flag: null
            }
        });

        return res.status(200).json({
            success: true,
            message: 'Insurances retrieved successfully',
            data: insurances
        });
    } catch (error) {
        return res.status(500).json({
            success: false,
            message: 'Server error',
            error: error.message
        });
    }
};
exports.reteriveInsuranceById = async (req, res) => {
    const { insuranceId } = req.body;


    if (!insuranceId) {
        return res.status(400).json({
            success: false,
            message: 'insuranceId is required'
        });
    }

    try {
        const insurance = await Insurance.findOne({
            where: {
                id: insuranceId,
                deleted_flag: null
            }
        });

        if (!insurance) {
            return res.status(404).json({
                success: false,
                message: 'Insurance not found'
            });
        }

        return res.status(200).json({
            success: true,
            message: 'Insurance retrieved successfully',
            data: insurance
        });
    } catch (error) {
        return res.status(500).json({
            success: false,
            message: 'Server error',
            error: error.message
        });
    }
};

exports.deletedMarkIsuranceById = async (req, res) => {
    const { insuranceId } = req.body;

    if (!insuranceId) {
        return res.status(400).json({
            success: false,
            message: 'insuranceId is required'
        });
    }

    try {
        const [updatedCount] = await Insurance.update(
            {
                deleted_flag: 1,
                deleted_at: new Date()
            },
            {
                where: {
                    id: insuranceId,
                    deleted_flag: null
                }
            }
        );

        if (updatedCount === 0) {
            return res.status(404).json({
                success: false,
                message: 'Insurance not found or already deleted'
            });
        }

        return res.status(200).json({
            success: true,
            message: 'Insurance deleted successfully'
        });
    } catch (error) {
        return res.status(500).json({
            success: false,
            message: 'Server error',
            error: error.message
        });
    }
};

exports.sendWhatsappOtp = async (req, res) => {


    const mobile = req.body.mobile;

    if (!mobile || mobile.length < 10) {
        return res.status(400).json({ success: false, message: "Mobile number must be at least 10 digits" });
    }

    try {
        const checkUserMobile = await user.findOne({
            where: { mobile: mobile }
        });

        if (checkUserMobile) {
            const randomOtp = Math.floor(1000 + Math.random() * 9000);
            const notification = await Notifications.findOne({
                where: { title: "OTPLogin" }
            });

            if (!notification) {
                return res.status(404).json({ success: false, message: "Notification not found" });
            }

            const otpUpdate = await UserNotification.create({
                user_id: checkUserMobile.id,
                notification_id: notification.id,
                user_otp: randomOtp
            });

            const url = "https://wtservices.ackrock.com/api/send/whatsapp";
            const secretKey = "f3b630127a407ae9dba5206ad454dd2d88ecaae7";
            const account = '1749049350aab3238922bcc25a6f606eb525ffdc566840600606b57';
            const recipient = "+91" + checkUserMobile.mobile;
            const type = 'text';
            const message = 'Welcome to Godago OTP:' + randomOtp;

            try {
                const form = new FormData();
                form.append('secret', secretKey);
                form.append('account', account);
                form.append('recipient', recipient);
                form.append('type', type);
                form.append('message', message);

                const response = await axios.post(url, form, {
                    headers: form.getHeaders(),
                });

                return res.status(200).json({ success: true, message: "OTP sent", otp: randomOtp, userId: otpUpdate.user_id, id: otpUpdate.id });

            } catch (error) {
                if (error.response) {
                    console.error("Error:", error.response.status, error.response.data);
                    res.status(error.response.status).json({ success: false, error: error.response.data });
                } else {
                    console.error("Error:", error.message);
                    res.status(500).json({ success: false, error: error.message });
                }
            }



        } else {
            return res.status(404).json({ success: false, message: "User not found" });
        }
    } catch (error) {
        console.error(error);
        return res.status(500).json({ success: false, message: "Internal Server Error" });
    }

};

exports.whatsappOtpValidate = async (req, res) => {
    const { id, userId, otp, type } = req.body;

    if (!id || !userId || !otp) {
        return res.status(400).json({
            success: false,
            message: "All fields (id, userId, otp) are required"
        });
    }

    try {
        const getOtp = await UserNotification.findOne({
            where: {
                id: id,
                user_id: userId
            }
        });

        if (!getOtp) {
            return res.status(404).json({
                success: false,
                message: "User notification not found"
            });
        }

        if (getOtp.user_otp.toString() !== otp.toString()) {
            return res.status(401).json({ success: false, message: "Invalid OTP" });
        }

        // If OTP is valid and type === 1, update the user status
        if (type === 1) {
            await user.update(
                {
                    user_status: "Active",
                    user_status_id: 2
                },
                { where: { id: userId } }
            );
        }

        const userDetails = await user.findOne({ where: { id: userId, user_status_id: 2 } });

        if (!userDetails) {
            return res.status(404).json({
                success: false,
                message: "User not found or has been deleted or not approved."
            });
        }

        const token = jwt.sign(
            {
                id: userDetails.id,
                mobile: userDetails.mobile
            },
            process.env.JWT_SECRET,
            { expiresIn: '1d' }
        );

        return res.status(200).json({
            success: true,
            message: 'Login successful',
            token,
            user: {
                id: userDetails.id,
                mobile: userDetails.mobile,
                firstName: userDetails.firstname,
                user_uid: userDetails.user_uid
            }
        });

    } catch (error) {
        console.error("Error:", error);
        return res.status(500).json({
            success: false,
            message: "Internal Server Error",
            error: error.message
        });
    }
};




exports.totalUsers = async (req, res) => {
    try {
        const totalUsers = await user.count();

        return res.status(200).json({
            success: true,
            totalUsers,
        });
    } catch (error) {
        console.error('Error fetching user count:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error',
            error: error.message,
        });
    }
};

exports.userProfileUpdate = async (req, res) => {
    try {
        const userId = req.body.userId;
        const firstname = req.body.firstname;
        const lastname = req.body.lastname;
        const email = req.body.email;
        const mobile = req.body.mobile;
        const gender = req.body.gender;
        const dob = req.body.dob;
        const city = req.body.city;
        const user_status = req.body.user_status;
        // console.log('check:', userId,firstname,lastname,email,mobile,gender,dob);
        if (!userId) {
            return res.status(400).json({ success: false, message: 'userId is required' });
        }

        const updateData = {
            firstname,
            lastname,
            email,
            mobile,
            gender,
            dob,
            city,
            user_status
        };

        if (req.file && req.file.filename) {
            updateData.profile = req.file.filename;
        }

        const [updated] = await user.update(updateData, {
            where: { id: userId }
        });

        if (!updated) {
            return res.status(404).json({ success: false, message: 'User not found or not updated' });
        }

        return res.status(200).json({
            success: true,
            message: 'User profile updated successfully',
            data: updateData
        });

    } catch (error) {
        console.error('Profile update error:', error);
        return res.status(500).json({ success: false, message: 'Server error' });
    }
};
exports.addUserDetails = async (req, res) => {
    try {
        const { userId, user_uid, rating, wallet } = req.body;
        if (!userId) {
            return res.status(400).json({ success: false, message: 'userId is required' });
        }
        const newUserDetails = await UserDetails.create({
            id: userId,
            user_uid,
            rating,
            wallet
        });

        return res.status(201).json({
            success: true,
            message: 'User details created successfully',
            data: newUserDetails
        });

    } catch (error) {
        console.error('Profile creation error:', error);
        return res.status(500).json({ success: false, message: 'Server error' });
    }
};
exports.updateUserDetails = async (req, res) => {
    try {
        const { userId, user_uid, rating, wallet } = req.body;

        if (!userId) {
            return res.status(400).json({ success: false, message: 'userId is required' });
        }

        const updateData = {
            user_uid,
            rating,
            wallet
        };

        const [updated] = await UserDetails.update(updateData, {
            where: { id: userId }
        });

        if (updated === 0) {
            return res.status(404).json({ success: false, message: 'User not found or not updated' });
        }

        return res.status(200).json({
            success: true,
            message: 'User details updated successfully',
            data: updateData
        });

    } catch (error) {
        console.error('Profile update error:', error);
        return res.status(500).json({ success: false, message: 'Server error' });
    }
};
exports.deletedUserDetails = async (req, res) => {
    try {
        const { userId } = req.body;

        if (!userId) {
            return res.status(400).json({ success: false, message: 'userId is required' });
        }

        const updateData = {
            deleted_flag: 1,
            deleted_at: new Date()
        };

        const [updated] = await UserDetails.update(updateData, {
            where: { id: userId }
        });

        if (updated === 0) {
            return res.status(404).json({ success: false, message: 'User not found or already deleted.' });
        }

        return res.status(200).json({
            success: true,
            message: 'User deleted successfully (soft delete)',
            data: { userId, ...updateData }
        });

    } catch (error) {
        console.error('Soft delete error:', error);
        return res.status(500).json({ success: false, message: 'Server error' });
    }
};
exports.userLogin = async (req, res) => {
    const { mobile, password } = req.body;

    const mobileRegex = /^\d{10}$/;
    if (!mobile || !mobileRegex.test(mobile)) {
        return res.status(400).json({ success: false, message: 'Mobile number must be 10 digits.' });
    }

    if (!password || password.length < 6) {
        return res.status(400).json({ success: false, message: 'Password must be at least 6 characters.' });
    }

    try {
        const existingUser = await user.findOne({
            where: {
                mobile,
                user_status_id: 2,
                deleted_flag: null,
                deleted_at: null
            }
        });

        if (!existingUser) {
            return res.status(404).json({
                success: false,
                message: 'User not found, has been deleted, or is not approved.',
            });
        }
        const isMatch = await bcrypt.compare(password, existingUser.password);
        if (!isMatch) {
            return res.status(401).json({ success: false, message: 'Invalid mobile number or password.' });
        }
        const token = jwt.sign(
            { id: existingUser.id, mobile: existingUser.mobile },
            process.env.JWT_SECRET,
            { expiresIn: '1d' }
        );

        return res.status(200).json({
            success: true,
            message: 'Login successful',
            token,
            user: {
                id: existingUser.id,
                mobile: existingUser.mobile,
                firstName: existingUser.firstname,
                user_uid: existingUser.user_uid
            }
        });

    } catch (error) {
        console.error('Login error:', error);
        return res.status(500).json({ success: false, message: 'Server error' });
    }
};
exports.deviceLocation = async (req, res) => {
    const { user_id, device_location } = req.body;

    if (!user_id) {
        return res.status(400).json({
            success: false,
            message: 'userId is required.',
        });
    }
    if (!device_location) {
        return res.status(400).json({
            success: false,
            message: 'deviceLocation is required.',
        });
    }

    try {
        const newLocation = await UserLocation.create({
            user_id,
            device_location
        });

        return res.status(201).json({
            success: true,
            message: 'Device location saved successfully.',
            data: newLocation
        });

    } catch (error) {
        console.error('Location Save Error:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error. Please try again later.',
            error: error.message
        });
    }
};

exports.deleteAccount = async (req, res) => {
    const { userId } = req.body;

    if (!userId) {
        return res.status(400).json({
            success: false,
            message: 'userId Required.',
        });
    }

    try {
        const userDeletedFlag = await user.findOne({
            where: {
                id: userId,
                deleted_flag: null,
                deleted_at: null
            }
        });

        if (!userDeletedFlag) {
            return res.status(404).json({
                success: false,
                message: 'User not found or already deleted.',
            });
        }

        await user.update(
            {
                deleted_flag: 1,
                deleted_at: new Date(),
            },
            {
                where: {
                    id: userId,
                    deleted_flag: null,
                    deleted_at: null
                }
            }
        );

        return res.status(200).json({
            success: true,
            message: 'User account marked as deleted.',
        });

    } catch (error) {
        console.error('Delete Error:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error.',
        });
    }
};

exports.logout = async (req, res) => {
    const { userId } = req.body;
};

exports.favouriteList = async (req, res) => {
    const { userId } = req.body;

    if (!userId) {
        return res.status(400).json({
            success: false,
            message: 'userId Required.',
        });
    }

    try {
        const favourites = await Favourite.findAll({
            where: {
                user_id: userId,
                deleted_at: null
            }
        });

        if (favourites.length === 0) {
            return res.status(404).json({
                success: false,
                message: 'No favourites found for the given userId.',
            });
        }

        return res.status(200).json({
            success: true,
            message: 'Favourites retrieved successfully.',
            data: favourites,
        });
    } catch (error) {
        console.error('Error fetching favourites:', error);
        return res.status(500).json({
            success: false,
            message: 'Server Error',
        });
    }
};


exports.addFavourite = async (req, res) => {
    const { userId, title, description } = req.body;

    if (!userId) {
        return res.status(400).json({
            success: false,
            message: 'userId is required.',
        });
    }

    try {
        const favourite = await Favourite.create({
            user_id: userId,
            title,
            description
        });

        return res.status(200).json({
            success: true,
            message: 'Favourite added successfully.',
            data: favourite,
        });
    } catch (error) {
        console.error('Error adding favourite:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error.',
        });
    }
};

exports.editFavourite = async (req, res) => {
    const { userId, title, description, id } = req.body;

    if (!id) {
        return res.status(400).json({
            success: false,
            message: 'Favourite Id is required.',
        });
    }

    try {
        const [updatedRows] = await Favourite.update(
            {
                title,
                description,
                user_id: userId,
            },
            {
                where: { id: id }
            }
        );

        if (updatedRows === 0) {
            return res.status(404).json({
                success: false,
                message: 'No favourite found with this ID to update.',
            });
        }

        return res.status(200).json({
            success: true,
            message: 'Favourite updated successfully.',
        });
    } catch (error) {
        console.error('Error updating favourite:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error.',
        });
    }
};

exports.deleteFavourite = async (req, res) => {
    const { id } = req.body;

    if (!id) {
        return res.status(400).json({
            success: false,
            message: 'Favourite Id is required.',
        });
    }

    try {
        const [updatedRows] = await Favourite.update(
            {
                deleted_at: new Date(),
            },
            {
                where: { id: id }
            }
        );

        if (updatedRows === 0) {
            return res.status(404).json({
                success: false,
                message: 'No favourite found with this ID to delete.',
            });
        }

        return res.status(200).json({
            success: true,
            message: 'Favourite deleted successfully (soft delete).',
        });
    } catch (error) {
        console.error('Error deleting favourite:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error.',
        });
    }
};

exports.userOrderBooking = async (req, res) => {
    const {
        user_uid,
        user_id,
        pickup_type_id,
        user_ride_type_id,
        distance,
        pickup_latitude,
        pickup_longitude,
        drop_latitude,
        drop_longitude,
        pickup_start_datetime,
        pickup_location,
        drop_location,
        suggestion_id,
        order_status
    } = req.body;

    const requiredFields = {
        user_id,
        pickup_latitude,
        pickup_longitude,
        pickup_location,
        distance,
        drop_latitude,
        drop_longitude,
        drop_location
    };

    for (const [field, value] of Object.entries(requiredFields)) {
        if (value === undefined || value === null || value === '') {
            return res.status(400).json({
                success: false,
                message: `${field} is required.`
            });
        }
    }
    const numericDistance = typeof distance === 'string' ? distance.replace('km', '').trim() : distance;
    try {
        const newOrder = await OrderDetail.create({
            user_uid,
            user_id,
            pickup_type_id,
            user_ride_type_id,
            distance: numericDistance,
            pickup_latitude,
            pickup_longitude,
            drop_latitude,
            drop_longitude,
            pickup_start_datetime,
            pickup_location,
            drop_location,
            suggestion_id,
            order_status: order_status ?? "stage_1",
            order_status_id: 1

        });



        return res.status(201).json({
            success: true,
            message: 'Order stored and estimates calculated successfully.',
            data: newOrder,

        });

    } catch (error) {
        console.error('Error storing order details:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error. Please try again later.',
            error: error.message
        });
    }
};
exports.estimatesListUserBooking = async (req, res) => {
    const { user_id, order_id } = req.body;

    const requiredFields = { user_id, order_id };
    for (const [field, value] of Object.entries(requiredFields)) {
        if (value === undefined || value === null || value === '') {
            return res.status(400).json({
                success: false,
                message: `${field} is required.`
            });
        }
    }

    try {
        const bookingDetails = await OrderDetail.findOne({
            where: {
                user_id,
                id: order_id
            }
        });

        if (!bookingDetails) {
            return res.status(404).json({
                success: false,
                message: 'Order not found.'
            });
        }

        const suggestions = await Suggestion.findAll({
            where: {
                deleted_flag: null,
                deleted_at: null
            }
        });

        const estimate = [];
        for (const suggestion of suggestions) {
            const priceRule = await PricingRules.findOne({
                where: {
                    suggestion_id: suggestion.id,
                    deleted_flag: null,
                    deleted_at: null
                }
            });

            if (priceRule) {
                const amount = parseFloat((priceRule.price_per_km * bookingDetails.distance).toFixed(2));
                const totalMinutes = parseFloat((priceRule.per_kilometer_time * bookingDetails.distance).toFixed(2));
                const hours = Math.floor(totalMinutes / 60);
                const minutes = Math.round(totalMinutes % 60);
                const formattedTime = `${hours > 0 ? hours + 'h ' : ''}${minutes}m`;

                estimate.push({
                    suggestion_id: suggestion.id,
                    name: suggestion.name,
                    amount,
                    timing: formattedTime,
                    orderId: bookingDetails.id,
                    distance: bookingDetails.distance,
                    userId: bookingDetails.user_id
                });
            }
        }

        return res.status(200).json({
            success: true,
            message: 'Estimates calculated successfully.',
            estimates: estimate
        });

    } catch (error) {
        console.error('Error fetching order estimates:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error. Please try again later.',
            error: error.message
        });
    }
};

exports.priceUpdateUserBooking = async (req, res) => {
    const {
        user_id,
        order_id,
        amount,
        duration,
        suggestion_id
    } = req.body;

    const requiredFields = {
        user_id,
        suggestion_id,
        amount,
        duration,
        order_id
    };

    for (const [field, value] of Object.entries(requiredFields)) {
        if (value === undefined || value === null || value === '') {
            return res.status(400).json({
                success: false,
                message: `${field} is required.`
            });
        }
    }

    try {
        const [updated] = await OrderDetail.update(
            {
                user_id,
                amount,
                suggestion_id,
                duration,
                order_status: "Stage_2",
                order_status_id: 2
            },
            {
                where: { id: order_id }
            }
        );

        if (updated === 0) {
            return res.status(404).json({
                success: false,
                message: 'Order not found or no changes made.'
            });
        }
        const notification = await Notifications.findOne({
            where: { title: 'OrderBooking' }
        });

        if (!notification) {
            return res.status(404).json({
                success: false,
                message: 'Notification with title "OrderBooking" not found.'
            });
        }
        await UserNotification.create({
            user_id: user_id,
            notification_id: notification.id
        });

        return res.status(200).json({
            success: true,
            message: 'Order updated and notification sent.'
        });

    } catch (error) {
        console.error('Error updating order details:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error. Please try again later.',
            error: error.message
        });
    }
};
exports.pickupTypes = async (req, res) => {
    try {
        const pickupTypes = await PickupType.findAll({
            where: {
                deleted_flag: {
                    [Op.is]: null
                }
            }
        });

        return res.status(200).json({
            success: true,
            message: 'Pickup types fetched successfully.',
            data: pickupTypes
        });
    } catch (error) {
        console.error('Error fetching pickup types:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error. Please try again later.',
            error: error.message
        });
    }
};
exports.UserRideTypes = async (req, res) => {
    try {
        const UserRideTypes = await UserRideType.findAll({
            where: {
                deleted_flag: {
                    [Op.is]: null
                }
            }
        });

        return res.status(200).json({
            success: true,
            message: 'User Ride types fetched successfully.',
            data: UserRideTypes
        });
    } catch (error) {
        console.error('Error fetching pickup types:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error. Please try again later.',
            error: error.message
        });
    }
};
exports.suggestions = async (req, res) => {
    try {
        const suggestions = await Suggestion.findAll({
            where: {
                deleted_flag: {
                    [Op.is]: null
                }
            }
        });
        return res.status(200).json({
            success: true,
            message: 'Suggestion fetched successfully.',
            data: suggestions
        });
    } catch (error) {
        console.error('Error fetching pickup types:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error. Please try again later.',
            error: error.message
        });
    }
};

exports.userRidesHistory = async (req, res) => {
    const { user_id } = req.body;

    if (!user_id) {
        return res.status(400).json({
            success: false,
            message: `user_id is required.`
        });
    }

    try {
        const today = new Date();

        const rideHistory = await OrderDetail.findAll({
            where: {
                user_id: user_id,
                order_status_id: 5,
                deleted_at: null,
                deleted_flag: null
            },
            order: [['id', 'DESC']]
        });

        return res.status(200).json({
            success: true,
            message: 'Ride history fetched successfully.',
            data: rideHistory
        });
    } catch (error) {
        console.error('Error fetching ride history:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error. Please try again later.',
            error: error.message
        });
    }
};

exports.sendUserBookingOtp = async (req, res) => {
    try {
        const { userId, bookingId } = req.body;

        if (!userId) {
            return res.status(400).json({ success: false, message: 'userId is required' });
        }

        if (!bookingId) {
            return res.status(400).json({ success: false, message: 'bookingId is required' });
        }

        const random5Digit = Math.floor(1000 + Math.random() * 9000);

        const [updated] = await OrderDetail.update(
            {
                otp: random5Digit,
                otp_status: '1',
                order_status: 'OTP Processing',
                order_status_id: 3
            },
            {
                where: {
                    id: bookingId,
                    user_id: userId
                }
            }
        );

        if (updated === 0) {
            return res.status(404).json({
                success: false,
                message: 'Booking not found or update failed.'
            });
        }

        const notification = await Notifications.findOne({
            where: { title: 'DriverSendOTP' }
        });

        if (!notification) {
            return res.status(404).json({
                success: false,
                message: 'Notification with title "DriverSendOTP" not found.'
            });
        }
        await UserNotification.create({
            user_id: userId,
            notification_id: notification.id,
            user_otp: random5Digit
        });

        return res.status(200).json({
            success: true,
            message: 'OTP sent successfully.',
            otp: random5Digit
        });

    } catch (error) {
        console.error('OTP update error:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error',
            error: error.message
        });
    }
};


exports.bookingOtpValidateUser = async (req, res) => {
    try {
        const { userId, bookingId, otp, rideId } = req.body;

        if (!userId || !bookingId || !otp) {
            return res.status(400).json({ success: false, message: 'userId, bookingId, and otp are required' });
        }

        const booking = await OrderDetail.findOne({
            where: {
                id: bookingId,
                user_id: userId
            }
        });

        if (!booking) {
            return res.status(404).json({ success: false, message: 'Booking not found' });
        }


        if (booking.otp !== otp) {
            return res.status(400).json({ success: false, message: 'Invalid OTP' });
        }


        await OrderDetail.update(
            {
                order_status: 'In Progress',
                otp_status: 2,
                order_status_id: 4
            },
            {
                where: {
                    id: bookingId,
                    user_id: userId
                }
            }
        );

        const notification = await Notifications.findOne({
            where: { title: 'OtpVerified' }
        });

        if (!notification) {
            return res.status(404).json({
                success: false,
                message: 'Notification with title "OtpVerified" not found.'
            });
        }

        await UserNotification.create({
            user_id: userId,
            notification_id: notification.id
        });


        await OrderHistory.create({
            user_id: userId,
            order_id: bookingId,
            ride_id: rideId
        });


        return res.status(200).json({
            success: true,
            message: 'active Booking',
            data: booking
        });

    } catch (error) {
        console.error('OTP update error:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error',
            error: error.message
        });
    }
};


exports.getUserAllNotifications = async (req, res) => {
    try {
        const { userId } = req.body;

        if (!userId) {
            return res.status(400).json({
                success: false,
                message: 'userId is required.'
            });
        }

        const notifications = await UserNotification.findAll({
            where: { user_id: userId },
            include: [
                {
                    model: Notifications,
                    as: 'notifications',
                    attributes: ['title', 'description', 'created_at']
                }
            ],
            order: [['created_at', 'DESC']]
        });

        if (!notifications || notifications.length === 0) {
            return res.status(404).json({
                success: false,
                message: 'No notifications found.'
            });
        }

        const filteredData = notifications.map(n => ({
            user_id: n.user_id,
            user_otp: n.user_otp,
            title: n.notifications?.title || null,
            description: n.notifications?.description || null,
            notification_created_at: n.notifications?.created_at || null
        }));

        return res.status(200).json({
            success: true,
            message: 'User notifications retrieved successfully.',
            data: filteredData
        });

    } catch (error) {
        console.error('Error fetching user notifications:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error',
            error: error.message
        });
    }
};


exports.userCompletedOrderList = async (req, res) => {
    const { userId } = req.body;

    if (!userId) {
        return res.status(400).json({
            success: false,
            message: 'userId is required.'
        });
    }

    try {
        const bookingList = await OrderDetail.findAll({
            where: {
                user_id: userId,
                order_status_id: 5,
                deleted_flag: null,
                deleted_at: null
            },
            include: [
                {
                    model: user,
                    as: 'users'
                }
            ],
            raw: true,
            nest: true
        });

        if (!bookingList || bookingList.length === 0) {
            return res.status(404).json({
                success: false,
                message: 'No completed orders found.'
            });
        }
        const flattenedBookingList = bookingList.map(({ users, ...booking }) => ({
            ...booking,
            ...users
        }));

        return res.status(200).json({
            success: true,
            message: 'Ride marked as online. Booking list fetched.',
            data: flattenedBookingList
        });

    } catch (error) {
        console.error('Error fetching completed orders:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error while fetching completed orders.'
        });
    }
};

exports.findingNearByDriver = async (req, res) => {
    try {
        const { userLat, userLng } = req.body;

        if (!userLat || !userLng) {
            return res.status(400).json({
                success: false,
                message: 'User latitude and longitude are required.'
            });
        }

        const drivers = await Ride.findAll({
            where: {
                deleted_flag: null,
                deleted_at: null
            }
        });

        const getDistance = (lat1, lon1, lat2, lon2) => {
            const R = 6371; // Earth radius in km
            const dLat = (lat2 - lat1) * Math.PI / 180;
            const dLon = (lon2 - lon1) * Math.PI / 180;
            const a =
                Math.sin(dLat / 2) ** 2 +
                Math.cos(lat1 * Math.PI / 180) *
                Math.cos(lat2 * Math.PI / 180) *
                Math.sin(dLon / 2) ** 2;
            const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
            return R * c;
        };

        const nearbyDrivers = drivers
            .map(driver => {
                const distance = getDistance(
                    parseFloat(userLat),
                    parseFloat(userLng),
                    parseFloat(driver.latitude),
                    parseFloat(driver.longitude)
                );
                return {
                    id: driver.id,
                    fullname: `${driver.firstname} ${driver.lastname}`,
                    mobile: driver.mobile,
                    latitude: driver.latitude,
                    longitude: driver.longitude,
                    location: driver.location,
                    distance: `${distance.toFixed(2)} km`
                };
            })
            .filter(d => parseFloat(d.distance) <= 10) // within 10 km
            .sort((a, b) => parseFloat(a.distance) - parseFloat(b.distance))
            .slice(0, 5); // top 5 nearest

        return res.status(200).json({
            success: true,
            message: 'Nearby drivers found successfully.',
            drivers: nearbyDrivers
        });

    } catch (error) {
        console.error('Error finding nearby drivers:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error while finding nearby drivers.',
            error: error.message
        });
    }
};

exports.recentRides = async (req, res) => {
    try {
        const recentRides = await OrderHistory.findAll({
            where: {
                deleted_at: null
            },
            include: [
                {
                    model: OrderDetail,
                    required: false,
                    where: {
                        deleted_flag: null,
                        deleted_at: null
                    },
                    attributes: [
                        'pickup_location',
                        'drop_location',
                        'order_status',
                        'distance',
                        'amount',
                        'duration'
                    ]
                },
                {
                    model: user,
                    required: false,
                    where: {
                        deleted_at: null
                    },
                    attributes: ['firstname', 'lastname']
                },
                {
                    model: Ride,
                    required: false,
                    where: {
                        deleted_at: null
                    },
                    attributes: ['firstname', 'lastname']
                }
            ],
            raw: false,
            nest: true
        });

        const flattenedRides = recentRides.map(ride => ({
            id: ride.id,
            orderId: ride.order_id,
            rideId: ride.ride_id,
            userId: ride.user_id,
            createdAt: ride.created_at,
            updatedAt: ride.updated_at,
            pickupLocation: ride.order_booking?.pickup_location || null,
            dropLocation: ride.order_booking?.drop_location || null,
            orderStatus: ride.order_booking?.order_status || null,
            distance: ride.order_booking?.distance || null,
            amount: ride.order_booking?.amount || null,
            duration: ride.order_booking?.duration || null,
            userFirstname: ride.user?.firstname || null,
            userLastname: ride.user?.lastname || null,
            driverFirstname: ride.ride?.firstname || null,
            driverLastname: ride.ride?.lastname || null
        }));

        return res.status(200).json({
            success: true,
            message: 'Recent rides fetched successfully.',
            rides: flattenedRides
        });

    } catch (error) {
        console.error('Error fetching recent rides:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error while fetching recent rides.',
            error: error.message
        });
    }
};









// controller.js

// function getDistanceFromLatLonInKm(lat1, lon1, lat2, lon2) {
//   const R = 6371;
//   const dLat = deg2rad(lat2 - lat1);
//   const dLon = deg2rad(lon2 - lon1);
//   const a =
//     Math.sin(dLat / 2) * Math.sin(dLat / 2) +
//     Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) *
//     Math.sin(dLon / 2) * Math.sin(dLon / 2);
//   const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
//   return R * c;
// }

// function deg2rad(deg) {
//   return deg * (Math.PI / 180);
// }

// exports.googleMap = async (req, res) => {
//   const TVS_LAT = 10.793305408133959;
//   const TVS_LNG = 78.70139486118003;

//   const drivers = [
//     { name: 'BDU', lat: 10.778069880805056, lng: 78.69693924351914 },
//     { name: 'Railway', lat: 10.79529129742472, lng: 78.68677836388382 },
//     { name: 'Supuramaniyapuram', lat: 10.789335146182308, lng: 78.70896755217046 },
//     { name: 'Srirangam', lat: 10.864716175384418, lng: 78.68393559323708 },

//   ];

//   const nearbyDrivers = drivers.filter(driver => {
//     const distance = getDistanceFromLatLonInKm(TVS_LAT, TVS_LNG, driver.lat, driver.lng);
//     return distance <= 8;
//   });

//   res.json({ nearbyDrivers });
// };


function getDistanceFromLatLonInKm(lat1, lon1, lat2, lon2) {
    const R = 6371; // Radius of Earth in km
    const dLat = deg2rad(lat2 - lat1);
    const dLon = deg2rad(lon2 - lon1);
    const a =
        Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) *
        Math.sin(dLon / 2) * Math.sin(dLon / 2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    return R * c;
}

function deg2rad(deg) {
    return deg * (Math.PI / 180);
}

exports.googleMap = async (req, res) => {
    const TVS_LAT = 10.793305408133959;
    const TVS_LNG = 78.70139486118003;

    try {
        const drivers = await Ride.findAll({
            where: {
                deleted_flag: null,
                deleted_at: null
            }
        });

        const nearbyDrivers = drivers
            .filter(driver => {
                const lat = parseFloat(driver.latitude);
                const lng = parseFloat(driver.longitude);

                // Skip if lat/lng missing
                if (!lat || !lng) return false;

                const distance = getDistanceFromLatLonInKm(TVS_LAT, TVS_LNG, lat, lng);
                return distance <= 5;
            })
            .map(driver => ({
                id: driver.id,
                latitude: driver.latitude,
                longitude: driver.longitude,
                location: driver.location
            }));

        res.json({ nearbyDrivers });

    } catch (error) {
        console.error('Error fetching drivers:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};





