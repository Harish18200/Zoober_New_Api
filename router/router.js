const express = require('express');
const router = express.Router();



const userController = require('../controllers/Users/userController');
const rideController = require('../controllers/Ride/rideController');
const adminController = require('../controllers/Admin/adminController');
const verifyToken = require('../Middleware/authMiddleware');
const verifyRideToken = require('../Middleware/rideMiddleware');
const upload  = require('../Middleware/upload');
const document  = require('../Middleware/document');

 
// webAdmin Api's
router.get('/totalActiveDrivers',rideController.totalActiveDrivers);  
router.get('/totalUsers',  userController.totalUsers);
router.get('/todayTotalRides',rideController.todayTotalRides);  // pending
router.get('/todayRevenue',rideController.todayRevenue);  // pending
router.get('/getAllUsers', userController.getAllUsers);
router.get('/getAllDrivers',rideController.getAllDrivers);
router.get('/recentRides',userController.recentRides);





router.post('/addFarePriceRule', adminController.addFarePriceRule);
router.post('/supports', adminController.supports);
router.get('/supportList', adminController.supportList);
router.post('/userLogin', userController.userLogin);  
router.post('/userSignUp', userController.userSignUp);
router.post('/rideSignUp', upload.single('profile'),rideController.rideSignUp);  
router.post('/rideLogin', rideController.rideLogin);  
router.post('/rideDashboard', rideController.rideDashboard);  
router.post('/addVehicle', verifyRideToken,rideController.addVehicle); 
router.post('/addOrUpdateRideDetails',rideController.addOrUpdateRideDetails);  
router.get('/totalOnlineRide',rideController.totalOnlineRide);  


router.post('/markRiderStatus',rideController.markRiderStatus);   // New Api
router.get('/totalRidesDetails',rideController.totalRidesDetails);  // New Api
router.post('/completedBookingRide',rideController.completedBookingRide);  // New Api
router.post('/OrderCompletedChangeStatus',rideController.OrderCompletedChangeStatus); // New Api

router.post('/activeVehicle', verifyRideToken,rideController.activeVehicle);
router.post('/rideVehicleList', verifyRideToken,rideController.rideVehicleList);   
router.post('/addDocument', verifyRideToken,document.single('document'),rideController.addDocument); 
router.post('/listDocument', verifyRideToken,rideController.listDocument); 
router.post('/getOrderDetailById', verifyRideToken,rideController.getOrderDetailById); 
router.post('/deviceLocation', verifyToken, userController.deviceLocation);  
router.post('/userOrderBooking', userController.userOrderBooking);  
router.get('/pickupTypes', verifyToken, userController.pickupTypes); 
router.get('/UserRideTypes', verifyToken, userController.UserRideTypes);   
router.get('/suggestions', verifyToken, userController.suggestions);  
router.post('/userProfileUpdate', verifyToken, upload.single('profile'), userController.userProfileUpdate); 
router.post('/deleteAccount', verifyToken, userController.deleteAccount); 
router.post('/logout', verifyToken, userController.logout);
router.post('/favouriteList', verifyToken, userController.favouriteList);  
router.post('/addFavourite', verifyToken, userController.addFavourite);  
router.post('/editFavourite', verifyToken, userController.editFavourite); 
router.post('/deleteFavourite', verifyToken, userController.deleteFavourite); 
router.post('/fetchUserDetails', verifyToken, userController.fetchUserDetails);  
router.post('/userRidesHistory', userController.userRidesHistory);
router.post('/addUserDetails', verifyToken, userController.addUserDetails);
router.post('/updateUserDetails', verifyToken, userController.updateUserDetails);
router.post('/deletedUserDetails', verifyToken, userController.deletedUserDetails);



router.post('/sendUserBookingOtp', userController.sendUserBookingOtp); // New Api
router.post('/bookingOtpValidateUser', userController.bookingOtpValidateUser); // New Api
router.post('/priceUpdateUserBooking', userController.priceUpdateUserBooking); // New Api
router.post('/estimatesListUserBooking', userController.estimatesListUserBooking); // New Api
router.post('/getUserAllNotifications', userController.getUserAllNotifications); // New Api
router.post('/userCompletedOrderList', userController.userCompletedOrderList);  // New Api



router.post('/findingNearByDriver', userController.findingNearByDriver);  // New Api
router.post('/googleMap', userController.googleMap); 

module.exports = router;

