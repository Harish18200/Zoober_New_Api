const express = require('express');
const router = express.Router();


const userController = require('../controllers/Users/userController');
const rideController = require('../controllers/Ride/rideController');
const adminController = require('../controllers/Admin/adminController');
const verifyToken = require('../Middleware/authMiddleware');
const verifyRideToken = require('../Middleware/rideMiddleware');
const upload  = require('../Middleware/upload');
const document  = require('../Middleware/document');



router.post('/addFarePriceRule', adminController.addFarePriceRule);




router.post('/userLogin', userController.userLogin);  // Done
router.post('/userSignUp', userController.userSignUp);  // Done
router.post('/rideSignUp', upload.single('profile'),rideController.rideSignUp);  // done
router.post('/rideLogin', rideController.rideLogin);  // done
router.post('/addVehicle', verifyRideToken,rideController.addVehicle); 
router.post('/addOrUpdateRideDetails',rideController.addOrUpdateRideDetails);  
router.get('/totalRideCount',rideController.totalRideCount);





router.post('/activeVehicle', verifyRideToken,rideController.activeVehicle);
router.post('/rideVehicleList', verifyRideToken,rideController.rideVehicleList);   // done 
router.post('/addDocument', verifyRideToken,document.single('document'),rideController.addDocument); // done
router.post('/listDocument', verifyRideToken,rideController.listDocument); // done 
router.post('/getOrderDetailById', verifyRideToken,rideController.getOrderDetailById); // done 
router.post('/deviceLocation', verifyToken, userController.deviceLocation);  // Done
router.post('/userOrderBooking', userController.userOrderBooking);  // Done
router.get('/pickupTypes', verifyToken, userController.pickupTypes); // Done
router.get('/UserRideTypes', verifyToken, userController.UserRideTypes);   // Done
router.get('/suggestions', verifyToken, userController.suggestions);  // Done
router.post('/userProfileUpdate', verifyToken, upload.single('profile'), userController.userProfileUpdate); 
router.post('/deleteAccount', verifyToken, userController.deleteAccount); // done
router.post('/logout', verifyToken, userController.logout); // pending
router.post('/favouriteList', verifyToken, userController.favouriteList);  // done
router.post('/addFavourite', verifyToken, userController.addFavourite);  // done
router.post('/editFavourite', verifyToken, userController.editFavourite); // done
router.post('/deleteFavourite', verifyToken, userController.deleteFavourite); // done
router.post('/fetchUserDetails', verifyToken, userController.fetchUserDetails);  // done
router.post('/userRideHistory', verifyToken, userController.userRideHistory);
router.post('/addUserDetails', verifyToken, userController.addUserDetails);
router.post('/updateUserDetails', verifyToken, userController.updateUserDetails);
router.post('/deletedUserDetails', verifyToken, userController.deletedUserDetails);
router.get('/getAllUsers', verifyToken, userController.getAllUsers);
router.post('/totalUsersCount', verifyToken, userController.totalUsersCount);

module.exports = router;

