

DROP TABLE IF EXISTS `accounts`;
CREATE TABLE IF NOT EXISTS `accounts` (
  `account_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `account_top_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `source_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `industry_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `type_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `rating_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `account_number` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `account_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `account_code` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `legal_status` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `ticket_symbol` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `tax_id` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `fax` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `email_opt_out` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `do_not_call` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `employees` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `revenue` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `created_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `updated` datetime NOT NULL,
  `updated_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `note` longtext COLLATE utf8_unicode_ci NOT NULL,
  `address_billing` longtext COLLATE utf8_unicode_ci NOT NULL,
  `zipcode_billing` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `city_billing` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `state_billing` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `country_billing` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `address_shipping` longtext COLLATE utf8_unicode_ci NOT NULL,
  `zipcode_shipping` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `city_shipping` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `state_shipping` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `country_shipping` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`account_id`),
  KEY `user_id` (`user_id`),
  KEY `account_name` (`account_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `activities`;
CREATE TABLE IF NOT EXISTS `activities` (
  `activity_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `is_private` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `is_open` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  `is_allday` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `status_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `type_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `subject` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `location` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `note` longtext COLLATE utf8_unicode_ci NOT NULL,
  `priority_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `account_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `contact_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `activity_start` datetime NOT NULL,
  `activity_end` datetime NOT NULL,
  `reminder_email` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `reminder_popup` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`activity_id`),
  KEY `user_id` (`user_id`),
  KEY `subject` (`subject`(10))
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `activities_preferences`;
CREATE TABLE IF NOT EXISTS `activities_preferences` (
  `user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `day_start_hour` int(11) NOT NULL DEFAULT '28800',
  `day_end_hour` int(11) NOT NULL DEFAULT '64800',
  `tab_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'activities',
  `inc_hour` int(11) NOT NULL DEFAULT '1800',
  `reminder_email` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '.',
  `reminder_popup` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '.',
  `first_day_week` tinyint(4) NOT NULL DEFAULT '1',
  `days_per_week` tinyint(4) NOT NULL DEFAULT '7',
  `priority_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'NO',
  `status_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'SC',
  `type_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'CA',
  `duration` int(11) NOT NULL DEFAULT '3600',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `activities_priorities`;
CREATE TABLE IF NOT EXISTS `activities_priorities` (
  `priority_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `priority_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `priority_sequence` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`priority_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `activities_priorities` (`priority_id`, `priority_name`, `priority_sequence`) VALUES
('LE', 'Lowest', 1),
('LO', 'Low', 2),
('NO', 'Normal', 3),
('HI', 'High', 4),
('HE', 'Highest', 5);

DROP TABLE IF EXISTS `activities_statuses`;
CREATE TABLE IF NOT EXISTS `activities_statuses` (
  `status_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `status_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `status_sequence` int(11) NOT NULL DEFAULT '0',
  `is_open` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`status_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `activities_statuses` (`status_id`, `status_name`, `status_sequence`, `is_open`) VALUES
('CA', 'Canceled', 1, 'N'),
('CL', 'Closed activities', 2, 'N'),
('CO', 'Completed', 3, 'N'),
('DE', 'Deferred', 4, 'Y'),
('HE', 'Held', 5, 'Y'),
('IP', 'In progress', 6, 'Y'),
('NT', 'Not started', 7, 'N'),
('OP', 'Open activities', 8, 'Y'),
('PE', 'Pending', 9, 'Y'),
('RE', 'Rescheduled', 10, 'Y'),
('SC', 'Scheduled', 11, 'Y');

DROP TABLE IF EXISTS `activities_types`;
CREATE TABLE IF NOT EXISTS `activities_types` (
  `type_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `type_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `activities_types` (`type_id`, `type_name`) VALUES
('CA', 'Call'),
('ME', 'Meeting'),
('TA', 'Task'),
('EV', 'Event'),
('VA', 'Vacation'),
('LE', 'Leave');

DROP TABLE IF EXISTS `campaigns`;
CREATE TABLE IF NOT EXISTS `campaigns` (
  `campaign_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `status_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `campaign_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `from_email` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `from_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `type_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `list_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `subject` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `body_text` longtext COLLATE utf8_unicode_ci NOT NULL,
  `body_html` longtext COLLATE utf8_unicode_ci NOT NULL,
  `note` longtext COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `created_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `updated` datetime NOT NULL,
  `updated_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`campaign_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `campaigns_fields`;
CREATE TABLE IF NOT EXISTS `campaigns_fields` (
  `field_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `field_label` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `lookup_source` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `lookup_target` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`field_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `campaigns_fields` (`field_name`, `field_label`, `lookup_source`, `lookup_target`) VALUES
('first_names', 'First Name', '', ''),
('last_name', 'Last Name', '', ''),
('email', 'Email', '', ''),
('salutation', 'Salutation', '', ''),
('account_name', 'Company Name', '', ''),
('mobile', 'Mobile', '', ''),
('phone', 'Phone', '', '');

DROP TABLE IF EXISTS `campaigns_history`;
CREATE TABLE IF NOT EXISTS `campaigns_history` (
  `campaign_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `list_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `records` int(11) NOT NULL DEFAULT '0',
  `rejected` int(11) NOT NULL DEFAULT '0',
  `note` longtext COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  KEY `campaign_id` (`campaign_id`),
  KEY `list_id` (`list_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `campaigns_lists`;
CREATE TABLE IF NOT EXISTS `campaigns_lists` (
  `list_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `list_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `status_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `records_count` decimal(10,0) NOT NULL DEFAULT '0',
  `note` longtext COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `created_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `updated` datetime NOT NULL,
  `updated_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`list_id`,`list_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `campaigns_lists_statuses`;
CREATE TABLE IF NOT EXISTS `campaigns_lists_statuses` (
  `status_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `status_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `status_sequence` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`status_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `campaigns_lists_statuses` (`status_id`, `status_name`, `status_sequence`) VALUES
('UP', 'Update', 1),
('IN', 'Inaccurate', 2),
('UN', 'Unknown', 3);

DROP TABLE IF EXISTS `campaigns_records`;
CREATE TABLE IF NOT EXISTS `campaigns_records` (
  `list_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `record_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `table_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `status_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`list_id`,`record_id`),
  KEY `record_id` (`record_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `campaigns_records_types`;
CREATE TABLE IF NOT EXISTS `campaigns_records_types` (
  `type_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `type_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `campaigns_records_types` (`type_id`, `type_name`) VALUES
('accounts', 'Account'),
('contacts', 'Contact'),
('leads', 'Lead');

DROP TABLE IF EXISTS `campaigns_statuses`;
CREATE TABLE IF NOT EXISTS `campaigns_statuses` (
  `status_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `status_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `status_sequence` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`status_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `campaigns_statuses` (`status_id`, `status_name`, `status_sequence`) VALUES
('SU', 'Set up', 1),
('SE', 'Sent', 2),
('CA', 'Canceled', 3);

DROP TABLE IF EXISTS `campaigns_types`;
CREATE TABLE IF NOT EXISTS `campaigns_types` (
  `type_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `type_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `cases`;
CREATE TABLE IF NOT EXISTS `cases` (
  `case_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `status_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `subject` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `note` longtext COLLATE utf8_unicode_ci NOT NULL,
  `priority_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `due_date` date NOT NULL DEFAULT '0000-00-00',
  `account_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `contact_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`case_id`),
  KEY `user_id` (`user_id`),
  KEY `subject` (`subject`(10)),
  KEY `due_date` (`due_date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `cases_priorities`;
CREATE TABLE IF NOT EXISTS `cases_priorities` (
  `priority_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `priority_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `priority_sequence` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`priority_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `cases_priorities` (`priority_id`, `priority_name`, `priority_sequence`) VALUES
('LE', 'Lowest', 1),
('LO', 'Low', 2),
('NO', 'Normal', 3),
('HI', 'High', 4),
('HE', 'Highest', 5);

DROP TABLE IF EXISTS `cases_statuses`;
CREATE TABLE IF NOT EXISTS `cases_statuses` (
  `status_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `status_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `status_sequence` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`status_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `cases_statuses` (`status_id`, `status_name`, `status_sequence`) VALUES
('NE', 'New', 1),
('AS', 'Assigned', 2),
('IP', 'In progress', 3),
('CL', 'Closed', 4),
('RE', 'Rejected', 5);

DROP TABLE IF EXISTS `company`;
CREATE TABLE IF NOT EXISTS `company` (
  `company_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `company_alias` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `main_user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `billing_user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `company_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `company_status` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `appshore_version` date NOT NULL DEFAULT '2010-07-03',
  `license_time_stamp` date NOT NULL DEFAULT '0000-00-00',
  `edition_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `due_date` date NOT NULL DEFAULT '0000-00-00',
  `users_quota` decimal(5,0) NOT NULL DEFAULT '1',
  `disk_quota` decimal(15,0) NOT NULL DEFAULT '0',
  `records_quota` decimal(15,0) NOT NULL DEFAULT '0',
  `emails_quota` decimal(15,0) NOT NULL DEFAULT '0',
  `legal_status` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `incorporation` date NOT NULL DEFAULT '0000-00-00',
  `industry_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `tax_id` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `fiscal_year` decimal(4,0) NOT NULL DEFAULT '0',
  `phone` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `fax` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `employees` decimal(10,0) NOT NULL DEFAULT '0',
  `address_billing` longtext COLLATE utf8_unicode_ci NOT NULL,
  `zipcode_billing` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `city_billing` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `state_billing` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `country_billing` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `address_shipping` longtext COLLATE utf8_unicode_ci NOT NULL,
  `zipcode_shipping` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `city_shipping` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `state_shipping` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `country_shipping` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `administration_rbac_update` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `is_ipacl` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `ipacl` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `domain_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime DEFAULT '0000-00-00 00:00:00',
  `created_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `updated` datetime DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `note` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`company_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `company_invoices`;
CREATE TABLE IF NOT EXISTS `company_invoices` (
  `invoice_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `company_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `invoice_status` char(3) COLLATE utf8_unicode_ci NOT NULL,
  `order_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`invoice_id`),
  KEY `order_id` (`order_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `company_orders`;
CREATE TABLE IF NOT EXISTS `company_orders` (
  `order_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `company_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `order_status` enum('CHE','CAN','REG','ACT') COLLATE utf8_unicode_ci NOT NULL,
  `edition_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `edition_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `price` int(11) NOT NULL DEFAULT '0',
  `amount` int(11) NOT NULL,
  `period` tinyint(4) NOT NULL,
  `metric` enum('U','C') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'U',
  `due_date` date NOT NULL,
  `currency_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `users_quota` int(11) NOT NULL DEFAULT '0',
  `records_quota` bigint(20) NOT NULL,
  `disk_quota` bigint(20) NOT NULL,
  `emails_quota` bigint(20) NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  KEY `company_id` (`company_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `contacts`;
CREATE TABLE IF NOT EXISTS `contacts` (
  `contact_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `first_names` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `full_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `salutation` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `avatar` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `account_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `type_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `department` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `manager_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `mobile` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `messenger` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `messenger_type` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `fax` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `email_opt_out` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `do_not_call` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `assistant_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `private_phone` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `private_mobile` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `private_email` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `birthdate` date NOT NULL,
  `address_1` longtext COLLATE utf8_unicode_ci NOT NULL,
  `zipcode_1` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `city_1` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `state_1` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `country_1` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `address_2` longtext COLLATE utf8_unicode_ci NOT NULL,
  `zipcode_2` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `city_2` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `state_2` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `country_2` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `note` longtext COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `created_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `updated` datetime NOT NULL,
  `updated_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`contact_id`),
  KEY `last_name` (`last_name`),
  KEY `user_id` (`user_id`),
  KEY `account_id` (`account_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `dashboards`;
CREATE TABLE IF NOT EXISTS `dashboards` (
  `user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `column_nbr` enum('1','2') COLLATE utf8_unicode_ci NOT NULL,
  `dashlet_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `dashlet_sequence` tinyint(4) NOT NULL,
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `dashboards` (`user_id`, `column_nbr`, `dashlet_name`, `dashlet_sequence`) VALUES
('initial', '1', 'history', 1),
('initial', '1', 'my_upcoming_activities', 3),
('initial', '2', 'last_campaigns', 6),
('initial', '1', 'my_neglected_accounts', 2),
('initial', '2', 'open_cases', 5),
('initial', '1', 'my_last_leads', 4),
('initial', '1', 'my_open_opportunities', 5),
('initial', '2', 'upcoming_activities', 4),
('initial', '2', 'last_leads', 3),
('initial', '2', 'top_opportunities', 2),
('initial', '2', 'tags_cloud', 1);

DROP TABLE IF EXISTS `db_applications`;
CREATE TABLE IF NOT EXISTS `db_applications` (
  `app_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `app_label` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `app_sequence` int(4) NOT NULL DEFAULT '0',
  `status_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `table_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `field_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `is_related` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  `is_visible` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  `is_search` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  `is_customizable` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `is_report` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `is_quickadd` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `excluded_tabs` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`app_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `db_applications` (`app_name`, `app_label`, `app_sequence`, `status_id`, `table_name`, `field_name`, `is_related`, `is_visible`, `is_search`, `is_customizable`, `is_report`, `is_quickadd`, `excluded_tabs`) VALUES
('accounts', 'Accounts', 2, 'A', 'accounts', 'account_id', 'Y', 'Y', 'Y', 'Y', 'Y', 'N', ''),
('activities', 'Activities', 4, 'A', 'activities', 'activity_id', 'Y', 'Y', 'Y', 'Y', 'Y', 'N', ''),
('activities_preferences', 'Activities - Preferences', 5, 'S', 'activities_preferences', 'user_id', 'N', 'Y', 'N', 'N', 'N', 'N', ''),
('administration', 'Administration', 0, 'S', '', '', 'N', 'N', 'N', 'N', 'N', 'N', ''),
('administration_applications', 'Administration - Applications', 20, 'S', 'db_applications', 'app_name', 'Y', 'Y', 'N', 'N', 'N', 'N', ''),
('administration_company', 'Administration - Company', 12, 'S', 'company', 'company_id', 'Y', 'Y', 'N', 'N', 'N', 'N', ''),
('administration_departments', 'Administration - Departments', 13, 'S', 'departments', 'department_id', 'Y', 'Y', 'N', 'N', 'N', 'N', ''),
('administration_invoices', 'Administration - Invoices', 15, 'S', 'shop_invoices', 'invoice_id', 'Y', 'Y', 'N', 'N', 'N', 'N', ''),
('administration_orders', 'Administration - Orders', 15, 'S', 'shop_orders', 'order_id', 'Y', 'Y', 'N', 'N', 'N', 'N', ''),
('administration_roles', 'Administration - Roles', 14, 'S', 'roles', 'role_id', 'Y', 'Y', 'N', 'N', 'N', 'N', ''),
('administration_users', 'Administration - Users', 15, 'S', 'users', 'user_id', 'Y', 'Y', 'N', 'N', 'N', 'N', ''),
('api', 'api', 0, 'I', '', '', 'N', 'N', 'N', 'N', 'N', 'N', ''),
('campaigns', 'Campaigns', 8, 'A', 'campaigns', 'campaign_id', 'Y', 'Y', 'Y', 'Y', 'Y', 'N', ''),
('campaigns_history', 'Campaigns - History', 18, 'S', 'campaigns_history_view', 'campaign_id', 'Y', 'Y', 'N', 'N', 'N', 'N', ''),
('campaigns_lists', 'Campaigns - Lists', 19, 'S', 'campaigns_lists', 'list_id', 'Y', 'Y', 'N', 'N', 'N', 'N', ''),
('campaigns_records', 'Campaigns - List Records', 10, 'S', 'campaigns_records_view', 'record_id', 'Y', 'Y', 'N', 'N', 'N', 'N', ''),
('cases', 'Cases', 7, 'A', 'cases', 'case_id', 'Y', 'Y', 'Y', 'Y', 'Y', 'N', ''),
('contacts', 'Contacts', 3, 'A', 'contacts', 'contact_id', 'Y', 'Y', 'Y', 'Y', 'Y', 'N', ''),
('dashboards', 'Dashboard', 15, 'A', 'dashboards', 'user_id', 'Y', 'Y', 'N', 'N', 'Y', 'N', ''),
('documents', 'Documents', 9, 'A', 'documents', 'document_id', 'Y', 'Y', 'Y', 'Y', 'Y', 'N', ''),
('forecasts', 'Forecasts', 6, 'A', 'opportunities', 'opportunity_id', 'N', 'Y', 'N', 'N', 'Y', 'N', ''),
('leads', 'Leads', 1, 'A', 'leads', 'lead_id', 'Y', 'Y', 'Y', 'Y', 'Y', 'N', ''),
('opportunities', 'Opportunities', 5, 'A', 'opportunities', 'opportunity_id', 'Y', 'Y', 'Y', 'Y', 'Y', 'N', ''),
('preferences', 'Preferences', 0, 'S', '', '', 'N', 'N', 'N', 'N', 'N', 'N', ''),
('preferences_lookandfeel', 'Preferences - Look and feel', 5, 'S', 'users', 'user_id', 'N', 'Y', 'N', 'N', 'N', 'N', ''),
('preferences_profile', 'Preferences - Profile', 5, 'S', 'users', 'user_id', 'N', 'Y', 'N', 'N', 'N', 'N', ''),
('reports', 'Reports', 10, 'A', 'reports', 'report_id', 'Y', 'Y', 'N', 'N', 'N', 'N', ''),
('support', 'Support', 0, 'S', '', '', 'N', 'N', 'N', 'N', 'N', 'N', ''),
('support_faqs', 'Support - Frequently Asked Questions', 5, 'S', 'backoffice_support_faqs', 'faq_id', 'N', 'N', 'N', 'N', 'N', 'N', ''),
('support_tickets', 'Support - Tickets', 5, 'S', 'backoffice_support_tickets', 'ticket_id', 'N', 'N', 'N', 'N', 'N', 'N', ''),
('webmail', 'Webmail', 11, 'A', 'webmail', 'mail_id', 'Y', 'Y', 'Y', 'N', 'N', 'N', ''),
('tags', 'Tags', 0, 'I', '', '', 'N', 'N', 'N', 'N', 'N', 'N', ''),
('base', 'base', 0, 'I', '', '', 'N', 'N', 'N', 'N', 'N', 'N', ''),
('preferences_searches', 'Preferences - Search filters', 5, 'S', 'searches', 'search_id', 'N', 'Y', 'N', 'N', 'N', 'N', '');

DROP TABLE IF EXISTS `db_applications_statuses`;
CREATE TABLE IF NOT EXISTS `db_applications_statuses` (
  `status_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `status_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`status_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `db_applications_statuses` (`status_id`, `status_name`) VALUES
('A', 'Activated'),
('D', 'Deactivated'),
('I', 'Internal'),
('S', 'Special');

DROP TABLE IF EXISTS `db_blocks`;
CREATE TABLE IF NOT EXISTS `db_blocks` (
  `app_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `form_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `block_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `block_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `is_title` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `columns` int(1) NOT NULL DEFAULT '1',
  `block_sequence` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`app_name`,`form_name`,`block_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `db_blocks` (`app_name`, `form_name`, `block_id`, `block_name`, `is_title`, `columns`, `block_sequence`) VALUES
('accounts', 'view', '1hf2kgorrtfookgocs08ks8wg', 'Header', 'N', 1, 1),
('accounts', 'bulk', '1cqe4nznej24r', 'block1', 'N', 2, 2),
('accounts', 'edit', 'js9sy1hdm6o8sc8ckgcsksgo', 'Contact information', 'N', 2, 5),
('accounts', 'view', '1w8hxvuf52f48swscc8o8coos', 'Note', 'Y', 1, 8),
('accounts', 'view', '1xg9z91jgx7o0ok0cw840og8s', 'Account information', 'N', 2, 3),
('accounts', 'popup_view', '1bb1g0j9fg744o8gwosgc8w0s', 'Contact information', 'N', 2, 2),
('accounts', 'popup_edit', '7m22rfhbyr0o04kk0ogoks4o', 'Account information', 'N', 2, 3),
('accounts', 'popup_edit', '1wm0cjnn87usogocwo40gc4g4', 'Header', 'N', 1, 1),
('accounts', 'edit', 'yb8guu6kn8ggc0og0s4wkgo0', 'Addresses', 'Y', 2, 7),
('accounts', 'edit', '1ftpx139m98gwsgowwog48soo', 'Note', 'Y', 1, 8),
('accounts', 'edit', '6klgprda0j48ows80g8sw0wk', 'Account information', 'N', 2, 3),
('accounts', 'edit', '104gdyphnkpc8gcgkww4440g', 'Header', 'N', 1, 1),
('accounts', 'view', '17lcz6nfp7ms4480kcc80gk0o', 'Contact information', 'N', 2, 5),
('accounts', 'view', '8z4rwqsders4kssw08ko0wg8', 'Addresses', 'Y', 2, 7),
('accounts', 'view', '1ymheyu7blq840844kgokc0s0', 'Footer', 'N', 2, 10),
('accounts', 'popup_view', 'atszni9ubtsgccgc0scokck4', 'Note', 'Y', 1, 5),
('accounts', 'popup_view', '934zbgwkkiccwwkkcsss8wko', 'Account information', 'N', 2, 4),
('accounts', 'popup_edit', 'y59xafctgjk088ookw0g0kg4', 'Contact information', 'N', 2, 5),
('accounts', 'popup_edit', 'h1zlyc8c6884oo808ss0oscs', 'Addresses', 'Y', 2, 7),
('accounts', 'popup_edit', '6nwfmzwmq800k80o84kkw8go', 'Note', 'N', 1, 8),
('activities', 'popup_edit', 'keg8kmk7ly8kk0wo8sg4ockw', 'Note', 'N', 1, 6),
('activities', 'popup_view', '17bu5wm1p6f44wsk4g0cw8c8c', 'Related', 'N', 2, 3),
('activities', 'view', '12kk18btwtwjv', 'Note', 'N', 1, 6),
('activities', 'popup_edit', '1btlatoffwu80ogkwcog0wkk8', 'Related', 'N', 2, 3),
('activities', 'view', '2856aiot08bog', 'Main', 'N', 2, 5),
('activities', 'view', '1t8478u5x9vji', 'Header', 'N', 1, 1),
('activities', 'bulk', '1h8zm01ckrnn7', 'Bulk', 'N', 2, 2),
('activities', 'edit', '1a185o9jtmas0cgwc4s0kggg0', 'Note', 'N', 1, 6),
('activities', 'view', 'dgfcw7b778w9', 'Footer', 'N', 2, 8),
('activities', 'edit', '1ax9vggdso748ogwkgckc8w0c', 'Header', 'N', 1, 1),
('activities', 'edit', 'hnk5fti0tvs4wcwc8840888k', 'Main', 'N', 2, 5),
('activities', 'edit', '138oeoawphy8g0ogsgs0os0wg', 'Related', 'N', 2, 3),
('activities', 'view', '10faiyv7yys084o44s4kcc0o', 'Related', 'N', 2, 3),
('activities', 'popup_view', '1hkr401s1jlwc44wswwo40ko8', 'Note', 'N', 1, 6),
('activities', 'popup_view', '1e049xsz2sg084gs0o8og8gw8', 'Header', 'N', 1, 1),
('activities', 'popup_view', 'kgkayl7vdf4ok4k4ckwwc4cg', 'Main', 'N', 2, 5),
('activities', 'popup_edit', '1x1dtq9bmmo0wcoocscwckkkw', 'Header', 'N', 1, 1),
('activities', 'popup_edit', 'ydost9j9uhw0c040gkkkckwk', 'Main', 'N', 2, 5),
('activities_preferences', 'edit', 'i1ssa14wljk8c8ws0c4os0gw', 'Calendar', 'Y', 2, 2),
('activities_preferences', 'edit', 'cz93mguyt7w44g800o4888s8', 'Notifications', 'N', 2, 6),
('activities_preferences', 'edit', '9q73632yuxgcgc0g4c0wso08', 'New activity', 'Y', 2, 4),
('activities_preferences', 'view', '2gj7q8ggm1a8000g8wwo8ow4', 'New activity', 'Y', 2, 4),
('activities_preferences', 'view', 'e06gt0i8dpck44kko8k0oow4', 'Notifications', 'N', 2, 6),
('activities_preferences', 'view', 'e22na4ejqjkg0kckg88csk4k', 'Calendar', 'Y', 2, 2),
('administration_applications', 'bulk', 'bffhd8oycs8', 'Bulk2', 'N', 2, 3),
('administration_applications', 'view', '13fcwhijj2ios', 'header', 'N', 2, 2),
('administration_applications', 'view', '1ig40xsic4m8c', 'Body', 'N', 2, 4),
('administration_applications', 'edit', '106c761euqsgg', 'header', 'N', 2, 2),
('administration_applications', 'edit', '2as1279427k0o', 'Body', 'N', 2, 4),
('administration_applications', 'bulk', 'sm44cp7zxesw', 'Bulk1', 'N', 1, 1),
('administration_applications', 'popup_view', 'k9k4i61k3u8s', 'header', 'N', 2, 2),
('administration_applications', 'popup_view', 'rzxxa87wpnkk', 'Body', 'N', 2, 4),
('administration_applications', 'popup_edit', '1w39jzlpg2sk', 'header', 'N', 2, 2),
('administration_applications', 'popup_edit', '288vl4ukqon4c', 'Body', 'N', 2, 4),
('administration_company', 'view', '10chwpx27p2oo', 'Footer', 'N', 2, 9),
('administration_company', 'view', '2aas8afqfolcw', 'Note', 'N', 1, 7),
('administration_company', 'view', '14a5hw8dfaqs0', 'Body', 'N', 2, 4),
('administration_company', 'view', '27lh198apmtc4', 'Header', 'N', 2, 2),
('administration_company', 'view', '20zqlfunr7gkc', 'Addresses', 'N', 2, 6),
('administration_company', 'edit', '13z2ecyz3rnk4', 'Body', 'N', 2, 4),
('administration_company', 'edit', '235ca6sy1j1co', 'Addresses', 'N', 2, 6),
('administration_company', 'edit', '231n90dmhlz48', 'Header', 'N', 2, 2),
('administration_company', 'edit', 'ucxnz3wxz9cw', 'Note', 'N', 1, 7),
('administration_departments', 'bulk', 'jeriamvy7k84', 'Bulk', 'N', 2, 2),
('administration_departments', 'view', '20zqlguhbcpw0', 'Footer', 'N', 2, 9),
('administration_departments', 'view', 'znv0w2rvfb4w', 'Note', 'N', 1, 7),
('administration_departments', 'view', '20w1kaf6130g8', 'Body', 'N', 2, 4),
('administration_departments', 'view', '13gl8htnmtfk8', 'Header', 'N', 2, 2),
('administration_departments', 'view', '9dun74mq658g', 'Addresses', 'N', 2, 6),
('administration_departments', 'edit', '1td1tv7q19j48', 'Header', 'N', 2, 2),
('administration_departments', 'edit', '10otcoc2t2uoo', 'Body', 'N', 2, 4),
('administration_departments', 'edit', '10dq95245bms0', 'Addresses', 'N', 2, 6),
('administration_departments', 'edit', '1i8py73yfbk0w', 'Note', 'N', 1, 7),
('administration_departments', 'popup_view', '1u92s2wst6pwg', 'Header', 'N', 2, 2),
('administration_departments', 'popup_view', 'zwhfn2wvnb44', 'Body', 'N', 2, 4),
('administration_departments', 'popup_view', 'so8lj5n686o', 'Addresses', 'N', 2, 6),
('administration_departments', 'popup_view', '2tcjrwguxaio', 'Note', 'N', 1, 7),
('administration_orders', 'popup_view', '1hq8xwcx46g0o', 'Header', 'N', 1, 1),
('administration_orders', 'popup_view', 'dbidytkyivc4', 'Main', 'N', 2, 3),
('administration_orders', 'view', '23bi5rvcomjo0', 'Main', 'N', 2, 3),
('administration_orders', 'view', 'zcs2y6f5i0gs', 'Header', 'N', 1, 1),
('administration_roles', 'bulk', 'nqmmcfkdvht', 'Bulk', 'N', 1, 2),
('administration_roles', 'view', 'kfploca1f5xx', 'Header', 'N', 2, 2),
('administration_roles', 'view', 'rfnsrrtgd5e', 'Footer', 'N', 2, 5),
('administration_roles', 'view', 'tklik7v2pj24', 'Main', 'N', 1, 3),
('administration_roles', 'edit', '1gkcujjr9bd9g', 'Header', 'N', 2, 2),
('administration_roles', 'edit', '167sih2wa79j', 'Main', 'N', 1, 3),
('administration_roles', 'popup_view', 'va6q7b909lnr', 'Header', 'N', 2, 2),
('administration_roles', 'popup_view', '1k0rm7vlcvgsq', 'Footer', 'N', 2, 5),
('administration_roles', 'popup_view', '3d1tnjyi5s5h', 'Main', 'N', 1, 3),
('administration_users', 'view', '1c3rbn2x5hb4kscgc4s44wwg8', 'Main', 'N', 2, 5),
('administration_users', 'view', '13aq5ko2z6m8w0gws4g4s00w8', 'Header', 'N', 2, 3),
('administration_users', 'popup_view', 'cqkdsoiy8hwg', 'Note', 'N', 1, 4),
('administration_users', 'popup_view', '1kfjzfu4tbb4s', 'Header', 'N', 1, 1),
('administration_users', 'popup_view', '1cz0xswt9tq84', 'Main', 'N', 2, 3),
('administration_users', 'popup_edit', 'vhl12f6951c4', 'Main', 'N', 2, 3),
('administration_users', 'popup_edit', 'dxofjnamwhs0', 'Note', 'N', 1, 4),
('administration_users', 'popup_edit', '1op6wuzxu9fo', 'Header', 'N', 1, 1),
('administration_users', 'edit', '1s9mtebmfoo0o', 'Header', 'N', 2, 2),
('administration_users', 'edit', '2brr1b6lkeasw', 'Preferences', 'Y', 2, 8),
('administration_users', 'edit', 'kfpueqebytc0', 'Setup', 'Y', 2, 10),
('administration_users', 'edit', 'sif2w2u11r4g', 'Main', 'N', 2, 4),
('administration_users', 'edit', '1r2irncvnack0', 'Footer', 'N', 2, 13),
('administration_users', 'edit', '1q6htfo3inesk', 'Personal Information', 'Y', 2, 6),
('administration_users', 'edit', '1ixcu5lf30asg', 'Note', 'Y', 1, 11),
('administration_users', 'bulk', '13qfxwi7vfi8w', 'bulk', 'N', 2, 2),
('administration_users', 'view', '1ie69957sr40wcocc880gksgk', 'Setup', 'Y', 2, 11),
('administration_users', 'view', '37tntojlesow4844cwkgo80c', 'Note', 'Y', 1, 12),
('administration_users', 'view', 'hqrn9uvotqo80sc480s0cswo', 'Personal Information', 'Y', 2, 7),
('administration_users', 'view', 'xpbxva0hj2so0ok840gsk4w', 'Footer', 'N', 2, 14),
('administration_users', 'view', 'y1n6wqpj9mskwws4w8s48gc', 'Preferences', 'Y', 2, 9),
('campaigns', 'popup_view', '1l6nqge1in6u3', 'Main', 'N', 1, 1),
('campaigns', 'view', '27z0l4zptuv4s', 'Main', 'N', 1, 3),
('campaigns', 'popup_edit', '1gqj38bubfpcw', 'Header', 'N', 2, 2),
('campaigns', 'view', '27fb2uq07lxco', 'Header', 'N', 2, 2),
('campaigns', 'view', '1ajk9ce7aq70g', 'Footer', 'N', 2, 5),
('campaigns', 'edit', '27k8gaej7800c', 'Main', 'N', 1, 5),
('campaigns', 'edit', '14a59bjpcswkp', 'Header', 'N', 2, 4),
('campaigns', 'bulk', 'k0xgrf3iadmt', 'Main', 'N', 2, 2),
('campaigns', 'popup_edit', 'kvqli98xqv44', 'Main', 'N', 1, 3),
('campaigns', 'edit', '6l821sj5q4kko0wk0sko4cgk', 'Note', 'Y', 1, 7),
('campaigns_history', 'view', 'i3y793uom34u', 'Header', 'N', 2, 2),
('campaigns_history', 'view', '7q5swwstwsu', 'Note', 'Y', 1, 3),
('campaigns_history', 'edit', '2awy7asa6su88', 'Note', 'Y', 1, 3),
('campaigns_history', 'edit', '1tgqmyfq4hixb', 'Header', 'N', 2, 2),
('campaigns_history', 'popup_edit', '1pljqkenloetb', 'Header', 'N', 2, 2),
('campaigns_history', 'popup_view', 'r552zjxezsso', 'Header', 'N', 2, 2),
('campaigns_history', 'popup_view', 's4v2do13jpo0', 'Note', 'Y', 1, 3),
('campaigns_history', 'popup_edit', 'b27acvnimo3f', 'Note', 'Y', 1, 3),
('campaigns_lists', 'view', 'rhgidmfukuel', 'Note', 'N', 1, 4),
('campaigns_lists', 'view', '13ka11p7j9dec', 'Main', 'N', 2, 3),
('campaigns_lists', 'view', '18xo2pz1dxkkb', 'Footer', 'N', 2, 6),
('campaigns_lists', 'bulk', 'toajip9gywa2', 'Bulk', 'N', 2, 2),
('campaigns_lists', 'edit', '9v3838ugdu1r', 'Header', 'N', 2, 2),
('campaigns_lists', 'popup_view', 'lz534sbpo3d5', 'Main', 'N', 2, 2),
('campaigns_lists', 'popup_edit', '26vll517dx0kc', 'Main', 'N', 2, 2),
('campaigns_lists', 'popup_view', 'mrh061sae1y1', 'Note', 'N', 1, 3),
('campaigns_lists', 'edit', '210yp94bljb40', 'Note', 'N', 1, 3),
('campaigns_lists', 'popup_edit', '19hdlqkspg8qp', 'Note', 'N', 1, 3),
('campaigns_records', 'bulk', 'lllb3nixq3qc', 'Bulk', 'N', 2, 2),
('campaigns_records', 'view', 'jygs8nj6taey', 'Header', 'N', 2, 2),
('campaigns_records', 'view', 'ubp39my99327', 'Main', 'N', 2, 4),
('campaigns_records', 'view', '1pvehgfl9t5qr', 'Footer', 'N', 2, 6),
('campaigns_records', 'edit', 's7bqwudj4dyi', 'Header', 'N', 1, 1),
('campaigns_records', 'edit', 'k1li7xu4xoh', 'Main', 'N', 2, 3),
('campaigns_records', 'popup_view', '2a4ma0f0n5usc', 'Footer', 'N', 2, 6),
('campaigns_records', 'popup_view', '1uhoyhl4orcdz', 'Header', 'N', 2, 2),
('campaigns_records', 'popup_view', '3wrc04h0hsja', 'Main', 'N', 2, 4),
('cases', 'popup_edit', '9bpus7sow3cwkc8sc0kkw8gs', 'Main', 'N', 2, 4),
('cases', 'popup_edit', '3cx343d7xmecskg0gc80kc4k', 'Note', 'N', 1, 5),
('cases', 'view', 'sh6efa3xi81h', 'Main', 'N', 2, 4),
('cases', 'view', '1lnw1iacxacgm', 'Note', 'N', 1, 5),
('cases', 'view', '12jblwzk5m3jx', 'Footer', 'N', 2, 7),
('cases', 'bulk', '1appthrik4ncl', 'block1', 'N', 2, 2),
('cases', 'edit', '4g3csfbf0gw0swkgg8s84c00', 'Header', 'N', 2, 2),
('cases', 'popup_edit', '4v6tcv5b4o4k4g0448w48gk4', 'Header', 'N', 2, 2),
('cases', 'view', '1dw97f8ekybook0kwwco0cs8w', 'Header', 'N', 2, 2),
('cases', 'edit', '17pyhosyerusc888wccgkwgcs', 'Note', 'N', 1, 5),
('cases', 'edit', '16osxxjt0xa88kk8o08ocwkk8', 'Main', 'N', 2, 4),
('cases', 'popup_view', '1gejj17ggcw0wok44sok0oks8', 'Header', 'N', 2, 2),
('cases', 'popup_view', '1dbm5hli4akg888800ss88sg8', 'Note', 'N', 1, 5),
('cases', 'popup_view', '196y9w2fexes8wsw4oc044cg0', 'Main', 'N', 2, 4),
('contacts', 'edit', 'hcdvji9mj9s84swc404ks888', 'Addresses', 'Y', 2, 10),
('contacts', 'popup_edit', 'z7nn2qdfmog8g88ks4w00ows', 'Information', 'Y', 2, 6),
('contacts', 'popup_edit', '17gnkyhd5of4kos4ws848g8cc', 'Note', 'Y', 1, 9),
('contacts', 'view', 'yyb4pm6fmisgo8k0c8skg0wc', 'Note', 'Y', 1, 11),
('contacts', 'edit', '1bovsnoc3c2s4gogoo0s00sc4', 'Note', 'Y', 1, 11),
('contacts', 'view', '14n822vjzheok844cogcw4cgc', 'Contact information', 'Y', 2, 6),
('contacts', 'bulk', '90aglgoeka6p', 'block1', 'N', 2, 2),
('contacts', 'edit', '1i02jw46b1pcck0sogs8wswwo', 'Company', 'Y', 2, 4),
('contacts', 'popup_edit', '1fopitk23t7os40oo804k0cos', 'Header', 'N', 2, 2),
('contacts', 'edit', 'cyshqwfm2vc4cow44sg4ock4', 'Private', 'Y', 2, 8),
('contacts', 'view', '6ehjjzt6r0ws8wksossk08s0', 'Header', 'N', 2, 2),
('contacts', 'edit', '10mu5hd1ejb4w08wsk4o4cww8', 'Information', 'Y', 2, 6),
('contacts', 'edit', '1hzebn5g3r0g8408owowgwggs', 'Header', 'N', 2, 2),
('contacts', 'view', 'yywxg2drs0g80cosgg840gck', 'Company', 'Y', 2, 4),
('contacts', 'view', '2xiy1hy8fzuock808440kcok', 'Private', 'Y', 2, 8),
('contacts', 'view', 'dvnwsbnv9soc80wkogg0k4o8', 'Addresses', 'Y', 2, 10),
('contacts', 'view', '1w7wkhy1nqf4sgkg8sco0oskk', 'Footer', 'N', 2, 13),
('contacts', 'popup_edit', '16rgdbpzv3408c40sosg08cgc', 'Addresses', 'Y', 2, 8),
('contacts', 'popup_view', '1772a77n4orkcwg0g84s4ok40', 'Header', 'N', 2, 2),
('contacts', 'popup_view', 'b6ywoe2ecygcgogks0gwwss0', 'Note', 'N', 1, 3),
('documents', 'bulk', '1tuaann8tbxn0', 'Bulk', 'N', 2, 2),
('documents', 'edit', '1331mspew8ysw', 'Main', 'N', 1, 3),
('documents', 'edit', '136qnz4qg60gs', 'Header', 'N', 2, 2),
('documents', 'edit', '29urxu14s1xco', 'Note', 'N', 1, 6),
('documents', 'edit', '2b9a1xuioa3og', 'Main2', 'N', 2, 5),
('documents', 'popup_edit', '1yroek7u0jtww', 'Main', 'N', 1, 3),
('documents', 'popup_edit', '21n5bk4tialcg', 'Main2', 'N', 2, 5),
('documents', 'popup_edit', '22hxxdohsag0k', 'Header', 'N', 2, 2),
('documents', 'popup_view', '29om7vgz844k4', 'Header', 'N', 2, 2),
('documents', 'popup_view', 'sof8437j52o', 'Main', 'N', 1, 3),
('documents', 'view', '1cae8gv3lm1w4', 'Main2', 'N', 2, 5),
('documents', 'view', '1hyvdoeu45gk8', 'Header', 'N', 2, 2),
('documents', 'view', '1jjipo3medytx', 'Main', 'N', 1, 3),
('documents', 'view', '1q0brwwu9b7xb', 'Note', 'N', 1, 6),
('documents', 'view', 'sr1630uzfo42', 'Footer', 'N', 2, 8),
('documents_folders', 'bulk', '1am1d82fzqkkg', 'Bulk', 'N', 2, 2),
('documents_folders', 'edit', '1qmih22i341wg', 'Main', 'N', 2, 2),
('documents_folders', 'edit', 'ucxumaonfusk', 'Note', 'N', 1, 3),
('documents_folders', 'popup_edit', '1331msuuqlnkg', 'Main', 'N', 2, 2),
('documents_folders', 'popup_edit', '271rpmjstxno8', 'Note', 'N', 1, 3),
('documents_folders', 'popup_view', '11ye9u6bhipwk', 'Main', 'N', 2, 2),
('documents_folders', 'popup_view', '1liz6jbibiasw', 'Note', 'N', 1, 3),
('documents_folders', 'view', '12kkgwkmxpcg8', 'Footer', 'N', 2, 5),
('documents_folders', 'view', '23bi6sxj0wbos', 'Note', 'N', 1, 3),
('documents_folders', 'view', '53vspu0jxq4g', 'Main', 'N', 2, 2),
('leads', 'edit', 'ayg7btj4wewcoow4gkokwccc', 'Address', 'Y', 2, 7),
('leads', 'bulk', '27k8an0vhzms8', 'block1', 'N', 2, 2),
('leads', 'edit', '9311g05v88w04wwk440cwokk', 'Contact information', 'Y', 2, 5),
('leads', 'popup_edit', '1bkcxk82tc2swkco0os04g0s4', 'Contact information', 'Y', 2, 5),
('leads', 'view', '1yrnmzgqdehws8wks0g4g8kw0', 'Contact information', 'N', 2, 5),
('leads', 'view', '11hgl44mxpes4ogkc8sg4484c', 'Address', 'Y', 2, 7),
('leads', 'popup_edit', 'hvnneuwufxkocs4c40gcwssc', 'Account information', 'N', 2, 3),
('leads', 'popup_edit', '1hovvmj2s2dc08csgcco8wgw0', 'Header', 'N', 1, 1),
('leads', 'edit', 'y9lrqvv0p6skcwk84k8kw4c', 'Note', 'Y', 1, 8),
('leads', 'view', '2p4670rod4sg8owoows4c00', 'Note', 'Y', 1, 8),
('leads', 'view', 'k6jpkeio3e8oo8gk0okw404k', 'Main', 'N', 2, 3),
('leads', 'view', 'g0o9ds8m15c8g00kckwwwgs0', 'Header', 'N', 1, 1),
('leads', 'view', '9038db7rvzswwwo4k8co8wsg', 'Footer', 'N', 2, 10),
('leads', 'popup_view', 'f2h981f6gkggcooo08skw8s4', 'Contact information', 'N', 2, 3),
('leads', 'popup_view', '1bkxlaid85dwgo4kcoocc80gw', 'Note', 'N', 1, 4),
('leads', 'popup_edit', '175vvls114qow8sg0so0oswwo', 'Address', 'Y', 2, 7),
('leads', 'popup_edit', '1winthlvds000gosg0k8kswwk', 'Note', 'N', 1, 8),
('leads', 'edit', 'dx80e5m0jq0c40oogo00sw8k', 'Header', 'N', 1, 1),
('leads', 'edit', '1hl15zdu2n9cwkc4cg00wg04k', 'Main', 'N', 2, 3),
('opportunities', 'edit', 'b7fv9q9kwu0w0c0ockk0ss88', 'Note', 'Y', 1, 3),
('opportunities', 'popup_view', '3eao684domwy', 'Note', 'N', 1, 3),
('opportunities', 'popup_edit', '18tr2n2ksj0kg4ccwcc880kco', 'Main', 'N', 2, 2),
('opportunities', 'bulk', '9l8bayclym1p', 'block1', 'N', 2, 2),
('opportunities', 'edit', '10e4hjkwodlw48cgwg4g8gg8k', 'Main', 'N', 2, 2),
('opportunities', 'popup_edit', '1ww6h6dw40isso48ogs8c0s8w', 'Note', 'Y', 1, 3),
('opportunities', 'view', '1457q3mybwt5u', 'Footer', 'N', 2, 5),
('opportunities', 'view', 'b4nszc8xzv23', 'Main', 'N', 2, 2),
('opportunities', 'view', 'hu39z57kbs2b', 'Note', 'Y', 1, 3),
('preferences_lookandfeel', 'edit', '10ragq2617itc', 'Theme', 'Y', 1, 5),
('preferences_lookandfeel', 'view', 'dwcouzp78tck4gkos40o4sos', 'Locale', 'Y', 2, 4),
('preferences_lookandfeel', 'edit', '12238nyd9hxc0', 'Main', 'N', 2, 2),
('preferences_lookandfeel', 'edit', '1h90e2frullvk', 'Locale', 'Y', 2, 4),
('preferences_lookandfeel', 'view', '1fa93ag8kvwg8o8ss44w000cg', 'Theme', 'Y', 1, 5),
('preferences_lookandfeel', 'view', 'dzw7l3yrs9w0gsw4goocs4g8', 'Main', 'N', 2, 2),
('preferences_profile', 'edit', '6ud3rec4mug48cs48k4ckogg', 'Header', 'N', 2, 2),
('preferences_profile', 'popup_edit', '1lstr1vwvfogg', 'Note', 'N', 1, 5),
('preferences_profile', 'popup_edit', '1pxj7dkwrcg0', 'Header', 'N', 2, 2),
('preferences_profile', 'popup_edit', '2bszdlp7ppes4', 'Body', 'N', 2, 4),
('preferences_profile', 'popup_view', '2ottxtlabo4kog8c8c4w80co', 'Main', 'N', 2, 4),
('preferences_profile', 'edit', '57nq6t21izcws0ocgkcc0kww', 'Footer', 'N', 2, 11),
('preferences_profile', 'edit', '6izgizweehwk0kw44g8ckgss', 'Private', 'Y', 2, 8),
('preferences_profile', 'edit', '10ai7betb800w4csco8owcosg', 'Main', 'N', 2, 4),
('preferences_profile', 'edit', '12uanve0br34kcgo0wcs0csws', 'Body', 'N', 2, 6),
('preferences_profile', 'edit', '1i9lkua03tr4c4ssooc0s88ko', 'Note', 'N', 1, 9),
('preferences_profile', 'popup_view', '77ch338qqr8coosww8go0oc0', 'Body', 'N', 2, 6),
('preferences_profile', 'popup_view', 'k5fns2beatc4w448csg0ss08', 'Header', 'N', 2, 2),
('preferences_profile', 'popup_view', 'kags62xb8ogos880ssg4cs8k', 'Note', 'N', 1, 7),
('preferences_profile', 'view', '118iuwd6a528g', 'Body', 'N', 2, 6),
('preferences_profile', 'view', '1963bv96yvtw84sw8c8s8ocs4', 'Main', 'N', 2, 4),
('preferences_profile', 'view', '9dun4w391wso', 'Note', 'N', 1, 9),
('preferences_profile', 'view', '9l8phqq6ujwo', 'Footer', 'N', 2, 11),
('preferences_profile', 'view', 'i04t6quk6f40wg4w80444sk8', 'Private', 'Y', 2, 8),
('preferences_profile', 'view', 'tqrgvar474g8', 'Header', 'N', 2, 2),
('preferences_searches', 'view', '785ofb87iz8c4s80o4kkw44g', 'Body', 'N', 2, 3),
('preferences_searches', 'view', '15mmys2jk6lcc448k4c4oscw4', 'Header', 'N', 1, 1),
('preferences_searches', 'view', 'ya81xno8534wcc48cwkscwsw', 'Footer', 'N', 2, 5),
('preferences_searches', 'popup_view', '155stu4q1dr4kck004s808ko8', 'Footer', 'N', 2, 5),
('preferences_searches', 'edit', 'dqulv1sqb14cscwko8gco404', 'Header', 'N', 1, 1),
('preferences_searches', 'edit', '1gd2edpui5wgcow8cscwss84k', 'Body', 'N', 2, 3),
('preferences_searches', 'popup_view', 'bpk76wid1r4gscocw840k00', 'Header', 'N', 1, 1),
('preferences_searches', 'popup_view', '109qf1yjq6u8g8w8csc4kck0', 'Body', 'N', 2, 3),
('preferences_searches', 'popup_edit', '1yc2lqbfqav4s80wgwsc40wcs', 'Body', 'N', 2, 3),
('preferences_searches', 'popup_edit', '15pe5y7kwg4gos88s808c8sc8', 'Header', 'N', 1, 1),
('reports', 'bulk', '1a8hdbjvfozog', 'Bulk', 'N', 2, 2),
('support_faqs', 'view', 'trzz2kk7iu8g', 'Note', 'N', 1, 4),
('support_faqs', 'view', '1hv6bmfw4yv48', 'Main', 'N', 2, 3),
('support_faqs', 'view', '19r8qitiobusk', 'Header', 'N', 1, 1),
('support_faqs', 'view', '141j8x4nsqcgc', 'Footer', 'N', 2, 6),
('support_faqs', 'popup_view', 't8agsawnl7kg', 'Header', 'N', 1, 1),
('support_faqs', 'popup_view', 'cak2c2ycv9s8', 'Main', 'N', 2, 3),
('support_faqs', 'popup_edit', '1pxvkbx6v7ggs', 'Main', 'N', 2, 3),
('support_faqs', 'popup_edit', '1ib6sqac2itc4', 'Note', 'N', 1, 4),
('support_faqs', 'popup_edit', '1budqhh47la8s', 'Header', 'N', 1, 1),
('support_faqs', 'edit', 'bn5ivdwa540g', 'Main', 'N', 2, 3),
('support_faqs', 'edit', '4xq1vkxgqc0s', 'Header', 'N', 1, 1),
('support_faqs', 'edit', '1z8x76i8wqxww', 'Note', 'N', 1, 4),
('support_faqs', 'bulk', 'lo2dyy4xm1w4', 'Bulk', 'N', 2, 2),
('support_tickets', 'edit', 'co3uo1a4t48o', 'Header', 'N', 1, 1),
('support_tickets', 'edit', '2be7en9edd348', 'Main', 'N', 2, 3),
('support_tickets', 'popup_edit', 'ibcndsd8tm8s', 'Header', 'N', 1, 1),
('support_tickets', 'popup_view', '45e4r22e9okk', 'Header', 'N', 1, 1),
('support_tickets', 'popup_edit', '11fx2z360hr4k', 'Note', 'N', 1, 4),
('support_tickets', 'popup_view', '27mpjc01xrfo0', 'Main', 'N', 2, 3),
('support_tickets', 'popup_edit', 'miuzp8ixiyo4', 'Main', 'N', 2, 3),
('support_tickets', 'edit', 'm5b7hbww1kgs', 'Note', 'N', 1, 4),
('support_tickets', 'view', 'lj50b4cuhcgc', 'Footer', 'N', 2, 6),
('support_tickets', 'view', '1223a1n1tsogs', 'Note', 'N', 1, 4),
('support_tickets', 'view', 'mlbohio1mi8o', 'Main', 'N', 2, 3),
('support_tickets', 'view', '1cdwjf8bx9lw', 'Header', 'N', 1, 1),
('support_tickets', 'bulk', '1a2btyu0dyrog', 'Bulk', 'N', 2, 2),
('webmail', 'edit', '1hqsns73yrizwg4wg8888wosc', 'Attachement', 'N', 1, 7),
('webmail', 'popup_edit', 'hqeeu9ndagz8', 'Main', 'N', 1, 3),
('webmail', 'view', '1c0lcn5bmmkx68sosccs00c4o', 'Attachement', 'N', 1, 8),
('webmail', 'popup_view', '18hnj62icuujr', 'Main', 'N', 1, 1),
('webmail', 'edit', 'ixj2n93p8c1s', 'Message', 'N', 1, 8),
('webmail', 'edit', 'tluh7ih8uyv4', 'To', 'N', 1, 3),
('webmail', 'edit', '1d09nxy4tngg0', 'CC-Bcc', 'N', 2, 5),
('webmail', 'view', '2k4gzds0ud55q8wos8sksw4g', 'CC-Bcc', 'N', 2, 5),
('webmail', 'edit', 'usyiyh819a0w', 'Header', 'N', 2, 2),
('webmail', 'edit', '74zpg30isnrh2cws0wgk48wo', 'Subject', 'N', 1, 6),
('webmail', 'view', 'de3ygur1wgmckkkkg44g0ow4', 'Subject', 'N', 1, 6),
('webmail', 'bulk', '10a0vzsn8jmu5', 'Bulk', 'N', 2, 2),
('webmail', 'view', '17rlwh26sbqh8g4scgk40s00g', 'Message', 'N', 1, 7),
('webmail', 'view', 'ti5vmf5qzdqj48s8gk4csow', 'To', 'N', 1, 3),
('webmail', 'view', 'f4ee8xyybqw34swkc4wgc8cg', 'Header', 'N', 2, 2);

DROP TABLE IF EXISTS `db_fields`;
CREATE TABLE IF NOT EXISTS `db_fields` (
  `app_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `table_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `field_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `is_custom` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `is_computed` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `field_type` varchar(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'TE',
  `field_label` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `field_height` int(4) NOT NULL DEFAULT '1',
  `field_default` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `related_table` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `related_id` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `related_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `related_filter` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `is_search` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `is_readonly` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `is_mandatory` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `is_unique` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `is_visible` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  `search_sequence` int(4) NOT NULL DEFAULT '0',
  `result_sequence` int(4) NOT NULL DEFAULT '0',
  `result_class` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'grid_left',
  `bulk_sequence` int(4) NOT NULL DEFAULT '0',
  `bulk_side` enum('L','R') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'L',
  `bulk_block_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `view_sequence` int(4) NOT NULL DEFAULT '0',
  `view_side` enum('L','R') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'L',
  `view_block_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `edit_sequence` int(4) NOT NULL DEFAULT '0',
  `edit_side` enum('L','R') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'L',
  `edit_block_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `popup_search_sequence` int(4) NOT NULL DEFAULT '0',
  `popup_result_sequence` int(4) NOT NULL DEFAULT '0',
  `popup_view_sequence` int(4) NOT NULL DEFAULT '0',
  `popup_view_side` enum('L','R') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'L',
  `popup_view_block_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `popup_edit_sequence` int(4) NOT NULL DEFAULT '0',
  `popup_edit_side` enum('L','R') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'L',
  `popup_edit_block_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `linked_sequence` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`app_name`,`field_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `db_fields` (`app_name`, `table_name`, `field_name`, `is_custom`, `is_computed`, `field_type`, `field_label`, `field_height`, `field_default`, `related_table`, `related_id`, `related_name`, `related_filter`, `is_search`, `is_readonly`, `is_mandatory`, `is_unique`, `is_visible`, `search_sequence`, `result_sequence`, `result_class`, `bulk_sequence`, `bulk_side`, `bulk_block_id`, `view_sequence`, `view_side`, `view_block_id`, `edit_sequence`, `edit_side`, `edit_block_id`, `popup_search_sequence`, `popup_result_sequence`, `popup_view_sequence`, `popup_view_side`, `popup_view_block_id`, `popup_edit_sequence`, `popup_edit_side`, `popup_edit_block_id`, `linked_sequence`) VALUES
('accounts', 'accounts', 'country_shipping', 'N', 'N', 'TE', 'Shipping country', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 5, 'R', '8z4rwqsders4kssw08ko0wg8', 5, 'R', 'yb8guu6kn8ggc0og0s4wkgo0', 0, 0, 0, 'L', '', 0, 'R', 'h1zlyc8c6884oo808ss0oscs', 0),
('accounts', 'accounts', 'state_shipping', 'N', 'N', 'TE', 'Shipping state', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'R', '8z4rwqsders4kssw08ko0wg8', 3, 'R', 'yb8guu6kn8ggc0og0s4wkgo0', 0, 0, 0, 'L', '', 0, 'R', 'h1zlyc8c6884oo808ss0oscs', 0),
('accounts', 'accounts', 'city_shipping', 'N', 'N', 'TE', 'Shipping city', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', '8z4rwqsders4kssw08ko0wg8', 2, 'R', 'yb8guu6kn8ggc0og0s4wkgo0', 0, 0, 0, 'L', '', 0, 'R', 'h1zlyc8c6884oo808ss0oscs', 0),
('accounts', 'accounts', 'zipcode_shipping', 'N', 'N', 'TE', 'Shipping zipcode', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'R', '8z4rwqsders4kssw08ko0wg8', 4, 'R', 'yb8guu6kn8ggc0og0s4wkgo0', 0, 0, 0, 'L', '', 0, 'R', 'h1zlyc8c6884oo808ss0oscs', 0),
('accounts', 'accounts', 'address_shipping', 'N', 'N', 'ML', 'Shipping address', 4, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', '8z4rwqsders4kssw08ko0wg8', 1, 'R', 'yb8guu6kn8ggc0og0s4wkgo0', 0, 0, 0, 'L', '', 0, 'R', 'h1zlyc8c6884oo808ss0oscs', 0),
('accounts', 'accounts', 'country_billing', 'N', 'N', 'TE', 'Billing country', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 5, 'L', '8z4rwqsders4kssw08ko0wg8', 5, 'L', 'yb8guu6kn8ggc0og0s4wkgo0', 0, 0, 0, 'R', 'b2sfthbqpeokc80k888444gw', 4, 'R', 'h1zlyc8c6884oo808ss0oscs', 0),
('accounts', 'accounts', 'state_billing', 'N', 'N', 'TE', 'Billing state', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 3, 5, 'grid_left', 0, 'L', '', 3, 'L', '8z4rwqsders4kssw08ko0wg8', 3, 'L', 'yb8guu6kn8ggc0og0s4wkgo0', 3, 5, 0, 'R', 'b2sfthbqpeokc80k888444gw', 2, 'R', 'h1zlyc8c6884oo808ss0oscs', 5),
('accounts', 'accounts', 'city_billing', 'N', 'N', 'TE', 'Billing city', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 2, 4, 'grid_left', 0, 'L', '', 2, 'L', '8z4rwqsders4kssw08ko0wg8', 2, 'L', 'yb8guu6kn8ggc0og0s4wkgo0', 2, 4, 0, 'R', 'b2sfthbqpeokc80k888444gw', 1, 'R', 'h1zlyc8c6884oo808ss0oscs', 4),
('accounts', 'accounts', 'zipcode_billing', 'N', 'N', 'TE', 'Billing zipcode', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 4, 0, 'grid_left', 0, 'L', '', 4, 'L', '8z4rwqsders4kssw08ko0wg8', 4, 'L', 'yb8guu6kn8ggc0og0s4wkgo0', 4, 6, 0, 'R', 'b2sfthbqpeokc80k888444gw', 3, 'R', 'h1zlyc8c6884oo808ss0oscs', 6),
('accounts', 'accounts', 'note', 'N', 'N', 'ML', 'Note', 4, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '1w8hxvuf52f48swscc8o8coos', 1, 'L', '1ftpx139m98gwsgowwog48soo', 0, 0, 1, 'L', 'atszni9ubtsgccgc0scokck4', 1, 'L', '6nwfmzwmq800k80o84kkw8go', 0),
('accounts', 'accounts', 'address_billing', 'N', 'N', 'ML', 'Billing address', 4, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '8z4rwqsders4kssw08ko0wg8', 1, 'L', 'yb8guu6kn8ggc0og0s4wkgo0', 0, 0, 0, 'L', 'b2sfthbqpeokc80k888444gw', 1, 'L', 'h1zlyc8c6884oo808ss0oscs', 0),
('accounts', 'accounts', 'updated', 'N', 'N', 'TS', 'Last update', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_center', -1, 'L', '', 1, 'R', '1ymheyu7blq840844kgokc0s0', 0, 'R', '1xg21rw7iskgg840oow8ksos0', 0, 0, 0, 'R', 'ayhdcndabt44wosgwsskok8w', 0, 'R', '11hm10urwvdw40ok0swogc4g0', 0),
('accounts', 'accounts', 'updated_by', 'N', 'N', 'DD', 'Updated by', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', -1, 'L', '', 0, 'R', 'czpa2s5fh1s8w80cc0woo04g', 0, 'R', '1xg21rw7iskgg840oow8ksos0', 0, 0, 0, 'L', '', 0, 'R', '11hm10urwvdw40ok0swogc4g0', 0),
('accounts', 'accounts', 'created_by', 'N', 'N', 'DD', 'Created by', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', -1, 'L', '', 0, 'L', 'czpa2s5fh1s8w80cc0woo04g', 0, 'L', '1xg21rw7iskgg840oow8ksos0', 0, 0, 0, 'L', '', 0, 'L', '11hm10urwvdw40ok0swogc4g0', 0),
('accounts', 'accounts', 'created', 'N', 'N', 'TS', 'Created', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_center', -1, 'L', '', 1, 'L', '1ymheyu7blq840844kgokc0s0', 0, 'L', '1xg21rw7iskgg840oow8ksos0', 0, 0, 0, 'L', 'ayhdcndabt44wosgwsskok8w', 0, 'L', '11hm10urwvdw40ok0swogc4g0', 0),
('accounts', 'accounts', 'revenue', 'N', 'N', 'TE', 'Revenue', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'L', '1xg9z91jgx7o0ok0cw840og8s', 4, 'L', '6klgprda0j48ows80g8sw0wk', 0, 0, 0, 'L', '934zbgwkkiccwwkkcsss8wko', 3, 'L', '7m22rfhbyr0o04kk0ogoks4o', 0),
('accounts', 'accounts', 'employees', 'N', 'N', 'TE', 'Employees', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', '1xg9z91jgx7o0ok0cw840og8s', 3, 'L', '6klgprda0j48ows80g8sw0wk', 0, 0, 0, 'L', '934zbgwkkiccwwkkcsss8wko', 4, 'L', '7m22rfhbyr0o04kk0ogoks4o', 0),
('accounts', 'accounts', 'fax', 'N', 'N', 'TE', 'Fax', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', '17lcz6nfp7ms4480kcc80gk0o', 3, 'L', 'js9sy1hdm6o8sc8ckgcsksgo', 0, 0, 0, 'L', '1bb1g0j9fg744o8gwosgc8w0s', 0, 'L', 'y59xafctgjk088ookw0g0kg4', 0),
('accounts', 'accounts', 'phone', 'N', 'N', 'PH', 'Phone', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 2, 'grid_left', 0, 'L', '', 2, 'L', '17lcz6nfp7ms4480kcc80gk0o', 2, 'L', 'js9sy1hdm6o8sc8ckgcsksgo', 0, 2, 1, 'L', '1bb1g0j9fg744o8gwosgc8w0s', 2, 'L', 'y59xafctgjk088ookw0g0kg4', 2),
('accounts', 'accounts', 'email', 'N', 'N', 'WM', 'Email', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 3, 'grid_left', 0, 'L', '', 1, 'L', '17lcz6nfp7ms4480kcc80gk0o', 1, 'L', 'js9sy1hdm6o8sc8ckgcsksgo', 0, 3, 1, 'R', '1bb1g0j9fg744o8gwosgc8w0s', 1, 'L', 'y59xafctgjk088ookw0g0kg4', 3),
('accounts', 'accounts', 'url', 'N', 'N', 'WS', 'Web site', 5, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 3, 'R', '17lcz6nfp7ms4480kcc80gk0o', 3, 'R', 'js9sy1hdm6o8sc8ckgcsksgo', 0, 0, 0, 'R', '1bb1g0j9fg744o8gwosgc8w0s', 0, 'R', 'y59xafctgjk088ookw0g0kg4', 0),
('accounts', 'accounts', 'tax_id', 'N', 'N', 'TE', 'Tax identifier', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '17lcz6nfp7ms4480kcc80gk0o', 0, 'L', 'js9sy1hdm6o8sc8ckgcsksgo', 0, 0, 0, 'L', '1bb1g0j9fg744o8gwosgc8w0s', 0, 'L', 'y59xafctgjk088ookw0g0kg4', 0),
('accounts', 'accounts', 'ticket_symbol', 'N', 'N', 'TE', 'Ticket symbol', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '17lcz6nfp7ms4480kcc80gk0o', 0, 'L', 'js9sy1hdm6o8sc8ckgcsksgo', 0, 0, 0, 'L', '1bb1g0j9fg744o8gwosgc8w0s', 0, 'L', 'y59xafctgjk088ookw0g0kg4', 0),
('accounts', 'accounts', 'legal_status', 'N', 'N', 'TE', 'Legal status', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '17lcz6nfp7ms4480kcc80gk0o', 0, 'L', 'js9sy1hdm6o8sc8ckgcsksgo', 0, 0, 0, 'L', '1bb1g0j9fg744o8gwosgc8w0s', 0, 'L', 'y59xafctgjk088ookw0g0kg4', 0),
('accounts', 'accounts', 'account_code', 'N', 'N', 'TE', 'Account code', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'R', '17lcz6nfp7ms4480kcc80gk0o', 0, 'R', 'js9sy1hdm6o8sc8ckgcsksgo', 0, 0, 0, 'R', '1bb1g0j9fg744o8gwosgc8w0s', 0, 'R', 'y59xafctgjk088ookw0g0kg4', 0),
('accounts', 'accounts', 'account_name', 'N', 'N', 'VF', 'Account', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 1, 1, 'grid_left', 0, 'R', '1cqe4nznej24r', 1, 'L', '1hf2kgorrtfookgocs08ks8wg', 1, 'L', '104gdyphnkpc8gcgkww4440g', 1, 1, 0, 'L', '9e3s6qvwafoc4c8gw840k44o', 1, 'L', '1wm0cjnn87usogocwo40gc4g4', 1),
('accounts', 'accounts', 'account_number', 'N', 'N', 'TE', 'Account number', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', '1xg9z91jgx7o0ok0cw840og8s', 2, 'L', '6klgprda0j48ows80g8sw0wk', 0, 0, 0, 'L', '934zbgwkkiccwwkkcsss8wko', 2, 'L', '7m22rfhbyr0o04kk0ogoks4o', 0),
('accounts', 'accounts', 'rating_id', 'N', 'N', 'DD', 'Rating', 1, '', 'ratings', 'rating_id', 'rating_name', ' order by rating_sequence', 'N', 'N', '', 'N', 'Y', 6, 8, 'grid_left', 3, 'L', '1cqe4nznej24r', 3, 'R', '1xg9z91jgx7o0ok0cw840og8s', 3, 'R', '6klgprda0j48ows80g8sw0wk', 6, 0, 1, 'R', '934zbgwkkiccwwkkcsss8wko', 3, 'R', '7m22rfhbyr0o04kk0ogoks4o', 0),
('accounts', 'accounts', 'type_id', 'N', 'N', 'DD', 'Type', 1, '', 'types', 'type_id', 'type_name', ' order by type_name', 'N', 'N', 'N', 'N', 'Y', 8, 6, 'grid_left', 2, 'R', '1cqe4nznej24r', 1, 'R', '1xg9z91jgx7o0ok0cw840og8s', 1, 'R', '6klgprda0j48ows80g8sw0wk', 8, 7, 1, 'L', '934zbgwkkiccwwkkcsss8wko', 1, 'R', '7m22rfhbyr0o04kk0ogoks4o', 7),
('accounts', 'accounts', 'industry_id', 'N', 'N', 'DD', 'Industry', 1, '', 'industries', 'industry_id', 'industry_name', ' order by industry_name', 'N', 'N', '', 'N', 'Y', 5, 7, 'grid_left', 2, 'L', '1cqe4nznej24r', 2, 'R', '1xg9z91jgx7o0ok0cw840og8s', 2, 'R', '6klgprda0j48ows80g8sw0wk', 5, 0, 2, 'L', '934zbgwkkiccwwkkcsss8wko', 2, 'R', '7m22rfhbyr0o04kk0ogoks4o', 0),
('accounts', 'accounts', 'source_id', 'N', 'N', 'DD', 'Source', 1, '', 'sources', 'source_id', 'source_name', ' order by source_name', 'N', 'N', '', 'N', 'Y', 7, 0, 'grid_left', 1, 'R', '1cqe4nznej24r', 4, 'R', '1xg9z91jgx7o0ok0cw840og8s', 4, 'R', '6klgprda0j48ows80g8sw0wk', 7, 0, 2, 'R', '934zbgwkkiccwwkkcsss8wko', 4, 'R', '7m22rfhbyr0o04kk0ogoks4o', 0),
('accounts', 'accounts', 'user_id', 'N', 'N', 'DD', 'Owner', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', '', 'N', 'Y', 9, 9, 'grid_left', 1, 'L', '1cqe4nznej24r', 0, 'L', '1cqe4nznej24r', -1, 'L', '', 9, 8, -1, 'L', '', 0, 'L', '', 8),
('accounts', 'accounts', 'account_top_id', 'N', 'N', 'RR', 'Main account', 1, '', 'accounts', 'account_id', 'account_name', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '1xg9z91jgx7o0ok0cw840og8s', 1, 'L', '6klgprda0j48ows80g8sw0wk', 0, 0, 0, 'L', '934zbgwkkiccwwkkcsss8wko', 1, 'L', '7m22rfhbyr0o04kk0ogoks4o', 0),
('accounts', 'accounts', 'account_id', 'N', 'N', 'RK', 'Account id', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', -1, -1, 'grid_left', -1, 'L', '', -1, 'L', '', -1, 'L', '', -1, -1, -1, 'L', '', 0, 'L', '', -1),
('accounts', 'accounts', 'email_opt_out', 'N', 'N', 'CH', 'Email opt out', 1, 'N', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'R', '17lcz6nfp7ms4480kcc80gk0o', 1, 'R', 'js9sy1hdm6o8sc8ckgcsksgo', 0, 0, 0, 'R', '1bb1g0j9fg744o8gwosgc8w0s', 1, 'R', 'y59xafctgjk088ookw0g0kg4', 0),
('accounts', 'accounts', 'do_not_call', 'N', 'N', 'CH', 'Do not call', 1, 'N', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 2, 'R', '17lcz6nfp7ms4480kcc80gk0o', 2, 'R', 'js9sy1hdm6o8sc8ckgcsksgo', 0, 0, 0, 'R', '1bb1g0j9fg744o8gwosgc8w0s', 2, 'R', 'y59xafctgjk088ookw0g0kg4', 0),
('activities', 'activities', 'updated_by', 'N', 'N', 'DD', 'Updated by', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', 'dgfcw7b778w9', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'R', 'bv3euhqar8oog40cc008w8g4', 0),
('activities', 'activities', 'updated', 'N', 'N', 'TS', 'Updated', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'R', 'dgfcw7b778w9', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'R', 'bv3euhqar8oog40cc008w8g4', 0),
('activities', 'activities', 'created_by', 'N', 'N', 'DD', 'Created by', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', 'dgfcw7b778w9', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', 'bv3euhqar8oog40cc008w8g4', 0),
('activities', 'activities', 'created', 'N', 'N', 'TS', 'Created', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'L', 'dgfcw7b778w9', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', 'bv3euhqar8oog40cc008w8g4', 0),
('activities', 'activities', 'is_allday', 'N', 'N', 'CH', 'All day', 1, 'N', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '2856aiot08bog', 0, 'L', 'hnk5fti0tvs4wcwc8840888k', 0, 0, 0, 'L', 'kgkayl7vdf4ok4k4ckwwc4cg', 0, 'L', 'ydost9j9uhw0c040gkkkckwk', 0),
('activities', 'activities', 'activity_end', 'N', 'N', 'DT', 'Activity end', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 4, 'L', '1h8zm01ckrnn7', 3, 'L', '2856aiot08bog', 3, 'L', 'hnk5fti0tvs4wcwc8840888k', 0, 0, 2, 'R', 'kgkayl7vdf4ok4k4ckwwc4cg', 3, 'L', 'ydost9j9uhw0c040gkkkckwk', 0),
('activities', 'activities', 'activity_start', 'N', 'N', 'DT', 'Activity start', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 6, 6, 'grid_center', 3, 'L', '1h8zm01ckrnn7', 2, 'L', '2856aiot08bog', 2, 'L', 'hnk5fti0tvs4wcwc8840888k', 6, 6, 1, 'R', 'kgkayl7vdf4ok4k4ckwwc4cg', 2, 'L', 'ydost9j9uhw0c040gkkkckwk', 6),
('activities', 'activities', 'priority_id', 'N', 'N', 'DD', 'Priority', 1, '', 'activities_priorities', 'priority_id', 'priority_name', ' order by priority_sequence', 'N', 'N', 'N', 'N', 'Y', 1, 1, 'grid_left', 2, 'R', '1h8zm01ckrnn7', 1, 'R', '2856aiot08bog', 1, 'R', 'hnk5fti0tvs4wcwc8840888k', 1, 1, 0, 'R', 'kgkayl7vdf4ok4k4ckwwc4cg', 1, 'R', 'ydost9j9uhw0c040gkkkckwk', 1),
('activities', 'activities', 'note', 'N', 'N', 'ML', 'Note', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '12kk18btwtwjv', 1, 'L', '1a185o9jtmas0cgwc4s0kggg0', 0, 0, 1, 'L', '1hkr401s1jlwc44wswwo40ko8', 1, 'L', 'keg8kmk7ly8kk0wo8sg4ockw', 0),
('activities', 'activities', 'location', 'N', 'N', 'TE', 'Location', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 3, 'R', '1h8zm01ckrnn7', 3, 'R', '2856aiot08bog', 3, 'R', 'hnk5fti0tvs4wcwc8840888k', 0, 0, 0, 'R', 'kgkayl7vdf4ok4k4ckwwc4cg', 3, 'R', 'ydost9j9uhw0c040gkkkckwk', 0),
('activities', 'activities', 'subject', 'N', 'N', 'VF', 'Subject', 1, '', '', '', '', '', 'Y', 'N', 'Y', 'N', 'Y', 5, 3, 'grid_left', 0, 'L', '', 1, 'L', '1t8478u5x9vji', 1, 'L', '1ax9vggdso748ogwkgckc8w0c', 5, 3, 1, 'L', '1e049xsz2sg084gs0o8og8gw8', 1, 'L', '1x1dtq9bmmo0wcoocscwckkkw', 3),
('activities', 'activities', 'type_id', 'N', 'N', 'DD', 'Type', 1, '', 'activities_types', 'type_id', 'type_name', ' order by type_name', 'N', 'N', 'Y', 'N', 'Y', 2, 2, 'grid_left', 1, 'R', '1h8zm01ckrnn7', 1, 'L', '2856aiot08bog', 1, 'L', 'hnk5fti0tvs4wcwc8840888k', 2, 2, 2, 'L', 'kgkayl7vdf4ok4k4ckwwc4cg', 1, 'L', 'ydost9j9uhw0c040gkkkckwk', 2),
('activities', 'activities', 'status_id', 'N', 'N', 'DD', 'Status', 1, '', 'activities_statuses', 'status_id', 'status_name', ' order by status_name', 'N', 'N', 'N', 'N', 'Y', 7, 7, 'grid_left', 2, 'L', '1h8zm01ckrnn7', 2, 'R', '2856aiot08bog', 2, 'R', 'hnk5fti0tvs4wcwc8840888k', 7, 7, 1, 'L', 'kgkayl7vdf4ok4k4ckwwc4cg', 2, 'R', 'ydost9j9uhw0c040gkkkckwk', 7),
('activities', 'activities', 'is_private', 'N', 'N', 'CH', 'Private', 1, 'N', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'R', '1h8zm01ckrnn7', 4, 'R', '2856aiot08bog', 4, 'R', 'hnk5fti0tvs4wcwc8840888k', 0, 0, 0, 'R', 'kgkayl7vdf4ok4k4ckwwc4cg', 4, 'R', 'ydost9j9uhw0c040gkkkckwk', 0),
('activities', 'activities', 'user_id', 'N', 'N', 'DD', 'Owner', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 9, 9, 'grid_left', 1, 'L', '1h8zm01ckrnn7', 0, 'L', '', 0, 'L', '', 9, 9, 0, 'L', '', 0, 'L', '', 9),
('activities', 'activities', 'is_open', 'N', 'N', 'CH', 'Open', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 8, 8, 'grid_center', 4, 'R', '1h8zm01ckrnn7', 4, 'L', '2856aiot08bog', 4, 'L', 'hnk5fti0tvs4wcwc8840888k', 8, 8, 0, 'L', 'kgkayl7vdf4ok4k4ckwwc4cg', 4, 'L', 'ydost9j9uhw0c040gkkkckwk', 8),
('activities', 'activities', 'activity_id', 'N', 'N', 'RK', 'Activity id', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', -1, -1, 'grid_left', -1, 'L', '', -1, 'L', '', -1, 'L', '', -1, -1, -1, 'L', '', 0, 'L', '', -1),
('activities', 'activities', 'account_id', 'N', 'N', 'RR', 'Account', 1, '', 'accounts', 'account_id', 'account_name', '', 'N', 'N', 'N', 'N', 'Y', 3, 4, 'grid_left', 0, 'L', '', 1, 'L', '10faiyv7yys084o44s4kcc0o', 1, 'L', '138oeoawphy8g0ogsgs0os0wg', 3, 4, 1, 'L', '17bu5wm1p6f44wsk4g0cw8c8c', 1, 'L', '1btlatoffwu80ogkwcog0wkk8', 4),
('activities', 'activities', 'contact_id', 'N', 'N', 'RR', 'Contact', 1, '', 'contacts', 'contact_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 4, 5, 'grid_left', 0, 'L', '', 1, 'R', '10faiyv7yys084o44s4kcc0o', 1, 'R', '138oeoawphy8g0ogsgs0os0wg', 4, 5, 1, 'R', '17bu5wm1p6f44wsk4g0cw8c8c', 1, 'R', '1btlatoffwu80ogkwcog0wkk8', 5),
('activities', 'activities', 'reminder_email', 'N', 'N', 'RR', 'Reminder email', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities', 'activities', 'reminder_popup', 'N', 'N', 'RR', 'Reminder popup', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'inc_hour', 'N', 'Y', 'DD', 'Time table granularity', 1, '1800', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 2, 'L', 'e22na4ejqjkg0kckg88csk4k', 2, 'L', 'i1ssa14wljk8c8ws0c4os0gw', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'first_day_week', 'N', 'Y', 'DD', 'First day of the week', 1, '1', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'R', 'e22na4ejqjkg0kckg88csk4k', 1, 'R', 'i1ssa14wljk8c8ws0c4os0gw', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'duration', 'N', 'N', 'DD', 'Duration', 1, '3600', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 2, 'R', '2gj7q8ggm1a8000g8wwo8ow4', 2, 'R', '9q73632yuxgcgc0g4c0wso08', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'day_start_hour', 'N', 'Y', 'DD', 'Day start hour', 1, '28800', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 0, 'L', 'e22na4ejqjkg0kckg88csk4k', 0, 'L', 'i1ssa14wljk8c8ws0c4os0gw', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'days_per_week', 'N', 'Y', 'DD', 'Days displayed in week and month tabs', 1, '7', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 2, 'R', 'e22na4ejqjkg0kckg88csk4k', 2, 'R', 'i1ssa14wljk8c8ws0c4os0gw', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'created_by', 'N', 'N', 'RR', 'Created by', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'day_end_hour', 'N', 'Y', 'DD', 'Day end hour', 1, '64800', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 0, 'L', 'e22na4ejqjkg0kckg88csk4k', 0, 'L', 'i1ssa14wljk8c8ws0c4os0gw', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'created', 'N', 'N', 'DT', 'Created', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'priority_id', 'N', 'N', 'DD', 'Priority', 1, '', 'activities_priorities', 'priority_id', 'priority_name', 'order by priority_sequence', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'L', '2gj7q8ggm1a8000g8wwo8ow4', 1, 'L', '9q73632yuxgcgc0g4c0wso08', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'status_id', 'N', 'N', 'DD', 'Status', 1, '', 'activities_statuses', 'status_id', 'status_name', 'order by status_name', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 2, 'L', '2gj7q8ggm1a8000g8wwo8ow4', 2, 'L', '9q73632yuxgcgc0g4c0wso08', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'tab_id', 'N', 'Y', 'DD', 'Default tab', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'L', 'e22na4ejqjkg0kckg88csk4k', 1, 'L', 'i1ssa14wljk8c8ws0c4os0gw', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'type_id', 'N', 'N', 'DD', 'Type', 1, '', 'activities_types', 'type_id', 'type_name', 'order by type_name', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'R', '2gj7q8ggm1a8000g8wwo8ow4', 1, 'R', '9q73632yuxgcgc0g4c0wso08', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'updated', 'N', 'N', 'DT', 'Updated', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'updated_by', 'N', 'N', 'RR', 'Updated by', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'user_id', 'N', 'N', 'RK', 'User id', 1, '', '', '', '', '', 'N', 'Y', 'N', 'Y', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_applications', 'db_applications', 'app_name', 'N', 'N', 'VF', 'Name', 1, '', '', '', '', '', 'N', 'Y', 'N', 'Y', 'Y', 2, 2, 'grid_left', 0, 'L', '', 1, 'L', '13fcwhijj2ios', 1, 'L', '106c761euqsgg', 2, 2, 1, 'L', 'k9k4i61k3u8s', 1, 'L', '1w39jzlpg2sk', 0),
('administration_applications', 'db_applications', 'app_label', 'N', 'N', 'VF', 'Label', 1, '', '', '', '', '', 'N', 'N', 'Y', 'Y', 'Y', 1, 1, 'grid_left', 0, 'L', '', 1, 'R', '13fcwhijj2ios', 1, 'R', '106c761euqsgg', 1, 1, 1, 'R', 'k9k4i61k3u8s', 1, 'R', '1w39jzlpg2sk', 0),
('administration_applications', 'db_applications', 'app_sequence', 'N', 'N', 'TE', 'Rank', 1, '0', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 7, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 7, 0, 'L', '', 0, 'L', '', 0),
('administration_applications', 'db_applications', 'status_id', 'N', 'N', 'DD', 'Status', 1, '', 'db_applications_statuses', 'status_id', 'status_name', 'where status_id in ("A","D") order by status_name', 'N', 'N', 'N', 'N', 'Y', 3, 3, 'grid_center', 1, 'L', 'sm44cp7zxesw', 1, 'L', '1ig40xsic4m8c', 1, 'L', '2as1279427k0o', 3, 3, 1, 'L', 'rzxxa87wpnkk', 1, 'L', '288vl4ukqon4c', 0),
('administration_applications', 'db_applications', 'table_name', 'N', 'N', 'TE', 'Table name', 1, '', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', '1ig40xsic4m8c', 2, 'L', '2as1279427k0o', 0, 0, 2, 'L', 'rzxxa87wpnkk', 2, 'L', '288vl4ukqon4c', 0),
('administration_applications', 'db_applications', 'field_name', 'N', 'N', 'TE', 'Field name', 1, '', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_applications', 'db_applications', 'is_related', 'N', 'N', 'CH', 'Is related', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_applications', 'db_applications', 'is_visible', 'N', 'N', 'CH', 'Visible', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 4, 4, 'grid_center', 1, 'L', 'bffhd8oycs8', 1, 'R', '1ig40xsic4m8c', 1, 'R', '2as1279427k0o', 4, 4, 1, 'R', 'rzxxa87wpnkk', 1, 'R', '288vl4ukqon4c', 0),
('administration_applications', 'db_applications', 'is_search', 'N', 'N', 'CH', 'Searchable', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 5, 5, 'grid_center', 1, 'R', 'bffhd8oycs8', 2, 'R', '1ig40xsic4m8c', 2, 'R', '2as1279427k0o', 5, 5, 2, 'R', 'rzxxa87wpnkk', 2, 'R', '288vl4ukqon4c', 0),
('administration_applications', 'db_applications', 'is_customizable', 'N', 'N', 'CH', 'Customizable', 1, 'N', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 6, 6, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 6, 6, 0, 'L', '', 0, 'L', '', 0),
('administration_applications', 'db_applications', 'is_report', 'N', 'N', 'CH', 'Is report', 1, 'N', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_applications', 'db_applications', 'excluded_tabs', 'N', 'N', 'TE', 'Excluded tabs', 1, '', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_applications', 'db_applications', 'is_quickadd', 'N', 'N', 'CH', 'Is quickadd', 1, 'N', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'company_id', 'N', 'N', 'RK', 'Company', 1, '1', '', '', '', '', 'N', 'Y', 'N', 'Y', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'company_alias', 'N', 'N', 'TE', 'Company alias', 1, '', '', '', '', '', 'N', 'Y', 'N', 'Y', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', '27lh198apmtc4', 1, 'R', '231n90dmhlz48', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'main_user_id', 'N', 'N', 'RR', 'Main user', 1, '', 'users', 'user_id', 'full_name', 'order by full_name', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', '27lh198apmtc4', 2, 'L', '231n90dmhlz48', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'billing_user_id', 'N', 'N', 'RR', 'Billing user', 1, '', 'users', 'user_id', 'full_name', 'order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', '27lh198apmtc4', 2, 'R', '231n90dmhlz48', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'company_name', 'N', 'N', 'TE', 'Company name', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '27lh198apmtc4', 1, 'L', '231n90dmhlz48', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'company_status', 'N', 'N', 'TE', 'Company status', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'appshore_version', 'N', 'N', 'DA', 'Appshore version', 1, '2010-04-20', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'license_time_stamp', 'N', 'N', 'DA', 'License time stamp', 1, '0000-00-00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'edition_id', 'N', 'N', 'DD', 'Edition', 1, 'TRIAL', 'global_editions', 'edition_id', 'edition_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'users_quota', 'N', 'N', 'TE', 'Users quota', 1, '1', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'disk_quota', 'N', 'N', 'TE', 'Disk quota', 1, '0', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'legal_status', 'N', 'N', 'TE', 'Legal status', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', '27lh198apmtc4', 3, 'L', '231n90dmhlz48', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'incorporation', 'N', 'N', 'DA', 'Incorporation', 1, '0000-00-00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 3, 'R', '27lh198apmtc4', 3, 'R', '231n90dmhlz48', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'industry_id', 'N', 'N', 'DD', 'Industry', 1, '', 'industries', 'industry_id', 'industry_name', ' order by industry_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'L', '14a5hw8dfaqs0', 4, 'L', '13z2ecyz3rnk4', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'tax_id', 'N', 'N', 'TE', 'Tax identifier', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'R', '27lh198apmtc4', 4, 'R', '231n90dmhlz48', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'fiscal_year', 'N', 'N', 'DD', 'Start of fiscal year', 1, '0', 'global_months', 'month_id', 'month_name', 'order by month_id', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'L', '27lh198apmtc4', 4, 'L', '231n90dmhlz48', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'phone', 'N', 'N', 'PH', 'Phone', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', '14a5hw8dfaqs0', 2, 'L', '13z2ecyz3rnk4', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'fax', 'N', 'N', 'TE', 'Fax', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', '14a5hw8dfaqs0', 3, 'L', '13z2ecyz3rnk4', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'url', 'N', 'N', 'WS', 'Url', 5, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'R', '14a5hw8dfaqs0', 1, 'R', '13z2ecyz3rnk4', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'email', 'N', 'N', 'WM', 'Email', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '14a5hw8dfaqs0', 1, 'L', '13z2ecyz3rnk4', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'employees', 'N', 'N', 'TE', 'Employees', 1, '0', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 5, 'L', '14a5hw8dfaqs0', 5, 'L', '13z2ecyz3rnk4', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'address_billing', 'N', 'N', 'ML', 'Address billing', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '20zqlfunr7gkc', 1, 'L', '235ca6sy1j1co', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'zipcode_billing', 'N', 'N', 'TE', 'Zipcode billing', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', '20zqlfunr7gkc', 3, 'L', '235ca6sy1j1co', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'city_billing', 'N', 'N', 'TE', 'City billing', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', '20zqlfunr7gkc', 2, 'L', '235ca6sy1j1co', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'state_billing', 'N', 'N', 'TE', 'State billing', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'L', '20zqlfunr7gkc', 4, 'L', '235ca6sy1j1co', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'country_billing', 'N', 'N', 'TE', 'Country billing', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 5, 'L', '20zqlfunr7gkc', 5, 'L', '235ca6sy1j1co', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'address_shipping', 'N', 'N', 'ML', 'Address shipping', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', '20zqlfunr7gkc', 1, 'R', '235ca6sy1j1co', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'zipcode_shipping', 'N', 'N', 'TE', 'Zipcode shipping', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'R', '20zqlfunr7gkc', 3, 'R', '235ca6sy1j1co', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'city_shipping', 'N', 'N', 'TE', 'City shipping', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', '20zqlfunr7gkc', 2, 'R', '235ca6sy1j1co', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'state_shipping', 'N', 'N', 'TE', 'State shipping', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'R', '20zqlfunr7gkc', 4, 'R', '235ca6sy1j1co', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'country_shipping', 'N', 'N', 'TE', 'Country shipping', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 5, 'R', '20zqlfunr7gkc', 5, 'R', '235ca6sy1j1co', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'administration_rbac_update', 'N', 'N', 'TS', 'Administration rbac update', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'domain_name', 'N', 'N', 'TE', 'Domain name', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'created', 'N', 'N', 'TS', 'Created', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'L', '10chwpx27p2oo', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'created_by', 'N', 'N', 'DD', 'Created by', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'updated', 'N', 'N', 'TS', 'Updated', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'R', '10chwpx27p2oo', 0, 'R', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'updated_by', 'N', 'N', 'DD', 'Updated by', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'note', 'N', 'N', 'ML', 'Note', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '2aas8afqfolcw', 1, 'L', 'ucxnz3wxz9cw', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_departments', 'departments', 'department_id', 'N', 'N', 'RK', 'Department', 1, '', '', '', '', '', 'N', 'Y', 'N', 'Y', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_departments', 'departments', 'user_id', 'N', 'N', 'DD', 'User', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_departments', 'departments', 'department_name', 'N', 'N', 'VF', 'Department name', 1, '', '', '', '', '', 'Y', 'N', 'Y', 'Y', 'Y', 1, 1, 'grid_left', 0, 'L', '', 1, 'L', '13gl8htnmtfk8', 1, 'L', '1td1tv7q19j48', 1, 1, 1, 'L', '1u92s2wst6pwg', 0, 'L', '', 1),
('administration_departments', 'departments', 'department_top_id', 'N', 'N', 'DD', 'Main department', 1, '0', 'departments', 'department_id', 'department_name', '', 'N', 'N', 'N', 'N', 'Y', 2, 2, 'grid_left', 1, 'L', 'jeriamvy7k84', 1, 'R', '13gl8htnmtfk8', 1, 'R', '1td1tv7q19j48', 0, 2, 1, 'R', '1u92s2wst6pwg', 0, 'L', '', 0),
('administration_departments', 'departments', 'manager_id', 'N', 'N', 'DD', 'Manager', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 3, 3, 'grid_left', 1, 'R', 'jeriamvy7k84', 1, 'R', '20w1kaf6130g8', 1, 'R', '10otcoc2t2uoo', 2, 3, 1, 'R', 'zwhfn2wvnb44', 0, 'L', '', 2),
('administration_departments', 'departments', 'assistant_id', 'N', 'N', 'DD', 'Assistant', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 4, 4, 'grid_left', 2, 'R', 'jeriamvy7k84', 2, 'R', '20w1kaf6130g8', 2, 'R', '10otcoc2t2uoo', 0, 4, 2, 'R', 'zwhfn2wvnb44', 0, 'L', '', 3),
('administration_departments', 'departments', 'employees', 'N', 'N', 'TE', 'Employees', 1, '0', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 7, 'grid_left', 0, 'L', '', 3, 'R', '20w1kaf6130g8', 3, 'R', '10otcoc2t2uoo', 0, 0, 3, 'R', 'zwhfn2wvnb44', 0, 'L', '', 6),
('administration_departments', 'departments', 'phone', 'N', 'N', 'PH', 'Phone', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 5, 'grid_left', 0, 'L', '', 2, 'L', '20w1kaf6130g8', 2, 'L', '10otcoc2t2uoo', 0, 5, 2, 'L', 'zwhfn2wvnb44', 0, 'L', '', 4),
('administration_departments', 'departments', 'fax', 'N', 'N', 'TE', 'Fax', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', '20w1kaf6130g8', 3, 'L', '10otcoc2t2uoo', 0, 0, 3, 'L', 'zwhfn2wvnb44', 0, 'L', '', 0),
('administration_departments', 'departments', 'email', 'N', 'N', 'WM', 'Email', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 6, 'grid_left', 0, 'L', '', 1, 'L', '20w1kaf6130g8', 1, 'L', '10otcoc2t2uoo', 0, 6, 1, 'L', 'zwhfn2wvnb44', 0, 'L', '', 5),
('administration_departments', 'departments', 'address_billing', 'N', 'N', 'ML', 'Address billing', 4, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '9dun74mq658g', 1, 'L', '10dq95245bms0', 0, 0, 1, 'L', 'so8lj5n686o', 0, 'L', '', 0),
('administration_departments', 'departments', 'zipcode_billing', 'N', 'N', 'TE', 'Zipcode billing', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'L', '9dun74mq658g', 4, 'L', '10dq95245bms0', 0, 0, 4, 'L', 'so8lj5n686o', 0, 'L', '', 0),
('administration_departments', 'departments', 'city_billing', 'N', 'N', 'TE', 'City billing', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', '9dun74mq658g', 2, 'L', '10dq95245bms0', 0, 0, 2, 'L', 'so8lj5n686o', 0, 'L', '', 0),
('administration_departments', 'departments', 'state_billing', 'N', 'N', 'TE', 'State billing', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', '9dun74mq658g', 3, 'L', '10dq95245bms0', 0, 0, 3, 'L', 'so8lj5n686o', 0, 'L', '', 0),
('administration_departments', 'departments', 'country_billing', 'N', 'N', 'TE', 'Country billing', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', 'jeriamvy7k84', 5, 'L', '9dun74mq658g', 5, 'L', '10dq95245bms0', 0, 0, 5, 'L', 'so8lj5n686o', 0, 'L', '', 0),
('administration_departments', 'departments', 'address_shipping', 'N', 'N', 'ML', 'Address shipping', 4, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', '9dun74mq658g', 1, 'R', '10dq95245bms0', 0, 0, 1, 'R', 'so8lj5n686o', 0, 'L', '', 0),
('administration_departments', 'departments', 'zipcode_shipping', 'N', 'N', 'TE', 'Zipcode shipping', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'R', '9dun74mq658g', 4, 'R', '10dq95245bms0', 0, 0, 4, 'R', 'so8lj5n686o', 0, 'L', '', 0),
('administration_departments', 'departments', 'city_shipping', 'N', 'N', 'TE', 'City shipping', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', '9dun74mq658g', 2, 'R', '10dq95245bms0', 0, 0, 2, 'R', 'so8lj5n686o', 0, 'L', '', 0),
('administration_departments', 'departments', 'state_shipping', 'N', 'N', 'TE', 'State shipping', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'R', '9dun74mq658g', 3, 'R', '10dq95245bms0', 0, 0, 3, 'R', 'so8lj5n686o', 0, 'L', '', 0),
('administration_departments', 'departments', 'country_shipping', 'N', 'N', 'TE', 'Country shipping', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 5, 'R', '9dun74mq658g', 5, 'R', '10dq95245bms0', 0, 0, 5, 'R', 'so8lj5n686o', 0, 'L', '', 0),
('administration_departments', 'departments', 'created', 'N', 'N', 'TS', 'Created', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'L', '20zqlguhbcpw0', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_departments', 'departments', 'created_by', 'N', 'N', 'DD', 'Created by', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_departments', 'departments', 'updated', 'N', 'N', 'TS', 'Updated', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'R', '20zqlguhbcpw0', 0, 'R', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_departments', 'departments', 'updated_by', 'N', 'N', 'DD', 'Updated by', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_departments', 'departments', 'note', 'N', 'N', 'ML', 'Note', 4, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', 'znv0w2rvfb4w', 1, 'L', '1i8py73yfbk0w', 0, 0, 1, 'L', '2tcjrwguxaio', 0, 'L', '', 0),
('administration_orders', 'shop_orders', 'order_id', 'N', 'N', 'RK', 'Order identifier', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '23bi5rvcomjo0', 0, 'L', '', 0, 1, 1, 'L', 'dbidytkyivc4', 0, 'L', '', 1),
('administration_orders', 'shop_orders', 'company_id', 'N', 'N', 'RR', 'Company', 1, '', 'company', 'company_id', 'company_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_orders', 'shop_orders', 'order_status', 'N', 'N', 'TE', 'Order status', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 2, 1, 'grid_center', 0, 'L', '', 2, 'R', '23bi5rvcomjo0', 0, 'L', '', 2, 0, 2, 'R', 'dbidytkyivc4', 0, 'L', '', 0),
('administration_orders', 'shop_orders', 'product_id', 'N', 'N', 'TE', 'Product id', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 2, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 2, 0, 'L', '', 0, 'L', '', 2),
('administration_orders', 'shop_orders', 'product_name', 'N', 'N', 'TE', 'Product name', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 1, 3, 'grid_left', 0, 'L', '', 1, 'L', 'zcs2y6f5i0gs', 0, 'L', '', 1, 3, 1, 'L', '1hq8xwcx46g0o', 0, 'L', '', 3),
('administration_orders', 'shop_orders', 'users_quota', 'N', 'N', 'NU', 'Users quota', 1, '0', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 4, 'grid_center', 0, 'L', '', 3, 'L', '23bi5rvcomjo0', 0, 'L', '', 0, 4, 3, 'L', 'dbidytkyivc4', 0, 'L', '', 4),
('administration_orders', 'shop_orders', 'price', 'N', 'N', 'CU', 'Price', 1, '0', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 5, 'grid_right', 0, 'L', '', 2, 'L', '23bi5rvcomjo0', 0, 'L', '', 0, 5, 2, 'L', 'dbidytkyivc4', 0, 'L', '', 5),
('administration_orders', 'shop_orders', 'period', 'N', 'N', 'TE', 'Period', 1, 'M', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_orders', 'shop_orders', 'metric', 'N', 'N', 'CH', 'Metric', 1, 'U', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_orders', 'shop_orders', 'currency_id', 'N', 'N', 'DD', 'Currency', 1, '', 'global_currencies', 'currency_id', 'currency_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_orders', 'shop_orders', 'records_quota', 'N', 'N', 'NU', 'Records quota', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 6, 'grid_right', 0, 'L', '', 4, 'L', '23bi5rvcomjo0', 0, 'L', '', 0, 6, 4, 'L', 'dbidytkyivc4', 0, 'L', '', 6),
('administration_orders', 'shop_orders', 'disk_quota', 'N', 'N', 'DS', 'Disk quota', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 7, 'grid_right', 0, 'L', '', 3, 'R', '23bi5rvcomjo0', 0, 'L', '', 0, 7, 3, 'R', 'dbidytkyivc4', 0, 'L', '', 7),
('administration_orders', 'shop_orders', 'emails_quota', 'N', 'N', 'NU', 'Emails quota', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 4, 'R', '23bi5rvcomjo0', 0, 'L', '', 0, 0, 4, 'R', 'dbidytkyivc4', 0, 'L', '', 0),
('administration_orders', 'shop_orders', 'created', 'N', 'N', 'TS', 'Created', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 3, 8, 'grid_center', 0, 'L', '', 1, 'R', '23bi5rvcomjo0', 0, 'L', '', 3, 8, 1, 'R', 'dbidytkyivc4', 0, 'L', '', 8),
('administration_orders', 'shop_orders', 'created_by', 'N', 'N', 'RR', 'Created by', 1, '0', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_orders', 'shop_orders', 'updated', 'N', 'N', 'TS', 'Updated', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_orders', 'shop_orders', 'updated_by', 'N', 'N', 'RR', 'Updated by', 1, '0', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_roles', 'roles', 'role_id', 'N', 'N', 'RK', 'Role id', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', -1, -1, 'grid_left', -1, 'L', '', -1, 'L', '', -1, 'L', '', -1, -1, -1, 'L', '', 0, 'L', '', -1),
('administration_roles', 'roles', 'role_name', 'N', 'N', 'VF', 'Role name', 1, '', '', '', '', '', 'N', 'N', 'Y', 'Y', 'Y', 1, 1, 'grid_left', 0, 'L', '', 1, 'L', 'kfploca1f5xx', 1, 'L', '1gkcujjr9bd9g', 1, 1, 1, 'L', 'va6q7b909lnr', 0, 'L', '', 1),
('administration_roles', 'roles', 'role_label', 'N', 'N', 'ML', 'Role label', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 2, 2, 'grid_left', 0, 'L', '', 1, 'L', 'tklik7v2pj24', 1, 'L', '167sih2wa79j', 2, 0, 1, 'L', '3d1tnjyi5s5h', 0, 'L', '', 2),
('administration_roles', 'roles', 'status_id', 'N', 'N', 'DD', 'Status', 1, 'D', 'roles_statuses', 'status_id', 'status_name', '', 'N', 'N', 'Y', 'N', 'Y', 3, 3, 'grid_left', 1, 'L', 'nqmmcfkdvht', 1, 'R', 'kfploca1f5xx', 1, 'R', '1gkcujjr9bd9g', 3, 2, 1, 'R', 'va6q7b909lnr', 0, 'L', '', 3),
('administration_roles', 'roles', 'created', 'N', 'N', 'TS', 'Created', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 4, 'grid_center', 0, 'L', '', 1, 'L', 'rfnsrrtgd5e', 0, 'L', '', 0, 3, 1, 'L', '1k0rm7vlcvgsq', 0, 'L', '', 4),
('administration_roles', 'roles', 'created_by', 'N', 'N', 'DD', 'Created by', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_roles', 'roles', 'updated', 'N', 'N', 'TS', 'Updated', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 5, 'grid_center', 0, 'L', '', 1, 'R', 'rfnsrrtgd5e', 0, 'R', '', 0, 4, 1, 'R', '1k0rm7vlcvgsq', 0, 'L', '', 5),
('administration_roles', 'roles', 'updated_by', 'N', 'N', 'DD', 'Updated by', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_users', 'users', 'skin_id', 'N', 'N', 'DD', 'Skin', 1, 'default', 'global_skins', 'skin_id', 'skin_name', ' order by skin_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'R', '2brr1b6lkeasw', 0, 0, 0, 'L', '13z2ehlofjuow', 0, 'L', 'da9w2y9gqxkc', 0),
('administration_users', 'users', 'send_welcome_email', 'N', 'Y', 'CH', 'Send welcome email', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 2, 'L', '13qfxwi7vfi8w', 1, 'L', '1ie69957sr40wcocc880gksgk', 1, 'L', 'kfpueqebytc0', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('administration_users', 'users', 'salutation', 'N', 'N', 'TE', 'Salutation', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', '1c3rbn2x5hb4kscgc4s44wwg8', 2, 'L', 'sif2w2u11r4g', 0, 0, 2, 'L', '1cz0xswt9tq84', 2, 'L', 'vhl12f6951c4', 0),
('administration_users', 'users', 'reset_password', 'N', 'Y', 'CH', 'Reset password', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 3, 'L', '13qfxwi7vfi8w', 2, 'R', '1ie69957sr40wcocc880gksgk', 2, 'L', 'kfpueqebytc0', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('administration_users', 'users', 'private_phone', 'N', 'N', 'TE', 'Private phone', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', 'hqrn9uvotqo80sc480s0cswo', 2, 'L', '1q6htfo3inesk', 0, 0, 0, 'L', '1pz3r2tgoyo0s', 0, 'L', 'sr1hn2m5y684', 0),
('administration_users', 'users', 'private_mobile', 'N', 'N', 'TE', 'Private mobile', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', 'hqrn9uvotqo80sc480s0cswo', 2, 'R', '1q6htfo3inesk', 0, 0, 0, 'R', '1pz3r2tgoyo0s', 0, 'R', 'sr1hn2m5y684', 0),
('administration_users', 'users', 'private_email', 'N', 'N', 'WM', 'Private email', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', 'hqrn9uvotqo80sc480s0cswo', 1, 'R', '1q6htfo3inesk', 0, 0, 0, 'R', '1pz3r2tgoyo0s', 0, 'R', 'sr1hn2m5y684', 0),
('administration_users', 'users', 'phone', 'N', 'N', 'TE', 'Phone', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 4, 'grid_left', 0, 'L', '', 4, 'L', '1c3rbn2x5hb4kscgc4s44wwg8', 4, 'L', 'sif2w2u11r4g', 0, 4, 4, 'L', '1cz0xswt9tq84', 4, 'L', 'vhl12f6951c4', 5);
INSERT INTO `db_fields` (`app_name`, `table_name`, `field_name`, `is_custom`, `is_computed`, `field_type`, `field_label`, `field_height`, `field_default`, `related_table`, `related_id`, `related_name`, `related_filter`, `is_search`, `is_readonly`, `is_mandatory`, `is_unique`, `is_visible`, `search_sequence`, `result_sequence`, `result_class`, `bulk_sequence`, `bulk_side`, `bulk_block_id`, `view_sequence`, `view_side`, `view_block_id`, `edit_sequence`, `edit_side`, `edit_block_id`, `popup_search_sequence`, `popup_result_sequence`, `popup_view_sequence`, `popup_view_side`, `popup_view_block_id`, `popup_edit_sequence`, `popup_edit_side`, `popup_edit_block_id`, `linked_sequence`) VALUES
('administration_users', 'users', 'password', 'N', 'N', 'TE', 'Password', 1, '', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_users', 'users', 'notifications_location', 'N', 'N', 'CH', 'Notifications location', 1, 'TC', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_users', 'users', 'note', 'N', 'N', 'ML', 'Note', 5, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '37tntojlesow4844cwkgo80c', 1, 'L', '1ixcu5lf30asg', 0, 0, 1, 'L', 'cqkdsoiy8hwg', 1, 'L', 'dxofjnamwhs0', 0),
('administration_users', 'users', 'nbrecords', 'N', 'N', 'DD', 'Lines displayed', 1, '10', 'global_lines', 'line_id', 'line_name', 'order by line_name', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 5, 'R', 'y1n6wqpj9mskwws4w8s48gc', 5, 'R', '2brr1b6lkeasw', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_users', 'users', 'mobile', 'N', 'N', 'TE', 'Mobile', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 5, 'grid_left', 0, 'L', '', 3, 'L', '1c3rbn2x5hb4kscgc4s44wwg8', 3, 'L', 'sif2w2u11r4g', 0, 5, 3, 'L', '1cz0xswt9tq84', 3, 'L', 'vhl12f6951c4', 6),
('administration_users', 'users', 'manager_id', 'N', 'N', 'DD', 'Manager', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 2, 'R', '13qfxwi7vfi8w', 5, 'R', '1c3rbn2x5hb4kscgc4s44wwg8', 5, 'R', 'sif2w2u11r4g', 4, 0, 5, 'R', '1cz0xswt9tq84', 5, 'R', 'vhl12f6951c4', 0),
('administration_users', 'users', 'locale_time_id', 'N', 'N', 'DD', 'Time format', 1, 'en_US', 'global_locales_time', 'time_id', 'time_label', ' order by time_label', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'R', 'y1n6wqpj9mskwws4w8s48gc', 4, 'R', '2brr1b6lkeasw', 0, 0, 0, 'L', '13z2ehlofjuow', 0, 'L', 'da9w2y9gqxkc', 0),
('administration_users', 'users', 'locale_date_id', 'N', 'N', 'DD', 'Date format', 1, 'en_US', 'global_locales_date', 'date_id', 'date_label', ' order by date_label', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'R', 'y1n6wqpj9mskwws4w8s48gc', 3, 'R', '2brr1b6lkeasw', 0, 0, 0, 'L', '13z2ehlofjuow', 0, 'L', 'da9w2y9gqxkc', 0),
('administration_users', 'users', 'last_password_change', 'N', 'N', 'TS', 'Last password change', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'R', 'xpbxva0hj2so0ok840gsk4w', 1, 'R', '1r2irncvnack0', 0, 0, 0, 'R', '1lmo16svlpdwo', 0, 'L', '', 0),
('administration_users', 'users', 'last_name', 'N', 'N', 'VF', 'Last name', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', '1c3rbn2x5hb4kscgc4s44wwg8', 1, 'R', 'sif2w2u11r4g', 0, 0, 1, 'R', '1cz0xswt9tq84', 1, 'R', 'vhl12f6951c4', 3),
('administration_users', 'users', 'last_login', 'N', 'N', 'TS', 'Last login', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 8, 'grid_center', 0, 'L', '', 1, 'L', 'xpbxva0hj2so0ok840gsk4w', 1, 'L', '1r2irncvnack0', 0, 0, 0, 'L', '1lmo16svlpdwo', 0, 'L', '', 0),
('administration_users', 'users', 'language_id', 'N', 'N', 'DD', 'Language', 1, 'en', 'global_languages', 'language_id', 'language_name', ' order by language_id', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', 'y1n6wqpj9mskwws4w8s48gc', 1, 'R', '2brr1b6lkeasw', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('administration_users', 'users', 'is_salespeople', 'N', 'N', 'CH', 'Sales people', 1, 'N', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '13qfxwi7vfi8w', 3, 'R', '1c3rbn2x5hb4kscgc4s44wwg8', 3, 'R', 'sif2w2u11r4g', 0, 0, 3, 'R', '1cz0xswt9tq84', 3, 'R', 'vhl12f6951c4', 0),
('administration_users', 'users', 'ipacl', 'N', 'N', 'TE', 'Ipacl', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_users', 'users', 'initial_role_id', 'N', 'N', 'DD', 'Initial role', 1, '', 'roles', 'role_id', 'role_name', 'order by role_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 2, 'L', '13qfxwi7vfi8w', 1, 'R', '1ie69957sr40wcocc880gksgk', 1, 'R', 'kfpueqebytc0', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('administration_users', 'users', 'full_name', 'N', 'N', 'TE', 'Full name', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 2, 3, 'grid_left', 0, 'L', '', 0, 'L', '9gba8zpqcnwg', 0, 'L', '', 2, 2, 0, 'L', '', 0, 'L', '', 0),
('administration_users', 'users', 'first_names', 'N', 'N', 'VF', 'First name', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '1c3rbn2x5hb4kscgc4s44wwg8', 1, 'L', 'sif2w2u11r4g', 0, 0, 1, 'L', '1cz0xswt9tq84', 1, 'L', 'vhl12f6951c4', 2),
('administration_users', 'users', 'fax', 'N', 'N', 'TE', 'Fax', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 6, 'L', '1c3rbn2x5hb4kscgc4s44wwg8', 6, 'L', 'sif2w2u11r4g', 0, 0, 6, 'L', '1cz0xswt9tq84', 6, 'L', 'vhl12f6951c4', 0),
('administration_users', 'users', 'created', 'N', 'N', 'TS', 'Created', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '1bcrvou4l58g40cogogkos44c', 0, 'L', '', 0, 0, 0, 'L', '1lmo16svlpdwo', 0, 'L', '', 0),
('administration_users', 'users', 'created_by', 'N', 'N', 'RR', 'Created by', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_users', 'users', 'currency_id', 'N', 'N', 'DD', 'Currency', 1, 'USD', 'global_currencies', 'currency_id', 'currency_name', ' order by currency_name', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'L', 'y1n6wqpj9mskwws4w8s48gc', 4, 'L', '2brr1b6lkeasw', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('administration_users', 'users', 'department_id', 'N', 'N', 'DD', 'Department', 1, '', 'departments', 'department_id', 'department_name', '', 'N', 'N', 'N', 'N', 'Y', 4, 7, 'grid_left', 3, 'R', '13qfxwi7vfi8w', 4, 'R', '1c3rbn2x5hb4kscgc4s44wwg8', 4, 'R', 'sif2w2u11r4g', 3, 3, 4, 'R', '1cz0xswt9tq84', 4, 'R', 'vhl12f6951c4', 4),
('administration_users', 'users', 'email', 'N', 'N', 'WM', 'Email', 1, '', '', '', '', '', 'N', 'N', 'Y', 'Y', 'Y', 3, 6, 'grid_left', 0, 'L', '', 5, 'L', '1c3rbn2x5hb4kscgc4s44wwg8', 5, 'L', 'sif2w2u11r4g', 0, 6, 5, 'L', '1cz0xswt9tq84', 5, 'L', 'vhl12f6951c4', 7),
('administration_users', 'users', 'confirm_delete', 'N', 'N', 'CH', 'Confirm delete', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '13qfxwi7vfi8w', 5, 'L', 'y1n6wqpj9mskwws4w8s48gc', 5, 'L', '2brr1b6lkeasw', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('administration_users', 'users', 'charset_id', 'N', 'N', 'DD', 'Character set', 1, 'UTF-8', 'global_charsets', 'charset_id', 'charset_name', 'order by charset_name', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', 'y1n6wqpj9mskwws4w8s48gc', 2, 'R', '2brr1b6lkeasw', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_users', 'users', 'birthdate', 'N', 'N', 'DA', 'Date of birth', 1, '0000-00-00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', 'hqrn9uvotqo80sc480s0cswo', 1, 'L', '1q6htfo3inesk', 0, 0, 0, 'L', '1pz3r2tgoyo0s', 0, 'L', 'sr1hn2m5y684', 0),
('administration_users', 'users', 'avatar', 'N', 'N', 'IM', 'Avatar', 9, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 1, 'grid_center', 0, 'L', '', 1, 'R', '13aq5ko2z6m8w0gws4g4s00w8', 1, 'R', '1s9mtebmfoo0o', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_users', 'users', 'assistant_id', 'N', 'N', 'DD', 'Assistant', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 1, 'R', '13qfxwi7vfi8w', 6, 'R', '1c3rbn2x5hb4kscgc4s44wwg8', 6, 'R', 'sif2w2u11r4g', 5, 0, 6, 'R', '1cz0xswt9tq84', 6, 'R', 'vhl12f6951c4', 0),
('administration_users', 'users', 'app_name', 'N', 'N', 'DD', 'Default application', 1, 'api', 'db_applications', 'app_name', 'app_label', 'where is_visible = "Y" and status_id = "A" order by app_label', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', 'y1n6wqpj9mskwws4w8s48gc', 1, 'L', '2brr1b6lkeasw', 0, 0, 0, 'L', '13z2ehlofjuow', 0, 'L', 'da9w2y9gqxkc', 0),
('administration_users', 'users', 'status_id', 'N', 'N', 'DD', 'User status', 1, 'A', 'users_statuses', 'status_id', 'status_name', 'where status_id in ("A","D") order by status_name', 'N', 'N', 'Y', 'N', 'Y', 5, 9, 'grid_left', 1, 'L', '13qfxwi7vfi8w', 2, 'L', '13aq5ko2z6m8w0gws4g4s00w8', 2, 'L', '1s9mtebmfoo0o', 0, 0, 0, 'R', '1bwu9iw9qois8', 0, 'R', '1lp4pvgw4f8k0', 8),
('administration_users', 'users', 'theme_id', 'N', 'N', 'DD', 'Theme', 1, 'default', 'global_themes', 'theme_id', 'theme_name', ' order by theme_name', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', 'y1n6wqpj9mskwws4w8s48gc', 2, 'L', '2brr1b6lkeasw', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('administration_users', 'users', 'timezone_id', 'N', 'Y', 'DD', 'Timezone', 1, '225', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', 'y1n6wqpj9mskwws4w8s48gc', 3, 'L', '2brr1b6lkeasw', 0, 0, 0, 'L', '13z2ehlofjuow', 0, 'L', 'da9w2y9gqxkc', 0),
('administration_users', 'users', 'title', 'N', 'N', 'TE', 'Title', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', '1c3rbn2x5hb4kscgc4s44wwg8', 2, 'R', 'sif2w2u11r4g', 0, 0, 2, 'R', '1cz0xswt9tq84', 2, 'R', 'vhl12f6951c4', 0),
('administration_users', 'users', 'updated', 'N', 'N', 'TS', 'Updated', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'R', '1bcrvou4l58g40cogogkos44c', 0, 'R', '', 0, 0, 0, 'R', '1lmo16svlpdwo', 0, 'L', '', 0),
('administration_users', 'users', 'updated_by', 'N', 'N', 'RR', 'Updated by', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_users', 'users', 'user_id', 'N', 'N', 'RK', 'User identifier', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', '13aq5ko2z6m8w0gws4g4s00w8', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_users', 'users', 'user_name', 'N', 'N', 'VF', 'User name', 1, '', '', '', '', '', 'N', 'N', 'Y', 'Y', 'Y', 1, 2, 'grid_left', 0, 'L', '', 1, 'L', '13aq5ko2z6m8w0gws4g4s00w8', 1, 'L', '1s9mtebmfoo0o', 1, 1, 1, 'L', '1kfjzfu4tbb4s', 1, 'L', '1op6wuzxu9fo', 1),
('campaigns', 'campaigns', 'status_id', 'N', 'N', 'DD', 'Status', 1, '0', 'campaigns_statuses', 'status_id', 'status_name', ' order by status_name', 'N', 'N', 'N', 'N', 'Y', 3, 4, 'grid_left', 1, 'R', 'k0xgrf3iadmt', 2, 'L', '27fb2uq07lxco', 2, 'L', '14a59bjpcswkp', 3, 4, 0, 'L', '19q0euv7eaj2x', 2, 'L', '1gqj38bubfpcw', 4),
('campaigns', 'campaigns', 'updated_by', 'N', 'N', 'DD', 'Updated by', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('campaigns', 'campaigns', 'updated', 'N', 'N', 'TS', 'Updated', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 6, 'grid_center', 0, 'L', '', 1, 'R', '1ajk9ce7aq70g', 0, 'R', '', 0, 7, 0, 'L', '', 0, 'L', '', 7),
('campaigns', 'campaigns', 'created_by', 'N', 'N', 'DD', 'Created by', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('campaigns', 'campaigns', 'created', 'N', 'N', 'TS', 'Created', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'L', '1ajk9ce7aq70g', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('campaigns', 'campaigns', 'note', 'N', 'N', 'ML', 'Note', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'L', '27z0l4zptuv4s', 1, 'L', '6l821sj5q4kko0wk0sko4cgk', 0, 0, 2, 'L', '1l6nqge1in6u3', 2, 'L', 'kvqli98xqv44', 0),
('campaigns', 'campaigns', 'body_html', 'N', 'N', 'EA', 'Body html', 15, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', '27z0l4zptuv4s', 2, 'L', '27k8gaej7800c', 0, 0, 0, 'L', '1l6nqge1in6u3', 0, 'L', 'kvqli98xqv44', 0),
('campaigns', 'campaigns', 'body_text', 'N', 'N', 'ET', 'Body text', 15, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', '27z0l4zptuv4s', 3, 'L', '27k8gaej7800c', 0, 0, 0, 'L', '1l6nqge1in6u3', 0, 'L', 'kvqli98xqv44', 0),
('campaigns', 'campaigns', 'subject', 'N', 'N', 'VF', 'Subject', 1, '', '', '', '', '', 'Y', 'N', 'Y', 'N', 'Y', 2, 2, 'grid_left', 0, 'L', '', 1, 'L', '27z0l4zptuv4s', 1, 'L', '27k8gaej7800c', 2, 2, 1, 'L', '1l6nqge1in6u3', 1, 'L', 'kvqli98xqv44', 2),
('campaigns', 'campaigns', 'list_id', 'N', 'N', 'RR', 'List', 1, '', 'campaigns_lists', 'list_id', 'list_name', '', 'N', 'N', 'N', 'N', 'Y', 4, 3, 'grid_left', 0, 'L', 'k0xgrf3iadmt', 1, 'R', '27fb2uq07lxco', 1, 'R', '14a59bjpcswkp', 5, 3, 0, 'R', '19q0euv7eaj2x', 1, 'R', '1gqj38bubfpcw', 3),
('campaigns', 'campaigns', 'type_id', 'N', 'N', 'DD', 'Type', 1, '', 'campaigns_types', 'type_id', 'type_name', ' order by type_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 2, 'L', 'k0xgrf3iadmt', 2, 'R', '27fb2uq07lxco', 2, 'R', '14a59bjpcswkp', 4, 5, 0, 'R', '19q0euv7eaj2x', 2, 'R', '1gqj38bubfpcw', 5),
('campaigns', 'campaigns', 'from_name', 'N', 'N', 'TE', 'From name', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'R', '27fb2uq07lxco', 3, 'R', '14a59bjpcswkp', 0, 0, 0, 'R', '19q0euv7eaj2x', 3, 'R', '1gqj38bubfpcw', 0),
('campaigns', 'campaigns', 'from_email', 'N', 'N', 'TE', 'From email', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', '27fb2uq07lxco', 3, 'L', '14a59bjpcswkp', 0, 0, 0, 'L', '19q0euv7eaj2x', 3, 'L', '1gqj38bubfpcw', 0),
('campaigns', 'campaigns', 'campaign_name', 'N', 'N', 'VF', 'Campaign name', 1, '', '', '', '', '', 'Y', 'N', 'Y', 'N', 'Y', 1, 1, 'grid_left', 0, 'L', '', 1, 'L', '27fb2uq07lxco', 1, 'L', '14a59bjpcswkp', 1, 1, 0, 'L', '19q0euv7eaj2x', 1, 'L', '1gqj38bubfpcw', 1),
('campaigns', 'campaigns', 'user_id', 'N', 'N', 'DD', 'Owner', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 5, 5, 'grid_left', 1, 'L', 'k0xgrf3iadmt', 0, 'L', '', 0, 'L', '', 6, 6, 0, 'L', '', 0, 'L', '', 6),
('campaigns', 'campaigns', 'campaign_id', 'N', 'N', 'RK', 'Campaign', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', -1, -1, 'grid_left', -1, 'L', '', -1, 'L', '', -1, 'L', '', -1, -1, -1, 'L', '', 0, 'L', '', -1),
('campaigns_history', 'campaigns_history_view', 'list_name', 'N', 'N', 'TE', 'List name', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 2, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 2, 0, 0, 'L', '', 0, 'L', '', 0),
('campaigns_history', 'campaigns_history_view', 'rejected', 'N', 'N', 'NU', 'Rejected', 1, '0', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 5, 'grid_right', 0, 'L', '', 3, 'R', 'i3y793uom34u', 3, 'R', '1tgqmyfq4hixb', 0, 4, 3, 'R', 'r552zjxezsso', 3, 'R', '1pljqkenloetb', 4),
('campaigns_history', 'campaigns_history_view', 'campaign_name', 'N', 'N', 'TE', 'Campaign name', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 1, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 1, 0, 0, 'L', '', 0, 'L', '', 0),
('campaigns_history', 'campaigns_history_view', 'campaign_id', 'N', 'N', 'RR', 'Campaign', 1, '', 'campaigns', 'campaign_id', 'campaign_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 1, 'grid_left', 0, 'L', '', 1, 'L', 'i3y793uom34u', 1, 'L', '1tgqmyfq4hixb', 0, 1, 1, 'L', 'r552zjxezsso', 1, 'L', '1pljqkenloetb', 1),
('campaigns_history', 'campaigns_history_view', 'created_by', 'N', 'N', 'DD', 'Owner', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 4, 7, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 3, 0, 0, 'L', '', 0, 'L', '', 0),
('campaigns_history', 'campaigns_history_view', 'list_id', 'N', 'N', 'RR', 'List', 1, '', 'campaigns_lists', 'list_id', 'list_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 2, 'grid_left', 0, 'L', '', 1, 'R', 'i3y793uom34u', 1, 'R', '1tgqmyfq4hixb', 0, 2, 1, 'R', 'r552zjxezsso', 1, 'R', '1pljqkenloetb', 2),
('campaigns_history', 'campaigns_history_view', 'records', 'N', 'N', 'NU', 'Records', 1, '0', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 4, 'grid_right', 0, 'L', '', 2, 'R', 'i3y793uom34u', 2, 'R', '1tgqmyfq4hixb', 0, 3, 2, 'R', 'r552zjxezsso', 2, 'R', '1pljqkenloetb', 3),
('campaigns_history', 'campaigns_history_view', 'note', 'N', 'N', 'ML', 'Note', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 3, 'grid_left', 0, 'L', '', 1, 'L', '7q5swwstwsu', 1, 'L', '2awy7asa6su88', 0, 0, 1, 'L', 's4v2do13jpo0', 1, 'L', 'b27acvnimo3f', 0),
('campaigns_history', 'campaigns_history_view', 'created', 'N', 'N', 'TS', 'Created', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 3, 6, 'grid_center', 0, 'L', '', 2, 'L', 'i3y793uom34u', 0, 'L', '', 0, 5, 2, 'L', 'r552zjxezsso', 0, 'L', '', 5),
('campaigns_lists', 'campaigns_lists', 'records_count', 'N', 'N', 'TE', 'Records', 1, '0', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 2, 'grid_center', 0, 'L', '', 1, 'R', '18xo2pz1dxkkb', 0, 'R', '', 0, 4, 0, 'L', '', 0, 'R', '', 4),
('campaigns_lists', 'campaigns_lists', 'list_id', 'N', 'N', 'RK', 'List', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', -1, -1, 'grid_left', -1, 'L', '', -1, 'L', '', -1, 'L', '', -1, -1, -1, 'L', '', 0, 'L', '', 0),
('campaigns_lists', 'campaigns_lists', 'user_id', 'N', 'N', 'DD', 'Owner', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 3, 3, 'grid_left', 1, 'L', 'toajip9gywa2', 0, 'L', '', 0, 'L', '', 3, 3, 0, 'L', '', 0, 'L', '', 3),
('campaigns_lists', 'campaigns_lists', 'list_name', 'N', 'N', 'VF', 'List name', 1, '', '', '', '', '', 'Y', 'N', 'Y', 'N', 'Y', 1, 1, 'grid_left', 0, 'L', '', 1, 'L', '13ka11p7j9dec', 1, 'L', '9v3838ugdu1r', 1, 1, 1, 'L', 'lz534sbpo3d5', 1, 'L', '26vll517dx0kc', 1),
('campaigns_lists', 'campaigns_lists', 'status_id', 'N', 'N', 'DD', 'Status', 1, '', 'campaigns_lists_statuses', 'status_id', 'status_name', ' order by status_name', 'N', 'N', 'N', 'N', 'Y', 2, 2, 'grid_left', 1, 'R', 'toajip9gywa2', 1, 'R', '13ka11p7j9dec', 1, 'R', '9v3838ugdu1r', 2, 2, 1, 'R', 'lz534sbpo3d5', 1, 'R', '26vll517dx0kc', 2),
('campaigns_lists', 'campaigns_lists', 'note', 'N', 'N', 'ML', 'Note', 4, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', 'rhgidmfukuel', 1, 'L', '210yp94bljb40', 0, 0, 1, 'L', 'mrh061sae1y1', 1, 'L', '19hdlqkspg8qp', 0),
('campaigns_lists', 'campaigns_lists', 'created', 'N', 'N', 'TS', 'Created', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'L', '18xo2pz1dxkkb', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('campaigns_lists', 'campaigns_lists', 'created_by', 'N', 'N', 'DD', 'Created by', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('campaigns_lists', 'campaigns_lists', 'updated', 'N', 'N', 'TS', 'Updated', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 4, 'grid_center', 0, 'L', '', 1, 'R', '18xo2pz1dxkkb', 0, 'R', '', 0, 4, 0, 'L', '', 0, 'R', '', 4),
('campaigns_lists', 'campaigns_lists', 'updated_by', 'N', 'N', 'DD', 'Updated by', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 5, 'grid_left', 0, 'L', '', 0, 'R', '', 0, 'R', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('campaigns_records', 'campaigns_records_view', 'first_names', 'N', 'N', 'TE', 'First name', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('campaigns_records', 'campaigns_records_view', 'last_name', 'N', 'N', 'TE', 'Last name', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('campaigns_records', 'campaigns_records_view', 'salutation', 'N', 'N', 'TE', 'Salutation', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('campaigns_records', 'campaigns_records_view', 'record_type_id', 'N', 'N', 'DD', 'Record type', 1, '', 'campaigns_records_types', 'type_id', 'type_name', ' order by type_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('campaigns_records', 'campaigns_records_view', 'list_id', 'N', 'N', 'DD', 'List', 1, '', 'campaigns_lists', 'list_id', 'list_name', ' order by list_name', 'N', 'N', 'N', 'N', 'Y', 1, 1, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 1, 0, 0, 'L', '', 0, 'L', '', 0),
('campaigns_records', 'campaigns_records_view', 'record_id', 'N', 'N', 'TE', 'Record', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('campaigns_records', 'campaigns_records_view', 'record_name', 'N', 'N', 'VF', 'Record name', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 2, 1, 'grid_left', 0, 'L', '', 1, 'L', 'jygs8nj6taey', 1, 'L', 's7bqwudj4dyi', 2, 1, 1, 'L', '1uhoyhl4orcdz', 0, 'L', '', 1),
('campaigns_records', 'campaigns_records_view', 'email', 'N', 'N', 'WM', 'Email', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 3, 2, 'grid_left', 0, 'L', '1cqealyh2b8uz', 2, 'L', 'ubp39my99327', 2, 'L', 'k1li7xu4xoh', 0, 2, 2, 'L', '3wrc04h0hsja', 0, 'L', '', 2),
('campaigns_records', 'campaigns_records_view', 'email_opt_out', 'N', 'N', 'CH', 'Email opt out', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 4, 3, 'grid_center', 1, 'L', 'lllb3nixq3qc', 3, 'L', 'ubp39my99327', 3, 'L', 'k1li7xu4xoh', 3, 3, 3, 'L', '3wrc04h0hsja', 0, 'L', '', 3),
('campaigns_records', 'campaigns_records_view', 'do_not_call', 'N', 'N', 'CH', 'Do not call', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 4, 6, 'grid_center', 2, 'L', 'lllb3nixq3qc', 3, 'R', 'ubp39my99327', 3, 'R', 'k1li7xu4xoh', 4, 6, 3, 'R', '3wrc04h0hsja', 0, 'L', '', 6),
('campaigns_records', 'campaigns_records_view', 'phone', 'N', 'N', 'PH', 'Phone', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 4, 'grid_left', 0, 'L', '', 1, 'R', 'ubp39my99327', 1, 'R', 'k1li7xu4xoh', 0, 4, 1, 'R', '3wrc04h0hsja', 0, 'L', '', 4),
('campaigns_records', 'campaigns_records_view', 'mobile', 'N', 'N', 'PH', 'Mobile', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 5, 'grid_left', 0, 'L', '', 2, 'R', 'ubp39my99327', 2, 'R', 'k1li7xu4xoh', 0, 5, 2, 'R', '3wrc04h0hsja', 0, 'L', '', 5),
('campaigns_records', 'campaigns_records_view', 'created', 'N', 'N', 'TS', 'Created', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'L', '1pvehgfl9t5qr', 0, 'L', '', 0, 0, 1, 'L', '2a4ma0f0n5usc', 0, 'L', '', 0),
('campaigns_records', 'campaigns_records_view', 'updated', 'N', 'N', 'TS', 'Updated', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'R', '1pvehgfl9t5qr', 0, 'R', '', 0, 0, 1, 'R', '2a4ma0f0n5usc', 0, 'L', '', 0),
('campaigns_records', 'campaigns_records_view', 'user_id', 'N', 'N', 'DD', 'Owner', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 7, 9, 'grid_left', 2, 'R', 'lllb3nixq3qc', 0, 'L', '', 0, 'L', '', 7, 0, 0, 'L', '', 0, 'L', '', 0),
('campaigns_records', 'campaigns_records_view', 'status_id', 'N', 'N', 'DD', 'Status', 1, '', 'campaigns_lists_statuses', 'status_id', 'status_name', ' order by status_name', 'N', 'N', 'N', 'N', 'Y', 5, 7, 'grid_left', 1, 'R', 'lllb3nixq3qc', 1, 'L', 'ubp39my99327', 1, 'L', 'k1li7xu4xoh', 5, 7, 1, 'L', '3wrc04h0hsja', 0, 'L', '', 7),
('campaigns_records', 'campaigns_records_view', 'account_name', 'N', 'N', 'TE', 'Account name', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('cases', 'cases', 'updated_by', 'N', 'N', 'DD', 'Updated by', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'R', '12jblwzk5m3jx', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('cases', 'cases', 'updated', 'N', 'N', 'TS', 'Last update', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'R', '12jblwzk5m3jx', 0, 'R', 'f7p3oyrij7wo0o0so4kgwk0w', 0, 0, 0, 'R', '11hbtvcfdmhw0gkogckkg848s', 0, 'L', '', 0),
('cases', 'cases', 'created_by', 'N', 'N', 'DD', 'Created by', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '12jblwzk5m3jx', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('cases', 'cases', 'created', 'N', 'N', 'TS', 'Created', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'L', '12jblwzk5m3jx', 0, 'L', 'f7p3oyrij7wo0o0so4kgwk0w', 0, 0, 0, 'L', '11hbtvcfdmhw0gkogckkg848s', 0, 'L', '', 0),
('cases', 'cases', 'due_date', 'N', 'N', 'DA', 'Due date', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 6, 6, 'grid_center', 1, 'R', '1appthrik4ncl', 2, 'L', '1dw97f8ekybook0kwwco0cs8w', 2, 'L', '4g3csfbf0gw0swkgg8s84c00', 6, 6, 2, 'L', '1gejj17ggcw0wok44sok0oks8', 2, 'L', '4v6tcv5b4o4k4g0448w48gk4', 6),
('cases', 'cases', 'priority_id', 'N', 'N', 'DD', 'Priority', 1, '', 'cases_priorities', 'priority_id', 'priority_name', 'order by priority_sequence', 'N', 'N', 'N', 'N', 'Y', 1, 1, 'grid_left', 2, 'R', '1appthrik4ncl', 2, 'R', '1dw97f8ekybook0kwwco0cs8w', 2, 'R', '4g3csfbf0gw0swkgg8s84c00', 1, 1, 2, 'R', '1gejj17ggcw0wok44sok0oks8', 2, 'R', '4v6tcv5b4o4k4g0448w48gk4', 1),
('cases', 'cases', 'note', 'N', 'N', 'ML', 'Note', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '1lnw1iacxacgm', 1, 'L', '17pyhosyerusc888wccgkwgcs', 0, 0, 1, 'L', '1dbm5hli4akg888800ss88sg8', 1, 'L', '3cx343d7xmecskg0gc80kc4k', 0),
('cases', 'cases', 'subject', 'N', 'N', 'VF', 'Subject', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 2, 2, 'grid_left', 0, 'L', '', 1, 'L', '1dw97f8ekybook0kwwco0cs8w', 1, 'L', '4g3csfbf0gw0swkgg8s84c00', 2, 2, 1, 'L', '1gejj17ggcw0wok44sok0oks8', 1, 'L', '4v6tcv5b4o4k4g0448w48gk4', 2),
('cases', 'cases', 'status_id', 'N', 'N', 'DD', 'Status', 1, '', 'cases_statuses', 'status_id', 'status_name', 'order by status_name', 'N', 'N', 'N', 'N', 'Y', 5, 5, 'grid_left', 2, 'L', '1appthrik4ncl', 1, 'R', '1dw97f8ekybook0kwwco0cs8w', 1, 'R', '4g3csfbf0gw0swkgg8s84c00', 5, 5, 1, 'R', '1gejj17ggcw0wok44sok0oks8', 1, 'R', '4v6tcv5b4o4k4g0448w48gk4', 5),
('cases', 'cases', 'user_id', 'N', 'N', 'DD', 'Owner', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 7, 7, 'grid_left', 1, 'L', '1appthrik4ncl', 0, 'L', '', 0, 'L', '', 7, 7, 0, 'L', '', 0, 'L', '', 7),
('cases', 'cases', 'case_id', 'N', 'N', 'RK', 'Case id', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', -1, -1, 'grid_left', -1, 'L', '', -1, 'L', '', -1, 'L', '', -1, -1, -1, 'L', '', 0, 'L', '', -1),
('cases', 'cases', 'account_id', 'N', 'N', 'RR', 'Account', 1, '', 'accounts', 'account_id', 'account_name', '', 'N', 'N', 'N', 'N', 'Y', 3, 3, 'grid_left', 0, 'L', '', 1, 'L', 'sh6efa3xi81h', 1, 'L', '16osxxjt0xa88kk8o08ocwkk8', 3, 3, 1, 'L', '196y9w2fexes8wsw4oc044cg0', 1, 'L', '9bpus7sow3cwkc8sc0kkw8gs', 3),
('cases', 'cases', 'contact_id', 'N', 'N', 'RR', 'Contact', 1, '', 'contacts', 'contact_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 4, 4, 'grid_left', 0, 'L', '', 1, 'R', 'sh6efa3xi81h', 1, 'R', '16osxxjt0xa88kk8o08ocwkk8', 4, 4, 1, 'R', '196y9w2fexes8wsw4oc044cg0', 1, 'R', '9bpus7sow3cwkc8sc0kkw8gs', 4),
('contacts', 'contacts', 'updated_by', 'N', 'N', 'DD', 'Updated by', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', -1, 'L', '', 0, 'R', '10eyk1zxqe6oc', 0, 'R', '4aibepnt2l4wsw0s4kkg0cgc', 0, 0, 0, 'L', '', 0, 'R', 'fn3ns2i70xkwk0csgw880kk', 0),
('contacts', 'contacts', 'updated', 'N', 'N', 'TS', 'Last update', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_center', -1, 'L', '', 1, 'R', '1w7wkhy1nqf4sgkg8sco0oskk', 0, 'R', '4aibepnt2l4wsw0s4kkg0cgc', 0, 0, 0, 'L', '', 0, 'R', 'fn3ns2i70xkwk0csgw880kk', 0),
('contacts', 'contacts', 'created_by', 'N', 'N', 'DD', 'Created by', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', -1, 'L', '', 0, 'L', '10eyk1zxqe6oc', 0, 'L', '4aibepnt2l4wsw0s4kkg0cgc', 0, 0, 0, 'L', '', 0, 'L', 'fn3ns2i70xkwk0csgw880kk', 0),
('contacts', 'contacts', 'created', 'N', 'N', 'TS', 'Created', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_center', -1, 'L', '', 1, 'L', '1w7wkhy1nqf4sgkg8sco0oskk', 0, 'L', '4aibepnt2l4wsw0s4kkg0cgc', 0, 0, 0, 'L', '', 0, 'L', 'fn3ns2i70xkwk0csgw880kk', 0),
('contacts', 'contacts', 'note', 'N', 'N', 'ML', 'Note', 4, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', 'yyb4pm6fmisgo8k0c8skg0wc', 1, 'L', '1bovsnoc3c2s4gogoo0s00sc4', 0, 0, 1, 'L', 'b6ywoe2ecygcgogks0gwwss0', 1, 'L', '17gnkyhd5of4kos4ws848g8cc', 0),
('contacts', 'contacts', 'state_2', 'N', 'N', 'TE', 'Secondary state', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'R', 'dvnwsbnv9soc80wkogg0k4o8', 3, 'R', 'hcdvji9mj9s84swc404ks888', 0, 0, 0, 'L', '', 0, 'R', '16rgdbpzv3408c40sosg08cgc', 0),
('contacts', 'contacts', 'country_2', 'N', 'N', 'TE', 'Secondary country', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 5, 'R', 'dvnwsbnv9soc80wkogg0k4o8', 5, 'R', 'hcdvji9mj9s84swc404ks888', 0, 0, 0, 'L', '', 0, 'R', '16rgdbpzv3408c40sosg08cgc', 0),
('contacts', 'contacts', 'city_2', 'N', 'N', 'TE', 'Secondary city', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', 'dvnwsbnv9soc80wkogg0k4o8', 2, 'R', 'hcdvji9mj9s84swc404ks888', 0, 0, 0, 'L', '', 0, 'R', '16rgdbpzv3408c40sosg08cgc', 0),
('contacts', 'contacts', 'zipcode_2', 'N', 'N', 'TE', 'Secondary zipcode', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'R', 'dvnwsbnv9soc80wkogg0k4o8', 4, 'R', 'hcdvji9mj9s84swc404ks888', 0, 0, 0, 'L', '', 0, 'R', '16rgdbpzv3408c40sosg08cgc', 0),
('contacts', 'contacts', 'address_2', 'N', 'N', 'ML', 'Secondary address', 4, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', 'dvnwsbnv9soc80wkogg0k4o8', 1, 'R', 'hcdvji9mj9s84swc404ks888', 0, 0, 0, 'L', '', 0, 'R', '16rgdbpzv3408c40sosg08cgc', 0),
('contacts', 'contacts', 'country_1', 'N', 'N', 'TE', 'Primary country', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 5, 'L', 'dvnwsbnv9soc80wkogg0k4o8', 5, 'L', 'hcdvji9mj9s84swc404ks888', 0, 0, 0, 'L', '', 4, 'R', '16rgdbpzv3408c40sosg08cgc', 0),
('contacts', 'contacts', 'state_1', 'N', 'N', 'TE', 'Primary state', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', 'dvnwsbnv9soc80wkogg0k4o8', 3, 'L', 'hcdvji9mj9s84swc404ks888', 0, 0, 0, 'L', '', 2, 'R', '16rgdbpzv3408c40sosg08cgc', 0),
('contacts', 'contacts', 'city_1', 'N', 'N', 'TE', 'Primary city', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', 'dvnwsbnv9soc80wkogg0k4o8', 2, 'L', 'hcdvji9mj9s84swc404ks888', 0, 0, 0, 'L', '', 1, 'R', '16rgdbpzv3408c40sosg08cgc', 0),
('contacts', 'contacts', 'zipcode_1', 'N', 'N', 'TE', 'Primary zipcode', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'L', 'dvnwsbnv9soc80wkogg0k4o8', 4, 'L', 'hcdvji9mj9s84swc404ks888', 0, 0, 0, 'L', '', 3, 'R', '16rgdbpzv3408c40sosg08cgc', 0),
('contacts', 'contacts', 'address_1', 'N', 'N', 'ML', 'Primary address', 4, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', 'dvnwsbnv9soc80wkogg0k4o8', 1, 'L', 'hcdvji9mj9s84swc404ks888', 0, 0, 0, 'L', '', 1, 'L', '16rgdbpzv3408c40sosg08cgc', 0),
('contacts', 'contacts', 'birthdate', 'N', 'N', 'DA', 'Date of birth', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'L', '2xiy1hy8fzuock808440kcok', 1, 'L', 'cyshqwfm2vc4cow44sg4ock4', 0, 0, 0, 'L', '', 0, 'L', '1yll0cx50jgg8s0ss48w44s4w', 0),
('contacts', 'contacts', 'private_mobile', 'N', 'N', 'PH', 'Private mobile', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', '2xiy1hy8fzuock808440kcok', 1, 'R', 'cyshqwfm2vc4cow44sg4ock4', 0, 0, 0, 'L', '', 0, 'R', '1yll0cx50jgg8s0ss48w44s4w', 0),
('contacts', 'contacts', 'private_email', 'N', 'N', 'WM', 'Private email', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', '2xiy1hy8fzuock808440kcok', 2, 'L', 'cyshqwfm2vc4cow44sg4ock4', 0, 0, 0, 'L', '', 0, 'L', '1yll0cx50jgg8s0ss48w44s4w', 0),
('contacts', 'contacts', 'private_phone', 'N', 'N', 'PH', 'Private phone', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', '2xiy1hy8fzuock808440kcok', 2, 'R', 'cyshqwfm2vc4cow44sg4ock4', 0, 0, 0, 'L', '', 0, 'R', '1yll0cx50jgg8s0ss48w44s4w', 0),
('contacts', 'contacts', 'assistant_id', 'N', 'N', 'RR', 'Assistant', 1, '', 'contacts', 'contact_id', 'full_name', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', 'yywxg2drs0g80cosgg840gck', 2, 'R', '1i02jw46b1pcck0sogs8wswwo', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('contacts', 'contacts', 'do_not_call', 'N', 'N', 'CH', 'Do not call', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_center', 1, 'R', '90aglgoeka6p', 2, 'R', '14n822vjzheok844cogcw4cgc', 2, 'R', '10mu5hd1ejb4w08wsk4o4cww8', 0, 0, 0, 'L', '', 2, 'R', 'z7nn2qdfmog8g88ks4w00ows', 0),
('contacts', 'contacts', 'email_opt_out', 'N', 'N', 'CH', 'Email opt out', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_center', 2, 'R', '90aglgoeka6p', 1, 'R', '14n822vjzheok844cogcw4cgc', 1, 'R', '10mu5hd1ejb4w08wsk4o4cww8', 0, 0, 0, 'L', '', 1, 'R', 'z7nn2qdfmog8g88ks4w00ows', 0),
('contacts', 'contacts', 'fax', 'N', 'N', 'TE', 'Fax', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'R', '14n822vjzheok844cogcw4cgc', 3, 'R', '10mu5hd1ejb4w08wsk4o4cww8', 0, 0, 0, 'L', '', 3, 'R', 'z7nn2qdfmog8g88ks4w00ows', 0),
('contacts', 'contacts', 'messenger_type', 'N', 'N', 'TE', 'Messenger type', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'R', 'yywxg2drs0g80cosgg840gck', 0, 'R', '1i02jw46b1pcck0sogs8wswwo', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('contacts', 'contacts', 'messenger', 'N', 'N', 'TE', 'Messenger', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'L', '14n822vjzheok844cogcw4cgc', 4, 'L', '10mu5hd1ejb4w08wsk4o4cww8', 0, 0, 0, 'L', '', 0, 'L', 'z7nn2qdfmog8g88ks4w00ows', 0),
('contacts', 'contacts', 'mobile', 'N', 'N', 'PH', 'Mobile', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 8, 'grid_left', 0, 'L', '', 3, 'L', '14n822vjzheok844cogcw4cgc', 3, 'L', '10mu5hd1ejb4w08wsk4o4cww8', 0, 7, 3, 'L', '1772a77n4orkcwg0g84s4ok40', 3, 'L', 'z7nn2qdfmog8g88ks4w00ows', 7),
('contacts', 'contacts', 'phone', 'N', 'N', 'PH', 'Phone', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 7, 'grid_left', 0, 'L', '', 2, 'L', '14n822vjzheok844cogcw4cgc', 2, 'L', '10mu5hd1ejb4w08wsk4o4cww8', 0, 6, 2, 'L', '1772a77n4orkcwg0g84s4ok40', 2, 'L', 'z7nn2qdfmog8g88ks4w00ows', 6),
('contacts', 'contacts', 'email', 'N', 'N', 'WM', 'Email', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 6, 'grid_left', 0, 'L', '', 1, 'L', '14n822vjzheok844cogcw4cgc', 1, 'L', '10mu5hd1ejb4w08wsk4o4cww8', 0, 5, 4, 'L', '1772a77n4orkcwg0g84s4ok40', 1, 'L', 'z7nn2qdfmog8g88ks4w00ows', 5),
('contacts', 'contacts', 'manager_id', 'N', 'N', 'RR', 'Manager', 1, '', 'contacts', 'contact_id', 'full_name', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', 'yywxg2drs0g80cosgg840gck', 1, 'R', '1i02jw46b1pcck0sogs8wswwo', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('contacts', 'contacts', 'contact_id', 'N', 'N', 'RK', 'Contact', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', -1, -1, 'grid_left', -1, 'L', '', -1, 'L', '', -1, 'L', '', -1, -1, -1, 'L', '', 0, 'L', '', -1),
('contacts', 'contacts', 'user_id', 'N', 'N', 'DD', 'Owner', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', '', 'N', 'Y', 6, 9, 'grid_left', 1, 'L', '90aglgoeka6p', -1, 'L', '', -1, 'L', '', 6, 8, 0, 'L', '', 0, 'L', '', 8),
('contacts', 'contacts', 'first_names', 'N', 'N', 'VF', 'First name', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 2, 3, 'grid_left', 0, 'L', '', 2, 'L', '6ehjjzt6r0ws8wksossk08s0', 2, 'L', '1hzebn5g3r0g8408owowgwggs', 2, 2, 0, 'L', '1772a77n4orkcwg0g84s4ok40', 2, 'L', '1fopitk23t7os40oo804k0cos', 2),
('contacts', 'contacts', 'last_name', 'N', 'N', 'VF', 'Last name', 1, '', '', '', '', '', 'Y', 'N', 'Y', 'N', 'Y', 3, 4, 'grid_left', 0, 'L', '', 3, 'L', '6ehjjzt6r0ws8wksossk08s0', 3, 'L', '1hzebn5g3r0g8408owowgwggs', 3, 3, 0, 'L', '1772a77n4orkcwg0g84s4ok40', 3, 'L', '1fopitk23t7os40oo804k0cos', 3),
('contacts', 'contacts', 'salutation', 'N', 'N', 'TE', 'Salutation', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '6ehjjzt6r0ws8wksossk08s0', 1, 'L', '1hzebn5g3r0g8408owowgwggs', 0, 0, 0, 'L', '1772a77n4orkcwg0g84s4ok40', 1, 'L', '1fopitk23t7os40oo804k0cos', 0),
('contacts', 'contacts', 'title', 'N', 'N', 'TE', 'Title', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 4, 5, 'grid_left', 0, 'L', '', 4, 'L', '6ehjjzt6r0ws8wksossk08s0', 4, 'L', '1hzebn5g3r0g8408owowgwggs', 4, 4, 0, 'L', '1772a77n4orkcwg0g84s4ok40', 0, 'L', '1fopitk23t7os40oo804k0cos', 4),
('contacts', 'contacts', 'account_id', 'N', 'N', 'RR', 'Account', 1, '', 'accounts', 'account_id', 'account_name', '', 'N', 'N', '', 'N', 'Y', 1, 2, 'grid_left', 0, 'R', '90aglgoeka6p', 1, 'L', 'yywxg2drs0g80cosgg840gck', 1, 'L', '1i02jw46b1pcck0sogs8wswwo', 1, 1, 1, 'R', '1772a77n4orkcwg0g84s4ok40', 1, 'R', '1fopitk23t7os40oo804k0cos', 1),
('contacts', 'contacts', 'department', 'N', 'N', 'TE', 'Department', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', 'yywxg2drs0g80cosgg840gck', 3, 'L', '1i02jw46b1pcck0sogs8wswwo', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('contacts', 'contacts', 'type_id', 'N', 'N', 'DD', 'Type', 1, '', 'types', 'type_id', 'type_name', ' order by type_name', 'N', 'N', 'N', 'N', 'Y', 5, 0, 'grid_left', 2, 'L', '90aglgoeka6p', 2, 'L', 'yywxg2drs0g80cosgg840gck', 2, 'L', '1i02jw46b1pcck0sogs8wswwo', 5, 0, 0, 'L', '', 2, 'R', '1fopitk23t7os40oo804k0cos', 0),
('contacts', 'contacts', 'full_name', 'N', 'N', 'TE', 'Full name', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 1, 'L', '1772a77n4orkcwg0g84s4ok40', 0, 'L', '', 0),
('contacts', 'contacts', 'avatar', 'N', 'N', 'IM', 'Avatar', 9, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 1, 'grid_left', 0, 'L', '', 1, 'R', '6ehjjzt6r0ws8wksossk08s0', 1, 'R', '1hzebn5g3r0g8408owowgwggs', 0, 0, 2, 'R', '1772a77n4orkcwg0g84s4ok40', 0, 'R', '1fopitk23t7os40oo804k0cos', 0),
('documents', 'documents', 'created', 'N', 'N', 'TS', 'Created', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'L', 'sr1630uzfo42', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('documents', 'documents', 'created_by', 'N', 'N', 'DD', 'Created by', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'R', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('documents', 'documents', 'document_id', 'N', 'N', 'RK', 'Document id', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', -1, -1, 'grid_left', -1, 'L', '', -1, 'L', '', -1, 'L', '', -1, -1, -1, 'L', '', 0, 'L', '', -1),
('documents', 'documents', 'document_name', 'N', 'N', 'DO', 'Name', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 1, 1, 'grid_left', 0, 'L', '', 1, 'L', '1hyvdoeu45gk8', 1, 'L', '136qnz4qg60gs', 1, 1, 1, 'L', '29om7vgz844k4', 1, 'L', '22hxxdohsag0k', 1),
('documents', 'documents', 'filesize', 'N', 'N', 'DS', 'Size', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 3, 'grid_right', 0, 'L', '', 1, 'R', '1cae8gv3lm1w4', 1, 'R', '2b9a1xuioa3og', 0, 3, 1, 'R', '220p3vp0ksf4k', 1, 'R', '21n5bk4tialcg', 3),
('documents', 'documents', 'filetype', 'N', 'N', 'DY', 'Type', 1, '', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 4, 'grid_left', 0, 'L', '', 1, 'L', '1cae8gv3lm1w4', 1, 'L', '2b9a1xuioa3og', 0, 4, 1, 'L', '220p3vp0ksf4k', 1, 'L', '21n5bk4tialcg', 4),
('documents', 'documents', 'folder_id', 'N', 'N', 'DF', 'Folder', 1, '', 'documents', 'document_id', 'document_name', '', 'N', 'N', 'N', 'N', 'Y', 3, 5, 'grid_left', 1, 'R', '1tuaann8tbxn0', 1, 'R', '1hyvdoeu45gk8', 1, 'R', '136qnz4qg60gs', 3, 5, 1, 'R', '29om7vgz844k4', 1, 'R', '22hxxdohsag0k', 5),
('documents', 'documents', 'is_folder', 'N', 'N', 'CH', 'Is a folder', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'R', '11s81saonrkcj', 0, 0, 0, 'L', '1zgar2xanqkgw', 0, 'L', '', 0),
('documents', 'documents', 'note', 'N', 'N', 'ML', 'Note', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '1q0brwwu9b7xb', 1, 'L', '29urxu14s1xco', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('documents', 'documents', 'subject', 'N', 'N', 'VF', 'Subject', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 2, 2, 'grid_left', 0, 'L', '1tuaann8tbxn0', 1, 'L', '1jjipo3medytx', 1, 'L', '1331mspew8ysw', 2, 2, 1, 'L', 'sof8437j52o', 1, 'L', '1yroek7u0jtww', 2),
('documents', 'documents', 'updated', 'N', 'N', 'TS', 'Last update', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 6, 'grid_center', 0, 'L', '', 1, 'R', 'sr1630uzfo42', 0, 'L', '', 0, 6, 0, 'L', '', 0, 'L', '', 6),
('documents', 'documents', 'updated_by', 'N', 'N', 'DD', 'Updated by', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'R', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('documents', 'documents', 'user_id', 'N', 'N', 'DD', 'Owner', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 4, 7, 'grid_left', 1, 'L', '1tuaann8tbxn0', 0, 'L', '', 0, 'L', '', 4, 7, 0, 'L', '', 0, 'L', '', 7),
('documents_folders', 'documents', 'created', 'N', 'N', 'TS', 'Created', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'L', '12kkgwkmxpcg8', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('documents_folders', 'documents', 'created_by', 'N', 'N', 'RR', 'Created by', 1, '', 'users', 'user_id', 'full_name', 'order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('documents_folders', 'documents', 'document_id', 'N', 'N', 'RK', 'Folder', 1, '', '', '', '', '', 'N', 'Y', 'N', 'Y', 'Y', 3, 5, 'grid_left', 1, 'R', '1am1d82fzqkkg', 0, 'L', '', 0, 'L', '', 3, 5, 0, 'L', '', 0, 'L', '', 5),
('documents_folders', 'documents', 'document_name', 'N', 'N', 'TE', 'Name', 1, '', '', '', '', '', 'Y', 'N', 'Y', 'N', 'Y', 1, 1, 'grid_left', 0, 'L', '', 1, 'L', '53vspu0jxq4g', 1, 'L', '1qmih22i341wg', 1, 1, 1, 'L', '11ye9u6bhipwk', 1, 'L', '1331msuuqlnkg', 1),
('documents_folders', 'documents', 'filesize', 'N', 'N', 'DS', 'Size', 1, '', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 4, 'grid_right', 0, 'L', '', 2, 'R', '53vspu0jxq4g', 2, 'R', '1qmih22i341wg', 0, 4, 2, 'R', '11ye9u6bhipwk', 2, 'R', '1331msuuqlnkg', 4),
('documents_folders', 'documents', 'filetype', 'N', 'N', 'DY', 'Type', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 3, 'grid_right', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 3, 0, 'L', '', 0, 'L', '', 3),
('documents_folders', 'documents', 'folder_id', 'N', 'N', 'DF', 'Main folder', 1, '0', 'documents', 'document_id', 'document_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', '53vspu0jxq4g', 1, 'R', '1qmih22i341wg', 0, 0, 1, 'R', '11ye9u6bhipwk', 1, 'R', '1331msuuqlnkg', 0),
('documents_folders', 'documents', 'is_folder', 'N', 'N', 'CH', 'Is folder', 1, 'N', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('documents_folders', 'documents', 'note', 'N', 'N', 'ML', 'Note', 4, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'L', '23bi6sxj0wbos', 1, 'L', 'ucxumaonfusk', 0, 0, 1, 'L', '1liz6jbibiasw', 1, 'L', '271rpmjstxno8', 0),
('documents_folders', 'documents', 'subject', 'N', 'N', 'TE', 'Subject', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 2, 2, 'grid_right', 0, 'L', '', 2, 'L', '53vspu0jxq4g', 2, 'L', '1qmih22i341wg', 2, 2, 2, 'L', '11ye9u6bhipwk', 2, 'L', '1331msuuqlnkg', 2),
('documents_folders', 'documents', 'updated', 'N', 'N', 'TS', 'Updated', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 6, 'grid_center', 0, 'L', '', 1, 'R', '12kkgwkmxpcg8', 0, 'R', '', 0, 6, 0, 'L', '', 0, 'L', '', 6),
('documents_folders', 'documents', 'updated_by', 'N', 'N', 'RR', 'Updated by', 1, '', 'users', 'user_id', 'full_name', 'order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'R', '', 0, 'R', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('documents_folders', 'documents', 'user_id', 'N', 'N', 'RR', 'Owner', 1, '', 'users', 'user_id', 'full_name', 'order by full_name', 'N', 'N', 'N', 'N', 'Y', 4, 7, 'grid_right', 1, 'L', '1am1d82fzqkkg', 0, 'L', '', 0, 'L', '', 4, 7, 0, 'L', '', 0, 'L', '', 7),
('leads', 'leads', 'account_name', 'N', 'N', 'VF', 'Account', 1, '', '', '', '', '', 'Y', 'N', 'Y', 'N', 'Y', 1, 1, 'grid_left', 0, 'L', '', 1, 'L', 'g0o9ds8m15c8g00kckwwwgs0', 1, 'L', 'dx80e5m0jq0c40oogo00sw8k', 1, 1, 1, 'R', 'f2h981f6gkggcooo08skw8s4', 1, 'L', '1hovvmj2s2dc08csgcco8wgw0', 1),
('leads', 'leads', 'address_1', 'N', 'N', 'ML', 'Address', 4, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '11hgl44mxpes4ogkc8sg4484c', 1, 'L', 'ayg7btj4wewcoow4gkokwccc', 0, 0, 0, 'L', '17l2kl2tt7ms4sggwkso8ks00', 1, 'L', '175vvls114qow8sg0so0oswwo', 0),
('leads', 'leads', 'city_1', 'N', 'N', 'TE', 'City', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', '11hgl44mxpes4ogkc8sg4484c', 1, 'R', 'ayg7btj4wewcoow4gkokwccc', 0, 0, 0, 'R', '17l2kl2tt7ms4sggwkso8ks00', 1, 'R', '175vvls114qow8sg0so0oswwo', 0),
('leads', 'leads', 'country_1', 'N', 'N', 'TE', 'Country', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'R', '11hgl44mxpes4ogkc8sg4484c', 4, 'R', 'ayg7btj4wewcoow4gkokwccc', 0, 0, 0, 'R', '17l2kl2tt7ms4sggwkso8ks00', 4, 'R', '175vvls114qow8sg0so0oswwo', 0),
('leads', 'leads', 'created', 'N', 'N', 'TS', 'Created', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_center', -1, 'L', '', 1, 'L', '9038db7rvzswwwo4k8co8wsg', 0, 'L', 'bcjxhrje5k8o0wgogkosc4kw', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('leads', 'leads', 'created_by', 'N', 'N', 'DD', 'Created by', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', -1, 'L', '', 0, 'L', '193ub13axo7e8', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('leads', 'leads', 'do_not_call', 'N', 'N', 'CH', 'Do not call', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_center', 0, 'R', '27k8an0vhzms8', 4, 'R', '1yrnmzgqdehws8wks0g4g8kw0', 4, 'R', '9311g05v88w04wwk440cwokk', 0, 0, 0, 'R', 'f2h981f6gkggcooo08skw8s4', 0, 'R', '1bkcxk82tc2swkco0os04g0s4', 0),
('leads', 'leads', 'email', 'N', 'N', 'WM', 'Email', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 4, 'grid_left', 0, 'L', '', 7, 'L', '1yrnmzgqdehws8wks0g4g8kw0', 7, 'L', '9311g05v88w04wwk440cwokk', 0, 4, 4, 'L', 'f2h981f6gkggcooo08skw8s4', 2, 'R', '1bkcxk82tc2swkco0os04g0s4', 4),
('leads', 'leads', 'email_opt_out', 'N', 'N', 'CH', 'Email opt out', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_center', 0, 'R', '27k8an0vhzms8', 3, 'R', '1yrnmzgqdehws8wks0g4g8kw0', 3, 'R', '9311g05v88w04wwk440cwokk', 0, 0, 0, 'R', 'f2h981f6gkggcooo08skw8s4', 0, 'R', '1bkcxk82tc2swkco0os04g0s4', 0),
('leads', 'leads', 'employees', 'N', 'N', 'TE', 'Employees', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', 'k6jpkeio3e8oo8gk0okw404k', 3, 'L', '1hl15zdu2n9cwkc4cg00wg04k', 0, 0, 0, 'L', '', 0, 'L', 'hvnneuwufxkocs4c40gcwssc', 0),
('leads', 'leads', 'fax', 'N', 'N', 'TE', 'Fax', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 8, 'L', '1yrnmzgqdehws8wks0g4g8kw0', 8, 'L', '9311g05v88w04wwk440cwokk', 0, 0, 0, 'L', 'f2h981f6gkggcooo08skw8s4', 0, 'L', '1bkcxk82tc2swkco0os04g0s4', 0),
('leads', 'leads', 'first_names', 'N', 'N', 'TE', 'First name', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 2, 2, 'grid_left', 0, 'L', '', 2, 'L', '1yrnmzgqdehws8wks0g4g8kw0', 2, 'L', '9311g05v88w04wwk440cwokk', 2, 2, 0, 'L', 'f2h981f6gkggcooo08skw8s4', 2, 'L', '1bkcxk82tc2swkco0os04g0s4', 2),
('leads', 'leads', 'full_name', 'N', 'N', 'TE', 'Full name', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 1, 'L', 'f2h981f6gkggcooo08skw8s4', 0, 'L', '', 0);
INSERT INTO `db_fields` (`app_name`, `table_name`, `field_name`, `is_custom`, `is_computed`, `field_type`, `field_label`, `field_height`, `field_default`, `related_table`, `related_id`, `related_name`, `related_filter`, `is_search`, `is_readonly`, `is_mandatory`, `is_unique`, `is_visible`, `search_sequence`, `result_sequence`, `result_class`, `bulk_sequence`, `bulk_side`, `bulk_block_id`, `view_sequence`, `view_side`, `view_block_id`, `edit_sequence`, `edit_side`, `edit_block_id`, `popup_search_sequence`, `popup_result_sequence`, `popup_view_sequence`, `popup_view_side`, `popup_view_block_id`, `popup_edit_sequence`, `popup_edit_side`, `popup_edit_block_id`, `linked_sequence`) VALUES
('leads', 'leads', 'industry_id', 'N', 'N', 'DD', 'Industry', 1, '', 'industries', 'industry_id', 'industry_name', ' order by industry_name', 'N', 'N', '', 'N', 'Y', 4, 0, 'grid_left', 2, 'L', '27k8an0vhzms8', 1, 'L', 'k6jpkeio3e8oo8gk0okw404k', 1, 'L', '1hl15zdu2n9cwkc4cg00wg04k', 4, 0, 0, 'L', '', 1, 'L', 'hvnneuwufxkocs4c40gcwssc', 0),
('leads', 'leads', 'last_name', 'N', 'N', 'TE', 'Last name', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 3, 3, 'grid_left', 0, 'L', '', 3, 'L', '1yrnmzgqdehws8wks0g4g8kw0', 3, 'L', '9311g05v88w04wwk440cwokk', 3, 3, 0, 'L', 'f2h981f6gkggcooo08skw8s4', 3, 'L', '1bkcxk82tc2swkco0os04g0s4', 3),
('leads', 'leads', 'lead_id', 'N', 'N', 'RK', 'Lead id', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', -1, -1, 'grid_left', -1, 'L', '', -1, 'L', '', -1, 'L', '', -1, -1, -1, 'L', '', 0, 'L', '', -1),
('leads', 'leads', 'mobile', 'N', 'N', 'PH', 'Mobile', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 6, 'grid_left', 0, 'L', '', 6, 'L', '1yrnmzgqdehws8wks0g4g8kw0', 6, 'L', '9311g05v88w04wwk440cwokk', 0, 6, 2, 'L', 'f2h981f6gkggcooo08skw8s4', 5, 'L', '1bkcxk82tc2swkco0os04g0s4', 6),
('leads', 'leads', 'note', 'N', 'N', 'ML', 'Note', 4, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '2p4670rod4sg8owoows4c00', 1, 'L', 'y9lrqvv0p6skcwk84k8kw4c', 0, 0, 1, 'L', '1bkxlaid85dwgo4kcoocc80gw', 1, 'L', '1winthlvds000gosg0k8kswwk', 0),
('leads', 'leads', 'phone', 'N', 'N', 'PH', 'Phone', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 5, 'grid_left', 0, 'L', '', 5, 'L', '1yrnmzgqdehws8wks0g4g8kw0', 5, 'L', '9311g05v88w04wwk440cwokk', 0, 5, 3, 'L', 'f2h981f6gkggcooo08skw8s4', 4, 'L', '1bkcxk82tc2swkco0os04g0s4', 5),
('leads', 'leads', 'rating_id', 'N', 'N', 'DD', 'Rating', 1, '', 'ratings', 'rating_id', 'rating_name', ' order by rating_name', 'N', 'N', '', 'N', 'Y', 5, 0, 'grid_left', 3, 'L', '27k8an0vhzms8', 1, 'R', 'k6jpkeio3e8oo8gk0okw404k', 1, 'R', '1hl15zdu2n9cwkc4cg00wg04k', 5, 0, 0, 'L', '', 2, 'L', 'hvnneuwufxkocs4c40gcwssc', 0),
('leads', 'leads', 'revenue', 'N', 'N', 'CU', 'Revenue', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 2, 'L', 'k6jpkeio3e8oo8gk0okw404k', 2, 'L', '1hl15zdu2n9cwkc4cg00wg04k', 0, 0, 0, 'L', '', 0, 'L', 'hvnneuwufxkocs4c40gcwssc', 0),
('leads', 'leads', 'salutation', 'N', 'N', 'TE', 'Salutation', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '1yrnmzgqdehws8wks0g4g8kw0', 1, 'L', '9311g05v88w04wwk440cwokk', 0, 0, 0, 'L', 'f2h981f6gkggcooo08skw8s4', 1, 'L', '1bkcxk82tc2swkco0os04g0s4', 0),
('leads', 'leads', 'source_id', 'N', 'N', 'DD', 'Source', 1, '', 'sources', 'source_id', 'source_name', ' order by source_name', 'N', 'N', '', 'N', 'Y', 6, 8, 'grid_left', 1, 'R', '27k8an0vhzms8', 2, 'R', 'k6jpkeio3e8oo8gk0okw404k', 2, 'R', '1hl15zdu2n9cwkc4cg00wg04k', 6, 8, 0, 'L', '', 1, 'R', 'hvnneuwufxkocs4c40gcwssc', 8),
('leads', 'leads', 'state_1', 'N', 'N', 'TE', 'State', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', '11hgl44mxpes4ogkc8sg4484c', 2, 'R', 'ayg7btj4wewcoow4gkokwccc', 0, 0, 0, 'R', '17l2kl2tt7ms4sggwkso8ks00', 2, 'R', '175vvls114qow8sg0so0oswwo', 0),
('leads', 'leads', 'title', 'N', 'N', 'TE', 'Title', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'L', '1yrnmzgqdehws8wks0g4g8kw0', 4, 'L', '9311g05v88w04wwk440cwokk', 0, 0, 0, 'R', 'f2h981f6gkggcooo08skw8s4', 0, 'L', '1bkcxk82tc2swkco0os04g0s4', 0),
('leads', 'leads', 'type_id', 'N', 'N', 'DD', 'Type', 1, '', 'types', 'type_id', 'type_name', ' order by type_name', 'N', 'N', 'N', 'N', 'Y', 7, 7, 'grid_left', 2, 'R', '27k8an0vhzms8', 3, 'R', 'k6jpkeio3e8oo8gk0okw404k', 3, 'R', '1hl15zdu2n9cwkc4cg00wg04k', 7, 7, 0, 'L', '', 2, 'R', 'hvnneuwufxkocs4c40gcwssc', 7),
('leads', 'leads', 'updated', 'N', 'N', 'TS', 'Last update', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_center', -1, 'L', '', 1, 'R', '9038db7rvzswwwo4k8co8wsg', 0, 'R', 'bcjxhrje5k8o0wgogkosc4kw', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('leads', 'leads', 'updated_by', 'N', 'N', 'DD', 'Updated by', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', -1, 'L', '', 0, 'R', '193ub13axo7e8', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('leads', 'leads', 'url', 'N', 'N', 'WS', 'Url', 5, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 2, 'R', '1yrnmzgqdehws8wks0g4g8kw0', 2, 'R', '9311g05v88w04wwk440cwokk', 0, 0, 0, 'R', 'f2h981f6gkggcooo08skw8s4', 1, 'R', '1bkcxk82tc2swkco0os04g0s4', 0),
('leads', 'leads', 'user_id', 'N', 'N', 'DD', 'Owner', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', '', 'N', 'Y', 8, 9, 'grid_left', 1, 'L', '27k8an0vhzms8', -1, 'L', '', -1, 'L', '', 8, 9, 0, 'L', '', 0, 'L', '', 9),
('leads', 'leads', 'zipcode_1', 'N', 'N', 'TE', 'Zipcode', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'R', '11hgl44mxpes4ogkc8sg4484c', 3, 'R', 'ayg7btj4wewcoow4gkokwccc', 0, 0, 0, 'R', '17l2kl2tt7ms4sggwkso8ks00', 3, 'R', '175vvls114qow8sg0so0oswwo', 0),
('leads', 'leads', 'avatar', 'N', 'N', 'IM', 'Avatar', 9, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', '1yrnmzgqdehws8wks0g4g8kw0', 1, 'R', '9311g05v88w04wwk440cwokk', 0, 0, 2, 'R', 'f2h981f6gkggcooo08skw8s4', 0, 'R', '1bkcxk82tc2swkco0os04g0s4', 0),
('opportunities', 'opportunities', 'account_id', 'N', 'N', 'RR', 'Account', 1, '', 'accounts', 'account_id', 'account_name', '', 'N', 'N', 'N', 'N', 'Y', 1, 1, 'grid_left', 0, 'L', '', 2, 'L', 'b4nszc8xzv23', 2, 'L', '10e4hjkwodlw48cgwg4g8gg8k', 1, 1, 0, 'L', '1zreh1nuw30kg', 2, 'L', '18tr2n2ksj0kg4ccwcc880kco', 1),
('opportunities', 'opportunities', 'closing', 'N', 'N', 'DA', 'Closing date', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 5, 6, 'grid_center', 1, 'R', '9l8bayclym1p', 3, 'L', 'b4nszc8xzv23', 3, 'L', '10e4hjkwodlw48cgwg4g8gg8k', 5, 6, 0, 'L', '1zreh1nuw30kg', 3, 'L', '18tr2n2ksj0kg4ccwcc880kco', 6),
('opportunities', 'opportunities', 'created', 'N', 'N', 'TS', 'Created', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', -1, 'L', '', 1, 'L', '1457q3mybwt5u', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('opportunities', 'opportunities', 'created_by', 'N', 'N', 'DD', 'Created by', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', -1, 'L', '', 2, 'L', '1457q3mybwt5u', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('opportunities', 'opportunities', 'expected_amount', 'N', 'N', 'CU', 'Expected amount', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 5, 'grid_right', 0, 'L', '', 1, 'R', 'b4nszc8xzv23', 1, 'R', '10e4hjkwodlw48cgwg4g8gg8k', 0, 5, 0, 'R', '1zreh1nuw30kg', 1, 'R', '18tr2n2ksj0kg4ccwcc880kco', 5),
('opportunities', 'opportunities', 'note', 'N', 'N', 'ML', 'Note', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', 'hu39z57kbs2b', 1, 'L', 'b7fv9q9kwu0w0c0ockk0ss88', 0, 0, 1, 'L', '3eao684domwy', 1, 'L', '1ww6h6dw40isso48ogs8c0s8w', 0),
('opportunities', 'opportunities', 'opportunity_id', 'N', 'N', 'RK', 'Opportunity id', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', -1, -1, 'grid_left', -1, 'L', '', -1, 'L', '', -1, 'L', '', -1, -1, -1, 'L', '', 0, 'L', '', -1),
('opportunities', 'opportunities', 'opportunity_name', 'N', 'N', 'VF', 'Opportunity', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 2, 2, 'grid_left', 0, 'L', '', 1, 'L', 'b4nszc8xzv23', 1, 'L', '10e4hjkwodlw48cgwg4g8gg8k', 2, 2, 0, 'L', '1zreh1nuw30kg', 1, 'L', '18tr2n2ksj0kg4ccwcc880kco', 2),
('opportunities', 'opportunities', 'probability', 'N', 'N', 'TE', 'Probability', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 4, 4, 'grid_left', 2, 'R', '9l8bayclym1p', 2, 'R', 'b4nszc8xzv23', 2, 'R', '10e4hjkwodlw48cgwg4g8gg8k', 4, 4, 0, 'R', '1zreh1nuw30kg', 2, 'R', '18tr2n2ksj0kg4ccwcc880kco', 4),
('opportunities', 'opportunities', 'recurring_amount', 'N', 'N', 'CU', 'Amount', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 0, 'L', 's8klceifbqcq', 0, 'L', '287ni1w2g9us4', 0, 0, 0, 'L', '', 0, 'L', '2809fpun9l1c4', 0),
('opportunities', 'opportunities', 'recurring_end_time', 'N', 'N', 'DA', 'End time', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'R', 's8klceifbqcq', 0, 'R', '287ni1w2g9us4', 0, 0, 0, 'L', '', 0, 'R', '2809fpun9l1c4', 0),
('opportunities', 'opportunities', 'recurring_id', 'N', 'N', 'TE', 'Period', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'R', 's8klceifbqcq', 0, 'R', '287ni1w2g9us4', 0, 0, 0, 'L', '', 0, 'R', '2809fpun9l1c4', 0),
('opportunities', 'opportunities', 'recurring_start_time', 'N', 'N', 'DA', 'Start time', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', 's8klceifbqcq', 0, 'L', '287ni1w2g9us4', 0, 0, 0, 'L', '', 0, 'L', '2809fpun9l1c4', 0),
('opportunities', 'opportunities', 'source_id', 'N', 'N', 'DD', 'Source', 1, '', 'sources', 'source_id', 'source_name', ' order by source_name', 'N', 'N', 'N', 'N', 'Y', 6, 0, 'grid_left', 0, 'L', '9l8bayclym1p', 4, 'L', 'b4nszc8xzv23', 4, 'L', '10e4hjkwodlw48cgwg4g8gg8k', 6, 0, 0, 'L', '1zreh1nuw30kg', 4, 'L', '18tr2n2ksj0kg4ccwcc880kco', 0),
('opportunities', 'opportunities', 'stage_id', 'N', 'N', 'DD', 'Stage', 1, '', 'stages', 'stage_id', 'stage_name', ' order by stage_name', 'N', 'N', 'N', 'N', 'Y', 3, 3, 'grid_left', 2, 'L', '9l8bayclym1p', 3, 'R', 'b4nszc8xzv23', 3, 'R', '10e4hjkwodlw48cgwg4g8gg8k', 3, 3, 0, 'R', '1zreh1nuw30kg', 3, 'R', '18tr2n2ksj0kg4ccwcc880kco', 3),
('opportunities', 'opportunities', 'type_id', 'N', 'N', 'TE', 'Type id', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'R', 'b4nszc8xzv23', 4, 'R', '10e4hjkwodlw48cgwg4g8gg8k', 0, 0, 0, 'R', '1zreh1nuw30kg', 4, 'R', '18tr2n2ksj0kg4ccwcc880kco', 0),
('opportunities', 'opportunities', 'updated', 'N', 'N', 'TS', 'Last update', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', -1, 'L', '', 1, 'R', '1457q3mybwt5u', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('opportunities', 'opportunities', 'updated_by', 'N', 'N', 'DD', 'Updated by', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', -1, 'L', '', 2, 'R', '1457q3mybwt5u', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('opportunities', 'opportunities', 'user_id', 'N', 'N', 'DD', 'Owner', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 7, 7, 'grid_left', 1, 'L', '9l8bayclym1p', -1, 'L', '', -1, 'L', '', 7, 7, 0, 'L', '', 0, 'L', '', 7),
('preferences_lookandfeel', 'users', 'app_name', 'N', 'N', 'DD', 'Default application', 1, 'api', 'db_applications', 'app_name', 'app_label', 'where is_visible = "Y" and status_id = "A" order by app_label', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', 'dzw7l3yrs9w0gsw4goocs4g8', 1, 'L', '12238nyd9hxc0', 0, 0, 0, 'L', '13z2ehlofjuow', 0, 'L', 'da9w2y9gqxkc', 0),
('preferences_lookandfeel', 'users', 'charset_id', 'N', 'N', 'DD', 'Character set', 1, 'UTF-8', 'global_charsets', 'charset_id', 'charset_name', 'order by charset_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', 'dwcouzp78tck4gkos40o4sos', 1, 'R', '1h90e2frullvk', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_lookandfeel', 'users', 'confirm_delete', 'N', 'N', 'CH', 'Confirm delete', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '13qfxwi7vfi8w', 2, 'L', 'dzw7l3yrs9w0gsw4goocs4g8', 2, 'L', '12238nyd9hxc0', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('preferences_lookandfeel', 'users', 'currency_id', 'N', 'N', 'DD', 'Currency', 1, 'USD', 'global_currencies', 'currency_id', 'currency_name', ' order by currency_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', 'dwcouzp78tck4gkos40o4sos', 2, 'L', '1h90e2frullvk', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('preferences_lookandfeel', 'users', 'language_id', 'N', 'N', 'DD', 'Language', 1, 'en', 'global_languages', 'language_id', 'language_name', ' order by language_id', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', 'dwcouzp78tck4gkos40o4sos', 1, 'L', '1h90e2frullvk', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('preferences_lookandfeel', 'users', 'locale_date_id', 'N', 'N', 'DD', 'Format date', 1, 'en_US', 'global_locales_date', 'date_id', 'date_label', ' order by date_label', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', 'dwcouzp78tck4gkos40o4sos', 2, 'R', '1h90e2frullvk', 0, 0, 0, 'L', '13z2ehlofjuow', 0, 'L', 'da9w2y9gqxkc', 0),
('preferences_lookandfeel', 'users', 'locale_time_id', 'N', 'N', 'DD', 'Format time', 1, 'en_US', 'global_locales_time', 'time_id', 'time_label', ' order by time_label', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'R', 'dwcouzp78tck4gkos40o4sos', 3, 'R', '1h90e2frullvk', 0, 0, 0, 'L', '13z2ehlofjuow', 0, 'L', 'da9w2y9gqxkc', 0),
('preferences_lookandfeel', 'users', 'nbrecords', 'N', 'N', 'DD', 'Lines displayed', 1, '10', 'global_lines', 'line_id', 'line_name', 'order by line_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', 'dzw7l3yrs9w0gsw4goocs4g8', 1, 'R', '12238nyd9hxc0', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_lookandfeel', 'users', 'notifications_location', 'N', 'Y', 'DD', 'Notifications location', 1, 'TC', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 2, 'R', 'dzw7l3yrs9w0gsw4goocs4g8', 2, 'R', '12238nyd9hxc0', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_lookandfeel', 'users', 'theme_id', 'N', 'N', 'DD', 'Theme', 1, 'default', 'global_themes', 'theme_id', 'theme_name', ' order by theme_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '1fa93ag8kvwg8o8ss44w000cg', 1, 'L', '10ragq2617itc', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('preferences_lookandfeel', 'users', 'timezone_id', 'N', 'Y', 'DD', 'Timezone', 1, '225', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', 'dwcouzp78tck4gkos40o4sos', 3, 'L', '1h90e2frullvk', 0, 0, 0, 'L', '13z2ehlofjuow', 0, 'L', 'da9w2y9gqxkc', 0),
('preferences_lookandfeel', 'users', 'user_id', 'N', 'N', 'RK', 'User identifier', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'confirm_delete', 'N', 'N', 'CH', 'Confirm delete', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'created', 'N', 'N', 'TS', 'Created', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 2, 'L', '9l8phqq6ujwo', 0, 'L', '57nq6t21izcws0ocgkcc0kww', 0, 0, 2, 'L', '2jvc6pe8h3sw8o0wswwcow40', 0, 'L', '', 0),
('preferences_profile', 'users', 'created_by', 'N', 'N', 'RR', 'Created by', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'currency_id', 'N', 'N', 'DD', 'Currency', 1, 'USD', 'global_currencies', 'currency_id', 'currency_name', 'order by currency_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'department_id', 'N', 'N', 'RR', 'Department', 1, '', 'departments', 'department_id', 'department_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'email', 'N', 'N', 'WM', 'Email', 1, '', '', '', '', '', 'N', 'N', 'Y', 'Y', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', '118iuwd6a528g', 1, 'R', '12uanve0br34kcgo0wcs0csws', 0, 0, 1, 'R', '77ch338qqr8coosww8go0oc0', 1, 'L', '2bszdlp7ppes4', 0),
('preferences_profile', 'users', 'fax', 'N', 'N', 'TE', 'Fax', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', '118iuwd6a528g', 2, 'R', '12uanve0br34kcgo0wcs0csws', 0, 0, 2, 'R', '77ch338qqr8coosww8go0oc0', 4, 'L', '2bszdlp7ppes4', 0),
('preferences_profile', 'users', 'first_names', 'N', 'N', 'TE', 'First name', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', 'tqrgvar474g8', 2, 'L', '6ud3rec4mug48cs48k4ckogg', 0, 0, 0, 'L', 'k5fns2beatc4w448csg0ss08', 2, 'L', '1pxj7dkwrcg0', 0),
('preferences_profile', 'users', 'full_name', 'N', 'N', 'TE', 'Full name', 1, '', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', 'tqrgvar474g8', 0, 'L', '6ud3rec4mug48cs48k4ckogg', 0, 0, 2, 'L', 'k5fns2beatc4w448csg0ss08', 0, 'L', '1pxj7dkwrcg0', 0),
('preferences_profile', 'users', 'ipacl', 'N', 'N', 'TE', 'Ipacl', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'is_salespeople', 'N', 'N', 'CH', 'Is salespeople', 1, 'N', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'language_id', 'N', 'N', 'DD', 'Language', 1, 'en', 'global_languages', 'language_id', 'language_name', ' order by language_id', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'last_login', 'N', 'N', 'TS', 'Last login', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'L', '9l8phqq6ujwo', 1, 'L', '57nq6t21izcws0ocgkcc0kww', 0, 0, 1, 'L', '2jvc6pe8h3sw8o0wswwcow40', 0, 'L', 'jzpcz4pef400', 0),
('preferences_profile', 'users', 'last_name', 'N', 'N', 'TE', 'Last name', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', 'tqrgvar474g8', 3, 'L', '6ud3rec4mug48cs48k4ckogg', 0, 0, 0, 'L', 'k5fns2beatc4w448csg0ss08', 2, 'R', '1pxj7dkwrcg0', 0),
('preferences_profile', 'users', 'last_password_change', 'N', 'N', 'TS', 'Last password change', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'R', '9l8phqq6ujwo', 1, 'R', '57nq6t21izcws0ocgkcc0kww', 0, 0, 1, 'R', '2jvc6pe8h3sw8o0wswwcow40', 0, 'R', 'jzpcz4pef400', 0),
('preferences_profile', 'users', 'locale_date_id', 'N', 'N', 'RR', 'Locale date id', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'locale_id', 'N', 'N', 'DD', 'Locale', 1, 'en_US', '', '', '', ' order by ', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'locale_time_id', 'N', 'N', 'RR', 'Locale time id', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'manager_id', 'N', 'N', 'RR', 'Manager', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '1963bv96yvtw84sw8c8s8ocs4', 1, 'L', '10ai7betb800w4csco8owcosg', 0, 0, 1, 'L', '2ottxtlabo4kog8c8c4w80co', 4, 'L', '1pxj7dkwrcg0', 0),
('preferences_profile', 'users', 'mobile', 'N', 'N', 'TE', 'Mobile', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', '118iuwd6a528g', 2, 'L', '12uanve0br34kcgo0wcs0csws', 0, 0, 2, 'L', '77ch338qqr8coosww8go0oc0', 3, 'L', '2bszdlp7ppes4', 0),
('preferences_profile', 'users', 'nbrecords', 'N', 'N', 'TE', 'Nbrecords', 1, '10', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'note', 'N', 'N', 'ML', 'Note', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '9dun4w391wso', 1, 'L', '1i9lkua03tr4c4ssooc0s88ko', 0, 0, 1, 'L', 'kags62xb8ogos880ssg4cs8k', 1, 'L', '1lstr1vwvfogg', 0),
('preferences_profile', 'users', 'notifications_location', 'N', 'N', 'CH', 'Notifications location', 1, 'TC', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'password', 'N', 'N', 'TE', 'Password', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'phone', 'N', 'N', 'TE', 'Phone', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '118iuwd6a528g', 1, 'L', '12uanve0br34kcgo0wcs0csws', 0, 0, 1, 'L', '77ch338qqr8coosww8go0oc0', 2, 'L', '2bszdlp7ppes4', 0),
('preferences_profile', 'users', 'private_email', 'N', 'N', 'TE', 'Private email', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', 'i04t6quk6f40wg4w80444sk8', 1, 'R', '6izgizweehwk0kw44g8ckgss', 0, 0, 0, 'R', '1ye4l211mvc0gc00c80k0gckw', 1, 'R', '2bszdlp7ppes4', 0),
('preferences_profile', 'users', 'private_mobile', 'N', 'N', 'TE', 'Private mobile', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', 'i04t6quk6f40wg4w80444sk8', 2, 'L', '6izgizweehwk0kw44g8ckgss', 0, 0, 0, 'L', '1ye4l211mvc0gc00c80k0gckw', 3, 'R', '2bszdlp7ppes4', 0),
('preferences_profile', 'users', 'charset_id', 'N', 'N', 'DD', 'Charset id', 1, 'UTF-8', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'birthdate', 'N', 'N', 'DA', 'Date of birth', 1, '0000-00-00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 2, 'R', 'i04t6quk6f40wg4w80444sk8', 2, 'R', '6izgizweehwk0kw44g8ckgss', 0, 0, 0, 'R', '1ye4l211mvc0gc00c80k0gckw', 4, 'R', '2bszdlp7ppes4', 0),
('preferences_profile', 'users', 'avatar', 'N', 'N', 'IM', 'Avatar', 9, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'R', 'tqrgvar474g8', 1, 'R', '6ud3rec4mug48cs48k4ckogg', 0, 0, 1, 'R', 'k5fns2beatc4w448csg0ss08', 0, 'L', '', 0),
('preferences_profile', 'users', 'assistant_id', 'N', 'N', 'RR', 'Assistant', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', '1963bv96yvtw84sw8c8s8ocs4', 1, 'R', '10ai7betb800w4csco8owcosg', 0, 0, 1, 'R', '2ottxtlabo4kog8c8c4w80co', 4, 'R', '1pxj7dkwrcg0', 0),
('preferences_profile', 'users', 'app_name', 'N', 'N', 'TE', 'App name', 1, 'api', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'private_phone', 'N', 'N', 'TE', 'Private phone', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', 'i04t6quk6f40wg4w80444sk8', 1, 'L', '6izgizweehwk0kw44g8ckgss', 0, 0, 0, 'L', '1ye4l211mvc0gc00c80k0gckw', 2, 'R', '2bszdlp7ppes4', 0),
('preferences_profile', 'users', 'salespeople', 'N', 'N', 'CH', 'Salespeople', 1, 'N', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'salutation', 'N', 'N', 'TE', 'Salutation', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', 'tqrgvar474g8', 1, 'L', '6ud3rec4mug48cs48k4ckogg', 0, 0, 1, 'L', 'k5fns2beatc4w448csg0ss08', 3, 'L', '1pxj7dkwrcg0', 0),
('preferences_profile', 'users', 'skin_id', 'N', 'N', 'DD', 'Skin', 1, 'default', '', '', '', ' order by ', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'status_id', 'N', 'N', 'DD', 'Status', 1, 'A', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'theme_id', 'N', 'N', 'DD', 'Theme', 1, 'default', '', '', '', ' order by ', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'timezone_id', 'N', 'Y', 'DD', 'Timezone', 1, '225', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'title', 'N', 'N', 'TE', 'Title', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'L', 'tqrgvar474g8', 4, 'L', '6ud3rec4mug48cs48k4ckogg', 0, 0, 0, 'L', 'k5fns2beatc4w448csg0ss08', 3, 'R', '1pxj7dkwrcg0', 0),
('preferences_profile', 'users', 'updated', 'N', 'N', 'TS', 'Updated', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 2, 'R', '9l8phqq6ujwo', 0, 'R', '57nq6t21izcws0ocgkcc0kww', 0, 0, 2, 'R', '2jvc6pe8h3sw8o0wswwcow40', 0, 'R', '', 0),
('preferences_profile', 'users', 'updated_by', 'N', 'N', 'RR', 'Updated by', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'user_id', 'N', 'N', 'RK', 'User identifier', 1, '', '', '', '', '', 'N', 'Y', 'N', 'Y', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'R', 'tqrgvar474g8', 3, 'R', '6ud3rec4mug48cs48k4ckogg', 0, 0, 0, 'R', 'k5fns2beatc4w448csg0ss08', 1, 'R', '1pxj7dkwrcg0', 0),
('preferences_profile', 'users', 'user_name', 'N', 'N', 'TE', 'User name', 1, '', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', 'tqrgvar474g8', 2, 'R', '6ud3rec4mug48cs48k4ckogg', 0, 0, 3, 'L', 'k5fns2beatc4w448csg0ss08', 1, 'L', '1pxj7dkwrcg0', 0),
('preferences_profile', 'users', 'user_status', 'N', 'N', 'CH', 'User status', 1, 'A', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_searches', 'searches', 'search_id', 'N', 'N', 'RK', 'Search id', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_searches', 'searches', 'app_name', 'N', 'N', 'DD', 'Application', 1, '', 'db_applications', 'app_name', 'app_label', ' where is_search = ''Y'' and status_id = ''A''', 'N', 'Y', 'N', 'N', 'Y', 1, 1, 'grid_left', 0, 'L', '', 1, 'L', '785ofb87iz8c4s80o4kkw44g', 1, 'L', '1gd2edpui5wgcow8cscwss84k', 0, 0, 1, 'L', '109qf1yjq6u8g8w8csc4kck0', 1, 'L', '1yc2lqbfqav4s80wgwsc40wcs', 1),
('preferences_searches', 'searches', 'user_id', 'N', 'N', 'RR', 'User id', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_searches', 'searches', 'search_name', 'N', 'N', 'VF', 'Search filter', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 2, 2, 'grid_left', 0, 'L', '', 1, 'L', '15mmys2jk6lcc448k4c4oscw4', 1, 'L', 'dqulv1sqb14cscwko8gco404', 0, 0, 1, 'L', 'bpk76wid1r4gscocw840k00', 1, 'L', '15pe5y7kwg4gos88s808c8sc8', 2),
('preferences_searches', 'searches', 'is_private', 'N', 'N', 'CH', 'Is private', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'R', '785ofb87iz8c4s80o4kkw44g', 0, 'R', '1gd2edpui5wgcow8cscwss84k', 0, 0, 0, 'R', '109qf1yjq6u8g8w8csc4kck0', 1, 'R', '1yc2lqbfqav4s80wgwsc40wcs', 3),
('preferences_searches', 'searches', 'search_filter', 'N', 'N', 'ML', 'Search filter', 4, '', '', '', '', '', 'Y', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_searches', 'searches', 'created', 'N', 'N', 'TS', 'Created', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 3, 'grid_center', 0, 'L', '', 1, 'L', 'ya81xno8534wcc48cwkscwsw', 0, 'L', '', 0, 0, 1, 'L', '155stu4q1dr4kck004s808ko8', 0, 'L', '', 4),
('preferences_searches', 'searches', 'created_by', 'N', 'N', 'RR', 'Created by', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '109cfl2ivnr40wss04g844wso', 0, 'L', '', 0, 0, 0, 'L', '13kb64i5tm2o0gg8s80kwg4c0', 0, 'L', '', 0),
('preferences_searches', 'searches', 'updated', 'N', 'N', 'TS', 'Updated', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 4, 'grid_center', 0, 'L', '', 1, 'R', 'ya81xno8534wcc48cwkscwsw', 0, 'L', '', 0, 0, 1, 'R', '155stu4q1dr4kck004s808ko8', 0, 'L', '', 5),
('preferences_searches', 'searches', 'updated_by', 'N', 'N', 'RR', 'Updated by', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'R', '109cfl2ivnr40wss04g844wso', 0, 'L', '', 0, 0, 0, 'R', '13kb64i5tm2o0gg8s80kwg4c0', 0, 'L', '', 0),
('reports', 'reports', 'filtercriterias', 'N', 'N', 'ML', 'Filtercriterias', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'orderbycolumns', 'N', 'N', 'ML', 'Orderbycolumns', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'quickselect', 'N', 'N', 'ML', 'Quickselect', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'quickwhere', 'N', 'N', 'ML', 'Quickwhere', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'quickparameter', 'N', 'N', 'ML', 'Quickparameter', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'pre_process', 'N', 'N', 'ML', 'Pre process', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'updated', 'N', 'N', 'TS', 'Updated', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 5, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'updated_by', 'N', 'N', 'DD', 'Updated by', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'created', 'N', 'N', 'TS', 'Created', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 6, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'created_by', 'N', 'N', 'DD', 'Created by', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'report_id', 'N', 'N', 'RK', 'Report id', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', -1, -1, 'grid_left', -1, 'L', '', 0, 'L', '', 0, 'L', '', -1, -1, -1, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'report_name', 'N', 'N', 'TE', 'Report name', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 1, 1, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'template', 'N', 'N', 'TE', 'Template', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'user_id', 'N', 'N', 'DD', 'Owner', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 4, 4, 'grid_left', 1, 'L', '1a8hdbjvfozog', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'table_name', 'N', 'N', 'DD', 'Application', 1, '', 'reports_tables', 'table_name', 'label', '', 'N', 'N', 'N', 'N', 'Y', 2, 2, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'type_id', 'N', 'N', 'DD', 'Type', 1, '', 'reports_types', 'type_id', 'type_name', ' order by type_name', 'N', 'N', 'N', 'N', 'Y', 3, 4, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'selectedcolumns', 'N', 'N', 'ML', 'Selectedcolumns', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'groupbycolumns', 'N', 'N', 'ML', 'Groupbycolumns', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'orderbygroupcolumns', 'N', 'N', 'TE', 'Orderbygroupcolumns', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'note', 'N', 'N', 'TE', 'Note', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'is_private', 'N', 'N', 'CH', 'Private', 1, 'N', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 3, 3, 'grid_center', 1, 'R', '1a8hdbjvfozog', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'selectedfields', 'N', 'N', 'TE', 'Selectedfields', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'groupbyfields', 'N', 'N', 'TE', 'Groupbyfields', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'orderbyfields', 'N', 'N', 'TE', 'Orderbyfields', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'orderbygroupfields', 'N', 'N', 'TE', 'Orderbygroupfields', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('support_faqs', 'backoffice_support_faqs', 'updated', 'N', 'N', 'TS', 'Updated', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'R', '141j8x4nsqcgc', 0, 'R', '', 0, 0, 0, 'L', '', 0, 'R', '', 0),
('support_faqs', 'backoffice_support_faqs', 'subject', 'N', 'N', 'VF', 'Subject', 1, '', '', '', '', '', 'Y', 'N', 'Y', 'N', 'Y', 1, 1, 'grid_left', 0, 'L', '', 1, 'L', '19r8qitiobusk', 1, 'L', '4xq1vkxgqc0s', 1, 1, 1, 'L', 't8agsawnl7kg', 1, 'L', '1budqhh47la8s', 1),
('support_faqs', 'backoffice_support_faqs', 'note', 'N', 'N', 'ML', 'Note', 20, '', '', '', '', '', 'Y', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'L', 'trzz2kk7iu8g', 1, 'L', '1z8x76i8wqxww', 0, 0, 0, 'L', 'vitj3t2oglws', 1, 'L', '1ib6sqac2itc4', 0),
('support_faqs', 'backoffice_support_faqs', 'is_active', 'N', 'N', 'CH', 'Is active', 1, 'A', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 2, 'L', 'lo2dyy4xm1w4', 0, 'L', '', 2, 'L', 'bn5ivdwa540g', 0, 0, 0, 'L', '', 2, 'R', '1pxvkbx6v7ggs', 0),
('support_faqs', 'backoffice_support_faqs', 'faq_id', 'N', 'N', 'RK', 'Faq identifier', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('support_faqs', 'backoffice_support_faqs', 'edition_id', 'N', 'N', 'DD', 'Edition', 1, '', 'global_editions', 'edition_id', 'edition_name', '', 'N', 'N', 'N', 'N', 'Y', 3, 3, 'grid_left', 1, 'R', 'lo2dyy4xm1w4', 1, 'R', '1hv6bmfw4yv48', 1, 'R', 'bn5ivdwa540g', 3, 3, 1, 'R', 'cak2c2ycv9s8', 1, 'R', '1pxvkbx6v7ggs', 3),
('support_faqs', 'backoffice_support_faqs', 'created_by', 'N', 'N', 'DD', 'Created by', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('support_faqs', 'backoffice_support_faqs', 'created', 'N', 'N', 'TS', 'Created', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'L', '141j8x4nsqcgc', 0, 'L', '', 0, 0, 0, 'L', '18ld15zxsvk04', 0, 'L', '', 0),
('support_faqs', 'backoffice_support_faqs', 'category_id', 'N', 'N', 'DD', 'Category', 1, '', 'backoffice_support_faqs_categories', 'category_id', 'category_name', 'order by category_sequence', 'N', 'Y', 'Y', 'N', 'Y', 2, 2, 'grid_left', 1, 'L', 'lo2dyy4xm1w4', 1, 'L', '1hv6bmfw4yv48', 1, 'L', 'bn5ivdwa540g', 2, 2, 1, 'L', 'cak2c2ycv9s8', 1, 'L', '1pxvkbx6v7ggs', 2),
('support_faqs', 'backoffice_support_faqs', 'updated_by', 'N', 'N', 'DD', 'Updated by', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'R', '', 0, 'R', '', 0, 0, 0, 'R', '', 0, 'L', '', 0),
('support_faqs', 'backoffice_support_faqs', 'user_id', 'N', 'N', 'DD', 'Owner', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 2, 'R', 'lo2dyy4xm1w4', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('support_tickets', 'backoffice_support_tickets', 'user_id', 'N', 'N', 'DD', 'Owner', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'Y', 'N', 'N', 'Y', 6, 6, 'grid_left', 2, 'R', '1a2btyu0dyrog', 0, 'R', 'mlbohio1mi8o', 2, 'R', '2be7en9edd348', 5, 7, 2, 'R', '27mpjc01xrfo0', 2, 'R', 'miuzp8ixiyo4', 7),
('support_tickets', 'backoffice_support_tickets', 'updated', 'N', 'N', 'TS', 'Updated', 1, '', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 5, 'grid_center', 0, 'L', '', 1, 'R', 'lj50b4cuhcgc', 0, 'L', '', 0, 5, 0, 'L', '', 0, 'L', '', 5),
('support_tickets', 'backoffice_support_tickets', 'updated_by', 'N', 'N', 'RR', 'Updated by', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 6, 0, 'L', '', 0, 'L', '', 6),
('support_tickets', 'backoffice_support_tickets', 'category_id', 'N', 'N', 'DD', 'Category', 1, '', 'backoffice_support_tickets_categories', 'category_id', 'category_name', 'order by category_sequence', 'N', 'N', 'Y', 'N', 'Y', 3, 3, 'grid_left', 1, 'L', '1a2btyu0dyrog', 1, 'L', 'mlbohio1mi8o', 1, 'L', '2be7en9edd348', 2, 3, 1, 'L', '27mpjc01xrfo0', 1, 'L', 'miuzp8ixiyo4', 3),
('support_tickets', 'backoffice_support_tickets', 'email', 'N', 'N', 'WM', 'Email', 1, '', '', '', '', '', 'Y', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', 'mlbohio1mi8o', 0, 'R', '2be7en9edd348', 0, 0, 0, 'R', '27mpjc01xrfo0', 0, 'R', 'miuzp8ixiyo4', 0),
('support_tickets', 'backoffice_support_tickets', 'edition_id', 'N', 'N', 'DD', 'Edition', 1, '', 'backoffice_support_tickets_editions', 'edition_id', 'edition_name', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'R', '1a2btyu0dyrog', 0, 'R', 'mlbohio1mi8o', 0, 'R', '2be7en9edd348', 0, 0, 0, 'R', '27mpjc01xrfo0', 0, 'R', 'miuzp8ixiyo4', 0),
('support_tickets', 'backoffice_support_tickets', 'ticket_id', 'N', 'N', 'RK', 'Ticket identifier', 1, '', '', '', '', '', 'N', 'Y', 'N', 'Y', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'R', 'mlbohio1mi8o', 0, 'R', '2be7en9edd348', 0, 0, 0, 'R', '27mpjc01xrfo0', 0, 'R', 'miuzp8ixiyo4', 0),
('support_tickets', 'backoffice_support_tickets', 'due_date', 'N', 'N', 'DA', 'Due date', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '1a2btyu0dyrog', 0, 'L', 'mlbohio1mi8o', 0, 'L', '2be7en9edd348', 0, 0, 0, 'L', '27mpjc01xrfo0', 0, 'L', 'miuzp8ixiyo4', 0),
('support_tickets', 'backoffice_support_tickets', 'priority_id', 'N', 'N', 'DD', 'Priority', 1, '', 'backoffice_support_tickets_priorities', 'priority_id', 'priority_name', '', 'N', 'N', 'N', 'N', 'Y', 5, 4, 'grid_left', 2, 'L', '1a2btyu0dyrog', 2, 'L', 'mlbohio1mi8o', 2, 'L', '2be7en9edd348', 4, 4, 2, 'L', '27mpjc01xrfo0', 2, 'L', 'miuzp8ixiyo4', 4),
('support_tickets', 'backoffice_support_tickets', 'created', 'N', 'N', 'TS', 'Created', 1, '', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'L', 'lj50b4cuhcgc', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('support_tickets', 'backoffice_support_tickets', 'created_by', 'N', 'N', 'RR', 'Created by', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('support_tickets', 'backoffice_support_tickets', 'company_id', 'N', 'N', 'DD', 'Company', 1, '', 'company', 'company_id', 'company_name', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'R', 'mlbohio1mi8o', 0, 'R', '2be7en9edd348', 0, 0, 0, 'R', '27mpjc01xrfo0', 0, 'R', 'miuzp8ixiyo4', 0),
('support_tickets', 'backoffice_support_tickets', 'status_id', 'N', 'N', 'DD', 'Status', 1, '', 'backoffice_support_tickets_statuses', 'status_id', 'status_name', '', 'N', 'N', 'N', 'N', 'Y', 4, 1, 'grid_left', 1, 'R', '1a2btyu0dyrog', 1, 'R', 'mlbohio1mi8o', 1, 'R', '2be7en9edd348', 3, 1, 1, 'R', '27mpjc01xrfo0', 1, 'R', 'miuzp8ixiyo4', 1),
('support_tickets', 'backoffice_support_tickets', 'subject', 'N', 'N', 'VF', 'Subject', 1, '', '', '', '', '', 'Y', 'N', 'Y', 'N', 'Y', 1, 2, 'grid_left', 0, 'L', '', 1, 'L', '1cdwjf8bx9lw', 1, 'L', 'co3uo1a4t48o', 1, 2, 1, 'L', '45e4r22e9okk', 1, 'L', 'ibcndsd8tm8s', 2),
('support_tickets', 'backoffice_support_tickets', 'note', 'N', 'N', 'ML', 'Note', 10, '', '', '', '', '', 'Y', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '1223a1n1tsogs', 1, 'L', 'm5b7hbww1kgs', 0, 0, 0, 'L', '27gjtdaiok4k4', 1, 'L', '11fx2z360hr4k', 0),
('support_tickets', 'backoffice_support_tickets', 'historic', 'N', 'N', 'ML', 'Historic', 20, '', '', '', '', '', 'Y', 'Y', 'N', 'N', 'Y', 2, 0, 'grid_left', 0, 'L', '', 1, 'L', '1223a1n1tsogs', 2, 'L', 'm5b7hbww1kgs', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('support_tickets', 'backoffice_support_tickets', 'appshore_version', 'N', 'N', 'DA', 'Appshore version', 1, '0000-00-00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('webmail', 'webmail', 'account_id', 'N', 'N', 'RR', 'Account id', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('webmail', 'webmail', 'mail_id', 'N', 'N', 'RK', 'Mail', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', -1, -1, 'grid_left', -1, 'L', '', 0, 'L', '', -1, 'L', '', -1, -1, -1, 'L', '', 0, 'L', '', -1),
('webmail', 'webmail', 'user_id', 'N', 'N', 'DD', 'Owner', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('webmail', 'webmail', 'folder_id', 'N', 'N', 'DD', 'Folder', 1, '', 'webmail_folders', 'folder_id', 'folder_name', ' order by folder_name', 'N', 'N', 'N', 'N', 'Y', 0, 5, 'grid_left', 1, 'R', '10a0vzsn8jmu5', 0, 'L', 'f4ee8xyybqw34swkc4wgc8cg', 0, 'L', 'usyiyh819a0w', 3, 3, 0, 'L', '', 0, 'L', '', 5),
('webmail', 'webmail', 'mail_size', 'N', 'N', 'DS', 'Size', 1, '0', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 3, 'grid_right', 0, 'L', '', 2, 'R', 'f4ee8xyybqw34swkc4wgc8cg', 0, 'R', 'usyiyh819a0w', 0, 0, 0, 'L', '', 0, 'L', '', 3),
('webmail', 'webmail', 'isread', 'N', 'N', 'CH', 'Mark as read', 1, 'N', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 1, 'L', '10a0vzsn8jmu5', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('webmail', 'webmail', 'bound', 'N', 'N', 'EN', 'Bound', 1, 'O', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('webmail', 'webmail', 'mail_from', 'N', 'N', 'TE', 'From', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 3, 0, 'grid_left', 0, 'L', '', 1, 'L', 'f4ee8xyybqw34swkc4wgc8cg', 1, 'L', 'usyiyh819a0w', 2, 2, 1, 'L', '18hnj62icuujr', 2, 'L', 'hqeeu9ndagz8', 0),
('webmail', 'webmail', 'mail_to', 'N', 'N', 'EM', 'To', 2, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 2, 1, 'grid_left', 0, 'L', '', 1, 'L', 'ti5vmf5qzdqj48s8gk4csow', 1, 'L', 'tluh7ih8uyv4', 0, 0, 2, 'L', '18hnj62icuujr', 1, 'L', 'hqeeu9ndagz8', 1),
('webmail', 'webmail', 'reply_to', 'N', 'N', 'ML', 'Reply to', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('webmail', 'webmail', 'mail_cc', 'N', 'N', 'EM', 'Cc', 2, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '2k4gzds0ud55q8wos8sksw4g', 1, 'L', '1d09nxy4tngg0', 0, 0, 0, 'L', '18hnj62icuujr', 0, 'L', '', 0),
('webmail', 'webmail', 'mail_bcc', 'N', 'N', 'EM', 'Bcc', 2, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', '2k4gzds0ud55q8wos8sksw4g', 1, 'R', '1d09nxy4tngg0', 0, 0, 0, 'L', '18hnj62icuujr', 0, 'L', '', 0),
('webmail', 'webmail', 'mail_date', 'N', 'N', 'DT', 'Date', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 4, 4, 'grid_center', 0, 'L', '', 2, 'L', 'f4ee8xyybqw34swkc4wgc8cg', 0, 'R', 'usyiyh819a0w', 0, 4, 4, 'L', '18hnj62icuujr', 0, 'L', '', 4),
('webmail', 'webmail', 'type', 'N', 'N', 'TE', 'Type', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('webmail', 'webmail', 'subtype', 'N', 'N', 'TE', 'Subtype', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('webmail', 'webmail', 'encoding', 'N', 'N', 'TE', 'Encoding', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('webmail', 'webmail', 'subject', 'N', 'N', 'VF', 'Subject', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 1, 2, 'grid_left', 0, 'L', '', 1, 'L', 'de3ygur1wgmckkkkg44g0ow4', 1, 'L', '74zpg30isnrh2cws0wgk48wo', 1, 1, 3, 'L', '18hnj62icuujr', 3, 'L', 'hqeeu9ndagz8', 2),
('webmail', 'webmail', 'body_html', 'N', 'N', 'EH', 'Message', 15, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '17rlwh26sbqh8g4scgk40s00g', 1, 'L', 'ixj2n93p8c1s', 0, 0, 5, 'L', '18hnj62icuujr', 4, 'L', 'hqeeu9ndagz8', 0),
('webmail', 'webmail', 'body_text', 'N', 'N', 'ML', 'Body text', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('webmail', 'webmail', 'priority_id', 'N', 'N', 'DD', 'Priority', 1, '', 'webmail_priorities', 'priority_id', 'priority_name', ' order by priority_sequence', 'N', 'N', 'N', 'N', 'Y', 5, 0, 'grid_left', 0, 'L', '', 1, 'R', 'f4ee8xyybqw34swkc4wgc8cg', 1, 'R', 'usyiyh819a0w', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('webmail', 'webmail', 'contact_id', 'N', 'N', 'RR', 'Contact id', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('webmail', 'webmail', 'is_attachment', 'N', 'Y', 'AT', 'Attachment', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '1c0lcn5bmmkx68sosccs00c4o', 1, 'L', '1hqsns73yrizwg4wg8888wosc', 0, 0, 0, 'L', '', 0, 'L', '', 0);

DROP TABLE IF EXISTS `db_linked`;
CREATE TABLE IF NOT EXISTS `db_linked` (
  `app_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `table_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `linked_app_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `linked_table_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `linked_record_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `linked_type` enum('11','1N','N1','NN') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'NN',
  `linked_app_label` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `sequence` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`app_name`,`linked_app_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `db_linked` (`app_name`, `table_name`, `linked_app_name`, `linked_table_name`, `linked_record_name`, `linked_type`, `linked_app_label`, `sequence`) VALUES
('accounts', 'accounts', 'webmail', 'webmail', 'mail_id', 'NN', 'Webmail', 6),
('accounts', 'accounts', 'activities', 'activities', 'activity_id', 'NN', 'Activities', 2),
('accounts', 'accounts', 'documents', 'documents', 'document_id', 'NN', 'Documents', 4),
('accounts', 'accounts', 'opportunities', 'opportunities', 'account_id', '1N', 'Opportunities', 3),
('accounts', 'accounts', 'accounts', 'accounts', 'account_top_id', '1N', 'Subsidiaries', 7),
('accounts', 'accounts', 'contacts', 'contacts', 'account_id', '1N', 'Contacts', 1),
('accounts', 'accounts', 'cases', 'cases', 'case_id', 'NN', 'Cases', 5),
('activities', 'activities', 'contacts', 'contacts', 'contact_id', 'NN', 'Contacts', 1),
('activities', 'activities', 'accounts', 'accounts', 'account_id', 'NN', 'Accounts', 2),
('activities', 'activities', 'leads', 'leads', 'lead_id', 'NN', 'Leads', 3),
('activities', 'activities', 'opportunities', 'opportunities', 'opportunity_id', 'NN', 'Opportunities', 4),
('activities', 'activities', 'cases', 'cases', 'case_id', 'NN', 'Cases', 5),
('activities', 'activities', 'webmail', 'webmail', 'mail_id', 'NN', 'Webmail', 7),
('activities', 'activities', 'documents', 'documents', 'document_id', 'NN', 'Documents', 6),
('campaigns', 'campaigns', 'webmail', 'webmail', 'mail_id', 'NN', 'Webmail', 7),
('campaigns', 'campaigns', 'opportunities', 'opportunities', 'opportunity_id', 'NN', 'Opportunities', 6),
('campaigns', 'campaigns', 'documents', 'documents', 'document_id', 'NN', 'Documents', 4),
('campaigns', 'campaigns', 'contacts', 'contacts', 'contact_id', 'NN', 'Contacts', 3),
('campaigns', 'campaigns', 'activities', 'activities', 'activity_id', 'NN', 'Activities', 2),
('campaigns', 'campaigns', 'accounts', 'accounts', 'account_id', 'NN', 'Accounts', 1),
('campaigns', 'campaigns', 'leads', 'leads', 'lead_id', 'NN', 'Leads', 5),
('campaigns_lists', 'campaigns_lists', 'campaigns', 'campaigns', 'list_id', '1N', 'Campaigns', 0),
('campaigns_records', 'campaigns_records_view', 'campaigns_lists', 'campaigns_lists', 'list_id', '11', 'Campaign Lists', 1),
('cases', 'cases', 'leads', 'leads', 'lead_id', 'NN', 'Leads', 5),
('cases', 'cases', 'opportunities', 'opportunities', 'opportunity_id', 'NN', 'Opportunities', 4),
('cases', 'cases', 'contacts', 'contacts', 'contact_id', 'NN', 'Contacts', 2),
('cases', 'cases', 'accounts', 'accounts', 'account_id', 'NN', 'Accounts', 1),
('cases', 'cases', 'webmail', 'webmail', 'mail_id', 'NN', 'Webmail', 7),
('cases', 'cases', 'activities', 'activities', 'activity_id', 'NN', 'Activities', 3),
('cases', 'cases', 'documents', 'documents', 'document_id', 'NN', 'Documents', 6),
('contacts', 'contacts', 'webmail', 'webmail', 'mail_id', 'NN', 'Webmail', 6),
('contacts', 'contacts', 'contacts', 'contacts', 'manager_id', '1N', 'Subordinates', 5),
('contacts', 'contacts', 'cases', 'cases', 'case_id', 'NN', 'Cases', 3),
('contacts', 'contacts', 'activities', 'activities', 'activity_id', 'NN', 'Activities', 1),
('contacts', 'contacts', 'accounts', 'accounts', 'account_id', '11', 'Accounts', 0),
('contacts', 'contacts', 'opportunities', 'opportunities', 'opportunity_id', 'NN', 'Opportunities', 2),
('contacts', 'contacts', 'documents', 'documents', 'document_id', 'NN', 'Documents', 4),
('leads', 'leads', 'activities', 'activities', 'activity_id', 'NN', 'Activities', 1),
('leads', 'leads', 'documents', 'documents', 'document_id', 'NN', 'Documents', 4),
('leads', 'leads', 'webmail', 'webmail', 'mail_id', 'NN', 'Webmail', 5),
('leads', 'leads', 'opportunities', 'opportunities', 'opportunity_id', 'NN', 'Opportunities', 2),
('leads', 'leads', 'cases', 'cases', 'case_id', 'NN', 'Cases', 3),
('opportunities', 'opportunities', 'activities', 'activities', 'activity_id', 'NN', 'Activities', 2),
('opportunities', 'opportunities', 'documents', 'documents', 'document_id', 'NN', 'Documents', 5),
('opportunities', 'opportunities', 'webmail', 'webmail', 'mail_id', 'NN', 'Webmail', 6),
('opportunities', 'opportunities', 'cases', 'cases', 'case_id', 'NN', 'Cases', 4),
('opportunities', 'opportunities', 'contacts', 'contacts', 'contact_id', 'NN', 'Contacts', 1),
('opportunities', 'opportunities', 'leads', 'leads', 'lead_id', 'NN', 'Leads', 3),
('opportunities', 'opportunities', 'accounts', 'accounts', 'account_id', '11', 'Accounts', 0),
('webmail', 'webmail', 'leads', 'leads', 'lead_id', 'NN', 'Leads', 1),
('webmail', 'webmail', 'contacts', 'contacts', 'contact_id', 'NN', 'Contacts', 3),
('webmail', 'webmail', 'cases', 'cases', 'case_id', 'NN', 'Cases', 5),
('webmail', 'webmail', 'activities', 'activities', 'activity_id', 'NN', 'Activities', 6),
('webmail', 'webmail', 'accounts', 'accounts', 'account_id', 'NN', 'Accounts', 2),
('documents', 'documents', 'accounts', 'accounts', 'account_id', 'NN', 'Accounts', 1),
('documents', 'documents', 'activities', 'activities', 'activity_id', 'NN', 'Activities', 2),
('documents', 'documents', 'cases', 'cases', 'case_id', 'NN', 'Cases', 3),
('documents', 'documents', 'contacts', 'contacts', 'contact_id', 'NN', 'Contacts', 4),
('documents', 'documents', 'leads', 'leads', 'lead_id', 'NN', 'Leads', 5),
('documents', 'documents', 'opportunities', 'opportunities', 'opportunity_id', 'NN', 'Opportunities', 6),
('documents_folders', 'documents', 'accounts', 'accounts', 'account_id', 'NN', 'Accounts', 1),
('documents_folders', 'documents', 'activities', 'activities', 'activity_id', 'NN', 'Activities', 2),
('documents_folders', 'documents', 'cases', 'cases', 'case_id', 'NN', 'Cases', 3),
('documents_folders', 'documents', 'contacts', 'contacts', 'contact_id', 'NN', 'Contacts', 4),
('documents_folders', 'documents', 'leads', 'leads', 'lead_id', 'NN', 'Leads', 5),
('documents_folders', 'documents', 'opportunities', 'opportunities', 'opportunity_id', 'NN', 'Opportunities', 6);

DROP TABLE IF EXISTS `db_lookups`;
CREATE TABLE IF NOT EXISTS `db_lookups` (
  `table_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `table_label` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `app_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `class_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `is_custom` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `is_customizable` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `lookup_id` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `lookup_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `lookup_value` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `lookup_comment` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`table_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `db_lookups` (`table_name`, `table_label`, `app_name`, `class_name`, `is_custom`, `is_customizable`, `lookup_id`, `lookup_name`, `lookup_value`, `lookup_comment`) VALUES
('activities_priorities', 'Priority - Activities', '', '', 'N', 'Y', 'priority_id', 'priority_name', '', 'Identifiers are unique values associated with Labels'),
('activities_statuses', 'Status - Activities', '', '', 'N', 'Y', 'status_id', 'status_name', 'is_open', 'Value represents whether or not the record is an open activity, it must be Y or N'),
('activities_types', 'Type - Activities', '', '', 'N', 'Y', 'type_id', 'type_name', '', 'Identifiers are unique values associated with Labels'),
('campaigns_lists', 'Campaigns - Lists', '', '', 'N', 'N', 'list_id', 'list_name', '', ''),
('campaigns_lists_statuses', 'Status - Lists, List Records', '', '', 'N', 'Y', 'status_id', 'status_name', '', 'Identifiers are unique values associated with Labels'),
('campaigns_records_types', 'Type - Campaigns List Records', '', '', 'N', 'N', 'type_id', 'type_name', '', 'Identifiers are unique values associated with Labels'),
('campaigns_statuses', 'Status - Campaigns', '', '', 'N', 'Y', 'status_id', 'status_name', '', 'Identifiers are unique values associated with Labels'),
('campaigns_types', 'Type - Campaigns', '', '', 'N', 'Y', 'type_id', 'type_name', '', 'Identifiers are unique values associated with Labels'),
('cases_priorities', 'Priority - Cases', '', '', 'N', 'Y', 'priority_id', 'priority_name', '', 'Identifiers are unique values associated with Labels'),
('cases_statuses', 'Status - Cases', '', '', 'N', 'Y', 'status_id', 'status_name', '', 'Identifiers are unique values associated with Labels'),
('departments', 'Departments', '', '', 'N', 'N', 'department_id', 'department_name', '', 'Identifiers are unique values associated with Labels'),
('global_countries', 'Countries', '', '', 'N', 'N', 'country_id', 'country_name', '', ''),
('global_editions', 'Editions', '', '', 'N', 'N', 'edition_id', 'edition_name', '', ''),
('industries', 'Industries', '', '', 'N', 'Y', 'industry_id', 'industry_name', '', 'Identifiers are unique values associated with Labels'),
('periods', 'Periods', '', '', 'N', 'N', 'period_id', 'period_name', '', 'The Value field represents the percentage of the tax. It must be a numeric value'),
('ratings', 'Ratings - Accounts', '', '', 'N', 'Y', 'rating_id', 'rating_name', '', 'Identifiers are unique values associated with Labels'),
('reports_types', 'Type - Reports', '', '', 'N', 'N', 'type_id', 'type_name', '', 'Identifiers are unique values associated with Labels'),
('sources', 'Source - Accounts, Leads', '', '', 'N', 'Y', 'source_id', 'source_name', '', 'Identifiers are unique values associated with Labels'),
('stages', 'Stage - Opportunities', '', '', 'N', 'Y', 'stage_id', 'stage_name', '', 'The Identifier field represents the Probability, or level of confidence the business will be won'),
('types', 'Type - Accounts, Contacts, Leads', '', '', 'N', 'Y', 'type_id', 'type_name', '', 'Identifiers are unique values associated with Labels'),
('users', 'User', '', 'administration.users', 'N', 'N', 'user_id', 'full_name', '', 'Identifiers are unique values associated with Labels'),
('webmail_folders', 'Folder - Web mail', '', '', 'N', 'N', 'folder_id', 'folder_name', '', ''),
('webmail_priorities', 'Priority - Webmail', '', '', 'N', 'Y', 'priority_id', 'priority_name', '', '');

DROP TABLE IF EXISTS `departments`;
CREATE TABLE IF NOT EXISTS `departments` (
  `department_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `department_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `department_top_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `manager_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `assistant_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `employees` int(6) NOT NULL DEFAULT '0',
  `phone` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `fax` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `address_billing` longtext COLLATE utf8_unicode_ci NOT NULL,
  `zipcode_billing` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `city_billing` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `state_billing` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `country_billing` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `address_shipping` longtext COLLATE utf8_unicode_ci NOT NULL,
  `zipcode_shipping` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `city_shipping` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `state_shipping` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `country_shipping` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `note` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`department_id`),
  UNIQUE KEY `department_name` (`department_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `documents`;
CREATE TABLE IF NOT EXISTS `documents` (
  `document_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `document_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `folder_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `is_folder` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `filesize` int(11) NOT NULL DEFAULT '0',
  `filetype` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `subject` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `note` longtext COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`document_id`),
  KEY `subject` (`subject`(10)),
  KEY `document_name` (`document_name`(10))
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `history`;
CREATE TABLE IF NOT EXISTS `history` (
  `user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `history_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `opname` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `filter` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`user_id`,`filter`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `industries`;
CREATE TABLE IF NOT EXISTS `industries` (
  `industry_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `industry_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`industry_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `industries` (`industry_id`, `industry_name`) VALUES
('Other', 'Other'),
('Advertising', 'Advertising'),
('Architecture', 'Architecture'),
('Chemicals', 'Chemicals'),
('Communications', 'Communications'),
('Computers', 'Computers'),
('Construction', 'Construction'),
('Consulting', 'Consulting'),
('Distribution', 'Distribution'),
('Education', 'Education'),
('Finance', 'Finance'),
('Government', 'Government'),
('Healthcare', 'Healthcare'),
('Insurance', 'Insurance'),
('Legal', 'Legal'),
('Manufacturing', 'Manufacturing'),
('Non-Profit', 'Non-Profit'),
('Real Estate', 'Real Estate'),
('Restaurant', 'Restaurant'),
('Retail', 'Retail');

DROP TABLE IF EXISTS `leads`;
CREATE TABLE IF NOT EXISTS `leads` (
  `lead_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `source_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `industry_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `type_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `rating_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `account_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `employees` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `revenue` int(11) NOT NULL,
  `first_names` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `full_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `salutation` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `avatar` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `mobile` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `fax` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `email_opt_out` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `do_not_call` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `address_1` longtext COLLATE utf8_unicode_ci NOT NULL,
  `zipcode_1` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `city_1` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `state_1` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `country_1` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `note` longtext COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `created_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `updated` datetime NOT NULL,
  `updated_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`lead_id`),
  KEY `user_id` (`user_id`),
  KEY `account_name` (`account_name`),
  KEY `last_name` (`last_name`),
  KEY `source_id` (`source_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `links`;
CREATE TABLE IF NOT EXISTS `links` (
  `from_table` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `from_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `to_table` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `to_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  KEY `from_table` (`from_table`,`from_id`),
  KEY `to_table` (`to_table`,`to_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


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


DROP TABLE IF EXISTS `notifications`;
CREATE TABLE IF NOT EXISTS `notifications` (
  `notification_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `notification_date` datetime NOT NULL,
  `app_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `record_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `type_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `status_id` enum('A','D','T') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'A',
  PRIMARY KEY (`notification_id`),
  KEY `notification_date` (`notification_date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `opportunities`;
CREATE TABLE IF NOT EXISTS `opportunities` (
  `opportunity_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `opportunity_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `account_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `source_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `stage_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `type_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `expected_amount` int(11) NOT NULL DEFAULT '0',
  `probability` int(11) NOT NULL DEFAULT '0',
  `closing` date NOT NULL DEFAULT '0000-00-00',
  `recurring_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `recurring_amount` int(11) NOT NULL DEFAULT '0',
  `recurring_start_time` date NOT NULL DEFAULT '0000-00-00',
  `recurring_end_time` date NOT NULL DEFAULT '0000-00-00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `note` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`opportunity_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `opportunities_recurring`;
CREATE TABLE IF NOT EXISTS `opportunities_recurring` (
  `recurring_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `recurring_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `recurring_sequence` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`recurring_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `opportunities_recurring` (`recurring_id`, `recurring_name`, `recurring_sequence`) VALUES
('Daily', 'Daily', 1),
('Weekly', 'Weekly', 2),
('Monthly', 'Monthly', 3),
('Quarterly', 'Quarterly', 4),
('Yearly', 'Yearly', 5);

DROP TABLE IF EXISTS `panelets`;
CREATE TABLE IF NOT EXISTS `panelets` (
  `user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `panelet_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `panelet_sequence` tinyint(4) NOT NULL,
  `is_open` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`user_id`,`panelet_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `periods`;
CREATE TABLE IF NOT EXISTS `periods` (
  `period_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `period_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `period_sequence` int(4) NOT NULL DEFAULT '0',
  KEY `period_sequence` (`period_sequence`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `periods` (`period_id`, `period_name`, `period_sequence`) VALUES
('TD', 'Today', 0),
('TO', 'Tomorrow', 1),
('YE', 'Yesterday', 2),
('TW', 'This week', 3),
('NW', 'Next week', 4),
('LW', 'Last week', 5),
('TM', 'This month', 6),
('NM', 'Next month', 7),
('LM', 'Last month', 8),
('TQ', 'This quarter', 9),
('NQ', 'Next quarter', 10),
('LQ', 'Last quarter', 11),
('TY', 'This year', 12),
('NY', 'Next year', 13),
('LY', 'Last year', 14);

DROP TABLE IF EXISTS `permissions`;
CREATE TABLE IF NOT EXISTS `permissions` (
  `role_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `app_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `level` int(4) NOT NULL DEFAULT '0',
  `import` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `export` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`role_id`,`app_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `permissions` (`role_id`, `app_name`, `level`, `import`, `export`) VALUES
('admin', 'accounts', 127, '1', '1'),
('admin', 'activities', 127, '1', '1'),
('admin', 'administration', 127, '0', '0'),
('admin', 'campaigns', 127, '1', '1'),
('admin', 'cases', 127, '1', '1'),
('admin', 'contacts', 127, '1', '1'),
('admin', 'dashboards', 127, '1', '1'),
('admin', 'documents', 127, '1', '1'),
('admin', 'forecasts', 127, '1', '1'),
('admin', 'leads', 127, '1', '1'),
('admin', 'opportunities', 127, '1', '1'),
('admin', 'preferences', 127, '1', '1'),
('admin', 'reports', 127, '1', '1'),
('admin', 'support', 127, '1', '1'),
('admin', 'webmail', 127, '1', '1'),
('public', 'accounts', 63, '1', '1'),
('public', 'activities', 63, '1', '1'),
('public', 'administration', 63, '1', '1'),
('public', 'campaigns', 63, '1', '1'),
('public', 'cases', 63, '1', '1'),
('public', 'contacts', 63, '1', '1'),
('public', 'dashboards', 63, '1', '1'),
('public', 'documents', 63, '1', '1'),
('public', 'forecasts', 63, '1', '1'),
('public', 'leads', 63, '1', '1'),
('public', 'opportunities', 63, '1', '1'),
('public', 'preferences', 63, '1', '1'),
('public', 'reports', 63, '1', '1'),
('public', 'webmail', 63, '1', '1'),
('public', 'support', 63, '1', '1'),
('user', 'opportunities', 3, '1', '1'),
('user', 'leads', 3, '1', '1'),
('user', 'forecasts', 3, '1', '1'),
('user', 'documents', 3, '1', '1'),
('user', 'dashboards', 3, '1', '1'),
('user', 'contacts', 3, '1', '1'),
('user', 'cases', 3, '1', '1'),
('user', 'campaigns', 3, '1', '1'),
('user', 'administration', 3, '1', '1'),
('user', 'activities', 3, '1', '1'),
('user', 'accounts', 3, '1', '1'),
('user', 'preferences', 3, '1', '1'),
('user', 'reports', 3, '1', '1'),
('user', 'webmail', 3, '1', '1'),
('user', 'support', 3, '1', '1');

DROP TABLE IF EXISTS `ratings`;
CREATE TABLE IF NOT EXISTS `ratings` (
  `rating_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `rating_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `rating_sequence` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`rating_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `ratings` (`rating_id`, `rating_name`, `rating_sequence`) VALUES
('Unknown', 'Unknown', 1),
('Avoid', 'Avoid', 2),
('Poor', 'Poor', 3),
('Fair', 'Fair', 4),
('Good', 'Good', 5),
('Excellent', 'Excellent', 6);

DROP TABLE IF EXISTS `reports`;
CREATE TABLE IF NOT EXISTS `reports` (
  `report_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `report_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `template` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `table_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `type_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `is_private` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `selectedfields` longtext COLLATE utf8_unicode_ci NOT NULL,
  `groupbyfields` longtext COLLATE utf8_unicode_ci NOT NULL,
  `filtercriterias` longtext COLLATE utf8_unicode_ci NOT NULL,
  `orderbyfields` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `orderbygroupfields` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `quickselect` longtext COLLATE utf8_unicode_ci NOT NULL,
  `quickwhere` longtext COLLATE utf8_unicode_ci NOT NULL,
  `quickparameter` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pre_process` mediumtext COLLATE utf8_unicode_ci,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `note` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`report_id`),
  KEY `user_id` (`user_id`),
  KEY `report_name` (`report_name`(10))
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `reports` (`report_id`, `report_name`, `template`, `user_id`, `table_name`, `type_id`, `is_private`, `selectedfields`, `groupbyfields`, `filtercriterias`, `orderbyfields`, `orderbygroupfields`, `quickselect`, `quickwhere`, `quickparameter`, `pre_process`, `created`, `created_by`, `updated`, `updated_by`, `note`) VALUES
('13', 'USA Accounts per State', '', 'initial', 'accounts', '2', '', 'account_name/email/phone/employees/city_billing/state_billing/zipcode_billing/country_billing', '', 'country_billing:contains:usa', '', '', '', '', NULL, NULL, '0000-00-00 00:00:00', 'initial', '0000-00-00 00:00:00', 'initial', ''),
('20', 'My weekly activities', '', 'initial', 'activities', '2', '', 'subject/type_id/priority_id/status_id/activity_start/activity_end/location/account_id/contact_id', '', 'activity_start:period:TW', '', '', '', '', NULL, NULL, '0000-00-00 00:00:00', 'initial', '0000-00-00 00:00:00', 'initial', ''),
('21', 'My monthly activities', '', 'initial', 'activities', '2', '', 'subject/type_id/priority_id/status_id/activity_start/activity_end/location/account_id/contact_id', '', 'activity_start:period:TM', '', '', '', '', NULL, NULL, '0000-00-00 00:00:00', 'initial', '0000-00-00 00:00:00', 'initial', ''),
('22', 'Leads of the month by source', '', 'initial', 'leads', '2', '', 'account_name/full_name/phone/email/address_1/city_1/zipcode_1/state_1/country_1/do_not_call/email_opt_out/industry_id/source_id', 'source_id:grp', 'created:period:TM', '', '', '', '', NULL, NULL, '0000-00-00 00:00:00', 'initial', '0000-00-00 00:00:00', 'initial', ''),
('1', 'All Accounts: with date created and last updated', 'accountsAllInfo.xml', 'initial', 'accounts', '1', 'N', '', '', '', '', '', '"SELECT account_name C1, account_number C2, B.user_name C3, C.source_name C4, D.industry_name C5, employees C6, revenue C7, A.created C8, E.user_name C9, A.updated C10, F.user_name C11, A.note C12 FROM `accounts` A\r\nLEFT OUTER JOIN users B on A.user_id = B.user_id\r\nLEFT OUTER JOIN sources C on A.source_id = C.source_id\r\nLEFT OUTER JOIN industries D on A.industry_id = D.industry_id\r\nLEFT OUTER JOIN users E on A.created_by = E.user_id\r\nLEFT OUTER JOIN users F on A.updated_by = F.user_id', '$bcwhere $range_date 1=1 ORDER BY A.account_name ASC\r\n"', 'popup_range_date', NULL, '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '', ''),
('2', 'All Accounts: with addresses', 'accountsAllDetails.xml', 'initial', 'accounts', '1', 'N', '', '', '', '', '', '"SELECT  B.user_name, A.*\r\nFROM accounts A\r\nLEFT OUTER JOIN users B \r\n ON A.user_id=B.user_id', '$users_scope $range_date 1=1 ORDER BY B.user_name ASC"', 'popup_users_scope', NULL, '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '', ''),
('3', 'All accounts of selected sales representative(s)', 'accountsBySales.xml', 'initial', 'accounts', '1', '', '', '', '', '', '', '"SELECT user_name C1,account_name C2,E.type_name C3,D.industry_name C4,F.rating_name C5,revenue C6 FROM accounts A  LEFT OUTER JOIN users B on A.user_id = B.user_id LEFT OUTER JOIN industries D on A.industry_id = D.industry_id LEFT OUTER JOIN types E on A.type_id=E.type_id LEFT OUTER JOIN ratings F on A.rating_id = F.rating_id ', '$users_scope $range_date 1=1 ORDER BY B.user_name ASC"', 'popup_users_scope', NULL, '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '', ''),
('4', 'All opportunities', 'opportunitiesAll.xml', 'initial', 'opportunities', '1', 'N', '', '', '', '', '', '"SELECT A.opportunity_name C1, B.account_name C2, C.user_name C3, expected_amount C4, closing C5, recurring_amount C6, A.created C7, A.updated C8, D.stage_name C9\r\nFROM opportunities A\r\nleft outer join accounts B on A.account_id = B.account_id\r\nleft outer join users C on A.user_id = C.user_id\r\nleft outer join stages D on D.stage_id = A.stage_id\r\n	', '$range_date 1=1\r\n"', 'popup_range_date', NULL, '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '', ''),
('5', 'All contacts of selected representative(s)', 'contactsAll.xml', 'initial', 'contacts', '1', '', '', '', '', '', '', '"SELECT B.user_name C1, A.first_names C2, A.last_name C3, A.salutation C4, A.title C5, C.account_name C6, A.department C7, D.last_name C8, A.email C9, A.phone C10, A.mobile C11, A.messenger C12, A.messenger_type C13, A.fax C14, A.email_opt_out C15, A.do_not_call C16, A.assistant_id C17, A.private_phone C18, A.private_mobile C19, A.private_email C20, A.birthdate C21, A.address_1 C22, A.zipcode_1 C23, A.city_1 C24, A.state_1 C25, A.country_1 C26, A.address_2 C27, A.zipcode_2 C28, A.city_2 C29, A.state_2 C30, A.country_2 C31, A.note C32\r\nFROM contacts A\r\nLEFT OUTER JOIN users B on A.user_id = B.user_id\r\nLEFT OUTER JOIN accounts C on A.account_id = C.account_id \r\nLEFT OUTER JOIN contacts D ON A.manager_id = D.user_id', '$users_scope $range_date 1=1 "', 'popup_users_scope', NULL, '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '', ''),
('6', 'All leads', 'leadsAll.xml', 'initial', 'leads', '1', 'N', '', '', '', '', '', '"SELECT  B.user_name C1, C.source_name C2, D.industry_name C3, E.type_name C4, F.rating_name C5,\r\n	A.account_name C6, A.url C7,A.employees C8,A.revenue C9, A.first_names C10,A.last_name C11,\r\n	A.salutation C12,A.title C13,A.email C14,A.phone C15,A.mobile C16,\r\n	A.fax C17,A.email_opt_out C18,A.do_not_call C19, A.address_1 C20,A.zipcode_1 C21,\r\n	A.city_1 C22, A.state_1 C23,A.country_1 C24,A.note C25,A.created C26,\r\n	A.created_by C27,A.updated C28, A.updated_by C29 FROM leads A\r\nLEFT OUTER JOIN users B \r\n ON A.user_id=B.user_id \r\nLEFT OUTER JOIN sources C\r\n  ON A.source_id=C.source_id\r\nLEFT OUTER JOIN industries D\r\n  ON A.industry_id=D.industry_id \r\nLEFT OUTER JOIN types E\r\n	  ON A.type_id=E.type_id \r\nLEFT OUTER JOIN ratings F\r\n ON A.rating_id=F.rating_id', '$users_scope $range_date 1=1 ORDER BY B.user_name ASC"', 'popup_users_scope', NULL, '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '', ''),
('12', 'My activities by Status', 'MyActivitiesByStatus.xml', 'initial', 'activities', '1', '', '', '', '', '', '', '"SELECT A.subject C0,B.user_name CB,D.status_name CD,A.activity_start C2,A.activity_end C3,A.updated C5,C.user_name CC,E.priority_name CE FROM activities A  \r\n LEFT OUTER JOIN users B on A.user_id =B.user_id\r\n LEFT OUTER JOIN users C on A.updated_by =C.user_id \r\n LEFT OUTER JOIN activities_statuses D on A.status_id =D.status_id\r\n LEFT OUTER JOIN activities_priorities E on A.priority_id=E.priority_id', ' $range_date A.user_id=''".$GLOBALS[''appshore_data''][''current_user''][''user_id'']."'' order by CB,CD "', 'popup_range_date', NULL, '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', 'initial', ''),
('7', 'My opportunities', 'myOpportunities.xml', 'initial', 'opportunities', '1', 'N', '    ', '', '', '', '', '"SELECT A.opportunity_name C1, B.account_name C2, C.user_name C3, expected_amount C4, closing  C5, recurring_amount C6, A.created C7, A.updated C8, D.stage_name C9 \r\nFROM opportunities A\r\n LEFT OUTER JOIN accounts B on A.account_id=B.account_id\r\n LEFT OUTER JOIN users C on A.user_id=C.user_id \r\n LEFT OUTER JOIN stages D on D.stage_id=A.stage_id', ' $range_date A.user_id=''".$GLOBALS[''appshore_data''][''current_user''][''user_id'']."''  "', 'popup_range_date', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '', ''),
('10', 'My leads', 'myLeads.xml', 'initial', 'leads', '1', '', '', '', '', '', '', '"SELECT  B.user_name C1, C.source_name C2, D.industry_name C3, E.type_name C4, F.rating_name C5,\r\n    A.account_name C6, A.url C7,A.employees C8,A.revenue C9, A.first_names C10,A.last_name C11,\r\n    A.salutation C12,A.title C13,A.email C14,A.phone C15,A.mobile C16,\r\n    A.fax C17,A.email_opt_out C18,A.do_not_call C19, A.address_1 C20,A.zipcode_1 C21,\r\n    A.city_1 C22, A.state_1 C23,A.country_1 C24,A.note C25,A.created C26,\r\n    A.created_by C27,A.updated C28, A.updated_by C29 FROM leads A\r\nLEFT OUTER JOIN users B \r\n ON A.user_id=B.user_id \r\nLEFT OUTER JOIN sources C\r\n  ON A.source_id=C.source_id\r\nLEFT OUTER JOIN industries D\r\n  ON A.industry_id=D.industry_id \r\nLEFT OUTER JOIN types E\r\n      ON A.type_id=E.type_id \r\nLEFT OUTER JOIN ratings F\r\n ON A.rating_id=F.rating_id', ' $range_date A.user_id=''".$GLOBALS[''appshore_data''][''current_user''][''user_id'']."''  "', 'popup_range_date', NULL, '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '', ''),
('8', 'My expected revenues per quarter', 'myExRevenueQ.xml', 'initial', 'opportunities', '1', 'N', '    ', '', '', '', '', '"SELECT quarter(closing) QU, stage_name C1, opportunity_name C4, expected_amount C2, A.stage_id C3\r\nfrom opportunities A\r\nLEFT OUTER JOIN stages B on A.stage_id=B.stage_id', ' $range_date A.user_id=''".$GLOBALS[''appshore_data''][''current_user''][''user_id'']."'' order by QU asc, C3"', 'popup_range_date', NULL, '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '', ''),
('9', 'My contacts', 'myContacts.xml', 'initial', 'contacts', '1', 'N', '', '', '', '', '', '"SELECT B.user_name C1, A.first_names C2, A.last_name C3, A.salutation C4, A.title C5, C.account_name C6, A.department C7, D.last_name C8, A.email C9, A.phone C10, A.mobile C11, A.messenger C12, A.messenger_type C13, A.fax C14, A.email_opt_out C15, A.do_not_call C16, A.assistant_id C17, A.private_phone C18, A.private_mobile C19, A.private_email C20, A.birthdate C21, A.address_1 C22, A.zipcode_1 C23, A.city_1 C24, A.state_1 C25, A.country_1 C26, A.address_2 C27, A.zipcode_2 C28, A.city_2 C29, A.state_2 C30, A.country_2 C31, A.note C32\r\nFROM contacts A\r\nLEFT outer join users B on A.user_id = B.user_id\r\nLEFT outer join accounts C on  A.account_id = C.account_id \r\nLEFT OUTER JOIN contacts D ON A.manager_id = D.contact_id', ' A.user_id=''".$GLOBALS[''appshore_data''][''current_user''][''user_id'']."'' "', NULL, NULL, '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '', '');

DROP TABLE IF EXISTS `reports_columns`;
CREATE TABLE IF NOT EXISTS `reports_columns` (
  `table_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `column_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `column_type` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `lookup_table` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `lookup_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `lookup_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `selectedcolumn` int(11) NOT NULL DEFAULT '0',
  `groupbycolumn` int(11) NOT NULL DEFAULT '0',
  `filtercriteria` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`table_name`,`column_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `reports_columns` (`table_name`, `column_name`, `column_type`, `lookup_table`, `lookup_id`, `lookup_name`, `label`, `selectedcolumn`, `groupbycolumn`, `filtercriteria`) VALUES
('accounts', 'account_name', 'V', '', '', '', 'Account', 1, 1, 1),
('accounts', 'account_top_id', 'L', 'accounts', 'account_id', 'account_name', 'Main Account', 1, 1, 1),
('accounts', 'source_id', 'L', 'sources', 'source_id', 'source_name', 'Source', 1, 1, 1),
('accounts', 'industry_id', 'L', 'industries', 'industry_id', 'industry_name', 'Industry', 1, 1, 1),
('accounts', 'type_id', 'L', 'types', 'type_id', 'type_name', 'Type', 1, 1, 1),
('contacts', 'created', 'D', '', '', '', 'Date of Creation', 1, 0, 0),
('accounts', 'rating_id', 'L', 'ratings', 'rating_id', 'rating_name', 'Rating', 1, 1, 1),
('accounts', 'user_id', 'L', 'users', 'user_id', 'user_name', 'Owner', 1, 1, 1),
('accounts', 'legal_status', 'V', '', '', '', 'Legal Status', 1, 1, 1),
('accounts', 'url', 'V', '', '', '', 'Web Site', 1, 0, 0),
('accounts', 'tax_id', 'V', '', '', '', 'Tax Identifier', 1, 0, 0),
('accounts', 'employees', 'I', '', '', '', 'Employees', 1, 0, 1),
('accounts', 'revenue', 'I', '', '', '', 'Revenue', 1, 0, 1),
('accounts', 'created', 'D', '', '', '', 'Date of Creation', 1, 0, 0),
('accounts', 'created_by', 'L', 'users', 'user_id', 'user_name', 'Created by', 1, 0, 0),
('accounts', 'updated', 'D', '', '', '', 'Last Update', 1, 0, 0),
('accounts', 'updated_by', 'L', 'users', 'user_id', 'user_name', 'Updated by', 1, 0, 0),
('accounts', 'note', 'V', '', '', '', 'Note', 1, 0, 0),
('contacts', 'salutation', 'V', '', '', '', 'Slt', 1, 1, 1),
('contacts', 'first_names', 'V', '', '', '', 'First Name', 1, 0, 1),
('contacts', 'last_name', 'V', '', '', '', 'Last Name', 1, 0, 1),
('contacts', 'title', 'V', '', '', '', 'Title', 1, 0, 1),
('contacts', 'account_id', 'L', 'accounts', 'account_id', 'account_name', 'Account', 1, 1, 1),
('contacts', 'Department', 'V', '', '', '', 'Dpt', 1, 1, 1),
('contacts', 'manager_id', 'L', 'users', 'user_id', 'user_name', 'Manager', 1, 1, 1),
('contacts', 'email', 'V', '', '', '', 'Email', 1, 0, 1),
('contacts', 'phone', 'V', '', '', '', 'Phone', 1, 0, 1),
('contacts', 'mobile', 'V', '', '', '', 'Mobile', 1, 0, 1),
('contacts', 'messenger', 'V', '', '', '', 'Messenger', 1, 0, 1),
('contacts', 'fax', 'V', '', '', '', 'Fax', 1, 0, 1),
('contacts', 'email_opt_out', 'V', '', '', '', 'Email opt', 1, 1, 1),
('contacts', 'do_not_call', 'V', '', '', '', 'No call', 1, 1, 1),
('contacts', 'assistant_id', 'L', 'users', 'user_id', 'user_name', 'Assistant', 1, 0, 1),
('contacts', 'private_phone', 'V', '', '', '', 'Priv Phone', 1, 0, 1),
('contacts', 'private_mobile', 'V', '', '', '', 'Priv Mobile', 1, 0, 1),
('contacts', 'private_email', 'V', '', '', '', 'Priv Email', 1, 0, 1),
('contacts', 'birthdate', 'D', '', '', '', 'Birth', 1, 0, 1),
('contacts', 'address_1', 'V', '', '', '', 'Address 1', 1, 0, 1),
('contacts', 'zipcode_1', 'V', '', '', '', 'ZipCode 1', 1, 0, 1),
('contacts', 'city_1', 'V', '', '', '', 'City 1', 1, 0, 1),
('contacts', 'state_1', 'V', '', '', '', 'State 1', 1, 0, 1),
('contacts', 'country_1', 'V', '', '', '', 'Country 1', 1, 0, 1),
('contacts', 'address_2', 'V', '', '', '', 'Address 2', 1, 0, 1),
('contacts', 'zipcode_2', 'V', '', '', '', 'ZipCode 2', 1, 0, 1),
('contacts', 'city_2', 'V', '', '', '', 'City 2', 1, 0, 1),
('contacts', 'state_2', 'V', '', '', '', 'State 2', 1, 0, 1),
('contacts', 'country_2', 'V', '', '', '', 'Country 2', 1, 0, 1),
('contacts', 'note', 'V', '', '', '', 'Note', 1, 0, 1),
('contacts', 'created_by', 'L', 'users', 'user_id', 'user_name', 'Created by', 1, 1, 0),
('contacts', 'updated', 'D', '', '', '', 'Last Update', 1, 0, 0),
('contacts', 'updated_by', 'L', 'users', 'user_id', 'user_name', 'Updated by', 1, 1, 0),
('opportunities', 'opportunity_name', 'V', '', '', '', 'Opportunity', 1, 1, 1),
('opportunities', 'account_id', 'L', 'accounts', 'account_id', 'account_name', 'Account', 1, 1, 1),
('opportunities', 'user_id', 'L', 'users', 'user_id', 'user_name', 'Owner', 1, 1, 1),
('opportunities', 'source_id', 'L', 'sources', 'source_id', 'source_name', 'Source', 1, 1, 1),
('opportunities', 'stage_id', 'L', 'stages', 'stage_id', 'stage_name', 'Stage', 1, 1, 1),
('opportunities', 'expected_amount', 'I', '', '', '', 'Expected amount', 1, 0, 1),
('opportunities', 'probability', 'I', '', '', '', 'Probability', 1, 0, 1),
('opportunities', 'closing', 'D', '', '', '', 'Closing', 1, 0, 0),
('opportunities', 'recurring_id', 'L', 'opportunities_recurring', 'recurring_id', 'recurring_name', 'Recurring', 1, 1, 1),
('opportunities', 'recurring_amount', 'I', '', '', '', 'Recurring amount', 1, 0, 1),
('opportunities', 'recurring_start_time', 'D', '', '', '', 'Start time', 1, 0, 0),
('opportunities', 'recurring_end_time', 'D', '', '', '', 'End time', 1, 0, 0),
('opportunities', 'created', 'D', '', '', '', 'Date of Creation', 1, 0, 0),
('opportunities', 'created_by', 'L', 'users', 'user_id', 'user_name', 'Created by', 1, 1, 0),
('opportunities', 'updated', 'D', '', '', '', 'Last Update', 1, 0, 0),
('opportunities', 'updated_by', 'L', 'users', 'user_id', 'user_name', 'Updated by', 1, 1, 0),
('opportunities', 'note', 'V', '', '', '', 'Note', 1, 0, 0),
('leads', 'user_id', 'L', 'users', 'user_id', 'user_name', 'Owner', 1, 1, 1),
('leads', 'source_id', 'L', 'sources', 'source_id', 'source_name', 'Source', 1, 1, 1),
('leads', 'industry_id', 'L', 'industries', 'industry_id', 'industry_name', 'Industry', 1, 1, 1),
('leads', 'type_id', 'L', 'types', 'type_id', 'type_name', 'Type', 1, 1, 1),
('leads', 'rating_id', 'L', 'ratings', 'rating_id', 'rating_name', 'Rating', 1, 1, 1),
('leads', 'account_name', 'V', '', '', '', 'Account', 1, 1, 1),
('leads', 'url', 'V', '', '', '', 'Web Site', 1, 0, 0),
('leads', 'employees', 'I', '', '', '', 'Employees', 1, 0, 1),
('leads', 'revenue', 'I', '', '', '', 'Revenue', 1, 0, 1),
('leads', 'first_names', 'V', '', '', '', 'First Name', 1, 0, 1),
('leads', 'last_name', 'V', '', '', '', 'Last Name', 1, 0, 1),
('leads', 'salutation', 'V', '', '', '', 'Salutation', 1, 0, 1),
('leads', 'email', 'V', '', '', '', 'Email', 1, 0, 1),
('leads', 'phone', 'V', '', '', '', 'Phone', 1, 0, 1),
('leads', 'mobile', 'V', '', '', '', 'Mobile', 1, 0, 1),
('leads', 'fax', 'V', '', '', '', 'Fax', 1, 0, 1),
('leads', 'email_opt_out', 'V', '', '', '', 'Email opt', 1, 1, 1),
('leads', 'do_not_call', 'V', '', '', '', 'No call', 1, 1, 1),
('leads', 'address_1', 'V', '', '', '', 'Address 1', 1, 0, 1),
('leads', 'zipcode_1', 'V', '', '', '', 'ZipCode 1', 1, 0, 1),
('leads', 'city_1', 'V', '', '', '', 'City 1', 1, 0, 1),
('leads', 'state_1', 'V', '', '', '', 'State 1', 1, 0, 1),
('leads', 'country_1', 'V', '', '', '', 'Country', 1, 1, 1),
('leads', 'created', 'D', '', '', '', 'Date of Creation', 1, 0, 0),
('leads', 'created_by', 'L', 'users', 'user_id', 'user_name', 'Created by', 1, 1, 0),
('leads', 'updated', 'D', '', '', '', 'Last Update', 1, 0, 0),
('leads', 'updated_by', 'L', 'users', 'user_id', 'user_name', 'Updated by', 1, 1, 0),
('leads', 'note', 'V', '', '', '', 'Note', 1, 0, 0),
('activities', 'user_id', 'L', 'users', 'user_id', 'user_name', 'Owner', 1, 1, 1),
('activities', 'is_private', 'V', '', '', '', 'Private', 1, 1, 1),
('activities', 'status_id', 'L', 'activities_statuses', 'status_id', 'status_name', 'Status', 1, 1, 1),
('activities', 'subject', 'V', '', '', '', 'Subject', 1, 1, 1),
('activities', 'location', 'V', '', '', '', 'Location', 1, 1, 1),
('activities', 'activity_start', 'D', '', '', '', 'Date', 1, 0, 0),
('activities', 'activity_end', 'D', '', '', '', 'Time', 1, 0, 0),
('activities', 'note', 'V', '', '', '', 'Note', 1, 1, 1),
('activities', 'created', 'D', '', '', '', 'Date of Creation', 1, 0, 0),
('activities', 'created_by', 'L', 'users', 'user_id', 'user_name', 'Created by', 1, 0, 0),
('activities', 'updated', 'D', '', '', '', 'Last Update', 1, 0, 0),
('activities', 'updated_by', 'L', 'users', 'user_id', 'user_name', 'Updated by', 1, 0, 0),
('activities', 'type_id', 'L', 'activities_types', 'type_id', 'type_name', 'Type', 1, 1, 1),
('activities', 'priority_id', 'L', 'activities_priorities', 'priority_id', 'priority_name', 'Priority', 1, 1, 1),
('cases', 'user_id', 'L', 'users', 'user_id', 'user_name', 'Owner', 1, 1, 1),
('cases', 'status_id', 'L', 'cases_statuses', 'status_id', 'status_name', 'Status', 1, 1, 1),
('cases', 'subject', 'V', '', '', '', 'Subject', 1, 0, 0),
('cases', 'note', 'V', '', '', '', 'Note', 1, 0, 0),
('cases', 'priority_id', 'L', 'cases_priorities', 'priority_id', 'priority_name', 'Priority', 1, 1, 1),
('cases', 'due_date', 'D', '', '', '', 'Due date', 1, 0, 0),
('cases', 'updated_by', 'L', 'users', 'user_id', 'user_name', 'Updated by', 1, 0, 0),
('cases', 'updated', 'D', '', '', '', 'Last Update', 1, 0, 0),
('cases', 'created_by', 'L', 'users', 'user_id', 'user_name', 'Created by', 1, 0, 0),
('cases', 'created', 'D', '', '', '', 'Date of Creation', 1, 0, 0);

DROP TABLE IF EXISTS `reports_operators`;
CREATE TABLE IF NOT EXISTS `reports_operators` (
  `operator_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `operator_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `operator_label` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `type_enable` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `field_type_enable` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `operator_id` (`operator_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `reports_operators` (`operator_id`, `operator_name`, `operator_label`, `type_enable`, `field_type_enable`) VALUES
('equal', '=', 'equal to', 'V/I/D', 'CU/DA/DD/DT/ET/EH/NU/ML/TE/TI/TS/RK/RR/VF'),
('less', '&lt;', 'less than', 'I/D', 'CU/DA/DT/NU/TI/TS'),
('lessequal', '&lt;&#61;', 'less than or equal to', 'I/D', 'CU/DA/DT/NU/TI/TS'),
('greater', '&gt;', 'greater than', 'I/D', 'CU/DA/DT/NU/TI/TS'),
('greaterequal', '&gt;&#61;', 'greater than or equal to', 'I/D', 'CU/DA/DT/NU/TI/TS'),
('contains', 'like ''%{$rptRIGHT0}%''', 'contains', 'V/L/D', 'DA/DD/DT/ET/EH/ML/TE/TI/TS/RR/RK/VF'),
('starts', 'like ''{$rptRIGHT0}%''', 'starts with', 'V/L/D', 'DA/DD/DT/ET/EH/ML/TE/TI/TS/RR/RK/VF'),
('ends', 'like ''%{$rptRIGHT0}''', 'ends with', 'V/L/D', 'DA/DD/DT/ET/EH/ML/TE/TI/TS/RR/RK/VF'),
('like', 'like', 'like', 'V/L/I/D', 'CU/DA/DD/DT/ET/EH/NU/ML/TE/TI/TS/RK/RR/VF'),
('notlike', 'not like', 'not like', 'V/L/I/D', 'CU/DA/DD/DT/ET/EH/NU/ML/TE/TI/TS/RK/RR/VF'),
('notequal', '!=', 'not equal to', 'V/I/D', 'CU/DA/DD/DT/ET/EH/NU/ML/TE/TI/TS/RK/RR/VF'),
('period', 'period', 'within period', 'D', 'DA/DT/TS');

DROP TABLE IF EXISTS `reports_prefs`;
CREATE TABLE IF NOT EXISTS `reports_prefs` (
  `display_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `report_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `report_user` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `table_name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `background_color` varchar(32) COLLATE utf8_unicode_ci DEFAULT '#FFFFFF',
  `page_size` smallint(6) NOT NULL DEFAULT '100',
  `page_width` smallint(6) NOT NULL DEFAULT '100',
  `page_header` int(11) DEFAULT '0',
  `page_break` smallint(6) NOT NULL DEFAULT '0',
  `document_header` int(11) DEFAULT '0',
  `document_align` varchar(10) COLLATE utf8_unicode_ci DEFAULT 'LEFT',
  `document_footer_gtotal` char(1) COLLATE utf8_unicode_ci DEFAULT '0',
  `print` int(11) NOT NULL DEFAULT '0',
  `trace` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `reports_tables`;
CREATE TABLE IF NOT EXISTS `reports_tables` (
  `table_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `enable` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`table_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `reports_tables` (`table_name`, `label`, `enable`) VALUES
('accounts', 'Accounts', 0),
('contacts', 'Contacts', 0),
('opportunities', 'Opportunities', 0),
('leads', 'Leads', 0),
('activities', 'Activities', 0),
('cases', 'Cases', 0);

DROP TABLE IF EXISTS `reports_types`;
CREATE TABLE IF NOT EXISTS `reports_types` (
  `type_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `type_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `reports_types` (`type_id`, `type_name`) VALUES
('1', 'Predefined'),
('2', 'Custom');

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `role_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `role_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `role_label` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `status_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `created_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `updated` datetime NOT NULL,
  `updated_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role_name` (`role_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `roles` (`role_id`, `role_name`, `role_label`, `status_id`, `created`, `created_by`, `updated`, `updated_by`) VALUES
('admin', 'Administration', 'This Role must not be deleted. \r\nDo not change the permissions on this Role. \r\nAt least one User must be granted this Role.', 'S', '2004-09-10 14:25:23', '1', '2007-10-30 10:34:38', '1'),
('public', 'Public level', 'Read/Write all records, all users - No Admin rights', 'A', '2008-05-14 19:11:36', '1', '2008-05-14 19:13:16', '1'),
('user', 'User Level', 'Read/Write only records assigned to User', 'A', '2008-05-14 19:13:44', '1', '2008-05-14 19:13:44', '1');

DROP TABLE IF EXISTS `roles_statuses`;
CREATE TABLE IF NOT EXISTS `roles_statuses` (
  `status_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `status_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`status_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `roles_statuses` (`status_id`, `status_name`) VALUES
('A', 'Activated'),
('D', 'Deactivated');

DROP TABLE IF EXISTS `sales_quotas`;
CREATE TABLE IF NOT EXISTS `sales_quotas` (
  `user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `amount` decimal(10,0) NOT NULL DEFAULT '0',
  `month` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`user_id`,`month`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `sales_teams`;
CREATE TABLE IF NOT EXISTS `sales_teams` (
  `team_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `team_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `team_top_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `manager_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`team_id`),
  UNIQUE KEY `team_name` (`team_name`(10))
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `sales_users`;
CREATE TABLE IF NOT EXISTS `sales_users` (
  `team_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`team_id`,`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `searches`;
CREATE TABLE IF NOT EXISTS `searches` (
  `search_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `app_name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `search_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `is_private` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  `search_filter` text COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  KEY `app_name` (`app_name`,`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `shop_invoices`;
CREATE TABLE IF NOT EXISTS `shop_invoices` (
  `invoice_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `company_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `invoice_status` char(3) COLLATE utf8_unicode_ci NOT NULL,
  `order_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`invoice_id`),
  KEY `order_id` (`order_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `shop_orders`;
CREATE TABLE IF NOT EXISTS `shop_orders` (
  `order_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `company_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `order_status` enum('CHE','CAN','REG','ACT') COLLATE utf8_unicode_ci NOT NULL,
  `product_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `product_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `users_quota` int(11) NOT NULL DEFAULT '0',
  `price` int(11) NOT NULL DEFAULT '0',
  `period` enum('M','Y') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'M',
  `metric` enum('U','C') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'U',
  `currency_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `quota_records` decimal(15,0) NOT NULL,
  `quota_disk` decimal(15,0) NOT NULL,
  `quota_emails` decimal(15,0) NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  KEY `company_id` (`company_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `sources`;
CREATE TABLE IF NOT EXISTS `sources` (
  `source_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `source_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`source_id`),
  UNIQUE KEY `source_name` (`source_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `sources` (`source_id`, `source_name`) VALUES
('Advertisement', 'Advertisement'),
('Cold calling', 'Cold calling'),
('Direct Mail', 'Direct Mail'),
('Other', 'Other'),
('Radio', 'Radio'),
('Search Engine', 'Search Engine'),
('Seminar', 'Seminar'),
('Telemarketing', 'Telemarketing'),
('Trade Show', 'Trade Show'),
('Web Site', 'Web Site'),
('Word of Mouth', 'Word of Mouth'),
('Expo', 'Expo'),
('Media', 'Media');

DROP TABLE IF EXISTS `stages`;
CREATE TABLE IF NOT EXISTS `stages` (
  `stage_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `stage_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`stage_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `stages` (`stage_id`, `stage_name`) VALUES
('0', 'Lost'),
('10', 'Qualification'),
('20', 'Presentation'),
('40', 'Value Proposition'),
('60', 'Proposal'),
('80', 'Negotiation'),
('100', 'Won');

DROP TABLE IF EXISTS `tags`;
CREATE TABLE IF NOT EXISTS `tags` (
  `tag_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `tag_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `status_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `note` longtext COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`tag_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `tags_records`;
CREATE TABLE IF NOT EXISTS `tags_records` (
  `tag_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `record_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `app_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`tag_id`,`record_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `templates`;
CREATE TABLE IF NOT EXISTS `templates` (
  `template_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `template_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `subject` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `body_text` longtext COLLATE utf8_unicode_ci,
  `body_html` longtext COLLATE utf8_unicode_ci,
  `note` longtext COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`template_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `translation`;
CREATE TABLE IF NOT EXISTS `translation` (
  `phrase` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `is_template` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `ar` longtext COLLATE utf8_unicode_ci NOT NULL,
  `de` longtext COLLATE utf8_unicode_ci NOT NULL,
  `en-gb` longtext COLLATE utf8_unicode_ci NOT NULL,
  `en-us` longtext COLLATE utf8_unicode_ci NOT NULL,
  `es` longtext COLLATE utf8_unicode_ci NOT NULL,
  `fr` longtext COLLATE utf8_unicode_ci NOT NULL,
  `it` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ja` longtext COLLATE utf8_unicode_ci NOT NULL,
  `pt` longtext COLLATE utf8_unicode_ci NOT NULL,
  `zh-cn` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`phrase`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `types`;
CREATE TABLE IF NOT EXISTS `types` (
  `type_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `type_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `types` (`type_id`, `type_name`) VALUES
('Lead', 'Lead'),
('Prospect', 'Prospect'),
('Customer', 'Customer'),
('Closed', 'Closed'),
('Partner', 'Partner'),
('Supplier', 'Supplier'),
('Competitor', 'Competitor');

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `user_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `salutation` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `first_names` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `full_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `manager_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `assistant_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `department_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `locale_date_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '%m/%d/%Y',
  `locale_time_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '%l:%M %p',
  `language_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'en-us',
  `charset_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UTF-8',
  `currency_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'USD',
  `timezone_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'America/Los_Angeles',
  `theme_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'default',
  `notifications_location` enum('TL','TC','TR','BL','BC','BR') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'TC',
  `app_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'accounts',
  `nbrecords` int(4) NOT NULL DEFAULT '15',
  `confirm_delete` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  `email` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `mobile` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `fax` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `private_phone` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `private_mobile` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `private_email` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `birthdate` date NOT NULL DEFAULT '0000-00-00',
  `status_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'A',
  `is_salespeople` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `last_login` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_password_change` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ipacl` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `avatar` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `note` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `user_name` (`user_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `users_roles`;
CREATE TABLE IF NOT EXISTS `users_roles` (
  `user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `role_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `users_roles` (`user_id`, `role_id`) VALUES
('initial', 'admin');

DROP TABLE IF EXISTS `users_statuses`;
CREATE TABLE IF NOT EXISTS `users_statuses` (
  `status_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `status_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`status_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `users_statuses` (`status_id`, `status_name`) VALUES
('A', 'Activated'),
('D', 'Deactivated'),
('L', 'Locked'),
('W', 'W'),
('S', 'Special');

DROP TABLE IF EXISTS `webmail`;
CREATE TABLE IF NOT EXISTS `webmail` (
  `mail_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `folder_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `mail_size` int(11) NOT NULL,
  `isread` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  `bound` enum('I','O','D') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'D',
  `mail_from` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `mail_to` longtext COLLATE utf8_unicode_ci NOT NULL,
  `reply_to` longtext COLLATE utf8_unicode_ci NOT NULL,
  `mail_cc` longtext COLLATE utf8_unicode_ci NOT NULL,
  `mail_bcc` longtext COLLATE utf8_unicode_ci NOT NULL,
  `mail_date` datetime NOT NULL,
  `type` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `subtype` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `encoding` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `subject` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `body_html` longtext COLLATE utf8_unicode_ci NOT NULL,
  `body_text` longtext COLLATE utf8_unicode_ci NOT NULL,
  `priority_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`mail_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `webmail_accounts`;
CREATE TABLE IF NOT EXISTS `webmail_accounts` (
  `account_id` varchar(32) NOT NULL DEFAULT '',
  `account_name` varchar(250) NOT NULL DEFAULT '',
  `user_id` varchar(32) NOT NULL DEFAULT '',
  `signature_id` varchar(32) NOT NULL DEFAULT '',
  `is_enable` enum('Y','N') NOT NULL DEFAULT 'Y',
  `email` varchar(250) NOT NULL DEFAULT '',
  `email_reply` varchar(250) NOT NULL DEFAULT '',
  `pop3_server` varchar(250) NOT NULL DEFAULT '',
  `pop3_port` varchar(10) NOT NULL DEFAULT '110',
  `pop3_ssl` enum('Y','N') NOT NULL DEFAULT 'N',
  `pop3_username` varchar(250) NOT NULL DEFAULT '',
  `pop3_password` varchar(250) NOT NULL DEFAULT '',
  `pop3_lmos` enum('Y','N') NOT NULL DEFAULT 'Y',
  `smtp_server` varchar(250) NOT NULL DEFAULT '',
  `smtp_port` varchar(10) NOT NULL DEFAULT '25',
  `smtp_ssl` enum('Y','N') NOT NULL DEFAULT 'N',
  `smtp_username` varchar(250) NOT NULL DEFAULT '',
  `smtp_password` varchar(250) NOT NULL DEFAULT '',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` varchar(32) NOT NULL DEFAULT '',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`account_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `webmail_attachments`;
CREATE TABLE IF NOT EXISTS `webmail_attachments` (
  `mail_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `attachment_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `subtype` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `filename` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `filesize` int(11) NOT NULL DEFAULT '0',
  KEY `mail_id` (`mail_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `webmail_documents`;
CREATE TABLE IF NOT EXISTS `webmail_documents` (
  `mail_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `document_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  KEY `mail_id` (`mail_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `webmail_folders`;
CREATE TABLE IF NOT EXISTS `webmail_folders` (
  `folder_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `folder_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `folder_type` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'folder',
  `sequence` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`folder_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `webmail_priorities`;
CREATE TABLE IF NOT EXISTS `webmail_priorities` (
  `priority_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `priority_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `priority_sequence` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`priority_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `webmail_priorities` (`priority_id`, `priority_name`, `priority_sequence`) VALUES
('LE', 'Lowest', 1),
('LO', 'Low', 2),
('NO', 'Normal', 3),
('HI', 'High', 4),
('HE', 'Highest', 5);

DROP TABLE IF EXISTS `webmail_signatures`;
CREATE TABLE IF NOT EXISTS `webmail_signatures` (
  `signature_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `signature_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `signature_text` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`signature_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

