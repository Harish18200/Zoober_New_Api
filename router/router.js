const express = require('express');
const router = express.Router();



const userController = require('../controllers/Users/userController');
const rideController = require('../controllers/Ride/rideController');
const adminController = require('../controllers/Admin/adminController');
const verifyToken = require('../Middleware/authMiddleware');
const verifyRideToken = require('../Middleware/rideMiddleware');
const upload = require('../Middleware/upload');
const document = require('../Middleware/document');

// webAdmin Api's
router.get('/totalActiveDrivers', rideController.totalActiveDrivers);    //ActiveDrivers
router.get('/totalUsers', userController.totalUsers);  //TotalUsers
router.get('/todayTotalRides', rideController.todayTotalRides);  // TodayRides
router.get('/todayRevenue', rideController.todayRevenue);  // RevenueToday
router.get('/getAllUsers', userController.getAllUsers);  //Users 
router.get('/getAllDrivers', rideController.getAllDrivers);  //Drivers 
router.get('/recentRides', userController.recentRides);  // Recent Rides
router.get('/driverPendingApproval', rideController.driverPendingApproval);  // driver pendingApproval
router.get('/driverApproval', rideController.driverApproval);  // driver Approval
router.post('/driverListByStatus', rideController.driverListByStatus);  //driver list by status
router.post('/addFarePriceRule', adminController.addFarePriceRule);// Fare & Pricing
router.post('/supports', adminController.supports);  // Supports



//Insurance  
router.post('/addInsurance', userController.addInsurance);
router.get('/reteriveInsurances', userController.reteriveInsurances);
router.post('/reteriveInsuranceById', userController.reteriveInsuranceById);
router.post('/deletedMarkIsuranceById', userController.deletedMarkIsuranceById);


// User whatapp Otp Api

router.post('/sentWhatsappOtp', userController.sendWhatsappOtp);
router.post('/whatsappOtpValidate', userController.whatsappOtpValidate);

// Driver Whatapp Otp Api 

router.post('/driverSentWhatsappOtp', rideController.driverSentWhatsappOtp);
router.post('/driverWhatsappOtpValidate', rideController.driverWhatsappOtpValidate);

//driver Api's

router.post('/getRiderAllNotifications', rideController.getRiderAllNotifications);
router.post('/driverDatewiseHistory', rideController.driverDatewiseHistory);



//user Api 's
router.post('/userSignUp', userController.userSignUp);
router.post('/userLogin', userController.userLogin);

router.post('/activeProcessingOrder', userController.activeProcessingOrder);
router.post('/userCompletedLocations', userController.userCompletedLocations);






router.get('/supportList', adminController.supportList);


router.post('/rideSignUp', upload.single('profile'), rideController.rideSignUp);
router.post('/rideLogin', rideController.rideLogin);
router.post('/rideDashboard', rideController.rideDashboard);
router.post('/addVehicle', rideController.addVehicle);
router.post('/addOrUpdateRideDetails', rideController.addOrUpdateRideDetails);
router.get('/totalOnlineRide', rideController.totalOnlineRide);


router.get('/totalRidesDetails', rideController.totalRidesDetails);
router.post('/completedBookingRide', rideController.completedBookingRide);
router.post('/OrderCompletedChangeStatus', rideController.OrderCompletedChangeStatus);
router.post('/retreiveAmountByUserId', rideController.retreiveAmountByUserId);
router.get('/documentTypes', rideController.documentTypes);
router.post('/cancelOrder', rideController.cancelOrder);



router.post('/activeVehicle', verifyRideToken, rideController.activeVehicle);
router.post('/rideVehicleList', rideController.rideVehicleList);
router.post(
    '/addDocument',
    document.fields([
        { name: 'front_side_file', maxCount: 1 },
        { name: 'back_side_file', maxCount: 1 }
    ]),
    rideController.addDocument
);
router.post('/listDocument', rideController.listDocument);
router.post('/getOrderDetailById', verifyRideToken, rideController.getOrderDetailById);
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
router.post('/userFeedbackForRider', userController.userFeedbackForRider);

router.post('/sendUserBookingOtp', userController.sendUserBookingOtp); // New Api

router.post('/bookingOtpValidateUser', userController.bookingOtpValidateUser); // New Api
router.post('/priceUpdateUserBooking', userController.priceUpdateUserBooking); // New Api
router.post('/estimatesListUserBooking', userController.estimatesListUserBooking); // New Api
router.post('/getUserAllNotifications', userController.getUserAllNotifications); // New Api
router.post('/userCompletedOrderList', userController.userCompletedOrderList);  // New Api

router.post('/findingNearByDriver', userController.findingNearByDriver);  // New Api
router.post('/googleMap', userController.googleMap);

module.exports = router;

