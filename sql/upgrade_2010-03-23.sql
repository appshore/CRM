DROP TABLE IF EXISTS `logs_import`;
CREATE TABLE IF NOT EXISTS `logs_import` (
  `user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `app_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `timestamp` datetime NOT NULL,
  `line` int(11) NOT NULL,
  `reason` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `record` longtext COLLATE utf8_unicode_ci NOT NULL,
  KEY `user_id` (`user_id`,`app_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

