require('dotenv').config({ path: './config/.env' });
const express = require('express');
const sequelize = require('./config/db');
const app = express();
const PORT = 3000;
const router = require('./router/router');
const cors = require('cors');
const User = require('./models/User');
const UserDetails = require('./models/UserDetails');
const Ride = require('./models/Ride');
const RideDetails = require('./models/RideDetails');
const Vehicle = require('./models/Vehicle');
const OrderBooking = require('./models/OrderBookings');
const OrderHistory = require('./models/OrderHistory');
const http = require('http');
const WebSocket = require('ws');
const UserReview = require('./models/UserReview');
const OrderDetail = require('./models/OrderBookings');


const server = http.createServer(app);
const wss = new WebSocket.Server({ server });

User.hasOne(UserDetails, { foreignKey: 'user_uid', sourceKey: 'user_uid' });
UserDetails.belongsTo(User, { foreignKey: 'user_uid', targetKey: 'user_uid' });

Ride.hasOne(RideDetails, { foreignKey: 'ride_id', sourceKey: 'id' });
RideDetails.belongsTo(Ride, { foreignKey: 'ride_id', targetKey: 'id' });

Ride.hasOne(Vehicle, { foreignKey: 'ride_id', sourceKey: 'id' });
Vehicle.belongsTo(Ride, { foreignKey: 'ride_id', targetKey: 'id' });

// OrderHistory.hasOne(OrderBooking, { foreignKey: 'id', sourceKey: 'order_id' });
// OrderBooking.belongsTo(OrderHistory, { foreignKey: 'order_id', targetKey: 'id' });

User.hasOne(OrderHistory, { foreignKey: 'user_id', sourceKey: 'id' });
OrderHistory.belongsTo(User, { foreignKey: 'user_id', targetKey: 'id' });

Ride.hasOne(OrderHistory, { foreignKey: 'ride_id', sourceKey: 'id' });
OrderHistory.belongsTo(Ride, { foreignKey: 'ride_id', targetKey: 'id' });


OrderBooking.belongsTo(User, { foreignKey: 'user_uid' });
User.hasMany(OrderBooking, { foreignKey: 'user_uid' });

module.exports = {
  User,
  UserDetails,
  OrderBooking
};



async function getUserReviewAndRating(userId) {
  if (!userId) {
    return { success: false, message: 'userId is required' };
  }

  try {
    const userReview = await UserReview.findOne({
      where: {
        user_id: userId,
        review_type_status: 1,
      },
    });

    if (!userReview) {
      return { success: false, message: 'No review found' };
    }

    const riderId = userReview.rider_id;

    if (!riderId) {
      return { success: false, message: 'riderId is missing in review data' };
    }

    const rider = await Ride.findOne({
      where: {
        id: riderId,
        deleted_at: null,
        deleted_flag: null,
      },
    });

    if (!rider) {
      return { success: false, message: 'Rider not found' };
    }

    return {
      success: true,
      message: 'User review and rider details retrieved successfully',
      data: {
        riderId: rider.id,
        profile: rider.profile,
        mobile: rider.mobile,
        firstName: rider.firstname,
        lastName: rider.lastname,
      },
    };
  } catch (error) {
    return {
      success: false,
      message: 'Server error',
      error: error.message,
    };
  }
}
async function userOrderAccpetedDriverDetails(userId) {
  if (!userId) {
    return { success: false, message: 'userId is required' };
  }

  try {
    const orderData = await OrderDetail.findOne({
      where: {
        otp_status: 1,
        order_status_id: 3,
        user_id: userId
      },
    });

    if (!orderData) {
      return { success: false, message: 'No processing order data found' };
    }

    const orderHistory = await OrderHistory.findOne({
      where: {
        order_id: orderData.id,
        user_id: userId
      }
    });

    if (!orderHistory || !orderHistory.ride_id) {
      return { success: false, message: 'ride_id is missing in order history data' };
    }

    const rider = await Ride.findOne({
      where: {
        id: orderHistory.ride_id,
        deleted_at: null,
        deleted_flag: null,
      },
    });

    if (!rider) {
      return { success: false, message: 'Rider not found' };
    }

    return {
      success: true,
      message: 'User processing ride and rider details retrieved successfully',
      data: {
        riderId: rider.id,
        profile: rider.profile,
        mobile: rider.mobile,
        firstName: rider.firstname,
        lastName: rider.lastname,
        pickupLocation: orderData.pickup_location,
        dropLocation: orderData.drop_location,
        otp: orderData.otp,
        orderId: orderData.id
      },
    };
  } catch (error) {
    return {
      success: false,
      message: 'Server error',
      error: error.message,
    };
  }
}

