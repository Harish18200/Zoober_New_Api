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
const OrderBookingChangeLog = require('./models/orderBookingChangeLog');
const mysql = require('mysql2');
const Document = require('./models/Document');
const DocumentType = require('./models/DocumentType');
const { Op } = require('sequelize');
const { differenceInMinutes, isBefore, isSameDay } = require('date-fns')



const server = http.createServer(app);
const wss = new WebSocket.Server({ server });

User.hasOne(UserDetails, { foreignKey: 'user_uid', sourceKey: 'user_uid' });
UserDetails.belongsTo(User, { foreignKey: 'user_uid', targetKey: 'user_uid' });

Ride.hasOne(RideDetails, { foreignKey: 'ride_id', sourceKey: 'id' });
RideDetails.belongsTo(Ride, { foreignKey: 'ride_id', targetKey: 'id' });

Ride.hasOne(Vehicle, { foreignKey: 'ride_id', sourceKey: 'id' });
Vehicle.belongsTo(Ride, { foreignKey: 'ride_id', targetKey: 'id' });

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

async function UserProcessingRideDetails(userId, orderId) {
  if (!userId) {
    return { success: false, message: 'userId is required' };
  }

  if (!orderId) {
    return { success: false, message: 'orderId is required' };
  }

  try {
    const orderDetails = await OrderBooking.findOne({
      where: {
        user_id: userId,
        id: orderId,
        otp_status: 2,
        order_status_id: 4,
      },
    });

    if (!orderDetails) {
      return { success: false, message: 'No order details found' };
    }

    return {
      success: true,
      message: 'Order details retrieved successfully',
      data: orderDetails,
    };
  } catch (error) {
    return {
      success: false,
      message: 'Server error',
      error: error.message || 'Unknown error',
    };
  }
}
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
  if (!rideId || !latitude || !longitude || !rideStatus || !location) {
    return { success: false, message: 'All fields (rideId, rideStatus, latitude, longitude, location) are required.' };
  }

  try {
    const existingRide = await Ride.findOne({ where: { id: rideId } });
    if (!existingRide) {
      return { success: false, message: 'Ride not found.' };
    }

    const masterDocs = await DocumentType.findAll({ where: { status: 1 } });
    if (!masterDocs || masterDocs.length === 0) {
      return { success: false, message: 'No document types found.' };
    }

    for (const docType of masterDocs) {
      const exists = await Document.findOne({
        where: { ride_id: rideId, document_type_id: docType.id }
      });
      if (!exists) {
        return {
          success: false,
          message: 'You have not submitted your documents such as Aadhar, License, and RC Book. Please submit them on a priority basis.'
        };
      }
    }


    await existingRide.update({ latitude, longitude, location });

    if (rideStatus === "offline") {
      const offlineTime = new Date();
      const workingHour = new Date(existingRide.working_hour || offlineTime);
      const addedMinutes = Math.floor((offlineTime - workingHour) / (1000 * 60));

      let totalMinutes = addedMinutes;
      const rideDetail = await RideDetails.findOne({ where: { ride_id: rideId } });

      if (rideDetail?.total_hours) {
        const [hours, minutes] = rideDetail.total_hours.split(':').map(Number);
        totalMinutes += (hours * 60 + minutes);
      }

      const finalHours = Math.floor(totalMinutes / 60);
      const finalMinutes = totalMinutes % 60;
      const formattedTime = `${String(finalHours).padStart(2, '0')}:${String(finalMinutes).padStart(2, '0')}`;

      await Ride.update({ status: rideStatus }, { where: { id: rideId } });

      if (rideDetail) {
        await rideDetail.update({ total_hours: formattedTime });
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

      const activeVehicle = await Vehicle.findOne({
        where: {
          ride_id: rideId,
          status: 1,
          suggestion_id: { [Op.ne]: null }
        }
      });

      if (!activeVehicle) {
        return { success: false, message: 'Vehicle not found.' };
      }

      const bookingList = await OrderBooking.findAll({
        where: {
          order_status_id: 2,
          suggestion_id: activeVehicle.suggestion_id,
          deleted_flag: null,
          deleted_at: null
        },
        include: [{
          model: User,
          as: 'users',
          attributes: ['firstname', 'lastname', 'mobile', 'profile', 'email', 'gender', 'dob', 'user_status']
        }],
        raw: true,
        nest: true
      });

      const getDistance = (lat1, lon1, lat2, lon2) => {
        const R = 6371;
        const dLat = (lat2 - lat1) * Math.PI / 180;
        const dLon = (lon2 - lon1) * Math.PI / 180;
        const a = Math.sin(dLat / 2) ** 2 +
          Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) *
          Math.sin(dLon / 2) ** 2;
        const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        return R * c;
      };

      const calculateNearbyOrders = (range) => {
        return bookingList
          .map(list => {
            const distance = getDistance(
              parseFloat(list.pickup_latitude),
              parseFloat(list.pickup_longitude),
              parseFloat(latitude),
              parseFloat(longitude),
            );
            return { ...list, distance };
          })
          .filter(d => d.distance <= range)
          .sort((a, b) => a.distance - b.distance)
          .map(d => ({
            ...d,
            distance: `${d.distance.toFixed(2)} km`
          }));
      };

      let nearbyOrders = calculateNearbyOrders(3);
      if (nearbyOrders.length === 0) {
        nearbyOrders = calculateNearbyOrders(5);
      }

      if (nearbyOrders.length === 0) {
        return {
          success: false,
          message: 'No nearby bookings found within 5 km.'
        };
      }

      const filteredOrders = nearbyOrders.map(order => ({
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

const clients = new Set();
wss.on('connection', (socket) => {
  console.log('🟢 WebSocket connected');
  clients.add(socket);


  socket.on('message', async (message) => {
    try {
      const parsed = JSON.parse(message);
      const event = parsed.event;

      if (event === 'getRideDetailsByOrderId') {
        const orderId = parsed.data?.orderId;
        if (!orderId) throw new Error('orderId is missing');

        const response = await fetchFullRideDetailsByOrderId(orderId);

        socket.send(JSON.stringify({
          event: 'getRideDetailsByOrderId',
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
      else if (event === 'UserProcessingRideDetails') {
        try {
          const userId = parsed.data?.userId;
          const orderId = parsed.data?.orderId;


          if (!userId || !orderId) {
            throw new Error('One or more required fields are missing');
          }

          const response = await UserProcessingRideDetails(userId, orderId);

          socket.send(JSON.stringify({
            event: 'UserProcessingRideDetails',
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
      console.error(' WebSocket Error:', err.message);
      socket.send(JSON.stringify({
        event: 'error',
        message: err.message || 'Invalid message format or internal error',
      }));
    }
  });



  setInterval(async () => {
    try {

      const orders = await OrderBooking.findAll({
        where: { order_status_id: 2 },
        attributes: ['id', 'user_id', 'created_at']
      });

      const now = new Date();
      const todayDate = now.toISOString().split('T')[0]; // 'YYYY-MM-DD'

      for (const order of orders) {
        const createdAt = new Date(order.created_at);
        const createdDate = createdAt.toISOString().split('T')[0];

        if (createdDate < todayDate) {
          // Past date – always expired
          await OrderBooking.update(
            {
              order_status: 'expired',
              order_status_id: 6
            },
            { where: { id: order.id } }
          );
          console.log(`Order ${order.id} marked as expired (past date)`);

        } else if (createdDate === todayDate) {
          const createdHour = createdAt.getUTCHours();
          console.log('createdHour,createdHour', createdHour);
          const createdMinute = createdAt.getUTCMinutes();
          console.log('createdMinute', createdMinute);

          const nowHour = now.getHours();
          console.log('nowHour,nowHour', nowHour);
          const nowMinute = now.getMinutes();
          console.log('nowMinute', nowMinute);

          console.log(`Order ${order.id} created at ${createdHour}:${createdMinute}, now is ${nowHour}:${nowMinute}`);

          if (createdHour < nowHour) {
            // More than an hour old → expired
            await OrderBooking.update(
              {
                order_status: 'expired',
                order_status_id: 6
              },
              { where: { id: order.id } }
            );
            console.log(`Order ${order.id} marked as expired (hour old)`);

          } else if (createdHour === nowHour) {


            if (nowMinute - createdMinute >= 3) {
              // Same hour but 3+ minutes older → expired
              await OrderBooking.update(
                {
                  order_status: 'expired',
                  order_status_id: 6
                },
                { where: { id: order.id } }
              );
              console.log(`Order ${order.id} marked as expired (>= 3 minutes old)`);
            } else {
              console.log(`Order ${order.id} is from today and less than 3 minutes old`);
            }

          } else {
            // Created time is in the future within same day
            console.log(`Order ${order.id} is from later today – not expired yet`);
          }

        } else {
          // Future date
          console.log(`Order ${order.id} is from the future — skipping`);
        }
      }



    } catch (err) {
      console.error('Sequelize polling error:', err);
    }
  }, 1000);



  setInterval(async () => {
    try {
      const [results] = await sequelize.query(`
      SELECT * FROM review_user_change_log 
      WHERE table_name = 'user_reviews' 
      AND action_type = 'INSERT' 
      ORDER BY id DESC LIMIT 1
    `);

      if (results.length > 0) {
        const latest = results[0];
        for (const client of clients) {
          client.send(JSON.stringify({
            event: 'newUserReview',
            data: latest,
          }));
        }
        await sequelize.query(
          "DELETE FROM review_user_change_log WHERE id = ?",
          { replacements: [latest.id] }
        );
        return latest;
      }

      return null;
    } catch (err) {
      console.error('Polling error:', err);
    }
  }, 3000);








  let latestUpdatedId = null;

  setInterval(async () => {
    try {
      const latest = await OrderBookingChangeLog.findOne({
        where: {
          table_name: 'order_bookings',
          action_type: ['INSERT', 'UPDATE'],
        },
        order: [['id', 'DESC']],
      });
      if (latest) {
        latestUpdatedId = latest.order_id;
        const retriveRiderId = await OrderHistory.findOne({
          where: {
            order_id: latestUpdatedId,
          },
        });

        let retriveRiderDetails = null;

        if (retriveRiderId?.ride_id) {
          retriveRiderDetails = await Ride.findOne({
            where: {
              id: retriveRiderId.ride_id,
            },
          });
        }

        for (const client of clients) {
          const responseData = {
            event: 'OrderBookingUpdates',
            data: {
              payload: latest?.payload ? JSON.parse(latest.payload) : null,
            },
          };

          if (retriveRiderDetails) {
            responseData.data.retriveRiderDetails = retriveRiderDetails;
          }

          client.send(JSON.stringify(responseData));
        }
        await OrderBookingChangeLog.destroy({
          where: {
            id: latest.id,
          },
        });
      }

      return null;
    } catch (err) {
      console.error('Polling error:', err);
    }
  }, 3000);




  setInterval(async () => {
    try {
      const [results] = await sequelize.query(`
      SELECT 
        ucl.id AS change_log_id,
        ucl.payload,
        JSON_UNQUOTE(JSON_EXTRACT(ucl.payload, '$.notification_id')) AS notif_id,
        n.*
      FROM user_notification_change_log ucl
      LEFT JOIN notifications n 
        ON JSON_UNQUOTE(JSON_EXTRACT(ucl.payload, '$.notification_id')) = n.id
      WHERE ucl.table_name = 'user_notifications' 
        AND ucl.action_type = 'INSERT'
      ORDER BY ucl.id ASC 
      LIMIT 1
    `);

      if (results.length > 0) {
        const latest = results[0];
        const [deleteResult] = await sequelize.query(
          `DELETE FROM user_notification_change_log WHERE id = ?`,
          { replacements: [latest.change_log_id] }
        );

        if (deleteResult.affectedRows === 0) {
          console.warn(`Failed to delete change log with id ${latest.change_log_id}`);
          return;
        }

        // Then broadcast to all clients
        for (const client of clients) {
          client.send(JSON.stringify({
            event: 'userNewNotification',
            data: latest,
          }));
        }
      }

    } catch (err) {
      console.error('Polling error:', err);
    }
  }, 3000);


  socket.on('close', () => {
    console.log('🔴 WebSocket connection closed');
    clients.delete(socket);
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