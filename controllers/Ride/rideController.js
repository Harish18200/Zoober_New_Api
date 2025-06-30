const Ride = require('../../models/Ride');
const User = require('../../models/User');
const RideDetails = require('../../models/RideDetails');
const Vehicle = require('../../models/Vehicle');
const Document = require('../../models/Document');
const OrderBooking = require('../../models/OrderBookings');
const UserReview = require('../../models/UserReview');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { Op, fn, col, literal } = require('sequelize');
const { user } = require('../..');
const Suggestion = require('../../models/Suggestion');
const RiderNotification = require('../../models/RiderNotification');
const Notifications = require('../../models/Notifications');
const axios = require('axios');
const FormData = require('form-data');
const OrderHistory = require('../../models/OrderHistory');
const moment = require('moment');






const JWT_SECRET = process.env.JWT_SECRET || 'ZooberRide';
exports.rideSignUp = async (req, res) => {
    const { firstname, lastname, email, mobile, gender, dob, password, status, latitude, longitude, location, ride_status } = req.body;
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
        return res.status(400).json({ success: false, message: 'Firstname is required.' });
    }

    try {
        const hashedPassword = await bcrypt.hash(password, 10);
        const ride_uid_set = new Set();

        const generateUniqueValue = () => {
            let value;
            do {
                value = Math.floor(Math.random() * 90000) + 10000;
            } while (ride_uid_set.has(value));
            ride_uid_set.add(value);
            return value;
        };

        const uniqueRideUid = generateUniqueValue();

        const createRide = await Ride.create({
            firstname,
            ride_uid: uniqueRideUid,
            lastname,
            email,
            mobile,
            gender,
            dob,
            password: hashedPassword,
            profile: req.file ? req.file.filename : null,
            status,
            latitude,
            longitude,
            location,
            ride_status: ride_status || "Pending Approval",
            ride_order_status_id: 1
        });

        res.status(200).json({
            success: true,
            message: 'Ride record created successfully.',
            data: createRide
        });

    } catch (error) {
        console.error('Error during signup:', error);
        res.status(500).json({
            success: false,
            message: 'Server error during signup'
        });
    }
};
exports.addOrUpdateRideDetails = async (req, res) => {
    const { rideId, ride_uid, total_ride, total_hours, total_kilometer, rating, earning } = req.body;

    if (!rideId) {
        return res.status(400).json({ success: false, message: 'RideId is required.' });
    }

    try {

        const existingRide = await RideDetails.findOne({ where: { id: rideId } });

        let rideDetails;
        if (existingRide) {
            await RideDetails.update(
                {
                    ride_uid,
                    total_ride,
                    total_hours,
                    total_kilometer,
                    rating,
                    earning
                },
                { where: { id: rideId } }
            );

            rideDetails = await RideDetails.findOne({ where: { id: rideId } });

            return res.status(200).json({
                success: true,
                message: 'Ride details updated successfully.',
                rideDetails
            });
        } else {
            rideDetails = await RideDetails.create({
                rideId,
                ride_uid,
                total_ride,
                total_hours,
                total_kilometer,
                rating,
                earning
            });

            return res.status(200).json({
                success: true,
                message: 'Ride details added successfully.',
                rideDetails
            });
        }
    } catch (error) {
        console.error('Add/Update Ride Details error:', error);
        return res.status(500).json({ success: false, message: 'Server error' });
    }
};
exports.markRiderStatus = async (req, res) => {
    const { rideId, ride_status } = req.body;

    if (!rideId) {
        return res.status(400).json({ success: false, message: 'RideId is required.' });
    }

    try {
        const existingRide = await Ride.findOne({ where: { id: rideId } });

        if (!existingRide) {
            return res.status(404).json({ success: false, message: 'Ride not found.' });
        }

        if (ride_status === "offline") {
            const rideRecord = await Ride.findOne({
                where: { id: rideId },
                attributes: ['working_hour']
            });

            const offlineTime = new Date();
            const workingHour = new Date(rideRecord.working_hour);
            const totalMilliseconds = offlineTime - workingHour;
            const addedMinutes = Math.floor(totalMilliseconds / (1000 * 60));

            const rideDetail = await RideDetails.findOne({ where: { ride_id: rideId } });

            let existingHours = 0;
            let existingMinutes = 0;

            if (rideDetail && rideDetail.total_hours) {
                const [hours, minutes] = rideDetail.total_hours.split(':').map(Number);
                existingHours = hours || 0;
                existingMinutes = minutes || 0;
            }

            const totalExistingMinutes = existingHours * 60 + existingMinutes;
            const totalMinutes = totalExistingMinutes + addedMinutes;

            const finalHours = Math.floor(totalMinutes / 60);
            const finalMinutes = totalMinutes % 60;
            const formattedTime = `${String(finalHours).padStart(2, '0')}:${String(finalMinutes).padStart(2, '0')}`;

            await Ride.update({ status: ride_status }, { where: { id: rideId } });


            if (rideDetail) {
                await RideDetails.update(
                    { total_hours: formattedTime },
                    { where: { ride_id: rideId } }
                );
            } else {
                await RideDetails.create({
                    ride_id: rideId,
                    total_hours: formattedTime
                });
            }

            return res.status(200).json({
                success: true,
                message: `Ride marked as offline. ${finalHours} hour(s) ${finalMinutes} minute(s) added.`,
                duration: { hours: finalHours, minutes: finalMinutes }
            });
        }

        if (ride_status === "online") {
            await Ride.update(
                {
                    status: ride_status,
                    working_hour: new Date()
                },
                { where: { id: rideId } }
            );

            const bookingList = await OrderBooking.findAll({
                where: {
                    order_status_id: 2,
                    deleted_flag: null,
                    deleted_at: null
                },
                include: [
                    {
                        model: User,
                        as: 'users',
                        attributes: [
                            'firstname',
                            'lastname',
                            'mobile',
                            'profile',
                            'email',
                            'gender',
                            'dob',
                            'user_status'
                        ]
                    }
                ],
                raw: true,
                nest: true
            });

            const filteredOrders = bookingList.map(order => ({
                order_id: order.id,
                user_id: order.user_id,
                distance: order.distance,
                pickup_latitude: order.pickup_latitude,
                pickup_longitude: order.pickup_longitude,
                pickup_location: order.pickup_location,
                drop_location: order.drop_location,
                drop_latitude: order.drop_latitude,
                drop_longitude: order.drop_longitude,
                amount: order.amount,
                duration: order.duration,
                order_status_id: order.order_status_id,
                suggestion_id: order.suggestion_id,
                firstname: order.users.firstname,
                lastname: order.users.lastname,
                mobile: order.users.mobile,
                profile: order.users.profile,
                email: order.users.email,
                gender: order.users.gender,
                dob: order.users.dob,
                user_status: order.users.user_status
            }));

            return res.status(200).json({
                success: true,
                data: filteredOrders
            });

            return res.status(200).json({
                success: true,
                message: 'Ride marked as online. Booking list fetched.',
                data: bookingList
            });
        }

        return res.status(200).json({
            success: true,
            message: `Ride status updated to "${ride_status}".`
        });

    } catch (error) {
        console.error('Error updating ride status:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error',
            error: error.message
        });
    }
};
const fetchTotalActiveRides = async () => {
    return await Ride.findAll({
        where: {
            deleted_flag: null,
            deleted_at: null,
            status: "online"
        }
    });
};
exports.totalOnlineRide = async (req, res) => {
    try {
        const totalUsers = await Ride.findAll({
            where: {
                deleted_flag: null,
                deleted_at: null,
                status: "online"
            }
        });
        return res.status(200).json({ success: true, totalUsers });
    } catch (error) {
        console.error('Error fetching user count:', error);
        return res.status(500).json({ success: false, message: 'Server error', error: error.message });
    }
};
exports.totalActiveDrivers = async (req, res) => {
    try {
        const totalDriverCount = await Ride.count({
            where: {
                deleted_flag: null,
                deleted_at: null,
                status: "online"
            }
        });

        return res.status(200).json({ success: true, totalDriverCount });
    } catch (error) {
        console.error('Error fetching driver count:', error);
        return res.status(500).json({ success: false, message: 'Server error', error: error.message });
    }
};
exports.todayTotalRides = async (req, res) => {
    try {
        const today = new Date();
        const startOfDay = new Date(today.setHours(0, 0, 0, 0));
        const endOfDay = new Date(today.setHours(23, 59, 59, 999));

        const rideCount = await OrderBooking.count({
            where: {
                deleted_flag: null,
                deleted_at: null,
                order_status_id: 4,
                ride_start_date: {
                    [Op.between]: [startOfDay, endOfDay]
                }
            },
        });

        return res.status(200).json({ success: true, count: rideCount });
    } catch (error) {
        console.error("Error fetching today's ride count:", error);
        return res.status(500).json({
            success: false,
            message: 'Server error',
            error: error.message,
        });
    }
};
exports.todayRevenue = async (req, res) => {
    try {
        const today = new Date();
        const startOfDay = new Date(today.setHours(0, 0, 0, 0));
        const endOfDay = new Date(today.setHours(23, 59, 59, 999));


        const todayRevenue = await OrderBooking.sum('amount', {
            where: {
                deleted_flag: null,
                deleted_at: null,
                order_status_id: 5,
                ride_start_date: {
                    [Op.between]: [startOfDay, endOfDay]
                }
            }
        });

        return res.status(200).json({ success: true, todayRevenue: todayRevenue || 0 });
    } catch (error) {
        console.error('Error fetching today\'s revenue:', error);
        return res.status(500).json({ success: false, message: 'Server error', error: error.message });
    }
};
exports.totalRidesDetails = async (req, res) => {
    try {
        const allOrders = await OrderBooking.findAll({
            where: {
                deleted_flag: null,
                deleted_at: null
            },
            // include: [
            //   {
            //     model: user,
            //     required: false,
            //     where: {
            //       deleted_flag: null,
            //       deleted_at: null
            //     }
            //   }
            // ]
        });

        return res.status(200).json({
            success: true,
            message: 'All order details fetched successfully.',
            data: allOrders
        });
    } catch (error) {
        console.error('Error fetching order details:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error',
            error: error.message
        });
    }
};
exports.rideLogin = async (req, res) => {
    const { mobile, password } = req.body;
    const mobileRegex = /^\d{10}$/;

    if (!mobile || !mobileRegex.test(mobile)) {
        return res.status(400).json({ success: false, message: 'Mobile number must be 10 digits.' });
    }
    if (!password || password.length < 6) {
        return res.status(400).json({ success: false, message: 'Password is required and must be at least 6 characters.' });
    }

    try {
        const rideLogin = await Ride.findOne({
            where: { mobile }
        });

        if (!rideLogin) {
            return res.status(401).json({ success: false, message: 'Mobile number not found.' });
        }

        const isMatch = await bcrypt.compare(password, rideLogin.password);
        if (!isMatch) {
            return res.status(401).json({ success: false, message: 'Invalid mobile number or password.' });
        }

        const token = jwt.sign(
            { id: rideLogin.id, mobile: rideLogin.mobile },
            JWT_SECRET,
            { expiresIn: '1d' }
        );

        const rideDetails = await RideDetails.findOne({ where: { ride_id: rideLogin.id } });

        return res.status(200).json({
            success: true,
            message: 'Login successful',
            token,
            user: {
                id: rideLogin.id,
                mobile: rideLogin.mobile,
                fullname: `${rideLogin.firstname} ${rideLogin.lastname}`,
                profile: rideLogin.profile
                    ? `http://192.168.1.63:3000/upload/images/${rideLogin.profile}`
                    : null,
                totalRide: rideDetails?.total_ride || 0,
                totalEarning: rideDetails?.earning || 0,
                totalKilometer: rideDetails?.total_kilometer || 0,
                totalHours: rideDetails?.total_hours || "00:00"
            }
        });

    } catch (error) {
        console.error('Login error:', error);
        return res.status(500).json({ success: false, message: 'Server error' });
    }
};

