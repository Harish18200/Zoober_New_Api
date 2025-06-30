const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const userReview = sequelize.define('user_reviews', {
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

    rider_id: {
        type: DataTypes.INTEGER,
        allowNull: true,
    },
    review_type_status: {
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
    tableName: 'user_reviews',
    timestamps: false,
});

module.exports = userReview;
