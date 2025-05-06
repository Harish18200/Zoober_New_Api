const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const PricingRules = sequelize.define('pricing_rules', {
    id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true,
    },
    base_price: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    price_per_km: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    price_per_minute: {
        type: DataTypes.TEXT,
        allowNull: true,
    },

    minimum_fare: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    cancellation_fee: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    platform_fee: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    max_wait_time: {
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
    tableName: 'pricing_rules',
    timestamps: false,
});





module.exports = PricingRules;
