const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const notifications = sequelize.define('notifications', {
    id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true,
    },
    title: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
     
    description: {
        type: DataTypes.TEXT,
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
    tableName: 'notifications',
    timestamps: false,
});

module.exports = notifications;
