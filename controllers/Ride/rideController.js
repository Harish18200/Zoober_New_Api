const Ride = require('../../models/Ride');
const RideDetails = require('../../models/RideDetails');
const Vehicle = require('../../models/Vehicle');
const Document = require('../../models/Document');
const OrderBooking = require('../../models/OrderBookings');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { Op } = require('sequelize');
const { user } = require('../..');


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
            ride_status: ride_status || "Pending Approval"
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

exports.updateRideStatusByRideId = async (req, res) => {
    const { rideId, ride_status } = req.body;

    if (!rideId) {
        return res.status(400).json({ success: false, message: 'RideId is required.' });
    }

    try {

        const existingRide = await Ride.findOne({ where: { id: rideId } });

       
        if (existingRide) {
            await Ride.update(
                {
                  ride_status
                },
                { where: { id: rideId } }
            );

          
        }
    } catch (error) {
        console.error('Add/Update Ride Details error:', error);
        return res.status(500).json({ success: false, message: 'Server error' });
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

exports.totalActiveRide = async (req, res) => {
    try {
        const totalUsers = await fetchTotalActiveRides();
        return res.status(200).json({ success: true, totalUsers });
    } catch (error) {
        console.error('Error fetching user count:', error);
        return res.status(500).json({ success: false, message: 'Server error', error: error.message });
    }
};

exports.todayTotalRides = async (req, res) => {
    try {
        const today = new Date();
        console.log('today', today);

        const startOfDay = new Date(today.setHours(0, 0, 0, 0));
        const endOfDay = new Date(today.setHours(23, 59, 59, 999));
        console.log('startOfDay', startOfDay);
        console.log('endOfDay', endOfDay);
        const todayTotalRides = await OrderBooking.count({
            where: {
                deleted_flag: null,
                deleted_at: null,
                created_at: {
                    [Op.lte]: endOfDay
                  }
            }
        });

        return res.status(200).json({ success: true, todayTotalRides });
    } catch (error) {
        console.error('Error fetching today\'s rides:', error);
        return res.status(500).json({ success: false, message: 'Server error', error: error.message });
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
                created_at: {
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

        return res.status(200).json({
            success: true,
            message: 'Login successful',
            token,
            user: {
                id: rideLogin.id,
                mobile: rideLogin.mobile,
                firstname: rideLogin.firstname,
                profile: `http://192.168.1.63:3000/upload/images/${rideLogin.profile}`
            }
        });

    } catch (error) {
        console.error('Login error:', error);
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
exports.fetchTotalActiveRides = fetchTotalActiveRides;