exports.rideDashboard = async (req, res) => {
    const { rideId } = req.body;

    if (!rideId) {
        return res.status(400).json({ success: false, message: 'rideId is required.' });
    }

    try {
        const rideLogin = await Ride.findOne({
            where: { id: rideId }
        });

        if (!rideLogin) {
            return res.status(404).json({ success: false, message: 'Ride not found.' });
        }

        const rideDetails = await RideDetails.findOne({ where: { ride_id: rideLogin.id } });

        return res.status(200).json({
            success: true,
            message: 'Ride dashboard fetched successfully',
            user: {
                id: rideLogin.id,
                mobile: rideLogin.mobile,
                fullname: `${rideLogin.firstname || ''} ${rideLogin.lastname || ''}`.trim(),
                profile: rideLogin.profile
                    ? `http://192.168.1.63:3000/upload/images/${rideLogin.profile}`
                    : null,
                totalRide: rideDetails?.total_ride || null,
                totalEarning: rideDetails?.earning || null,
                totalKilometer: rideDetails?.total_kilometer || null,
                totalHours: rideDetails?.total_hours || "00:00"
            }
        });

    } catch (error) {
        console.error('Ride dashboard error:', error);
        return res.status(500).json({ success: false, message: 'Server error' });
    }
};

exports.addVehicle = async (req, res) => {
    const { ride_id, brand, model, model_year, license_plate, color, booking_type } = req.body;

    if (!ride_id || !brand || !model || !model_year || !license_plate || !booking_type) {
        return res.status(400).json({
            success: false,
            message: 'rideId, brand, model, model_year, license_plate, and booking_type are required.'
        });
    }

    try {
        const existingVehicle = await Vehicle.findOne({
            where: {
                ride_id,
                status: 1
            }
        });
        const status = existingVehicle ? null : 1;

        const newVehicle = new Vehicle({
            ride_id,
            brand,
            model,
            model_year,
            license_plate,
            color,
            booking_type,
            status
        });

        const savedVehicle = await newVehicle.save();

        return res.status(201).json({
            success: true,
            message: 'Vehicle added successfully',
            data: savedVehicle
        });

    } catch (error) {
        console.error('Error adding vehicle:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error while adding vehicle'
        });
    }
};
exports.activeVehicle = async (req, res) => {
    const { ride_id, id } = req.body;

    if (!ride_id || !id) {
        return res.status(400).json({
            success: false,
            message: 'rideId and id are required.'
        });
    }
    try {
        await Vehicle.update(
            { status: null },
            {
                where: {
                    ride_id: ride_id,
                    status: 1
                }
            }
        );
        const [updatedRows] = await Vehicle.update(
            { status: 1 },
            {
                where: {
                    ride_id: ride_id,
                    id: id
                }
            }
        );

        if (updatedRows === 0) {
            return res.status(404).json({
                success: false,
                message: 'Vehicle not found or not updated.'
            });
        }

        return res.status(200).json({
            success: true,
            message: 'Vehicle activated successfully.'
        });

    } catch (error) {
        console.error('Error activating vehicle:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error while activating vehicle.'
        });
    }
};
exports.rideVehicleList = async (req, res) => {
    const { ride_id } = req.body;

    if (!ride_id) {
        return res.status(400).json({
            success: false,
            message: 'ride_id is required.'
        });
    }

    try {
        const vehicleList = await Vehicle.findAll({
            where: { ride_id: ride_id }
        });

        return res.status(200).json({
            success: true,
            message: 'Vehicle list retrieved successfully',
            data: vehicleList
        });

    } catch (error) {
        console.error('Error fetching vehicle list:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error while fetching vehicle list'
        });
    }
};
exports.addDocument = async (req, res) => {

    const ride_id = req.body.ride_id;
    const card_number = req.body.card_number;
    const expired_date = req.body.expired_date;
    const name = req.body.name;

    if (!ride_id || !card_number) {
        return res.status(400).json({
            success: false,
            message: 'ride_id and card_number are required.'
        });
    }

    try {
        console.log('Uploaded file:', req.file);
        const documentData = {
            ride_id,
            card_number,
            expired_date,
            name,
            photo: req.file ? req.file.filename : null
        };
        const newDocument = new Document(documentData);
        const savedDocument = await newDocument.save();

        return res.status(201).json({
            success: true,
            message: 'Document added successfully',
            data: savedDocument
        });

    } catch (error) {
        console.error('Error adding document:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error while adding document'
        });
    }
};
exports.listDocument = async (req, res) => {
    const { ride_id } = req.body;

    if (!ride_id) {
        return res.status(400).json({
            success: false,
            message: 'ride_id is required.'
        });
    }

    try {
        const fetchDocument = await Document.findAll({
            where: {
                ride_id: ride_id,
                deleted_at: null
            }
        });

        const baseUrl = "https://zoober.ackrock.com/upload/documents/";

        const updatedDocuments = fetchDocument.map(doc => {
            return {
                ...doc.dataValues,
                photo: doc.photo ? baseUrl + doc.photo : baseUrl
            };
        });

        return res.status(200).json({
            success: true,
            message: 'Documents fetched successfully',
            data: updatedDocuments
        });

    } catch (error) {
        console.error('Error fetching documents:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error while fetching documents'
        });
    }
};
exports.getOrderDetailById = async (req, res) => {
    const { id } = req.body;
    if (!id) {
        return res.status(400).json({
            success: false,
            message: 'id is required.'
        });
    }
    try {
        const orderDetail = await OrderBooking.findOne({
            where: { id }
        });
        if (!orderDetail) {
            return res.status(404).json({
                success: false,
                message: 'Order detail not found.'
            });
        }
        return res.status(200).json({
            success: true,
            message: 'Order detail retrieved successfully',
            data: orderDetail
        });

    } catch (error) {
        console.error('Error fetching order detail:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error while fetching order detail'
        });
    }
};
exports.completedBookingRide = async (req, res) => {
    const { orderId, rideId } = req.body;
    if (!orderId) {
        return res.status(400).json({
            success: false,
            message: 'orderId is required.'
        });
    }
    if (!rideId) {
        return res.status(400).json({
            success: false,
            message: 'RideId is required.'
        });
    }
    try {
        const orderDetail = await OrderBooking.findOne({
            where: {
                id: orderId,
                order_status_id: 5,
                deleted_at: null,
                deleted_flag: null
            }
        });
        if (!orderDetail) {
            return res.status(404).json({
                success: false,
                message: 'Order detail not found or not completed yet.'
            });
        }

        const rideDetails = await RideDetails.findOne({
            where: { ride_id: rideId }
        });

        const distance = parseFloat(orderDetail.distance || 0);
        const amount = parseFloat(orderDetail.amount || 0);

        if (rideDetails) {
            const updatedRideCount = (parseFloat(rideDetails.total_ride) || 0) + 1;
            const updatedDistance = (parseFloat(rideDetails.total_kilometer) || 0) + distance;
            const updatedEarnings = (parseFloat(rideDetails.earning) || 0) + amount;

            await RideDetails.update(
                {
                    total_ride: updatedRideCount,
                    total_kilometer: updatedDistance,
                    earning: updatedEarnings
                },
                {
                    where: { ride_id: rideId }
                }
            );
        } else {
            await RideDetails.create({
                ride_id: rideId,
                total_ride: 1,
                total_kilometer: distance,
                earning: amount
            });
        }

        return res.status(200).json({
            success: true,
            message: 'Ride summary updated successfully.'
        });

    } catch (error) {
        console.error('Error completing booking ride:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error while completing booking ride.'
        });
    }
};

