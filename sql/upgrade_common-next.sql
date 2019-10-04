
ALTER TABLE  `campaigns` DROP  `type_id`;
ALTER TABLE  `campaigns` ADD  `scheduled` DATETIME NOT NULL DEFAULT  '0000-00-00 00:00:00' AFTER  `status_id`;

DROP TABLE IF EXISTS `campaigns_types`;

DROP TABLE IF EXISTS `schedules`;
CREATE TABLE IF NOT EXISTS `schedules` (
  `schedule_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `schedule_date` date NOT NULL DEFAULT '0000-00-00',
  `schedule_time` time DEFAULT '00:00:00',
  `app_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `record_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `type_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `status_id` enum('A','D','T') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'A',
  PRIMARY KEY (`schedule_id`),
  KEY `schedule` (`schedule_date`,`schedule_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
