const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const UserDetails = sequelize.define('user_details', {
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
    rating: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    wallet: {
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
    tableName: 'user_details',
    timestamps: false,
});





module.exports = UserDetails;
