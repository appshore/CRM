UPDATE `db_fields` SET `is_search` = 'N' WHERE `db_fields`.`field_type` not in ('CU','DA','DO','DT','ML','NU','PH','TE','TI','TS','VF','WM','WS');
