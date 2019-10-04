-- 
-- Database: `backoffice`
-- 

REPLACE INTO `company` (`company_id`, `company_alias`, `main_user_id`, `billing_user_id`, `company_name`, `company_status`, `appshore_version`, `license_time_stamp`, `edition_id`, `users_quota`, `disk_quota`, `legal_status`, `incorporation`, `industry_id`, `tax_id`, `fiscal_year`, `phone`, `fax`, `url`, `email`, `employees`, `address_billing`, `zipcode_billing`, `city_billing`, `state_billing`, `country_billing`, `address_shipping`, `zipcode_shipping`, `city_shipping`, `state_shipping`, `country_shipping`, `administration_rbac_update`, `domain_name`, `created`, `created_by`, `updated`, `updated_by`, `note`) VALUES 
('backoffice', 'backoffice', '1', '1', 'Backoffice', 'ACT', '0000-00-00', '0000-00-00', 'BACKOFFICE', 10, 512, '', '0000-00-00', '', '', 0, '', '', '', '', 0, '', '', '', '', '', '', '', '', '', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '', '');


DROP TABLE IF EXISTS `customers`;
CREATE TABLE IF NOT EXISTS `customers` (
  `company_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `referral_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `domain_name` varchar(250) collate utf8_unicode_ci NOT NULL,
  `company_name` varchar(250) collate utf8_unicode_ci NOT NULL,
  `company_alias` varchar(250) collate utf8_unicode_ci NOT NULL,
  `company_status` varchar(32) collate utf8_unicode_ci NOT NULL,
  `license_time_stamp` date NOT NULL default '0000-00-00',
  `edition_id` varchar(32) collate utf8_unicode_ci NOT NULL default 'TRIAL',
  `edition_name` varchar(250) collate utf8_unicode_ci NOT NULL,
  `due_date` date NOT NULL default '0000-00-00',
  `users_quota` int(11) NOT NULL default '10',
  `disk_quota` decimal(15,0) NOT NULL default '0',
  `records_quota` int(11) NOT NULL default '0',
  `emails_quota` decimal(15,0) NOT NULL default '0',
  `disk_used` decimal(15,0) NOT NULL default '0',
  `db_size` decimal(15,0) NOT NULL,
  `db_records` int(11) NOT NULL,
  `documents_size` decimal(15,0) NOT NULL,
  `documents_count` int(11) NOT NULL,
  `attachments_size` decimal(15,0) NOT NULL,
  `attachments_count` int(11) NOT NULL,
  `users_count` int(11) NOT NULL,
  `users_activated` int(11) NOT NULL,
  `industry_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `employees` int(11) NOT NULL,
  `address` varchar(250) collate utf8_unicode_ci NOT NULL,
  `zipcode` varchar(250) collate utf8_unicode_ci NOT NULL,
  `city` varchar(250) collate utf8_unicode_ci NOT NULL,
  `state_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `country_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `url` varchar(250) collate utf8_unicode_ci NOT NULL,
  `user_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `user_name` varchar(250) collate utf8_unicode_ci NOT NULL,
  `last_name` varchar(250) collate utf8_unicode_ci NOT NULL,
  `first_names` varchar(250) collate utf8_unicode_ci NOT NULL,
  `title` varchar(250) collate utf8_unicode_ci NOT NULL,
  `email` varchar(250) collate utf8_unicode_ci NOT NULL,
  `password` varchar(250) collate utf8_unicode_ci NOT NULL,
  `phone` varchar(250) collate utf8_unicode_ci NOT NULL,
  `training` enum('Y','N') collate utf8_unicode_ci NOT NULL default 'Y',
  `remote_addr` varchar(250) collate utf8_unicode_ci default NULL,
  `note` longtext collate utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_by` varchar(32) collate utf8_unicode_ci NOT NULL,
  `updated` datetime NOT NULL default '0000-00-00 00:00:00',
  `updated_by` varchar(32) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`company_id`),
  UNIQUE KEY `company_alias` (`company_alias`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


--
-- Table structure for table `customers_notifications`
--

DROP TABLE IF EXISTS `customers_notifications`;
CREATE TABLE IF NOT EXISTS `customers_notifications` (
  `notification_date` date NOT NULL,
  `notification_time` time DEFAULT '00:00:00',
  `company_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `notification_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`company_id`,`notification_id`),
  KEY `notification_date` (`notification_date`,`notification_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `customers_statuses`;
CREATE TABLE IF NOT EXISTS `customers_statuses`(
  `status_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `status_name` varchar(250) collate utf8_unicode_ci NOT NULL,
  `is_available` enum('Y','N') collate utf8_unicode_ci NOT NULL default 'Y',
  PRIMARY KEY  (`status_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


REPLACE INTO `customers_statuses` (`status_id`, `status_name`, `is_available`) VALUES 
('REG', 'Instance not created', 'N'),
('CLO', 'Closed', 'Y'),
('ACT', 'Activated', 'Y');


DROP TABLE IF EXISTS `customers_users`;
CREATE TABLE IF NOT EXISTS `customers_users` (
  `company_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `customers_user_id` varchar(64) collate utf8_unicode_ci NOT NULL,
  `customers_user_name` varchar(250) collate utf8_unicode_ci NOT NULL,
  `password` varchar(250) collate utf8_unicode_ci NOT NULL,
  `salutation` varchar(250) collate utf8_unicode_ci NOT NULL,
  `last_name` varchar(250) collate utf8_unicode_ci NOT NULL,
  `first_names` varchar(250) collate utf8_unicode_ci NOT NULL,
  `full_name` varchar(250) collate utf8_unicode_ci NOT NULL,
  `title` varchar(250) collate utf8_unicode_ci NOT NULL,
  `manager_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `assistant_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `department_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `locale_id` varchar(32) collate utf8_unicode_ci NOT NULL default 'en_US',
  `language_id` varchar(32) collate utf8_unicode_ci NOT NULL default 'en',
  `currency_id` varchar(32) collate utf8_unicode_ci NOT NULL default 'USD',
  `timezone_id` varchar(32) collate utf8_unicode_ci NOT NULL default '225',
  `skin_id` varchar(32) collate utf8_unicode_ci NOT NULL default 'default',
  `theme_id` varchar(32) collate utf8_unicode_ci NOT NULL default 'default',
  `app_name` varchar(250) collate utf8_unicode_ci NOT NULL default 'api',
  `nbrecords` int(4) NOT NULL default '10',
  `confirm_delete` enum('Y','N') collate utf8_unicode_ci NOT NULL default 'Y',
  `email` varchar(250) collate utf8_unicode_ci NOT NULL,
  `phone` varchar(250) collate utf8_unicode_ci NOT NULL,
  `mobile` varchar(250) collate utf8_unicode_ci NOT NULL,
  `fax` varchar(250) collate utf8_unicode_ci NOT NULL,
  `private_phone` varchar(250) collate utf8_unicode_ci NOT NULL,
  `private_mobile` varchar(250) collate utf8_unicode_ci NOT NULL,
  `private_email` varchar(250) collate utf8_unicode_ci NOT NULL,
  `birthdate` date NOT NULL default '0000-00-00',
  `status_id` varchar(32) collate utf8_unicode_ci NOT NULL default 'A',
  `is_salespeople` enum('Y','N') collate utf8_unicode_ci NOT NULL default 'N',
  `last_login` datetime NOT NULL default '0000-00-00 00:00:00',
  `last_password_change` datetime NOT NULL default '0000-00-00 00:00:00',
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_by` varchar(32) collate utf8_unicode_ci NOT NULL,
  `updated` datetime NOT NULL default '0000-00-00 00:00:00',
  `updated_by` varchar(32) collate utf8_unicode_ci NOT NULL,
  `note` longtext collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`company_id`,`customers_user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


REPLACE INTO `db_applications` (`app_name`, `app_label`, `app_sequence`, `status_id`, `table_name`, `field_name`, `is_related`, `is_visible`, `is_search`, `is_customizable`, `is_report`, `is_quickadd`, `excluded_tabs`) VALUES 
('backoffice', 'Backoffice', 1, 'A', 'customers', 'company_id', 'Y', 'Y', 'N', 'N', 'N', 'N', ''),
('backoffice_customers', 'Backoffice - Customers', 12, 'S', 'customers', 'company_id', 'Y', 'Y', 'N', 'N', 'N', 'N', ''),
('backoffice_users', 'Backoffice - Users', 12, 'S', 'customers_users', 'user_id', 'Y', 'Y', 'N', 'N', 'N', 'N', ''),
('support', 'Support', 0, 'S', '', '', 'N', 'N', 'N', 'N', 'N', 'N', ''),
('support_tickets', 'Support - Tickets', 5, 'S_L', 'backoffice_support_tickets', 'ticket_id', 'N', 'N', 'N', 'Y', 'N', 'N', ''),
('support_faqs', 'Support - Frequently Asked Questions', 5, 'S_L', 'backoffice_support_faqs', 'faq_id', 'N', 'N', 'N', 'Y', 'N', 'N', '');


REPLACE INTO `db_blocks` (`app_name`, `form_name`, `block_id`, `block_name`, `is_title`, `columns`, `block_sequence`) VALUES 
('backoffice_customers', 'bulk', '20yi8j4rznggs', 'bulk', 'N', 2, 2),
('backoffice_customers', 'edit', '123blnbzwlsgc', 'quotas3', 'N', 2, 10),
('backoffice_customers', 'edit', '1h5b2hr2e5xcs', 'header', 'N', 2, 2),
('backoffice_customers', 'edit', '1lk7h61v6p0gg', 'footer', 'N', 2, 17),
('backoffice_customers', 'edit', '1phv2cd629msg', 'Contact', 'Y', 2, 14),
('backoffice_customers', 'edit', '1zrec6x9e83oc', 'Quotas', 'Y', 1, 6),
('backoffice_customers', 'edit', '20tl0dbks2hw8', 'Note', 'Y', 1, 15),
('backoffice_customers', 'edit', '27xsm2ttt4e8s', 'Edition2', 'N', 2, 5),
('backoffice_customers', 'edit', '2ekjxdf78io0', 'Edition', 'Y', 1, 3),
('backoffice_customers', 'edit', '9hjt8qkdpasc', 'quotas4', 'N', 2, 12),
('backoffice_customers', 'edit', 'anfilk7bg4gk', 'quotas2', 'N', 2, 8),
('backoffice_customers', 'popup_edit', '10a1bnqktvg0s', 'Note', 'Y', 1, 14),
('backoffice_customers', 'popup_edit', '1cfbj43jz0kks', 'footer', 'N', 2, 16),
('backoffice_customers', 'popup_edit', '1hrh8e88qtog4', 'quotas3', 'N', 1, 9),
('backoffice_customers', 'popup_edit', '1k38n3vimby80', 'Edition2', 'N', 2, 5),
('backoffice_customers', 'popup_edit', '1kgsfffozdess', 'quotas2', 'N', 2, 8),
('backoffice_customers', 'popup_edit', '27fbf0mh2phcs', 'quotas4', 'N', 2, 11),
('backoffice_customers', 'popup_edit', 'e057xdxrc5s8', 'header', 'N', 2, 2),
('backoffice_customers', 'popup_edit', 'idta7jmp7tsk', 'Edition', 'Y', 1, 3),
('backoffice_customers', 'popup_edit', 'imfoyjdnpkow', 'Contact', 'Y', 2, 13),
('backoffice_customers', 'popup_edit', 't3d15y43i4g0', 'Quotas', 'Y', 1, 6),
('backoffice_customers', 'popup_view', '19g5lan0yqrok', 'Note', 'N', 1, 8),
('backoffice_customers', 'popup_view', '1bed7oq4h7i8w', 'Contact', 'N', 2, 7),
('backoffice_customers', 'popup_view', '21kok78ykojog', 'Edition2', 'N', 2, 3),
('backoffice_customers', 'popup_view', 'b5wnohu5m800', 'Quotas', 'N', 2, 5),
('backoffice_customers', 'popup_view', 'r1gdybh2huok', 'Edition', 'N', 1, 1),
('backoffice_customers', 'view', '1ig401oix29wo', 'Edition', 'Y', 1, 3),
('backoffice_customers', 'view', '1kz9hk8z06g0o', 'Edition2', 'N', 2, 5),
('backoffice_customers', 'view', '1tqllohts7dww', 'quotas2', 'N', 2, 8),
('backoffice_customers', 'view', '21i7qup3zg3og', 'quotas3', 'N', 2, 10),
('backoffice_customers', 'view', '2avddhhtxqf4', 'quotas4', 'N', 2, 12),
('backoffice_customers', 'view', '4p3gvezeqckk', 'Contact', 'Y', 2, 14),
('backoffice_customers', 'view', 'a66jq43l3q8g', 'Quotas', 'Y', 1, 6),
('backoffice_customers', 'view', 'dp206q490bkg', 'footer', 'N', 2, 17),
('backoffice_customers', 'view', 'r2ols6y16f4w', 'Note', 'Y', 1, 15),
('backoffice_customers', 'view', 't24kkf5eaggs', 'header', 'N', 2, 2),
('backoffice_users', 'bulk', '1atfcs633n8gc', 'Bulk', 'N', 2, 2),
('backoffice_users', 'edit', '13liq4bhcrr4s', 'Header', 'N', 2, 2),
('backoffice_users', 'edit', '1yk209t4vz0k', 'Main', 'N', 2, 4),
('backoffice_users', 'edit', '213fqp77l4748', 'Footer', 'N', 2, 7),
('backoffice_users', 'edit', '2748bu61dse80', 'Note', 'N', 1, 5),
('backoffice_users', 'edit', '3wrp06rmxf0g', 'Password', 'Y', 1, 8),
('backoffice_users', 'popup_view', '1lk7gcsnov0g0', 'Main', 'N', 2, 4),
('backoffice_users', 'popup_view', 'c1xlw4dpvgg0', 'Header', 'N', 2, 2),
('backoffice_users', 'view', '12kkec20xb9cw', 'Footer', 'N', 2, 7),
('backoffice_users', 'view', '1jyb9w4d41348', 'Main', 'N', 2, 4),
('backoffice_users', 'view', '28l74q9dqscgk', 'Header', 'N', 2, 2),
('backoffice_users', 'view', 'rzy0y80pgpw4', 'Note', 'N', 1, 5),
('support_faqs', 'bulk', 'lo2dyy4xm1w4', 'Bulk', 'N', 2, 2),
('support_faqs', 'edit', '1z8x76i8wqxww', 'Note', 'N', 1, 4),
('support_faqs', 'edit', '4xq1vkxgqc0s', 'Header', 'N', 1, 1),
('support_faqs', 'edit', 'bn5ivdwa540g', 'Main', 'N', 2, 3),
('support_faqs', 'edit', 't24qtlchtg0c', 'Footer', 'N', 2, 6),
('support_faqs', 'popup_edit', '1budqhh47la8s', 'Header', 'N', 1, 1),
('support_faqs', 'popup_edit', '1ib6sqac2itc4', 'Note', 'N', 1, 4),
('support_faqs', 'popup_edit', '1pxvkbx6v7ggs', 'Main', 'N', 2, 3),
('support_faqs', 'popup_view', 'cak2c2ycv9s8', 'Main', 'N', 2, 3),
('support_faqs', 'popup_view', 't8agsawnl7kg', 'Header', 'N', 1, 1),
('support_faqs', 'view', '141j8x4nsqcgc', 'Footer', 'N', 2, 6),
('support_faqs', 'view', '19r8qitiobusk', 'Header', 'N', 1, 1),
('support_faqs', 'view', '1hv6bmfw4yv48', 'Main', 'N', 2, 3),
('support_faqs', 'view', 'trzz2kk7iu8g', 'Note', 'N', 1, 4),
('support_tickets', 'bulk', '1a2btyu0dyrog', 'Bulk', 'N', 2, 2),
('support_tickets', 'edit', '1331lx5i9yo04', 'Header', 'N', 1, 1),
('support_tickets', 'edit', '1a3k6g8fr4skk', 'Footer', 'N', 2, 6),
('support_tickets', 'edit', 'hlhf82bs53sc', 'Note', 'N', 1, 4),
('support_tickets', 'edit', 'ucxtqz88t1c0', 'Main', 'N', 2, 3),
('support_tickets', 'popup_edit', '11fx2z360hr4k', 'Note', 'N', 1, 4),
('support_tickets', 'popup_edit', 'ibcndsd8tm8s', 'Header', 'N', 1, 1),
('support_tickets', 'popup_edit', 'miuzp8ixiyo4', 'Main', 'N', 2, 3),
('support_tickets', 'popup_view', '27mpjc01xrfo0', 'Main', 'N', 2, 3),
('support_tickets', 'popup_view', '45e4r22e9okk', 'Header', 'N', 1, 1),
('support_tickets', 'view', '1223a1n1tsogs', 'Note', 'N', 1, 4),
('support_tickets', 'view', '1cdwjf8bx9lw', 'Header', 'N', 1, 1),
('support_tickets', 'view', 'lj50b4cuhcgc', 'Footer', 'N', 2, 6),
('support_tickets', 'view', 'mlbohio1mi8o', 'Main', 'N', 2, 3);


REPLACE INTO `db_fields` (`app_name`, `table_name`, `field_name`, `is_custom`, `is_computed`, `field_type`, `field_label`, `field_height`, `field_default`, `related_table`, `related_id`, `related_name`, `related_filter`, `is_search`, `is_readonly`, `is_mandatory`, `is_unique`, `is_visible`, `search_sequence`, `result_sequence`, `result_class`, `bulk_sequence`, `bulk_side`, `bulk_block_id`, `view_sequence`, `view_side`, `view_block_id`, `edit_sequence`, `edit_side`, `edit_block_id`, `popup_search_sequence`, `popup_result_sequence`, `popup_view_sequence`, `popup_view_side`, `popup_view_block_id`, `popup_edit_sequence`, `popup_edit_side`, `popup_edit_block_id`, `linked_sequence`) VALUES 
('backoffice_customers', 'customers', 'address', 'N', 'N', 'ML', 'Address', 4, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'L', '4p3gvezeqckk', 4, 'L', '1phv2cd629msg', 0, 0, 0, 'L', '1bed7oq4h7i8w', 4, 'L', 'imfoyjdnpkow', 0),
('backoffice_customers', 'customers', 'attachments_count', 'N', 'N', 'NU', 'Attachments count', 1, '', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 3, 'R', '2avddhhtxqf4', 3, 'R', '9hjt8qkdpasc', 0, 0, 0, 'L', 'm1m4llut31so', 3, 'L', '27fbf0mh2phcs', 0),
('backoffice_customers', 'customers', 'attachments_size', 'N', 'N', 'NU', 'Attachments size', 1, '', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 3, 'L', '2avddhhtxqf4', 3, 'L', '9hjt8qkdpasc', 0, 0, 0, 'R', 'm1m4llut31so', 3, 'R', '27fbf0mh2phcs', 0),
('backoffice_customers', 'customers', 'city', 'N', 'N', 'TE', 'City', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'R', '4p3gvezeqckk', 4, 'R', '1phv2cd629msg', 0, 0, 0, 'R', '1bed7oq4h7i8w', 4, 'R', 'imfoyjdnpkow', 0),
('backoffice_customers', 'customers', 'company_alias', 'N', 'N', 'VF', 'Company alias', 1, '', '', '', '', '', 'Y', 'N', 'Y', 'Y', 'Y', 2, 2, 'grid_left', 0, 'L', '', 1, 'R', 't24kkf5eaggs', 1, 'R', '1h5b2hr2e5xcs', 2, 2, 0, 'R', '19l2yv7gdaxw8', 1, 'R', 'e057xdxrc5s8', 2),
('backoffice_customers', 'customers', 'company_id', 'N', 'N', 'RK', 'Company identifier', 1, '0', '', '', '', '', 'N', 'N', 'N', 'Y', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('backoffice_customers', 'customers', 'company_name', 'N', 'N', 'VF', 'Company name', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 1, 1, 'grid_left', 0, 'L', '', 1, 'L', 't24kkf5eaggs', 1, 'L', '1h5b2hr2e5xcs', 1, 1, 0, 'L', '19l2yv7gdaxw8', 1, 'L', 'e057xdxrc5s8', 1),
('backoffice_customers', 'customers', 'company_status', 'N', 'N', 'DD', 'Company status', 1, '', 'customers_statuses', 'status_id', 'status_name', 'where is_available = ''Y'' order by status_name', 'N', 'N', 'Y', 'N', 'Y', 3, 4, 'grid_left', 1, 'L', '20yi8j4rznggs', 2, 'L', 't24kkf5eaggs', 2, 'L', '1h5b2hr2e5xcs', 3, 4, 0, 'L', '19l2yv7gdaxw8', 2, 'L', 'e057xdxrc5s8', 4),
('backoffice_customers', 'customers', 'country_id', 'N', 'N', 'DD', 'Country', 1, '', 'global_countries', 'country_id', 'country_name', ' order by country_name', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 7, 'R', '4p3gvezeqckk', 7, 'R', '1phv2cd629msg', 0, 0, 0, 'R', '1bed7oq4h7i8w', 7, 'R', 'imfoyjdnpkow', 0),
('backoffice_customers', 'customers', 'created', 'N', 'N', 'TS', 'Created', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 9, 'grid_center', 0, 'L', '', 1, 'R', 'dp206q490bkg', 1, 'R', '1lk7h61v6p0gg', 0, 9, 0, 'L', '', 1, 'R', '1cfbj43jz0kks', 9),
('backoffice_customers', 'customers', 'created_by', 'N', 'N', 'DD', 'Created by', 1, '0', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('backoffice_customers', 'customers', 'db_records', 'N', 'N', 'NU', 'Database records', 1, '', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'R', '2avddhhtxqf4', 1, 'R', '9hjt8qkdpasc', 0, 0, 0, 'R', 'm1m4llut31so', 1, 'R', '27fbf0mh2phcs', 0),
('backoffice_customers', 'customers', 'db_size', 'N', 'N', 'NU', 'Database size', 1, '', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'L', '2avddhhtxqf4', 1, 'L', '9hjt8qkdpasc', 0, 0, 0, 'L', 'm1m4llut31so', 1, 'L', '27fbf0mh2phcs', 0),
('backoffice_customers', 'customers', 'disk_quota', 'N', 'N', 'NU', 'Disk quota', 1, '536870912', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'L', '21i7qup3zg3og', 1, 'L', '123blnbzwlsgc', 0, 0, 0, 'L', '1sav9qsyxacgo', 1, 'L', '1hrh8e88qtog4', 0),
('backoffice_customers', 'customers', 'disk_used', 'N', 'N', 'NU', 'Disk used', 1, '0', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'R', '21i7qup3zg3og', 1, 'R', '123blnbzwlsgc', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('backoffice_customers', 'customers', 'documents_count', 'N', 'N', 'NU', 'Documents count', 1, '', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 2, 'R', '2avddhhtxqf4', 2, 'R', '9hjt8qkdpasc', 0, 0, 0, 'L', 'm1m4llut31so', 2, 'L', '27fbf0mh2phcs', 0),
('backoffice_customers', 'customers', 'documents_size', 'N', 'N', 'NU', 'Documents size', 1, '', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 2, 'L', '2avddhhtxqf4', 2, 'L', '9hjt8qkdpasc', 0, 0, 0, 'R', 'm1m4llut31so', 2, 'R', '27fbf0mh2phcs', 0),
('backoffice_customers', 'customers', 'domain_name', 'N', 'N', 'TE', 'Domain name', 1, 'appshore.net', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'R', 't24kkf5eaggs', 0, 'R', '1h5b2hr2e5xcs', 0, 0, 0, 'R', '19l2yv7gdaxw8', 2, 'R', 'e057xdxrc5s8', 0),
('backoffice_customers', 'customers', 'edition_id', 'N', 'N', 'DD', 'Edition', 1, 'TRIAL', 'global_editions', 'edition_id', 'edition_name', ' order by edition_name', 'N', 'N', 'Y', 'N', 'Y', 4, 3, 'grid_left', 1, 'R', '20yi8j4rznggs', 1, 'L', '1ig401oix29wo', 1, 'L', '2ekjxdf78io0', 0, 3, 1, 'L', 'r1gdybh2huok', 1, 'L', 'idta7jmp7tsk', 3),
('backoffice_customers', 'customers', 'edition_name', 'N', 'N', 'TE', 'Edition name', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '1ig401oix29wo', 0, 'L', '2ekjxdf78io0', 4, 0, 0, 'L', 'r1gdybh2huok', 0, 'L', 'idta7jmp7tsk', 0),
('backoffice_customers', 'customers', 'email', 'N', 'N', 'EM', 'Email', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', '4p3gvezeqckk', 3, 'L', '1phv2cd629msg', 0, 0, 2, 'L', '1bed7oq4h7i8w', 3, 'L', 'imfoyjdnpkow', 0),
('backoffice_customers', 'customers', 'employees', 'N', 'N', 'NU', 'Employees', 1, '0', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 4, 'L', 't24kkf5eaggs', 4, 'L', '1h5b2hr2e5xcs', 0, 0, 0, 'R', '19l2yv7gdaxw8', 6, 'R', 'e057xdxrc5s8', 0),
('backoffice_customers', 'customers', 'first_names', 'N', 'N', 'TE', 'First name', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '4p3gvezeqckk', 1, 'L', '1phv2cd629msg', 0, 0, 1, 'L', '1bed7oq4h7i8w', 1, 'L', 'imfoyjdnpkow', 0),
('backoffice_customers', 'customers', 'industry_id', 'N', 'N', 'DD', 'Industry', 1, '0', 'industries', 'industry_id', 'industry_name', ' order by industry_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', 't24kkf5eaggs', 3, 'L', '1h5b2hr2e5xcs', 0, 0, 0, 'R', '19l2yv7gdaxw8', 5, 'R', 'e057xdxrc5s8', 0),
('backoffice_customers', 'customers', 'last_name', 'N', 'N', 'TE', 'Last name', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', '4p3gvezeqckk', 1, 'R', '1phv2cd629msg', 0, 0, 1, 'R', '1bed7oq4h7i8w', 1, 'R', 'imfoyjdnpkow', 0),
('backoffice_customers', 'customers', 'license_time_stamp', 'N', 'N', 'DT', 'License time stamp', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 6, 'grid_center', 0, 'L', '', 1, 'R', '1kz9hk8z06g0o', 1, 'R', '27xsm2ttt4e8s', 0, 6, 1, 'R', '21kok78ykojog', 1, 'R', '1k38n3vimby80', 6),
('backoffice_customers', 'customers', 'note', 'N', 'N', 'ML', 'Note', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', 'r2ols6y16f4w', 1, 'L', '20tl0dbks2hw8', 0, 0, 1, 'L', '19g5lan0yqrok', 1, 'L', '10a1bnqktvg0s', 0),
('backoffice_customers', 'customers', 'password', 'N', 'N', 'TE', 'Password', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('backoffice_customers', 'customers', 'phone', 'N', 'N', 'TE', 'Phone', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'R', '4p3gvezeqckk', 3, 'R', '1phv2cd629msg', 0, 0, 2, 'R', '1bed7oq4h7i8w', 3, 'R', 'imfoyjdnpkow', 0),
('backoffice_customers', 'customers', 'referral_id', 'N', 'N', 'TE', 'Referral identifier', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 6, 'L', 't24kkf5eaggs', 6, 'L', '1h5b2hr2e5xcs', 5, 0, 0, 'R', '19l2yv7gdaxw8', 3, 'R', 'e057xdxrc5s8', 0),
('backoffice_customers', 'customers', 'remote_addr', 'N', 'N', 'TE', 'Remote addr', 1, '', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'R', 't24kkf5eaggs', 0, 'R', '1h5b2hr2e5xcs', 0, 0, 0, 'R', '19l2yv7gdaxw8', 7, 'R', 'e057xdxrc5s8', 0),
('backoffice_customers', 'customers', 'reset_password', 'N', 'Y', 'CH', 'Reset password', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 3, 'L', '13qfxwi7vfi8w', 0, 'L', '', 8, 'R', '1phv2cd629msg', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('backoffice_customers', 'customers', 'send_welcome_email', 'N', 'Y', 'CH', 'Send welcome email', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 2, 'L', '13qfxwi7vfi8w', 0, 'L', '', 5, 'L', '1phv2cd629msg', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('backoffice_customers', 'customers', 'state_id', 'N', 'N', 'DD', 'State', 1, '', 'global_countries_states', 'state_id', 'state_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 6, 'R', '4p3gvezeqckk', 6, 'R', '1phv2cd629msg', 0, 0, 0, 'R', '1bed7oq4h7i8w', 6, 'R', 'imfoyjdnpkow', 0),
('backoffice_customers', 'customers', 'title', 'N', 'N', 'TE', 'Title', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', '4p3gvezeqckk', 2, 'R', '1phv2cd629msg', 0, 0, 0, 'R', '1bed7oq4h7i8w', 2, 'R', 'imfoyjdnpkow', 0),
('backoffice_customers', 'customers', 'training', 'N', 'N', 'CH', 'Training', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 8, 'grid_center', 0, 'L', '', 5, 'L', 't24kkf5eaggs', 5, 'L', '1h5b2hr2e5xcs', 6, 8, 0, 'R', '19l2yv7gdaxw8', 4, 'R', 'e057xdxrc5s8', 8),
('backoffice_customers', 'customers', 'due_date', 'N', 'N', 'DA', 'Trial due', 1, '0000-00-00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 7, 'grid_center', 0, 'L', '', 1, 'L', '1kz9hk8z06g0o', 1, 'L', '27xsm2ttt4e8s', 0, 7, 1, 'L', '21kok78ykojog', 1, 'L', '1k38n3vimby80', 7),
('backoffice_customers', 'customers', 'updated', 'N', 'N', 'TS', 'Updated', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'L', 'dp206q490bkg', 1, 'L', '1lk7h61v6p0gg', 0, 0, 0, 'L', '', 1, 'L', '1cfbj43jz0kks', 0),
('backoffice_customers', 'customers', 'updated_by', 'N', 'N', 'DD', 'Updated by', 1, '0', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('backoffice_customers', 'customers', 'url', 'N', 'N', 'WS', 'Web site', 5, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 2, 'R', 't24kkf5eaggs', 2, 'R', '1h5b2hr2e5xcs', 0, 0, 0, 'L', '', 3, 'L', 'e057xdxrc5s8', 0),
('backoffice_customers', 'customers', 'user_id', 'N', 'N', 'TE', 'User identifier', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('backoffice_customers', 'customers', 'user_name', 'N', 'N', 'TE', 'User name', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', '4p3gvezeqckk', 2, 'L', '1phv2cd629msg', 0, 0, 0, 'L', '1bed7oq4h7i8w', 2, 'L', 'imfoyjdnpkow', 0),
('backoffice_customers', 'customers', 'users_activated', 'N', 'N', 'NU', 'Users activated', 1, '', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'R', '1tqllohts7dww', 1, 'R', 'anfilk7bg4gk', 0, 0, 0, 'R', '9mh6040uthc0', 1, 'R', '1kgsfffozdess', 0),
('backoffice_customers', 'customers', 'users_count', 'N', 'N', 'NU', 'Users count', 1, '', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'L', '1tqllohts7dww', 1, 'L', 'anfilk7bg4gk', 0, 0, 1, 'R', 'b5wnohu5m800', 1, 'L', '1kgsfffozdess', 0),
('backoffice_customers', 'customers', 'users_quota', 'N', 'N', 'NU', 'Users quota', 1, '10', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 0, 5, 'grid_right', 0, 'L', '', 1, 'L', 'a66jq43l3q8g', 1, 'L', '1zrec6x9e83oc', 0, 5, 1, 'L', 'b5wnohu5m800', 1, 'L', 't3d15y43i4g0', 5),
('backoffice_customers', 'customers', 'zipcode', 'N', 'N', 'TE', 'Zipcode', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 5, 'R', '4p3gvezeqckk', 5, 'R', '1phv2cd629msg', 0, 0, 0, 'R', '1bed7oq4h7i8w', 5, 'R', 'imfoyjdnpkow', 0),
('backoffice_users', 'customers_users', 'app_name', 'N', 'N', 'DD', 'Default Application', 1, 'api', 'db_applications', 'app_name', 'app_label', 'where is_visible = "Y" and status_id = "A" order by app_label', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('backoffice_users', 'customers_users', 'assistant_id', 'N', 'N', 'RR', 'Assistant', 1, '', 'customers_users', 'customers_user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'R', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'R', '', 6, 'R', '', 0),
('backoffice_users', 'customers_users', 'birthdate', 'N', 'N', 'DA', 'Date of Birth', 1, '0000-00-00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('backoffice_users', 'customers_users', 'company_id', 'N', 'N', 'DD', 'Company Alias', 1, '', 'customers', 'company_id', 'company_name', 'order by company_name', 'N', 'Y', 'N', 'Y', 'Y', 1, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 1, 0, 0, 'L', '', 0, 'L', '', 0),
('backoffice_users', 'customers_users', 'confirm_delete', 'N', 'N', 'CH', 'Confirm Delete', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'R', '', 0, 'R', '', 0),
('backoffice_users', 'customers_users', 'created', 'N', 'N', 'TS', 'Created', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 2, 'L', '12kkec20xb9cw', 2, 'L', '213fqp77l4748', 0, 0, 0, 'L', 'u4bdb0v3phwo', 0, 'L', '', 0),
('backoffice_users', 'customers_users', 'created_by', 'N', 'N', 'RR', 'Created by', 1, '', 'customers_users', 'customers_user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '12kkec20xb9cw', 0, 'L', '213fqp77l4748', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('backoffice_users', 'customers_users', 'currency_id', 'N', 'N', 'DD', 'Currency', 1, 'USD', 'global_currencies', 'currency_id', 'currency_name', ' order by currency_name', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'R', '', 0, 'R', '', 0),
('backoffice_users', 'customers_users', 'customers_user_id', 'N', 'N', 'RK', 'User identifier', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('backoffice_users', 'customers_users', 'customers_user_name', 'N', 'N', 'VF', 'User Name', 1, '', '', '', '', '', 'N', 'N', 'Y', 'Y', 'Y', 2, 1, 'grid_left', 0, 'L', '', 1, 'L', '28l74q9dqscgk', 1, 'L', '13liq4bhcrr4s', 2, 1, 1, 'L', 'c1xlw4dpvgg0', 1, 'L', '', 1),
('backoffice_users', 'customers_users', 'department_id', 'N', 'N', 'RR', 'Department', 1, '', 'departments', 'department_id', 'department_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'R', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'R', '', 4, 'R', '', 4),
('backoffice_users', 'customers_users', 'email', 'N', 'N', 'WM', 'Email', 1, '', '', '', '', '', 'N', 'N', 'Y', 'Y', 'Y', 5, 6, 'grid_left', 0, 'L', '', 2, 'L', '1jyb9w4d41348', 2, 'L', '1yk209t4vz0k', 0, 6, 2, 'L', '1lk7gcsnov0g0', 5, 'L', '', 7),
('backoffice_users', 'customers_users', 'fax', 'N', 'N', 'TE', 'Fax', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'R', '1jyb9w4d41348', 3, 'R', '1yk209t4vz0k', 0, 0, 3, 'R', '1lk7gcsnov0g0', 6, 'L', '', 0),
('backoffice_users', 'customers_users', 'first_names', 'N', 'N', 'VF', 'First Name', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 3, 2, 'grid_left', 0, 'L', '', 1, 'L', '1jyb9w4d41348', 1, 'L', '1yk209t4vz0k', 3, 2, 1, 'L', '1lk7gcsnov0g0', 1, 'L', '', 2),
('backoffice_users', 'customers_users', 'full_name', 'N', 'N', 'TE', 'Full Name', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('backoffice_users', 'customers_users', 'is_salespeople', 'N', 'N', 'CH', 'Sales People', 1, 'N', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'R', '', 3, 'R', '', 0),
('backoffice_users', 'customers_users', 'language_id', 'N', 'N', 'DD', 'Language', 1, 'en', 'global_languages', 'language_id', 'language_name', ' order by language_name', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'R', '', 0, 'R', '', 0),
('backoffice_users', 'customers_users', 'last_login', 'N', 'N', 'TS', 'Last Login', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 7, 'grid_center', 0, 'L', '', 1, 'L', '12kkec20xb9cw', 1, 'L', '213fqp77l4748', 0, 7, 2, 'L', 'c1xlw4dpvgg0', 0, 'L', '', 0),
('backoffice_users', 'customers_users', 'last_name', 'N', 'N', 'VF', 'Last Name', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 4, 3, 'grid_left', 0, 'L', '', 1, 'R', '1jyb9w4d41348', 1, 'R', '1yk209t4vz0k', 4, 3, 1, 'R', '1lk7gcsnov0g0', 1, 'R', '', 3),
('backoffice_users', 'customers_users', 'last_password_change', 'N', 'N', 'TS', 'Last Password Change', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 8, 'grid_center', 0, 'L', '', 1, 'R', '12kkec20xb9cw', 1, 'R', '213fqp77l4748', 0, 8, 2, 'R', 'c1xlw4dpvgg0', 0, 'L', '', 0),
('backoffice_users', 'customers_users', 'locale_id', 'N', 'N', 'DD', 'Locale', 1, 'en_US', 'global_locales', 'locale_id', 'locale_name', ' order by locale_name', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('backoffice_users', 'customers_users', 'manager_id', 'N', 'N', 'RR', 'Manager', 1, '', 'customers_users', 'customers_user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'R', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'R', '', 5, 'R', '', 0),
('backoffice_users', 'customers_users', 'mobile', 'N', 'N', 'TE', 'Mobile', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 5, 'grid_left', 0, 'L', '', 2, 'R', '1jyb9w4d41348', 2, 'R', '1yk209t4vz0k', 0, 5, 2, 'R', '1lk7gcsnov0g0', 3, 'L', '', 6),
('backoffice_users', 'customers_users', 'nbrecords', 'N', 'N', 'DD', 'Lines displayed', 1, '10', 'global_lines', 'line_id', 'line_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('backoffice_users', 'customers_users', 'note', 'N', 'N', 'ML', 'Note', 5, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', 'rzy0y80pgpw4', 1, 'L', '2748bu61dse80', 0, 0, 0, 'L', '1l94ctip13tws', 1, 'L', '', 0),
('backoffice_users', 'customers_users', 'password', 'N', 'N', 'TE', 'Password', 1, '', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('backoffice_users', 'customers_users', 'phone', 'N', 'N', 'TE', 'Phone', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 4, 'grid_left', 0, 'L', '', 3, 'L', '1jyb9w4d41348', 3, 'L', '1yk209t4vz0k', 0, 4, 3, 'L', '1lk7gcsnov0g0', 4, 'L', '', 5),
('backoffice_users', 'customers_users', 'private_email', 'N', 'N', 'WM', 'Private Email', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'R', '', 0, 'R', '', 0),
('backoffice_users', 'customers_users', 'private_mobile', 'N', 'N', 'TE', 'Private Mobile', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'R', '', 0, 'R', '', 0),
('backoffice_users', 'customers_users', 'private_phone', 'N', 'N', 'TE', 'Private Phone', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('backoffice_users', 'customers_users', 'reset_password', 'N', 'Y', 'CH', 'Reset password', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 1, 'L', '1atfcs633n8gc', 0, 'L', '', 1, 'L', '3wrp06rmxf0g', 0, 0, 0, 'R', '', 0, 'R', '', 0),
('backoffice_users', 'customers_users', 'salutation', 'N', 'N', 'TE', 'Salutation', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 2, 'L', '', 0),
('backoffice_users', 'customers_users', 'send_welcome_email', 'N', 'Y', 'CH', 'Send welcome email', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'R', '', 0, 'R', '', 0),
('backoffice_users', 'customers_users', 'skin_id', 'N', 'N', 'DD', 'Skin', 1, 'default', 'global_skins', 'skin_id', 'skin_name', ' order by skin_name', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('backoffice_users', 'customers_users', 'status_id', 'N', 'N', 'DD', 'User status', 1, 'A', 'users_statuses', 'status_id', 'status_name', 'where status_id in ("A","D") order by status_name', 'N', 'N', 'Y', 'N', 'Y', 6, 9, 'grid_left', 1, 'R', '1atfcs633n8gc', 1, 'R', '28l74q9dqscgk', 1, 'R', '13liq4bhcrr4s', 5, 9, 1, 'R', 'c1xlw4dpvgg0', 0, 'R', '', 8),
('backoffice_users', 'customers_users', 'theme_id', 'N', 'N', 'DD', 'Theme', 1, 'default', 'global_themes', 'theme_id', 'theme_name', ' order by theme_name', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'R', '', 0, 'R', '', 0),
('backoffice_users', 'customers_users', 'timezone_id', 'N', 'N', 'DD', 'Timezone', 1, '225', 'global_timezones', 'timezone_id', 'timezone_name', ' order by timezone_name', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('backoffice_users', 'customers_users', 'title', 'N', 'N', 'TE', 'Title', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'R', '', 2, 'R', '', 0),
('backoffice_users', 'customers_users', 'updated', 'N', 'N', 'TS', 'Updated', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 2, 'R', '12kkec20xb9cw', 2, 'R', '213fqp77l4748', 0, 0, 0, 'R', 'u4bdb0v3phwo', 0, 'L', '', 0),
('backoffice_users', 'customers_users', 'updated_by', 'N', 'N', 'RR', 'Updated by', 1, '', 'customers_users', 'customers_user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'R', '12kkec20xb9cw', 0, 'R', '213fqp77l4748', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('support_faqs', 'backoffice_support_faqs', 'category_id', 'N', 'N', 'DD', 'Category', 1, '', 'backoffice_support_faqs_categories', 'category_id', 'category_name', 'order by category_sequence', 'N', 'Y', 'Y', 'N', 'Y', 2, 2, 'grid_left', 1, 'L', 'lo2dyy4xm1w4', 1, 'L', '1hv6bmfw4yv48', 1, 'L', 'bn5ivdwa540g', 2, 2, 1, 'L', 'cak2c2ycv9s8', 1, 'L', '1pxvkbx6v7ggs', 2),
('support_faqs', 'backoffice_support_faqs', 'created', 'N', 'N', 'TS', 'Created', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'L', '141j8x4nsqcgc', 1, 'L', 't24qtlchtg0c', 0, 0, 0, 'L', '18ld15zxsvk04', 1, 'L', '11zmlcmb3bdww', 0),
('support_faqs', 'backoffice_support_faqs', 'created_by', 'N', 'N', 'DD', 'Created by', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('support_faqs', 'backoffice_support_faqs', 'edition_id', 'N', 'N', 'DD', 'Edition', 1, '', 'global_editions', 'edition_id', 'edition_name', '', 'N', 'N', 'N', 'N', 'Y', 3, 3, 'grid_left', 1, 'R', 'lo2dyy4xm1w4', 1, 'R', '1hv6bmfw4yv48', 1, 'R', 'bn5ivdwa540g', 3, 3, 1, 'R', 'cak2c2ycv9s8', 1, 'R', '1pxvkbx6v7ggs', 3),
('support_faqs', 'backoffice_support_faqs', 'faq_id', 'N', 'N', 'RK', 'Faq identifier', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('support_faqs', 'backoffice_support_faqs', 'is_active', 'N', 'N', 'CH', 'Is active', 1, 'A', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 2, 'L', 'lo2dyy4xm1w4', 0, 'L', '', 2, 'L', 'bn5ivdwa540g', 0, 0, 0, 'L', '', 2, 'R', '1pxvkbx6v7ggs', 0),
('support_faqs', 'backoffice_support_faqs', 'note', 'N', 'N', 'ML', 'Note', 20, '', '', '', '', '', 'Y', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'L', 'trzz2kk7iu8g', 1, 'L', '1z8x76i8wqxww', 0, 0, 0, 'L', 'vitj3t2oglws', 1, 'L', '1ib6sqac2itc4', 0),
('support_faqs', 'backoffice_support_faqs', 'subject', 'N', 'N', 'VF', 'Subject', 1, '', '', '', '', '', 'Y', 'N', 'Y', 'N', 'Y', 1, 1, 'grid_left', 0, 'L', '', 1, 'L', '19r8qitiobusk', 1, 'L', '4xq1vkxgqc0s', 1, 1, 1, 'L', 't8agsawnl7kg', 1, 'L', '1budqhh47la8s', 1),
('support_faqs', 'backoffice_support_faqs', 'updated', 'N', 'N', 'TS', 'Updated', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'R', '141j8x4nsqcgc', 1, 'R', 't24qtlchtg0c', 0, 0, 0, 'L', '', 1, 'R', '11zmlcmb3bdww', 0),
('support_faqs', 'backoffice_support_faqs', 'updated_by', 'N', 'N', 'DD', 'Updated by', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'R', '141j8x4nsqcgc', 0, 'R', 't24qtlchtg0c', 0, 0, 0, 'R', '18ld15zxsvk04', 0, 'L', '', 0),
('support_faqs', 'backoffice_support_faqs', 'user_id', 'N', 'N', 'DD', 'Owner', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 2, 'R', 'lo2dyy4xm1w4', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('support_tickets', 'backoffice_support_tickets', 'category_id', 'N', 'N', 'DD', 'Category', 1, '', 'backoffice_support_tickets_categories', 'category_id', 'category_name', 'order by category_sequence', 'N', 'N', 'Y', 'N', 'Y', 2, 3, 'grid_left', 1, 'R', '1a2btyu0dyrog', 1, 'L', 'mlbohio1mi8o', 1, 'L', 'ucxtqz88t1c0', 2, 3, 1, 'L', '27mpjc01xrfo0', 1, 'L', 'miuzp8ixiyo4', 3),
('support_tickets', 'backoffice_support_tickets', 'company_id', 'N', 'N', 'RR', 'Company identifier', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('support_tickets', 'backoffice_support_tickets', 'created', 'N', 'N', 'TS', 'Created', 1, '', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'L', 'lj50b4cuhcgc', 1, 'L', '1a3k6g8fr4skk', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('support_tickets', 'backoffice_support_tickets', 'created_by', 'N', 'N', 'RR', 'Created by', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('support_tickets', 'backoffice_support_tickets', 'due_date', 'N', 'N', 'DA', 'Due date', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 3, 'L', '1a2btyu0dyrog', 3, 'R', 'mlbohio1mi8o', 3, 'R', 'ucxtqz88t1c0', 0, 0, 3, 'R', '27mpjc01xrfo0', 3, 'R', 'miuzp8ixiyo4', 0),
('support_tickets', 'backoffice_support_tickets', 'edition_id', 'N', 'N', 'DD', 'Edition', 1, '', 'global_editions', 'edition_id', 'edition_name', '', 'N', 'N', 'N', 'N', 'Y', 3, 4, 'grid_left', 2, 'R', '1a2btyu0dyrog', 1, 'R', 'mlbohio1mi8o', 1, 'R', 'ucxtqz88t1c0', 3, 4, 1, 'R', '27mpjc01xrfo0', 1, 'R', 'miuzp8ixiyo4', 4),
('support_tickets', 'backoffice_support_tickets', 'email', 'N', 'N', 'TE', 'Email', 1, '', '', '', '', '', 'Y', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', 'mlbohio1mi8o', 2, 'R', 'ucxtqz88t1c0', 0, 0, 2, 'R', '27mpjc01xrfo0', 2, 'R', 'miuzp8ixiyo4', 0),
('support_tickets', 'backoffice_support_tickets', 'note', 'N', 'N', 'ML', 'Note', 15, '', '', '', '', '', 'Y', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '1223a1n1tsogs', 1, 'L', 'hlhf82bs53sc', 0, 0, 0, 'L', '27gjtdaiok4k4', 1, 'L', '11fx2z360hr4k', 0),
('support_tickets', 'backoffice_support_tickets', 'historic', 'N', 'N', 'ML', 'Historic', 25, '', '', '', '', '', 'Y', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '1223a1n1tsogs', 1, 'L', 'hlhf82bs53sc', 0, 0, 0, 'L', '27gjtdaiok4k4', 1, 'L', '11fx2z360hr4k', 0),
('support_tickets', 'backoffice_support_tickets', 'priority_id', 'N', 'N', 'DD', 'Priority', 1, '', 'backoffice_support_tickets_priorities', 'priority_id', 'priority_name', '', 'N', 'N', 'N', 'N', 'Y', 5, 5, 'grid_left', 2, 'L', '1a2btyu0dyrog', 3, 'L', 'mlbohio1mi8o', 3, 'L', 'ucxtqz88t1c0', 5, 5, 3, 'L', '27mpjc01xrfo0', 3, 'L', 'miuzp8ixiyo4', 5),
('support_tickets', 'backoffice_support_tickets', 'status_id', 'N', 'N', 'DD', 'Status', 1, '', 'backoffice_support_tickets_statuses', 'status_id', 'status_name', '', 'N', 'N', 'N', 'N', 'Y', 4, 1, 'grid_left', 1, 'L', '1a2btyu0dyrog', 2, 'L', 'mlbohio1mi8o', 2, 'L', 'ucxtqz88t1c0', 4, 1, 2, 'L', '27mpjc01xrfo0', 2, 'L', 'miuzp8ixiyo4', 1),
('support_tickets', 'backoffice_support_tickets', 'subject', 'N', 'N', 'VF', 'Subject', 1, '', '', '', '', '', 'Y', 'N', 'Y', 'N', 'Y', 1, 2, 'grid_left', 0, 'L', '', 1, 'L', '1cdwjf8bx9lw', 1, 'L', '1331lx5i9yo04', 1, 2, 1, 'L', '45e4r22e9okk', 1, 'L', 'ibcndsd8tm8s', 2),
('support_tickets', 'backoffice_support_tickets', 'ticket_id', 'N', 'N', 'RK', 'Ticket identifier', 1, '', '', '', '', '', 'N', 'Y', 'N', 'Y', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'R', 'mlbohio1mi8o', 0, 'R', 'ucxtqz88t1c0', 0, 0, 0, 'R', '27mpjc01xrfo0', 0, 'R', 'miuzp8ixiyo4', 0),
('support_tickets', 'backoffice_support_tickets', 'updated', 'N', 'N', 'TS', 'Updated', 1, '', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 6, 'grid_center', 0, 'L', '', 1, 'R', 'lj50b4cuhcgc', 1, 'R', '1a3k6g8fr4skk', 0, 6, 0, 'L', '', 0, 'L', '', 6),
('support_tickets', 'backoffice_support_tickets', 'updated_by', 'N', 'N', 'RR', 'Updated by', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('support_tickets', 'backoffice_support_tickets', 'user_id', 'N', 'N', 'DD', 'Owner', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 6, 7, 'grid_left', 3, 'R', '1a2btyu0dyrog', 0, 'L', '', 0, 'L', '', 6, 7, 0, 'L', '', 0, 'L', '', 7);


REPLACE INTO `db_lookups` (`table_name`, `table_label`, `app_name`, `class_name`, `is_custom`, `is_customizable`, `lookup_id`, `lookup_name`, `lookup_value`, `lookup_comment`) VALUES 
('customers_statuses', 'Customers Statuses', '', '', 'N', 'N', 'status_id', 'status_name', '', '');


REPLACE INTO `permissions` ( `role_id` , `app_name` , `level` , `import` , `export` ) VALUES 
('admin', 'backoffice', '127', '0', '0');


REPLACE INTO `roles` (`role_id`, `role_name`, `role_label`, `status_id`, `created`, `created_by`, `updated`, `updated_by`) VALUES 
('admin', 'Administration', 'This role can''t be deleted and permissions can''t be changed. At least one user must be granted this role.', 'S', '2004-09-10 14:25:23', '1', '2007-10-30 10:34:38', '1'),
('standard', 'Every Employee', 'Standard role for each employee', 'A', '2004-09-10 14:27:00', '1', '2007-11-09 08:31:32', '1');


CREATE TABLE IF NOT EXISTS `support_editions` (
  `edition_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `edition_name` varchar(250) collate utf8_unicode_ci NOT NULL,
  `edition_sequence` int(11) NOT NULL default '0',
  PRIMARY KEY  (`edition_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `support_editions` (`edition_id`, `edition_name`, `edition_sequence`) VALUES
('pro_v1.1', 'Professional v1.1', 1),
('pro_v2.1', 'Professional v2.1', 2),
('pre_v2.1', 'Premium v2.1', 3);

DROP TABLE IF EXISTS `support_faqs`;
CREATE TABLE IF NOT EXISTS `support_faqs` (
  `faq_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `user_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `subject` varchar(250) collate utf8_unicode_ci NOT NULL,
  `edition_id` varchar(32) collate utf8_unicode_ci NOT NULL, 
  `category_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `is_active` enum('A','D') collate utf8_unicode_ci NOT NULL default 'A',
  `note` longtext collate utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `created_by` varchar(32) collate utf8_unicode_ci NOT NULL,
  `updated` datetime NOT NULL,
  `updated_by` varchar(32) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`faq_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `support_faqs_categories`;
CREATE TABLE IF NOT EXISTS `support_faqs_categories` (
  `category_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `category_name` varchar(250) collate utf8_unicode_ci NOT NULL,
  `category_sequence` int(11) NOT NULL default '0',
  PRIMARY KEY  (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `support_faqs_categories`
-- 

INSERT INTO `support_faqs_categories` (`category_id`, `category_name`, `category_sequence`) VALUES 
('Applications', '***** Applications *****', 1),
('Applications-Accounts', 'Accounts', 10),
('Applications-Activities', 'Activities', 11),
('Applications-Campaigns', 'Campaigns', 12),
('Applications-Cases', 'Cases', 13),
('Applications-Contacts', 'Contacts', 14),
('Applications-Dashboard', 'Dashboard', 15),
('Applications-Documents', 'Documents', 16),
('Applications-Forecasts', 'Forecasts', 17),
('Applications-Leads', 'Leads', 18),
('Applications-Opportunities', 'Opportunities', 19),
('Applications-Reports', 'Reports', 20),
('Applications-Webmail', 'Webmail', 21),
('Administration', '***** Administration *****', 100),
('Administration-Company', 'Company', 101),
('Administration-Departments', 'Departments', 102),
('Administration-Roles', 'Roles', 103),
('Administration-Sales', 'Sales organization', 104),
('Administration-Users', 'Users', 105),
('Administration-Applications', 'Applications', 106),
('Administration-Customization', 'Customization', 107),
('Browsers', '***** Web Browsers *****', 200),
('Browser-IE', 'Internet Explorer', 202),
('Browser-FF', 'Firefox', 201),
('Browser-Others', 'Opera - Safari - Others', 203);


DROP TABLE IF EXISTS `support_tickets`;
CREATE TABLE IF NOT EXISTS `support_tickets` (
  `ticket_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `company_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `user_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `email` varchar(250) collate utf8_unicode_ci NOT NULL,
  `subject` varchar(250) collate utf8_unicode_ci NOT NULL,
  `edition_id` varchar(32) collate utf8_unicode_ci NOT NULL, 
  `status_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `priority_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `category_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `due_date` date NOT NULL,
  `note` longtext collate utf8_unicode_ci NOT NULL,
  `historic` longtext collate utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `created_by` varchar(32) collate utf8_unicode_ci NOT NULL,
  `updated` datetime NOT NULL,
  `updated_by` varchar(32) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`ticket_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `support_tickets_categories`;
CREATE TABLE IF NOT EXISTS `support_tickets_categories` (
  `category_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `category_name` varchar(250) collate utf8_unicode_ci NOT NULL,
  `category_email` varchar(250) collate utf8_unicode_ci NOT NULL,
  `category_sequence` int(11) NOT NULL default '0',
  PRIMARY KEY  (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


INSERT INTO `support_tickets_categories` (`category_id`, `category_name`, `category_email`, `category_sequence`) VALUES
('Support', 'Technical support', 'support@appshore.com', 1),
('Sales', 'Sales, account, billing', 'sales@appshore.com', 2),
('Training', 'Request training', 'training@appshore.com', 3),
('Feature', 'Request new feature', 'support@appshore.com', 4);


DROP TABLE IF EXISTS `support_tickets_priorities`;
CREATE TABLE IF NOT EXISTS `support_tickets_priorities` (
  `priority_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `priority_name` varchar(250) collate utf8_unicode_ci NOT NULL,
  `priority_sequence` int(11) NOT NULL default '0',
  PRIMARY KEY  (`priority_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `support_tickets_priorities` (`priority_id`, `priority_name`, `priority_sequence`) VALUES
('LE', 'Lowest', 1),
('LO', 'Low', 2),
('NO', 'Normal', 3),
('HI', 'High', 4),
('HE', 'Highest', 5);

DROP TABLE IF EXISTS `support_tickets_statuses`;
CREATE TABLE IF NOT EXISTS `support_tickets_statuses` (
  `status_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `status_name` varchar(250) collate utf8_unicode_ci NOT NULL,
  `status_sequence` int(11) NOT NULL default '0',
  PRIMARY KEY  (`status_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `support_tickets_statuses` (`status_id`, `status_name`, `status_sequence`) VALUES
('NE', 'New', 1),
('AS', 'Assigned', 2),
('IP', 'In progress', 3),
('CL', 'Closed', 4),
('RE', 'Rejected', 5);


REPLACE INTO `users` (`user_id`, `user_name`, `password`, `salutation`, `last_name`, `first_names`, `full_name`, `title`, `manager_id`, `assistant_id`, `department_id`, `locale_id`, `language_id`, `currency_id`, `timezone_id`, `skin_id`, `theme_id`, `app_name`, `nbrecords`, `confirm_delete`, `email`, `phone`, `mobile`, `fax`, `private_phone`, `private_mobile`, `private_email`, `birthdate`, `status_id`, `is_salespeople`, `last_login`, `last_password_change`, `created`, `created_by`, `updated`, `updated_by`, `note`) VALUES 
('1', 'backoffice', '9d218e45ca25e53056ea3ce0e59f1094', '', 'Backoffice Administration', 'AppShore', 'AppShore Backoffice Administration', '', '', '', '', 'en_US', 'en', 'USD', '230', 'default', 'default', 'backoffice', 15, 'Y', 'backoffice@appshore.com', '', '', '', '', '', '', '0000-00-00', 'A', 'N', '2008-04-01 04:30:06', '2008-03-10 15:19:16', '0000-00-00 00:00:00', '0', '2008-03-30 07:57:56', '1', 'DO NOT CHANGE USERNAME, EMAIL or PASSWORD.'),
('2', 'admin', 'a7e639c26db389c3a9623d5c46c3af33', '', 'Administrator', 'Backoffice', 'Backoffice Administrator', '', '', '', '', 'en_US', 'en', 'USD', '237', 'default', 'default', 'backoffice', 25, 'Y', 'admin@appshore.com', '', '', '', '', '', '', '0000-00-00', 'A', 'N', '2008-03-31 11:41:07', '0000-00-00 00:00:00', '2008-03-30 07:54:59', '1', '2008-03-30 07:54:59', '1', '');


REPLACE INTO `users_roles` (`user_id`, `role_id`) VALUES 
('1', 'admin'),
('2', 'admin');

