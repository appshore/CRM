DELETE FROM `db_fields` WHERE field_name = "skin_id";
ALTER TABLE `users` ADD `initial_role_id` VARCHAR( 32 ) NOT NULL AFTER `theme_id`;
