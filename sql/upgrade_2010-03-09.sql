
UPDATE `db_applications` SET `is_customizable` = 'N' WHERE `db_applications`.`app_name` = 'preferences_searches';
UPDATE `db_applications` SET `is_customizable` = 'N' WHERE `db_applications`.`app_name` = 'support_faqs';
UPDATE `db_applications` SET `is_customizable` = 'N' WHERE `db_applications`.`app_name` = 'support_tickets';

UPDATE `db_lookups` SET `is_customizable` = 'N' WHERE `db_lookups`.`table_name` = 'departments';
UPDATE `db_lookups` SET `is_customizable` = 'N' WHERE `db_lookups`.`table_name` = 'reports_types';
