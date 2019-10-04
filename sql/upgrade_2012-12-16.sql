ALTER TABLE `accounts` CHANGE `address_billing` `address_billing` VARCHAR( 1000 ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL;
ALTER TABLE `accounts` CHANGE `address_shipping` `address_shipping` VARCHAR( 1000 ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL;

ALTER TABLE `contacts` CHANGE `address_1` `address_1` VARCHAR( 1000 ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL;
ALTER TABLE `contacts` CHANGE `address_2` `address_2` VARCHAR( 1000 ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL;

ALTER TABLE `leads` CHANGE `address_1` `address_1` VARCHAR( 1000 ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL;

set @exist := (SELECT COUNT(*) FROM information_schema.statistics WHERE table_schema = DATABASE() AND table_name = 'sales_teams' AND index_name = 'team_name');
set @sqlstmt := if( @exist > 0, 'DROP INDEX team_name ON sales_teams','OPTIMIZE TABLE sales_teams');
PREPARE stmt FROM @sqlstmt;
EXECUTE stmt;
ALTER TABLE `sales_teams` ADD UNIQUE `team_name` ( `team_name` );

ALTER TABLE `users` ADD `notify_owner` ENUM( 'Y', 'N' ) NOT NULL DEFAULT 'N' AFTER `notifications_location` ,
ADD `notify_me` ENUM( 'Y', 'N' ) NOT NULL DEFAULT 'N' AFTER `notify_owner`;

DELETE FROM `db_blocks` WHERE `app_name` = 'preferences_lookandfeel';
INSERT INTO `db_blocks` (`app_name`, `form_name`, `block_id`, `block_name`, `is_title`, `columns`, `block_sequence`) VALUES
('preferences_lookandfeel', 'edit', '10ragq2617itc', 'Theme', 'Y', 1, 5),
('preferences_lookandfeel', 'edit', '12238nyd9hxc0', 'Main', 'N', 2, 2),
('preferences_lookandfeel', 'edit', '1h90e2frullvk', 'Locale', 'Y', 2, 4),
('preferences_lookandfeel', 'view', '1fa93ag8kvwg8o8ss44w000cg', 'Theme', 'Y', 1, 5),
('preferences_lookandfeel', 'view', 'dwcouzp78tck4gkos40o4sos', 'Locale', 'Y', 2, 4),
('preferences_lookandfeel', 'view', 'dzw7l3yrs9w0gsw4goocs4g8', 'Main', 'N', 2, 2);

DELETE FROM `db_fields` WHERE `app_name` = 'preferences_lookandfeel';
INSERT INTO `db_fields` (`app_name`, `table_name`, `field_name`, `is_custom`, `is_computed`, `field_type`, `field_label`, `field_height`, `field_default`, `related_table`, `related_id`, `related_name`, `related_filter`, `is_search`, `is_readonly`, `is_mandatory`, `is_unique`, `is_visible`, `search_sequence`, `result_sequence`, `result_class`, `bulk_sequence`, `bulk_side`, `bulk_block_id`, `view_sequence`, `view_side`, `view_block_id`, `edit_sequence`, `edit_side`, `edit_block_id`, `popup_search_sequence`, `popup_result_sequence`, `popup_view_sequence`, `popup_view_side`, `popup_view_block_id`, `popup_edit_sequence`, `popup_edit_side`, `popup_edit_block_id`, `linked_sequence`) VALUES
('preferences_lookandfeel', 'users', 'app_name', 'N', 'N', 'DD', 'Default application', 1, 'api', 'db_applications', 'app_name', 'app_label', 'where is_visible = "Y" and status_id = "A" order by app_label', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', 'dzw7l3yrs9w0gsw4goocs4g8', 1, 'L', '12238nyd9hxc0', 0, 0, 0, 'L', '13z2ehlofjuow', 0, 'L', 'da9w2y9gqxkc', 0),
('preferences_lookandfeel', 'users', 'charset_id', 'N', 'N', 'DD', 'Character set', 1, 'UTF-8', 'global_charsets', 'charset_id', 'charset_name', 'order by charset_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', 'dwcouzp78tck4gkos40o4sos', 1, 'R', '1h90e2frullvk', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_lookandfeel', 'users', 'confirm_delete', 'N', 'N', 'CH', 'Confirm delete', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '13qfxwi7vfi8w', 2, 'L', 'dzw7l3yrs9w0gsw4goocs4g8', 2, 'L', '12238nyd9hxc0', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('preferences_lookandfeel', 'users', 'currency_id', 'N', 'N', 'DD', 'Currency', 1, 'USD', 'global_currencies', 'currency_id', 'currency_name', ' order by currency_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'L', 'dwcouzp78tck4gkos40o4sos', 2, 'L', '1h90e2frullvk', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('preferences_lookandfeel', 'users', 'language_id', 'N', 'N', 'DD', 'Language', 1, 'en', 'global_languages', 'language_id', 'language_name', ' order by language_id', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', 'dwcouzp78tck4gkos40o4sos', 1, 'L', '1h90e2frullvk', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('preferences_lookandfeel', 'users', 'locale_date_id', 'N', 'N', 'DD', 'Format date', 1, 'en_US', 'global_locales_date', 'date_id', 'date_label', ' order by date_label', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 2, 'R', 'dwcouzp78tck4gkos40o4sos', 2, 'R', '1h90e2frullvk', 0, 0, 0, 'L', '13z2ehlofjuow', 0, 'L', 'da9w2y9gqxkc', 0),
('preferences_lookandfeel', 'users', 'locale_time_id', 'N', 'N', 'DD', 'Format time', 1, 'en_US', 'global_locales_time', 'time_id', 'time_label', ' order by time_label', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'R', 'dwcouzp78tck4gkos40o4sos', 3, 'R', '1h90e2frullvk', 0, 0, 0, 'L', '13z2ehlofjuow', 0, 'L', 'da9w2y9gqxkc', 0),
('preferences_lookandfeel', 'users', 'nbrecords', 'N', 'N', 'DD', 'Lines displayed', 1, '10', 'global_lines', 'line_id', 'line_name', 'order by line_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'R', 'dzw7l3yrs9w0gsw4goocs4g8', 1, 'R', '12238nyd9hxc0', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_lookandfeel', 'users', 'notifications_location', 'N', 'Y', 'DD', 'Notifications location', 1, 'TC', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '', 3, 'L', 'dzw7l3yrs9w0gsw4goocs4g8', 3, 'L', '12238nyd9hxc0', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_lookandfeel', 'users', 'theme_id', 'N', 'N', 'DD', 'Theme', 1, 'default', 'global_themes', 'theme_id', 'theme_name', ' order by theme_name', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 1, 'L', '1fa93ag8kvwg8o8ss44w000cg', 1, 'L', '10ragq2617itc', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('preferences_lookandfeel', 'users', 'timezone_id', 'N', 'Y', 'DD', 'Timezone', 1, '225', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 3, 'L', 'dwcouzp78tck4gkos40o4sos', 3, 'L', '1h90e2frullvk', 0, 0, 0, 'L', '13z2ehlofjuow', 0, 'L', 'da9w2y9gqxkc', 0),
('preferences_lookandfeel', 'users', 'user_id', 'N', 'N', 'RK', 'User identifier', 1, '', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_left', 0, 'L', '', 0, 'L', '', 0, 'L', '', 0, 0, 0, 'L', '', 0, 'L', '', 0),
('preferences_lookandfeel', 'users', 'notify_owner', 'N', 'N', 'CH', 'Notify (new) owner by email when a record is created, updated or assigned', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '13qfxwi7vfi8w', 2, 'R', 'dzw7l3yrs9w0gsw4goocs4g8', 2, 'R', '12238nyd9hxc0', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0),
('preferences_lookandfeel', 'users', 'notify_me', 'N', 'N', 'CH', 'Notify me if owner is notified', 1, 'Y', '', '', '', '', 'N', 'N', 'N', 'N', 'Y', 0, 0, 'grid_center', 0, 'L', '13qfxwi7vfi8w', 3, 'R', 'dzw7l3yrs9w0gsw4goocs4g8', 3, 'R', '12238nyd9hxc0', 0, 0, 0, 'R', '13z2ehlofjuow', 0, 'R', 'da9w2y9gqxkc', 0);

