DROP TABLE IF EXISTS `dashboards_boxes`;
ALTER TABLE `dashboards` ADD PRIMARY KEY  (`user_id`,`dashlet_name`);
ALTER TABLE `dashboards` DROP INDEX `user_id`;

