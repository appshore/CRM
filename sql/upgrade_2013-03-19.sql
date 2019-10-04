UPDATE `db_fields` SET `is_result` = 'Y' WHERE `db_fields`.`app_name` = 'reports' AND `db_fields`.`field_name` in ('quickparameter', 'table_name', 'type_id');

