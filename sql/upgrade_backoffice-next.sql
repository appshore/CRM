
DROP TABLE IF EXISTS `customers_schedules`;
CREATE TABLE IF NOT EXISTS `customers_schedules` (
  `schedule_date` date NOT NULL DEFAULT '0000-00-00',
  `schedule_time` time DEFAULT '00:00:00',
  `company_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `schedule_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`company_id`,`schedule_id`),
  KEY `schedule` (`schedule_date`,`schedule_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


