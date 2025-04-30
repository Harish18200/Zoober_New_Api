const Ride = require('../../models/Ride');
const Vehicle = require('../../models/Vehicle');
const Document = require('../../models/Document');
const OrderDetail = require('../../models/OrderDetail');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { Op } = require('sequelize');


const JWT_SECRET = process.env.JWT_SECRET || 'ZooberRide';
exports.rideSignUp = async (req, res) => {
    const { mobile, email, password, firstname ,lastname ,gender,dob } = req.body;
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!email || !emailRegex.test(email)) {
        return res.status(400).json({ success: false, message: 'Invalid email format.' });
    }
    const mobileRegex = /^\d{10}$/;
    if (!mobile || !mobileRegex.test(mobile)) {
        return res.status(400).json({ success: false, message: 'Mobile number must be 10 digits.' });
    }
    if (!password || password.length < 6) {
        return res.status(400).json({ success: false, message: 'Password is required and must be at least 6 characters.' });
    }
    if (!firstname || firstname.trim() === '') {
        return res.status(400).json({ success: false, message: 'Name is required.' });
    }
    try {

        const saltRounds = 10;
        const hashedPassword = await bcrypt.hash(password, saltRounds);
        const user = await Ride.create({
            mobile,
            email,
            password: hashedPassword,
            firstname,
            lastname,
            gender,
            dob

        });

        res.status(200).json({
            success: true,
            message: 'Ride  Record Created Successfully.',
            data: user,
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: error.message,
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
        const newVehicle = new Vehicle({
            ride_id,
            brand,
            model,
            model_year,
            license_plate,
            color,
            booking_type
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
    const { ride_id, photo, card_number, expired_date, name } = req.body;
    if (!ride_id || !card_number) {
        return res.status(400).json({
            success: false,
            message: 'ride_id, card_number,  are required.'
        });
    }
    try {
        const newDocument = new Document({
            ride_id,
            photo,
            card_number,
            expired_date,
            name
        });
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





exports.getOrderDetailById = async (req, res) => {
    const { id } = req.body;
    if (!id) {
        return res.status(400).json({
            success: false,
            message: 'id is required.'
        });
    }
    try {
        const orderDetail = await OrderDetail.findOne({
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
