const PricingRules = require('../../models/PricingRules');
const Supports = require('../../models/Supports');

exports.addFarePriceRule = async (req, res) => {
    const {
      base_price,
      price_per_km,
      price_per_minute,
      minimum_fare,
      cancellation_fee,
      platform_fee,
      max_wait_time,
      suggestion_id
    } = req.body;
    try {
      const newRule = await PricingRules.create({
        base_price,
        price_per_km,
        price_per_minute,
        minimum_fare,
        cancellation_fee,
        platform_fee,
        max_wait_time,
        suggestion_id
      });
  
      return res.status(201).json({
        success: true,
        message: 'Pricing rule created successfully.',
        data: newRule
      });
    } catch (error) {
      console.error('Error creating pricing rule:', error);
      return res.status(500).json({
        success: false,
        message: 'Server error. Please try again later.',
        error: error.message
      });
    }
  };
  exports.supports = async (req, res) => {
    const {
      platform_name,
      support_email,
      support_phone,
      help_center_url,
      terms_conditions_url,
      privacy_policy_url,
  
    } = req.body;

    try {
      const newRule = await Supports.create({
        platform_name,
        support_email,
        support_phone,
        help_center_url,
        terms_conditions_url,
        privacy_policy_url,
      });
      return res.status(201).json({
        success: true,
        message: 'Supports created successfully.',
        data: newRule
      });
    } catch (error) {
      console.error('Error creating pricing rule:', error);
      return res.status(500).json({
        success: false,
        message: 'Server error. Please try again later.',
        error: error.message
      });
    }
  };
  exports.supportList = async (req, res) => {
    try {
      const supportList = await Supports.findAll({
        where: {
          deleted_flag: null,
          deleted_at: null
        },
        order: [['id', 'ASC']] 
      });
  
      return res.status(200).json({
        success: true,
        message: 'Supports fetched successfully.',
        data: supportList
      });
  
    } catch (error) {
      console.error('Error fetching supports:', error);
      return res.status(500).json({
        success: false,
        message: 'Server error. Please try again later.',
        error: error.message
      });
    }
  };
  