const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

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

module.exports = RiderNotification;
