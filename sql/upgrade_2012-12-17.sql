ALTER TABLE `db_fields` ADD `is_result` ENUM('Y','N') NOT NULL DEFAULT 'N' AFTER `is_visible`;

UPDATE db_fields SET is_result = 'Y' WHERE field_name 
	IN ('created','updated','due_date','activity_start','activity_end','closing','scheduled','license_time_stamp','mail_date');
