
TRUNCATE TABLE `editions`;
INSERT INTO `editions` (`edition_id`, `edition_name`, `description`, `is_available`, `price`, `period_id`, `metric_id`, `currency_id`, `users_quota`, `records_quota`, `disk_quota`, `emails_quota`, `edition_sequence`, `category`, `created`, `created_by`, `updated`, `updated_by`) VALUES
('PRO', 'AppShore Professional', '<li>10,000 records and 512 MB per user</li>\r\n<li>Up to 500 email messages per user per 24 hour period</li>', 'N', 14, 'MONTH', 'USER', 'USD', 1, 10000, 536870912, 500, 100, 'PRO', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0'),
('TRIAL', 'AppShore Trial', '', 'N', 0, 'MONTH', 'CUSTOMER', 'USD', 10, 10000, 1073741824, 100, 0, '', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0'),
('PRE', 'AppShore Premium', '<li>20,000 records and 1 GB per user</li>\r\n<li>Up to 2,000 email messages per user per 24 hour period</li>', 'N', 24, 'MONTH', 'USER', 'USD', 1, 20000, 1073741824, 2000, 110, 'PRE', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0'),
('SOLO', 'AppShore Solo', 'Single user', 'Y', 9, 'MONTH', 'CUSTOMER', 'USD', 1, 10000, 1073741824, 100, 10, '', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0'),
('TEAM3', 'AppShore Team3', 'Up to 3 users', 'Y', 24, 'MONTH', 'CUSTOMER', 'USD', 3, 50000, 3221225472, 500, 20, '', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0'),
('TEAM7', 'AppShore Team7', 'Up to 7 users', 'Y', 49, 'MONTH', 'CUSTOMER', 'USD', 7, 100000, 6442450944, 1000, 30, '', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0'),
('TEAM15', 'AppShore Team15', 'Up to 15 users', 'Y', 84, 'MONTH', 'CUSTOMER', 'USD', 15, 200000, 9663676416, 2000, 40, '', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0'),
('TEAM30', 'AppShore Team30', 'Up to 30 users', 'Y', 129, 'MONTH', 'CUSTOMER', 'USD', 30, 400000, 12884901888, 3000, 50, '', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0'),
('TNPROS', 'TNPROS', 'Up to 30 users', 'N', 0, 'MONTH', 'CUSTOMER', 'USD', 30, 400000, 12884901888, 3000, 50, '', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');


DROP TABLE IF EXISTS `editions_periods`;
CREATE TABLE IF NOT EXISTS `editions_periods` (
  `period_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `period_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `period_value` int(4) NOT NULL,
  `period_discount` int(4) NOT NULL DEFAULT '0',
  `period_sequence` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`period_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `editions_periods` (`period_id`, `period_name`, `period_value`, `period_discount`, `period_sequence`) VALUES
('UPGRADE', 'Upgrade', 0, 0, 0),
('MONTH', 'Month', 1, 0, 1),
('QUARTER', 'Quarter', 3, 0, 2),
('SEMESTER', 'Semester', 6, 5, 3),
('YEAR', 'Year', 12, 10, 4);