const createUserReview = async ({ orderId, userId, riderId }) => {
    if (!orderId || !userId || !riderId) {
        throw new Error(`${!orderId ? 'orderId' : !userId ? 'userId' : 'riderId'} is required.`);
    }

    const newReview = await UserReview.create({
        order_id: orderId,
        user_id: userId,
        rider_id: riderId,
        review_type_status: 1,
    });

    return newReview;
};



exports.OrderCompletedChangeStatus = async (req, res) => {
    const { orderId, userId, riderId } = req.body;

    if (!orderId || !userId || !riderId) {
        return res.status(400).json({
            success: false,
            message: `${!orderId ? 'orderId' : !userId ? 'userId' : 'riderId'} is required.`,
        });
    }

    try {
        const [updatedRows] = await OrderBooking.update(
            {
                cash_type_status: 1,
                order_status_id: 5,
                order_status: "Completed"
            },
            {
                where: {
                    id: orderId,
                    user_id: userId,
                    deleted_at: null,
                    deleted_flag: null
                }
            }
        );

        if (updatedRows === 0) {
            return res.status(404).json({
                success: false,
                message: 'Order detail not found or not updated.'
            });
        }

        const newReview = await createUserReview({ orderId, userId, riderId });

        const notification = await Notifications.findOne({
            where: { title: "RideCompleted" }
        });

        if (!notification) {
            return res.status(404).json({ success: false, message: "Notification not found" });
        }

        const riderNotify = await RiderNotification.create({
            rider_id: riderId,
            notification_id: notification.id,

        });

        return res.status(200).json({
            success: true,
            message: 'Order marked as completed and review submitted.',
            review: newReview
        });

    } catch (error) {
        console.error('Error completing booking ride:', error.message);
        return res.status(500).json({
            success: false,
            message: error.message || 'Server error while completing booking ride.'
        });
    }
};

