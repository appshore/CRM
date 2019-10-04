ALTER TABLE `activities_preferences` CHANGE `reminder_email` `reminder_email` VARCHAR( 32 ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '.';
ALTER TABLE `activities_preferences` CHANGE `reminder_popup` `reminder_popup` VARCHAR( 32 ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '.';
UPDATE `activities_preferences` SET `reminder_email` = '.', `reminder_popup` = '.';

DELETE FROM db_blocks WHERE app_name = 'activities' and block_name = 'Notification';
INSERT INTO `db_blocks` (`app_name`, `form_name`, `block_id`, `block_name`, `is_title`, `columns`, `block_sequence`) VALUES
('activities', 'edit', '13a695bezvjks0c0c4cgo0c0', 'Notification', 'N', 2, 4),
('activities', 'view', '19h21z3idjc0ggo8w4sowg84w', 'Notification', 'N', 2, 4),
('activities', 'popup_edit', '13235qfd4glwo0gcwk0kg4wws', 'Notification', 'N', 2, 4);

DELETE FROM db_fields WHERE app_name = 'activities' and field_name in ('reminder_email','reminder_popup');
INSERT INTO `db_fields` (`app_name`, `table_name`, `field_name`, `is_custom`, `is_computed`, `field_type`, `field_label`, `field_height`, `field_default`, `related_table`, `related_id`, `related_name`, `related_filter`, `is_search`, `is_readonly`, `is_mandatory`, `is_unique`, `is_visible`, `search_sequence`, `result_sequence`, `result_class`, `bulk_sequence`, `bulk_side`, `bulk_block_id`, `view_sequence`, `view_side`, `view_block_id`, `edit_sequence`, `edit_side`, `edit_block_id`, `popup_search_sequence`, `popup_result_sequence`, `popup_view_sequence`, `popup_view_side`, `popup_view_block_id`, `popup_edit_sequence`, `popup_edit_side`, `popup_edit_block_id`, `linked_sequence`) VALUES
('activities', 'activities', 'reminder_email', 'N', 'N', 'RM', 'Reminder email', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 5, 'L', '1h8zm01ckrnn7', 1, 'L', '19h21z3idjc0ggo8w4sowg84w', 1, 'L', '13a695bezvjks0c0c4cgo0c0', 0, 0, 0, 'L', '', 1, 'L', '13235qfd4glwo0gcwk0kg4wws', 0),
('activities', 'activities', 'reminder_popup', 'N', 'N', 'RM', 'Reminder popup', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 5, 'R', '1h8zm01ckrnn7', 1, 'R', '19h21z3idjc0ggo8w4sowg84w', 1, 'R', '13a695bezvjks0c0c4cgo0c0', 0, 0, 0, 'L', '', 1, 'R', '13235qfd4glwo0gcwk0kg4wws', 0);

DELETE FROM db_blocks WHERE app_name = 'activities_preferences';
INSERT INTO `db_blocks` (`app_name`, `form_name`, `block_id`, `block_name`, `is_title`, `columns`, `block_sequence`) VALUES
('activities_preferences', 'edit', '9q73632yuxgcgc0g4c0wso08', 'New activity', 'Y', 2, 4),
('activities_preferences', 'edit', 'cz93mguyt7w44g800o4888s8', 'Notifications', 'N', 2, 6),
('activities_preferences', 'edit', 'i1ssa14wljk8c8ws0c4os0gw', 'Calendar', 'Y', 2, 2),
('activities_preferences', 'view', '2gj7q8ggm1a8000g8wwo8ow4', 'New activity', 'Y', 2, 4),
('activities_preferences', 'view', 'e06gt0i8dpck44kko8k0oow4', 'Notifications', 'N', 2, 6),
('activities_preferences', 'view', 'e22na4ejqjkg0kckg88csk4k', 'Calendar', 'Y', 2, 2);

DELETE FROM db_fields WHERE app_name = 'activities_preferences';
INSERT INTO `db_fields` (`app_name`, `table_name`, `field_name`, `is_custom`, `is_computed`, `field_type`, `field_label`, `field_height`, `field_default`, `related_table`, `related_id`, `related_name`, `related_filter`, `is_search`, `is_readonly`, `is_mandatory`, `is_unique`, `is_visible`, `search_sequence`, `result_sequence`, `result_class`, `bulk_sequence`, `bulk_side`, `bulk_block_id`, `view_sequence`, `view_side`, `view_block_id`, `edit_sequence`, `edit_side`, `edit_block_id`, `popup_search_sequence`, `popup_result_sequence`, `popup_view_sequence`, `popup_view_side`, `popup_view_block_id`, `popup_edit_sequence`, `popup_edit_side`, `popup_edit_block_id`, `linked_sequence`) VALUES
('activities_preferences', 'activities_preferences', 'created', 'N', 'N', 'DT', 'Created', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'created_by', 'N', 'N', 'RR', 'Created by', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'day_end_hour', 'N', 'Y', 'DD', 'Day end hour', 1, '64800', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 0, 'L', 'e22na4ejqjkg0kckg88csk4k', 0, 'L', 'i1ssa14wljk8c8ws0c4os0gw', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'day_start_hour', 'N', 'Y', 'DD', 'Day start hour', 1, '28800', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 0, 'L', 'e22na4ejqjkg0kckg88csk4k', 0, 'L', 'i1ssa14wljk8c8ws0c4os0gw', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'days_per_week', 'N', 'Y', 'DD', 'Days displayed in week and month tabs', 1, '7', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 2, 'R', 'e22na4ejqjkg0kckg88csk4k', 2, 'R', 'i1ssa14wljk8c8ws0c4os0gw', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'duration', 'N', 'N', 'DD', 'Duration', 1, '3600', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 2, 'R', '2gj7q8ggm1a8000g8wwo8ow4', 2, 'R', '9q73632yuxgcgc0g4c0wso08', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'first_day_week', 'N', 'Y', 'DD', 'First day of the week', 1, '1', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'R', 'e22na4ejqjkg0kckg88csk4k', 1, 'R', 'i1ssa14wljk8c8ws0c4os0gw', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'inc_hour', 'N', 'Y', 'DD', 'Time table granularity', 1, '1800', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 2, 'L', 'e22na4ejqjkg0kckg88csk4k', 2, 'L', 'i1ssa14wljk8c8ws0c4os0gw', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'priority_id', 'N', 'N', 'DD', 'Priority', 1, '', 'activities_priorities', 'priority_id', 'priority_name', 'order by priority_sequence', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'L', '2gj7q8ggm1a8000g8wwo8ow4', 1, 'L', '9q73632yuxgcgc0g4c0wso08', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'reminder_email', 'N', 'N', 'RM', 'Reminder email', 1, '10.M', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'L', 'e06gt0i8dpck44kko8k0oow4', 1, 'L', 'cz93mguyt7w44g800o4888s8', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'reminder_popup', 'N', 'N', 'RM', 'Reminder popup', 1, '10.M', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'R', 'e06gt0i8dpck44kko8k0oow4', 1, 'R', 'cz93mguyt7w44g800o4888s8', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'status_id', 'N', 'N', 'DD', 'Status', 1, '', 'activities_statuses', 'status_id', 'status_name', 'order by status_name', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 2, 'L', '2gj7q8ggm1a8000g8wwo8ow4', 2, 'L', '9q73632yuxgcgc0g4c0wso08', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'tab_id', 'N', 'Y', 'DD', 'Default tab', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'L', 'e22na4ejqjkg0kckg88csk4k', 1, 'L', 'i1ssa14wljk8c8ws0c4os0gw', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'type_id', 'N', 'N', 'DD', 'Type', 1, '', 'activities_types', 'type_id', 'type_name', 'order by type_name', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'R', '2gj7q8ggm1a8000g8wwo8ow4', 1, 'R', '9q73632yuxgcgc0g4c0wso08', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'updated', 'N', 'N', 'DT', 'Updated', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'updated_by', 'N', 'N', 'RR', 'Updated by', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'user_id', 'N', 'N', 'RK', 'User id', 1, '', '', '', '', '', 'N', 'Y', 'N', 'Y', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0);

update `db_blocks` set block_sequence = '1' WHERE app_name = 'activities' and form_name in ('edit','view','popup_edit','popup_view') and block_name = 'Header';
update `db_blocks` set block_sequence = '2' WHERE app_name = 'activities' and form_name in ('edit','view','popup_edit','popup_view') and block_name = 'Related';
update `db_blocks` set block_sequence = '3' WHERE app_name = 'activities' and form_name in ('edit','view','popup_edit','popup_view') and block_name = 'Main';
update `db_blocks` set block_sequence = '4' WHERE app_name = 'activities' and form_name in ('edit','view','popup_edit','popup_view') and block_name = 'Notification';
update `db_blocks` set block_sequence = '5' WHERE app_name = 'activities' and form_name in ('edit','view','popup_edit','popup_view') and block_name = 'Note';

UPDATE db_fields SET field_type = 'RM' WHERE field_name = 'reminder_email';
UPDATE db_fields SET field_type = 'RM' WHERE field_name = 'reminder_popup';

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

DROP table IF EXISTS global_notifications_fields;
DROP VIEW IF EXISTS global_notifications_fields;
CREATE VIEW global_notifications_fields AS select * from appshore_global.notifications_fields;

DROP table IF EXISTS global_notifications_periods;
DROP VIEW IF EXISTS global_notifications_periods;
CREATE VIEW global_notifications_periods AS select * from appshore_global.notifications_periods;

DROP table IF EXISTS global_notifications_statuses;
DROP VIEW IF EXISTS global_notifications_statuses;
CREATE VIEW global_notifications_statuses AS select * from appshore_global.notifications_statuses;

DROP table IF EXISTS global_notifications_types;
DROP VIEW IF EXISTS global_notifications_types;
CREATE VIEW global_notifications_types AS select * from appshore_global.notifications_types;

DROP table IF EXISTS global_editions;
DROP VIEW IF EXISTS global_editions;
CREATE VIEW global_editions AS select * from appshore_global.editions;
