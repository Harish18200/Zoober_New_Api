const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');
const Notification = require('./Notifications');

const RiderNotification = sequelize.define('rider_notifications', {
    id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true,
    },
    rider_id: {
        type: DataTypes.INTEGER,
        allowNull: true,
    },
     
    notification_id: {
        type: DataTypes.INTEGER,
        allowNull: true,
    },
     rider_otp: {
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
    tableName: 'rider_notifications',
    timestamps: false,
});
RiderNotification.belongsTo(Notification, { foreignKey: 'notification_id', as: 'notifications' });

module.exports = RiderNotification;