exports.retreiveAmountByUserId = async (req, res) => {
    const { orderId, userId } = req.body;

    if (!orderId) {
        return res.status(400).json({
            success: false,
            message: 'orderId is required.'
        });
    }

    if (!userId) {
        return res.status(400).json({
            success: false,
            message: 'userId is required.'
        });
    }

    try {
        const userAmount = await OrderBooking.findOne({
            where: {
                id: orderId,
                user_id: userId,
                deleted_at: null,
                deleted_flag: null
            }
        });

        if (!userAmount) {
            return res.status(404).json({
                success: false,
                message: 'Order not found for the provided user.'
            });
        }

        const userDetails = await fetchUserDetails(userId);

        return res.status(200).json({
            success: true,
            message: 'Amount retrieved successfully.',
            userData: {
                userId: userDetails.id,
                firstname: userDetails.firstname,
                lastname: userDetails.lastname,
                mobile: userDetails.mobile,
                amount: userAmount.amount
            }
        });


    } catch (error) {
        console.error('Error retrieving amount:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error while retrieving amount.',
            error: error.message
        });
    }
};
const fetchUserDetails = async (userId) => {
    if (!userId) throw new Error('userId is required');

    const userDetails = await User.findOne({
        where: {
            id: userId,
            deleted_at: null,
            deleted_flag: null
        }
    });

    return userDetails;
};



