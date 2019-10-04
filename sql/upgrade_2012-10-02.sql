DROP table IF EXISTS backoffice_support_tickets;
DROP VIEW IF EXISTS backoffice_support_tickets;
CREATE VIEW backoffice_support_tickets AS select * from appshore_backoffice.support_tickets;

UPDATE  `db_fields` SET  `search_sequence` =  '0',`result_sequence` =  '0' WHERE CONVERT(  `db_fields`.`app_name` USING utf8 ) =  'support_tickets' AND CONVERT(  `db_fields`.`field_name` USING utf8 ) =  'user_id' LIMIT 1 ;

REPLACE INTO  `db_fields` VALUES (
'support_tickets',  'backoffice_support_tickets',  'created_by_name',  'N',  'N',  'TE',  'Created by',  '1',  '',  '',  '',  '',  '',  'N',  'N',  'N',  'N',  'Y',  '0',  '6',  'grid_center',  '0',  'L',  '',  '0',  'L',  '',  '0',  'L',  '',  '0',  '0',  '0',  'L',  '',  '0',  'L',  '',  '0'
);

REPLACE INTO  `db_fields` VALUES (
'support_tickets',  'backoffice_support_tickets',  'updated_by_name',  'N',  'N',  'TE',  'Updated by',  '1',  '',  '',  '',  '',  '',  'N',  'N',  'N',  'N',  'Y',  '0',  '7',  'grid_center',  '0',  'L',  '',  '0',  'L',  '',  '3',  'R',  '2be7en9edd348',  '0',  '0',  '0',  'L',  '',  '0',  'L',  '',  '0'
);