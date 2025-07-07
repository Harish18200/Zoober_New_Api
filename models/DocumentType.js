const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');

const DocumentType = sequelize.define('document_types', {
    id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true,
    },
    type_name: {
        type: DataTypes.TEXT,
        allowNull: true,
    },

    status: {
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
    tableName: 'document_types',
    timestamps: false,
});


module.exports = DocumentType;
