update db_fields set is_result = 'Y' where field_name = 'is_folder';
UPDATE db_fields SET is_result = 'Y' WHERE  app_name =  'webmail' AND  field_name in  ('bound','is_read','is_archive');
