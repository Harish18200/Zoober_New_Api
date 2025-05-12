const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');
const Notification = require('./Notifications');

const UserNotification = sequelize.define('user_notifications', {
    id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true,
    },
    user_id: {
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
    tableName: 'user_notifications',
    timestamps: false,
});
UserNotification.belongsTo(Notification, { foreignKey: 'notification_id', as: 'notifications' });

module.exports = UserNotification;
