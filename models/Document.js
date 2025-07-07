const { DataTypes } = require('sequelize');
const sequelize = require('../config/db');
const DocumentType = require('./DocumentType');

const Document = sequelize.define('documents', {
    id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true,
    },
    ride_id: {
        type: DataTypes.INTEGER,
        allowNull: true,
    },
    document_type_id: {
        type: DataTypes.INTEGER,
        allowNull: true,
    },
     admin_approval_status: {
        type: DataTypes.INTEGER,
        allowNull: true,
    },
    name: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    front_side_file_path: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    back_side_file_path: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    card_number: {
        type: DataTypes.TEXT,
        allowNull: true,
    }, expired_date: {
        type: DataTypes.TEXT,
        allowNull: true,
    }, status: {
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
    tableName: 'documents',
    timestamps: false,
});
Document.belongsTo(DocumentType, {
    foreignKey: 'document_type_id',
    as: 'documentType'
});
module.exports = Document;
