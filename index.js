const express = require('express');
const sequelize = require('./config/db');
const app = express();
const PORT = 3000;
const router = require('./router/router');
const cors = require('cors');
app.use('/upload/images', express.static('upload/images'));
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
        app.listen(PORT, '0.0.0.0', () => {
            console.log('Server is running on http://192.168.118.177:${PORT}');
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