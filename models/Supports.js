const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const Supports = sequelize.define('supports', {
    id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true,
    },
    platform_name: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    support_email: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    support_phone: {
        type: DataTypes.TEXT,
        allowNull: true,
    },

    help_center_url: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    terms_conditions_url: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    privacy_policy_url: {
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
    tableName: 'supports',
    timestamps: false,
});





module.exports = Supports;