exports.getAllDrivers = async (req, res) => {
    try {
        const foundDrivers = await Ride.findAll({
            where: {
                deleted_flag: null,
                deleted_at: null
            },
            attributes: [
                ['id', 'rideId'],
                'firstname',
                'lastname',
                'email',
                'mobile',
                ['ride_status', 'rideStatus'],
                ['created_at', 'createdAt']
            ],
            include: [
                {
                    model: RideDetails,
                    required: false,
                    where: {
                        deleted_flag: null,
                        deleted_at: null
                    },
                    attributes: ['rating', 'earning', ['total_ride', 'totalRides']]
                },
                {
                    model: Vehicle,
                    required: false,
                    where: {

                        deleted_at: null,
                        status: 1
                    },
                    attributes: ['brand', 'model', 'model_year', 'license_plate']
                }
            ],
            raw: true,
            nest: true
        });

        const flattenedDrivers = foundDrivers.map(driver => ({
            rideId: driver.rideId,
            firstname: driver.firstname,
            lastname: driver.lastname,
            email: driver.email,
            mobile: driver.mobile,
            rideStatus: driver.rideStatus,
            createdAt: driver.createdAt,
            rating: driver.ride_detail?.rating || null,
            earning: driver.ride_detail?.earning || null,
            totalRides: driver.ride_detail?.totalRides || 0,
            vehicleBrand: driver.vehicle?.brand || null,
            vehicleModel: driver.vehicle?.model || null,
            vehicleModelYear: driver.vehicle?.model_year || null,
            licensePlace: driver.vehicle?.license_place || null
        }));

        if (flattenedDrivers.length === 0) {
            return res.status(404).json({ success: false, message: 'No drivers found or all marked as deleted.' });
        }

        return res.status(200).json({ success: true, drivers: flattenedDrivers });
    } catch (error) {
        console.error('Error fetching driver details:', error);
        return res.status(500).json({ success: false, message: 'Server error', error: error.message });
    }
};

