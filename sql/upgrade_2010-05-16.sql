ALTER TABLE `activities` ADD `reminder_email` VARCHAR( 32 ) NOT NULL AFTER `activity_end`;
ALTER TABLE `activities` ADD `reminder_popup` VARCHAR( 32 ) NOT NULL AFTER `reminder_email`;

CREATE TABLE IF NOT EXISTS `activities_preferences` (
  `user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `day_start_hour` int(11) NOT NULL DEFAULT '28800',
  `day_end_hour` int(11) NOT NULL DEFAULT '64800',
  `tab_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'activities',
  `inc_hour` int(11) NOT NULL DEFAULT '1800',
  `reminder_email` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '10.M',
  `reminder_popup` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '10.M',
  `first_day_week` tinyint(4) NOT NULL DEFAULT '1',
  `days_per_week` tinyint(4) NOT NULL DEFAULT '7',
  `priority_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'NO',
  `status_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'SC',
  `type_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'CA',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `db_applications` (`app_name`, `app_label`, `app_sequence`, `status_id`, `table_name`, `field_name`, `is_related`, `is_visible`, `is_search`, `is_customizable`, `is_report`, `is_quickadd`, `excluded_tabs`) VALUES
('activities_preferences', 'Activities - Preferences', 5, 'S', 'activities_preferences', 'user_id', 'N', 'Y', 'N', 'N', 'N', 'N', '');

DELETE FROM `db_blocks` where `app_name` = 'activities_preferences';
INSERT INTO `db_blocks` (`app_name`, `form_name`, `block_id`, `block_name`, `is_title`, `columns`, `block_sequence`) VALUES
('activities_preferences', 'edit', '1awnxhwwm2kg8oscswg44og0w', 'New activity', 'Y', 2, 4),
('activities_preferences', 'edit', '1fjtpooog9wggswsogk040g0w', 'Calendar', 'Y', 2, 2),
('activities_preferences', 'view', '2gj7q8ggm1a8000g8wwo8ow4', 'New activity', 'Y', 2, 4),
('activities_preferences', 'view', 'e22na4ejqjkg0kckg88csk4k', 'Calendar', 'Y', 2, 2);

DELETE FROM `db_blocks` where `app_name` = 'preferences_lookandfeel';
INSERT INTO `db_blocks` (`app_name`, `form_name`, `block_id`, `block_name`, `is_title`, `columns`, `block_sequence`) VALUES
('preferences_lookandfeel', 'edit', '10ragq2617itc', 'Theme', 'Y', 1, 5),
('preferences_lookandfeel', 'edit', '12238nyd9hxc0', 'Main', 'N', 2, 2),
('preferences_lookandfeel', 'edit', '1h90e2frullvk', 'Locale', 'Y', 2, 4),
('preferences_lookandfeel', 'view', '1fa93ag8kvwg8o8ss44w000cg', 'Theme', 'Y', 1, 5),
('preferences_lookandfeel', 'view', 'dwcouzp78tck4gkos40o4sos', 'Locale', 'Y', 2, 4),
('preferences_lookandfeel', 'view', 'dzw7l3yrs9w0gsw4goocs4g8', 'Main', 'N', 2, 2);

DELETE FROM `db_fields` where `app_name` = 'activities_preferences';
INSERT INTO `db_fields` (`app_name`, `table_name`, `field_name`, `is_custom`, `is_computed`, `field_type`, `field_label`, `field_height`, `field_default`, `related_table`, `related_id`, `related_name`, `related_filter`, `is_search`, `is_readonly`, `is_mandatory`, `is_unique`, `is_visible`, `search_sequence`, `result_sequence`, `result_class`, `bulk_sequence`, `bulk_side`, `bulk_block_id`, `view_sequence`, `view_side`, `view_block_id`, `edit_sequence`, `edit_side`, `edit_block_id`, `popup_search_sequence`, `popup_result_sequence`, `popup_view_sequence`, `popup_view_side`, `popup_view_block_id`, `popup_edit_sequence`, `popup_edit_side`, `popup_edit_block_id`, `linked_sequence`) VALUES
('activities_preferences', 'activities_preferences', 'days_per_week', 'N', 'Y', 'DD', 'Days displayed in week and month tabs', 1, '7', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 2, 'R', 'e22na4ejqjkg0kckg88csk4k', 2, 'R', '1fjtpooog9wggswsogk040g0w', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'first_day_week', 'N', 'Y', 'DD', 'First day of the week', 1, '1', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'R', 'e22na4ejqjkg0kckg88csk4k', 1, 'R', '1fjtpooog9wggswsogk040g0w', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'inc_hour', 'N', 'Y', 'DD', 'Time table granularity', 1, '1800', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 2, 'L', 'e22na4ejqjkg0kckg88csk4k', 2, 'L', '1fjtpooog9wggswsogk040g0w', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'priority_id', 'N', 'N', 'DD', 'Priority', 1, '', 'activities_priorities', 'priority_id', 'priority_name', 'order by priority_sequence', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'L', '2gj7q8ggm1a8000g8wwo8ow4', 1, 'L', '1awnxhwwm2kg8oscswg44og0w', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'status_id', 'N', 'N', 'DD', 'Status', 1, '', 'activities_statuses', 'status_id', 'status_name', 'order by status_name', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 2, 'L', '2gj7q8ggm1a8000g8wwo8ow4', 2, 'L', '1awnxhwwm2kg8oscswg44og0w', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'tab_id', 'N', 'Y', 'DD', 'Default tab', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'L', 'e22na4ejqjkg0kckg88csk4k', 1, 'L', '1fjtpooog9wggswsogk040g0w', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'type_id', 'N', 'N', 'DD', 'Type', 1, '', 'activities_types', 'type_id', 'type_name', 'order by type_name', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'R', '2gj7q8ggm1a8000g8wwo8ow4', 1, 'R', '1awnxhwwm2kg8oscswg44og0w', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'user_id', 'N', 'N', 'RK', 'User id', 1, '', '', '', '', '', 'N', 'Y', 'N', 'Y', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0);

DELETE FROM `db_fields` where `app_name` = 'preferences_lookandfeel';
INSERT INTO `db_fields` (`app_name`, `table_name`, `field_name`, `is_custom`, `is_computed`, `field_type`, `field_label`, `field_height`, `field_default`, `related_table`, `related_id`, `related_name`, `related_filter`, `is_search`, `is_readonly`, `is_mandatory`, `is_unique`, `is_visible`, `search_sequence`, `result_sequence`, `result_class`, `bulk_sequence`, `bulk_side`, `bulk_block_id`, `view_sequence`, `view_side`, `view_block_id`, `edit_sequence`, `edit_side`, `edit_block_id`, `popup_search_sequence`, `popup_result_sequence`, `popup_view_sequence`, `popup_view_side`, `popup_view_block_id`, `popup_edit_sequence`, `popup_edit_side`, `popup_edit_block_id`, `linked_sequence`) VALUES
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
('preferences_lookandfeel', 'users', 'user_id', 'N', 'N', 'RK', 'User identifier', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0);

UPDATE `departments` SET `department_top_id` = '' WHERE `department_top_id` = '0';

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

ALTER TABLE `users` ADD `notifications_location` ENUM( 'TL', 'TC', 'TR', 'BL', 'BC', 'BR' ) NOT NULL DEFAULT 'TC' AFTER `theme_id`;

DROP table IF EXISTS global_notifications_periods;
DROP VIEW IF EXISTS global_notifications_periods;
CREATE VIEW global_notifications_periods AS select * from appshore_global.notifications_periods;


