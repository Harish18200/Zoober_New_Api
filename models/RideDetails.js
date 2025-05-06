const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const RideDetails = sequelize.define('ride_details', {
    id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true,
    },
    ride_uid: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    total_ride: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    total_hours: {
        type: DataTypes.TEXT,
        allowNull: true,
    },

    total_kilometer: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    rating: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    earning: {
        type: DataTypes.TEXT,
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
        type: DataTypes.DATE,
        allowNull: true,

    },
}, {
    tableName: 'ride_details',
    timestamps: false,
});

module.exports = RideDetails;
