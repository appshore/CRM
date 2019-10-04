INSERT INTO `db_applications` (`app_name`, `app_label`, `app_sequence`, `status_id`, `table_name`, `field_name`, `is_related`, `is_visible`, `is_search`, `is_customizable`, `is_report`, `is_quickadd`, `excluded_tabs`) VALUES
('dailies', 'Dailies', 5, 'A', 'dailies', 'daily_id', 'N', 'Y', 'Y', 'Y', 'Y', 'N', '');

INSERT INTO `db_applications` (`app_name`, `app_label`, `app_sequence`, `status_id`, `table_name`, `field_name`, `is_related`, `is_visible`, `is_search`, `is_customizable`, `is_report`, `is_quickadd`, `excluded_tabs`) VALUES
('dailies_preferences', 'Dailies - Preferences', 5, 'S', 'dailies_preferences', 'user_id', 'N', 'Y', 'N', 'N', 'N', 'N', '');

INSERT INTO  `permissions` (`role_id` ,`app_name` ,`level` ,`import` ,`export`) VALUES
('admin',  'dailies',  '127',  '1',  '1');


INSERT INTO `db_applications` (`app_name`, `app_label`, `app_sequence`, `status_id`, `table_name`, `field_name`, `is_related`, `is_visible`, `is_search`, `is_customizable`, `is_report`, `is_quickadd`, `excluded_tabs`) VALUES
('notes', 'Notes', 5, 'A', 'notes', 'note_id', 'N', 'Y', 'Y', 'Y', 'Y', 'N', '');

INSERT INTO `db_applications` (`app_name`, `app_label`, `app_sequence`, `status_id`, `table_name`, `field_name`, `is_related`, `is_visible`, `is_search`, `is_customizable`, `is_report`, `is_quickadd`, `excluded_tabs`) VALUES
('notes_preferences', 'Notes - Preferences', 5, 'S', 'notes_preferences', 'user_id', 'N', 'Y', 'N', 'N', 'N', 'N', '');

INSERT INTO  `permissions` (`role_id` ,`app_name` ,`level` ,`import` ,`export`) VALUES
('admin',  'notes',  '127',  '1',  '1');

