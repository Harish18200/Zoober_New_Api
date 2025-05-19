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
const { fetchTotalActiveRides } = require('./controllers/Ride/rideController');

const server = http.createServer(app);
const wss = new WebSocket.Server({ server });

User.hasOne(UserDetails, { foreignKey: 'user_uid', sourceKey: 'user_uid' });
UserDetails.belongsTo(User, { foreignKey: 'user_uid', targetKey: 'user_uid' });

Ride.hasOne(RideDetails, { foreignKey: 'ride_id', sourceKey: 'id' });
RideDetails.belongsTo(Ride, { foreignKey: 'ride_id', targetKey: 'id' });

Ride.hasOne(Vehicle, { foreignKey: 'ride_id', sourceKey: 'id' });
Vehicle.belongsTo(Ride, { foreignKey: 'ride_id', targetKey: 'id' });

OrderHistory.hasOne(OrderBooking, { foreignKey: 'id', sourceKey: 'order_id' });
OrderBooking.belongsTo(OrderHistory, { foreignKey: 'order_id', targetKey: 'id' });

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

wss.on('connection', (ws) => {
  console.log('🟢 New WebSocket connection established');

  ws.on('message', (message) => {
    console.log(`📩 Received: ${message}`);
  });
  ws.on('close', () => {
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
        app.listen(PORT,() => {
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