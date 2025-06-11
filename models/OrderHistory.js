const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const OrderHistory = sequelize.define('order_histories', {
    id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true,
    },
    user_id: {
        type: DataTypes.INTEGER,
        allowNull: true,
    },

    order_id: {
        type: DataTypes.INTEGER,
        allowNull: true,
    },

    ride_id: {
        type: DataTypes.INTEGER,
        allowNull: true,
    },
  started_date: {
        type: DataTypes.DATE,
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
    tableName: 'order_histories',
    timestamps: false,
});

module.exports = OrderHistory;
