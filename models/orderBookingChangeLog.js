const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const OrderBookingChangeLog = sequelize.define('order_booking_change_log', {
    id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true,
    },
    order_id: {
        type: DataTypes.INTEGER,
        allowNull: true,
    },
    action_type: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    table_name: {
        type: DataTypes.TEXT,
        allowNull: true,
    },

    payload: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    changed_at: {
        type: DataTypes.DATE,
        allowNull: true,
        defaultValue: DataTypes.NOW
    }

}, {
    tableName: 'order_booking_change_log',
    timestamps: false,
});



module.exports = OrderBookingChangeLog;
