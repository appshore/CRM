-- phpMyAdmin SQL Dump
-- version 2.10.3deb1ubuntu0.2
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Mar 28, 2008 at 04:07 PM
-- Server version: 5.0.45
-- PHP Version: 5.2.3-1ubuntu6.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- 
-- Database: `private_global`
-- 

-- --------------------------------------------------------

-- 
-- Table structure for table `applications`
-- 

DROP TABLE IF EXISTS `applications`;
CREATE TABLE IF NOT EXISTS `applications` (
  `app_sequence` int(3) NOT NULL default '0',
  `app_name` varchar(50) collate utf8_unicode_ci NOT NULL default '',
  `app_title` varchar(20) collate utf8_unicode_ci NOT NULL default '',
  `app_status` char(1) collate utf8_unicode_ci NOT NULL default '0',
  `app_visible` char(1) collate utf8_unicode_ci NOT NULL default '',
  `app_quickadd` char(1) collate utf8_unicode_ci NOT NULL default 'N',
  `app_custom` char(1) collate utf8_unicode_ci NOT NULL default 'N',
  PRIMARY KEY  (`app_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `applications`
-- 

INSERT INTO `applications` (`app_sequence`, `app_name`, `app_title`, `app_status`, `app_visible`, `app_quickadd`, `app_custom`) VALUES 
(0, 'dashboards', 'Dashboard', 'A', 'Y', 'N', 'N'),
(0, 'contacts', 'Contacts', 'A', 'Y', 'Y', 'N'),
(0, 'leads', 'Leads', 'A', 'Y', 'Y', 'N'),
(0, 'accounts', 'Accounts', 'A', 'Y', 'Y', 'N'),
(0, 'activities', 'Activities', 'A', 'Y', 'Y', 'N'),
(0, 'opportunities', 'Opportunities', 'A', 'Y', 'Y', 'N'),
(0, 'forecasts', 'Forecasts', 'A', 'Y', 'N', 'N'),
(0, 'cases', 'Cases', 'A', 'Y', 'Y', 'N'),
(0, 'reports', 'Reports', 'A', 'Y', 'N', 'N'),
(0, 'documents', 'Documents', 'A', 'Y', 'Y', 'N'),
(0, 'webmail', 'Webmail', 'A', 'Y', 'Y', 'N'),
(0, 'api', 'api', 'I', 'N', 'N', 'N'),
(0, 'preferences', 'Preferences', 'S', 'Y', 'N', 'N'),
(0, 'administration', 'Administration', 'S', 'Y', 'N', 'N'),
(0, 'base', 'Base', 'I', 'N', 'N', 'N'),
(0, 'campaigns', 'Campaigns', 'A', 'Y', 'N', 'N');


DROP TABLE IF EXISTS `activities_priorities`; 
CREATE TABLE IF NOT EXISTS  `activities_priorities` (
  `priority_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `priority_name` varchar(250) collate utf8_unicode_ci NOT NULL,
  `priority_sequence` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY  (`priority_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `activities_priorities` (`priority_id`, `priority_name`, `priority_sequence`) VALUES 
('LE', 'Lowest', 1),
('LO', 'Low', 2),
('NO', 'Normal', 3),
('HI', 'High', 4),
('HE', 'Highest', 5);

-- 
-- Table structure for table `activities_statuses`
-- 

CREATE TABLE `activities_statuses` (
  `status_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `status_name` varchar(250) collate utf8_unicode_ci NOT NULL,
  `status_sequence` tinyint(4) NOT NULL DEFAULT '0',
  `is_open` enum('Y','N') collate utf8_unicode_ci NOT NULL default 'Y',
  PRIMARY KEY  (`status_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `activities_statuses`
-- 

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

-- 
-- Table structure for table `activities_types`
-- 

CREATE TABLE `activities_types` (
  `type_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `type_app` varchar(250) collate utf8_unicode_ci NOT NULL,
  `type_name` varchar(250) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `activities_types`
-- 

INSERT INTO `activities_types` (`type_id`, `type_app`, `type_name`) VALUES 
('CA', '', 'Call'),
('ME', '', 'Meeting'),
('TA', '', 'Task'),
('EV', '', 'Event'),
('VA', '', 'Vacation'),
('LE', '', 'Leave');


-- 
-- Table structure for table `cases_priorities`
-- 

CREATE TABLE `cases_priorities` (
  `priority_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `priority_name` varchar(250) collate utf8_unicode_ci NOT NULL,
  `priority_sequence` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY  (`priority_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `cases_priorities`
-- 

INSERT INTO `cases_priorities` (`priority_id`, `priority_name`, `priority_sequence`) VALUES 
('LE', 'Lowest', 1),
('LO', 'Low', 2),
('NO', 'Normal', 3),
('HI', 'High', 4),
('HE', 'Highest', 5);



-- 
-- Table structure for table `cases_statuses`
-- 

CREATE TABLE `cases_statuses` (
  `status_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `status_name` varchar(250) collate utf8_unicode_ci NOT NULL,
  `status_sequence` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`status_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `cases_statuses`
-- 

INSERT INTO `cases_statuses` (`status_id`, `status_name`, `status_sequence`) VALUES 
('NE', 'New', 1),
('AS', 'Assigned', 2),
('IP', 'In progress', 3),
('CL', 'Closed', 4),
('RE', 'Rejected', 5);

-- 
-- Table structure for table `countries`
-- 

DROP TABLE IF EXISTS `countries`;
CREATE TABLE IF NOT EXISTS `countries` (
  `country_name` varchar(100) collate utf8_unicode_ci NOT NULL default '',
  `un_code` varchar(4) collate utf8_unicode_ci NOT NULL default '',
  `country_id` varchar(4) collate utf8_unicode_ci NOT NULL default '',
  `telephone_code` varchar(10) collate utf8_unicode_ci NOT NULL default '',
  PRIMARY KEY  (`country_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `countries`
-- 

INSERT INTO `countries` (`country_name`, `un_code`, `country_id`, `telephone_code`) VALUES 
('Afghanistan', '004', 'AFG', '93'),
('Albania', '008', 'ALB', '355'),
('Algeria', '012', 'DZA', '213'),
('American Samoa', '016', 'ASM', '684'),
('Andorra', '020', 'AND', '376'),
('Angola', '024', 'AGO', '244'),
('Anguilla', '660', 'AIA', '1 264'),
('Antarctica', '010', 'ATA', '672'),
('Antigua and Barbuda', '028', 'ATG', '1 268'),
('Argentina', '032', 'ARG', '54'),
('Armenia', '051', 'ARM', '374'),
('Aruba', '533', 'ABW', '297'),
('Australia', '036', 'AUS', '61'),
('Austria', '040', 'AUT', '43'),
('Azerbaijan', '031', 'AZE', '994'),
('Bahamas', '044', 'BHS', '1 242'),
('Bahrain', '048', 'BHR', '973'),
('Bangladesh', '050', 'BGD', '880'),
('Barbados', '052', 'BRB', '1 246'),
('Belarus', '112', 'BLR', '375'),
('Belgium', '056', 'BEL', '32'),
('Belize', '084', 'BLZ', '501'),
('Benin', '204', 'BEN', '229'),
('Bermuda', '060', 'BMU', '1 441'),
('Bhutan', '064', 'BTN', '975'),
('Bolivia', '068', 'BOL', '591'),
('Bosnia and Herzegovina', '070', 'BIH', '387'),
('Botswana', '072', 'BWA', '267'),
('Brazil', '076', 'BRA', '55'),
('British Virgin Islands', '092', 'VGB', '1 284'),
('Brunei Darussalam', '096', 'BRN', '673'),
('Bulgaria', '100', 'BGR', '359'),
('Burkina Faso', '854', 'BFA', '226'),
('Burundi', '108', 'BDI', '257'),
('Cambodia', '116', 'KHM', '855'),
('Cameroon', '120', 'CMR', '237'),
('Canada', '124', 'CAN', '1'),
('Cape Verde', '132', 'CPV', '238'),
('Cayman Islands', '136', 'CYM', '1 345'),
('Central African Republic', '140', 'CAF', '236'),
('Chad', '148', 'TCD', '235'),
('Chile', '152', 'CHL', '56'),
('China', '156', 'CHN', '86'),
('Christmas Island', '162', 'CXR', '61'),
('Cocos (Keeling) Islands', '166', 'CCK', '61'),
('Colombia', '170', 'COL', '57'),
('Comoros', '174', 'COM', '269'),
('Congo', '178', 'COG', '242'),
('Cook Islands', '184', 'COK', '682'),
('Costa Rica', '188', 'CRI', '506'),
('Cote d''Ivoire', '384', 'CIV', '225'),
('Croatia', '191', 'HRV', '385'),
('Cuba', '192', 'CUB', '53'),
('Cyprus', '196', 'CYP', '357'),
('Czech Republic', '203', 'CZE', '420'),
('Korea (North Korea)', '408', 'PRK', '850'),
('Congo', '180', 'COD', '243'),
('Denmark', '208', 'DNK', '45'),
('Djibouti', '262', 'DJI', '253'),
('Dominica', '212', 'DMA', '1 767'),
('Dominican Republic', '214', 'DOM', '1 809'),
('Ecuador', '218', 'ECU', '593'),
('Egypt', '818', 'EGY', '20'),
('El Salvador', '222', 'SLV', '503'),
('Equatorial Guinea', '226', 'GNQ', '240'),
('Eritrea', '232', 'ERI', '291'),
('Estonia', '233', 'EST', '372'),
('Ethiopia', '231', 'ETH', '251'),
('Faeroe Islands', '234', 'FRO', '298'),
('Falkland Islands (Malvinas)', '238', 'FLK', '500'),
('Federated States of Micronesia', '583', 'FSM', '691'),
('Fiji', '242', 'FJI', '679'),
('Finland', '246', 'FIN', '358'),
('France', '250', 'FRA', '33'),
('French Guiana', '254', 'GUF', '594'),
('French Polynesia', '258', 'PYF', '689'),
('Gabon', '266', 'GAB', '241'),
('Gambia', '270', 'GMB', '220'),
('Georgia', '268', 'GEO', '995'),
('Germany', '276', 'DEU', '49'),
('Ghana', '288', 'GHA', '233'),
('Gibraltar', '292', 'GIB', '350'),
('Greece', '300', 'GRC', '30'),
('Greenland', '304', 'GRL', '299'),
('Grenada', '308', 'GRD', '1 473'),
('Guadeloupe', '312', 'GLP', '590'),
('Guam', '316', 'GUM', '1 671'),
('Guatemala', '320', 'GTM', '502'),
('Guinea', '324', 'GIN', '224'),
('Guinea-Bissau', '624', 'GNB', '245'),
('Guyana', '328', 'GUY', '592'),
('Haiti', '332', 'HTI', '509'),
('Holy See', '336', 'VAT', '39'),
('Honduras', '340', 'HND', '504'),
('Hong Kong (China)', '344', 'HKG', '852'),
('Hungary', '348', 'HUN', '36'),
('Iceland', '352', 'ISL', '354'),
('India', '356', 'IND', '91'),
('Indonesia', '360', 'IDN', '62'),
('Iran', '364', 'IRN', '98'),
('Iraq', '368', 'IRQ', '964'),
('Ireland', '372', 'IRL', '353'),
('Israel', '376', 'ISR', '972'),
('Italy', '380', 'ITA', '39'),
('Jamaica', '388', 'JAM', '1 876'),
('Japan', '392', 'JPN', '81'),
('Jordan', '400', 'JOR', '962'),
('Kazakhstan', '398', 'KAZ', '7'),
('Kenya', '404', 'KEN', '254'),
('Kiribati', '296', 'KIR', '686'),
('Kuwait', '414', 'KWT', '965'),
('Kyrgyzstan', '417', 'KGZ', '996'),
('Laos', '418', 'LAO', '856'),
('Latvia', '428', 'LVA', '371'),
('Lebanon', '422', 'LBN', '961'),
('Lesotho', '426', 'LSO', '266'),
('Liberia', '430', 'LBR', '231'),
('Libya', '434', 'LBY', '218'),
('Liechtenstein', '438', 'LIE', '423'),
('Lithuania', '440', 'LTU', '370'),
('Luxembourg', '442', 'LUX', '352'),
('Macau', '446', 'MAC', '853'),
('Madagascar', '450', 'MDG', '261'),
('Malawi', '454', 'MWI', '265'),
('Malaysia', '458', 'MYS', '60'),
('Maldives', '462', 'MDV', '960'),
('Mali', '466', 'MLI', '223'),
('Malta', '470', 'MLT', '356'),
('Marshall Islands', '584', 'MHL', '692'),
('Martinique', '474', 'MTQ', '596'),
('Mauritania', '478', 'MRT', '222'),
('Mauritius', '480', 'MUS', '230'),
('Mayotte', '175', 'MYT', '269'),
('Mexico', '484', 'MEX', '52'),
('Monaco', '492', 'MCO', '377'),
('Mongolia', '496', 'MNG', '976'),
('Montserrat', '500', 'MSR', '1 664'),
('Morocco', '504', 'MAR', '212'),
('Mozambique', '508', 'MOZ', '258'),
('Myanmar', '104', 'MMR', '95'),
('Namibia', '516', 'NAM', '264'),
('Nauru', '520', 'NRU', '674'),
('Nepal', '524', 'NPL', '977'),
('Netherlands', '528', 'NLD', '31'),
('Netherlands Antilles', '530', 'ANT', '599'),
('New Caledonia', '540', 'NCL', '687'),
('New Zealand', '554', 'NZL', '64'),
('Nicaragua', '558', 'NIC', '505'),
('Niger', '562', 'NER', '227'),
('Nigeria', '566', 'NGA', '234'),
('Niue', '570', 'NIU', '683'),
('Norfolk Island', '574', 'NFK', '672'),
('Northern Mariana Islands', '580', 'MNP', '1 670'),
('Norway', '578', 'NOR', '47'),
('Oman', '512', 'OMN', '968'),
('Pakistan', '586', 'PAK', '92'),
('Palau', '585', 'PLW', '680'),
('Panama', '591', 'PAN', '507'),
('Papua New Guinea', '598', 'PNG', '675'),
('Paraguay', '600', 'PRY', '595'),
('Peru', '604', 'PER', '51'),
('Philippines', '608', 'PHL', '63'),
('Poland', '616', 'POL', '48'),
('Portugal', '620', 'PRT', '351'),
('Puerto Rico', '630', 'PRI', '1 787'),
('Qatar', '634', 'QAT', '974'),
('Korea (South Korea)', '410', 'KOR', '82'),
('Moldova', '498', 'MDA', '373'),
('Romania', '642', 'ROM', '40'),
('Russian Federation', '643', 'RUS', '7'),
('Rwanda', '646', 'RWA', '250'),
('Saint Helena', '654', 'SHN', '290'),
('Saint Kitts and Nevis', '659', 'KNA', '1 869'),
('Saint Lucia', '662', 'LCA', '1 758'),
('Saint Pierre and Miquelon', '666', 'SPM', '508'),
('Saint Vincent and the Grenadines', '670', 'VCT', '1 784'),
('Samoa', '882', 'WSM', '685'),
('San Marino', '674', 'SMR', '378'),
('Saudi Arabia', '682', 'SAU', '966'),
('Senegal', '686', 'SEN', '221'),
('Seychelles', '690', 'SYC', '248'),
('Sierra Leone', '694', 'SLE', '232'),
('Singapore', '702', 'SGP', '65'),
('Slovakia', '703', 'SVK', '421'),
('Slovenia', '705', 'SVN', '386'),
('Solomon Islands', '90', 'SLB', '677'),
('Somalia', '706', 'SOM', '252'),
('South Africa', '710', 'ZAF', '27'),
('Spain', '724', 'ESP', '34'),
('Sri Lanka', '144', 'LKA', '94'),
('Sudan', '736', 'SDN', '249'),
('Suriname', '740', 'SUR', '597'),
('Swaziland', '748', 'SWZ', '268'),
('Sweden', '752', 'SWE', '46'),
('Switzerland', '756', 'CHE', '41'),
('Syrian Arab Republic', '760', 'SYR', '963'),
('Taiwan', '158', 'TWN', '886'),
('Tajikistan', '762', 'TJK', '7'),
('Thailand', '764', 'THA', '66'),
('Macedonia', '807', 'MKD', '389'),
('Togo', '768', 'TGO', '228'),
('Tonga', '776', 'TON', '676'),
('Trinidad and Tobago', '780', 'TTO', '1 868'),
('Tunisia', '788', 'TUN', '216'),
('Turkey', '792', 'TUR', '90'),
('Turkmenistan', '795', 'TKM', '993'),
('Turks and Caicos Islands', '796', 'TCA', '1 649'),
('Tuvalu', '798', 'TUV', '688'),
('Uganda', '800', 'UGA', '256'),
('Ukraine', '804', 'UKR', '380'),
('United Arab Emirates', '784', 'ARE', '971'),
('United Kingdom', '826', 'GBR', '44'),
('Tanzania', '834', 'TZA', '255'),
('United States of America', '840', 'USA', '1'),
('United States Virgin Islands', '850', 'VIR', '1 340'),
('Uruguay', '858', 'URY', '598'),
('Uzbekistan', '860', 'UZB', '998'),
('Vanuatu', '548', 'VUT', '678'),
('Venezuela', '862', 'VEN', '58'),
('Viet Nam', '704', 'VNM', '84'),
('Yemen', '887', 'YEM', '967'),
('Yugoslavia', '891', 'YUG', '381'),
('Zambia', '894', 'ZMB', '260'),
('Zimbabwe', '716', 'ZWE', '263');

-- --------------------------------------------------------

-- 
-- Table structure for table `countries_states`
-- 

DROP TABLE IF EXISTS `countries_states`;
CREATE TABLE IF NOT EXISTS `countries_states` (
  `country_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `state_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `state_code` varchar(32) collate utf8_unicode_ci NOT NULL,
  `state_name` varchar(250) collate utf8_unicode_ci NOT NULL,
  `state_capital` varchar(250) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`country_id`,`state_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `countries_states`
-- 

INSERT INTO `countries_states` (`country_id`, `state_id`, `state_code`, `state_name`, `state_capital`) VALUES 
('USA', 'AL', '22', 'Alabama', 'Montgomery'),
('USA', 'AK', '49', 'Alaska', 'Juneau'),
('USA', 'AZ', '48', 'Arizona', 'Phoenix'),
('USA', 'AR', '25', 'Arkansas', 'Little Rock'),
('USA', 'CA', '31', 'California', 'Sacramento'),
('USA', 'CO', '38', 'Colorado', 'Denver'),
('USA', 'CT', '5', 'Connecticut', 'Hartford'),
('USA', 'DE', '1', 'Delaware', 'Dover'),
('USA', 'DC', '', 'District of Columbia', 'Washington'),
('USA', 'FL', '27', 'Florida', 'Tallahassee'),
('USA', 'GA', '4', 'Georgia', 'Atlanta'),
('USA', 'HI', '50', 'Hawaii', 'Honolulu'),
('USA', 'ID', '43', 'Idaho', 'Boise'),
('USA', 'IL', '21', 'Illinois', 'Springfield'),
('USA', 'IN', '19', 'Indiana', 'Indianapolis'),
('USA', 'IA', '29', 'Iowa', 'Des Moines'),
('USA', 'KS', '34', 'Kansas', 'Topeka'),
('USA', 'KY', '15', 'Kentucky', 'Frankfort'),
('USA', 'LA', '18', 'Louisiana', 'Baton Rouge'),
('USA', 'ME', '23', 'Maine', 'Augusta'),
('USA', 'MD', '7', 'Maryland', 'Annapolis'),
('USA', 'MA', '6', 'Massachusetts', 'Boston'),
('USA', 'MI', '26', 'Michigan', 'Lansing'),
('USA', 'MN', '32', 'Minnesota', 'St Paul'),
('USA', 'MS', '20', 'Mississippi', 'Jackson'),
('USA', 'MO', '24', 'Missouri', 'Jefferson City'),
('USA', 'MT', '41', 'Montana', 'Helena'),
('USA', 'NE', '37', 'Nebraska', 'Lincoln'),
('USA', 'NV', '36', 'Nevada', 'Carson City'),
('USA', 'NJ', '3', 'New Jersey', 'Trenton'),
('USA', 'NH', '9', 'New Hampshire', 'Concord'),
('USA', 'NM', '47', 'New Mexico', 'Santa Fe'),
('USA', 'NY', '11', 'New York', 'Albany'),
('USA', 'NC', '12', 'North Carolina', 'Raleigh'),
('USA', 'ND', '39', 'North Dakota', 'Bismarck'),
('USA', 'OH', '17', 'Ohio', 'Columbus'),
('USA', 'OK', '46', 'Oklahoma', 'Oklahoma City'),
('USA', 'OR', '33', 'Oregon', 'Salem'),
('USA', 'PA', '2', 'Pennsylvania', 'Harrisburg'),
('USA', 'RI', '13', 'Rhode Island', 'Providence'),
('USA', 'SC', '8', 'South Carolina', 'Columbia'),
('USA', 'SD', '40', 'South Dakota', 'Pierre'),
('USA', 'TN', '16', 'Tennessee', 'Nashville'),
('USA', 'TX', '28', 'Texas', 'Austin'),
('USA', 'UT', '45', 'Utah', 'Salt Lake City'),
('USA', 'VT', '14', 'Vermont', 'Montpelier'),
('USA', 'VA', '10', 'Virginia', 'Richmond'),
('USA', 'WA', '42', 'Washington', 'Olympia'),
('USA', 'WV', '35', 'West Virginia', 'Charleston'),
('USA', 'WI', '30', 'Wisconsin', 'Madison'),
('USA', 'WY', '44', 'Wyoming', 'Cheyenne');

-- --------------------------------------------------------

-- 
-- Table structure for table `currencies`
-- 

DROP TABLE IF EXISTS `currencies`;
CREATE TABLE IF NOT EXISTS `currencies` (
  `currency_id` varchar(3) collate utf8_unicode_ci NOT NULL default '',
  `country_name` varchar(50) collate utf8_unicode_ci NOT NULL default '',
  `currency_name` varchar(50) collate utf8_unicode_ci NOT NULL default '',
  `vsUSD` float NOT NULL default '0',
  `is_available` enum('Y','N') collate utf8_unicode_ci NOT NULL default 'N',
  PRIMARY KEY  (`currency_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `currencies`
-- 

INSERT INTO `currencies` (`currency_id`, `country_name`, `currency_name`, `vsUSD`, `is_available`) VALUES 
('DZD', 'Algeria', 'Algerian Dinar', 0.014118, 'Y'),
('ARS', 'Argentina', 'Argentine Peso', 0.33784, 'Y'),
('AUD', 'Australia', 'Australian Dollar', 0.68814, 'Y'),
('BSD', 'Bahamas', 'Bahamas Dollar', 1, 'Y'),
('BBD', 'Barbados', 'Barbados Dollar', 0.50125, 'Y'),
('BMD', 'Bermuda', 'Bermuda Dollar', 1, 'Y'),
('BRL', 'Brazil', 'Brazilian Real', 0.31903, 'Y'),
('CAD', 'Canada', 'Canadian Dollar', 0.73643, 'Y'),
('CLP', 'Chile', 'Chilian Peso', 0.0015546, 'Y'),
('CNY', 'China', 'Chinese Yuan (Renminbi)', 0.12082, 'Y'),
('COP', 'Colombia', 'Colombian Peso', 0.00036849, 'Y'),
('CRC', 'Costa Rica', 'Costa Rica Colon', 0.0022913, 'Y'),
('CYP', 'Cyprus', 'Cyprian Pound', 2.0781, 'Y'),
('CZK', 'Czech Republic', 'Czech Koruna', 0.037882, 'Y'),
('DKK', 'Denmark', 'Danish Kroner', 0.1626, 'Y'),
('XCD', 'Eastern Caribbean', 'Eastern Caribbean Dollar', 0.37106, 'Y'),
('EGP', 'Egypt', 'Egyptian Pound', 0.16103, 'Y'),
('EUR', 'European Union', 'Euro', 1.2086, 'Y'),
('FJD', 'Fiji', 'Fijian Dollar', 0.55689, 'Y'),
('HKD', 'Hong Kong', 'Hong Kong Dollar', 0.12822, 'Y'),
('HUF', 'Hungary', 'Hungarian Forint', 0.0047533, 'Y'),
('ISK', 'Iceland', 'Icelandic Krona', 0.013765, 'Y'),
('INR', 'India', 'Indian Rupee', 0.021877, 'Y'),
('IDR', 'Indonesia', 'Indonesian Rupiah', 0.00010612, 'Y'),
('ILS', 'Israel', 'Israeli New Shekel', 0.22198, 'Y'),
('JMD', 'Jamaica', 'Jamaican Dollar', 0.016273, 'Y'),
('JPY', 'Japan', 'Japanese Yen', 0.0091979, 'Y'),
('JOD', 'Jordan', 'Jordanian Dinar', 1.4104, 'Y'),
('LBP', 'Lebanon', 'Lebanon Pound', 0.00066007, 'Y'),
('LTL', 'Lithuania', 'Lithuanian Litas', 0.35007, 'Y'),
('MYR', 'Malaysia', 'Malaysian Ringgit', 0.26316, 'Y'),
('MXN', 'Mexico', 'Mexican Pesos', 0.088129, 'Y'),
('NZD', 'New Zealand', 'New Zealand Dollar', 0.62574, 'Y'),
('NOK', 'Norway', 'Norwegian Kroner', 0.14434, 'Y'),
('PKR', 'Pakistan', 'Pakistan Rupee', 0.017256, 'Y'),
('PAB', 'Panama', 'Panamanian Balboa', 1, 'Y'),
('PHP', 'Philippines', 'Filipino Peso', 0.017786, 'Y'),
('PLN', 'Poland', 'Polish Zloty', 0.26456, 'Y'),
('ROL', 'Romania', 'Romanian Leu', 2.9715e-05, 'Y'),
('SAR', 'Saudi Arabia', 'Saudi Arabian Riyal', 0.26665, 'Y'),
('SGD', 'Singapore', 'Singapore Dollar', 0.58075, 'Y'),
('SKK', 'Slovakia', 'Slovak Koruna', 0.03026, 'Y'),
('ZAR', 'South Africa', 'South African Rand', 0.15963, 'Y'),
('KRW', 'South Korea', 'Korean Won', 0.00086222, 'Y'),
('LKR', 'Sri Lanka', 'Sri Lankan Rupee', 0.0097934, 'Y'),
('SDD', 'Sudan', 'Sudanese Pound', 0.0038537, 'Y'),
('SEK', 'Sweden', 'Swedish Krona', 0.13182, 'Y'),
('CHF', 'Switzerland', 'Swiss Franc', 0.79688, 'Y'),
('TWD', 'Taiwan', 'New Taiwan Dollar', 0.029602, 'Y'),
('THB', 'Thailand', 'Thai Baht', 0.024393, 'Y'),
('TTD', 'Trinidad & Tobago', 'Trinidad & Tobago Dollar', 0.16129, 'Y'),
('TRL', 'Turkey', 'Turkish Lira', 0.67159, 'Y'),
('GBP', 'United Kingdom', 'British Pound Sterling', 1.8182, 'Y'),
('USD', 'United States of America', 'United States Dollar', 1, 'Y'),
('VEB', 'Venezuela', 'Venezuelan Bolivar', 0.00052149, 'Y'),
('ZMK', 'Zambia', 'Zambian Kwacha', 0.00020619, 'Y'),
('KES', 'Kenya', 'Kenya shilling', 0.0135776, 'Y'),
('SIT', 'Slovenia', 'Slovenian Tolar', 0.004872, 'Y');

-- --------------------------------------------------------

-- 
-- Table structure for table `dashboards_apps`
-- 

DROP TABLE IF EXISTS `dashboards_apps`;
CREATE TABLE IF NOT EXISTS `dashboards_apps` (
  `dashlet_name` varchar(50) collate utf8_unicode_ci NOT NULL,
  `template_path` varchar(50) collate utf8_unicode_ci NOT NULL default '',
  `xml_scope` varchar(50) collate utf8_unicode_ci NOT NULL default '',
  `app_path` varchar(100) character set utf8 NOT NULL default '',
  `app_param` varchar(50) collate utf8_unicode_ci NOT NULL default '',
  `filter` varchar(250) collate utf8_unicode_ci NOT NULL default '',
  `scope` varchar(20) collate utf8_unicode_ci NOT NULL default 'user',
  `orderby` varchar(100) collate utf8_unicode_ci NOT NULL default '',
  `ascdesc` varchar(100) collate utf8_unicode_ci NOT NULL default '',
  `display` int(2) NOT NULL default '5',
  `app_label` varchar(50) collate utf8_unicode_ci NOT NULL default '',
  `app_width` char(1) collate utf8_unicode_ci NOT NULL default '',
  PRIMARY KEY  (`dashlet_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `dashboards_apps`
-- 

INSERT INTO `dashboards_apps` (`dashlet_name`, `template_path`, `xml_scope`, `app_path`, `app_param`, `filter`, `scope`, `orderby`, `ascdesc`, `display`, `app_label`, `app_width`) VALUES 
('history', 'dashboards.base', '', '', '', '', 'user', '', '', 5, 'Last Viewed', 'N'),
('weather_forecast_weekly', 'weather.dashboard', 'weather', 'weather.base.view_weekly', '', '', 'user', '', '', 5, 'Weather Weekly Forecast', 'W'),
('accounts_most_actives', '', 'accounts', '', '', '', 'user', 'updated', 'desc', 5, 'Most Active Accounts', 'W'),
('accounts_neglected', '', 'accounts', '', '', '', 'user', 'updated', 'asc', 5, 'Neglected Accounts', 'N'),
('top_opportunities', '', 'opportunities', '', '', 'probability not in ("0","100")', 'user', 'expected_amount', 'desc', 5, 'Top open opportunities', 'N'),
('upcoming_activities_narrow', '', 'activities', '', '', 'activity_start >= now()', 'user', 'activity_start', 'asc', 5, 'My Upcoming Activities', 'N'),
('open_cases', '', 'cases', '', '', 't0.status_id not in ("CL")', 'user', 'due_date', 'asc', 5, 'Open Cases', 'N'),
('upcoming_activities_wide', '', 'activities', '', '', 'activity_start >= now()', 'user', 'activity_start', 'desc', 5, 'My Upcoming Activities by date', 'W'),
('weather_forecast_daily', 'weather.dashboard', 'weather', 'weather.base.view_daily', '', '', 'user', '', '', 5, 'Weather Daily Forecast', 'N'),
('upcoming_activities_wide_priority', '', 'activities', '', '', 'activity_start >= now()', 'user', 'priority_id', 'desc', 5, 'My Upcoming Activities by priority', 'W'),
('last_leads', '', 'leads', '', '', '', 'user', 'created', 'desc', 5, 'Last Leads', 'W'),
('last_emails', '', 'webmail', '', '', '', 'user', 'mail_date', 'desc', 10, 'Last Emails', 'W'),
('open_opportunities', '', 'opportunities', '', '', 'probability not in ("0","100")', 'user', 'closing', 'asc', 5, 'Open opportunities', 'W'),
('cal_dashboard_daylist', '', 'calendar', 'calendar.dashboard.board_daylist', 'key=dash', '', 'user', '', '', 5, 'Today''s activities', 'N'),
('cal_dashboard_month', '', 'calendar', 'calendar.dashboard.board_month', 'key=dash', '', 'user', '', '', 5, 'This Month', 'N'),
('unread_emails', '', 'webmail', '', '', 'isread="N"', 'user', 'mail_date', 'desc', 10, 'Unread Emails', 'W');

-- --------------------------------------------------------

-- 
-- Table structure for table `dashboards_themes`
-- 

DROP TABLE IF EXISTS `dashboards_themes`;
CREATE TABLE IF NOT EXISTS `dashboards_themes` (
  `theme_id` int(4) NOT NULL default '0',
  `theme_name` varchar(50) collate utf8_unicode_ci NOT NULL default '',
  PRIMARY KEY  (`theme_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `dashboards_themes`
-- 

INSERT INTO `dashboards_themes` (`theme_id`, `theme_name`) VALUES 
(1, 'portal_box_1'),
(2, 'portal_box_2'),
(3, 'portal_box_3'),
(4, 'portal_box_4'),
(0, 'portal_box_0'),
(5, 'portal_box_5');

-- --------------------------------------------------------

-- 
-- Table structure for table `days`
-- 

DROP TABLE IF EXISTS `days`;
CREATE TABLE IF NOT EXISTS `days` (
  `day_id` tinyint(4) NOT NULL,
  `day_name` varchar(50) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`day_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `days`
-- 

INSERT INTO `days` (`day_id`, `day_name`) VALUES 
(1, 'Monday'),
(2, 'Tuesday'),
(3, 'Wednesday'),
(4, 'Thursday'),
(5, 'Friday'),
(6, 'Saturday'),
(7, 'Sunday');

-- --------------------------------------------------------

-- 
-- Table structure for table `db_applications`
-- 

CREATE TABLE `db_applications` (
  `app_name` varchar(50) collate utf8_unicode_ci NOT NULL,
  `app_label` varchar(250) collate utf8_unicode_ci NOT NULL,
  `app_sequence` int(4) NOT NULL default '0',
  `status_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `table_name` varchar(50) collate utf8_unicode_ci NOT NULL,
  `field_name` varchar(50) collate utf8_unicode_ci NOT NULL,
  `is_related` enum('Y','N') collate utf8_unicode_ci NOT NULL default 'Y',
  `is_visible` enum('Y','N') collate utf8_unicode_ci NOT NULL default 'Y',
  `is_search` enum('Y','N') collate utf8_unicode_ci NOT NULL default 'Y',
  `is_customizable` enum('Y','N') collate utf8_unicode_ci NOT NULL default 'N',
  `is_report` enum('Y','N') collate utf8_unicode_ci NOT NULL default 'N',
  `is_quickadd` enum('Y','N') collate utf8_unicode_ci NOT NULL default 'N',
  `excluded_tabs` varchar(250) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`app_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `db_applications`
-- 

INSERT INTO `db_applications` (`app_name`, `app_label`, `app_sequence`, `status_id`, `table_name`, `field_name`, `is_related`, `is_visible`, `is_search`, `is_customizable`, `is_report`, `is_quickadd`, `excluded_tabs`) VALUES 
('accounts', 'Accounts', 1, 'A', 'accounts', 'account_id', 'Y', 'Y', 'Y', 'Y', 'Y', 'N', ''),
('activities', 'Activities', 11, 'A', 'activities', 'activity_id', 'Y', 'Y', 'Y', 'Y', 'Y', 'N', ''),
('administration', 'Administration', 0, 'S', '', '', 'N', 'N', 'N', 'N', 'N', 'N', ''),
('administration_applications', 'Administration - Applications', 20, 'S', 'db_applications', 'app_name', 'Y', 'Y', 'N', 'Y', 'N', 'N', ''),
('administration_company', 'Administration - Company', 12, 'S', 'company', 'company_id', 'Y', 'Y', 'N', 'Y', 'N', 'N', ''),
('administration_departments', 'Administration - Departments', 13, 'S', 'departments', 'department_id', 'Y', 'Y', 'N', 'Y', 'N', 'N', ''),
('administration_roles', 'Administration - Roles', 14, 'S', 'roles', 'role_id', 'Y', 'Y', 'N', 'Y', 'N', 'N', ''),
('administration_users', 'Administration - Users', 15, 'S', 'users', 'user_id', 'Y', 'Y', 'N', 'Y', 'N', 'N', ''),
('api', 'api', 0, 'I', '', '', 'N', 'N', 'N', 'N', 'N', 'N', ''),
('campaigns', 'Campaigns', 13, 'A', 'campaigns', 'campaign_id', 'Y', 'Y', 'Y', 'Y', 'Y', 'N', ''),
('campaigns_history', 'Campaigns - History', 18, 'S', 'campaigns_history_view', 'campaign_id', 'Y', 'Y', 'Y', 'Y', 'N', 'N', ''),
('campaigns_lists', 'Campaigns - Lists', 19, 'S', 'campaigns_lists', 'list_id', 'Y', 'Y', 'N', 'Y', 'N', 'N', ''),
('campaigns_records', 'Campaigns - List Records', 10, 'S', 'campaigns_records_view', 'record_id', 'Y', 'Y', 'Y', 'Y', 'N', 'N', ''),
('cases', 'Cases', 10, 'A', 'cases', 'case_id', 'Y', 'Y', 'Y', 'Y', 'Y', 'N', ''),
('contacts', 'Contacts', 9, 'A', 'contacts', 'contact_id', 'Y', 'Y', 'Y', 'Y', 'Y', 'N', ''),
('dashboards', 'Dashboard', 3, 'A', 'dashboards', 'dashboard_id', 'Y', 'Y', 'Y', 'Y', 'Y', 'N', ''),
('documents', 'Documents', 4, 'A', 'documents', 'document_id', 'Y', 'Y', 'Y', 'Y', 'Y', 'N', ''),
('forecasts', 'Forecasts', 2, 'A', 'opportunities', 'opportunity_id', 'Y', 'Y', 'N', 'N', 'Y', 'N', ''),
('leads', 'Leads', 5, 'A', 'leads', 'lead_id', 'Y', 'Y', 'Y', 'Y', 'Y', 'N', ''),
('opportunities', 'Opportunities', 6, 'A', 'opportunities', 'opportunity_id', 'Y', 'Y', 'Y', 'Y', 'Y', 'N', ''),
('preferences', 'Preferences', 0, 'S', '', '', 'N', 'N', 'N', 'N', 'N', 'N', ''),
('preferences_profile', 'Preferences - Profile', 5, 'S', 'users', 'user_id', 'N', 'Y', 'N', 'Y', 'N', 'N', ''),
('preferences_lookandfeel', 'Preferences - Look and feel', 5, 'S', 'users', 'user_id', 'N', 'Y', 'N', 'Y', 'N', 'N', ''),
('reports', 'Reports', 7, 'A', 'reports', 'report_id', 'Y', 'Y', 'Y', 'Y', 'N', 'N', ''),
('webmail', 'Webmail', 8, 'A', 'webmail', 'mail_id', 'Y', 'Y', 'Y', 'Y', 'N', 'N', '');

-- 
-- Table structure for table `db_blocks`
-- 

CREATE TABLE `db_blocks` (
  `app_name` varchar(50) collate utf8_unicode_ci NOT NULL,
  `form_name` varchar(50) collate utf8_unicode_ci NOT NULL,
  `block_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `block_name` varchar(50) collate utf8_unicode_ci NOT NULL,
  `is_title` enum('Y','N') collate utf8_unicode_ci NOT NULL default 'N',
  `columns` int(1) NOT NULL default '1',
  `block_sequence` int(4) NOT NULL default '0',
  PRIMARY KEY  (`app_name`,`form_name`,`block_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `db_blocks`
-- 

INSERT INTO `db_blocks` (`app_name`, `form_name`, `block_id`, `block_name`, `is_title`, `columns`, `block_sequence`) VALUES 
('accounts', 'bulk', '1cqe4nznej24r', 'block1', 'N', 2, 2),
('accounts', 'view', '1rookc04esxvp', 'Footer', 'N', 2, 7),
('accounts', 'bulk', 'dwforks8nav2', 'block2', 'N', 2, 4),
('accounts', 'view', 'ag0x39obsa2l', 'Note', 'Y', 1, 5),
('accounts', 'view', '1qisuz6hyqws0', 'Main', 'N', 2, 2),
('accounts', 'view', 'cwppdheottca', 'Addresses', 'Y', 2, 4),
('accounts', 'popup_view', '1y49a6qqjh7o4', 'Main', 'N', 2, 2),
('accounts', 'edit', '9wbn0xep0c0s', 'Main', 'N', 2, 2),
('accounts', 'edit', '1ynz0ove9dokc', 'Footer', 'N', 2, 7),
('accounts', 'popup_view', 'reznxp8cz24q', 'Addresses', 'N', 2, 4),
('accounts', 'edit', 'qyzf1pseb00o', 'Addresses', 'Y', 2, 4),
('accounts', 'popup_edit', '22qjxa3f395w0', 'Main', 'N', 2, 2),
('accounts', 'popup_edit', '1pms2trg47kuk', 'Addresses', 'Y', 2, 4),
('accounts', 'edit', '1sly35rgm4n40', 'Note', 'Y', 1, 5),
('activities', 'edit', '220op2opw4o0o', 'Main', 'N', 2, 3),
('activities', 'bulk', '1h8zm01ckrnn7', 'Bulk', 'N', 2, 2),
('activities', 'edit', '2brqt147gh7o0', 'Header', 'N', 1, 1),
('activities', 'view', '2856aiot08bog', 'Main', 'N', 2, 3),
('activities', 'view', '12kk18btwtwjv', 'Note', 'N', 1, 4),
('activities', 'edit', 's63eoldeqwhv', 'Footer', 'N', 2, 6),
('activities', 'edit', 'ixigmahlz1jp', 'Note', 'N', 1, 4),
('activities', 'popup_view', 'anf5jymyztqg', 'Footer', 'N', 2, 6),
('activities', 'popup_view', '193tt4td1b6x9', 'Main', 'N', 2, 3),
('activities', 'view', 'dgfcw7b778w9', 'Footer', 'N', 2, 6),
('activities', 'view', '1t8478u5x9vji', 'Header', 'N', 1, 1),
('activities', 'popup_edit', '9l8hdkbpkgo7', 'Main', 'N', 2, 3),
('activities', 'popup_view', 'iow1varzcdcz', 'Note', 'N', 1, 4),
('activities', 'popup_view', 'spswyv4ctl8e', 'Header', 'N', 1, 1),
('activities', 'popup_edit', 'zle3xdmjuowf', 'Footer', 'N', 2, 6),
('activities', 'popup_edit', '2bbqbx9uuexwg', 'Note', 'N', 1, 4),
('activities', 'popup_edit', '18cq8hp0fn1sa', 'Header', 'N', 1, 1),
('activities_calls', 'view', '1ky0t2goprv47', 'Main', 'N', 2, 3),
('activities_calls', 'edit', '1b52hdv5f4ll', 'Main', 'N', 2, 3),
('activities_calls', 'edit', 'kas4i48ij905', 'Header', 'N', 1, 1),
('activities_calls', 'view', '2964j6wfas9ws', 'Note', 'N', 1, 6),
('activities_calls', 'view', '1hf5cml1m13qa', 'related', 'N', 2, 5),
('activities_calls', 'view', '1jvu4wss0zxpd', 'Time stamp', 'N', 2, 8),
('activities_calls', 'edit', 'dgf9xquak7sb', 'Time stamp', 'N', 2, 8),
('activities_calls', 'edit', 'qu1vj7o2qjex', 'related', 'N', 2, 5),
('activities_calls', 'view', '1tpcxnik6o3ea', 'Header', 'N', 1, 1),
('activities_calls', 'popup_view', '2qviuty18hzd', 'related', 'N', 2, 5),
('activities_calls', 'popup_view', '1pfdwk4eoknn6', 'Main', 'N', 2, 3),
('activities_calls', 'popup_view', '1kmxpk9fj016e', 'Header', 'N', 1, 1),
('activities_calls', 'popup_view', '8vd5683dsbnh', 'Note', 'N', 1, 6),
('activities_calls', 'edit', '1sdbigu0qni30', 'Note', 'N', 1, 6),
('activities_events', 'view', '1jdd241eh5ruv', 'Main', 'N', 2, 3),
('activities_events', 'view', '9ys8tsw743nh', 'Header', 'N', 1, 1),
('activities_events', 'view', '1xbcigb1ptbu', 'Location', 'N', 1, 4),
('activities_events', 'edit', '9due5e2zodp0', 'Related', 'N', 2, 6),
('activities_events', 'view', 'zqbgmlzxvccs', 'Time stamp', 'N', 2, 9),
('activities_events', 'view', '29r2gzevoglcg', 'Related', 'N', 2, 6),
('activities_events', 'edit', 'dcqbpuhpw6qb', 'Main', 'N', 2, 3),
('activities_events', 'edit', '1a9phmbehf9gz', 'Location', 'N', 1, 4),
('activities_events', 'view', 'ircps8xsiwor', 'Note', 'N', 1, 7),
('activities_events', 'edit', '1q2sj3utp1a0m', 'Header', 'N', 1, 1),
('activities_events', 'edit', '12kk18ebzgsyb', 'Note', 'N', 1, 7),
('activities_events', 'edit', '28rchlb8ee68c', 'Time stamp', 'N', 2, 9),
('activities_meetings', 'edit', '51el60vmgvnn', 'Header', 'N', 1, 1),
('activities_meetings', 'edit', '1td1hq4h4ihhx', 'Related', 'N', 2, 6),
('activities_meetings', 'view', '1bd4f2oh93gen', 'Main', 'N', 2, 3),
('activities_meetings', 'view', '1h5algnkrp2o8', 'Note', 'N', 1, 7),
('activities_meetings', 'view', '20009xmh0a1w4', 'Header', 'N', 1, 1),
('activities_meetings', 'view', '1pwmq1rxa6uta', 'Location', 'N', 1, 4),
('activities_meetings', 'edit', '1ztujyxozfms4', 'Location', 'N', 1, 4),
('activities_meetings', 'view', '21od56kqwvs0k', 'Related', 'N', 2, 6),
('activities_meetings', 'edit', 'qva7sj4mo7x5', 'Main', 'N', 2, 3),
('activities_meetings', 'edit', '29tj2ocxi9gkc', 'Note', 'N', 1, 7),
('activities_meetings', 'view', '21zg8puqibj4k', 'Time stamp', 'N', 2, 9),
('activities_meetings', 'edit', '142r3faf5obbn', 'Time stamp', 'N', 2, 9),
('activities_tasks', 'view', 'crse2wzfks4b', 'Main', 'N', 2, 3),
('activities_tasks', 'view', '1htxhh5cre0oo', 'Header', 'N', 1, 1),
('activities_tasks', 'edit', '20x9kob18kcg0', 'Time stamp', 'N', 2, 8),
('activities_tasks', 'edit', '1tt1yyss7hawv', 'Note', 'N', 1, 6),
('activities_tasks', 'view', '59d4kidgyfr', 'Time stamp', 'N', 2, 8),
('activities_tasks', 'view', '1l46j6rmgrxlf', 'Note', 'N', 1, 6),
('activities_tasks', 'view', 'skvfkgen6jel', 'Related', 'N', 2, 5),
('activities_tasks', 'edit', 'clmo47fqj28x', 'Main', 'N', 2, 3),
('activities_tasks', 'edit', '9xjth53cmh1a', 'Related', 'N', 2, 5),
('activities_tasks', 'edit', 'iq4afll32djw', 'Header', 'N', 1, 1),
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
('administration_company', 'edit', '1knxf4v2jnr', 'Footer', 'N', 2, 9),
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
('administration_departments', 'edit', '4gh2mpb2cko4', 'Footer', 'N', 2, 9),
('administration_departments', 'edit', '10dq95245bms0', 'Addresses', 'N', 2, 6),
('administration_departments', 'edit', '1i8py73yfbk0w', 'Note', 'N', 1, 7),
('administration_departments', 'popup_view', '1u92s2wst6pwg', 'Header', 'N', 2, 2),
('administration_departments', 'popup_view', 'zwhfn2wvnb44', 'Body', 'N', 2, 4),
('administration_departments', 'popup_view', 'so8lj5n686o', 'Addresses', 'N', 2, 6),
('administration_departments', 'popup_view', '2tcjrwguxaio', 'Note', 'N', 1, 7),
('administration_roles', 'bulk', 'nqmmcfkdvht', 'Bulk', 'N', 1, 2),
('administration_roles', 'view', 'kfploca1f5xx', 'Header', 'N', 2, 2),
('administration_roles', 'view', 'rfnsrrtgd5e', 'Footer', 'N', 2, 5),
('administration_roles', 'view', 'tklik7v2pj24', 'Main', 'N', 1, 3),
('administration_roles', 'edit', '1gkcujjr9bd9g', 'Header', 'N', 2, 2),
('administration_roles', 'edit', 's4v229dkh1xf', 'Footer', 'N', 2, 5),
('administration_roles', 'edit', '167sih2wa79j', 'Main', 'N', 1, 3),
('administration_roles', 'popup_view', 'va6q7b909lnr', 'Header', 'N', 2, 2),
('administration_roles', 'popup_view', '1k0rm7vlcvgsq', 'Footer', 'N', 2, 5),
('administration_roles', 'popup_view', '3d1tnjyi5s5h', 'Main', 'N', 1, 3),
('administration_users', 'bulk', '13qfxwi7vfi8w', 'bulk', 'N', 2, 2),
('administration_users', 'view', 'dxodpktw7tsg', 'Preferences', 'Y', 2, 8),
('administration_users', 'view', '1j2a5w3hftwgg', 'Personal Information', 'Y', 2, 6),
('administration_users', 'view', '294wh86uphj4g', 'Note', 'Y', 1, 9),
('administration_users', 'view', '1lhqls5x4yv48', 'Footer', 'N', 2, 11),
('administration_users', 'view', '235c8hd439voo', 'Main', 'N', 2, 4),
('administration_users', 'view', '9gba8zpqcnwg', 'Header', 'N', 2, 2),
('administration_users', 'edit', 'sif2w2u11r4g', 'Main', 'N', 2, 4),
('administration_users', 'edit', '1ixcu5lf30asg', 'Note', 'Y', 1, 9),
('administration_users', 'edit', '1q6htfo3inesk', 'Personal Information', 'Y', 2, 6),
('administration_users', 'edit', '1r2irncvnack0', 'Footer', 'N', 2, 11),
('administration_users', 'edit', '1s9mtebmfoo0o', 'Header', 'N', 2, 2),
('administration_users', 'popup_view', 'cqkdsoiy8hwg', 'Note', 'N', 1, 4),
('administration_users', 'popup_view', '1kfjzfu4tbb4s', 'Header', 'N', 1, 1),
('administration_users', 'popup_view', '1cz0xswt9tq84', 'Main', 'N', 2, 3),
('administration_users', 'popup_edit', 'dxofjnamwhs0', 'Note', 'N', 1, 4),
('administration_users', 'popup_edit', 'vhl12f6951c4', 'Main', 'N', 2, 3),
('administration_users', 'edit', 'kfpueqebytc0', 'Setup', 'Y', 2, 13),
('administration_users', 'edit', '2brr1b6lkeasw', 'Preferences', 'Y', 2, 8),
('administration_users', 'popup_edit', '1op6wuzxu9fo', 'Header', 'N', 1, 1),
('campaigns', 'bulk', 'k0xgrf3iadmt', 'Main', 'N', 2, 2),
('campaigns', 'edit', '14a59bjpcswkp', 'Header', 'N', 2, 2),
('campaigns', 'edit', '27k8gaej7800c', 'Main', 'N', 1, 3),
('campaigns', 'edit', '1pkbdns9p55a3', 'Footer', 'N', 2, 5),
('campaigns', 'view', '1ajk9ce7aq70g', 'Footer', 'N', 2, 5),
('campaigns', 'view', '27fb2uq07lxco', 'Header', 'N', 2, 2),
('campaigns', 'popup_view', 'a2hagc4vcxdb', 'Header', 'N', 2, 2),
('campaigns', 'popup_view', 'uvelal6cdy2a', 'Main', 'N', 1, 3),
('campaigns', 'view', '27z0l4zptuv4s', 'Main', 'N', 1, 3),
('campaigns', 'popup_edit', '2as0ypa51w74w', 'Header', 'N', 2, 2),
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
('campaigns_lists', 'edit', '1txzfxr6f2v99', 'Footer', 'N', 2, 5),
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
('campaigns_records', 'edit', '1lhqf69y2thhj', 'Footer', 'N', 2, 5),
('campaigns_records', 'edit', 's7bqwudj4dyi', 'Header', 'N', 1, 1),
('campaigns_records', 'edit', 'k1li7xu4xoh', 'Main', 'N', 2, 3),
('campaigns_records', 'popup_view', '2a4ma0f0n5usc', 'Footer', 'N', 2, 6),
('campaigns_records', 'popup_view', '1uhoyhl4orcdz', 'Header', 'N', 2, 2),
('campaigns_records', 'popup_view', '3wrc04h0hsja', 'Main', 'N', 2, 4),
('cases', 'bulk', '1appthrik4ncl', 'block1', 'N', 2, 2),
('cases', 'edit', 'cd09egoz2mtw', 'Note', 'N', 1, 5),
('cases', 'edit', 'jurnfj4d78f8', 'Main', 'N', 2, 2),
('cases', 'popup_edit', '1h6j2a3qovhez', 'Header', 'N', 1, 1),
('cases', 'popup_view', '1rooqvnkdybx6', 'Note', 'N', 1, 3),
('cases', 'edit', '123b4t5508c46', 'Footer', 'N', 2, 7),
('cases', 'view', '12jblwzk5m3jx', 'Footer', 'N', 2, 7),
('cases', 'view', '1lnw1iacxacgm', 'Note', 'N', 1, 5),
('cases', 'view', 'sh6efa3xi81h', 'Main', 'N', 2, 2),
('cases', 'popup_edit', '297czvyle7tw0', 'Main', 'N', 2, 3),
('cases', 'popup_edit', '2at96cmke5xc8', 'Note', 'N', 1, 4),
('cases', 'popup_view', 'mp0c9perffap', 'Main', 'N', 2, 2),
('contacts', 'edit', '19pzzzxgc8du6', 'Main', 'N', 2, 2),
('contacts', 'view', '10eyk1zxqe6oc', 'Footer', 'N', 2, 7),
('contacts', 'bulk', '90aglgoeka6p', 'block1', 'N', 2, 2),
('contacts', 'view', 'l4cogl4adios', 'Main', 'N', 2, 2),
('contacts', 'view', '8xu4m31alhk4', 'Addresses', 'Y', 2, 4),
('contacts', 'edit', '8vd8x58p4sil', 'Footer', 'N', 2, 7),
('contacts', 'popup_view', 'b276h1p3t6lj', 'Main', 'N', 2, 2),
('contacts', 'edit', '1jftrk7u1yala', 'Addresses', 'Y', 2, 4),
('contacts', 'popup_view', '1go1s5js1v52e', 'Addresses', 'N', 2, 4),
('contacts', 'edit', 'bf6pohx6e1o', 'Note', 'Y', 1, 5),
('contacts', 'popup_edit', '1ss3qzbfakxrq', 'Main', 'N', 2, 2),
('contacts', 'popup_edit', '212721nb9fgkc', 'Addresses', 'N', 2, 4),
('contacts', 'view', '7qcfwr9g2s0', 'Note', 'Y', 1, 5),
('documents', 'bulk', '1tuaann8tbxn0', 'New block', 'N', 2, 2),
('documents', 'view', '1jjipo3medytx', 'Main', 'N', 1, 3),
('documents', 'edit', '13318h3afbkf5', 'TimeStamp', 'N', 2, 7),
('documents', 'view', '1q0brwwu9b7xb', 'Note', 'N', 1, 4),
('documents', 'edit', '1hxmmynpszxcn', 'Main', 'N', 1, 4),
('documents', 'edit', '29pu5xukwjy8k', 'Note', 'N', 1, 5),
('documents', 'popup_view', '1zgar2xanqkgw', 'Main', 'N', 1, 3),
('documents', 'popup_view', '8swft6fa6wqm', 'Header', 'N', 2, 2),
('documents', 'view', '58so7kd9tth9', 'Header', 'N', 2, 2),
('documents', 'edit', '1a9piyvr5ol5g', 'Header', 'N', 2, 3),
('documents', 'view', 'sr1630uzfo42', 'TimeStamp', 'N', 2, 6),
('documents', 'popup_edit', '12y40ppr8ee8k', 'Main', 'N', 1, 3),
('documents', 'popup_edit', '9xk3lf1hths8', 'Note', 'N', 1, 4),
('documents', 'popup_edit', '10eyjn7u927ks', 'Header', 'N', 1, 2),
('documents', 'edit', '1ha89c6n8hggc', 'Upload', 'N', 1, 1),
('leads', 'bulk', '27k8an0vhzms8', 'block1', 'N', 2, 2),
('leads', 'view', 'hnxo32h3vci3', 'Header', 'N', 2, 2),
('leads', 'view', '1kgs1jxs9g0fd', 'Address', 'Y', 2, 6),
('leads', 'edit', '1sukfl85ljghz', 'Header', 'N', 2, 2),
('leads', 'popup_view', 'qxr081stazsq', 'Header', 'N', 2, 2),
('leads', 'edit', '1jzj9uhg5sa09', 'Address', 'Y', 2, 6),
('leads', 'edit', '1twr3rmgzbyts', 'Main', 'Y', 2, 4),
('leads', 'popup_view', '1iw495y761u9p', 'Main', 'N', 2, 4),
('leads', 'popup_view', '1ixclk3b0oyl3', 'Address', 'N', 2, 6),
('leads', 'view', '10g6nqy7d53q6', 'Main', 'N', 2, 4),
('leads', 'edit', '21lwk5jjhciss', 'Note', 'Y', 1, 7),
('leads', 'popup_edit', '1lrl6g72lmc1s', 'Main', 'N', 2, 4),
('leads', 'popup_edit', '59gxaxc4tmq', 'Address', 'N', 2, 6),
('leads', 'popup_edit', '2ss50pmw997', 'Header', 'N', 2, 2),
('leads', 'view', 's3mnwc3p0w75', 'Note', 'Y', 1, 7),
('opportunities', 'bulk', '9l8bayclym1p', 'block1', 'N', 2, 2),
('opportunities', 'view', '1457q3mybwt5u', 'Footer', 'N', 2, 7),
('opportunities', 'view', 'hu39z57kbs2b', 'Note', 'Y', 1, 5),
('opportunities', 'view', 'b4nszc8xzv23', 'Main', 'N', 2, 2),
('opportunities', 'view', 'bxb8kbm6dj', 'Recurring', 'N', 2, 4),
('opportunities', 'edit', '1tbt381th3vvu', 'Main', 'N', 2, 2),
('opportunities', 'edit', 'uo0dacgaydwe', 'Recurring', 'N', 2, 4),
('opportunities', 'edit', 'b274725mbzr7', 'Note', 'Y', 1, 5),
('opportunities', 'popup_view', 'hp5welliywza', 'Main', 'N', 2, 2),
('opportunities', 'popup_view', '2h0plgzs8zxx', 'Note', 'N', 1, 3),
('opportunities', 'popup_edit', '1lhqfb3ptbgn3', 'Main', 'N', 2, 2),
('preferences_lookandfeel', 'edit', '12238nyd9hxc0', 'Main', 'N', 2, 2),
('preferences_lookandfeel', 'view', 'd7tbgynjipwg', 'Main', 'N', 2, 2),
('preferences_profile', 'edit', '26y2hrgd023o8', 'Footer', 'N', 2, 7),
('preferences_profile', 'edit', '29pudky0xvtwc', 'Note', 'N', 1, 5),
('preferences_profile', 'edit', '1zf2rc8trag0o', 'Body', 'N', 2, 4),
('preferences_profile', 'view', '9l8phqq6ujwo', 'Footer', 'N', 2, 7),
('preferences_profile', 'view', '9dun4w391wso', 'Note', 'N', 1, 5),
('preferences_profile', 'view', '118iuwd6a528g', 'Body', 'N', 2, 4),
('preferences_profile', 'view', 'tqrgvar474g8', 'Header', 'N', 2, 2),
('preferences_profile', 'edit', '1yro7vjsl4ysw', 'Header', 'N', 2, 2),
('preferences_profile', 'popup_view', 'c5mj0n6xfhko', 'Body', 'N', 2, 4),
('preferences_profile', 'popup_view', 'ss9txl6ke6oc', 'Note', 'N', 1, 5),
('preferences_profile', 'popup_edit', '1pxj7dkwrcg0', 'Header', 'N', 2, 2),
('preferences_profile', 'popup_view', 'r3wyomxv1m8s', 'Header', 'N', 2, 2),
('preferences_profile', 'popup_edit', '2bszdlp7ppes4', 'Body', 'N', 2, 4),
('preferences_profile', 'popup_edit', '1lstr1vwvfogg', 'Note', 'N', 1, 5),
('reports', 'edit', '10xfnyslfaysg', 'New Block', 'N', 2, 2),
('reports', 'view', '1qoyvrhjyiqsw', 'qqqqqqq', 'N', 2, 2),
('reports', 'view', '19hdq64qbthc0', 'ggg', 'Y', 2, 4),
('reports', 'bulk', '1a8hdbjvfozog', 'Bulk', 'N', 2, 2),
('webmail', 'bulk', '10a0vzsn8jmu5', 'New block', 'N', 2, 2),
('webmail', 'popup_view', '18hnj62icuujr', 'Header', 'N', 1, 1),
('webmail', 'popup_view', '1sauum7g5bvpp', 'Header 2', 'N', 2, 3),
('webmail', 'popup_view', 'rdrer50sxy92', 'Main', 'N', 1, 4),
('webmail', 'edit', '3kg2m6nileqs', 'Attachment', 'N', 1, 4),
('webmail', 'edit', '1y5hz28trq00c', 'Header', 'N', 2, 2),
('webmail', 'view', 'lmtu12yntc0w', 'Attachment', 'N', 1, 4),
('webmail', 'view', '4p3fkv0odpc0', 'Header', 'N', 2, 2),
('webmail', 'view', '1zf2plhmw6f4s', 'Message', 'N', 1, 3),
('webmail', 'edit', '299tuqcldny88', 'Message', 'N', 1, 3),
('webmail', 'popup_edit', 'so0e1od7gow', 'Header', 'N', 1, 1),
('webmail', 'popup_edit', 'hqeeu9ndagz8', 'Main', 'N', 1, 4),
('webmail', 'popup_edit', '20ihjrdym0kkw', 'Header2', 'N', 2, 3);
-- --------------------------------------------------------

-- 
-- Table structure for table `db_fields`
-- 

CREATE TABLE `db_fields` (
  `app_name` varchar(50) collate utf8_unicode_ci NOT NULL,
  `table_name` varchar(50) collate utf8_unicode_ci NOT NULL,
  `field_name` varchar(50) collate utf8_unicode_ci NOT NULL,
  `is_custom` enum('Y','N') collate utf8_unicode_ci NOT NULL default 'N',
  `is_computed` enum('Y','N') collate utf8_unicode_ci NOT NULL default 'N',
  `field_type` varchar(5) collate utf8_unicode_ci NOT NULL default 'TE',
  `field_label` varchar(250) collate utf8_unicode_ci NOT NULL,
  `field_height` int(4) NOT NULL default '1',
  `field_default` varchar(50) collate utf8_unicode_ci NOT NULL,
  `related_table` varchar(50) collate utf8_unicode_ci NOT NULL,
  `related_id` varchar(50) collate utf8_unicode_ci NOT NULL,
  `related_name` varchar(50) collate utf8_unicode_ci NOT NULL,
  `related_filter` varchar(250) collate utf8_unicode_ci NOT NULL,
  `is_search` enum('Y','N') collate utf8_unicode_ci NOT NULL default 'N',
  `is_readonly` enum('Y','N') collate utf8_unicode_ci NOT NULL default 'N',
  `is_mandatory` enum('Y','N') collate utf8_unicode_ci NOT NULL default 'N',
  `is_unique` enum('Y','N') collate utf8_unicode_ci NOT NULL default 'N',
  `is_visible` enum('Y','N') collate utf8_unicode_ci NOT NULL default 'Y',
  `search_sequence` int(4) NOT NULL default '0',
  `result_sequence` int(4) NOT NULL default '0',
  `result_class` varchar(50) collate utf8_unicode_ci NOT NULL default 'grid_left',
  `bulk_sequence` int(4) NOT NULL default '0',
  `bulk_side` enum('L','R') collate utf8_unicode_ci NOT NULL default 'L',
  `bulk_block_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `view_sequence` int(4) NOT NULL default '0',
  `view_side` enum('L','R') collate utf8_unicode_ci NOT NULL default 'L',
  `view_block_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `edit_sequence` int(4) NOT NULL default '0',
  `edit_side` enum('L','R') collate utf8_unicode_ci NOT NULL default 'L',
  `edit_block_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `popup_search_sequence` int(4) NOT NULL default '0',
  `popup_result_sequence` int(4) NOT NULL default '0',
  `popup_view_sequence` int(4) NOT NULL default '0',
  `popup_view_side` enum('L','R') collate utf8_unicode_ci NOT NULL default 'L',
  `popup_view_block_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `popup_edit_sequence` int(4) NOT NULL default '0',
  `popup_edit_side` enum('L','R') collate utf8_unicode_ci NOT NULL default 'L',
  `popup_edit_block_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `linked_sequence` int(4) NOT NULL default '0',
  PRIMARY KEY  (`app_name`,`field_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `db_fields`
-- 
INSERT INTO db_fields (app_name, table_name, field_name, is_custom, is_computed, field_type, field_label, field_height, field_default, related_table, related_id, related_name, related_filter, is_search, is_readonly, is_mandatory, is_unique, is_visible, search_sequence, result_sequence, result_class, bulk_sequence, bulk_side, bulk_block_id, view_sequence, view_side, view_block_id, edit_sequence, edit_side, edit_block_id, popup_search_sequence, popup_result_sequence, popup_view_sequence, popup_view_side, popup_view_block_id, popup_edit_sequence, popup_edit_side, popup_edit_block_id, linked_sequence) VALUES 
('accounts', 'accounts', 'account_id', 'N', 'N', 'RK', 'Account Id', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', -1, -1, 'grid_left', -1, 'L', '', -1, 'L', '', -1, 'L', '', -1, -1, -1, 'L', '', 0, 'L', '', -1),
('accounts', 'accounts', 'account_top_id', 'N', 'N', 'RR', 'Main account', 1, '', 'accounts', 'account_id', 'account_name', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', '1qisuz6hyqws0', 1, 'R', '9wbn0xep0c0s', 0, 0, 0, 'R', '1y49a6qqjh7o4', 1, 'R', '22qjxa3f395w0', 0),
('accounts', 'accounts', 'user_id', 'N', 'N', 'DD', 'Owner', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', '', 'N', 'Y', 8, 9, 'grid_left', 1, 'L', '1cqe4nznej24r', -1, 'L', '', -1, 'L', '', 6, 6, -1, 'L', '', 0, 'L', '', 7),
('accounts', 'accounts', 'source_id', 'N', 'N', 'DD', 'Source', 1, '', 'sources', 'source_id', 'source_name', ' order by source_name', 'N', 'N', '', 'N', 'Y', 3, 8, 'grid_left', 1, 'R', 'dwforks8nav2', 4, 'L', '1qisuz6hyqws0', 4, 'L', '9wbn0xep0c0s', 3, 5, 2, 'L', '1y49a6qqjh7o4', 3, 'L', '22qjxa3f395w0', 6),
('accounts', 'accounts', 'industry_id', 'N', 'N', 'DD', 'Industry', 1, '', 'industries', 'industry_id', 'industry_name', ' order by industry_name', 'N', 'N', '', 'N', 'Y', 4, 6, 'grid_left', 2, 'L', 'dwforks8nav2', 2, 'L', '1qisuz6hyqws0', 2, 'L', '9wbn0xep0c0s', 4, 3, 1, 'L', '1y49a6qqjh7o4', 2, 'L', '22qjxa3f395w0', 4),
('accounts', 'accounts', 'type_id', 'N', 'N', 'DD', 'Type', 1, '', 'types', 'type_id', 'type_name', ' order by type_name', 'N', 'N', 'N', 'N', 'Y', 2, 5, 'grid_left', 1, 'L', 'dwforks8nav2', 2, 'R', '1qisuz6hyqws0', 2, 'R', '9wbn0xep0c0s', 2, 2, 0, 'R', '1y49a6qqjh7o4', 2, 'R', '22qjxa3f395w0', 3),
('accounts', 'accounts', 'rating_id', 'N', 'N', 'DD', 'Rating', 1, '', 'ratings', 'rating_id', 'rating_name', ' order by rating_sequence', 'N', 'N', '', 'N', 'Y', 5, 7, 'grid_left', 2, 'R', 'dwforks8nav2', 5, 'L', '1qisuz6hyqws0', 5, 'L', '9wbn0xep0c0s', 5, 4, 3, 'L', '1y49a6qqjh7o4', 4, 'L', '22qjxa3f395w0', 5),
('accounts', 'accounts', 'account_number', 'N', 'N', 'TE', 'Account number', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'R', '1qisuz6hyqws0', 3, 'R', '9wbn0xep0c0s', 0, 0, 0, 'R', '1y49a6qqjh7o4', 3, 'R', '22qjxa3f395w0', 0),
('accounts', 'accounts', 'account_name', 'N', 'N', 'VF', 'Account', 1, '', '', '', '', '', 'Y', 'N', 'Y', 'N', 'Y', 1, 1, 'grid_left', 0, 'L', '', 1, 'L', '1qisuz6hyqws0', 1, 'L', '9wbn0xep0c0s', 1, 1, 0, 'L', '1y49a6qqjh7o4', 1, 'L', '22qjxa3f395w0', 1),
('accounts', 'accounts', 'account_code', 'N', 'N', 'TE', 'Account code', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 6, 'R', '1qisuz6hyqws0', 6, 'R', '9wbn0xep0c0s', 0, 0, 0, 'R', '1y49a6qqjh7o4', 4, 'R', '22qjxa3f395w0', 0),
('accounts', 'accounts', 'legal_status', 'N', 'N', 'TE', 'Legal status', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', '1qisuz6hyqws0', 3, 'L', '9wbn0xep0c0s', 0, 0, 0, 'L', '1y49a6qqjh7o4', 0, 'L', '22qjxa3f395w0', 0),
('accounts', 'accounts', 'ticket_symbol', 'N', 'N', 'TE', 'Ticket symbol', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 11, 'L', '1qisuz6hyqws0', 11, 'L', '9wbn0xep0c0s', 0, 0, 0, 'L', '1y49a6qqjh7o4', 0, 'L', '22qjxa3f395w0', 0),
('accounts', 'accounts', 'tax_id', 'N', 'N', 'TE', 'Tax identifier', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 10, 'L', '1qisuz6hyqws0', 10, 'L', '9wbn0xep0c0s', 0, 0, 0, 'L', '1y49a6qqjh7o4', 0, 'L', '22qjxa3f395w0', 0),
('accounts', 'accounts', 'url', 'N', 'N', 'WS', 'Web site', 5, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 4, 'R', '1qisuz6hyqws0', 4, 'R', '9wbn0xep0c0s', 0, 0, 0, 'R', '1y49a6qqjh7o4', 0, 'R', '22qjxa3f395w0', 0),
('accounts', 'accounts', 'email', 'N', 'N', 'WM', 'Email', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 2, 'grid_left', 0, 'L', '', 8, 'L', '1qisuz6hyqws0', 8, 'L', '9wbn0xep0c0s', 0, 0, 1, 'R', '1y49a6qqjh7o4', 5, 'L', '22qjxa3f395w0', 0),
('accounts', 'accounts', 'phone', 'N', 'N', 'TE', 'Phone', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 4, 'grid_left', 0, 'L', '', 9, 'L', '1qisuz6hyqws0', 9, 'L', '9wbn0xep0c0s', 0, 0, 2, 'R', '1y49a6qqjh7o4', 5, 'R', '22qjxa3f395w0', 2),
('accounts', 'accounts', 'fax', 'N', 'N', 'TE', 'Fax', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 5, 'R', '1qisuz6hyqws0', 5, 'R', '9wbn0xep0c0s', 0, 0, 3, 'R', '1y49a6qqjh7o4', 6, 'R', '22qjxa3f395w0', 0),
('accounts', 'accounts', 'employees', 'N', 'N', 'TE', 'Employees', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 6, 'L', '1qisuz6hyqws0', 6, 'L', '9wbn0xep0c0s', 0, 0, 0, 'L', '1y49a6qqjh7o4', 0, 'L', '22qjxa3f395w0', 0),
('accounts', 'accounts', 'revenue', 'N', 'N', 'TE', 'Revenue', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 7, 'L', '1qisuz6hyqws0', 7, 'L', '9wbn0xep0c0s', 0, 0, 0, 'L', '1y49a6qqjh7o4', 0, 'L', '22qjxa3f395w0', 0),
('accounts', 'accounts', 'created', 'N', 'N', 'TS', 'Created', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_center', -1, 'L', '', 1, 'L', '1rookc04esxvp', 1, 'L', '1ynz0ove9dokc', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('accounts', 'accounts', 'created_by', 'N', 'N', 'DD', 'Created by', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', -1, 'L', '', 0, 'L', '1rookc04esxvp', 0, 'L', '1ynz0ove9dokc', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('accounts', 'accounts', 'updated', 'N', 'N', 'TS', 'Last Update', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_center', -1, 'L', '', 1, 'R', '1rookc04esxvp', 1, 'R', '1ynz0ove9dokc', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('accounts', 'accounts', 'updated_by', 'N', 'N', 'DD', 'Updated by', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', -1, 'L', '', 0, 'R', '1rookc04esxvp', 0, 'R', '1ynz0ove9dokc', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('accounts', 'accounts', 'note', 'N', 'N', 'ML', 'Note', 4, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', 'ag0x39obsa2l', 1, 'L', '1sly35rgm4n40', 0, 0, 0, 'L', '', 0, 'L', 'qlfkkhwl0ah7', 0),
('accounts', 'accounts', 'address_billing', 'N', 'N', 'ML', 'Billing address', 4, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', 'cwppdheottca', 1, 'L', 'qyzf1pseb00o', 0, 0, 1, 'L', 'reznxp8cz24q', 1, 'L', '1pms2trg47kuk', 0),
('accounts', 'accounts', 'zipcode_billing', 'N', 'N', 'TE', 'Billing zipcode', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'L', 'cwppdheottca', 4, 'L', 'qyzf1pseb00o', 0, 0, 3, 'R', 'reznxp8cz24q', 3, 'R', '1pms2trg47kuk', 0),
('accounts', 'accounts', 'city_billing', 'N', 'N', 'TE', 'Billing city', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', 'cwppdheottca', 2, 'L', 'qyzf1pseb00o', 0, 0, 2, 'R', 'reznxp8cz24q', 1, 'R', '1pms2trg47kuk', 0),
('accounts', 'accounts', 'state_billing', 'N', 'N', 'TE', 'Billing state', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 6, 0, 'grid_left', 0, 'L', '', 3, 'L', 'cwppdheottca', 3, 'L', 'qyzf1pseb00o', 0, 0, 1, 'R', 'reznxp8cz24q', 2, 'R', '1pms2trg47kuk', 0),
('accounts', 'accounts', 'country_billing', 'N', 'N', 'TE', 'Billing country', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 7, 10, 'grid_left', 0, 'L', '', 5, 'L', 'cwppdheottca', 5, 'L', 'qyzf1pseb00o', 0, 0, 4, 'R', 'reznxp8cz24q', 4, 'R', '1pms2trg47kuk', 8),
('accounts', 'accounts', 'address_shipping', 'N', 'N', 'ML', 'Shipping address', 4, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', 'cwppdheottca', 1, 'R', 'qyzf1pseb00o', 0, 0, 0, 'R', 'reznxp8cz24q', 0, 'R', '1pms2trg47kuk', 0),
('accounts', 'accounts', 'zipcode_shipping', 'N', 'N', 'TE', 'Shipping zipcode', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'R', 'cwppdheottca', 4, 'R', 'qyzf1pseb00o', 0, 0, 0, 'R', 'reznxp8cz24q', 0, 'R', '1pms2trg47kuk', 0),
('accounts', 'accounts', 'city_shipping', 'N', 'N', 'TE', 'Shipping city', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', 'cwppdheottca', 2, 'R', 'qyzf1pseb00o', 0, 0, 0, 'R', 'reznxp8cz24q', 0, 'R', '1pms2trg47kuk', 0),
('accounts', 'accounts', 'state_shipping', 'N', 'N', 'TE', 'Shipping state', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'R', 'cwppdheottca', 3, 'R', 'qyzf1pseb00o', 0, 0, 0, 'R', 'reznxp8cz24q', 0, 'R', '1pms2trg47kuk', 0),
('accounts', 'accounts', 'country_shipping', 'N', 'N', 'TE', 'Shipping country', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 5, 'R', 'cwppdheottca', 5, 'R', 'qyzf1pseb00o', 0, 0, 0, 'R', 'reznxp8cz24q', 0, 'R', '1pms2trg47kuk', 0),
('activities', 'activities', 'is_open', 'N', 'N', 'CH', 'Open', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 7, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 5, 0, 0, 'L', '', 0, 'L', '', 1),
('activities', 'activities', 'activity_id', 'N', 'N', 'RK', 'Activity Id', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', -1, -1, 'grid_left', -1, 'L', '', -1, 'L', '', -1, 'L', '', -1, -1, -1, 'L', '', 0, 'L', '', 0),
('activities', 'activities', 'user_id', 'N', 'N', 'DD', 'Owner', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 9, 7, 'grid_left', 1, 'R', '1h8zm01ckrnn7', 0, 'L', '', 0, 'L', '', 6, 7, 0, 'L', '', 0, 'L', '', 0),
('activities', 'activities', 'is_private', 'N', 'N', 'CH', 'Private', 1, 'N', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 8, 0, 'grid_center', 4, 'R', '1h8zm01ckrnn7', 4, 'R', '2856aiot08bog', 4, 'R', '220op2opw4o0o', 0, 0, 4, 'R', '193tt4td1b6x9', 4, 'R', '9l8hdkbpkgo7', 0),
('activities', 'activities', 'status_id', 'N', 'N', 'DD', 'Status', 1, '', 'activities_statuses', 'status_id', 'status_name', ' order by status_name', 'N', 'N', 'N', 'N', 'Y', 6, 6, 'grid_left', 1, 'L', '1h8zm01ckrnn7', 2, 'R', '2856aiot08bog', 2, 'R', '220op2opw4o0o', 0, 6, 2, 'R', '193tt4td1b6x9', 2, 'R', '9l8hdkbpkgo7', 8),
('activities', 'activities', 'type_id', 'N', 'N', 'DD', 'Type', 1, '', 'activities_types', 'type_id', 'type_name', ' order by type_name', 'N', 'N', 'Y', 'N', 'Y', 1, 2, 'grid_left', 2, 'R', '1h8zm01ckrnn7', 1, 'L', '2856aiot08bog', 1, 'L', '220op2opw4o0o', 1, 2, 1, 'L', '193tt4td1b6x9', 1, 'L', '9l8hdkbpkgo7', 3),
('activities', 'activities', 'subject', 'N', 'N', 'VF', 'Subject', 1, '', '', '', '', '', 'Y', 'N', 'Y', 'N', 'Y', 2, 3, 'grid_left', 0, 'L', '', 1, 'L', '1t8478u5x9vji', 1, 'L', '2brqt147gh7o0', 2, 3, 1, 'L', 'spswyv4ctl8e', 1, 'L', '18cq8hp0fn1sa', 4),
('activities', 'activities', 'location', 'N', 'N', 'TE', 'Location', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 5, 'grid_left', 4, 'L', '1h8zm01ckrnn7', 3, 'R', '2856aiot08bog', 3, 'R', '220op2opw4o0o', 0, 5, 3, 'R', '193tt4td1b6x9', 3, 'R', '9l8hdkbpkgo7', 7),
('activities', 'activities', 'note', 'N', 'N', 'ML', 'Note', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '12kk18btwtwjv', 1, 'L', 'ixigmahlz1jp', 0, 0, 1, 'L', 'iow1varzcdcz', 1, 'L', '2bbqbx9uuexwg', 0),
('activities', 'activities', 'priority_id', 'N', 'N', 'DD', 'Priority', 1, '', 'activities_priorities', 'priority_id', 'priority_name', ' order by priority_sequence', 'N', 'N', 'N', 'N', 'Y', 5, 1, 'grid_left', 3, 'R', '1h8zm01ckrnn7', 1, 'R', '2856aiot08bog', 1, 'R', '220op2opw4o0o', 4, 1, 1, 'R', '193tt4td1b6x9', 1, 'R', '9l8hdkbpkgo7', 2),
('activities', 'activities', 'activity_start', 'N', 'N', 'DT', 'Activity Start', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 3, 4, 'grid_center', 2, 'L', '1h8zm01ckrnn7', 2, 'L', '2856aiot08bog', 2, 'L', '220op2opw4o0o', 3, 4, 2, 'L', '193tt4td1b6x9', 2, 'L', '9l8hdkbpkgo7', 5),
('activities', 'activities', 'activity_end', 'N', 'N', 'DT', 'Activity End', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 4, 0, 'grid_center', 3, 'L', '1h8zm01ckrnn7', 3, 'L', '2856aiot08bog', 3, 'L', '220op2opw4o0o', 0, 0, 3, 'L', '193tt4td1b6x9', 3, 'L', '9l8hdkbpkgo7', 6),
('activities', 'activities', 'is_allday', 'N', 'N', 'CH', 'All day', 1, 'N', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 4, 'L', '2856aiot08bog', 4, 'L', '220op2opw4o0o', 0, 0, 4, 'L', '193tt4td1b6x9', 4, 'L', '9l8hdkbpkgo7', 0),
('activities', 'activities', 'created', 'N', 'N', 'TS', 'Created', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'L', 'dgfcw7b778w9', 1, 'L', 's63eoldeqwhv', 0, 0, 1, 'L', 'anf5jymyztqg', 1, 'L', 'zle3xdmjuowf', 0),
('activities', 'activities', 'created_by', 'N', 'N', 'DD', 'Created By', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities', 'activities', 'updated', 'N', 'N', 'TS', 'Updated', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'R', 'dgfcw7b778w9', 1, 'R', 's63eoldeqwhv', 0, 0, 1, 'R', 'anf5jymyztqg', 1, 'R', 'zle3xdmjuowf', 0),
('activities', 'activities', 'updated_by', 'N', 'N', 'DD', 'Updated By', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'company_id', 'N', 'N', 'RK', 'Company', 1, '1', '', '', '', '', 'N', 'Y', 'N', 'Y', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'company_alias', 'N', 'N', 'TE', 'Company Alias', 1, '', '', '', '', '', 'N', 'Y', 'N', 'Y', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', '27lh198apmtc4', 1, 'R', '231n90dmhlz48', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'main_user_id', 'N', 'N', 'RR', 'Main User', 1, '', 'users', 'user_id', 'full_name', 'order by full_name', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', '27lh198apmtc4', 2, 'L', '231n90dmhlz48', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'billing_user_id', 'N', 'N', 'RR', 'Billing User', 1, '', 'users', 'user_id', 'full_name', 'order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', '27lh198apmtc4', 2, 'R', '231n90dmhlz48', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'company_name', 'N', 'N', 'TE', 'Company Name', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '27lh198apmtc4', 1, 'L', '231n90dmhlz48', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'company_status', 'N', 'N', 'TE', 'Company Status', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'appshore_version', 'N', 'N', 'DA', 'Appshore Version', 1, '2005-11-20', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'license_time_stamp', 'N', 'N', 'DA', 'License Time Stamp', 1, '0000-00-00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'edition_id', 'N', 'N', 'DD', 'Edition', 1, 'TRIAL', 'global_editions', 'edition_id', 'edition_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'users_quota', 'N', 'N', 'TE', 'Users Quota', 1, '1', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'disk_quota', 'N', 'N', 'TE', 'Disk Quota', 1, '0', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'legal_status', 'N', 'N', 'TE', 'Legal Status', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', '27lh198apmtc4', 3, 'L', '231n90dmhlz48', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'incorporation', 'N', 'N', 'DA', 'Incorporation', 1, '0000-00-00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 3, 'R', '27lh198apmtc4', 3, 'R', '231n90dmhlz48', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'industry_id', 'N', 'N', 'DD', 'Industry', 1, '', 'industries', 'industry_id', 'industry_name', ' order by industry_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'L', '14a5hw8dfaqs0', 4, 'L', '13z2ecyz3rnk4', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'tax_id', 'N', 'N', 'TE', 'Tax identifier', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'R', '27lh198apmtc4', 4, 'R', '231n90dmhlz48', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'fiscal_year', 'N', 'N', 'DD', 'Start of fiscal year', 1, '0', 'global_months', 'month_id', 'month_name', 'order by month_id', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'L', '27lh198apmtc4', 4, 'L', '231n90dmhlz48', 0, 0, 0, 'L', '', 0, 'L', '', 0);
('administration_company', 'company', 'phone', 'N', 'N', 'TE', 'Phone', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', '14a5hw8dfaqs0', 2, 'L', '13z2ecyz3rnk4', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'fax', 'N', 'N', 'TE', 'Fax', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', '14a5hw8dfaqs0', 3, 'L', '13z2ecyz3rnk4', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'url', 'N', 'N', 'WS', 'Url', 5, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'R', '14a5hw8dfaqs0', 1, 'R', '13z2ecyz3rnk4', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'email', 'N', 'N', 'WM', 'Email', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '14a5hw8dfaqs0', 1, 'L', '13z2ecyz3rnk4', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'employees', 'N', 'N', 'TE', 'Employees', 1, '0', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 5, 'L', '14a5hw8dfaqs0', 5, 'L', '13z2ecyz3rnk4', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'address_billing', 'N', 'N', 'ML', 'Address Billing', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '20zqlfunr7gkc', 1, 'L', '235ca6sy1j1co', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'zipcode_billing', 'N', 'N', 'TE', 'Zipcode Billing', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', '20zqlfunr7gkc', 3, 'L', '235ca6sy1j1co', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'city_billing', 'N', 'N', 'TE', 'City Billing', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', '20zqlfunr7gkc', 2, 'L', '235ca6sy1j1co', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'state_billing', 'N', 'N', 'TE', 'State Billing', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'L', '20zqlfunr7gkc', 4, 'L', '235ca6sy1j1co', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'country_billing', 'N', 'N', 'TE', 'Country Billing', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 5, 'L', '20zqlfunr7gkc', 5, 'L', '235ca6sy1j1co', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'address_shipping', 'N', 'N', 'ML', 'Address Shipping', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', '20zqlfunr7gkc', 1, 'R', '235ca6sy1j1co', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'zipcode_shipping', 'N', 'N', 'TE', 'Zipcode Shipping', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'R', '20zqlfunr7gkc', 3, 'R', '235ca6sy1j1co', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'city_shipping', 'N', 'N', 'TE', 'City Shipping', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', '20zqlfunr7gkc', 2, 'R', '235ca6sy1j1co', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'state_shipping', 'N', 'N', 'TE', 'State Shipping', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'R', '20zqlfunr7gkc', 4, 'R', '235ca6sy1j1co', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'country_shipping', 'N', 'N', 'TE', 'Country Shipping', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 5, 'R', '20zqlfunr7gkc', 5, 'R', '235ca6sy1j1co', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'administration_rbac_update', 'N', 'N', 'TS', 'Administration Rbac Update', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'domain_name', 'N', 'N', 'TE', 'Domain Name', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'created', 'N', 'N', 'TS', 'Created', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'L', '10chwpx27p2oo', 1, 'L', '1knxf4v2jnr', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'created_by', 'N', 'N', 'DD', 'Created By', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'updated', 'N', 'N', 'TS', 'Updated', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'R', '10chwpx27p2oo', 1, 'R', '1knxf4v2jnr', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'updated_by', 'N', 'N', 'DD', 'Updated By', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_company', 'company', 'note', 'N', 'N', 'ML', 'Note', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '2aas8afqfolcw', 1, 'L', 'ucxnz3wxz9cw', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_departments', 'departments', 'department_id', 'N', 'N', 'RK', 'Department', 1, '', '', '', '', '', 'N', 'Y', 'N', 'Y', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_departments', 'departments', 'user_id', 'N', 'N', 'DD', 'User', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_departments', 'departments', 'department_name', 'N', 'N', 'VF', 'Department Name', 1, '', '', '', '', '', 'Y', 'N', 'Y', 'Y', 'Y', 1, 1, 'grid_left', 0, 'L', '', 1, 'L', '13gl8htnmtfk8', 1, 'L', '1td1tv7q19j48', 1, 1, 1, 'L', '1u92s2wst6pwg', 0, 'L', '', 1),
('administration_departments', 'departments', 'department_top_id', 'N', 'N', 'RR', 'Main Department', 1, '0', 'departments', 'department_id', 'department_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 2, 'grid_left', 1, 'L', 'jeriamvy7k84', 1, 'R', '13gl8htnmtfk8', 1, 'R', '1td1tv7q19j48', 0, 2, 1, 'R', '1u92s2wst6pwg', 0, 'L', '', 0),
('administration_departments', 'departments', 'manager_id', 'N', 'N', 'RR', 'Manager', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 3, 3, 'grid_left', 1, 'R', 'jeriamvy7k84', 1, 'R', '20w1kaf6130g8', 1, 'R', '10otcoc2t2uoo', 2, 3, 1, 'R', 'zwhfn2wvnb44', 0, 'L', '', 2),
('administration_departments', 'departments', 'assistant_id', 'N', 'N', 'RR', 'Assistant', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 4, 4, 'grid_left', 2, 'R', 'jeriamvy7k84', 2, 'R', '20w1kaf6130g8', 2, 'R', '10otcoc2t2uoo', 0, 4, 2, 'R', 'zwhfn2wvnb44', 0, 'L', '', 3),
('administration_departments', 'departments', 'employees', 'N', 'N', 'TE', 'Employees', 1, '0', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 7, 'grid_left', 0, 'L', '', 3, 'R', '20w1kaf6130g8', 3, 'R', '10otcoc2t2uoo', 0, 0, 3, 'R', 'zwhfn2wvnb44', 0, 'L', '', 6),
('administration_departments', 'departments', 'phone', 'N', 'N', 'TE', 'Phone', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 5, 'grid_left', 0, 'L', '', 2, 'L', '20w1kaf6130g8', 2, 'L', '10otcoc2t2uoo', 0, 5, 2, 'L', 'zwhfn2wvnb44', 0, 'L', '', 4),
('administration_departments', 'departments', 'fax', 'N', 'N', 'TE', 'Fax', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', '20w1kaf6130g8', 3, 'L', '10otcoc2t2uoo', 0, 0, 3, 'L', 'zwhfn2wvnb44', 0, 'L', '', 0),
('administration_departments', 'departments', 'email', 'N', 'N', 'EM', 'Email', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 6, 'grid_left', 0, 'L', '', 1, 'L', '20w1kaf6130g8', 1, 'L', '10otcoc2t2uoo', 0, 6, 1, 'L', 'zwhfn2wvnb44', 0, 'L', '', 5),
('administration_departments', 'departments', 'address_billing', 'N', 'N', 'ML', 'Address Billing', 4, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '9dun74mq658g', 1, 'L', '10dq95245bms0', 0, 0, 1, 'L', 'so8lj5n686o', 0, 'L', '', 0),
('administration_departments', 'departments', 'zipcode_billing', 'N', 'N', 'TE', 'Zipcode Billing', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'L', '9dun74mq658g', 4, 'L', '10dq95245bms0', 0, 0, 4, 'L', 'so8lj5n686o', 0, 'L', '', 0),
('administration_departments', 'departments', 'city_billing', 'N', 'N', 'TE', 'City Billing', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', '9dun74mq658g', 2, 'L', '10dq95245bms0', 0, 0, 2, 'L', 'so8lj5n686o', 0, 'L', '', 0),
('administration_departments', 'departments', 'state_billing', 'N', 'N', 'TE', 'State Billing', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', '9dun74mq658g', 3, 'L', '10dq95245bms0', 0, 0, 3, 'L', 'so8lj5n686o', 0, 'L', '', 0),
('administration_departments', 'departments', 'country_billing', 'N', 'N', 'TE', 'Country Billing', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 2, 0, 'grid_left', 2, 'L', 'jeriamvy7k84', 5, 'L', '9dun74mq658g', 5, 'L', '10dq95245bms0', 0, 0, 5, 'L', 'so8lj5n686o', 0, 'L', '', 0),
('administration_departments', 'departments', 'address_shipping', 'N', 'N', 'ML', 'Address Shipping', 4, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', '9dun74mq658g', 1, 'R', '10dq95245bms0', 0, 0, 1, 'R', 'so8lj5n686o', 0, 'L', '', 0),
('administration_departments', 'departments', 'zipcode_shipping', 'N', 'N', 'TE', 'Zipcode Shipping', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'R', '9dun74mq658g', 4, 'R', '10dq95245bms0', 0, 0, 4, 'R', 'so8lj5n686o', 0, 'L', '', 0),
('administration_departments', 'departments', 'city_shipping', 'N', 'N', 'TE', 'City Shipping', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', '9dun74mq658g', 2, 'R', '10dq95245bms0', 0, 0, 2, 'R', 'so8lj5n686o', 0, 'L', '', 0),
('administration_departments', 'departments', 'state_shipping', 'N', 'N', 'TE', 'State Shipping', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'R', '9dun74mq658g', 3, 'R', '10dq95245bms0', 0, 0, 3, 'R', 'so8lj5n686o', 0, 'L', '', 0),
('administration_departments', 'departments', 'country_shipping', 'N', 'N', 'TE', 'Country Shipping', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 5, 'R', '9dun74mq658g', 5, 'R', '10dq95245bms0', 0, 0, 5, 'R', 'so8lj5n686o', 0, 'L', '', 0),
('administration_departments', 'departments', 'created', 'N', 'N', 'TS', 'Created', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'L', '20zqlguhbcpw0', 1, 'L', '4gh2mpb2cko4', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_departments', 'departments', 'created_by', 'N', 'N', 'DD', 'Created By', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_departments', 'departments', 'updated', 'N', 'N', 'TS', 'Updated', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'R', '20zqlguhbcpw0', 1, 'R', '4gh2mpb2cko4', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_departments', 'departments', 'updated_by', 'N', 'N', 'DD', 'Updated By', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
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
('administration_orders', 'shop_orders', 'created', 'N', 'N', 'DA', 'Created', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 3, 8, 'grid_center', 0, 'L', '', 1, 'R', '23bi5rvcomjo0', 0, 'L', '', 3, 8, 1, 'R', 'dbidytkyivc4', 0, 'L', '', 8),
('administration_orders', 'shop_orders', 'created_by', 'N', 'N', 'RR', 'Created by', 1, '0', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_orders', 'shop_orders', 'updated', 'N', 'N', 'DT', 'Updated', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_orders', 'shop_orders', 'updated_by', 'N', 'N', 'RR', 'Updated by', 1, '0', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_roles', 'roles', 'role_id', 'N', 'N', 'RK', 'Role Id', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', -1, -1, 'grid_left', -1, 'L', '', -1, 'L', '', -1, 'L', '', -1, -1, -1, 'L', '', 0, 'L', '', -1),
('administration_roles', 'roles', 'role_name', 'N', 'N', 'VF', 'Role Name', 1, '', '', '', '', '', 'N', 'N', 'Y', 'Y', 'Y', 1, 1, 'grid_left', 0, 'L', '', 1, 'L', 'kfploca1f5xx', 1, 'L', '1gkcujjr9bd9g', 1, 1, 1, 'L', 'va6q7b909lnr', 0, 'L', '', 1),
('administration_roles', 'roles', 'role_label', 'N', 'N', 'ML', 'Role Label', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 2, 2, 'grid_left', 0, 'L', '', 1, 'L', 'tklik7v2pj24', 1, 'L', '167sih2wa79j', 2, 0, 1, 'L', '3d1tnjyi5s5h', 0, 'L', '', 2),
('administration_roles', 'roles', 'status_id', 'N', 'N', 'DD', 'Status', 1, 'D', 'roles_statuses', 'status_id', 'status_name', '', 'N', 'N', 'Y', 'N', 'Y', 3, 3, 'grid_left', 1, 'L', 'nqmmcfkdvht', 1, 'R', 'kfploca1f5xx', 1, 'R', '1gkcujjr9bd9g', 3, 2, 1, 'R', 'va6q7b909lnr', 0, 'L', '', 3),
('administration_roles', 'roles', 'created', 'N', 'N', 'TS', 'Created', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 4, 'grid_center', 0, 'L', '', 1, 'L', 'rfnsrrtgd5e', 1, 'L', 's4v229dkh1xf', 0, 3, 1, 'L', '1k0rm7vlcvgsq', 0, 'L', '', 4),
('administration_roles', 'roles', 'created_by', 'N', 'N', 'DD', 'Created By', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_roles', 'roles', 'updated', 'N', 'N', 'TS', 'Updated', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 5, 'grid_center', 0, 'L', '', 1, 'R', 'rfnsrrtgd5e', 1, 'R', 's4v229dkh1xf', 0, 4, 1, 'R', '1k0rm7vlcvgsq', 0, 'L', '', 5),
('administration_roles', 'roles', 'updated_by', 'N', 'N', 'DD', 'Updated By', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_users', 'users', 'password', 'N', 'N', 'TE', 'Password', 1, '', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_users', 'users', 'salutation', 'N', 'N', 'TE', 'Salutation', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', '235c8hd439voo', 2, 'L', 'sif2w2u11r4g', 0, 0, 2, 'L', '1cz0xswt9tq84', 2, 'L', 'vhl12f6951c4', 0),
('administration_users', 'users', 'user_id', 'N', 'N', 'RK', 'User', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_users', 'users', 'user_name', 'N', 'N', 'VF', 'User Name', 1, '', '', '', '', '', 'N', 'N', 'Y', 'Y', 'Y', 1, 1, 'grid_left', 0, 'L', '', 1, 'L', '9gba8zpqcnwg', 1, 'L', '1s9mtebmfoo0o', 1, 1, 1, 'L', '1kfjzfu4tbb4s', 1, 'L', '1op6wuzxu9fo', 1),
('administration_users', 'users', 'last_name', 'N', 'N', 'VF', 'Last Name', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 3, 3, 'grid_left', 0, 'L', '', 1, 'R', '235c8hd439voo', 1, 'R', 'sif2w2u11r4g', 3, 3, 1, 'R', '1cz0xswt9tq84', 1, 'R', 'vhl12f6951c4', 3),
('administration_users', 'users', 'first_names', 'N', 'N', 'VF', 'First Name', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 2, 2, 'grid_left', 0, 'L', '', 1, 'L', '235c8hd439voo', 1, 'L', 'sif2w2u11r4g', 2, 2, 1, 'L', '1cz0xswt9tq84', 1, 'L', 'vhl12f6951c4', 2),
('administration_users', 'users', 'title', 'N', 'N', 'TE', 'Title', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', '235c8hd439voo', 2, 'R', 'sif2w2u11r4g', 0, 0, 2, 'R', '1cz0xswt9tq84', 2, 'R', 'vhl12f6951c4', 0),
('administration_users', 'users', 'manager_id', 'N', 'N', 'RR', 'Manager', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 2, 'R', '13qfxwi7vfi8w', 5, 'R', '235c8hd439voo', 5, 'R', 'sif2w2u11r4g', 5, 0, 5, 'R', '1cz0xswt9tq84', 5, 'R', 'vhl12f6951c4', 0),
('administration_users', 'users', 'assistant_id', 'N', 'N', 'RR', 'Assistant', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 1, 'R', '13qfxwi7vfi8w', 6, 'R', '235c8hd439voo', 6, 'R', 'sif2w2u11r4g', 6, 0, 6, 'R', '1cz0xswt9tq84', 6, 'R', 'vhl12f6951c4', 0),
('administration_users', 'users', 'department_id', 'N', 'N', 'RR', 'Department', 1, '', 'departments', 'department_id', 'department_name', '', 'N', 'N', 'N', 'N', 'Y', 4, 4, 'grid_left', 3, 'R', '13qfxwi7vfi8w', 4, 'R', '235c8hd439voo', 4, 'R', 'sif2w2u11r4g', 4, 4, 4, 'R', '1cz0xswt9tq84', 4, 'R', 'vhl12f6951c4', 4),
('administration_users', 'users', 'language_id', 'N', 'N', 'DD', 'Language', 1, 'en', 'global_languages', 'language_id', 'language_name', ' order by language_name', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', 'dxodpktw7tsg', 1, 'R', '2brr1b6lkeasw', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('administration_users', 'users', 'currency_id', 'N', 'N', 'DD', 'Currency', 1, 'USD', 'global_currencies', 'currency_id', 'currency_name', ' order by currency_name', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', 'dxodpktw7tsg', 2, 'R', '2brr1b6lkeasw', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('administration_users', 'users', 'theme_id', 'N', 'N', 'DD', 'Theme', 1, 'default', 'global_themes', 'theme_id', 'theme_name', ' order by theme_name', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'L', 'dxodpktw7tsg', 4, 'L', '2brr1b6lkeasw', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('administration_users', 'users', 'app_name', 'N', 'N', 'DD', 'Default Application', 1, 'api', 'db_applications', 'app_name', 'app_label', 'where is_visible = "Y" and status_id = "A" order by app_label', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'R', 'dxodpktw7tsg', 3, 'R', '2brr1b6lkeasw', 0, 0, 0, 'L', '13z2ehlofjuow', 0, 'L', 'da9w2y9gqxkc', 0),
('administration_users', 'users', 'nbrecords', 'N', 'N', 'TE', 'Number Of Record Lines', 1, '10', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'R', 'dxodpktw7tsg', 0, 'R', '2brr1b6lkeasw', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_users', 'users', 'confirm_delete', 'N', 'N', 'CH', 'Confirm Delete', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '13qfxwi7vfi8w', 3, 'L', 'dxodpktw7tsg', 3, 'L', '2brr1b6lkeasw', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('administration_users', 'users', 'email', 'N', 'N', 'WM', 'Email', 1, '', '', '', '', '', 'N', 'N', 'Y', 'Y', 'Y', 0, 7, 'grid_left', 0, 'L', '', 5, 'L', '235c8hd439voo', 5, 'L', 'sif2w2u11r4g', 0, 7, 5, 'L', '1cz0xswt9tq84', 5, 'L', 'vhl12f6951c4', 7),
('administration_users', 'users', 'phone', 'N', 'N', 'TE', 'Phone', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 5, 'grid_left', 0, 'L', '', 4, 'L', '235c8hd439voo', 4, 'L', 'sif2w2u11r4g', 0, 5, 4, 'L', '1cz0xswt9tq84', 4, 'L', 'vhl12f6951c4', 5),
('administration_users', 'users', 'mobile', 'N', 'N', 'TE', 'Mobile', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 6, 'grid_left', 0, 'L', '', 3, 'L', '235c8hd439voo', 3, 'L', 'sif2w2u11r4g', 0, 6, 3, 'L', '1cz0xswt9tq84', 3, 'L', 'vhl12f6951c4', 6),
('administration_users', 'users', 'fax', 'N', 'N', 'TE', 'Fax', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 6, 'L', '235c8hd439voo', 6, 'L', 'sif2w2u11r4g', 0, 0, 6, 'L', '1cz0xswt9tq84', 6, 'L', 'vhl12f6951c4', 0),
('administration_users', 'users', 'private_phone', 'N', 'N', 'TE', 'Private Phone', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', '1j2a5w3hftwgg', 2, 'L', '1q6htfo3inesk', 0, 0, 0, 'L', '1pz3r2tgoyo0s', 0, 'L', 'sr1hn2m5y684', 0),
('administration_users', 'users', 'private_mobile', 'N', 'N', 'TE', 'Private Mobile', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', '1j2a5w3hftwgg', 2, 'R', '1q6htfo3inesk', 0, 0, 0, 'R', '1pz3r2tgoyo0s', 0, 'R', 'sr1hn2m5y684', 0),
('administration_users', 'users', 'private_email', 'N', 'N', 'WM', 'Private Email', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', '1j2a5w3hftwgg', 1, 'R', '1q6htfo3inesk', 0, 0, 0, 'R', '1pz3r2tgoyo0s', 0, 'R', 'sr1hn2m5y684', 0),
('administration_users', 'users', 'birthdate', 'N', 'N', 'DA', 'Date of Birth', 1, '0000-00-00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '1j2a5w3hftwgg', 1, 'L', '1q6htfo3inesk', 0, 0, 0, 'L', '1pz3r2tgoyo0s', 0, 'L', 'sr1hn2m5y684', 0),
('administration_users', 'users', 'status_id', 'N', 'N', 'DD', 'User Status', 1, 'A', 'users_statuses', 'status_id', 'status_name', 'where status_id in ("A","D") order by status_name', 'N', 'N', 'Y', 'N', 'Y', 5, 8, 'grid_left', 1, 'L', '13qfxwi7vfi8w', 1, 'R', '9gba8zpqcnwg', 1, 'R', '1s9mtebmfoo0o', 0, 0, 0, 'R', '1bwu9iw9qois8', 0, 'R', '1lp4pvgw4f8k0', 8),
('administration_users', 'users', 'is_salespeople', 'N', 'N', 'CH', 'Sales People', 1, 'N', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '13qfxwi7vfi8w', 3, 'R', '235c8hd439voo', 3, 'R', 'sif2w2u11r4g', 0, 0, 3, 'R', '1cz0xswt9tq84', 3, 'R', 'vhl12f6951c4', 0),
('administration_users', 'users', 'last_login', 'N', 'N', 'TS', 'Last Login', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 2, 'L', '1lhqls5x4yv48', 2, 'L', 'kfpueqebytc0', 0, 0, 0, 'L', '1lmo16svlpdwo', 0, 'L', '', 0),
('administration_users', 'users', 'last_password_change', 'N', 'N', 'TS', 'Last Password Change', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 2, 'R', '1lhqls5x4yv48', 2, 'R', 'kfpueqebytc0', 0, 0, 0, 'R', '1lmo16svlpdwo', 0, 'L', '', 0),
('administration_users', 'users', 'created', 'N', 'N', 'TS', 'Created', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'L', '1lhqls5x4yv48', 1, 'L', '1r2irncvnack0', 0, 0, 0, 'L', '1lmo16svlpdwo', 0, 'L', '', 0),
('administration_users', 'users', 'created_by', 'N', 'N', 'RR', 'Created By', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_users', 'users', 'updated', 'N', 'N', 'TS', 'Updated', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'R', '1lhqls5x4yv48', 1, 'R', '1r2irncvnack0', 0, 0, 0, 'R', '1lmo16svlpdwo', 0, 'L', '', 0),
('administration_users', 'users', 'updated_by', 'N', 'N', 'RR', 'Updated By', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_users', 'users', 'note', 'N', 'N', 'ML', 'Note', 5, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '294wh86uphj4g', 1, 'L', '1ixcu5lf30asg', 0, 0, 1, 'L', 'cqkdsoiy8hwg', 1, 'L', 'dxofjnamwhs0', 0);

INSERT INTO db_fields (app_name, table_name, field_name, is_custom, is_computed, field_type, field_label, field_height, field_default, related_table, related_id, related_name, related_filter, is_search, is_readonly, is_mandatory, is_unique, is_visible, search_sequence, result_sequence, result_class, bulk_sequence, bulk_side, bulk_block_id, view_sequence, view_side, view_block_id, edit_sequence, edit_side, edit_block_id, popup_search_sequence, popup_result_sequence, popup_view_sequence, popup_view_side, popup_view_block_id, popup_edit_sequence, popup_edit_side, popup_edit_block_id, linked_sequence) VALUES 
('campaigns', 'campaigns', 'campaign_id', 'N', 'N', 'RK', 'Campaign', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', -1, -1, 'grid_left', -1, 'L', '', -1, 'L', '', -1, 'L', '', -1, -1, -1, 'L', '', 0, 'L', '', -1),
('campaigns', 'campaigns', 'user_id', 'N', 'N', 'DD', 'Owner', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 6, 6, 'grid_left', 2, 'R', 'k0xgrf3iadmt', 0, 'L', '', 0, 'L', '', 5, 0, 0, 'L', '', 0, 'L', '', 6),
('campaigns', 'campaigns', 'campaign_name', 'N', 'N', 'VF', 'Campaign Name', 1, '', '', '', '', '', 'Y', 'N', 'Y', 'N', 'Y', 1, 1, 'grid_left', 0, 'L', '', 1, 'L', '27fb2uq07lxco', 1, 'L', '14a59bjpcswkp', 1, 1, 1, 'L', 'a2hagc4vcxdb', 1, 'L', '2as0ypa51w74w', 1),
('campaigns', 'campaigns', 'from_email', 'N', 'N', 'TE', 'From Email', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', '27fb2uq07lxco', 3, 'L', '14a59bjpcswkp', 0, 0, 3, 'L', 'a2hagc4vcxdb', 3, 'L', '2as0ypa51w74w', 0),
('campaigns', 'campaigns', 'from_name', 'N', 'N', 'TE', 'From Name', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'R', '27fb2uq07lxco', 3, 'R', '14a59bjpcswkp', 0, 0, 3, 'R', 'a2hagc4vcxdb', 3, 'R', '2as0ypa51w74w', 0),
('campaigns', 'campaigns', 'type_id', 'N', 'N', 'DD', 'Type', 1, '', 'campaigns_types', 'type_id', 'type_name', ' order by type_name', 'N', 'N', 'N', 'N', 'Y', 4, 5, 'grid_left', 1, 'R', 'k0xgrf3iadmt', 2, 'R', '27fb2uq07lxco', 2, 'R', '14a59bjpcswkp', 4, 5, 2, 'R', 'a2hagc4vcxdb', 2, 'R', '2as0ypa51w74w', 5),
('campaigns', 'campaigns', 'list_id', 'N', 'N', 'RR', 'List', 1, '', 'campaigns_lists', 'list_id', 'list_name', '', 'N', 'N', 'N', 'N', 'Y', 5, 3, 'grid_left', 2, 'L', 'k0xgrf3iadmt', 1, 'R', '27fb2uq07lxco', 1, 'R', '14a59bjpcswkp', 0, 3, 1, 'R', 'a2hagc4vcxdb', 1, 'R', '2as0ypa51w74w', 3),
('campaigns', 'campaigns', 'subject', 'N', 'N', 'VF', 'Subject', 1, '', '', '', '', '', 'Y', 'N', 'Y', 'N', 'Y', 2, 2, 'grid_left', 0, 'L', '', 1, 'L', '27z0l4zptuv4s', 1, 'L', '27k8gaej7800c', 2, 2, 1, 'L', 'uvelal6cdy2a', 0, 'L', '', 2),
('campaigns', 'campaigns', 'body_text', 'N', 'N', 'ET', 'Body Text', 15, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', '27z0l4zptuv4s', 3, 'L', '27k8gaej7800c', 0, 0, 0, 'L', 'uvelal6cdy2a', 0, 'L', '', 0),
('campaigns', 'campaigns', 'body_html', 'N', 'N', 'EH', 'Body Html', 15, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', '27z0l4zptuv4s', 2, 'L', '27k8gaej7800c', 0, 0, 0, 'L', 'uvelal6cdy2a', 0, 'L', '', 0),
('campaigns', 'campaigns', 'note', 'N', 'N', 'ML', 'Note', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'L', '27z0l4zptuv4s', 4, 'L', '27k8gaej7800c', 0, 0, 2, 'L', 'uvelal6cdy2a', 0, 'L', '', 0),
('campaigns', 'campaigns', 'created', 'N', 'N', 'TS', 'Created', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'L', '1ajk9ce7aq70g', 1, 'L', '1pkbdns9p55a3', 0, 0, 0, 'L', '', 0, 'L', '2bvfz9tkad5wk', 0),
('campaigns', 'campaigns', 'created_by', 'N', 'N', 'DD', 'Created By', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('campaigns', 'campaigns', 'updated', 'N', 'N', 'TS', 'Updated', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 7, 'grid_center', 0, 'L', '', 1, 'R', '1ajk9ce7aq70g', 1, 'R', '1pkbdns9p55a3', 0, 0, 0, 'L', '', 0, 'R', '2bvfz9tkad5wk', 7),
('campaigns', 'campaigns', 'updated_by', 'N', 'N', 'DD', 'Updated By', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('campaigns', 'campaigns', 'status_id', 'N', 'N', 'DD', 'Status', 1, '0', 'campaigns_statuses', 'status_id', 'status_name', ' order by status_name', 'N', 'N', 'N', 'N', 'Y', 3, 4, 'grid_left', 1, 'L', 'k0xgrf3iadmt', 2, 'L', '27fb2uq07lxco', 2, 'L', '14a59bjpcswkp', 3, 4, 2, 'L', 'a2hagc4vcxdb', 2, 'L', '2as0ypa51w74w', 4),
('campaigns_history', 'campaigns_history_view', 'list_name', 'N', 'N', 'TE', 'List Name', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 2, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 2, 0, 0, 'L', '', 0, 'L', '', 0),
('campaigns_history', 'campaigns_history_view', 'rejected', 'N', 'N', 'NU', 'Rejected', 1, '0', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 5, 'grid_right', 0, 'L', '', 3, 'R', 'i3y793uom34u', 3, 'R', '1tgqmyfq4hixb', 0, 4, 3, 'R', 'r552zjxezsso', 3, 'R', '1pljqkenloetb', 4),
('campaigns_history', 'campaigns_history_view', 'campaign_name', 'N', 'N', 'TE', 'Campaign Name', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 1, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 1, 0, 0, 'L', '', 0, 'L', '', 0),
('campaigns_history', 'campaigns_history_view', 'campaign_id', 'N', 'N', 'RR', 'Campaign', 1, '', 'campaigns', 'campaign_id', 'campaign_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 1, 'grid_left', 0, 'L', '', 1, 'L', 'i3y793uom34u', 1, 'L', '1tgqmyfq4hixb', 0, 1, 1, 'L', 'r552zjxezsso', 1, 'L', '1pljqkenloetb', 1),
('campaigns_history', 'campaigns_history_view', 'created_by', 'N', 'N', 'DD', 'Owner', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 4, 7, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 3, 0, 0, 'L', '', 0, 'L', '', 0),
('campaigns_history', 'campaigns_history_view', 'list_id', 'N', 'N', 'RR', 'List', 1, '', 'campaigns_lists', 'list_id', 'list_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 2, 'grid_left', 0, 'L', '', 1, 'R', 'i3y793uom34u', 1, 'R', '1tgqmyfq4hixb', 0, 2, 1, 'R', 'r552zjxezsso', 1, 'R', '1pljqkenloetb', 2),
('campaigns_history', 'campaigns_history_view', 'records', 'N', 'N', 'NU', 'Records', 1, '0', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 4, 'grid_right', 0, 'L', '', 2, 'R', 'i3y793uom34u', 2, 'R', '1tgqmyfq4hixb', 0, 3, 2, 'R', 'r552zjxezsso', 2, 'R', '1pljqkenloetb', 3),
('campaigns_history', 'campaigns_history_view', 'note', 'N', 'N', 'ML', 'Note', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 3, 'grid_left', 0, 'L', '', 1, 'L', '7q5swwstwsu', 1, 'L', '2awy7asa6su88', 0, 0, 1, 'L', 's4v2do13jpo0', 1, 'L', 'b27acvnimo3f', 0),
('campaigns_history', 'campaigns_history_view', 'created', 'N', 'N', 'TS', 'Created', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 3, 6, 'grid_center', 0, 'L', '', 2, 'L', 'i3y793uom34u', 2, 'L', '1tgqmyfq4hixb', 0, 5, 2, 'L', 'r552zjxezsso', 2, 'L', '1pljqkenloetb', 5),
('campaigns_lists', 'campaigns_lists', 'list_id', 'N', 'N', 'RK', 'List', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', -1, -1, 'grid_left', -1, 'L', '', -1, 'L', '', -1, 'L', '', -1, -1, -1, 'L', '', 0, 'L', '', 0),
('campaigns_lists', 'campaigns_lists', 'user_id', 'N', 'N', 'DD', 'Owner', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 3, 3, 'grid_left', 1, 'L', 'toajip9gywa2', 0, 'L', '', 0, 'L', '', 3, 3, 0, 'L', '', 0, 'L', '', 3),
('campaigns_lists', 'campaigns_lists', 'list_name', 'N', 'N', 'VF', 'List Name', 1, '', '', '', '', '', 'Y', 'N', 'Y', 'N', 'Y', 1, 1, 'grid_left', 0, 'L', '', 1, 'L', '13ka11p7j9dec', 1, 'L', '9v3838ugdu1r', 1, 1, 1, 'L', 'lz534sbpo3d5', 1, 'L', '26vll517dx0kc', 1),
('campaigns_lists', 'campaigns_lists', 'status_id', 'N', 'N', 'DD', 'Status', 1, '', 'campaigns_lists_statuses', 'status_id', 'status_name', ' order by status_name', 'N', 'N', 'N', 'N', 'Y', 2, 2, 'grid_left', 1, 'R', 'toajip9gywa2', 1, 'R', '13ka11p7j9dec', 1, 'R', '9v3838ugdu1r', 2, 2, 1, 'R', 'lz534sbpo3d5', 1, 'R', '26vll517dx0kc', 2),
('campaigns_lists', 'campaigns_lists', 'note', 'N', 'N', 'ML', 'Note', 4, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', 'rhgidmfukuel', 1, 'L', '210yp94bljb40', 0, 0, 1, 'L', 'mrh061sae1y1', 1, 'L', '19hdlqkspg8qp', 0),
('campaigns_lists', 'campaigns_lists', 'created', 'N', 'N', 'TS', 'Created', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'L', '18xo2pz1dxkkb', 1, 'L', '1txzfxr6f2v99', 0, 0, 0, 'L', '', 1, 'L', '1zhj8ae3jpy8g', 0),
('campaigns_lists', 'campaigns_lists', 'created_by', 'N', 'N', 'DD', 'Created By', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('campaigns_lists', 'campaigns_lists', 'updated', 'N', 'N', 'TS', 'Updated', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 4, 'grid_center', 0, 'L', '', 1, 'R', '18xo2pz1dxkkb', 1, 'R', '1txzfxr6f2v99', 0, 4, 0, 'L', '', 1, 'R', '1zhj8ae3jpy8g', 4),
('campaigns_lists', 'campaigns_lists', 'updated_by', 'N', 'N', 'DD', 'Updated By', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 5, 'grid_left', 0, 'L', '', 0, 'R', '18xo2pz1dxkkb', 0, 'R', '1txzfxr6f2v99', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('campaigns_records', 'campaigns_records_view', 'first_names', 'N', 'N', 'TE', 'First Names', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('campaigns_records', 'campaigns_records_view', 'last_name', 'N', 'N', 'TE', 'Last Name', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('campaigns_records', 'campaigns_records_view', 'salutation', 'N', 'N', 'TE', 'Salutation', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('campaigns_records', 'campaigns_records_view', 'record_type_id', 'N', 'N', 'DD', 'Record Type', 1, '', 'campaigns_records_types', 'type_id', 'type_name', ' order by type_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('campaigns_records', 'campaigns_records_view', 'list_id', 'N', 'N', 'DD', 'List', 1, '', 'campaigns_lists', 'list_id', 'list_name', ' order by list_name', 'N', 'N', 'N', 'N', 'Y', 1, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 1, 0, 0, 'L', '', 0, 'L', '', 0),
('campaigns_records', 'campaigns_records_view', 'record_id', 'N', 'N', 'TE', 'Record', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('campaigns_records', 'campaigns_records_view', 'record_name', 'N', 'N', 'VF', 'Record Name', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 2, 1, 'grid_left', 0, 'L', '', 1, 'L', 'jygs8nj6taey', 1, 'L', 's7bqwudj4dyi', 2, 1, 1, 'L', '1uhoyhl4orcdz', 0, 'L', '', 1),
('campaigns_records', 'campaigns_records_view', 'email', 'N', 'N', 'WM', 'Email', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 2, 'grid_left', 0, 'L', '1cqealyh2b8uz', 2, 'L', 'ubp39my99327', 2, 'L', 'k1li7xu4xoh', 0, 2, 2, 'L', '3wrc04h0hsja', 0, 'L', '', 2),
('campaigns_records', 'campaigns_records_view', 'email_opt_out', 'N', 'N', 'CH', 'Email Opt Out', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 3, 3, 'grid_center', 1, 'L', 'lllb3nixq3qc', 3, 'L', 'ubp39my99327', 3, 'L', 'k1li7xu4xoh', 3, 3, 3, 'L', '3wrc04h0hsja', 0, 'L', '', 3),
('campaigns_records', 'campaigns_records_view', 'do_not_call', 'N', 'N', 'CH', 'Do Not Call', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 4, 6, 'grid_center', 2, 'L', 'lllb3nixq3qc', 3, 'R', 'ubp39my99327', 3, 'R', 'k1li7xu4xoh', 4, 6, 3, 'R', '3wrc04h0hsja', 0, 'L', '', 6),
('campaigns_records', 'campaigns_records_view', 'phone', 'N', 'N', 'TE', 'Phone', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 4, 'grid_left', 0, 'L', '', 1, 'R', 'ubp39my99327', 1, 'R', 'k1li7xu4xoh', 0, 4, 1, 'R', '3wrc04h0hsja', 0, 'L', '', 4),
('campaigns_records', 'campaigns_records_view', 'mobile', 'N', 'N', 'TE', 'Mobile', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 5, 'grid_left', 0, 'L', '', 2, 'R', 'ubp39my99327', 2, 'R', 'k1li7xu4xoh', 0, 5, 2, 'R', '3wrc04h0hsja', 0, 'L', '', 5),
('campaigns_records', 'campaigns_records_view', 'created', 'N', 'N', 'TS', 'Created', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'L', '1pvehgfl9t5qr', 1, 'L', '1lhqf69y2thhj', 0, 0, 1, 'L', '2a4ma0f0n5usc', 0, 'L', '', 0),
('campaigns_records', 'campaigns_records_view', 'updated', 'N', 'N', 'TS', 'Updated', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'R', '1pvehgfl9t5qr', 1, 'R', '1lhqf69y2thhj', 0, 0, 1, 'R', '2a4ma0f0n5usc', 0, 'L', '', 0),
('campaigns_records', 'campaigns_records_view', 'user_id', 'N', 'N', 'DD', 'Owner', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 7, 9, 'grid_left', 2, 'R', 'lllb3nixq3qc', 0, 'L', '', 0, 'L', '', 7, 0, 0, 'L', '', 0, 'L', '', 0),
('campaigns_records', 'campaigns_records_view', 'status_id', 'N', 'N', 'DD', 'Status', 1, '', 'campaigns_lists_statuses', 'status_id', 'status_name', ' order by status_name', 'N', 'N', 'N', 'N', 'Y', 5, 7, 'grid_left', 1, 'R', 'lllb3nixq3qc', 1, 'L', 'ubp39my99327', 1, 'L', 'k1li7xu4xoh', 5, 7, 1, 'L', '3wrc04h0hsja', 0, 'L', '', 7),
('campaigns_records', 'campaigns_records_view', 'account_name', 'N', 'N', 'TE', 'Account Name', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('cases', 'cases', 'case_id', 'N', 'N', 'RK', 'Case Id', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', -1, -1, 'grid_left', -1, 'L', '', -1, 'L', '', -1, 'L', '', -1, -1, -1, 'L', '', 0, 'L', '', -1),
('cases', 'cases', 'user_id', 'N', 'N', 'DD', 'Owner', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 7, 7, 'grid_left', 1, 'L', '1appthrik4ncl', 0, 'L', '', 0, 'L', '', 5, 6, 0, 'L', '', 0, 'L', '', 7),
('cases', 'cases', 'status_id', 'N', 'N', 'DD', 'Status', 1, '', 'cases_statuses', 'status_id', 'status_name', 'order by status_name', 'N', 'N', 'N', 'N', 'Y', 4, 5, 'grid_left', 2, 'L', '1appthrik4ncl', 1, 'R', 'sh6efa3xi81h', 1, 'R', 'jurnfj4d78f8', 2, 4, 1, 'R', 'mp0c9perffap', 1, 'R', '297czvyle7tw0', 5),
('cases', 'cases', 'subject', 'N', 'N', 'VF', 'Subject', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 1, 2, 'grid_left', 0, 'L', '', 1, 'L', 'sh6efa3xi81h', 1, 'L', 'jurnfj4d78f8', 1, 2, 1, 'L', 'mp0c9perffap', 1, 'L', '1h6j2a3qovhez', 2),
('cases', 'cases', 'note', 'N', 'N', 'ML', 'Note', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '1lnw1iacxacgm', 1, 'L', 'cd09egoz2mtw', 0, 0, 1, 'L', '1rooqvnkdybx6', 1, 'L', '2at96cmke5xc8', 0),
('cases', 'cases', 'priority_id', 'N', 'N', 'DD', 'Priority', 1, '', 'cases_priorities', 'priority_id', 'priority_name', 'order by priority_sequence', 'N', 'N', 'N', 'N', 'Y', 5, 1, 'grid_left', 2, 'R', '1appthrik4ncl', 2, 'R', 'sh6efa3xi81h', 2, 'R', 'jurnfj4d78f8', 3, 1, 2, 'R', 'mp0c9perffap', 1, 'L', '297czvyle7tw0', 1),
('cases', 'cases', 'due_date', 'N', 'N', 'DA', 'Due Date', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 6, 6, 'grid_center', 1, 'R', '1appthrik4ncl', 2, 'L', 'sh6efa3xi81h', 2, 'L', 'jurnfj4d78f8', 4, 5, 2, 'L', 'mp0c9perffap', 2, 'L', '1h6j2a3qovhez', 6),
('cases', 'cases', 'created', 'N', 'N', 'TS', 'Created', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'L', '12jblwzk5m3jx', 1, 'L', '123b4t5508c46', 0, 0, 1, 'L', '18ohyrc48kp5', 0, 'L', '', 0),
('cases', 'cases', 'created_by', 'N', 'N', 'DD', 'Created By', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '12jblwzk5m3jx', 0, 'L', '123b4t5508c46', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('cases', 'cases', 'updated', 'N', 'N', 'TS', 'Last Update', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'R', '12jblwzk5m3jx', 1, 'R', '123b4t5508c46', 0, 0, 1, 'R', '18ohyrc48kp5', 0, 'L', '', 0),
('cases', 'cases', 'updated_by', 'N', 'N', 'DD', 'Updated By', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'R', '12jblwzk5m3jx', 0, 'R', '123b4t5508c46', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('contacts', 'contacts', 'type_id', 'N', 'N', 'DD', 'Type', 1, '', 'types', 'type_id', 'type_name', ' order by type_name', 'N', 'N', 'N', 'N', 'Y', 4, 0, 'grid_left', 2, 'R', '90aglgoeka6p', 11, 'L', 'l4cogl4adios', 11, 'L', '19pzzzxgc8du6', 4, 0, 0, 'L', '', 0, 'L', '', 0),
('contacts', 'contacts', 'department', 'N', 'N', 'TE', 'Department', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', 'l4cogl4adios', 3, 'L', '19pzzzxgc8du6', 0, 0, 3, 'L', 'b276h1p3t6lj', 3, 'L', '1ss3qzbfakxrq', 0),
('contacts', 'contacts', 'account_id', 'N', 'N', 'RR', 'Account', 1, '', 'accounts', 'account_id', 'account_name', '', 'N', 'N', '', 'N', 'Y', 2, 3, 'grid_left', 1, 'R', '90aglgoeka6p', 3, 'R', 'l4cogl4adios', 3, 'R', '19pzzzxgc8du6', 3, 3, 0, 'R', 'b276h1p3t6lj', 3, 'R', '1ss3qzbfakxrq', 3),
('contacts', 'contacts', 'title', 'N', 'N', 'TE', 'Title', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 3, 0, 'grid_left', 0, 'L', '', 2, 'R', 'l4cogl4adios', 2, 'R', '19pzzzxgc8du6', 0, 0, 2, 'R', 'b276h1p3t6lj', 2, 'R', '1ss3qzbfakxrq', 0),
('contacts', 'contacts', 'salutation', 'N', 'N', 'TE', 'Salutation', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', 'l4cogl4adios', 2, 'L', '19pzzzxgc8du6', 0, 0, 2, 'L', 'b276h1p3t6lj', 2, 'L', '1ss3qzbfakxrq', 0),
('contacts', 'contacts', 'last_name', 'N', 'N', 'VF', 'Last name', 1, '', '', '', '', '', 'Y', 'N', 'Y', 'N', 'Y', 1, 2, 'grid_left', 0, 'L', '', 1, 'R', 'l4cogl4adios', 1, 'R', '19pzzzxgc8du6', 2, 2, 1, 'R', 'b276h1p3t6lj', 1, 'R', '1ss3qzbfakxrq', 2),
('contacts', 'contacts', 'first_names', 'N', 'N', 'VF', 'First name', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 1, 'grid_left', 0, 'L', '', 1, 'L', 'l4cogl4adios', 1, 'L', '19pzzzxgc8du6', 1, 1, 1, 'L', 'b276h1p3t6lj', 1, 'L', '1ss3qzbfakxrq', 1),
('contacts', 'contacts', 'user_id', 'N', 'N', 'DD', 'Owner', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', '', 'N', 'Y', 6, 9, 'grid_left', 3, 'R', '90aglgoeka6p', -1, 'L', '', -1, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 8),
('contacts', 'contacts', 'contact_id', 'N', 'N', 'RK', 'Contact', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', -1, -1, 'grid_left', -1, 'L', '', -1, 'L', '', -1, 'L', '', -1, -1, -1, 'L', '', 0, 'L', '', -1),
('contacts', 'contacts', 'manager_id', 'N', 'N', 'RR', 'Manager', 1, '', 'contacts', 'contact_id', 'full_name', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 10, 'L', 'l4cogl4adios', 10, 'L', '19pzzzxgc8du6', 0, 0, 0, 'L', 'b276h1p3t6lj', 7, 'L', '1ss3qzbfakxrq', 0),
('contacts', 'contacts', 'email', 'N', 'N', 'WM', 'Email', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 4, 'grid_left', 0, 'L', '', 4, 'L', 'l4cogl4adios', 4, 'L', '19pzzzxgc8du6', 0, 4, 5, 'L', 'b276h1p3t6lj', 4, 'L', '1ss3qzbfakxrq', 4),
('contacts', 'contacts', 'phone', 'N', 'N', 'TE', 'Phone', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 6, 'grid_left', 0, 'L', '', 5, 'L', 'l4cogl4adios', 5, 'L', '19pzzzxgc8du6', 0, 5, 4, 'R', 'b276h1p3t6lj', 5, 'L', '1ss3qzbfakxrq', 5),
('contacts', 'contacts', 'mobile', 'N', 'N', 'TE', 'Mobile', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 7, 'grid_left', 0, 'L', '', 6, 'L', 'l4cogl4adios', 6, 'L', '19pzzzxgc8du6', 0, 0, 4, 'L', 'b276h1p3t6lj', 6, 'L', '1ss3qzbfakxrq', 6),
('contacts', 'contacts', 'messenger', 'N', 'N', 'TE', 'Messenger', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 8, 'L', 'l4cogl4adios', 8, 'L', '19pzzzxgc8du6', 0, 0, 0, 'L', 'b276h1p3t6lj', 0, 'L', '1ss3qzbfakxrq', 0),
('contacts', 'contacts', 'messenger_type', 'N', 'N', 'TE', 'Messenger type', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 9, 'L', 'l4cogl4adios', 9, 'L', '19pzzzxgc8du6', 0, 0, 0, 'L', 'b276h1p3t6lj', 0, 'L', '1ss3qzbfakxrq', 0),
('contacts', 'contacts', 'fax', 'N', 'N', 'TE', 'Fax', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 7, 'L', 'l4cogl4adios', 7, 'L', '19pzzzxgc8du6', 0, 0, 0, 'R', 'b276h1p3t6lj', 0, 'L', '1ss3qzbfakxrq', 0),
('contacts', 'contacts', 'email_opt_out', 'N', 'N', 'CH', 'Email opt out', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_center', 3, 'L', '90aglgoeka6p', 4, 'R', 'l4cogl4adios', 4, 'R', '19pzzzxgc8du6', 0, 0, 0, 'R', 'b276h1p3t6lj', 4, 'R', '1ss3qzbfakxrq', 0),
('contacts', 'contacts', 'do_not_call', 'N', 'N', 'CH', 'Do not call', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_center', 2, 'L', '90aglgoeka6p', 5, 'R', 'l4cogl4adios', 5, 'R', '19pzzzxgc8du6', 0, 0, 0, 'R', 'b276h1p3t6lj', 5, 'R', '1ss3qzbfakxrq', 0),
('contacts', 'contacts', 'assistant_id', 'N', 'N', 'RR', 'Assistant', 1, '', 'contacts', 'contact_id', 'full_name', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 10, 'R', 'l4cogl4adios', 10, 'R', '19pzzzxgc8du6', 0, 0, 3, 'R', 'b276h1p3t6lj', 7, 'R', '1ss3qzbfakxrq', 0),
('contacts', 'contacts', 'private_phone', 'N', 'N', 'TE', 'Private phone', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 7, 'R', 'l4cogl4adios', 7, 'R', '19pzzzxgc8du6', 0, 0, 0, 'R', 'b276h1p3t6lj', 0, 'R', '1ss3qzbfakxrq', 0),
('contacts', 'contacts', 'private_mobile', 'N', 'N', 'TE', 'Private mobile', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 8, 'R', 'l4cogl4adios', 8, 'R', '19pzzzxgc8du6', 0, 0, 0, 'R', 'b276h1p3t6lj', 0, 'R', '1ss3qzbfakxrq', 0),
('contacts', 'contacts', 'private_email', 'N', 'N', 'WM', 'Private email', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 9, 'R', 'l4cogl4adios', 9, 'R', '19pzzzxgc8du6', 0, 0, 0, 'R', 'b276h1p3t6lj', 0, 'R', '1ss3qzbfakxrq', 0),
('contacts', 'contacts', 'birthdate', 'N', 'N', 'DA', 'Date of birth', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 11, 'R', 'l4cogl4adios', 11, 'R', '19pzzzxgc8du6', 0, 0, 0, 'R', 'b276h1p3t6lj', 0, 'R', '1ss3qzbfakxrq', 0),
('contacts', 'contacts', 'address_1', 'N', 'N', 'ML', 'Primary address', 4, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '8xu4m31alhk4', 1, 'L', '1jftrk7u1yala', 0, 0, 1, 'L', '1go1s5js1v52e', 1, 'L', '212721nb9fgkc', 0),
('contacts', 'contacts', 'zipcode_1', 'N', 'N', 'TE', 'Primary zipcode', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 5, 'L', '8xu4m31alhk4', 5, 'L', '1jftrk7u1yala', 0, 0, 4, 'R', '1go1s5js1v52e', 4, 'R', '212721nb9fgkc', 0),
('contacts', 'contacts', 'city_1', 'N', 'N', 'TE', 'Primary city', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', '8xu4m31alhk4', 2, 'L', '1jftrk7u1yala', 0, 0, 1, 'R', '1go1s5js1v52e', 1, 'R', '212721nb9fgkc', 0),
('contacts', 'contacts', 'state_1', 'N', 'N', 'TE', 'Primary state', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', '8xu4m31alhk4', 3, 'L', '1jftrk7u1yala', 0, 0, 2, 'R', '1go1s5js1v52e', 2, 'R', '212721nb9fgkc', 0),
('contacts', 'contacts', 'country_1', 'N', 'N', 'TE', 'Primary country', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'L', '8xu4m31alhk4', 4, 'L', '1jftrk7u1yala', 0, 0, 3, 'R', '1go1s5js1v52e', 3, 'R', '212721nb9fgkc', 0),
('contacts', 'contacts', 'address_2', 'N', 'N', 'ML', 'Secondary address', 4, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', '8xu4m31alhk4', 1, 'R', '1jftrk7u1yala', 0, 0, 0, 'R', '1go1s5js1v52e', 0, 'R', '212721nb9fgkc', 0),
('contacts', 'contacts', 'zipcode_2', 'N', 'N', 'TE', 'Secondary zipcode', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'R', '8xu4m31alhk4', 4, 'R', '1jftrk7u1yala', 0, 0, 0, 'R', '1go1s5js1v52e', 0, 'R', '212721nb9fgkc', 0),
('contacts', 'contacts', 'city_2', 'N', 'N', 'TE', 'Secondary city', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', '8xu4m31alhk4', 2, 'R', '1jftrk7u1yala', 0, 0, 0, 'R', '1go1s5js1v52e', 0, 'R', '212721nb9fgkc', 0),
('contacts', 'contacts', 'state_2', 'N', 'N', 'TE', 'Secondary state', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'R', '8xu4m31alhk4', 3, 'R', '1jftrk7u1yala', 0, 0, 0, 'R', '1go1s5js1v52e', 0, 'R', '212721nb9fgkc', 0),
('contacts', 'contacts', 'country_2', 'N', 'N', 'TE', 'Secondary country', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 5, 'R', '8xu4m31alhk4', 5, 'R', '1jftrk7u1yala', 0, 0, 0, 'R', '1go1s5js1v52e', 0, 'R', '212721nb9fgkc', 0),
('contacts', 'contacts', 'note', 'N', 'N', 'ML', 'Note', 4, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '7qcfwr9g2s0', 1, 'L', 'bf6pohx6e1o', 0, 0, 0, 'L', '', 0, 'L', '1r3qvqd6l8rso', 0),
('contacts', 'contacts', 'created', 'N', 'N', 'TS', 'Created', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_center', -1, 'L', '', 1, 'L', '10eyk1zxqe6oc', 1, 'L', '8vd8x58p4sil', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('contacts', 'contacts', 'created_by', 'N', 'N', 'DD', 'Created by', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', -1, 'L', '', 0, 'L', '10eyk1zxqe6oc', 0, 'L', '8vd8x58p4sil', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('contacts', 'contacts', 'updated', 'N', 'N', 'TS', 'Last Update', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_center', -1, 'L', '', 1, 'R', '10eyk1zxqe6oc', 1, 'R', '8vd8x58p4sil', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('contacts', 'contacts', 'updated_by', 'N', 'N', 'DD', 'Updated by', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', -1, 'L', '', 0, 'R', '10eyk1zxqe6oc', 0, 'R', '8vd8x58p4sil', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('documents', 'documents', 'document_id', 'N', 'N', 'RK', 'Document Id', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', -1, -1, 'grid_left', -1, 'L', '', -1, 'L', '', -1, 'L', '', -1, -1, -1, 'L', '', 0, 'L', '', -1),
('documents', 'documents', 'document_name', 'N', 'N', 'DO', 'Name', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 1, 2, 'grid_left', 0, 'L', '', 1, 'L', '58so7kd9tth9', 1, 'L', '1ha89c6n8hggc', 1, 1, 1, 'L', '8swft6fa6wqm', 1, 'L', '10eyjn7u927ks', 1),
('documents', 'documents', 'is_folder', 'N', 'N', 'CH', 'Is a folder', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 1, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'R', '11s81saonrkcj', 0, 0, 0, 'L', '1zgar2xanqkgw', 0, 'L', '', 0),
('documents', 'documents', 'filesize', 'N', 'N', 'DS', 'Size', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 4, 'grid_right', 0, 'L', '', 2, 'R', '58so7kd9tth9', 2, 'L', '1a9piyvr5ol5g', 0, 3, 2, 'R', '8swft6fa6wqm', 0, 'L', '', 3),
('documents', 'documents', 'filetype', 'N', 'N', 'DY', 'Type', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 5, 'grid_left', 0, 'L', '', 2, 'L', '58so7kd9tth9', 1, 'L', '1a9piyvr5ol5g', 0, 0, 2, 'L', '8swft6fa6wqm', 0, 'L', '10eyjn7u927ks', 4),
('documents', 'documents', 'user_id', 'N', 'N', 'DD', 'Owner', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 4, 7, 'grid_left', 1, 'R', '1tuaann8tbxn0', 0, 'L', '', 0, 'L', '', 4, 6, 0, 'L', '', 0, 'L', '', 6),
('documents', 'documents', 'subject', 'N', 'N', 'VF', 'Subject', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 2, 3, 'grid_left', 1, 'L', '1tuaann8tbxn0', 1, 'L', '1jjipo3medytx', 1, 'L', '1hxmmynpszxcn', 2, 2, 1, 'L', '1zgar2xanqkgw', 1, 'L', '12y40ppr8ee8k', 2),
('documents', 'documents', 'note', 'N', 'N', 'ML', 'Note', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '1q0brwwu9b7xb', 1, 'L', '29pu5xukwjy8k', 0, 0, 2, 'L', '1zgar2xanqkgw', 1, 'L', '9xk3lf1hths8', 0),
('documents', 'documents', 'created', 'N', 'N', 'TS', 'Created', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 8, 'grid_center', 0, 'L', '', 1, 'L', 'sr1630uzfo42', 1, 'L', '13318h3afbkf5', 0, 0, 0, 'L', '20yhwd603vvo0', 0, 'L', '', 7),
('documents', 'documents', 'created_by', 'N', 'N', 'DD', 'Created By', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'R', '11s81saonrkcj', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('documents', 'documents', 'updated', 'N', 'N', 'TS', 'Last Update', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 9, 'grid_center', 0, 'L', '', 1, 'R', 'sr1630uzfo42', 1, 'R', '13318h3afbkf5', 0, 5, 0, 'R', '20yhwd603vvo0', 0, 'L', '', 0),
('documents', 'documents', 'updated_by', 'N', 'N', 'DD', 'Updated By', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'R', '11s81saonrkcj', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('documents', 'documents', 'folder_id', 'N', 'N', 'DF', 'Folder', 1, '', 'documents', 'document_id', 'document_name', '', 'N', 'N', 'N', 'N', 'Y', 3, 6, 'grid_left', 2, 'R', '1tuaann8tbxn0', 1, 'R', '58so7kd9tth9', 1, 'R', '1a9piyvr5ol5g', 3, 4, 1, 'R', '8swft6fa6wqm', 2, 'L', '10eyjn7u927ks', 5),
('opportunities', 'opportunities', 'recurring_amount', 'N', 'N', 'CU', 'Recurring Amount', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'R', 'bxb8kbm6dj', 1, 'R', 'uo0dacgaydwe', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('opportunities', 'opportunities', 'recurring_start_time', 'N', 'N', 'DA', 'Recurring Start Time', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 2, 'L', 'bxb8kbm6dj', 2, 'L', 'uo0dacgaydwe', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('opportunities', 'opportunities', 'recurring_end_time', 'N', 'N', 'DA', 'Recurring End Time', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 2, 'R', 'bxb8kbm6dj', 2, 'R', 'uo0dacgaydwe', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('opportunities', 'opportunities', 'created', 'N', 'N', 'DT', 'Created', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', -1, 'L', '', 1, 'L', '1457q3mybwt5u', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '8xtxvsx3dmw4', 0),
('opportunities', 'opportunities', 'created_by', 'N', 'N', 'DD', 'Created By', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', -1, 'L', '', 2, 'L', '1457q3mybwt5u', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '8xtxvsx3dmw4', 0),
('opportunities', 'opportunities', 'updated', 'N', 'N', 'DT', 'Last Update', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', -1, 'L', '', 1, 'R', '1457q3mybwt5u', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'R', '8xtxvsx3dmw4', 0),
('opportunities', 'opportunities', 'updated_by', 'N', 'N', 'DD', 'Updated By', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', -1, 'L', '', 2, 'R', '1457q3mybwt5u', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'R', '8xtxvsx3dmw4', 0),
('opportunities', 'opportunities', 'note', 'N', 'N', 'ML', 'Note', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', 'hu39z57kbs2b', 1, 'L', 'b274725mbzr7', 0, 0, 1, 'L', '2h0plgzs8zxx', 0, 'L', '', 0),
('opportunities', 'opportunities', 'recurring_id', 'N', 'N', 'TE', 'Recurring Id', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', 'bxb8kbm6dj', 1, 'L', 'uo0dacgaydwe', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('opportunities', 'opportunities', 'closing', 'N', 'N', 'DA', 'Closing Date', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 10, 'grid_center', 1, 'R', '9l8bayclym1p', 2, 'L', 'b4nszc8xzv23', 2, 'L', '1tbt381th3vvu', 3, 5, 1, 'L', 'hp5welliywza', 2, 'L', '1lhqfb3ptbgn3', 8),
('opportunities', 'opportunities', 'probability', 'N', 'N', 'TE', 'Probability', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 8, 'grid_left', 2, 'R', '9l8bayclym1p', 4, 'R', 'b4nszc8xzv23', 4, 'R', '1tbt381th3vvu', 0, 0, 3, 'R', 'hp5welliywza', 3, 'R', '1lhqfb3ptbgn3', 6),
('opportunities', 'opportunities', 'expected_amount', 'N', 'N', 'CU', 'Expected Amount', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 9, 'grid_right', 0, 'L', '', 3, 'L', 'b4nszc8xzv23', 3, 'L', '1tbt381th3vvu', 0, 4, 2, 'L', 'hp5welliywza', 3, 'L', '1lhqfb3ptbgn3', 7),
('opportunities', 'opportunities', 'type_id', 'N', 'N', 'TE', 'Type Id', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('opportunities', 'opportunities', 'stage_id', 'N', 'N', 'DD', 'Stage', 1, '', 'stages', 'stage_id', 'stage_name', ' order by stage_name', 'N', 'N', 'N', 'N', 'Y', 5, 6, 'grid_left', 2, 'L', '9l8bayclym1p', 3, 'R', 'b4nszc8xzv23', 3, 'R', '1tbt381th3vvu', 0, 0, 2, 'R', 'hp5welliywza', 2, 'R', '1lhqfb3ptbgn3', 4),
('opportunities', 'opportunities', 'source_id', 'N', 'N', 'DD', 'Source', 1, '', 'sources', 'source_id', 'source_name', ' order by source_name', 'N', 'N', 'N', 'N', 'Y', 4, 7, 'grid_left', 0, 'L', '9l8bayclym1p', 4, 'L', 'b4nszc8xzv23', 4, 'L', '1tbt381th3vvu', 0, 0, 3, 'L', 'hp5welliywza', 4, 'L', '1lhqfb3ptbgn3', 5),
('opportunities', 'opportunities', 'user_id', 'N', 'N', 'DD', 'Owner', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 7, 11, 'grid_left', 1, 'L', '9l8bayclym1p', -1, 'L', '', -1, 'L', '', 4, 3, 0, 'L', '', 0, 'L', '', 3),
('opportunities', 'opportunities', 'opportunity_id', 'N', 'N', 'RK', 'Opportunity Id', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', -1, -1, 'grid_left', -1, 'L', '', -1, 'L', '', -1, 'L', '', -1, -1, -1, 'L', '', 0, 'L', '', -1),
('opportunities', 'opportunities', 'opportunity_name', 'N', 'N', 'VF', 'Opportunity', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 1, 1, 'grid_left', 0, 'L', '', 1, 'L', 'b4nszc8xzv23', 1, 'L', '1tbt381th3vvu', 1, 1, 0, 'L', 'hp5welliywza', 1, 'L', '1lhqfb3ptbgn3', 1),
('opportunities', 'opportunities', 'account_id', 'N', 'N', 'RR', 'Account', 1, '', 'accounts', 'account_id', 'account_name', '', 'N', 'N', 'N', 'N', 'Y', 2, 2, 'grid_left', 0, 'L', '', 1, 'R', 'b4nszc8xzv23', 1, 'R', '1tbt381th3vvu', 2, 2, 1, 'R', 'hp5welliywza', 1, 'R', '1lhqfb3ptbgn3', 2);

INSERT INTO db_fields (app_name, table_name, field_name, is_custom, is_computed, field_type, field_label, field_height, field_default, related_table, related_id, related_name, related_filter, is_search, is_readonly, is_mandatory, is_unique, is_visible, search_sequence, result_sequence, result_class, bulk_sequence, bulk_side, bulk_block_id, view_sequence, view_side, view_block_id, edit_sequence, edit_side, edit_block_id, popup_search_sequence, popup_result_sequence, popup_view_sequence, popup_view_side, popup_view_block_id, popup_edit_sequence, popup_edit_side, popup_edit_block_id, linked_sequence) VALUES 
('reports', 'reports', 'filtercriterias', 'N', 'N', 'ML', 'Filtercriterias', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'orderbycolumns', 'N', 'N', 'ML', 'Orderbycolumns', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'quickselect', 'N', 'N', 'ML', 'Quickselect', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'quickwhere', 'N', 'N', 'ML', 'Quickwhere', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'quickparameter', 'N', 'N', 'ML', 'Quickparameter', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'pre_process', 'N', 'N', 'ML', 'Pre Process', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'updated', 'N', 'N', 'TS', 'Updated', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 5, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'updated_by', 'N', 'N', 'DD', 'Updated By', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'created', 'N', 'N', 'TS', 'Created', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 6, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'created_by', 'N', 'N', 'DD', 'Created By', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'report_id', 'N', 'N', 'RK', 'Report Id', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', -1, -1, 'grid_left', -1, 'L', '', 0, 'L', '', 0, 'L', '', -1, -1, -1, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'report_name', 'N', 'N', 'TE', 'Report Name', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 1, 1, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'template', 'N', 'N', 'TE', 'Template', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'user_id', 'N', 'N', 'DD', 'Owner', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 4, 4, 'grid_left', 1, 'L', '1a8hdbjvfozog', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'table_name', 'N', 'N', 'DD', 'Application', 1, '', 'db_applications', 'table_name', 'app_label', 'where status_id in ("A","D") and is_report = "Y" order by app_label', 'N', 'N', 'N', 'N', 'Y', 2, 2, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'type_id', 'N', 'N', 'DD', 'Type', 1, '', 'reports_types', 'type_id', 'type_name', ' order by type_name', 'N', 'N', 'N', 'N', 'Y', 0, 4, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'selectedcolumns', 'N', 'N', 'ML', 'Selectedcolumns', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'groupbycolumns', 'N', 'N', 'ML', 'Groupbycolumns', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'orderbygroupcolumns', 'N', 'N', 'TE', 'Orderbygroupcolumns', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'note', 'N', 'N', 'TE', 'Note', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'is_private', 'N', 'N', 'CH', 'Private', 1, 'N', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 3, 3, 'grid_center', 1, 'R', '1a8hdbjvfozog', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'selectedfields', 'N', 'N', 'TE', 'Selectedfields', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'groupbyfields', 'N', 'N', 'TE', 'Groupbyfields', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'orderbyfields', 'N', 'N', 'TE', 'Orderbyfields', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('reports', 'reports', 'orderbygroupfields', 'N', 'N', 'TE', 'Orderbygroupfields', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
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
('support_tickets', 'backoffice_support_tickets', 'note', 'N', 'N', 'ML', 'Note', 20, '', '', '', '', '', 'Y', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '1223a1n1tsogs', 1, 'L', 'hlhf82bs53sc', 0, 0, 0, 'L', '27gjtdaiok4k4', 1, 'L', '11fx2z360hr4k', 0),
('support_tickets', 'backoffice_support_tickets', 'priority_id', 'N', 'N', 'DD', 'Priority', 1, '', 'backoffice_support_tickets_priorities', 'priority_id', 'priority_name', '', 'N', 'N', 'N', 'N', 'Y', 5, 5, 'grid_left', 2, 'L', '1a2btyu0dyrog', 3, 'L', 'mlbohio1mi8o', 3, 'L', 'ucxtqz88t1c0', 5, 5, 3, 'L', '27mpjc01xrfo0', 3, 'L', 'miuzp8ixiyo4', 5),
('support_tickets', 'backoffice_support_tickets', 'status_id', 'N', 'N', 'DD', 'Status', 1, '', 'backoffice_support_tickets_statuses', 'status_id', 'status_name', '', 'N', 'N', 'N', 'N', 'Y', 4, 1, 'grid_left', 1, 'L', '1a2btyu0dyrog', 2, 'L', 'mlbohio1mi8o', 2, 'L', 'ucxtqz88t1c0', 4, 1, 2, 'L', '27mpjc01xrfo0', 2, 'L', 'miuzp8ixiyo4', 1),
('support_tickets', 'backoffice_support_tickets', 'subject', 'N', 'N', 'VF', 'Subject', 1, '', '', '', '', '', 'Y', 'N', 'Y', 'N', 'Y', 1, 2, 'grid_left', 0, 'L', '', 1, 'L', '1cdwjf8bx9lw', 1, 'L', '1331lx5i9yo04', 1, 2, 1, 'L', '45e4r22e9okk', 1, 'L', 'ibcndsd8tm8s', 2),
('support_tickets', 'backoffice_support_tickets', 'ticket_id', 'N', 'N', 'RK', 'Ticket identifier', 1, '', '', '', '', '', 'N', 'Y', 'N', 'Y', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'R', 'mlbohio1mi8o', 0, 'R', 'ucxtqz88t1c0', 0, 0, 0, 'R', '27mpjc01xrfo0', 0, 'R', 'miuzp8ixiyo4', 0),
('support_tickets', 'backoffice_support_tickets', 'updated', 'N', 'N', 'TS', 'Updated', 1, '', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 6, 'grid_center', 0, 'L', '', 1, 'R', 'lj50b4cuhcgc', 1, 'R', '1a3k6g8fr4skk', 0, 6, 0, 'L', '', 0, 'L', '', 6),
('support_tickets', 'backoffice_support_tickets', 'updated_by', 'N', 'N', 'RR', 'Updated by', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('support_tickets', 'backoffice_support_tickets', 'user_id', 'N', 'N', 'DD', 'Owner', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 6, 7, 'grid_left', 3, 'R', '1a2btyu0dyrog', 0, 'L', '', 0, 'L', '', 6, 7, 0, 'L', '', 0, 'L', '', 7),
('webmail', 'webmail', 'mail_id', 'N', 'N', 'RK', 'Mail', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', -1, -1, 'grid_left', -1, 'L', '', -1, 'L', '', -1, 'L', '', -1, -1, -1, 'L', '', 0, 'L', '', 0),
('webmail', 'webmail', 'user_id', 'N', 'N', 'DD', 'Owner', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('webmail', 'webmail', 'folder_id', 'N', 'N', 'DD', 'Folder', 1, '', 'webmail_folders', 'folder_id', 'folder_name', ' order by folder_name', 'N', 'N', 'N', 'N', 'Y', 0, 5, 'grid_left', 1, 'R', '10a0vzsn8jmu5', 6, 'L', '4p3fkv0odpc0', 6, 'L', '1y5hz28trq00c', 3, 3, 0, 'R', '1sauum7g5bvpp', 0, 'L', '', 5),
('webmail', 'webmail', 'mail_size', 'N', 'N', 'DS', 'Size', 1, '0', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 3, 'grid_right', 0, 'L', '', 5, 'L', '4p3fkv0odpc0', 5, 'L', '1y5hz28trq00c', 0, 0, 1, 'R', '1sauum7g5bvpp', 0, 'L', '', 4),
('webmail', 'webmail', 'isread', 'N', 'N', 'CH', 'Mark as Read', 1, 'N', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 1, 'L', '10a0vzsn8jmu5', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('webmail', 'webmail', 'bound', 'N', 'N', 'EN', 'Bound', 1, 'O', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('webmail', 'webmail', 'mail_from', 'N', 'N', 'TE', 'From', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 3, 0, 'grid_left', 0, 'L', '', 1, 'L', '4p3fkv0odpc0', 1, 'L', '1y5hz28trq00c', 2, 2, 1, 'L', '18hnj62icuujr', 1, 'L', 'hqeeu9ndagz8', 2),
('webmail', 'webmail', 'mail_to', 'N', 'N', 'ML', 'To', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 2, 1, 'grid_left', 0, 'L', '', 2, 'L', '4p3fkv0odpc0', 2, 'L', '1y5hz28trq00c', 0, 0, 2, 'L', '18hnj62icuujr', 1, 'L', 'so0e1od7gow', 0),
('webmail', 'webmail', 'reply_to', 'N', 'N', 'ML', 'Reply to', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('webmail', 'webmail', 'mail_cc', 'N', 'N', 'ML', 'Cc', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'R', '4p3fkv0odpc0', 3, 'R', '1y5hz28trq00c', 0, 0, 0, 'L', '18hnj62icuujr', 1, 'L', '20ihjrdym0kkw', 0),
('webmail', 'webmail', 'mail_bcc', 'N', 'N', 'ML', 'Bcc', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', '4p3fkv0odpc0', 2, 'R', '1y5hz28trq00c', 0, 0, 0, 'L', '18hnj62icuujr', 1, 'R', '20ihjrdym0kkw', 0),
('webmail', 'webmail', 'mail_date', 'N', 'N', 'DT', 'Date', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 4, 4, 'grid_center', 0, 'L', '', 1, 'R', '4p3fkv0odpc0', 1, 'R', '1y5hz28trq00c', 0, 4, 1, 'L', '1sauum7g5bvpp', 0, 'L', '', 3),
('webmail', 'webmail', 'type', 'N', 'N', 'TE', 'Type', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('webmail', 'webmail', 'subtype', 'N', 'N', 'TE', 'Subtype', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('webmail', 'webmail', 'encoding', 'N', 'N', 'TE', 'Encoding', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('webmail', 'webmail', 'subject', 'N', 'N', 'VF', 'Subject', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 1, 2, 'grid_left', 0, 'L', '', 3, 'L', '4p3fkv0odpc0', 3, 'L', '1y5hz28trq00c', 1, 1, 1, 'L', 'rdrer50sxy92', 2, 'L', 'hqeeu9ndagz8', 1),
('webmail', 'webmail', 'body_html', 'N', 'N', 'ML', 'Body Html', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '1zf2plhmw6f4s', 1, 'L', '299tuqcldny88', 0, 0, 0, 'L', 'rdrer50sxy92', 3, 'L', 'hqeeu9ndagz8', 0),
('webmail', 'webmail', 'body_text', 'N', 'N', 'ML', 'Body Text', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('webmail', 'webmail', 'priority_id', 'N', 'N', 'DD', 'Priority', 1, '', 'webmail_priorities', 'priority_id', 'priority_name', ' order by priority_sequence', 'N', 'N', 'N', 'N', 'Y', 5, 0, 'grid_left', 0, 'L', '', 4, 'L', '4p3fkv0odpc0', 4, 'L', '1y5hz28trq00c', 0, 0, 0, 'L', '1sauum7g5bvpp', 0, 'L', '', 0),
('administration_users', 'users', 'full_name', 'N', 'N', 'TE', 'Full Name', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_users', 'users', 'send_welcome_email', 'N', 'Y', 'CH', 'Send Welcome Email', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 2, 'L', '13qfxwi7vfi8w', 0, 'L', '', 1, 'L', 'kfpueqebytc0', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('administration_users', 'users', 'reset_password', 'N', 'Y', 'CH', 'Reset password', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 3, 'L', '13qfxwi7vfi8w', 0, 'L', '', 1, 'R', 'kfpueqebytc0', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('administration_applications', 'db_applications', 'app_name', 'N', 'N', 'VF', 'Name', 1, '', '', '', '', '', 'N', 'Y', 'N', 'Y', 'Y', 2, 2, 'grid_left', 0, 'L', '', 1, 'L', '13fcwhijj2ios', 1, 'L', '106c761euqsgg', 2, 2, 1, 'L', 'k9k4i61k3u8s', 1, 'L', '1w39jzlpg2sk', 0),
('administration_applications', 'db_applications', 'app_label', 'N', 'N', 'VF', 'Label', 1, '', '', '', '', '', 'N', 'N', 'Y', 'Y', 'Y', 1, 1, 'grid_left', 0, 'L', '', 1, 'R', '13fcwhijj2ios', 1, 'R', '106c761euqsgg', 1, 1, 1, 'R', 'k9k4i61k3u8s', 1, 'R', '1w39jzlpg2sk', 0),
('administration_applications', 'db_applications', 'app_sequence', 'N', 'N', 'TE', 'Rank', 1, '0', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 7, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 7, 0, 'L', '', 0, 'L', '', 0),
('administration_applications', 'db_applications', 'status_id', 'N', 'N', 'DD', 'Status', 1, '', 'db_applications_statuses', 'status_id', 'status_name', 'where status_id in ("A","D") order by status_name', 'N', 'N', 'N', 'N', 'Y', 3, 3, 'grid_center', 1, 'L', 'sm44cp7zxesw', 1, 'L', '1ig40xsic4m8c', 1, 'L', '2as1279427k0o', 3, 3, 1, 'L', 'rzxxa87wpnkk', 1, 'L', '288vl4ukqon4c', 0),
('administration_applications', 'db_applications', 'table_name', 'N', 'N', 'TE', 'Table Name', 1, '', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', '1ig40xsic4m8c', 2, 'L', '2as1279427k0o', 0, 0, 2, 'L', 'rzxxa87wpnkk', 2, 'L', '288vl4ukqon4c', 0),
('administration_applications', 'db_applications', 'field_name', 'N', 'N', 'TE', 'Field Name', 1, '', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_applications', 'db_applications', 'is_related', 'N', 'N', 'CH', 'Is Related', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_applications', 'db_applications', 'is_visible', 'N', 'N', 'CH', 'Visible', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 4, 4, 'grid_center', 1, 'L', 'bffhd8oycs8', 1, 'R', '1ig40xsic4m8c', 1, 'R', '2as1279427k0o', 4, 4, 1, 'R', 'rzxxa87wpnkk', 1, 'R', '288vl4ukqon4c', 0),
('administration_applications', 'db_applications', 'is_search', 'N', 'N', 'CH', 'Searchable', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 5, 5, 'grid_center', 1, 'R', 'bffhd8oycs8', 2, 'R', '1ig40xsic4m8c', 2, 'R', '2as1279427k0o', 5, 5, 2, 'R', 'rzxxa87wpnkk', 2, 'R', '288vl4ukqon4c', 0),
('administration_applications', 'db_applications', 'is_customizable', 'N', 'N', 'CH', 'Customizable', 1, 'N', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 6, 6, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 6, 6, 0, 'L', '', 0, 'L', '', 0),
('administration_applications', 'db_applications', 'is_report', 'N', 'N', 'CH', 'Is Report', 1, 'N', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_applications', 'db_applications', 'excluded_tabs', 'N', 'N', 'TE', 'Excluded Tabs', 1, '', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_applications', 'db_applications', 'is_quickadd', 'N', 'N', 'CH', 'Is Quickadd', 1, 'N', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0);

INSERT INTO `db_fields` (`app_name`, `table_name`, `field_name`, `is_custom`, `is_computed`, `field_type`, `field_label`, `field_height`, `field_default`, `related_table`, `related_id`, `related_name`, `related_filter`, `is_search`, `is_readonly`, `is_mandatory`, `is_unique`, `is_visible`, `search_sequence`, `result_sequence`, `result_class`, `bulk_sequence`, `bulk_side`, `bulk_block_id`, `view_sequence`, `view_side`, `view_block_id`, `edit_sequence`, `edit_side`, `edit_block_id`, `popup_search_sequence`, `popup_result_sequence`, `popup_view_sequence`, `popup_view_side`, `popup_view_block_id`, `popup_edit_sequence`, `popup_edit_side`, `popup_edit_block_id`, `linked_sequence`) VALUES
('leads', 'leads', 'account_name', 'N', 'N', 'VF', 'Account', 1, '', '', '', '', '', 'Y', 'N', 'Y', 'N', 'Y', 2, 3, 'grid_left', 0, 'L', '', 3, 'L', 'hnxo32h3vci3', 3, 'L', '1sukfl85ljghz', 1, 1, 3, 'L', 'qxr081stazsq', 3, 'L', '2ss50pmw997', 1),
('leads', 'leads', 'rating_id', 'N', 'N', 'DD', 'Rating', 1, '', 'ratings', 'rating_id', 'rating_name', ' order by rating_name', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'R', '10g6nqy7d53q6', 6, 'L', '1twr3rmgzbyts', 0, 0, 0, 'L', '1iw495y761u9p', 0, 'L', '1lrl6g72lmc1s', 0),
('leads', 'leads', 'type_id', 'N', 'N', 'DD', 'Type', 1, '', 'types', 'type_id', 'type_name', ' order by type_name', 'N', 'N', 'N', 'N', 'Y', 3, 7, 'grid_left', 2, 'R', '27k8an0vhzms8', 3, 'R', 'hnxo32h3vci3', 0, 'R', '1sukfl85ljghz', 3, 0, 3, 'R', 'qxr081stazsq', 3, 'R', '2ss50pmw997', 0),
('leads', 'leads', 'industry_id', 'N', 'N', 'DD', 'Industry', 1, '', 'industries', 'industry_id', 'industry_name', ' order by industry_name', 'N', 'N', '', 'N', 'Y', 4, 0, 'grid_left', 0, 'R', '27k8an0vhzms8', 3, 'R', '10g6nqy7d53q6', 7, 'L', '1twr3rmgzbyts', 5, 0, 0, 'L', '1iw495y761u9p', 0, 'R', '1lrl6g72lmc1s', 0),
('leads', 'leads', 'source_id', 'N', 'N', 'DD', 'Source', 1, '', 'sources', 'source_id', 'source_name', ' order by source_name', 'N', 'N', '', 'N', 'Y', 0, 4, 'grid_left', 1, 'R', '27k8an0vhzms8', 6, 'L', '10g6nqy7d53q6', 5, 'L', '1twr3rmgzbyts', 4, 0, 0, 'L', '1iw495y761u9p', 0, 'L', '1lrl6g72lmc1s', 0),
('leads', 'leads', 'user_id', 'N', 'N', 'DD', 'Owner', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', '', 'N', 'Y', 5, 0, 'grid_left', 3, 'R', '27k8an0vhzms8', -1, 'L', '', -1, 'L', '', 8, 6, 0, 'L', '', 0, 'L', '', 8),
('leads', 'leads', 'lead_id', 'N', 'N', 'RK', 'Lead Id', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', -1, -1, 'grid_left', -1, 'L', '', -1, 'L', '', -1, 'L', '', -1, -1, -1, 'L', '', 0, 'L', '', -1),
('leads', 'leads', 'url', 'N', 'N', 'WS', 'Url', 5, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'R', '10g6nqy7d53q6', 5, 'R', '1twr3rmgzbyts', 0, 0, 0, 'R', '1iw495y761u9p', 0, 'R', '1lrl6g72lmc1s', 0),
('leads', 'leads', 'employees', 'N', 'N', 'TE', 'Employees', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 5, 'L', '10g6nqy7d53q6', 8, 'L', '1twr3rmgzbyts', 0, 0, 0, 'L', '1iw495y761u9p', 0, 'L', '1lrl6g72lmc1s', 0),
('leads', 'leads', 'revenue', 'N', 'N', 'CU', 'Revenue', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 5, 'R', '10g6nqy7d53q6', 9, 'L', '1twr3rmgzbyts', 0, 0, 0, 'L', '1iw495y761u9p', 0, 'L', '1lrl6g72lmc1s', 0),
('leads', 'leads', 'first_names', 'N', 'N', 'TE', 'First name', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 1, 'grid_left', 0, 'L', '', 1, 'L', 'hnxo32h3vci3', 1, 'L', '1sukfl85ljghz', 0, 2, 1, 'L', 'qxr081stazsq', 1, 'L', '2ss50pmw997', 2),
('leads', 'leads', 'last_name', 'N', 'N', 'TE', 'Last name', 1, '', '', '', '', '', 'Y', 'N', '', 'N', 'Y', 0, 2, 'grid_left', 0, 'L', '', 1, 'R', 'hnxo32h3vci3', 1, 'R', '1sukfl85ljghz', 2, 3, 1, 'R', 'qxr081stazsq', 1, 'R', '2ss50pmw997', 3),
('leads', 'leads', 'salutation', 'N', 'N', 'TE', 'Salutation', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', 'hnxo32h3vci3', 2, 'L', '1sukfl85ljghz', 0, 0, 2, 'L', 'qxr081stazsq', 2, 'L', '2ss50pmw997', 0),
('leads', 'leads', 'title', 'N', 'N', 'TE', 'Title', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', 'hnxo32h3vci3', 0, 'R', '1sukfl85ljghz', 0, 0, 2, 'R', 'qxr081stazsq', 2, 'R', '2ss50pmw997', 0),
('leads', 'leads', 'email', 'N', 'N', 'WM', 'Email', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 6, 'grid_left', 0, 'L', '', 2, 'L', '10g6nqy7d53q6', 2, 'L', '1twr3rmgzbyts', 0, 5, 2, 'L', '1iw495y761u9p', 2, 'L', '1lrl6g72lmc1s', 5),
('leads', 'leads', 'phone', 'N', 'N', 'TE', 'Phone', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 5, 'grid_left', 0, 'L', '', 1, 'L', '10g6nqy7d53q6', 1, 'L', '1twr3rmgzbyts', 0, 4, 1, 'L', '1iw495y761u9p', 1, 'L', '1lrl6g72lmc1s', 4),
('leads', 'leads', 'mobile', 'N', 'N', 'TE', 'Mobile', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', '10g6nqy7d53q6', 3, 'L', '1twr3rmgzbyts', 0, 0, 3, 'L', '1iw495y761u9p', 3, 'L', '1lrl6g72lmc1s', 0),
('leads', 'leads', 'fax', 'N', 'N', 'TE', 'Fax', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'L', '10g6nqy7d53q6', 4, 'L', '1twr3rmgzbyts', 0, 0, 0, 'R', '1iw495y761u9p', 0, 'L', '1lrl6g72lmc1s', 0),
('leads', 'leads', 'email_opt_out', 'N', 'N', 'CH', 'Email opt out', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 8, 'grid_center', 3, 'L', '27k8an0vhzms8', 2, 'R', '10g6nqy7d53q6', 3, 'R', '1twr3rmgzbyts', 0, 0, 2, 'R', '1iw495y761u9p', 2, 'R', '1lrl6g72lmc1s', 0),
('leads', 'leads', 'do_not_call', 'N', 'N', 'CH', 'Do not call', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 9, 'grid_center', 2, 'L', '27k8an0vhzms8', 1, 'R', '10g6nqy7d53q6', 2, 'R', '1twr3rmgzbyts', 0, 0, 1, 'R', '1iw495y761u9p', 1, 'R', '1lrl6g72lmc1s', 0),
('leads', 'leads', 'address_1', 'N', 'N', 'ML', 'Address', 4, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '1kgs1jxs9g0fd', 1, 'L', '1jzj9uhg5sa09', 0, 0, 1, 'L', '1ixclk3b0oyl3', 1, 'L', '59gxaxc4tmq', 0),
('leads', 'leads', 'zipcode_1', 'N', 'N', 'TE', 'Zipcode', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'R', '1kgs1jxs9g0fd', 3, 'R', '1jzj9uhg5sa09', 0, 0, 3, 'R', '1ixclk3b0oyl3', 3, 'R', '59gxaxc4tmq', 0),
('leads', 'leads', 'city_1', 'N', 'N', 'TE', 'City', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', '1kgs1jxs9g0fd', 1, 'R', '1jzj9uhg5sa09', 0, 0, 1, 'R', '1ixclk3b0oyl3', 1, 'R', '59gxaxc4tmq', 0),
('leads', 'leads', 'state_1', 'N', 'N', 'TE', 'State', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', '1kgs1jxs9g0fd', 2, 'R', '1jzj9uhg5sa09', 6, 7, 2, 'R', '1ixclk3b0oyl3', 2, 'R', '59gxaxc4tmq', 7),
('leads', 'leads', 'country_1', 'N', 'N', 'TE', 'Country', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'R', '1kgs1jxs9g0fd', 4, 'R', '1jzj9uhg5sa09', 7, 0, 4, 'R', '1ixclk3b0oyl3', 4, 'R', '59gxaxc4tmq', 0),
('leads', 'leads', 'note', 'N', 'N', 'ML', 'Note', 4, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', 's3mnwc3p0w75', 1, 'L', '21lwk5jjhciss', 0, 0, 0, 'L', '20jpvv5ec7tws', 0, 'L', '', 0),
('leads', 'leads', 'created', 'N', 'N', 'DT', 'Created', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_center', -1, 'L', '', 0, 'L', '1c7wyt2xu094h', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('leads', 'leads', 'created_by', 'N', 'N', 'DD', 'Created by', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', -1, 'L', '', 0, 'L', '1c7wyt2xu094h', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('leads', 'leads', 'updated', 'N', 'N', 'DT', 'Last Update', 1, '', '', '', '', '', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_center', -1, 'L', '', 0, 'R', '1c7wyt2xu094h', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('leads', 'leads', 'updated_by', 'N', 'N', 'DD', 'Updated by', 1, '', 'users', 'user_id', 'full_name', ' order by full_name', 'N', 'N', '', 'N', 'Y', 0, 0, 'grid_left', -1, 'L', '', 0, 'R', '1c7wyt2xu094h', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('leads', 'leads', 'full_name', 'N', 'N', 'TE', 'Full Name', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 1, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0);

INSERT INTO `db_fields` (`app_name`, `table_name`, `field_name`, `is_custom`, `is_computed`, `field_type`, `field_label`, `field_height`, `field_default`, `related_table`, `related_id`, `related_name`, `related_filter`, `is_search`, `is_readonly`, `is_mandatory`, `is_unique`, `is_visible`, `search_sequence`, `result_sequence`, `result_class`, `bulk_sequence`, `bulk_side`, `bulk_block_id`, `view_sequence`, `view_side`, `view_block_id`, `edit_sequence`, `edit_side`, `edit_block_id`, `popup_search_sequence`, `popup_result_sequence`, `popup_view_sequence`, `popup_view_side`, `popup_view_block_id`, `popup_edit_sequence`, `popup_edit_side`, `popup_edit_block_id`, `linked_sequence`) VALUES
('preferences_lookandfeel', 'users', 'app_name', 'N', 'N', 'DD', 'Default Application', 1, 'api', 'db_applications', 'app_name', 'app_label', 'where is_visible = "Y" and status_id = "A" order by app_label', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', 'd7tbgynjipwg', 1, 'L', '12238nyd9hxc0', 0, 0, 0, 'L', '13z2ehlofjuow', 0, 'L', 'da9w2y9gqxkc', 0),
('preferences_lookandfeel', 'users', 'assistant_id', 'N', 'N', 'RR', 'Assistant', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 1, 'R', '13qfxwi7vfi8w', 0, 'R', '235c8hd439voo', 0, 'R', 'sif2w2u11r4g', 6, 0, 0, 'R', '1cz0xswt9tq84', 0, 'R', 'vhl12f6951c4', 0),
('preferences_lookandfeel', 'users', 'birthdate', 'N', 'N', 'DA', 'Date of birth', 1, '0000-00-00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '1j2a5w3hftwgg', 0, 'L', '1q6htfo3inesk', 0, 0, 0, 'L', '1pz3r2tgoyo0s', 0, 'L', 'sr1hn2m5y684', 0),
('preferences_lookandfeel', 'users', 'confirm_delete', 'N', 'N', 'CH', 'Confirm delete', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '13qfxwi7vfi8w', 3, 'L', 'd7tbgynjipwg', 3, 'L', '12238nyd9hxc0', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('preferences_lookandfeel', 'users', 'created', 'N', 'N', 'TS', 'Created', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '1lhqls5x4yv48', 0, 'L', '1r2irncvnack0', 0, 0, 0, 'L', '1lmo16svlpdwo', 0, 'L', '', 0),
('preferences_lookandfeel', 'users', 'created_by', 'N', 'N', 'RR', 'Created by', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_lookandfeel', 'users', 'currency_id', 'N', 'N', 'DD', 'Currency', 1, 'USD', 'global_currencies', 'currency_id', 'currency_name', ' order by currency_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'R', 'd7tbgynjipwg', 4, 'R', '12238nyd9hxc0', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('preferences_lookandfeel', 'users', 'department_id', 'N', 'N', 'RR', 'Department', 1, '', 'departments', 'department_id', 'department_name', '', 'N', 'N', 'N', 'N', 'Y', 4, 4, 'grid_left', 3, 'R', '13qfxwi7vfi8w', 0, 'R', '235c8hd439voo', 0, 'R', 'sif2w2u11r4g', 4, 4, 0, 'R', '1cz0xswt9tq84', 0, 'R', 'vhl12f6951c4', 4),
('preferences_lookandfeel', 'users', 'email', 'N', 'N', 'WM', 'Email', 1, '', '', '', '', '', 'N', 'N', 'Y', 'Y', 'Y', 0, 7, 'grid_left', 0, 'L', '', 0, 'L', '235c8hd439voo', 0, 'L', 'sif2w2u11r4g', 0, 7, 0, 'L', '1cz0xswt9tq84', 0, 'L', 'vhl12f6951c4', 7),
('preferences_lookandfeel', 'users', 'fax', 'N', 'N', 'TE', 'Fax', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '235c8hd439voo', 0, 'L', 'sif2w2u11r4g', 0, 0, 0, 'L', '1cz0xswt9tq84', 0, 'L', 'vhl12f6951c4', 0),
('preferences_lookandfeel', 'users', 'first_names', 'N', 'N', 'VF', 'First name', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 2, 2, 'grid_left', 0, 'L', '', 0, 'L', '235c8hd439voo', 0, 'L', 'sif2w2u11r4g', 2, 2, 0, 'L', '1cz0xswt9tq84', 0, 'L', 'vhl12f6951c4', 2),
('preferences_lookandfeel', 'users', 'full_name', 'N', 'N', 'TE', 'Full name', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_lookandfeel', 'users', 'is_salespeople', 'N', 'N', 'CH', 'Sales people', 1, 'N', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '13qfxwi7vfi8w', 0, 'R', '235c8hd439voo', 0, 'R', 'sif2w2u11r4g', 0, 0, 0, 'R', '1cz0xswt9tq84', 0, 'R', 'vhl12f6951c4', 0),
('preferences_lookandfeel', 'users', 'language_id', 'N', 'N', 'DD', 'Language', 1, 'en', 'global_languages', 'language_id', 'language_name', ' order by language_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', 'd7tbgynjipwg', 1, 'R', '12238nyd9hxc0', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('preferences_lookandfeel', 'users', 'last_login', 'N', 'N', 'TS', 'Last login', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '1lhqls5x4yv48', 0, 'L', 'kfpueqebytc0', 0, 0, 0, 'L', '1lmo16svlpdwo', 0, 'L', '', 0),
('preferences_lookandfeel', 'users', 'last_name', 'N', 'N', 'VF', 'Last name', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 3, 3, 'grid_left', 0, 'L', '', 0, 'R', '235c8hd439voo', 0, 'R', 'sif2w2u11r4g', 3, 3, 0, 'R', '1cz0xswt9tq84', 0, 'R', 'vhl12f6951c4', 3),
('preferences_lookandfeel', 'users', 'last_password_change', 'N', 'N', 'TS', 'Last password change', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'R', '1lhqls5x4yv48', 0, 'R', 'kfpueqebytc0', 0, 0, 0, 'R', '1lmo16svlpdwo', 0, 'L', '', 0),
('preferences_lookandfeel', 'users', 'locale_id', 'N', 'N', 'DD', 'Locale', 1, 'en_US', 'global_locales', 'locale_id', 'locale_name', ' order by locale_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', 'd7tbgynjipwg', 2, 'R', '12238nyd9hxc0', 0, 0, 0, 'L', '13z2ehlofjuow', 0, 'L', 'da9w2y9gqxkc', 0),
('preferences_lookandfeel', 'users', 'manager_id', 'N', 'N', 'RR', 'Manager', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 2, 'R', '13qfxwi7vfi8w', 0, 'R', '235c8hd439voo', 0, 'R', 'sif2w2u11r4g', 5, 0, 0, 'R', '1cz0xswt9tq84', 0, 'R', 'vhl12f6951c4', 0),
('preferences_lookandfeel', 'users', 'mobile', 'N', 'N', 'TE', 'Mobile', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 6, 'grid_left', 0, 'L', '', 0, 'L', '235c8hd439voo', 0, 'L', 'sif2w2u11r4g', 0, 6, 0, 'L', '1cz0xswt9tq84', 0, 'L', 'vhl12f6951c4', 6),
('preferences_lookandfeel', 'users', 'nbrecords', 'N', 'N', 'DD', 'Lines displayed', 1, '10', 'global_lines', 'line_id', 'line_name', 'order by line_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', 'd7tbgynjipwg', 2, 'L', '12238nyd9hxc0', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_lookandfeel', 'users', 'note', 'N', 'N', 'ML', 'Note', 5, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '294wh86uphj4g', 0, 'L', '1ixcu5lf30asg', 0, 0, 0, 'L', 'cqkdsoiy8hwg', 0, 'L', 'dxofjnamwhs0', 0),
('preferences_lookandfeel', 'users', 'password', 'N', 'N', 'TE', 'Password', 1, '', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_lookandfeel', 'users', 'phone', 'N', 'N', 'TE', 'Phone', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 5, 'grid_left', 0, 'L', '', 0, 'L', '235c8hd439voo', 0, 'L', 'sif2w2u11r4g', 0, 5, 0, 'L', '1cz0xswt9tq84', 0, 'L', 'vhl12f6951c4', 5),
('preferences_lookandfeel', 'users', 'private_email', 'N', 'N', 'WM', 'Private email', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'R', '1j2a5w3hftwgg', 0, 'R', '1q6htfo3inesk', 0, 0, 0, 'R', '1pz3r2tgoyo0s', 0, 'R', 'sr1hn2m5y684', 0),
('preferences_lookandfeel', 'users', 'private_mobile', 'N', 'N', 'TE', 'Private mobile', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'R', '1j2a5w3hftwgg', 0, 'R', '1q6htfo3inesk', 0, 0, 0, 'R', '1pz3r2tgoyo0s', 0, 'R', 'sr1hn2m5y684', 0),
('preferences_lookandfeel', 'users', 'private_phone', 'N', 'N', 'TE', 'Private phone', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '1j2a5w3hftwgg', 0, 'L', '1q6htfo3inesk', 0, 0, 0, 'L', '1pz3r2tgoyo0s', 0, 'L', 'sr1hn2m5y684', 0),
('preferences_lookandfeel', 'users', 'reset_password', 'N', 'Y', 'CH', 'Reset password', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 3, 'L', '13qfxwi7vfi8w', 0, 'L', '', 0, 'R', 'kfpueqebytc0', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('preferences_lookandfeel', 'users', 'salutation', 'N', 'N', 'TE', 'Salutation', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '235c8hd439voo', 0, 'L', 'sif2w2u11r4g', 0, 0, 0, 'L', '1cz0xswt9tq84', 0, 'L', 'vhl12f6951c4', 0),
('preferences_lookandfeel', 'users', 'send_welcome_email', 'N', 'Y', 'CH', 'Send welcome email', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 2, 'L', '13qfxwi7vfi8w', 0, 'L', '', 0, 'L', 'kfpueqebytc0', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('preferences_lookandfeel', 'users', 'status_id', 'N', 'N', 'DD', 'User Status', 1, 'A', 'users_statuses', 'status_id', 'status_name', 'where status_id in ("A","D") order by status_name', 'N', 'N', 'Y', 'N', 'Y', 5, 8, 'grid_left', 1, 'L', '13qfxwi7vfi8w', 0, 'R', '9gba8zpqcnwg', 0, 'R', '1s9mtebmfoo0o', 0, 0, 0, 'R', '1bwu9iw9qois8', 0, 'R', '1lp4pvgw4f8k0', 8),
('preferences_lookandfeel', 'users', 'theme_id', 'N', 'N', 'DD', 'Theme', 1, 'default', 'global_themes', 'theme_id', 'theme_name', ' order by theme_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'L', 'd7tbgynjipwg', 4, 'L', '12238nyd9hxc0', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('preferences_lookandfeel', 'users', 'title', 'N', 'N', 'TE', 'Title', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'R', '235c8hd439voo', 0, 'R', 'sif2w2u11r4g', 0, 0, 0, 'R', '1cz0xswt9tq84', 0, 'R', 'vhl12f6951c4', 0),
('preferences_lookandfeel', 'users', 'updated', 'N', 'N', 'TS', 'Updated', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'R', '1lhqls5x4yv48', 0, 'R', '1r2irncvnack0', 0, 0, 0, 'R', '1lmo16svlpdwo', 0, 'L', '', 0),
('preferences_lookandfeel', 'users', 'updated_by', 'N', 'N', 'RR', 'Updated by', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_lookandfeel', 'users', 'user_id', 'N', 'N', 'RK', 'User identifier', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_lookandfeel', 'users', 'user_name', 'N', 'N', 'VF', 'User name', 1, '', '', '', '', '', 'N', 'N', 'Y', 'Y', 'Y', 1, 1, 'grid_left', 0, 'L', '', 0, 'L', '9gba8zpqcnwg', 0, 'L', '1s9mtebmfoo0o', 1, 1, 0, 'L', '1kfjzfu4tbb4s', 0, 'L', '1op6wuzxu9fo', 1);

INSERT INTO `db_fields` (`app_name`, `table_name`, `field_name`, `is_custom`, `is_computed`, `field_type`, `field_label`, `field_height`, `field_default`, `related_table`, `related_id`, `related_name`, `related_filter`, `is_search`, `is_readonly`, `is_mandatory`, `is_unique`, `is_visible`, `search_sequence`, `result_sequence`, `result_class`, `bulk_sequence`, `bulk_side`, `bulk_block_id`, `view_sequence`, `view_side`, `view_block_id`, `edit_sequence`, `edit_side`, `edit_block_id`, `popup_search_sequence`, `popup_result_sequence`, `popup_view_sequence`, `popup_view_side`, `popup_view_block_id`, `popup_edit_sequence`, `popup_edit_side`, `popup_edit_block_id`, `linked_sequence`) VALUES
('preferences_profile', 'users', 'app_name', 'N', 'N', 'TE', 'App Name', 1, 'api', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'assistant_id', 'N', 'N', 'RR', 'Assistant', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'R', 'tqrgvar474g8', 4, 'R', '1yro7vjsl4ysw', 0, 0, 4, 'R', 'r3wyomxv1m8s', 4, 'R', '1pxj7dkwrcg0', 0),
('preferences_profile', 'users', 'birthdate', 'N', 'N', 'DA', 'Birthdate', 1, '0000-00-00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 4, 'R', '118iuwd6a528g', 4, 'R', '1zf2rc8trag0o', 0, 0, 4, 'R', 'c5mj0n6xfhko', 4, 'R', '2bszdlp7ppes4', 0),
('preferences_profile', 'users', 'confirm_delete', 'N', 'N', 'CH', 'Confirm Delete', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'created', 'N', 'N', 'TS', 'Created', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 2, 'L', '9l8phqq6ujwo', 2, 'L', '26y2hrgd023o8', 0, 0, 0, 'L', '', 0, 'L', 'jzpcz4pef400', 0),
('preferences_profile', 'users', 'created_by', 'N', 'N', 'RR', 'Created By', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'currency_id', 'N', 'N', 'DD', 'Currency', 1, 'USD', 'global_currencies', 'currency_id', 'currency_name', 'order by currency_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'department_id', 'N', 'N', 'RR', 'Department', 1, '', 'departments', 'department_id', 'department_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'email', 'N', 'N', 'WM', 'Email', 1, '', '', '', '', '', 'N', 'N', 'Y', 'Y', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '118iuwd6a528g', 1, 'L', '1zf2rc8trag0o', 0, 0, 1, 'L', 'c5mj0n6xfhko', 1, 'L', '2bszdlp7ppes4', 0),
('preferences_profile', 'users', 'fax', 'N', 'N', 'TE', 'Fax', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'L', '118iuwd6a528g', 4, 'L', '1zf2rc8trag0o', 0, 0, 4, 'L', 'c5mj0n6xfhko', 4, 'L', '2bszdlp7ppes4', 0),
('preferences_profile', 'users', 'first_names', 'N', 'N', 'TE', 'First Names', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', 'tqrgvar474g8', 2, 'L', '1yro7vjsl4ysw', 0, 0, 2, 'L', 'r3wyomxv1m8s', 2, 'L', '1pxj7dkwrcg0', 0),
('preferences_profile', 'users', 'full_name', 'N', 'N', 'TE', 'Full Name', 1, '', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', 'tqrgvar474g8', 0, 'L', '1yro7vjsl4ysw', 0, 0, 0, 'L', 'r3wyomxv1m8s', 0, 'L', '1pxj7dkwrcg0', 0),
('preferences_profile', 'users', 'is_salespeople', 'N', 'N', 'CH', 'Is Salespeople', 1, 'N', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'language_id', 'N', 'N', 'DD', 'Language', 1, 'en', 'global_languages', 'language_id', 'language_name', 'order by language_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'last_login', 'N', 'N', 'TS', 'Last Login', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'L', '9l8phqq6ujwo', 1, 'L', '26y2hrgd023o8', 0, 0, 0, 'L', '', 0, 'L', 'jzpcz4pef400', 0),
('preferences_profile', 'users', 'last_name', 'N', 'N', 'TE', 'Last Name', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', 'tqrgvar474g8', 2, 'R', '1yro7vjsl4ysw', 0, 0, 2, 'R', 'r3wyomxv1m8s', 2, 'R', '1pxj7dkwrcg0', 0),
('preferences_profile', 'users', 'last_password_change', 'N', 'N', 'TS', 'Last Password Change', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'R', '9l8phqq6ujwo', 1, 'R', '26y2hrgd023o8', 0, 0, 0, 'L', '', 0, 'R', 'jzpcz4pef400', 0),
('preferences_profile', 'users', 'locale_id', 'N', 'N', 'DD', 'Locale', 1, 'en_US', '', '', '', ' order by ', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'manager_id', 'N', 'N', 'RR', 'Manager', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'L', 'tqrgvar474g8', 4, 'L', '1yro7vjsl4ysw', 0, 0, 4, 'L', 'r3wyomxv1m8s', 4, 'L', '1pxj7dkwrcg0', 0),
('preferences_profile', 'users', 'mobile', 'N', 'N', 'TE', 'Mobile', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', '118iuwd6a528g', 3, 'L', '1zf2rc8trag0o', 0, 0, 3, 'L', 'c5mj0n6xfhko', 3, 'L', '2bszdlp7ppes4', 0),
('preferences_profile', 'users', 'nbrecords', 'N', 'N', 'TE', 'Nbrecords', 1, '10', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'note', 'N', 'N', 'ML', 'Note', 4, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '9dun4w391wso', 1, 'L', '29pudky0xvtwc', 0, 0, 1, 'L', 'ss9txl6ke6oc', 1, 'L', '1lstr1vwvfogg', 0),
('preferences_profile', 'users', 'password', 'N', 'N', 'TE', 'Password', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'phone', 'N', 'N', 'TE', 'Phone', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', '118iuwd6a528g', 2, 'L', '1zf2rc8trag0o', 0, 0, 2, 'L', 'c5mj0n6xfhko', 2, 'L', '2bszdlp7ppes4', 0),
('preferences_profile', 'users', 'private_email', 'N', 'N', 'TE', 'Private Email', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', '118iuwd6a528g', 1, 'R', '1zf2rc8trag0o', 0, 0, 1, 'R', 'c5mj0n6xfhko', 1, 'R', '2bszdlp7ppes4', 0),
('preferences_profile', 'users', 'private_mobile', 'N', 'N', 'TE', 'Private Mobile', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'R', '118iuwd6a528g', 3, 'R', '1zf2rc8trag0o', 0, 0, 3, 'R', 'c5mj0n6xfhko', 3, 'R', '2bszdlp7ppes4', 0),
('preferences_profile', 'users', 'private_phone', 'N', 'N', 'TE', 'Private Phone', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', '118iuwd6a528g', 2, 'R', '1zf2rc8trag0o', 0, 0, 2, 'R', 'c5mj0n6xfhko', 2, 'R', '2bszdlp7ppes4', 0),
('preferences_profile', 'users', 'salespeople', 'N', 'N', 'CH', 'Salespeople', 1, 'N', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'salutation', 'N', 'N', 'TE', 'Salutation', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', 'tqrgvar474g8', 3, 'L', '1yro7vjsl4ysw', 0, 0, 3, 'L', 'r3wyomxv1m8s', 3, 'L', '1pxj7dkwrcg0', 0),
('preferences_profile', 'users', 'status_id', 'N', 'N', 'DD', 'Status', 1, 'A', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'theme_id', 'N', 'N', 'DD', 'Theme', 1, 'default', '', '', '', ' order by ', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'title', 'N', 'N', 'TE', 'Title', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'R', 'tqrgvar474g8', 3, 'R', '1yro7vjsl4ysw', 0, 0, 3, 'R', 'r3wyomxv1m8s', 3, 'R', '1pxj7dkwrcg0', 0),
('preferences_profile', 'users', 'updated', 'N', 'N', 'TS', 'Updated', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 2, 'R', '9l8phqq6ujwo', 2, 'R', '26y2hrgd023o8', 0, 0, 0, 'L', '', 0, 'R', 'jzpcz4pef400', 0),
('preferences_profile', 'users', 'updated_by', 'N', 'N', 'RR', 'Updated By', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'user_id', 'N', 'N', 'RK', 'User Id', 1, '', '', '', '', '', 'N', 'Y', 'N', 'Y', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', 'tqrgvar474g8', 1, 'R', '1yro7vjsl4ysw', 0, 0, 1, 'R', 'r3wyomxv1m8s', 1, 'R', '1pxj7dkwrcg0', 0),
('preferences_profile', 'users', 'user_name', 'N', 'N', 'TE', 'User Name', 1, '', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', 'tqrgvar474g8', 1, 'L', '1yro7vjsl4ysw', 0, 0, 1, 'L', 'r3wyomxv1m8s', 1, 'L', '1pxj7dkwrcg0', 0),
('preferences_profile', 'users', 'user_status', 'N', 'N', 'CH', 'User Status', 1, 'A', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0);


-- 
-- Table structure for table `db_linked`
-- 

CREATE TABLE `db_linked` (
  `app_name` varchar(50) collate utf8_unicode_ci NOT NULL,
  `table_name` varchar(50) collate utf8_unicode_ci NOT NULL,
  `linked_app_name` varchar(50) collate utf8_unicode_ci NOT NULL,
  `linked_table_name` varchar(50) collate utf8_unicode_ci NOT NULL,
  `linked_record_name` varchar(50) collate utf8_unicode_ci NOT NULL,
  `linked_type` enum('11','1N','N1','NN') collate utf8_unicode_ci NOT NULL default 'NN',
  `linked_app_label` varchar(250) collate utf8_unicode_ci NOT NULL,
  `sequence` int(4) NOT NULL default '0',
  PRIMARY KEY  (`app_name`,`linked_app_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `db_linked`
-- 

INSERT INTO `db_linked` (`app_name`, `table_name`, `linked_app_name`, `linked_table_name`, `linked_record_name`, `linked_type`, `linked_app_label`, `sequence`) VALUES 
('accounts', 'accounts', 'cases', 'cases', 'case_id', 'NN', 'Cases', 5),
('accounts', 'accounts', 'contacts', 'contacts', 'account_id', '1N', 'Contacts', 3),
('accounts', 'accounts', 'accounts', 'accounts', 'account_top_id', '1N', 'Subsidiaries', 2),
('accounts', 'accounts', 'opportunities', 'opportunities', 'account_id', '1N', 'Opportunities', 4),
('accounts', 'accounts', 'documents', 'documents', 'document_id', 'NN', 'Documents', 7),
('accounts', 'accounts', 'activities', 'activities', 'activity_id', 'NN', 'Activities', 1),
('accounts', 'accounts', 'webmail', 'webmail', 'mail_id', 'NN', 'Webmail', 6),
('activities', 'activities', 'documents', 'documents', 'document_id', 'NN', 'Documents', 7),
('activities', 'activities', 'webmail', 'webmail', 'mail_id', 'NN', 'Webmail', 4),
('activities', 'activities', 'cases', 'cases', 'case_id', 'NN', 'Cases', 6),
('activities', 'activities', 'opportunities', 'opportunities', 'opportunity_id', 'NN', 'Opportunities', 5),
('activities', 'activities', 'leads', 'leads', 'lead_id', 'NN', 'Leads', 3),
('activities', 'activities', 'accounts', 'accounts', 'account_id', 'NN', 'Accounts', 1),
('activities', 'activities', 'contacts', 'contacts', 'contact_id', 'NN', 'Contacts', 2),
('campaigns', 'campaigns', 'leads', 'leads', 'lead_id', 'NN', 'Leads', 3),
('campaigns', 'campaigns', 'accounts', 'accounts', 'account_id', 'NN', 'Accounts', 1),
('campaigns', 'campaigns', 'activities', 'activities', 'activity_id', 'NN', 'Activities', 4),
('campaigns', 'campaigns', 'contacts', 'contacts', 'contact_id', 'NN', 'Contacts', 2),
('campaigns', 'campaigns', 'documents', 'documents', 'document_id', 'NN', 'Documents', 7),
('campaigns', 'campaigns', 'opportunities', 'opportunities', 'opportunity_id', 'NN', 'Opportunities', 6),
('campaigns', 'campaigns', 'webmail', 'webmail', 'mail_id', 'NN', 'Webmail', 5),
('campaigns_lists', 'campaigns_lists', 'campaigns', 'campaigns', 'list_id', '1N', 'Campaigns', 0),
('campaigns_records', 'campaigns_records_view', 'campaigns_lists', 'campaigns_lists', 'list_id', '11', 'Campaign Lists', 1),
('cases', 'cases', 'documents', 'documents', 'document_id', 'NN', 'Documents', 1),
('cases', 'cases', 'activities', 'activities', 'activity_id', 'NN', 'Activities', 5),
('cases', 'cases', 'webmail', 'webmail', 'mail_id', 'NN', 'Webmail', 6),
('cases', 'cases', 'accounts', 'accounts', 'account_id', 'NN', 'Accounts', 3),
('cases', 'cases', 'contacts', 'contacts', 'contact_id', 'NN', 'Contacts', 2),
('cases', 'cases', 'opportunities', 'opportunities', 'opportunity_id', 'NN', 'Opportunities', 7),
('cases', 'cases', 'leads', 'leads', 'lead_id', 'NN', 'Leads', 4),
('contacts', 'contacts', 'documents', 'documents', 'document_id', 'NN', 'Documents', 1),
('contacts', 'contacts', 'opportunities', 'opportunities', 'opportunity_id', 'NN', 'Opportunities', 2),
('contacts', 'contacts', 'accounts', 'accounts', 'account_id', '11', 'Accounts', 0),
('contacts', 'contacts', 'activities', 'activities', 'activity_id', 'NN', 'Activities', 0),
('contacts', 'contacts', 'cases', 'cases', 'case_id', 'NN', 'Cases', 0),
('contacts', 'contacts', 'contacts', 'contacts', 'manager_id', '1N', 'Subordinates', 4),
('contacts', 'contacts', 'webmail', 'webmail', 'mail_id', 'NN', 'Webmail', 3),
('documents', 'documents', 'accounts', 'accounts', 'account_id', 'NN', 'Accounts', 2),
('documents', 'documents', 'activities', 'activities', 'activity_id', 'NN', 'Activities', 1),
('documents', 'documents', 'opportunities', 'opportunities', 'opportunity_id', 'NN', 'Opportunities', 6),
('documents', 'documents', 'cases', 'cases', 'case_id', 'NN', 'Cases', 5),
('documents', 'documents', 'contacts', 'contacts', 'contact_id', 'NN', 'Contacts', 3),
('documents', 'documents', 'leads', 'leads', 'lead_id', 'NN', 'Leads', 4),
('leads', 'leads', 'activities', 'activities', 'activity_id', 'NN', 'Activities', 2),
('leads', 'leads', 'documents', 'documents', 'document_id', 'NN', 'Documents', 5),
('leads', 'leads', 'webmail', 'webmail', 'mail_id', 'NN', 'Webmail', 3),
('leads', 'leads', 'opportunities', 'opportunities', 'opportunity_id', 'NN', 'Opportunities', 4),
('leads', 'leads', 'cases', 'cases', 'case_id', 'NN', 'Cases', 1),
('opportunities', 'opportunities', 'activities', 'activities', 'activity_id', 'NN', 'Activities', 2),
('opportunities', 'opportunities', 'documents', 'documents', 'document_id', 'NN', 'Documents', 7),
('opportunities', 'opportunities', 'webmail', 'webmail', 'mail_id', 'NN', 'Webmail', 5),
('opportunities', 'opportunities', 'cases', 'cases', 'case_id', 'NN', 'Cases', 3),
('opportunities', 'opportunities', 'contacts', 'contacts', 'contact_id', 'NN', 'Contacts', 4),
('opportunities', 'opportunities', 'leads', 'leads', 'lead_id', 'NN', 'Leads', 6),
('opportunities', 'opportunities', 'accounts', 'accounts', 'account_id', '11', 'Accounts', 1),
('webmail', 'webmail', 'leads', 'leads', 'lead_id', 'NN', 'Leads', 1),
('webmail', 'webmail', 'contacts', 'contacts', 'contact_id', 'NN', 'Contacts', 3),
('webmail', 'webmail', 'cases', 'cases', 'case_id', 'NN', 'Cases', 5),
('webmail', 'webmail', 'activities', 'activities', 'activity_id', 'NN', 'Activities', 6),
('webmail', 'webmail', 'accounts', 'accounts', 'account_id', 'NN', 'Accounts', 2);

-- --------------------------------------------------------


-- 
-- Table structure for table `db_lookups`
-- 

CREATE TABLE `db_lookups` (
  `table_name` varchar(50) collate utf8_unicode_ci NOT NULL,
  `table_label` varchar(250) collate utf8_unicode_ci NOT NULL,
  `app_name` varchar(50) collate utf8_unicode_ci NOT NULL,
  `class_name` varchar(50) collate utf8_unicode_ci NOT NULL,
  `is_custom` enum('Y','N') collate utf8_unicode_ci NOT NULL default 'N',
  `is_customizable` enum('Y','N') collate utf8_unicode_ci NOT NULL default 'N',
  `lookup_id` varchar(50) collate utf8_unicode_ci NOT NULL,
  `lookup_name` varchar(50) collate utf8_unicode_ci NOT NULL,
  `lookup_value` varchar(250) collate utf8_unicode_ci NOT NULL,
  `lookup_comment` varchar(250) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`table_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `db_lookups`
-- 

INSERT INTO `db_lookups` (`table_name`, `table_label`, `app_name`, `class_name`, `is_custom`, `is_customizable`, `lookup_id`, `lookup_name`, `lookup_value`, `lookup_comment`) VALUES 
('activities_priorities', 'Priority - Activities', '', '', 'N', 'Y', 'priority_id', 'priority_name', '', 'Identifiers are unique values associated with Labels'),
('activities_statuses', 'Status - Activities', '', '', 'N', 'Y', 'status_id', 'status_name', 'is_open', 'Value represents wether or not the record is an open activity, it must be Y or N'),
('activities_types', 'Type - Activities', '', '', 'N', 'Y', 'type_id', 'type_name', '', 'Identifiers are unique values associated with Labels'),
('campaigns_lists', 'Campaigns - Lists', '', '', 'N', 'N', 'list_id', 'list_name', '', ''),
('campaigns_lists_statuses', 'Status - Lists, List Records', '', '', 'N', 'Y', 'status_id', 'status_name', '', 'Identifiers are unique values associated with Labels'),
('campaigns_records_types', 'Type - Campaigns List Records', '', '', 'N', 'N', 'type_id', 'type_name', '', 'Identifiers are unique values associated with Labels'),
('campaigns_statuses', 'Status - Campaigns', '', '', 'N', 'Y', 'status_id', 'status_name', '', 'Identifiers are unique values associated with Labels'),
('campaigns_types', 'Type - Campaigns', '', '', 'N', 'Y', 'type_id', 'type_name', '', 'Identifiers are unique values associated with Labels'),
('cases_priorities', 'Priority - Cases', '', '', 'N', 'Y', 'priority_id', 'priority_name', '', 'Identifiers are unique values associated with Labels'),
('cases_statuses', 'Status - Cases', '', '', 'N', 'Y', 'status_id', 'status_name', '', 'Identifiers are unique values associated with Labels'),
('global_editions', 'Editions', '', '', 'N', 'N', 'edition_id', 'edition_name', '', ''),
('industries', 'Industries', '', '', 'N', 'Y', 'industry_id', 'industry_name', '', 'Identifiers are unique values associated with Labels'),
('periods', 'Periods', '', '', 'N', 'N', 'period_id', 'period_name', '', 'The Value field represents the percentage of the tax. It must be a numeric value'),
('ratings', 'Ratings - Accounts', '', '', 'N', 'Y', 'rating_id', 'rating_name', '', 'Identifiers are unique values associated with Labels'),
('reports_types', 'Type - Reports', '', '', 'N', 'Y', 'type_id', 'type_name', '', 'Identifiers are unique values associated with Labels'),
('sources', 'Source - Accounts, Leads', '', '', 'N', 'Y', 'source_id', 'source_name', '', 'Identifiers are unique values associated with Labels'),
('stages', 'Stage - Opportunities', '', '', 'N', 'Y', 'stage_id', 'stage_name', '', 'The Identifier field represents the Probability, or level of confidence the business will be won'),
('types', 'Type - Accounts, Contacts, Leads', '', '', 'N', 'Y', 'type_id', 'type_name', '', 'Identifiers are unique values associated with Labels'),
('users', 'User', '', 'administration.users', 'N', 'N', 'user_id', 'full_name', '', 'Identifiers are unique values associated with Labels'),
('webmail_folders', 'Folder - Web mail', '', '', 'N', 'N', 'folder_id', 'folder_name', '', ''),
('webmail_priorities', 'Priority - Webmail', '', '', 'N', 'Y', 'priority_id', 'priority_name', '', ''),
('global_countries', 'Countries', '', '', 'N', 'N', 'country_id', 'country_name', '', ''),
('departments', 'Departments', '', '', 'N', 'Y', 'department_id', 'department_name', '', 'Identifiers are unique values associated with Labels');

-- --------------------------------------------------------

-- 
-- Table structure for table `dropdownlists`
-- 

DROP TABLE IF EXISTS `dropdownlists`;

-- --------------------------------------------------------

-- 
-- Table structure for table `editions`
-- 

DROP TABLE IF EXISTS `editions`;
CREATE TABLE IF NOT EXISTS `editions` (
  `edition_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `edition_name` varchar(250) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`edition_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `editions`
-- 

INSERT INTO `editions` (`edition_id`, `edition_name`) VALUES 
('BACKOFFICE', 'Backoffice Edition'),
('BETA', 'Beta Edition'),
('CUSTOM', 'Custom Edition'),
('DEV', 'Development Edition'),
('FRE', 'Free Edition'),
('PRE', 'Premium Edition'),
('PRO', 'Professional Edition'),
('TRIAL', 'Professional Edition 30 day trial'),
('PROTRIAL', 'Professional Edition 30 day trial'),
('PRETRIAL', 'Premium Edition 30 day trial');

-- --------------------------------------------------------

-- 
-- Table structure for table `editions_applications`
-- 

DROP TABLE IF EXISTS `editions_applications`;
CREATE TABLE IF NOT EXISTS `editions_applications` (
  `edition_id` varchar(13) collate utf8_unicode_ci NOT NULL default '',
  `app_name` varchar(50) collate utf8_unicode_ci NOT NULL default '',
  PRIMARY KEY  (`edition_id`,`app_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `editions_applications`
-- 

INSERT INTO `editions_applications` (`edition_id`, `app_name`) VALUES 
('BETA', 'accounts'),
('BETA', 'activities'),
('BETA', 'administration'),
('BETA', 'base'),
('BETA', 'api'),
('BETA', 'calendar'),
('BETA', 'campaigns'),
('BETA', 'cases'),
('BETA', 'contacts'),
('BETA', 'dashboards'),
('BETA', 'documents'),
('BETA', 'forecasts'),
('BETA', 'leads'),
('BETA', 'opportunities'),
('BETA', 'preferences'),
('BETA', 'reports'),
('BETA', 'weather'),
('BETA', 'webmail'),
('DEV', 'accounts'),
('DEV', 'activities'),
('DEV', 'administration'),
('DEV', 'base'),
('DEV', 'api'),
('DEV', 'calendar'),
('DEV', 'campaigns'),
('DEV', 'cases'),
('DEV', 'contacts'),
('DEV', 'dashboards'),
('DEV', 'documents'),
('DEV', 'forecasts'),
('DEV', 'leads'),
('DEV', 'opportunities'),
('DEV', 'preferences'),
('DEV', 'reports'),
('DEV', 'weather'),
('DEV', 'webmail'),
('PRE', 'accounts'),
('PRE', 'activities'),
('PRE', 'administration'),
('PRE', 'base'),
('PRE', 'api'),
('PRE', 'calendar'),
('PRE', 'campaigns'),
('PRE', 'cases'),
('PRE', 'contacts'),
('PRE', 'dashboards'),
('PRE', 'documents'),
('PRE', 'forecasts'),
('PRE', 'leads'),
('PRE', 'opportunities'),
('PRE', 'preferences'),
('PRE', 'reports'),
('PRE', 'weather'),
('PRE', 'webmail'),
('PRO', 'accounts'),
('PRO', 'activities'),
('PRO', 'administration'),
('PRO', 'base'),
('PRO', 'api'),
('PRO', 'campaigns'),
('PRO', 'cases'),
('PRO', 'contacts'),
('PRO', 'dashboards'),
('PRO', 'documents'),
('PRO', 'forecasts'),
('PRO', 'leads'),
('PRO', 'opportunities'),
('PRO', 'preferences'),
('PRO', 'reports'),
('PRO', 'weather'),
('PRO', 'webmail'),
('TRIAL', 'accounts'),
('TRIAL', 'activities'),
('TRIAL', 'administration'),
('TRIAL', 'base'),
('TRIAL', 'api'),
('TRIAL', 'calendar'),
('TRIAL', 'campaigns'),
('TRIAL', 'cases'),
('TRIAL', 'contacts'),
('TRIAL', 'dashboards'),
('TRIAL', 'documents'),
('TRIAL', 'forecasts'),
('TRIAL', 'leads'),
('TRIAL', 'opportunities'),
('TRIAL', 'preferences'),
('TRIAL', 'reports'),
('TRIAL', 'weather'),
('TRIAL', 'webmail');

-- --------------------------------------------------------

-- 
-- Table structure for table `emailer`
-- 

DROP TABLE IF EXISTS `emailer`;
CREATE TABLE IF NOT EXISTS `emailer` (
  `from` varchar(128) collate utf8_unicode_ci NOT NULL default '',
  `fromname` varchar(100) collate utf8_unicode_ci NOT NULL default '',
  `username` varchar(128) collate utf8_unicode_ci NOT NULL default '',
  `password` varchar(64) collate utf8_unicode_ci NOT NULL default '',
  `mailer` varchar(10) collate utf8_unicode_ci NOT NULL default '',
  `protocol` varchar(10) collate utf8_unicode_ci NOT NULL,
  `host` varchar(128) collate utf8_unicode_ci NOT NULL default '',
  `port` varchar(10) collate utf8_unicode_ci NOT NULL default '',
  `auth` enum('Y','N') collate utf8_unicode_ci NOT NULL default 'Y',
  PRIMARY KEY  (`from`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `emailer`
-- 

INSERT INTO `emailer` (`from`, `fromname`, `username`, `password`, `mailer`, `protocol`, `host`, `port`, `auth`) VALUES 
('webmaster@appshore.com', 'AppShore Inc', 'mailer@appshore.com', 'TNNqYT9U1Vc=', 'gmail', 'ssl', 'smtp.gmail.com', '465', 'Y');

-- --------------------------------------------------------

-- 
-- Table structure for table `industries`
-- 

DROP TABLE IF EXISTS `industries`;
CREATE TABLE IF NOT EXISTS `industries` (
  `industry_id` varchar(13) collate utf8_unicode_ci NOT NULL default '',
  `industry_name` varchar(50) collate utf8_unicode_ci NOT NULL default '',
  PRIMARY KEY  (`industry_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `industries`
-- 

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

-- --------------------------------------------------------

-- 
-- Table structure for table `languages`
-- 

DROP TABLE IF EXISTS `languages`;
CREATE TABLE IF NOT EXISTS `languages` (
  `language_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `language_name` varchar(50) collate utf8_unicode_ci NOT NULL default '',
  `language_direction` enum('ltr','rtl') collate utf8_unicode_ci NOT NULL default 'ltr',
  `is_available` enum('Y','N') collate utf8_unicode_ci NOT NULL default 'N',
  PRIMARY KEY  (`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `languages`
-- 

INSERT INTO `languages` (`language_id`, `language_name`, `language_direction`, `is_available`) VALUES 
('en', 'English', 'ltr', 'Y'),
('fr', 'Français - French', 'ltr', 'Y'),
('zh-CN', '中文 - Chinese (simplified)', 'ltr', 'Y'),
('ar', 'العربية - Arabic', 'rtl', 'N');

-- --------------------------------------------------------

-- 
-- Table structure for table `lines`
-- 

DROP TABLE IF EXISTS `lines`;
CREATE TABLE IF NOT EXISTS `lines` (
  `line_id` tinyint(4) NOT NULL,
  `line_name` tinyint(4) NOT NULL,
  PRIMARY KEY  (`line_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `lines`
-- 

INSERT INTO `lines` (`line_id`, `line_name`) VALUES 
(5, 5),
(10, 10),
(15, 15),
(20, 20),
(25, 25),
(30, 30),
(35, 35),
(40, 40),
(45, 45),
(50, 50);

-- --------------------------------------------------------

-- 
-- Table structure for table `locales`
-- 

DROP TABLE IF EXISTS `locales`;
CREATE TABLE IF NOT EXISTS `locales` (
  `locale_id` varchar(5) collate utf8_unicode_ci NOT NULL default '',
  `locale_name` varchar(50) collate utf8_unicode_ci NOT NULL default '',
  `is_available` enum('Y','N') collate utf8_unicode_ci NOT NULL default 'N',
  PRIMARY KEY  (`locale_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `locales`
-- 

INSERT INTO `locales` (`locale_id`, `locale_name`, `is_available`) VALUES 
('en_US', 'English (United States)', 'Y'),
('fr_FR', 'Français - French', 'Y'),
('en_GB', 'English (United Kingdom)', 'Y'),
('de_DE', 'Deutsch - German', 'N'),
('sv_SE', 'Swedish', 'N'),
('es_ES', 'Espanol - Spanish', 'N'),
('it_IT', 'Italiano - Italian', 'N'),
('nl_NL', 'Dutch', 'N'),
('fi_FI', 'Suomi - Finnish', 'N'),
('no_NO', 'Norge - Norwegian', 'N'),
('en_SG', 'Singapore', 'N');

-- --------------------------------------------------------

-- 
-- Table structure for table `months`
-- 

DROP TABLE IF EXISTS `months`;
CREATE TABLE IF NOT EXISTS `months` (
  `month_id` tinyint(4) NOT NULL,
  `month_name` varchar(50) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`month_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `months`
-- 

INSERT INTO `months` (`month_id`, `month_name`) VALUES 
(1, 'January'),
(2, 'February'),
(3, 'March'),
(4, 'April'),
(5, 'May'),
(6, 'June'),
(7, 'July'),
(8, 'August'),
(9, 'September'),
(10, 'October'),
(11, 'November'),
(12, 'December');

--
-- Table structure for table `notifications_fields`
--

DROP TABLE IF EXISTS `notifications_fields`;
CREATE TABLE IF NOT EXISTS `notifications_fields` (
  `field_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `field_label` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `lookup_source` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `lookup_target` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`field_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `notifications_fields`
--

INSERT INTO `notifications_fields` (`field_name`, `field_label`, `lookup_source`, `lookup_target`) VALUES
('account_name', 'Company name', '', ''),
('email', 'Email', '', ''),
('first_names', 'First name', '', ''),
('full_name', 'Full name', '', ''),
('last_name', 'Last name', '', ''),
('link', 'Link to record', '', ''),
('mobile', 'Mobile', '', ''),
('note', 'Note', '', ''),
('phone', 'Phone', '', ''),
('salutation', 'Salutation', '', ''),
('subject', 'Subject', '', ''),
('timestamp', 'Timestamp', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `notifications_periods`
--

DROP TABLE IF EXISTS `notifications_periods`;
CREATE TABLE IF NOT EXISTS `notifications_periods` (
  `period_id` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `period_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `period_sequence` int(11) NOT NULL,
  PRIMARY KEY (`period_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `notifications_periods`
--

INSERT INTO `notifications_periods` (`period_id`, `period_name`, `period_sequence`) VALUES
('M', 'minutes', 1),
('H', 'hours', 2),
('D', 'days', 3),
('W', 'weeks', 4);

-- --------------------------------------------------------

--
-- Table structure for table `notifications_statuses`
--

DROP TABLE IF EXISTS `notifications_statuses`;
CREATE TABLE IF NOT EXISTS `notifications_statuses` (
  `status_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `status_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`status_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `notifications_statuses`
--

INSERT INTO `notifications_statuses` (`status_id`, `status_name`) VALUES
('A', 'Activated'),
('D', 'Deactivated'),
('N', 'Notified'),
('T', 'Timed');

-- --------------------------------------------------------

--
-- Table structure for table `notifications_types`
--

DROP TABLE IF EXISTS `notifications_types`;
CREATE TABLE IF NOT EXISTS `notifications_types` (
  `type_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `type_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `notifications_types`
--

INSERT INTO `notifications_types` (`type_id`, `type_name`) VALUES
('E', 'Email'),
('P', 'popup');

--
-- Table structure for table `opportunities_recurring`
--

CREATE TABLE `opportunities_recurring` (
  `recurring_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `recurring_name` varchar(250) collate utf8_unicode_ci NOT NULL,
  `recurring_sequence` int(4) NOT NULL default 0,
  PRIMARY KEY  (`recurring_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `opportunities_recurring`
-- 

INSERT INTO `opportunities_recurring` (`recurring_id`, `recurring_name`, `recurring_sequence`) VALUES 
('Daily', 'Daily', 1),
('Weekly', 'Weekly', 2),
('Monthly', 'Monthly', 3),
('Quarterly', 'Quarterly', 4),
('Yearly', 'Yearly', 5);

-- 
-- Table structure for table `periods`
-- 

CREATE TABLE `periods` (
  `period_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `period_name` varchar(50) collate utf8_unicode_ci NOT NULL,
  `period_sequence` int(4) NOT NULL default '0',
  KEY `period_sequence` (`period_sequence`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `periods`
-- 

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

-- --------------------------------------------------------

-- 
-- Table structure for table `ratings`
-- 

CREATE TABLE `ratings` (
  `rating_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `rating_name` varchar(250) collate utf8_unicode_ci NOT NULL,
  `rating_sequence` int(4) NOT NULL default 0,
  PRIMARY KEY  (`rating_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `ratings`
-- 

INSERT INTO `ratings` (`rating_id`, `rating_name`, `rating_sequence`) VALUES 
('Unknown', 'Unknown', 1),
('Avoid', 'Avoid', 2),
('Poor', 'Poor', 3),
('Fair', 'Fair', 4),
('Good', 'Good', 5),
('Excellent', 'Excellent', 6);

-- 
-- Table structure for table `roles_statuses`
-- 

CREATE TABLE `roles_statuses` (
  `status_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `status_name` varchar(250) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`status_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `roles_statuses`
-- 

INSERT INTO `roles_statuses` (`status_id`, `status_name`) VALUES 
('A', 'Activated'),
('D', 'Deactivated');

-- --------------------------------------------------------

-- 
-- Table structure for table `shop_products`
-- 

DROP TABLE IF EXISTS `shop_products`;
CREATE TABLE IF NOT EXISTS `shop_products` (
  `product_id` varchar(32) collate utf8_unicode_ci NOT NULL default '0',
  `main_product_id` varchar(32) collate utf8_unicode_ci default NULL,
  `product_name` varchar(250) collate utf8_unicode_ci NOT NULL,
  `description` longtext collate utf8_unicode_ci,
  `status` char(1) collate utf8_unicode_ci NOT NULL default 'A',
  `mininum` int(11) NOT NULL default '0',
  `maximum` int(11) NOT NULL default '-1',
  `price` int(11) NOT NULL default '0',
  `period` varchar(50) collate utf8_unicode_ci NOT NULL,
  `metric` varchar(50) collate utf8_unicode_ci NOT NULL,
  `currency_id` char(3) collate utf8_unicode_ci NOT NULL default 'USD',
  `sequence` int(11) NOT NULL default '0',
  `category` varchar(5) collate utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_by` varchar(32) collate utf8_unicode_ci NOT NULL default '0',
  `updated` datetime NOT NULL default '0000-00-00 00:00:00',
  `updated_by` varchar(32) collate utf8_unicode_ci NOT NULL default '0',
  PRIMARY KEY  (`product_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `shop_products`
-- 

INSERT INTO `shop_products` (`product_id`, `main_product_id`, `product_name`, `description`, `status`, `mininum`, `maximum`, `price`, `period`, `metric`, `currency_id`, `sequence`, `category`, `created`, `created_by`, `updated`, `updated_by`) VALUES 
('FRE', '0', 'AppShore Free Edition', 'AppShore Free Edition', 'D', 10, 0, 0, 'per month', 'per company', 'USD', 0, 'FRE', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0'),
('PRO-MONTHLY', '0', 'AppShore Professional Edition, monthly subscription', '<ul>		\r\n<li>Leads and web lead capture</li>					\r\n<li>Contacts</li>\r\n<li>Accounts</li>\r\n<li>Opportunities</li>	\r\n<li>Activities</li>									<li>Forecasts</li>\r\n<li>Dashboard</li>\r\n<li>Document Management</li>						\r\n<li>Cases</li>										<li>Email Marketing</li>\r\n<li>Customizable Logo and Menus</li>	\r\n<li>Customizable Drop Down Lists</li>	\r\n<li>Customizable Reports</li>	\r\n<li>Outbound Web Mail</li>								</ul>', 'A', 1, -1, 12, 'per month', 'per user', 'USD', 1, 'PRO', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0'),
('PRE-MONTHLY-USER', 'PRE-MONTHLY', 'Users, monthly subscription', '<ul>\r\n<li>Each user comes with 512 MB of disk space</li>\r\n</ul>\r\n', 'A', 1, -1, 24, 'per month', 'per user', 'USD', 10, 'PRO', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0'),
('PRO-MONTHLY-USER', 'PRO-MONTHLY', 'Users, monthly subscription', '<ul>\r\n<li>Each user comes with 512 MB of disk space</li>\r\n</ul>\r\n', 'A', 1, -1, 12, 'per month', 'per user', 'USD', 2, 'PRO', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0'),
('PRO-YEARLY', '0', 'AppShore Professional Edition, yearly subscription, 2 months free', '<ul>\r\n<li>Subscribe for one year and save 2 months!</li>\r\n</ul>', 'A', 1, -1, 120, 'per year', 'per user', 'USD', 2, 'PRO', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0'),
('PRO-YEARLY-USER', 'PRO-YEARLY', 'Users', '<ul>\r\n<li>Each user comes with 512 MB of disk space</li>\r\n</ul>\r\n', 'A', 1, -1, 120, 'per year', 'per user', 'USD', 2, 'PRO', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0'),
('PRE-YEARLY-USER', 'PRE-YEARLY', 'Users', '<ul>\r\n<li>Each user comes with 512 MB of disk space</li>\r\n</ul>\r\n', 'A', 1, -1, 240, 'per year', 'per user', 'USD', 2, 'PRE', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0'),
('PRE-MONTHLY', '0', 'AppShore Premium Edition, monthly subscription', '<ul>		\r\n<li>All Features of Professional Edition</li>						\r\n<li>Customizable Forms and Fields</li>	\r\n<li>Shared Calendar</li>\r\n<li>Advanced List Management</li>\r\n</ul>', 'A', 1, -1, 24, 'per month', 'per user', 'USD', 3, 'PRE', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0'),
('PRE-YEARLY', '0', 'AppShore Premium Edition, yearly subscription, 2 months free', '<ul>\r\n<li>Subscribe for one year and save 2 months!</li>\r\n</ul>', 'A', 1, -1, 240, 'per year', 'per user', 'USD', 4, 'PRE', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');

-- --------------------------------------------------------

-- 
-- Table structure for table `sources`
-- 

CREATE TABLE `sources` (
  `source_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `source_name` varchar(250) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`source_id`),
  UNIQUE KEY `source_name` (`source_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `sources`
-- 

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

-- --------------------------------------------------------

-- 
-- Table structure for table `types`
-- 

CREATE TABLE `types` (
  `type_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `type_name` varchar(250) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `types`
-- 

INSERT INTO `types` (`type_id`, `type_name`) VALUES 
('Lead', 'Lead'),
('Prospect', 'Prospect'),
('Customer', 'Customer'),
('Closed', 'Closed'),
('Partner', 'Partner'),
('Supplier', 'Supplier'),
('Competitor', 'Competitor');

-- --------------------------------------------------------

-- 
-- Table structure for table `statuses`
-- 

DROP TABLE IF EXISTS `statuses`;
CREATE TABLE IF NOT EXISTS `statuses` (
  `status_id` varchar(13) collate utf8_unicode_ci NOT NULL default '',
  `status_name` varchar(50) collate utf8_unicode_ci NOT NULL default '',
  PRIMARY KEY  (`status_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `statuses`
-- 

INSERT INTO `statuses` (`status_id`, `status_name`) VALUES 
('1', 'Lead'),
('2', 'Prospect'),
('3', 'Customer'),
('4', 'Closed'),
('5', 'Partner'),
('6', 'Supplier'),
('7', 'Competitor');

-- --------------------------------------------------------

-- 
-- Table structure for table `themes`
-- 

DROP TABLE IF EXISTS `themes`;
CREATE TABLE IF NOT EXISTS `themes` (
  `theme_id` varchar(20) collate utf8_unicode_ci NOT NULL default '',
  `theme_name` varchar(50) collate utf8_unicode_ci NOT NULL default '',
  `is_available` enum('Y','N') collate utf8_unicode_ci NOT NULL default 'N',
  PRIMARY KEY  (`theme_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `themes`
-- 

INSERT INTO `themes` (`theme_id`, `theme_name`, `is_available`) VALUES 
('default', 'Light Blue (default)', 'Y'),
('browngreen', 'Brown and Green', 'Y'),
('lightbrown', 'Light Brown', 'Y'),
('orangeblue', 'Orange Blue', 'Y'),
('darksand', 'Dark Sand', 'Y'),
('bluenote', 'Blue Note', 'Y'),
('absinthe', 'Absinthe', 'Y'),
('mahogany', 'Mahogany', 'Y'),
('citrus', 'Citrus', 'Y'),
('cranberry', 'Cranberry', 'Y'),
('alpine', 'Alpine', 'Y'),
('aqua', 'Aqua', 'Y'),
('clay', 'Clay', 'Y'),
('dawn', 'Dawn', 'Y'),
('eggplant', 'Eggplant', 'Y'),
('berry', 'Berry', 'Y'),
('navyblue', 'Navy blue', 'Y'),
('greenblue', 'Green blue', 'Y'),
('wine', 'Wine', 'Y'),
('grove', 'Grove', 'Y'),
('mist', 'Mist', 'Y'),
('brown', 'Brown', 'Y'),
('heather', 'Heather', 'Y'),
('waterfall', 'Waterfall', 'Y'),
('cavern', 'Cavern', 'Y'),
('fields', 'Fields', 'Y'),
('twilight', 'Twilight', 'Y'),
('crocus', 'Crocus', 'Y'),
('desert', 'Desert', 'Y'),
('spice', 'Spice', 'Y');

-- --------------------------------------------------------


-- 
-- Table structure for table `translation`
-- 

DROP TABLE IF EXISTS `translation`;
CREATE TABLE IF NOT EXISTS `translation` (
  `phrase` varchar(250) collate utf8_unicode_ci NOT NULL default '',
  `en` varchar(250) collate utf8_unicode_ci NOT NULL default '',
  `fr` varchar(250) collate utf8_unicode_ci NOT NULL default '',
  `zh-CN` varchar(250) collate utf8_unicode_ci NOT NULL,
  `ar` varchar(250) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`phrase`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci PACK_KEYS=0;

-- 
-- Dumping data for table `translation`
-- 

INSERT INTO `translation` (`phrase`, `en`, `fr`, `zh-CN`, `ar`) VALUES 
('Account', 'Account', 'Compte', '帐户名称', 'تقرير'),
('Account Number', 'Account Number', 'Compte N°', '帐户数', 'رقم الحساب'),
('Accounts', 'Accounts', 'Comptes', '帐户', 'تقارير'),
('Action', 'Action', 'Action', 'Action', 'Action'),
('Activate', 'Activate', 'Activer', 'Activate', 'Activate'),
('Activate applications', 'Activate applications', 'Activer applications', 'Activate applications', 'Activate applications'),
('Activate roles', 'Activate roles', 'Activer rôles', 'Activate roles', 'Activate roles'),
('Activate users', 'Activate users', 'Activer utilisateurs', 'Activate users', 'Activate users'),
('Activated', 'Activated', 'Activé', 'Activated', 'Activated'),
('Activated applications', 'Activated applications', 'Applications activées', 'Activated applications', 'Activated applications'),
('Activated roles', 'Activated roles', 'Rôles activés', 'Activated roles', 'Activated roles'),
('Activated users', 'Activated users', 'Utilisateurs sélectionnés', 'Activated users', 'Activated users'),
('Activities', 'Activities', 'Activités', 'Activities', 'Activities'),
('Activity', 'Activity', 'Activité', 'Activity', 'Activity'),
('Add', 'Add', 'Ajouter', 'Add', 'Add'),
('Address', 'Address', 'Adresse', 'Address', 'Address'),
('Administration', 'Administration', 'Administration', 'Administration', 'Administration'),
('Advertisement', 'Advertisement', 'Publicité', 'Advertisement', 'Advertisement'),
('Advertising', 'Advertising', 'Publicité', 'Advertising', 'Advertising'),
('alternate_address', 'Alternate Address', 'Autre Adresse', 'Alternate Address', 'Alternate Address'),
('Amount', 'Amount', 'Montant', 'Amount', 'Amount'),
('Application', 'Application', 'Application', 'Application', 'Application'),
('Applications', 'Applications', 'Applications', 'Applications', 'Applications'),
('Architecture', 'Architecture', 'Architecture', 'Architecture', 'Architecture'),
('Assigned', 'Assigned', 'Assigné', 'Assigned', 'Assigned'),
('Assigned to', 'Assigned to', 'Assigné à', 'Assigned to', 'Assigned to'),
('Assistant', 'Assistant', 'Assistant', 'Assistant', 'Assistant'),
('Attendee', 'Attendee', 'Invité', 'Attendee', 'Attendee'),
('Attendees', 'Attendees', 'Invités', 'Attendees', 'Attendees'),
('Avoid', 'Avoid', 'A éviter', 'Avoid', 'Avoid'),
('Billing Contact', 'Billing Contact', 'Contact pour facturation', 'Billing Contact', 'Billing Contact'),
('billing_address', 'Billing address', 'Adresse de facturation', 'Billing address', 'Billing address'),
('Birth Date', 'Birth date', 'Date de Naissance', 'Birth date', 'Birth date'),
('by', 'by', 'par', 'by', 'by'),
('Call', 'Call', 'Appel', 'Call', 'Call'),
('Cancel', 'Cancel', 'Annuler', 'Cancel', 'Cancel'),
('Canceled', 'Canceled', 'Annulée', 'Canceled', 'Canceled'),
('Case', 'Case', 'Cas', 'Case', 'Case'),
('Cases', 'Cases', 'Cas', 'Cases', 'Cases'),
('Chemicals', 'Chemicals', 'Chimie', 'Chemicals', 'Chemicals'),
('City', 'City', 'Ville', 'City', 'City'),
('Clear', 'Clear', 'Effacer', 'Clear', 'Clear'),
('Closed', 'Closed', 'Fermé', 'Closed', 'Closed'),
('Closing Date', 'Closing Date', 'Date de conclusion', 'Closing Date', 'Closing Date'),
('Cold calling', 'Cold calling', 'Appel direct', 'Cold calling', 'Cold calling'),
('Communications', 'Communications', 'Communications', 'Communications', 'Communications'),
('Companies', 'Companies', 'Sociétés', 'Companies', 'Companies'),
('Company', 'Company', 'Société', 'Company', 'Company'),
('Company Most Active Accounts', 'Most Active Accounts', 'Comptes les plus actifs', 'Most Active Accounts', 'Most Active Accounts'),
('Competitor', 'Competitor', 'Concurrent', 'Competitor', 'Competitor'),
('Completed', 'Completed', 'Terminée', 'Completed', 'Completed'),
('Computers', 'Computers', 'Informatique', 'Computers', 'Computers'),
('Confirm', 'Confirm', 'Confirmer', 'Confirm', 'Confirm'),
('Connected users', 'Connected users', 'Utilisateurs connectés', 'Connected users', 'Connected users'),
('Construction', 'Construction', 'Construction', 'Construction', 'Construction'),
('Consulting', 'Consulting', 'Consulting', 'Consulting', 'Consulting'),
('Contact', 'Contact', 'Contact', 'Contact', 'Contact'),
('Contacts', 'Contacts', 'Contacts', 'Contacts', 'Contacts'),
('Countries', 'Countries', 'Pays', 'Countries', 'Countries'),
('Country', 'Country', 'Pays', 'Country', 'Country'),
('Creation', 'Creation', 'Création', 'Creation', 'Creation'),
('Currency', 'Currency', 'Devise', 'Currency', 'Currency'),
('Customer', 'Customer', 'Client', 'Customer', 'Customer'),
('Daily', 'Daily', 'Journalière', 'Daily', 'Daily'),
('Dashboard', 'Dashboard', 'Tableau de bord', 'Dashboard', 'Dashboard'),
('Date', 'Date', 'Date', 'Date', 'Date'),
('Date and Time', 'Date and Time', 'Date et Heure', 'Date and Time', 'Date and Time'),
('Day', 'Day', 'Jour', 'Day', 'Day'),
('Deactivated', 'Deactivated', 'Désactivé', 'Deactivated', 'Deactivated'),
('Deactivated applications', 'Deactivated applications', 'Applications désactivées', 'Deactivated applications', 'Deactivated applications'),
('Deactivated roles', 'Deactivated roles', 'Rôles désactivés', 'Deactivated roles', 'Deactivated roles'),
('Deactivated users', 'Deactivated users', 'Utilisateurs désélectionnés', 'Deactivated users', 'Deactivated users'),
('Deferred', 'Deferred', 'Retardée', 'Deferred', 'Deferred'),
('Definition', 'Definition', 'Définition', 'Definition', 'Definition'),
('Delete', 'Delete', 'Supprimer', 'Delete', 'Delete'),
('Department', 'Department', 'Département', 'Department', 'Department'),
('Departments', 'Departments', 'Départements', 'Departments', 'Departments'),
('Direct Mail', 'Direct Mail', 'Courrier', '直接邮寄', 'Direct Mail'),
('Distribution', 'Distribution', 'Logistique', 'Distribution', 'Distribution'),
('Do Not Call', 'Do Not Call', 'Ne Pas Appeler', 'Do Not Call', 'Do Not Call'),
('Due Date', 'Due Date', 'Date', 'Due Date', 'Due Date'),
('Duplicate', 'Duplicate', 'Copier', 'Duplicate', 'Duplicate'),
('Duration', 'Duration', 'Durée', 'Duration', 'Duration'),
('Edit', 'Edit', 'Editer', 'Edit', 'Edit'),
('Education', 'Education', 'Education', 'Education', 'Education'),
('Email', 'Email', 'Email', '电子邮件', 'Email'),
('Email Opt', 'Email Opt', 'Mailing', '选择电子邮件', 'Email Opt'),
('Email Opt Out', 'Email Opt Out', 'Exclure Mailing', '电子邮件退出', 'Email Opt Out'),
('Employees', 'Employees', 'Employés', 'Employees', 'Employees'),
('End', 'End', 'Fin', 'End', 'End'),
('Event', 'Event', 'Evènement', 'Event', 'Event'),
('Excellent', 'Excellent', 'Excellent', 'Excellent', 'Excellent'),
('Expected Amount', 'Expected Amount', 'Montant espéré', 'Expected Amount', 'Expected Amount'),
('Fair', 'Fair', 'Correct', 'Fair', 'Fair'),
('Fax', 'Fax', 'Télécopie', 'Fax', 'Fax'),
('Finance', 'Finance', 'Finance', 'Finance', 'Finance'),
('First', 'First', 'Premier', 'First', 'First'),
('First Name', 'First Name', 'Prénom', 'First Name', 'First Name'),
('Mailto', 'To', 'De', '至', 'To'),
('Good', 'Good', 'Bon', 'Good', 'Good'),
('Government', 'Government', 'Gouvernement', 'Government', 'Government'),
('Grant', 'Grant', 'Attribuer', 'Grant', 'Grant'),
('Grant permissions', 'Grant permissions', 'Attribuer permissions', 'Grant permissions', 'Grant permissions'),
('Grant roles', 'Grant roles', 'Attribuer rôles', 'Grant roles', 'Grant roles'),
('Healthcare', 'Healthcare', 'Santé', 'Healthcare', 'Healthcare'),
('Held', 'Held', 'Tenue', 'Held', 'Held'),
('hh:mm', 'hh:mm', 'hh:mm', 'hh:mm', 'hh:mm'),
('High', 'High', 'Haute', 'High', 'High'),
('Highest', 'Highest', 'Plus haute', 'Highest', 'Highest'),
('Home', 'Home', 'Accueil', 'Home', 'Home'),
('Hour', 'Hour', 'Heure', 'Hour', 'Hour'),
('In', 'In', 'Oui', 'In', 'In'),
('In progress', 'In progress', 'En cours', 'In progress', 'In progress'),
('Industry', 'Industry', 'Industrie', 'Industry', 'Industry'),
('Insurance', 'Insurance', 'Assurances', 'Insurance', 'Insurance'),
('Language', 'Language', 'Langue', 'Language', 'Language'),
('Last', 'Last', 'Dernier', 'Last', 'Last'),
('Last Login', 'Last Login', 'Dernière Connexion', 'Last Login', 'Last Login'),
('Last Name', 'Last Name', 'Nom', 'Last Name', 'Last Name'),
('Last Password Change', 'Last password change', 'Dernier changement de mot de passe', 'Last password change', 'Last password change'),
('Last Update', 'Last Update', 'Mise à Jour', 'Last Update', 'Last Update'),
('Last Viewed', 'Last Viewed', 'Dernières Consultations', 'Last Viewed', 'Last Viewed'),
('Lead', 'Lead', 'Piste', 'Lead', 'Lead'),
('Leads', 'Leads', 'Pistes', 'Leads', 'Leads'),
('Legal', 'Legal', 'Juridique', 'Legal', 'Legal'),
('Legal Status', 'Legal Status', 'Forme juridique', 'Legal Status', 'Legal Status'),
('List', 'List', 'Liste', 'List', 'List'),
('Location', 'Location', 'Lieu', 'Location', 'Location'),
('Login', 'Login', 'Connexion', 'Login', 'Login'),
('Logout', 'Logout', 'Déconnexion', 'Logout', 'Logout'),
('Lost', 'Lost', 'Perdu', 'Lost', 'Lost'),
('Low', 'Low', 'Basse', 'Low', 'Low'),
('Lowest', 'Lowest', 'Plus basse', 'Lowest', 'Lowest'),
('Main Account', 'Main Account', 'Filiale de', 'Main Account', 'Main Account'),
('Main Contact', 'Main Contact', 'Contact Principal', 'Main Contact', 'Main Contact'),
('Manager', 'Manager', 'Supérieur hiérarchique', 'Manager', 'Manager'),
('Manufacturing', 'Manufacturing', 'Production', 'Manufacturing', 'Manufacturing'),
('Meeting', 'Meeting', 'Réunion', 'Meeting', 'Meeting'),
('Messenger', 'Messenger', 'Messagerie instantanée', 'Messenger', 'Messenger'),
('Mobile', 'Mobile', 'Portable', 'Mobile', 'Mobile'),
('Month', 'Month', 'Mois', 'Month', 'Month'),
('Monthly', 'Monthly', 'Mensuelle', 'Monthly', 'Monthly'),
('My Neglected Accounts', 'My Neglected Accounts', 'Mes Comptes Négligés', 'My Neglected Accounts', 'My Neglected Accounts'),
('Name', 'Name', 'Nom', 'Name', 'Name'),
('Negociation', 'Negotiation', 'Négociation', 'Negotiation', 'Negotiation'),
('New', 'New', 'Nouveau', 'New', 'New'),
('New Account', 'New Account', 'Nouveau Compte', 'New Account', 'New Account'),
('New Call', 'New Call', 'Nouvel Appel', 'New Call', 'New Call'),
('New Case', 'New Case', 'Nouveau Cas', 'New Case', 'New Case'),
('New Contact', 'New Contact', 'Nouveau Contact', 'New Contact', 'New Contact'),
('New Lead', 'New Lead', 'Nouvelle Piste', 'New Lead', 'New Lead'),
('New Meeting', 'New Meeting', 'Nouvelle Réunion', 'New Meeting', 'New Meeting'),
('New Opportunity', 'New Opportunity', 'Nouvelle Opportunité', 'New Opportunity', 'New Opportunity'),
('New role', 'New role', 'Nouveau rôle', 'New role', 'New role'),
('New Task', 'New Task', 'Nouvelle Tâche', 'New Task', 'New Task'),
('New user', 'New user', 'Nouvel utilisateur', 'New user', 'New user'),
('Next', 'Next', 'Suivant', 'Next', 'Next'),
('No', 'No', 'Non', 'No', 'No'),
('No user', 'No user', 'Pas d''utilisateur', 'No user', 'No user'),
('Non-Profit', 'Non-Profit', 'Associations', 'Non-Profit', 'Non-Profit'),
('Normal', 'Normal', 'Normale', 'Normal', 'Normal'),
('Not started', 'Not started', 'Non démarré', 'Not started', 'Not started'),
('Note', 'Note', 'Commentaire', 'Note', 'Note'),
('of', 'of', 'sur', 'of', 'of'),
('One week forecast', 'One week forecast', 'Prévisions Hebdomadaires', 'One week forecast', 'One week forecast'),
('Opportunities', 'Opportunities', 'Opportunités', 'Opportunities', 'Opportunities'),
('Opportunity', 'Opportunity', 'Opportunité', 'Opportunity', 'Opportunity'),
('Origin', 'Origin', 'Origine', 'Origin', 'Origin'),
('Other', 'Other', 'Autre', 'Other', 'Other'),
('Out', 'Out', 'Non', 'Out', 'Out'),
('Owner', 'Owner', 'Responsable', 'Owner', 'Owner'),
('Partner', 'Partner', 'Partenaire', 'Partner', 'Partner'),
('Password', 'Password', 'Mot de passe', 'Password', 'Password'),
('Pending', 'Pending', 'En attente', 'Pending', 'Pending'),
('Performance', 'Performance', 'Performance', 'Performance', 'Performance'),
('Permissions', 'Permissions', 'Permissions', 'Permissions', 'Permissions'),
('Phone', 'Phone', 'Téléphone', 'Phone', 'Phone'),
('Poor', 'Poor', 'Faible', 'Poor', 'Poor'),
('Portal', 'Portal', 'Portail', 'Portal', 'Portal'),
('Powered by', 'Powered by', 'Powered by', 'Powered by', 'Powered by'),
('Preferences', 'Preferences', 'Préférences', 'Preferences', 'Preferences'),
('Presentation', 'Presentation', 'Présentation', 'Presentation', 'Presentation'),
('Previous', 'Previous', 'Précédent', 'Previous', 'Previous'),
('primary_address', 'Primary address', 'Adresse principale', 'Primary address', 'Primary address'),
('Print', 'Print', 'Imprimer', 'Print', 'Print'),
('Priority', 'Priority', 'Priorité', 'Priority', 'Priority'),
('Private', 'Private', 'Privé', 'Private', 'Private'),
('Private Email', 'Private Email', 'Email Personel', '私人电子邮件', 'Private Email'),
('Private Mobile', 'Private Mobile', 'Portable Personel', 'Private Mobile', 'Private Mobile'),
('Private Phone', 'Private Phone', 'Téléphone Personel', 'Private Phone', 'Private Phone'),
('Probability', 'Probability', 'Probabilité', 'Probability', 'Probability'),
('Profile', 'Profile', 'Profile', 'Profile', 'Profile'),
('Proposal', 'Proposal', 'Proposition', 'Proposal', 'Proposal'),
('Prospect', 'Prospect', 'Prospect', 'Prospect', 'Prospect'),
('Public', 'Public', 'Public', 'Public', 'Public'),
('Qualification', 'Qualification', 'Qualification', 'Qualification', 'Qualification'),
('Quarterly', 'Quarterly', 'Trimestrielle', 'Quarterly', 'Quarterly'),
('Quick Search', 'Quick Search', 'Recherche Rapide', '快速搜索', 'Quick Search'),
('Quit', 'Quit', 'Quitter', 'Quit', 'Quit'),
('Radio', 'Radio', 'Radio', 'Radio', 'Radio'),
('Rating', 'Rating', 'Estimation', 'Rating', 'Rating'),
('Read', 'Read', 'Lecture', 'Read', 'Read'),
('Real Estate', 'Real Estate', 'Immobilier', 'Real Estate', 'Real Estate'),
('Recurring Opportunity', 'Recurring Opportunity', 'Opportunité récurrante', 'Recurring Opportunity', 'Recurring Opportunity'),
('Rejected', 'Rejected', 'Rejeté', 'Rejected', 'Rejected'),
('Related to', 'Related to', 'En relation avec', 'Related to', 'Related to'),
('Report', 'Report', 'Rapport', 'Report', 'Report'),
('Reports', 'Reports', 'Rapports', 'Reports', 'Reports'),
('Rescheduled', 'Rescheduled', 'Replanifiée', 'Rescheduled', 'Rescheduled'),
('Reset', 'Reset', 'Réinitialiser', 'Reset', 'Reset'),
('Reset passwords', 'Reset passwords', 'MAJ Mots de passe', 'Reset passwords', 'Reset passwords'),
('Restaurant', 'Restaurant', 'Restauration', 'Restaurant', 'Restaurant'),
('Retail', 'Retail', 'Distribution', 'Retail', 'Retail'),
('Revenue', 'Revenue', 'Chiffre d''affaire', 'Revenue', 'Revenue'),
('Role', 'Role', 'Rôle', 'Role', 'Role'),
('Roles', 'Roles', 'Rôles', 'Roles', 'Roles'),
('Roles Granted', 'Roles Granted', 'Rôles attribués', 'Roles Granted', 'Roles Granted'),
('Salutation', 'Salutation', 'Salutations', 'Salutation', 'Salutation'),
('Save', 'Save', 'Sauvegarder', 'Save', 'Save'),
('Scheduled', 'Scheduled', 'Planifiée', 'Scheduled', 'Scheduled'),
('Search', 'Search', 'Rechercher', '搜索', 'Search'),
('Search Engine', 'Search Engine', 'Moteur de recherche', '搜索引擎', 'Search Engine'),
('Search Result', 'Search Result', 'Résultat de la recherche', '搜索结果', 'Search Result'),
('Seconds', 'seconds', 'secondes', 'seconds', 'seconds'),
('Select', 'Select', 'Sélectionner', 'Select', 'Select'),
('Selected Users', 'Selected Users', 'Utilisateurs sélectionnés', 'Selected Users', 'Selected Users'),
('Seminar', 'Seminar', 'Séminaire', 'Seminar', 'Seminar'),
('Sequence', 'Sequence', 'Rang', 'Sequence', 'Sequence'),
('Server response time', 'Server response time', 'Temps de réponse du serveur', 'Server response time', 'Server response time'),
('shipping_address', 'Shipping address', 'Adresse de livraison', 'Shipping address', 'Shipping address'),
('Source', 'Source', 'Source', 'Source', 'Source'),
('Stage', 'Stage', 'Avancement', 'Stage', 'Stage'),
('Start', 'Start', 'Début', 'Start', 'Start'),
('State', 'State', 'Etat ou Région', 'State', 'State'),
('Status', 'Status', 'Status', 'Status', 'Status'),
('Subject', 'Subject', 'Objet', 'Subject', 'Subject'),
('Submit', 'Submit', 'Valider', 'Submit', 'Submit'),
('Supplier', 'Supplier', 'Fournisseur', 'Supplier', 'Supplier'),
('Task', 'Task', 'Tâche', 'Task', 'Task'),
('Tax Identification', 'Tax Identification', 'N° Taxe', 'Tax Identification', 'Tax Identification'),
('Telemarketing', 'Telemarketing', 'Télémarketing', 'Telemarketing', 'Telemarketing'),
('Territory', 'Territory', 'Territoire', 'Territory', 'Territory'),
('Time', 'Time', 'Heure', 'Time', 'Time'),
('Time Zone', 'Time Zone', 'Fuseau horaire', 'Time Zone', 'Time Zone'),
('Title', 'Title', 'Titre', 'Title', 'Title'),
('to', 'to', 'à', 'to', 'to'),
('Today', 'Today', 'Aujourdhui', 'Today', 'Today'),
('Top Opportunities', 'Top Opportunities', 'Opportunités Majeures', 'Top Opportunities', 'Top Opportunities'),
('Trade Show', 'Trade Show', 'Salon', 'Trade Show', 'Trade Show'),
('Type', 'Type', 'Catégorie', 'Type', 'Type'),
('Unknown', 'Unknown', 'Inconnu', 'Unknown', 'Unknown'),
('Upcoming Activities', 'Upcoming Activities', 'Activités à venir', 'Upcoming Activities', 'Upcoming Activities'),
('Update', 'Update', 'Mis à jour', 'Update', 'Update'),
('User', 'User', 'Utilisateur', 'User', 'User'),
('Username', 'User Name', 'Nom d''utilisateur', 'User Name', 'User Name'),
('Users', 'Users', 'Utilisateurs', 'Users', 'Users'),
('Value Proposition', 'Value Proposition', 'Proposition de valeur', 'Value Proposition', 'Value Proposition'),
('Version', 'Version', 'Version', 'Version', 'Version'),
('View', 'View', 'Visualiser', 'View', 'View'),
('Visible', 'Visible', 'Visible', 'Visible', 'Visible'),
('Weather', 'Weather', 'Météorologie', 'Weather', 'Weather'),
('Web Site', 'Web Site', 'Site Web', 'Web Site', 'Web Site'),
('Weekly', 'Weekly', 'Hebdomadaire', 'Weekly', 'Weekly'),
('Weekly forecast', 'Weekly forecast', 'Prévisions hebdomadaires', 'Weekly forecast', 'Weekly forecast'),
('Weekly weather conditions for', 'Weekly weather conditions for', 'Conditions météorologiques pour', 'Weekly weather conditions for', 'Weekly weather conditions for'),
('Welcome', 'Welcome', 'Bienvenue', 'Welcome', 'نرحب'),
('Won', 'Won', 'Gagné', 'Won', 'Won'),
('Word of Mouth', 'Word of Mouth', 'Bouche à oreille', 'Word of Mouth', 'Word of Mouth'),
('Write', 'Write', 'Ecriture', 'Write', 'Write'),
('Yearly', 'Yearly', 'Annuelle', 'Yearly', 'Yearly'),
('Yes', 'Yes', 'Oui', 'Yes', 'Yes'),
('Zipcode', 'Zip code', 'Code postal', 'Zip code', 'Zip code'),
('Locale', 'Locale', 'Paramêtres régionaux', 'Locale', 'Locale'),
('Change password', 'Change password', 'Changer mot de passe', 'Change password', 'Change password'),
('Old Password', 'Old password', 'Ancien mot de passe', 'Old password', 'Old password'),
('New Password', 'New password', 'Nouveau mot de passe', 'New password', 'New password'),
('4 characters minimum', '4 characters minimum', '4 caractères au minimum', '4 characters minimum', '4 characters minimum'),
('Confirm New Password', 'Confirm new password', 'Confirmer le nouveau mot de passe', 'Confirm new password', 'Confirm new password'),
('Localization', 'Localization', 'Localisation', 'Localization', 'Localization'),
('Themes', 'Themes', 'Thêmes', 'Themes', 'Themes'),
('Theme', 'Theme', 'Thême', 'Theme', 'Theme'),
('Colors', 'Colors', 'Couleurs', 'Colors', 'Colors'),
('Skin', 'Skin', 'Revêtement', 'Skin', 'Skin'),
('Look and Feel', 'Look and Feel', 'Présentation', 'Look and Feel', 'Look and Feel'),
('My information', 'My information', 'Mes informations', 'My information', 'My information'),
('Top', 'Top', 'Haut', 'Top', 'Top'),
('Up', 'Up', 'Monter', 'Up', 'Up'),
('Down', 'Down', 'Descendre', 'Down', 'Down'),
('Bottom', 'Bottom', 'Bas', 'Bottom', 'Bottom'),
('Main Department', 'Main Department', 'Département principal', 'Main Department', 'Main Department'),
('New department', 'New department', 'Nouveau département', 'New department', 'New department'),
('Convert', 'Convert', 'Conversion', 'Convert', 'Convert'),
('Dashboards', 'Dashboards', 'Tableaux de bord', 'Dashboards', 'Dashboards'),
('Unit', 'Unit', 'Système', 'Unit', 'Unit'),
('Metric', 'Metric', 'Métrique', 'Metric', 'Metric'),
('Standard', 'Standard', 'Standard (USA)', 'Standard', 'Standard'),
('File format', 'File format', 'Format de fichier', 'File format', 'File format'),
('File name', 'File name', 'Nom du fichier', 'File name', 'File name'),
('Header column', 'Header column', 'Colonne d''entête', 'Header column', 'Header column'),
('Import', 'Import', 'Importer', 'Import', 'Import'),
('Send email', 'Send email', 'Envoyer un email', '电子邮件', 'Send email'),
('Database fields', 'Database fields', 'Champs de la base', 'Database fields', 'Database fields'),
('Header row', 'Header row', 'Entête du fichier', 'Header row', 'Header row'),
('Row 1', 'Row 1', 'Première colonne', 'Row 1', 'Row 1'),
('Row 2', 'Row 2', 'Seconde colonne', 'Row 2', 'Row 2'),
('Row 3', 'Row 3', 'Troisième colonne', 'Row 3', 'Row 3'),
('Select fields', 'Select fields', 'Sélection des champs', 'Select fields', 'Select fields'),
('Rows processed', 'Rows processed', 'Lignes traitées', 'Rows processed', 'Rows processed'),
('Created', 'Created', 'Créé', 'Created', 'Created'),
('Year', 'Year', 'Année', 'Year', 'Year'),
('Forecast', 'Forecast', 'Prévision', 'Forecast', 'Forecast'),
('Forecasts', 'Forecasts', 'Prévisions', 'Forecasts', 'Forecasts'),
('Total Amount', 'Total Amount', 'Montant total', 'Total Amount', 'Total Amount'),
('Forecasted Amount', 'Forecasted Amount', 'Montant prévisionnel', 'Forecasted Amount', 'Forecasted Amount'),
('Quotas', 'Quotas', 'Quotas', 'Quotas', 'Quotas'),
('Quota', 'Quota', 'Quota', 'Quota', 'Quota'),
('Won Amount', 'Won Amount', 'Montant gagné', 'Won Amount', 'Won Amount'),
('Quota vs Won', 'Quota vs Won', 'Quota/Gagné', 'Quota vs Won', 'Quota vs Won'),
('Quota vs Expected', 'Quota vs Expected', 'Quota/Espéré', 'Quota vs Expected', 'Quota vs Expected'),
('Quota vs Forecasted', 'Quota vs Forecasted', 'Quota/Prévisionnel', 'Quota vs Forecasted', 'Quota vs Forecasted'),
('Total', 'Total', 'Total', 'Total', 'Total'),
('Start of Fiscal Year', 'Start of Fiscal Year', 'Début d''année fiscale', 'Start of Fiscal Year', 'Start of Fiscal Year'),
('Incorporation', 'Date of Incorporation', 'Date de constitution', 'Date of Incorporation', 'Date of Incorporation'),
('Sales team', 'Sales team', 'Equipe de vente', 'Sales team', 'Sales team'),
('Sales teams', 'Sales teams', 'Equipes de vente', 'Sales teams', 'Sales teams'),
('Team member', 'Team member', 'Equipier', 'Team member', 'Team member'),
('Team members', 'Team members', 'Equipiers', 'Team members', 'Team members'),
('Main sales team', 'Main sales team', 'Equipe principale', 'Main sales team', 'Main sales team'),
('Sales people', 'Sales people', 'Vendeur', 'Sales people', 'Sales people'),
('Fiscal year', 'Fiscal year', 'Année fiscale', 'Fiscal year', 'Fiscal year'),
('Quarter', 'Quarter', 'Trimestre', 'Quarter', 'Quarter'),
('Start date', 'Start date', 'Date de début', 'Start date', 'Start date'),
('End date', 'End date', 'Date de fin', 'End date', 'End date'),
('Custom dates', 'Custom dates', 'Dates personnalisées', 'Custom dates', 'Custom dates'),
('Org Chart', 'Org Chart', 'Organigramme', 'Org Chart', 'Org Chart'),
('Document', 'Document', 'Document', 'Document', 'Document'),
('Documents', 'Documents', 'Documents', 'Documents', 'Documents'),
('Download', 'Download', 'Télécharger du serveur', 'Download', 'Download'),
('Upload', 'Upload', 'Télécharger vers serveur', 'Upload', 'Upload'),
('Copy', 'Copy', 'Copie', 'Copy', 'Copy'),
('Move', 'Move', 'Déplacer', 'Move', 'Move'),
('Size', 'Size', 'Taille', 'Size', 'Size'),
('Folder', 'Folder', 'Dossier', 'Folder', 'Folder'),
('Mail', 'Mail', 'Courrier', '邮件', 'Mail'),
('Mails', 'Mails', 'Courriers', '邮件', 'Mails'),
('From', 'From', 'De', 'From', 'From'),
('Max size', 'Max size', 'Taille maximale', 'Max size', 'Max size'),
('Reply to', 'Reply to', 'Répondre à', 'Reply to', 'Reply to'),
('Default', 'Default', 'Défaut', 'Default', 'Default'),
('Server port', 'Server port', 'port du serveur', 'Server port', 'Server port'),
('Server', 'Server', 'Serveur', 'Server', 'Server'),
('POP3 Server', 'POP3 Server (In)', 'Serveur POP3 (entrant)', 'POP3 Server (In)', 'POP3 Server (In)'),
('SMTP Server', 'SMTP Server (Out)', 'Serveur SMTP (sortant)', 'SMTP Server (Out)', 'SMTP Server (Out)'),
('SSL connection', 'SSL connection', 'Connexion SSL', 'SSL connection', 'SSL connection'),
('Information updated', 'Information successfully updated', 'Mise à jour réussie', 'Information successfully updated', 'Information successfully updated'),
('Information created', 'Information successfully created', 'Création réussie', 'Information successfully created', 'Information successfully created'),
('Information deleted', 'Information successfully deleted', 'Suppression réussie', 'Information successfully deleted', 'Information successfully deleted'),
('Update error', 'Update error', 'Erreur de mise à jour', 'Update error', 'Update error'),
('Insert error', 'Insert error', 'Erreur de création', 'Insert error', 'Insert error'),
('Delete error', 'Delete error', 'Erreur de suppression', 'Delete error', 'Delete error'),
('Invalid or missing data', 'Invalid or missing data, check the form below', 'Information manquante dans le formulaire', 'Invalid or missing data, check the form below', 'Invalid or missing data, check the form below'),
('Enter a valid search criteria', 'Enter a valid search criteria', 'Entrez un critère de recherche valide', '进入求职有效期', 'Enter a valid search criteria'),
('Enter a valid email address', 'Enter a valid email address', 'Entrez une adresse email valide', '进入一个有效的电子邮件地址', 'Enter a valid email address'),
('This field is mandatory', 'This field is mandatory', 'Ce champ est obligatoire', 'This field is mandatory', 'This field is mandatory'),
('Enter a valid numeric value', 'Enter a valid numeric value', 'Entrez une valeur numérique', 'Enter a valid numeric value', 'Enter a valid numeric value'),
('Enter a valid phone number', 'Enter a valid phone number', 'Entrez un numéro de téléphone valide', 'Enter a valid phone number', 'Enter a valid phone number'),
('Enter a valid date', 'Enter a valid date', 'Entrez une date valide', 'Enter a valid date', 'Enter a valid date'),
('Enter a valid time', 'Enter a valid time', 'Entrez une heure valide', 'Enter a valid time', 'Enter a valid time'),
('Enter a valid password', 'Enter a valid password', 'Entrez un mot de passe valide', 'Enter a valid password', 'Enter a valid password'),
('Enter a valid alias', 'Enter a valid alias', 'Entrez un alias valide', 'Enter a valid alias', 'Enter a valid alias'),
('no access rights to this form', 'You have no access rights to this form', 'Vous n''avez pas accès à cette application', 'You have no access rights to this form', 'You have no access rights to this form'),
('no update rights on this form', 'You have no update rights on this form', 'Vous n''avez pas de droits en mise à jour', 'You have no update rights on this form', 'You have no update rights on this form'),
('By address', 'By address', 'Par adresse', 'By address', 'By address'),
('By zipcode', 'By zipcode', 'Par code postal', 'By zipcode', 'By zipcode'),
('Map', 'Map', 'Plan', 'Map', 'Map'),
('Direction', 'Direction', 'Direction', 'Direction', 'Direction'),
('To here', 'To here', 'En direction de', 'To here', 'To here'),
('From here', 'From here', 'En provenance de', 'From here', 'From here'),
('Import Leads', 'Import Leads', 'Importer des Pistes', 'Import Leads', 'Import Leads'),
('Export Leads', 'Export Leads', 'Exporter des Pistes', 'Export Leads', 'Export Leads'),
('Import Accounts', 'Import Accounts', 'Importer des Comptes', 'Import Accounts', 'Import Accounts'),
('Export Accounts', 'Export Accounts', 'Exporter des Comptes', 'Export Accounts', 'Export Accounts'),
('Import Contacts', 'Import Contacts', 'Importer des Contacts', 'Import Contacts', 'Import Contacts'),
('Export Contacts', 'Export Contacts', 'Exporter des Contacts', 'Export Contacts', 'Export Contacts'),
('Export Opportunities', 'Export Opportunities', 'Exporter des Opportunités', 'Export Opportunities', 'Export Opportunities'),
('Browse', 'Browse', 'Naviguer', 'Browse', 'Browse'),
('New Folder', 'New Folder', 'Nouveau Dossier', 'New Folder', 'New Folder'),
('Upload Document', 'Upload Document', 'Télécharger un Document', 'Upload Document', 'Upload Document'),
('Customize', 'Customize', 'Personaliser', 'Customize', 'Customize'),
('Export Cases', 'Export Cases', 'Exporter des Cas', 'Export Cases', 'Export Cases'),
('New Mail', 'New Mail', 'Nouvel Email', '新邮件', 'New Mail'),
('Edit Folder', 'Edit Folder', 'Editer le Dossier', 'Edit Folder', 'Edit Folder'),
('Folders', 'Folders', 'Dossiers', 'Folders', 'Folders'),
('Check Mailboxes', 'Check Mailboxes', 'Relever les nouveaux messages', '检查信箱', 'Check Mailboxes'),
('Setup', 'Setup', 'Configuration', 'Setup', 'Setup'),
('Export Activities', 'Export Activities', 'Exporter des activités', 'Export Activities', 'Export Activities'),
('Sales Organization', 'Sales Organization', 'Organisation des Ventes', 'Sales Organization', 'Sales Organization'),
('Send a welcome email', 'Send a welcome email', 'Envoyer un email de bienvenue', '电子邮件发出欢迎', 'Send a welcome email'),
('Lines', 'Lines', 'Lignes', 'Lines', 'Lines'),
('Mandatory fields', 'Mandatory fields', 'Champs obligatoires', 'Mandatory fields', 'Mandatory fields'),
('Capture Leads', 'Capture Leads', 'Capturer des pistes', 'Capture Leads', 'Capture Leads'),
('Order', 'Order', 'Commande', 'Order', 'Order'),
('Product', 'Product', 'Produit', 'Product', 'Product'),
('Invoice', 'Invoice', 'Facture', 'Invoice', 'Invoice'),
('Description', 'Description', 'Description', 'Description', 'Description'),
('Records', 'Records', 'Enregistrements', 'Records', 'Records'),
('Used', 'Used', 'Utilisé', 'Used', 'Used'),
('Percentage', 'Percentage', 'Pourcentage', 'Percentage', 'Percentage'),
('Disk space quota', 'Maximum disk space', 'Espace disque maximum', 'Maximum disk space', 'Maximum disk space'),
('Quantity', 'Quantity', 'Quantité', 'Quantity', 'Quantity'),
('Database', 'Database', 'Base de données', 'Database', 'Database'),
('Datas', 'Datas', 'Données', 'Datas', 'Datas'),
('Usage statistics', 'Usage statistics', 'Statistiques d''utilisation', 'Usage statistics', 'Usage statistics'),
('Maximum users', 'Maximum users', 'Nombre maximum d''utilisateurs', 'Maximum users', 'Maximum users'),
('Created users', 'Created users', 'Utilisateurs créés', 'Created users', 'Created users'),
('Company alias', 'Company alias', 'Alias de la société', 'Company alias', 'Company alias'),
('AppShore Edition', 'AppShore Edition', 'Edition AppShore', 'AppShore Edition', 'AppShore Edition'),
('Remaining time', 'Remaining time', 'Temps restant', 'Remaining time', 'Remaining time'),
('Date of registration', 'Date of registration', 'Date d''enregistrement', 'Date of registration', 'Date of registration'),
('Applications available', 'Applications available', 'Applications disponibles', 'Applications available', 'Applications available'),
('Negotiation', 'Negotiation', 'Négociation', 'Negotiation', 'Negotiation'),
('Grant inital role', 'Grant inital role', 'Affecter un role', 'Grant inital role', 'Grant inital role'),
('Last auto update', 'Last auto update', 'Dernière mise à jour automatique', 'Last auto update', 'Last auto update'),
('Last license check', 'Last license check', 'Dernier contrôle de licence', 'Last license check', 'Last license check'),
('Register', 'Register', 'Enregistrer', 'Register', 'Register'),
('Recalculate', 'Recalculate', 'Recalculer', 'Recalculate', 'Recalculate'),
('Campaign', 'Campaign', 'Campagne', 'Campaign', 'Campaign'),
('Campaigns', 'Campaigns', 'Campagnes', 'Campaigns', 'Campaigns'),
('Media', 'Media', 'Média', 'Media', 'Media'),
('Targets', 'Targets', 'Cibles', 'Targets', 'Targets'),
('HTML template', 'HTML template', 'Modèle HTML', 'HTML template', 'HTML template'),
('Text template', 'Text template', 'Modèle texte', 'Text template', 'Text template'),
('Add checked', 'Add checked', 'Ajouter la sélection', 'Add checked', 'Add checked'),
('All all', 'Add all', 'Tout ajouter', 'Add all', 'Add all'),
('Add all', 'Add all', 'Tout ajouter', 'Add all', 'Add all'),
('Close', 'Close', 'Fermer', 'Close', 'Close'),
('Email sent', 'Email sent', 'Email envoyé', '发送电子邮件', 'Email sent'),
('Authentication', 'Authentication', 'Authentification', 'Authentication', 'Authentication'),
('Port', 'Port', 'Port', 'Port', 'Port'),
('Protocol', 'Protocol', 'Protocôle', 'Protocol', 'Protocol'),
('Email server', 'Email server', 'Serveur d''emails', '电子邮件伺服器', 'Email server'),
('Run by', 'Run by', 'Executée par', 'Run by', 'Run by'),
('Default Application', 'Default Application', 'Application initiale', 'Default Application', 'Default Application'),
('Products', 'Products', 'Produits', 'Products', 'Products'),
('Product Name', 'Product Name', 'Nom produit', 'Product Name', 'Product Name'),
('New Product', 'New Product', 'Nouveau produit', 'New Product', 'New Product'),
('Search Products', 'Search Products', 'Recherche produits', '产品搜索', 'Search Products'),
('Import Products', 'Import Products', 'Importer produits', 'Import Products', 'Import Products'),
('Export Products', 'Export Products', 'Exporter produits', 'Export Products', 'Export Products'),
('Categories', 'Categories', 'Catégories', 'Categories', 'Categories'),
('Search Categories', 'Search Categories', 'Rechercher catégories', '搜索类别', 'Search Categories'),
('Export Categories', 'Export Categories', 'Exporter catégories', 'Export Categories', 'Export Categories'),
('New Category', 'New Category', 'Nouvelle catégorie', 'New Category', 'New Category'),
('Import Categories', 'Import Categories', 'Importer catégories', 'Import Categories', 'Import Categories'),
('Sell Price', 'Sell Price', 'Prix de vente', 'Sell Price', 'Sell Price'),
('Buy Price', 'Buy Price', 'Prix d''achat', 'Buy Price', 'Buy Price'),
('Selected lines', 'Selected lines', 'Lignes sélectionnées', 'Selected lines', 'Selected lines'),
('Current page', 'Current page', 'Page courante', 'Current page', 'Current page'),
('Apply on', 'Apply on', 'Appliquer sur', 'Apply on', 'Apply on'),
('Supplier Code', 'Supplier Code', 'Code fournisseur', 'Supplier Code', 'Supplier Code'),
('Supplier Description', 'Supplier Description', 'Description fournisseur', 'Supplier Description', 'Supplier Description'),
('Supplier Product', 'Supplier Product', 'Nom produit', 'Supplier Product', 'Supplier Product'),
('Product Code', 'Product Code', 'Code produit', 'Product Code', 'Product Code'),
('Customization', 'Customization', 'Personalisation', 'Customization', 'Customization'),
('Company logo', 'Company logo', 'Logo compagnie', 'Company logo', 'Company logo'),
('Drop down lists', 'Drop down lists', 'Listes déroulantes', 'Drop down lists', 'Drop down lists'),
('Templates', 'Templates', 'Modèles', 'Templates', 'Templates'),
('Template', 'Template', 'Modèle', 'Template', 'Template'),
('Templates List', 'Templates List', 'Liste des modèles', 'Templates List', 'Templates List'),
('Run Report', 'Run Report', 'Lancer le rapport', 'Run Report', 'Run Report'),
('Run Export', 'Run Export', 'Lancer un export', 'Run Export', 'Run Export'),
('New Report', 'New Report', 'Nouveau Rapport', 'New Report', 'New Report'),
('Search Reports', 'Search Reports', 'Rechercher des Rapports', 'Search Reports', 'Search Reports'),
('Report Name', 'Report Name', 'Nom du Rapport', 'Report Name', 'Report Name'),
('Data Source', 'Data Source', 'Source de données', 'Data Source', 'Data Source'),
('Columns', 'Columns', 'Colonnes', 'Columns', 'Columns'),
('Search Contacts', 'Search Contacts', 'Rechercher Contacts', 'Search Contacts', 'Search Contacts'),
('Search Accounts', 'Search Accounts', 'Rechercher des Comptes', 'Search Accounts', 'Search Accounts'),
('Updated', 'Updated', 'Mise à jour', 'Updated', 'Updated'),
('Count', 'Count', 'Compte', 'Count', 'Count'),
('Sum', 'Sum', 'Somme', 'Sum', 'Sum'),
('Average', 'Average', 'Moyenne', 'Average', 'Average'),
('Minimum', 'Minimum', 'Minimum', 'Minimum', 'Minimum'),
('Maximum', 'Maximum', 'Maximum', 'Maximum', 'Maximum'),
('Group', 'Group', 'Groupage', 'Group', 'Group'),
('Group by', 'Group by', 'Grouper par', 'Group by', 'Group by'),
('and', 'and', 'et', 'and', 'and'),
('Filters', 'Filters', 'Filtres', 'Filters', 'Filters'),
('Operation', 'Operation', 'Opération', 'Operation', 'Operation'),
('Criteria', 'Criteria', 'Critère', 'Criteria', 'Criteria'),
('Column', 'Column', 'Colonne', 'Column', 'Column'),
('contains', 'contains', 'contiens', 'contains', 'contains'),
('equal to', 'equal to', 'égale à', 'equal to', 'equal to'),
('starts with', 'starts with', 'débute par', 'starts with', 'starts with'),
('ends with', 'ends with', 'fini par', 'ends with', 'ends with'),
('like', 'like', 'comme', 'like', 'like'),
('not like', 'not like', 'non comme', 'not like', 'not like'),
('not equal to', 'not equal to', 'non égale à', 'not equal to', 'not equal to'),
('Created by', 'Created by', 'Créé par', 'Created by', 'Created by'),
('Date of Creation', 'Date of Creation', 'Créé le', 'Date of Creation', 'Date of Creation'),
('Tax Identifier', 'Tax Identifier', 'N° Taxe', 'Tax Identifier', 'Tax Identifier'),
('Updated by', 'Updated by', 'Mise à jour par', 'Updated by', 'Updated by'),
('greater than', 'greater than', 'plus grand que', 'greater than', 'greater than'),
('less than', 'less than', 'moins que', 'less than', 'less than'),
('within period', 'within period', 'dans la période de', 'within period', 'within period'),
('less than or equal to', 'less than or equal to', 'moins que ou égale à ', 'less than or equal to', 'less than or equal to'),
('greater than or equal to', 'greater than or equal to', 'plus grand ou égale à', 'greater than or equal to', 'greater than or equal to');

-- --------------------------------------------------------
-- 
-- Table structure for table `users_statuses`
-- 

CREATE TABLE `users_statuses` (
  `status_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `status_name` varchar(250) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`status_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Dumping data for table `users_statuses`
-- 

INSERT INTO `users_statuses` (`status_id`, `status_name`) VALUES 
('A', 'Activated'),
('D', 'Deactivated'),
('L', 'Locked'),
('W', 'W'),
('S', 'Special');


-- 
-- Table structure for table `versions`
-- 

DROP TABLE IF EXISTS `versions`;
CREATE TABLE IF NOT EXISTS `versions` (
  `version` date NOT NULL default '0000-00-00',
  `editions` varchar(10) collate utf8_unicode_ci NOT NULL default 'DEV',
  `note` text collate utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`version`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 
-- Table structure for table `webmail_priorities`
-- 
CREATE TABLE `webmail_priorities` (
  `priority_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `priority_name` varchar(250) collate utf8_unicode_ci NOT NULL,
  `priority_sequence` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY  (`priority_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `webmail_priorities` (`priority_id`, `priority_name`, `priority_sequence`) VALUES 
('LE', 'Lowest', 1),
('LO', 'Low', 2),
('NO', 'Normal', 3),
('HI', 'High', 4),
('HE', 'Highest', 5);