exports.driverApproval = async (req, res) => {
    const { rideId, rideStatusId, rideStatus } = req.body;
    try {
        const updatedRide = await Ride.update(
            {
                ride_status: rideStatus || "Approval",
                ride_status_id: rideStatusId || 2
            },
            {
                where: {
                    deleted_flag: null,
                    deleted_at: null,
                    id: rideId
                }
            }
        );

        if (updatedRide[0] === 0) {
            return res.status(404).json({ success: false, message: 'Ride not found or no changes made' });
        }

        return res.status(200).json({ success: true, message: 'Ride status updated successfully' });

    } catch (error) {
        console.error('Error updating ride status:', error);
        return res.status(500).json({ success: false, message: 'Server error', error: error.message });
    }
};
exports.driverPendingApproval = async (req, res) => {
    try {
        const pendingRides = await Ride.findAll({
            where: {
                deleted_flag: null,
                deleted_at: null,
                ride_status_id: 1
            }
        });

        if (pendingRides.length === 0) {
            return res.status(404).json({ success: false, message: 'No pending approval rides found' });
        }

        return res.status(200).json({ success: true, rides: pendingRides });
    } catch (error) {
        console.error('Error fetching pending rides:', error);
        return res.status(500).json({ success: false, message: 'Server error', error: error.message });
    }
};

