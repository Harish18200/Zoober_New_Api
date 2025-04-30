const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const OrderDetail = sequelize.define('order_details', {
    id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true,
    },
    user_id: {
        type: DataTypes.INTEGER,
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
    kilometer: {
        type: DataTypes.TEXT,
        allowNull: true,
    }, amount: {
        type: DataTypes.TEXT,
        allowNull: true,
    }, pickup_start_datetime: {
        type: DataTypes.DATE,
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
    tableName: 'order_details',
    timestamps: false,
});

module.exports = OrderDetail;