async function markDriverStatusAndUpdated(rideId, rideStatus, latitude, longitude, location) {
  if (!rideId) {
    return { success: false, message: 'RideId is required.' };
  }

  if (!latitude) {
    return { success: false, message: 'latitude is required.' };
  }

  if (!longitude) {
    return { success: false, message: 'longitude is required.' };
  }

  if (!rideStatus) {
    return { success: false, message: 'rideStatus is required.' };
  }

  if (!location) {
    return { success: false, message: 'location is required.' };
  }

  try {
    const existingRide = await Ride.findOne({ where: { id: rideId } });

    if (!existingRide) {
      return { success: false, message: 'Ride not found.' };
    }

    await existingRide.update({ latitude, longitude, location });

    if (rideStatus === "offline") {
      const rideRecord = await Ride.findOne({
        where: { id: rideId },
        attributes: ['working_hour']
      });

      const offlineTime = new Date();
      const workingHour = new Date(rideRecord.working_hour);
      const addedMinutes = Math.floor((offlineTime - workingHour) / (1000 * 60));

      const rideDetail = await RideDetails.findOne({ where: { ride_id: rideId } });

      let totalMinutes = addedMinutes;
      if (rideDetail && rideDetail.total_hours) {
        const [hours, minutes] = rideDetail.total_hours.split(':').map(Number);
        const existingMinutes = (hours || 0) * 60 + (minutes || 0);
        totalMinutes += existingMinutes;
      }

      const finalHours = Math.floor(totalMinutes / 60);
      const finalMinutes = totalMinutes % 60;
      const formattedTime = `${String(finalHours).padStart(2, '0')}:${String(finalMinutes).padStart(2, '0')}`;

      await Ride.update({ status: rideStatus }, { where: { id: rideId } });

      if (rideDetail) {
        await RideDetails.update({ total_hours: formattedTime }, { where: { ride_id: rideId } });
      } else {
        await RideDetails.create({ ride_id: rideId, total_hours: formattedTime });
      }

      return {
        success: true,
        message: `Ride marked as offline. ${finalHours} hour(s) ${finalMinutes} minute(s) added.`,
        duration: { hours: finalHours, minutes: finalMinutes }
      };
    }

    if (rideStatus === "online") {
      await Ride.update({ status: rideStatus, working_hour: new Date() }, { where: { id: rideId } });

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
            attributes: ['firstname', 'lastname', 'mobile', 'profile', 'email', 'gender', 'dob', 'user_status']
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

      return {
        success: true,
        message: 'Ride marked as online. Booking list fetched.',
        data: filteredOrders
      };
    }

    return {
      success: true,
      message: `Ride status updated to "${rideStatus}".`
    };

  } catch (error) {
    console.error('Error updating ride status:', error);
    return {
      success: false,
      message: 'Server error',
      error: error.message
    };
  }
}


wss.on('connection', (socket) => {
  console.log('🟢 WebSocket connected');

  socket.on('message', async (message) => {
    try {
      const parsed = JSON.parse(message);
      const event = parsed.event;

      if (event === 'getUserReview') {
        const userId = parsed.data?.userId;
        if (!userId) throw new Error('userId is missing');

        const response = await getUserReviewAndRating(userId);

        socket.send(JSON.stringify({
          event: 'userReviewResponse',
          data: response,
        }));

      } else if (event === 'userOrderAccpetedDriverDetails') {
        const userId = parsed.data?.userId;

        if (!userId) throw new Error('userId  is missing');

        const response = await userOrderAccpetedDriverDetails(userId);

        socket.send(JSON.stringify({
          event: 'userOrderAccpetedDriverDetails',
          data: response,
        }));

      }
      else if (event === 'markDriverStatusAndUpdated') {
        try {
          const rideId = parsed.data?.rideId;
          const rideStatus = parsed.data?.rideStatus;
          const latitude = parsed.data?.latitude;
          const longitude = parsed.data?.longitude;
          const location = parsed.data?.location;

          if (!rideId || !rideStatus || !latitude || !longitude || !location) {
            throw new Error('One or more required fields are missing');
          }

          const response = await markDriverStatusAndUpdated(rideId, rideStatus, latitude, longitude, location);

          socket.send(JSON.stringify({
            event: 'markDriverStatusAndUpdated',
            data: response
          }));
        } catch (err) {
          socket.send(JSON.stringify({
            event: 'error',
            message: err.message
          }));
        }
      }


      else {
        socket.send(JSON.stringify({
          event: 'error',
          message: 'Unknown event type',
        }));
      }

    } catch (err) {
      console.error('❌ WebSocket Error:', err.message);
      socket.send(JSON.stringify({
        event: 'error',
        message: err.message || 'Invalid message format or internal error',
      }));
    }
  });


  socket.on('close', () => {
    console.log('🔴 WebSocket connection closed');
  });
});




app.get('/', (req, res) => {
  res.send('WebSocket server is running!');
});

app.use('/upload/images', express.static('upload/images'));
app.use('/upload/documents', express.static('upload/documents'));

app.use('/upload/images', cors(), express.static('upload/images'));

app.use(cors({
  origin: '*',
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization']
}));
app.use(express.json());
app.use('/uploads', express.static('./uploads'));
app.set('view engine', 'ejs');
app.use("/api", router);

sequelize.sync()
  .then(() => {
    console.log('Database synced');
    server.listen(PORT, () => {
      console.log(`🚀 Server and WebSocket listening on http://0.0.0.0:${PORT}`);
    });
  })
  .catch(err => {
    console.error('Error syncing database:', err);
  });
process.on('SIGINT', async () => {
  console.log("Server is shutting down...");
  await sequelize.close();
  process.exit(0);
});