const user = require('../../models/User');
const UserDetails = require('../../models/UserDetails');
const UserLocation = require('../../models/UserLocation');
const OrderDetail = require('../../models/OrderBookings');
const Suggestion = require('../../models/Suggestion');
const UserRideType = require('../../models/UserRideType');
const PickupType = require('../../models/PickupType');
const bcrypt = require('bcrypt');
const moment = require('moment');
const Favourite = require('../../models/Favourite');
const jwt = require('jsonwebtoken');
const { Op } = require('sequelize');
const { v4: uuidv4 } = require('uuid');
const PricingRules = require('../../models/PricingRules');
const JWT_SECRET = process.env.JWT_SECRET;

exports.userSignUp = async (req, res) => {
    const { mobile, email, password, firstname, lastname, gender, dob, city, user_status } = req.body;
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

        const saltRounds = 10;
        const hashedPassword = await bcrypt.hash(password, saltRounds);
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
            user_status: user_status || "active",
        });

        return res.status(201).json({
            success: true,
            message: 'User record created successfully.',
            data: newUser
        });

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

        if (!foundUsers || foundUsers.length === 0) {
            return res.status(404).json({ success: false, message: 'No users found or all marked as deleted.' });
        }

        return res.status(200).json({ success: true, users: foundUsers });
    } catch (error) {
        console.error('Error fetching user details:', error);
        return res.status(500).json({ success: false, message: 'Server error', error: error.message });
    }
};
exports.totalUsers = async (req, res) => {
   
    try {
        const totalUsers = await OrderDetail.count({
            where: {
               
                deleted_flag: null,
                deleted_at: null
            }
        });

        return res.status(200).json({ success: true, totalUsers });
    } catch (error) {
        console.error('Error fetching user count:', error);
        return res.status(500).json({ success: false, message: 'Server error', error: error.message });
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
            rating ,
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
                deleted_flag: null,
                deleted_at: null
            }
        });

        if (!existingUser) {
            return res.status(404).json({
                success: false,
                message: 'User not found or has been deleted.',
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
                user_uid : existingUser.user_uid
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
      duration,
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
      duration,
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
  
    try {

      const priceCalculator = await PricingRules.findOne({
        order: [['id', 'ASC']]
      });
  
      if (!priceCalculator || !priceCalculator.price_per_km) {
        return res.status(500).json({
          success: false,
          message: 'Pricing rules not found or invalid.'
        });
      }
      const amount = parseFloat((priceCalculator.price_per_km * distance).toFixed(2));
      const newOrder = await OrderDetail.create({
        user_uid,
        user_id,
        pickup_type_id,
        user_ride_type_id,
        amount,
        distance,
        duration,
        pickup_latitude,
        pickup_longitude,
        drop_latitude,
        drop_longitude,
        pickup_start_datetime,
        pickup_location,
        drop_location,
        suggestion_id,
        order_status: order_status || "In Progress",

      });
  
      return res.status(201).json({
        success: true,
        message: 'Order details stored successfully.',
        data: newOrder
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


exports.userRideHistory = async (req, res) => {
    const { user_id } = req.body;

    if (!user_id) {
        return res.status(400).json({
            success: false,
            message: `user_id is required.`
        });
    }

    try {
        const today = new Date();

        const newOrder = await OrderDetail.findAll({
            where: {
                user_id: user_id,
                pickup_start_datetime: {
                    [Op.lt]: today
                }
            }
        });

        return res.status(200).json({
            success: true,
            message: 'Ride history fetched successfully.',
            data: newOrder
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
