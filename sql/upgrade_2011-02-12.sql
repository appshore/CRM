ALTER TABLE `notifications` ADD `notification_time` TIME NULL DEFAULT '00:00:00' AFTER `notification_date`;
UPDATE `notifications` SET notification_time = DATE_FORMAT(notification_date, '%H:%i:00');
ALTER TABLE `notifications` CHANGE `notification_date` `notification_date` DATE NOT NULL DEFAULT '0000-00-00';
ALTER TABLE `notifications` DROP INDEX `notification_date`;
ALTER TABLE `notifications` ADD INDEX ( `notification_date` , `notification_time` );

DROP TABLE IF EXISTS `cases_preferences`;
CREATE TABLE IF NOT EXISTS `cases_preferences` (
  `user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `reminder_email` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '.',
  `reminder_popup` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '.',
  `priority_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'NO',
  `status_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'SC',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

ALTER TABLE `cases` ADD `reminder_email` VARCHAR( 32 ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '.' AFTER `due_date`;
ALTER TABLE `cases` ADD `reminder_popup` VARCHAR( 32 ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '.' AFTER `reminder_email`;

INSERT INTO `db_applications` (`app_name`, `app_label`, `app_sequence`, `status_id`, `table_name`, `field_name`, `is_related`, `is_visible`, `is_search`, `is_customizable`, `is_report`, `is_quickadd`, `excluded_tabs`) VALUES
('cases_preferences', 'Cases - Preferences', 5, 'S', 'cases_preferences', 'user_id', 'N', 'Y', 'N', 'N', 'N', 'N', '');

INSERT INTO `db_blocks` (`app_name`, `form_name`, `block_id`, `block_name`, `is_title`, `columns`, `block_sequence`) VALUES
('cases', 'edit', '1gdhxhgzxc740s0s48gccsscc', 'Notifications', 'N', 2, 4),
('cases', 'popup_edit', '12o8wcp9rre8s4c8ssgg40ks', 'Notifications', 'N', 2, 4),
('cases', 'view', '1awl8oi84ruskc8g8ww4gso44', 'Notifications', 'N', 2, 4);

INSERT INTO `db_blocks` (`app_name`, `form_name`, `block_id`, `block_name`, `is_title`, `columns`, `block_sequence`) VALUES
('cases_preferences', 'edit', '1i2zjqvfdem8w0owkcokw44gk', 'Main', 'N', 2, 2),
('cases_preferences', 'view', 'diun7r445vwo0g4wk8goo8s0', 'Main', 'N', 2, 2);

UPDATE `db_fields` SET `field_type` = 'DA' WHERE `db_fields`.`app_name` = 'cases' AND `db_fields`.`field_name` = 'due_date';

INSERT INTO `db_fields` (`app_name`, `table_name`, `field_name`, `is_custom`, `is_computed`, `field_type`, `field_label`, `field_height`, `field_default`, `related_table`, `related_id`, `related_name`, `related_filter`, `is_search`, `is_readonly`, `is_mandatory`, `is_unique`, `is_visible`, `search_sequence`, `result_sequence`, `result_class`, `bulk_sequence`, `bulk_side`, `bulk_block_id`, `view_sequence`, `view_side`, `view_block_id`, `edit_sequence`, `edit_side`, `edit_block_id`, `popup_search_sequence`, `popup_result_sequence`, `popup_view_sequence`, `popup_view_side`, `popup_view_block_id`, `popup_edit_sequence`, `popup_edit_side`, `popup_edit_block_id`, `linked_sequence`) VALUES
('cases', 'cases', 'reminder_email', 'N', 'N', 'RD', 'Reminder email', 1, '.', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '1awl8oi84ruskc8g8ww4gso44', 1, 'L', '1gdhxhgzxc740s0s48gccsscc', 0, 0, 0, 'L', '', 1, 'L', '12o8wcp9rre8s4c8ssgg40ks', 0),
('cases', 'cases', 'reminder_popup', 'N', 'N', 'RD', 'Reminder popup', 1, '.', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', '1awl8oi84ruskc8g8ww4gso44', 1, 'R', '1gdhxhgzxc740s0s48gccsscc', 0, 0, 0, 'L', '', 1, 'R', '12o8wcp9rre8s4c8ssgg40ks', 0);

INSERT INTO `db_fields` (`app_name`, `table_name`, `field_name`, `is_custom`, `is_computed`, `field_type`, `field_label`, `field_height`, `field_default`, `related_table`, `related_id`, `related_name`, `related_filter`, `is_search`, `is_readonly`, `is_mandatory`, `is_unique`, `is_visible`, `search_sequence`, `result_sequence`, `result_class`, `bulk_sequence`, `bulk_side`, `bulk_block_id`, `view_sequence`, `view_side`, `view_block_id`, `edit_sequence`, `edit_side`, `edit_block_id`, `popup_search_sequence`, `popup_result_sequence`, `popup_view_sequence`, `popup_view_side`, `popup_view_block_id`, `popup_edit_sequence`, `popup_edit_side`, `popup_edit_block_id`, `linked_sequence`) VALUES
('cases_preferences', 'cases_preferences', 'created', 'N', 'N', 'DT', 'Created', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('cases_preferences', 'cases_preferences', 'created_by', 'N', 'N', 'RR', 'Created by', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('cases_preferences', 'cases_preferences', 'priority_id', 'N', 'N', 'DD', 'Priority', 1, 'NO', 'cases_priorities', 'priority_id', 'priority_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'L', 'diun7r445vwo0g4wk8goo8s0', 1, 'L', '1i2zjqvfdem8w0owkcokw44gk', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('cases_preferences', 'cases_preferences', 'reminder_email', 'N', 'N', 'RD', 'Reminder email', 1, '1.D', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 2, 'L', 'diun7r445vwo0g4wk8goo8s0', 2, 'L', '1i2zjqvfdem8w0owkcokw44gk', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('cases_preferences', 'cases_preferences', 'reminder_popup', 'N', 'N', 'RD', 'Reminder popup', 1, '1.D', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 2, 'R', 'diun7r445vwo0g4wk8goo8s0', 2, 'R', '1i2zjqvfdem8w0owkcokw44gk', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('cases_preferences', 'cases_preferences', 'status_id', 'N', 'N', 'DD', 'Status', 1, 'NE', 'cases_statuses', 'status_id', 'status_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'R', 'diun7r445vwo0g4wk8goo8s0', 1, 'R', '1i2zjqvfdem8w0owkcokw44gk', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('cases_preferences', 'cases_preferences', 'updated', 'N', 'N', 'DT', 'Updated', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('cases_preferences', 'cases_preferences', 'updated_by', 'N', 'N', 'RR', 'Updated by', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('cases_preferences', 'cases_preferences', 'user_id', 'N', 'N', 'RK', 'User id', 1, '', '', '', '', '', 'N', 'Y', 'N', 'Y', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0);


DROP TABLE IF EXISTS `opportunities_preferences`;
CREATE TABLE IF NOT EXISTS `opportunities_preferences` (
  `user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `reminder_email` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '.',
  `reminder_popup` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '.',
  `source_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `stage_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `type_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

ALTER TABLE `opportunities` ADD `reminder_email` VARCHAR( 32 ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '.' AFTER `closing`;
ALTER TABLE `opportunities` ADD `reminder_popup` VARCHAR( 32 ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '.' AFTER `reminder_email`;

INSERT INTO `db_applications` (`app_name`, `app_label`, `app_sequence`, `status_id`, `table_name`, `field_name`, `is_related`, `is_visible`, `is_search`, `is_customizable`, `is_report`, `is_quickadd`, `excluded_tabs`) VALUES
('opportunities_preferences', 'Opportunities - Preferences', 5, 'S', 'opportunities_preferences', 'user_id', 'N', 'Y', 'N', 'N', 'N', 'N', '');

UPDATE  `db_blocks` SET  `block_sequence` = '4', `is_title` = 'N' WHERE `app_name` = 'opportunities' AND `block_name` = 'Note';
INSERT INTO `db_blocks` (`app_name`, `form_name`, `block_id`, `block_name`, `is_title`, `columns`, `block_sequence`) VALUES
('opportunities', 'edit', '1gdhxhgzxc740s0s48gccsscc', 'Notifications', 'N', 2, 3),
('opportunities', 'popup_edit', '12o8wcp9rre8s4c8ssgg40ks', 'Notifications', 'N', 2, 3),
('opportunities', 'view', '1awl8oi84ruskc8g8ww4gso44', 'Notifications', 'N', 2, 3);

INSERT INTO `db_blocks` (`app_name`, `form_name`, `block_id`, `block_name`, `is_title`, `columns`, `block_sequence`) VALUES
('opportunities_preferences', 'edit', '1iemzo2p2m5coogk4cc8ggo4w', 'Main', 'N', 2, 2),
('opportunities_preferences', 'edit', 'cuwnt8sx5a0wos0soc8w0sc0', 'Notifications', 'N', 2, 4),
('opportunities_preferences', 'view', '6xiorhx2lt0k048og4wo0wg', 'Notifications', 'N', 2, 4),
('opportunities_preferences', 'view', 'diun7r445vwo0g4wk8goo8s0', 'Main', 'N', 2, 2);

UPDATE `db_fields` SET `field_type` = 'DD',`field_label` = 'Type',`related_table` = 'types',`related_id` = 'type_id',`related_name` = 'type_name' WHERE `db_fields`.`app_name` = 'opportunities' AND `db_fields`.`field_name` = 'type_id';

INSERT INTO `db_fields` (`app_name`, `table_name`, `field_name`, `is_custom`, `is_computed`, `field_type`, `field_label`, `field_height`, `field_default`, `related_table`, `related_id`, `related_name`, `related_filter`, `is_search`, `is_readonly`, `is_mandatory`, `is_unique`, `is_visible`, `search_sequence`, `result_sequence`, `result_class`, `bulk_sequence`, `bulk_side`, `bulk_block_id`, `view_sequence`, `view_side`, `view_block_id`, `edit_sequence`, `edit_side`, `edit_block_id`, `popup_search_sequence`, `popup_result_sequence`, `popup_view_sequence`, `popup_view_side`, `popup_view_block_id`, `popup_edit_sequence`, `popup_edit_side`, `popup_edit_block_id`, `linked_sequence`) VALUES
('opportunities', 'opportunities', 'reminder_email', 'N', 'N', 'RD', 'Reminder email', 1, '.', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '1awl8oi84ruskc8g8ww4gso44', 1, 'L', '1gdhxhgzxc740s0s48gccsscc', 0, 0, 0, 'L', '', 1, 'L', '12o8wcp9rre8s4c8ssgg40ks', 0),
('opportunities', 'opportunities', 'reminder_popup', 'N', 'N', 'RD', 'Reminder popup', 1, '.', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', '1awl8oi84ruskc8g8ww4gso44', 1, 'R', '1gdhxhgzxc740s0s48gccsscc', 0, 0, 0, 'L', '', 1, 'R', '12o8wcp9rre8s4c8ssgg40ks', 0);

INSERT INTO `db_fields` (`app_name`, `table_name`, `field_name`, `is_custom`, `is_computed`, `field_type`, `field_label`, `field_height`, `field_default`, `related_table`, `related_id`, `related_name`, `related_filter`, `is_search`, `is_readonly`, `is_mandatory`, `is_unique`, `is_visible`, `search_sequence`, `result_sequence`, `result_class`, `bulk_sequence`, `bulk_side`, `bulk_block_id`, `view_sequence`, `view_side`, `view_block_id`, `edit_sequence`, `edit_side`, `edit_block_id`, `popup_search_sequence`, `popup_result_sequence`, `popup_view_sequence`, `popup_view_side`, `popup_view_block_id`, `popup_edit_sequence`, `popup_edit_side`, `popup_edit_block_id`, `linked_sequence`) VALUES
('opportunities_preferences', 'opportunities_preferences', 'created', 'N', 'N', 'DT', 'Created', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('opportunities_preferences', 'opportunities_preferences', 'created_by', 'N', 'N', 'RR', 'Created by', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('opportunities_preferences', 'opportunities_preferences', 'reminder_email', 'N', 'N', 'RD', 'Reminder email', 1, '1.D', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'L', '6xiorhx2lt0k048og4wo0wg', 1, 'L', 'cuwnt8sx5a0wos0soc8w0sc0', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('opportunities_preferences', 'opportunities_preferences', 'reminder_popup', 'N', 'N', 'RD', 'Reminder popup', 1, '1.D', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'R', '6xiorhx2lt0k048og4wo0wg', 1, 'R', 'cuwnt8sx5a0wos0soc8w0sc0', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('opportunities_preferences', 'opportunities_preferences', 'source_id', 'N', 'N', 'DD', 'Source', 1, 'NO', 'sources', 'source_id', 'source_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'L', 'diun7r445vwo0g4wk8goo8s0', 1, 'L', '1iemzo2p2m5coogk4cc8ggo4w', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('opportunities_preferences', 'opportunities_preferences', 'stage_id', 'N', 'N', 'DD', 'Stage', 1, 'NO', 'stages', 'stage_id', 'stage_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 2, 'L', 'diun7r445vwo0g4wk8goo8s0', 2, 'L', '1iemzo2p2m5coogk4cc8ggo4w', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('opportunities_preferences', 'opportunities_preferences', 'type_id', 'N', 'N', 'DD', 'Type', 1, 'NE', 'types', 'type_id', 'type_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'R', 'diun7r445vwo0g4wk8goo8s0', 1, 'R', '1iemzo2p2m5coogk4cc8ggo4w', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('opportunities_preferences', 'opportunities_preferences', 'updated', 'N', 'N', 'DT', 'Updated', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('opportunities_preferences', 'opportunities_preferences', 'updated_by', 'N', 'N', 'RR', 'Updated by', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('opportunities_preferences', 'opportunities_preferences', 'user_id', 'N', 'N', 'RK', 'User id', 1, '', '', '', '', '', 'N', 'Y', 'N', 'Y', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0);


DROP table IF EXISTS global_notifications_periods;
DROP VIEW IF EXISTS global_notifications_periods;
CREATE VIEW global_notifications_periods AS select * from appshore_global.notifications_periods;