exports.driverListByStatus = async (req, res) => {
    const { rideStatusId } = req.body;
    try {
        const whereCondition = {
            deleted_flag: null,
            deleted_at: null,
        };
        if (rideStatusId) {
            whereCondition.ride_status_id = rideStatusId;
        }

        const rides = await Ride.findAll({
            where: whereCondition
        });

        if (rides.length === 0) {
            return res.status(404).json({ success: false, message: 'No rides found' });
        }

        return res.status(200).json({ success: true, rides });
    } catch (error) {
        console.error('Error fetching rides by status:', error);
        return res.status(500).json({ success: false, message: 'Server error', error: error.message });
    }
};

exports.driverSentWhatsappOtp = async (req, res) => {


    const mobile = req.body.mobile;

    if (!mobile || mobile.length < 10) {
        return res.status(400).json({ success: false, message: "Mobile number must be at least 10 digits" });
    }

    try {
        const checkDriverMobile = await Ride.findOne({
            where: { mobile: mobile }
        });

        if (checkDriverMobile) {
            const randomOtp = Math.floor(1000 + Math.random() * 9000);
            const notification = await Notifications.findOne({
                where: { title: "OTPLogin" }
            });

            if (!notification) {
                return res.status(404).json({ success: false, message: "Notification not found" });
            }

            const otpUpdate = await RiderNotification.create({
                rider_id: checkDriverMobile.id,
                notification_id: notification.id,
                rider_otp: randomOtp
            });

            const url = "https://wtservices.ackrock.com/api/send/whatsapp";
            const secretKey = "f3b630127a407ae9dba5206ad454dd2d88ecaae7";
            const account = '1749049350aab3238922bcc25a6f606eb525ffdc566840600606b57';
            const recipient = "+91" + checkDriverMobile.mobile;
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

                return res.status(200).json({ success: true, message: "OTP sent", otp: randomOtp, rideId: otpUpdate.rider_id, id: otpUpdate.id });

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

exports.driverWhatsappOtpValidate = async (req, res) => {
    const { id, rideId, otp } = req.body;

    if (!id || !rideId || !otp) {
        return res.status(400).json({ success: false, message: "All fields (id, rideId, otp) are required" });
    }

    try {
        const getOtp = await RiderNotification.findOne({
            where: {
                id: id,
                rider_id: rideId
            }
        });

        if (!getOtp) {
            return res.status(404).json({ success: false, message: "Rider notification not found" });
        }

        if (getOtp.rider_otp === otp) {

            const ridedata = await Ride.findOne({ where: { id: rideId } });
            const token = jwt.sign(
                { id: ridedata.id, mobile: ridedata.mobile },
                JWT_SECRET,
                { expiresIn: '1d' }
            );

            const rideDetails = await RideDetails.findOne({ where: { ride_id: ridedata.id } });

            return res.status(200).json({
                success: true,
                message: 'Login successful',
                token,
                user: {
                    id: ridedata.id,
                    mobile: ridedata.mobile,
                    fullname: `${ridedata.firstname} ${ridedata.lastname}`,
                    profile: ridedata.profile
                        ? `http://192.168.1.63:3000/upload/images/${ridedata.profile}`
                        : null,
                    totalRide: rideDetails?.total_ride || 0,
                    totalEarning: rideDetails?.earning || 0,
                    totalKilometer: rideDetails?.total_kilometer || 0,
                    totalHours: rideDetails?.total_hours || "00:00"
                }
            });



        } else {
            return res.status(401).json({ success: false, message: "Invalid OTP" });
        }

    } catch (error) {
        console.error("Error:", error);
        return res.status(500).json({ success: false, message: "Internal Server Error", error: error.message });
    }
};


exports.getRiderAllNotifications = async (req, res) => {
    try {
        const { rideId } = req.body;

        if (!rideId) {
            return res.status(400).json({
                success: false,
                message: 'rideId is required.'
            });
        }

        const notifications = await RiderNotification.findAll({
            where: { rider_id: rideId },
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
            user_id: n.rider_id,
            user_otp: n.rider_otp,
            title: n.notifications?.title || null,
            description: n.notifications?.description || null,
            notification_created_at: n.notifications?.created_at || null
        }));

        return res.status(200).json({
            success: true,
            message: 'Rider notifications retrieved successfully.',
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
exports.driverDatewiseHistory = async (req, res) => {
    try {
        const { rideId, date } = req.body;

        if (!rideId || !date) {
            return res.status(400).json({
                success: false,
                message: 'rideId and date are required.'
            });
        }

        const startOfDay = moment(date).startOf('day').toDate();
        const endOfDay = moment(date).endOf('day').toDate();

        // Step 1: Fetch all OrderHistory entries for this ride and date
        const orderHistories = await OrderHistory.findAll({
            where: {
                ride_id: rideId,
                started_date: {
                    [Op.between]: [startOfDay, endOfDay]
                }
            }
        });

        const filteredHistories = [];
        let totalAmount = 0;

        // Step 2: Loop through and filter based on OrderBooking
        for (const history of orderHistories) {
            const booking = await OrderBooking.findOne({
                where: {
                    id: history.order_id,
                    order_status_id: 5
                }
            });

            if (booking) {
                filteredHistories.push(booking);
                totalAmount += parseFloat(booking.amount || 0);
            }
        }

        return res.status(200).json({
            success: true,
            message: 'Filtered rider history retrieved successfully.',
            total_count: filteredHistories.length,
            total_amount: totalAmount,

        });

    } catch (error) {
        console.error('Error fetching rider history:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error',
            error: error.message
        });
    }
};




exports.fetchTotalActiveRides = fetchTotalActiveRides;