ALTER TABLE `activities_preferences` ADD `duration` int(11) NOT NULL DEFAULT '3600' AFTER `type_id`;

ALTER TABLE `company` ADD `is_ipacl` ENUM( "Y", "N" ) NOT NULL DEFAULT 'N' AFTER `administration_rbac_update`;
ALTER TABLE `company` ADD `ipacl` VARCHAR( 250 ) NOT NULL AFTER `is_ipacl`;

ALTER TABLE `contacts` ADD `avatar` VARCHAR( 250 ) NOT NULL AFTER `title`;

DROP TABLE IF EXISTS `dashboards`;
CREATE TABLE IF NOT EXISTS `dashboards` (
  `user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `column_nbr` enum('1','2') COLLATE utf8_unicode_ci NOT NULL,
  `dashlet_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `dashlet_sequence` tinyint(4) NOT NULL,
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `dashboards_boxes`;

ALTER TABLE `leads` ADD `avatar` VARCHAR( 250 ) NOT NULL AFTER `title`; 

ALTER TABLE `users` ADD `ipacl` VARCHAR( 250 ) NOT NULL AFTER `last_password_change`;
ALTER TABLE `users` ADD `avatar` VARCHAR( 250 ) NOT NULL AFTER `ipacl`;

INSERT INTO `db_fields` (`app_name`, `table_name`, `field_name`, `is_custom`, `is_computed`, `field_type`, `field_label`, `field_height`, `field_default`, `related_table`, `related_id`, `related_name`, `related_filter`, `is_search`, `is_readonly`, `is_mandatory`, `is_unique`, `is_visible`, `search_sequence`, `result_sequence`, `result_class`, `bulk_sequence`, `bulk_side`, `bulk_block_id`, `view_sequence`, `view_side`, `view_block_id`, `edit_sequence`, `edit_side`, `edit_block_id`, `popup_search_sequence`, `popup_result_sequence`, `popup_view_sequence`, `popup_view_side`, `popup_view_block_id`, `popup_edit_sequence`, `popup_edit_side`, `popup_edit_block_id`, `linked_sequence`) VALUES
('contacts', 'contacts', 'avatar', 'N', 'N', 'IM', 'Avatar', 9, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 1, 'grid_left', 0, 'L', '', 0, 'R', '', 0, 'R', '', 0, 0, 0, 'R', '', 0, 'R', '', 0),
('leads', 'leads', 'avatar', 'N', 'N', 'IM', 'Avatar', 9, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 1, 'grid_left', 0, 'L', '', 0, 'R', '', 0, 'R', '', 0, 0, 0, 'R', '', 0, 'R', '', 0);

UPDATE `db_applications` SET `app_sequence` = '15',`status_id` = 'A',`field_name` = 'user_id' WHERE `db_applications`.`app_name` = 'dashboards';

UPDATE `db_fields` SET `field_type` = 'EA' WHERE `db_fields`.`app_name` = 'campaigns' AND `db_fields`.`field_name` = 'body_html';

DELETE FROM `db_blocks` WHERE `db_blocks`.`app_name` = 'activities_preferences';
INSERT INTO `db_blocks` (`app_name`, `form_name`, `block_id`, `block_name`, `is_title`, `columns`, `block_sequence`) VALUES
('activities_preferences', 'edit', '9q73632yuxgcgc0g4c0wso08', 'New activity', 'Y', 2, 4),
('activities_preferences', 'edit', 'cz93mguyt7w44g800o4888s8', 'Notifications', 'N', 2, 6),
('activities_preferences', 'edit', 'i1ssa14wljk8c8ws0c4os0gw', 'Calendar', 'Y', 2, 2),
('activities_preferences', 'view', '2gj7q8ggm1a8000g8wwo8ow4', 'New activity', 'Y', 2, 4),
('activities_preferences', 'view', 'e06gt0i8dpck44kko8k0oow4', 'Notifications', 'N', 2, 6),
('activities_preferences', 'view', 'e22na4ejqjkg0kckg88csk4k', 'Calendar', 'Y', 2, 2);

DELETE FROM `db_fields` WHERE `db_fields`.`app_name` = 'activities_preferences';
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
('activities_preferences', 'activities_preferences', 'status_id', 'N', 'N', 'DD', 'Status', 1, '', 'activities_statuses', 'status_id', 'status_name', 'order by status_name', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 2, 'L', '2gj7q8ggm1a8000g8wwo8ow4', 2, 'L', '9q73632yuxgcgc0g4c0wso08', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'tab_id', 'N', 'Y', 'DD', 'Default tab', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'L', 'e22na4ejqjkg0kckg88csk4k', 1, 'L', 'i1ssa14wljk8c8ws0c4os0gw', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'type_id', 'N', 'N', 'DD', 'Type', 1, '', 'activities_types', 'type_id', 'type_name', 'order by type_name', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_right', 0, 'L', '', 1, 'R', '2gj7q8ggm1a8000g8wwo8ow4', 1, 'R', '9q73632yuxgcgc0g4c0wso08', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'updated', 'N', 'N', 'DT', 'Updated', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'updated_by', 'N', 'N', 'RR', 'Updated by', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('activities_preferences', 'activities_preferences', 'user_id', 'N', 'N', 'RK', 'User id', 1, '', '', '', '', '', 'N', 'Y', 'N', 'Y', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0);

DELETE FROM db_blocks where app_name = "administration_users";

INSERT INTO `db_blocks` (`app_name`, `form_name`, `block_id`, `block_name`, `is_title`, `columns`, `block_sequence`) VALUES
('administration_users', 'bulk', '13qfxwi7vfi8w', 'bulk', 'N', 2, 2),
('administration_users', 'edit', '1ixcu5lf30asg', 'Note', 'Y', 1, 11),
('administration_users', 'edit', '1q6htfo3inesk', 'Personal Information', 'Y', 2, 6),
('administration_users', 'edit', '1r2irncvnack0', 'Footer', 'N', 2, 13),
('administration_users', 'edit', '1s9mtebmfoo0o', 'Header', 'N', 2, 2),
('administration_users', 'edit', '2brr1b6lkeasw', 'Preferences', 'Y', 2, 8),
('administration_users', 'edit', 'kfpueqebytc0', 'Setup', 'Y', 2, 10),
('administration_users', 'edit', 'sif2w2u11r4g', 'Main', 'N', 2, 4),
('administration_users', 'popup_edit', '1op6wuzxu9fo', 'Header', 'N', 1, 1),
('administration_users', 'popup_edit', 'dxofjnamwhs0', 'Note', 'N', 1, 4),
('administration_users', 'popup_edit', 'vhl12f6951c4', 'Main', 'N', 2, 3),
('administration_users', 'popup_view', '1cz0xswt9tq84', 'Main', 'N', 2, 3),
('administration_users', 'popup_view', '1kfjzfu4tbb4s', 'Header', 'N', 1, 1),
('administration_users', 'popup_view', 'cqkdsoiy8hwg', 'Note', 'N', 1, 4),
('administration_users', 'view', '13aq5ko2z6m8w0gws4g4s00w8', 'Header', 'N', 2, 3),
('administration_users', 'view', '1c3rbn2x5hb4kscgc4s44wwg8', 'Main', 'N', 2, 5),
('administration_users', 'view', '1ie69957sr40wcocc880gksgk', 'Setup', 'Y', 2, 11),
('administration_users', 'view', '37tntojlesow4844cwkgo80c', 'Note', 'Y', 1, 12),
('administration_users', 'view', 'hqrn9uvotqo80sc480s0cswo', 'Personal Information', 'Y', 2, 7),
('administration_users', 'view', 'xpbxva0hj2so0ok840gsk4w', 'Footer', 'N', 2, 14),
('administration_users', 'view', 'y1n6wqpj9mskwws4w8s48gc', 'Preferences', 'Y', 2, 9);

DELETE FROM db_fields where app_name = "administration_users";

INSERT INTO `db_fields` (`app_name`, `table_name`, `field_name`, `is_custom`, `is_computed`, `field_type`, `field_label`, `field_height`, `field_default`, `related_table`, `related_id`, `related_name`, `related_filter`, `is_search`, `is_readonly`, `is_mandatory`, `is_unique`, `is_visible`, `search_sequence`, `result_sequence`, `result_class`, `bulk_sequence`, `bulk_side`, `bulk_block_id`, `view_sequence`, `view_side`, `view_block_id`, `edit_sequence`, `edit_side`, `edit_block_id`, `popup_search_sequence`, `popup_result_sequence`, `popup_view_sequence`, `popup_view_side`, `popup_view_block_id`, `popup_edit_sequence`, `popup_edit_side`, `popup_edit_block_id`, `linked_sequence`) VALUES
('administration_users', 'users', 'app_name', 'N', 'N', 'DD', 'Default application', 1, 'api', 'db_applications', 'app_name', 'app_label', 'where is_visible = "Y" and status_id = "A" order by app_label', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', 'y1n6wqpj9mskwws4w8s48gc', 1, 'L', '2brr1b6lkeasw', 0, 0, 0, 'L', '13z2ehlofjuow', 0, 'L', 'da9w2y9gqxkc', 0),
('administration_users', 'users', 'assistant_id', 'N', 'N', 'DD', 'Assistant', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 1, 'R', '13qfxwi7vfi8w', 6, 'R', '1c3rbn2x5hb4kscgc4s44wwg8', 6, 'R', 'sif2w2u11r4g', 5, 0, 6, 'R', '1cz0xswt9tq84', 6, 'R', 'vhl12f6951c4', 0),
('administration_users', 'users', 'avatar', 'N', 'N', 'IM', 'Avatar', 9, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 1, 'grid_center', 0, 'L', '', 1, 'R', '13aq5ko2z6m8w0gws4g4s00w8', 1, 'R', '1s9mtebmfoo0o', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_users', 'users', 'birthdate', 'N', 'N', 'DA', 'Date of birth', 1, '0000-00-00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', 'hqrn9uvotqo80sc480s0cswo', 1, 'L', '1q6htfo3inesk', 0, 0, 0, 'L', '1pz3r2tgoyo0s', 0, 'L', 'sr1hn2m5y684', 0),
('administration_users', 'users', 'charset_id', 'N', 'N', 'DD', 'Character set', 1, 'UTF-8', 'global_charsets', 'charset_id', 'charset_name', 'order by charset_name', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', 'y1n6wqpj9mskwws4w8s48gc', 2, 'R', '2brr1b6lkeasw', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_users', 'users', 'confirm_delete', 'N', 'N', 'CH', 'Confirm delete', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '13qfxwi7vfi8w', 5, 'L', 'y1n6wqpj9mskwws4w8s48gc', 5, 'L', '2brr1b6lkeasw', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('administration_users', 'users', 'created', 'N', 'N', 'TS', 'Created', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '1bcrvou4l58g40cogogkos44c', 0, 'L', '', 0, 0, 0, 'L', '1lmo16svlpdwo', 0, 'L', '', 0),
('administration_users', 'users', 'created_by', 'N', 'N', 'RR', 'Created by', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_users', 'users', 'currency_id', 'N', 'N', 'DD', 'Currency', 1, 'USD', 'global_currencies', 'currency_id', 'currency_name', ' order by currency_name', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'L', 'y1n6wqpj9mskwws4w8s48gc', 4, 'L', '2brr1b6lkeasw', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('administration_users', 'users', 'department_id', 'N', 'N', 'DD', 'Department', 1, '', 'departments', 'department_id', 'department_name', '', 'N', 'N', 'N', 'N', 'Y', 4, 7, 'grid_left', 3, 'R', '13qfxwi7vfi8w', 4, 'R', '1c3rbn2x5hb4kscgc4s44wwg8', 4, 'R', 'sif2w2u11r4g', 3, 3, 4, 'R', '1cz0xswt9tq84', 4, 'R', 'vhl12f6951c4', 4),
('administration_users', 'users', 'email', 'N', 'N', 'WM', 'Email', 1, '', '', '', '', '', 'N', 'N', 'Y', 'Y', 'Y', 3, 6, 'grid_left', 0, 'L', '', 5, 'L', '1c3rbn2x5hb4kscgc4s44wwg8', 5, 'L', 'sif2w2u11r4g', 0, 6, 5, 'L', '1cz0xswt9tq84', 5, 'L', 'vhl12f6951c4', 7),
('administration_users', 'users', 'fax', 'N', 'N', 'TE', 'Fax', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 6, 'L', '1c3rbn2x5hb4kscgc4s44wwg8', 6, 'L', 'sif2w2u11r4g', 0, 0, 6, 'L', '1cz0xswt9tq84', 6, 'L', 'vhl12f6951c4', 0),
('administration_users', 'users', 'first_names', 'N', 'N', 'VF', 'First name', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '1c3rbn2x5hb4kscgc4s44wwg8', 1, 'L', 'sif2w2u11r4g', 0, 0, 1, 'L', '1cz0xswt9tq84', 1, 'L', 'vhl12f6951c4', 2),
('administration_users', 'users', 'full_name', 'N', 'N', 'TE', 'Full name', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 2, 3, 'grid_left', 0, 'L', '', 0, 'L', '9gba8zpqcnwg', 0, 'L', '', 2, 2, 0, 'L', '', 0, 'L', '', 0),
('administration_users', 'users', 'initial_role_id', 'N', 'N', 'DD', 'Initial role', 1, '', 'roles', 'role_id', 'role_name', 'order by role_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 2, 'L', '13qfxwi7vfi8w', 1, 'R', '1ie69957sr40wcocc880gksgk', 1, 'R', 'kfpueqebytc0', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('administration_users', 'users', 'ipacl', 'N', 'N', 'TE', 'Ipacl', 1, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_users', 'users', 'is_salespeople', 'N', 'N', 'CH', 'Sales people', 1, 'N', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '13qfxwi7vfi8w', 3, 'R', '1c3rbn2x5hb4kscgc4s44wwg8', 3, 'R', 'sif2w2u11r4g', 0, 0, 3, 'R', '1cz0xswt9tq84', 3, 'R', 'vhl12f6951c4', 0),
('administration_users', 'users', 'language_id', 'N', 'N', 'DD', 'Language', 1, 'en', 'global_languages', 'language_id', 'language_name', ' order by language_id', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', 'y1n6wqpj9mskwws4w8s48gc', 1, 'R', '2brr1b6lkeasw', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('administration_users', 'users', 'last_login', 'N', 'N', 'TS', 'Last login', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 8, 'grid_center', 0, 'L', '', 1, 'L', 'xpbxva0hj2so0ok840gsk4w', 1, 'L', '1r2irncvnack0', 0, 0, 0, 'L', '1lmo16svlpdwo', 0, 'L', '', 0),
('administration_users', 'users', 'last_name', 'N', 'N', 'VF', 'Last name', 1, '', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', '1c3rbn2x5hb4kscgc4s44wwg8', 1, 'R', 'sif2w2u11r4g', 0, 0, 1, 'R', '1cz0xswt9tq84', 1, 'R', 'vhl12f6951c4', 3),
('administration_users', 'users', 'last_password_change', 'N', 'N', 'TS', 'Last password change', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'R', 'xpbxva0hj2so0ok840gsk4w', 1, 'R', '1r2irncvnack0', 0, 0, 0, 'R', '1lmo16svlpdwo', 0, 'L', '', 0),
('administration_users', 'users', 'locale_date_id', 'N', 'N', 'DD', 'Date format', 1, 'en_US', 'global_locales_date', 'date_id', 'date_label', ' order by date_label', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'R', 'y1n6wqpj9mskwws4w8s48gc', 3, 'R', '2brr1b6lkeasw', 0, 0, 0, 'L', '13z2ehlofjuow', 0, 'L', 'da9w2y9gqxkc', 0),
('administration_users', 'users', 'locale_time_id', 'N', 'N', 'DD', 'Time format', 1, 'en_US', 'global_locales_time', 'time_id', 'time_label', ' order by time_label', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 4, 'R', 'y1n6wqpj9mskwws4w8s48gc', 4, 'R', '2brr1b6lkeasw', 0, 0, 0, 'L', '13z2ehlofjuow', 0, 'L', 'da9w2y9gqxkc', 0),
('administration_users', 'users', 'manager_id', 'N', 'N', 'DD', 'Manager', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 2, 'R', '13qfxwi7vfi8w', 5, 'R', '1c3rbn2x5hb4kscgc4s44wwg8', 5, 'R', 'sif2w2u11r4g', 4, 0, 5, 'R', '1cz0xswt9tq84', 5, 'R', 'vhl12f6951c4', 0),
('administration_users', 'users', 'mobile', 'N', 'N', 'TE', 'Mobile', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 5, 'grid_left', 0, 'L', '', 3, 'L', '1c3rbn2x5hb4kscgc4s44wwg8', 3, 'L', 'sif2w2u11r4g', 0, 5, 3, 'L', '1cz0xswt9tq84', 3, 'L', 'vhl12f6951c4', 6),
('administration_users', 'users', 'nbrecords', 'N', 'N', 'DD', 'Lines displayed', 1, '10', 'global_lines', 'line_id', 'line_name', 'order by line_name', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 5, 'R', 'y1n6wqpj9mskwws4w8s48gc', 5, 'R', '2brr1b6lkeasw', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_users', 'users', 'note', 'N', 'N', 'ML', 'Note', 5, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '37tntojlesow4844cwkgo80c', 1, 'L', '1ixcu5lf30asg', 0, 0, 1, 'L', 'cqkdsoiy8hwg', 1, 'L', 'dxofjnamwhs0', 0),
('administration_users', 'users', 'notifications_location', 'N', 'N', 'CH', 'Notifications location', 1, 'TC', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_users', 'users', 'password', 'N', 'N', 'TE', 'Password', 1, '', '', '', '', '', 'N', 'Y', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_users', 'users', 'phone', 'N', 'N', 'TE', 'Phone', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 4, 'grid_left', 0, 'L', '', 4, 'L', '1c3rbn2x5hb4kscgc4s44wwg8', 4, 'L', 'sif2w2u11r4g', 0, 4, 4, 'L', '1cz0xswt9tq84', 4, 'L', 'vhl12f6951c4', 5),
('administration_users', 'users', 'private_email', 'N', 'N', 'WM', 'Private email', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', 'hqrn9uvotqo80sc480s0cswo', 1, 'R', '1q6htfo3inesk', 0, 0, 0, 'R', '1pz3r2tgoyo0s', 0, 'R', 'sr1hn2m5y684', 0),
('administration_users', 'users', 'private_mobile', 'N', 'N', 'TE', 'Private mobile', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', 'hqrn9uvotqo80sc480s0cswo', 2, 'R', '1q6htfo3inesk', 0, 0, 0, 'R', '1pz3r2tgoyo0s', 0, 'R', 'sr1hn2m5y684', 0),
('administration_users', 'users', 'private_phone', 'N', 'N', 'TE', 'Private phone', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', 'hqrn9uvotqo80sc480s0cswo', 2, 'L', '1q6htfo3inesk', 0, 0, 0, 'L', '1pz3r2tgoyo0s', 0, 'L', 'sr1hn2m5y684', 0),
('administration_users', 'users', 'reset_password', 'N', 'Y', 'CH', 'Reset password', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 3, 'L', '13qfxwi7vfi8w', 2, 'R', '1ie69957sr40wcocc880gksgk', 2, 'L', 'kfpueqebytc0', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('administration_users', 'users', 'salutation', 'N', 'N', 'TE', 'Salutation', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', '1c3rbn2x5hb4kscgc4s44wwg8', 2, 'L', 'sif2w2u11r4g', 0, 0, 2, 'L', '1cz0xswt9tq84', 2, 'L', 'vhl12f6951c4', 0),
('administration_users', 'users', 'send_welcome_email', 'N', 'Y', 'CH', 'Send welcome email', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 2, 'L', '13qfxwi7vfi8w', 1, 'L', '1ie69957sr40wcocc880gksgk', 1, 'L', 'kfpueqebytc0', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('administration_users', 'users', 'skin_id', 'N', 'N', 'DD', 'Skin', 1, 'default', 'global_skins', 'skin_id', 'skin_name', ' order by skin_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'R', '2brr1b6lkeasw', 0, 0, 0, 'L', '13z2ehlofjuow', 0, 'L', 'da9w2y9gqxkc', 0),
('administration_users', 'users', 'status_id', 'N', 'N', 'DD', 'User status', 1, 'A', 'users_statuses', 'status_id', 'status_name', 'where status_id in ("A","D") order by status_name', 'N', 'N', 'Y', 'N', 'Y', 5, 9, 'grid_left', 1, 'L', '13qfxwi7vfi8w', 2, 'L', '13aq5ko2z6m8w0gws4g4s00w8', 2, 'L', '1s9mtebmfoo0o', 0, 0, 0, 'R', '1bwu9iw9qois8', 0, 'R', '1lp4pvgw4f8k0', 8),
('administration_users', 'users', 'theme_id', 'N', 'N', 'DD', 'Theme', 1, 'default', 'global_themes', 'theme_id', 'theme_name', ' order by theme_name', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', 'y1n6wqpj9mskwws4w8s48gc', 2, 'L', '2brr1b6lkeasw', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('administration_users', 'users', 'timezone_id', 'N', 'Y', 'DD', 'Timezone', 1, '225', '', '', '', '', 'N', 'N', 'Y', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', 'y1n6wqpj9mskwws4w8s48gc', 3, 'L', '2brr1b6lkeasw', 0, 0, 0, 'L', '13z2ehlofjuow', 0, 'L', 'da9w2y9gqxkc', 0),
('administration_users', 'users', 'title', 'N', 'N', 'TE', 'Title', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', '1c3rbn2x5hb4kscgc4s44wwg8', 2, 'R', 'sif2w2u11r4g', 0, 0, 2, 'R', '1cz0xswt9tq84', 2, 'R', 'vhl12f6951c4', 0),
('administration_users', 'users', 'updated', 'N', 'N', 'TS', 'Updated', 1, '0000-00-00 00:00:00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'R', '1bcrvou4l58g40cogogkos44c', 0, 'R', '', 0, 0, 0, 'R', '1lmo16svlpdwo', 0, 'L', '', 0),
('administration_users', 'users', 'updated_by', 'N', 'N', 'RR', 'Updated by', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_users', 'users', 'user_id', 'N', 'N', 'RK', 'User identifier', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', '13aq5ko2z6m8w0gws4g4s00w8', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('administration_users', 'users', 'user_name', 'N', 'N', 'VF', 'User name', 1, '', '', '', '', '', 'N', 'N', 'Y', 'Y', 'Y', 1, 2, 'grid_left', 0, 'L', '', 1, 'L', '13aq5ko2z6m8w0gws4g4s00w8', 1, 'L', '1s9mtebmfoo0o', 1, 1, 1, 'L', '1kfjzfu4tbb4s', 1, 'L', '1op6wuzxu9fo', 1);

DELETE FROM db_blocks where app_name = "preferences_profile";

INSERT INTO `db_blocks` (`app_name`, `form_name`, `block_id`, `block_name`, `is_title`, `columns`, `block_sequence`) VALUES
('preferences_profile', 'edit', '10ai7betb800w4csco8owcosg', 'Main', 'N', 2, 4),
('preferences_profile', 'edit', '12uanve0br34kcgo0wcs0csws', 'Body', 'N', 2, 6),
('preferences_profile', 'edit', '1i9lkua03tr4c4ssooc0s88ko', 'Note', 'N', 1, 9),
('preferences_profile', 'edit', '57nq6t21izcws0ocgkcc0kww', 'Footer', 'N', 2, 11),
('preferences_profile', 'edit', '6izgizweehwk0kw44g8ckgss', 'Private', 'Y', 2, 8),
('preferences_profile', 'edit', '6ud3rec4mug48cs48k4ckogg', 'Header', 'N', 2, 2),
('preferences_profile', 'popup_edit', '1lstr1vwvfogg', 'Note', 'N', 1, 5),
('preferences_profile', 'popup_edit', '1pxj7dkwrcg0', 'Header', 'N', 2, 2),
('preferences_profile', 'popup_edit', '2bszdlp7ppes4', 'Body', 'N', 2, 4),
('preferences_profile', 'popup_view', '2ottxtlabo4kog8c8c4w80co', 'Main', 'N', 2, 4),
('preferences_profile', 'popup_view', '77ch338qqr8coosww8go0oc0', 'Body', 'N', 2, 6),
('preferences_profile', 'popup_view', 'k5fns2beatc4w448csg0ss08', 'Header', 'N', 2, 2),
('preferences_profile', 'popup_view', 'kags62xb8ogos880ssg4cs8k', 'Note', 'N', 1, 7),
('preferences_profile', 'view', '118iuwd6a528g', 'Body', 'N', 2, 6),
('preferences_profile', 'view', '1963bv96yvtw84sw8c8s8ocs4', 'Main', 'N', 2, 4),
('preferences_profile', 'view', '9dun4w391wso', 'Note', 'N', 1, 9),
('preferences_profile', 'view', '9l8phqq6ujwo', 'Footer', 'N', 2, 11),
('preferences_profile', 'view', 'i04t6quk6f40wg4w80444sk8', 'Private', 'Y', 2, 8),
('preferences_profile', 'view', 'tqrgvar474g8', 'Header', 'N', 2, 2);

DELETE FROM db_fields where app_name = "preferences_profile";

INSERT INTO `db_fields` (`app_name`, `table_name`, `field_name`, `is_custom`, `is_computed`, `field_type`, `field_label`, `field_height`, `field_default`, `related_table`, `related_id`, `related_name`, `related_filter`, `is_search`, `is_readonly`, `is_mandatory`, `is_unique`, `is_visible`, `search_sequence`, `result_sequence`, `result_class`, `bulk_sequence`, `bulk_side`, `bulk_block_id`, `view_sequence`, `view_side`, `view_block_id`, `edit_sequence`, `edit_side`, `edit_block_id`, `popup_search_sequence`, `popup_result_sequence`, `popup_view_sequence`, `popup_view_side`, `popup_view_block_id`, `popup_edit_sequence`, `popup_edit_side`, `popup_edit_block_id`, `linked_sequence`) VALUES
('preferences_profile', 'users', 'app_name', 'N', 'N', 'TE', 'App name', 1, 'api', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_profile', 'users', 'assistant_id', 'N', 'N', 'RR', 'Assistant', 1, '', 'users', 'user_id', 'full_name', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', '1963bv96yvtw84sw8c8s8ocs4', 1, 'R', '10ai7betb800w4csco8owcosg', 0, 0, 1, 'R', '2ottxtlabo4kog8c8c4w80co', 4, 'R', '1pxj7dkwrcg0', 0),
('preferences_profile', 'users', 'avatar', 'N', 'N', 'IM', 'Avatar', 9, '', '', '', '', '', 'Y', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 1, 'R', 'tqrgvar474g8', 1, 'R', '6ud3rec4mug48cs48k4ckogg', 0, 0, 1, 'R', 'k5fns2beatc4w448csg0ss08', 0, 'L', '', 0),
('preferences_profile', 'users', 'birthdate', 'N', 'N', 'DA', 'Date of birth', 1, '0000-00-00', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 2, 'R', 'i04t6quk6f40wg4w80444sk8', 2, 'R', '6izgizweehwk0kw44g8ckgss', 0, 0, 0, 'R', '1ye4l211mvc0gc00c80k0gckw', 4, 'R', '2bszdlp7ppes4', 0),
('preferences_profile', 'users', 'charset_id', 'N', 'N', 'DD', 'Charset id', 1, 'UTF-8', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
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
('preferences_profile', 'users', 'user_status', 'N', 'N', 'CH', 'User status', 1, 'A', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0);


DROP table IF EXISTS global_charsets;
DROP VIEW IF EXISTS global_charsets;
CREATE VIEW global_charsets AS select * from appshore_global.charsets;		
	
DROP table IF EXISTS global_countries;
DROP VIEW IF EXISTS global_countries;
CREATE VIEW global_countries AS select * from appshore_global.countries;

DROP table IF EXISTS global_countries_states;
DROP VIEW IF EXISTS global_countries_states;
CREATE VIEW global_countries_states AS select * from appshore_global.countries_states;

DROP table IF EXISTS global_currencies;
DROP VIEW IF EXISTS global_currencies;
CREATE VIEW global_currencies AS select * from appshore_global.currencies where (is_available = _utf8'Y');

DROP table IF EXISTS global_dashlets;
DROP VIEW IF EXISTS global_dashlets;
CREATE VIEW global_dashlets AS select * from appshore_global.dashlets where (is_available = _utf8'Y');

DROP table IF EXISTS global_editions;
DROP VIEW IF EXISTS global_editions;
CREATE VIEW global_editions AS select * from appshore_global.editions;

DROP table IF EXISTS global_editions_applications;
DROP VIEW IF EXISTS global_editions_applications;
CREATE VIEW global_editions_applications AS select * from appshore_global.editions_applications;

DROP table IF EXISTS global_editions_metrics;
DROP VIEW IF EXISTS global_editions_metrics;
CREATE VIEW global_editions_metrics AS select * from appshore_global.editions_metrics;

DROP table IF EXISTS global_editions_periods;
DROP VIEW IF EXISTS global_editions_periods;
CREATE VIEW global_editions_periods AS select * from appshore_global.editions_periods;

DROP table IF EXISTS global_languages;
DROP VIEW IF EXISTS global_languages;
CREATE VIEW global_languages AS select * from appshore_global.languages where (is_available = _utf8'Y');

DROP table IF EXISTS global_locales_date;
DROP VIEW IF EXISTS global_locales_date;
CREATE VIEW global_locales_date AS select * from appshore_global.locales_date;

DROP table IF EXISTS global_locales_time;
DROP VIEW IF EXISTS global_locales_time;
CREATE VIEW global_locales_time AS select * from appshore_global.locales_time;

DROP table IF EXISTS global_lines;
DROP VIEW IF EXISTS global_lines;
CREATE VIEW global_lines AS select * from appshore_global.lines order by line_name;

DROP table IF EXISTS global_months;
DROP VIEW IF EXISTS global_months;
CREATE VIEW global_months AS select * from appshore_global.months;

DROP table IF EXISTS global_notifications_periods;
DROP VIEW IF EXISTS global_notifications_periods;
CREATE VIEW global_notifications_periods AS select * from appshore_global.notifications_periods;

DROP table IF EXISTS global_notifications_statuses;
DROP VIEW IF EXISTS global_notifications_statuses;
CREATE VIEW global_notifications_statuses AS select * from appshore_global.notifications_statuses;

DROP table IF EXISTS global_notifications_types;
DROP VIEW IF EXISTS global_notifications_types;
CREATE VIEW global_notifications_types AS select * from appshore_global.notifications_types;

DROP table IF EXISTS global_themes;
DROP VIEW IF EXISTS global_themes;
CREATE VIEW global_themes AS select * from appshore_global.themes where (is_available = _utf8'Y');

DROP TABLE IF EXISTS global_translation;
DROP VIEW IF EXISTS global_translation;
CREATE VIEW global_translation AS select * from appshore_global.translation;

CREATE TABLE IF NOT EXISTS translation (PRIMARY KEY(phrase)) select * from global_translation where 1=2;

DROP table IF EXISTS translation_view;
DROP VIEW IF EXISTS translation_view;
CREATE VIEW translation_view as SELECT * FROM translation union SELECT * FROM global_translation where phrase not in (select phrase from translation);


