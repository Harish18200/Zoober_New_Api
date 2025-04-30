const express = require('express');
const router = express.Router();


const userController = require('../controllers/Users/userController');
const rideController = require('../controllers/Ride/rideController');
const verifyToken = require('../Middleware/authMiddleware');
const upload  = require('../Middleware/upload');

router.post('/userLogin', userController.userLogin);  // Done
router.post('/userSignUp', userController.userSignUp);  // Done
router.post('/rideSignUp', rideController.rideSignUp);  // done live not working
router.post('/rideLogin', rideController.rideLogin);  // done
router.post('/addVehicle', rideController.addVehicle);  // done without token
router.post('/rideVehicleList', rideController.rideVehicleList);   // done without token
router.post('/addDocument', rideController.addDocument);   // done without token
router.post('/getOrderDetailById', rideController.getOrderDetailById); // done without token
router.post('/deviceLocation', verifyToken, userController.deviceLocation);  // Done
router.post('/storeOrderDetails', verifyToken, userController.storeOrderDetails);  // Done
router.get('/pickupTypes', verifyToken, userController.pickupTypes); // Done
router.get('/UserRideTypes', verifyToken, userController.UserRideTypes);   // Done
router.get('/suggestions', verifyToken, userController.suggestions);  // Done

router.post('/userProfileUpdate', verifyToken, upload.single('profile'), userController.userProfileUpdate);  // pending


router.post('/deleteAccount', verifyToken, userController.deleteAccount); // done
router.post('/logout', verifyToken, userController.logout); // pending
router.post('/favouriteList', verifyToken, userController.favouriteList);  // done
router.post('/addFavourite', verifyToken, userController.addFavourite);  // done
router.post('/editFavourite', verifyToken, userController.editFavourite); // done
router.post('/deleteFavourite', verifyToken, userController.deleteFavourite); // done
router.post('/fetchUserDetails', verifyToken, userController.fetchUserDetails);  // done

module.exports = router;

