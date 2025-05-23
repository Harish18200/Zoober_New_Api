const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const Ride = sequelize.define('rides', {
    id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true,
    },
    ride_uid: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    firstname: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    lastname: {
        type: DataTypes.TEXT,
        allowNull: true,
    },

    mobile: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
     ride_status_id: {
        type: DataTypes.INTEGER,
        allowNull: true,
    },
    profile: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    email: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    gender: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    status: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
     working_hour: {
        type: DataTypes.DATE,
        allowNull: true,
    },
    ride_status: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    dob: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    latitude: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    location: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    longitude: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    deleted_flag: {
        type: DataTypes.INTEGER,
        allowNull: true,
    },
    password: {
        type: DataTypes.STRING,
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
        type: DataTypes.DATE,
        allowNull: true,

    },
}, {
    tableName: 'rides',
    timestamps: false,
});

module.exports = Ride;
