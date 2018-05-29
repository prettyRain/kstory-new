ALTER TABLE `np_goods` ADD COLUMN `sell_type` varchar(5) DEFAULT '0' COMMENT '销售类型，0零售，1批发，默认为0' AFTER `freight_template_id`;
ALTER TABLE `np_goods` ADD COLUMN `unit_price` decimal(10,2) COMMENT '单价' AFTER `sell_type`;
ALTER TABLE `np_customer_address` ADD COLUMN `address_type` enum('0','1') DEFAULT '0' COMMENT '地址类型：0普通收货地址，1社区店地址' AFTER `address_email`, ADD COLUMN `community_store_id` bigint(20) COMMENT '关联的社区店id' AFTER `address_type`;
ALTER TABLE `np_order` ADD COLUMN `community_store_id` bigint(20) COMMENT '社区店id' AFTER `coupon_price`;
ALTER TABLE `np_channel_adver` ADD COLUMN `nav_id` bigint(20) COMMENT '导航id' AFTER `temp5`;
ALTER TABLE `np_channel_storey_goods` ADD COLUMN `nav_id` bigint COMMENT '导航id' AFTER `temp5`;