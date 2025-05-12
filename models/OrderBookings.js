const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');
const User = require('./User');

const OrderBookings = sequelize.define('order_bookings', {
    id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true,
    },
    user_id: {
        type: DataTypes.INTEGER,
        allowNull: true,
    },
    user_uid: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    pickup_type_id: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    user_ride_type_id: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    distance: {
        type: DataTypes.TEXT,
        allowNull: true,
    }, pickup_latitude: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    pickup_longitude: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    drop_latitude: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    drop_longitude: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    amount: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    pickup_start_datetime: {
        type: DataTypes.DATE,
        allowNull: true,
    },
    otp: {
        type: DataTypes.INTEGER,
        allowNull: true,
    },
    otp_status: {
        type: DataTypes.INTEGER,
        allowNull: true,
    },
    pickup_location: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    drop_location: {
        type: DataTypes.TEXT,
        allowNull: true,
    },

    duration: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    order_status: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    order_status_id: {
        type: DataTypes.INTEGER,
        allowNull: true,
    },
    suggestion_id: {
        type: DataTypes.INTEGER,
        allowNull: true,
    },
    deleted_flag: {
        type: DataTypes.INTEGER,
        allowNull: true,
    },
    created_at: {
        type: DataTypes.DATE,
        allowNull: true,
        defaultValue: DataTypes.NOW
    },
    updated_at: {
        type: DataTypes.DATE,
        allowNull: true,
        defaultValue: DataTypes.NOW
    },
    deleted_at: {
        type: DataTypes.NOW,
        allowNull: true,

    },

}, {
    tableName: 'order_bookings',
    timestamps: false,
});
OrderBookings.belongsTo(User, { foreignKey: 'user_id', as: 'users' });


module.exports = OrderBookings;
