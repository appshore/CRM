

UPDATE `db_fields` SET `app_name` = 'reports',`table_name` = 'reports',`field_name` = 'table_name',`is_custom` = 'N',`is_computed` = 'N',`field_type` = 'DD',`field_label` = 'Application',`field_height` = 1,`field_default` = '',`related_table` = 'reports_tables',`related_id` = 'table_name',`related_name` = 'label',`related_filter` = '',`is_search` = 'N',`is_readonly` = 'N',`is_mandatory` = 'N',`is_unique` = 'N',`is_visible` = 'Y',`search_sequence` = 2,`result_sequence` = 2,`result_class` = 'grid_left',`bulk_sequence` = 0,`bulk_side` = 'L',`bulk_block_id` = '',`view_sequence` = 0,`view_side` = 'L',`view_block_id` = '',`edit_sequence` = 0,`edit_side` = 'L',`edit_block_id` = '',`popup_search_sequence` = 0,`popup_result_sequence` = 0,`popup_view_sequence` = 0,`popup_view_side` = 'L',`popup_view_block_id` = '',`popup_edit_sequence` = 0,`popup_edit_side` = 'L',`popup_edit_block_id` = '',`linked_sequence` = 0 WHERE `db_fields`.`app_name` = 'reports' AND `db_fields`.`field_name` = 'table_name';
UPDATE `db_fields` SET `app_name` = 'reports',`table_name` = 'reports',`field_name` = 'type_id',`is_custom` = 'N',`is_computed` = 'N',`field_type` = 'DD',`field_label` = 'Type',`field_height` = 1,`field_default` = '',`related_table` = 'reports_types',`related_id` = 'type_id',`related_name` = 'type_name',`related_filter` = ' order by type_name',`is_search` = 'N',`is_readonly` = 'N',`is_mandatory` = 'N',`is_unique` = 'N',`is_visible` = 'Y',`search_sequence` = 3,`result_sequence` = 4,`result_class` = 'grid_left',`bulk_sequence` = 0,`bulk_side` = 'L',`bulk_block_id` = '',`view_sequence` = 0,`view_side` = 'L',`view_block_id` = '',`edit_sequence` = 0,`edit_side` = 'L',`edit_block_id` = '',`popup_search_sequence` = 0,`popup_result_sequence` = 0,`popup_view_sequence` = 0,`popup_view_side` = 'L',`popup_view_block_id` = '',`popup_edit_sequence` = 0,`popup_edit_side` = 'L',`popup_edit_block_id` = '',`linked_sequence` = 0 WHERE `db_fields`.`app_name` = 'reports' AND `db_fields`.`field_name` = 'type_id';

DELETE FROM reports WHERE report_id = "11";

REPLACE INTO `reports` VALUES('3', 'All accounts of selected sales representative(s)', 'accountsBySales.xml', 'initial', 'accounts', '1', '', '', '', '', '', '', '"SELECT user_name C1,account_name C2,E.type_name C3,D.industry_name C4,F.rating_name C5,revenue C6 FROM accounts A  LEFT OUTER JOIN users B on A.user_id = B.user_id LEFT OUTER JOIN industries D on A.industry_id = D.industry_id LEFT OUTER JOIN types E on A.type_id=E.type_id LEFT OUTER JOIN ratings F on A.rating_id = F.rating_id ', '$users_scope $range_date 1=1 ORDER BY B.user_name ASC"', 'popup_users_scope', NULL, '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '', '');
REPLACE INTO `reports` VALUES('2', 'All Accounts: with addresses', 'accountsAllDetails.xml', 'initial', 'accounts', '1', 'N', '', '', '', '', '', '"SELECT  B.user_name, A.*\r\nFROM accounts A\r\nLEFT OUTER JOIN users B \r\n ON A.user_id=B.user_id', '$users_scope $range_date 1=1 ORDER BY B.user_name ASC"', 'popup_users_scope', NULL, '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '', '');
REPLACE INTO `reports` VALUES('1', 'All Accounts: with date created and last updated', 'accountsAllInfo.xml', 'initial', 'accounts', '1', 'N', '', '', '', '', '', '"SELECT account_name C1, account_number C2, B.user_name C3, C.source_name C4, D.industry_name C5, employees C6, revenue C7, A.created C8, E.user_name C9, A.updated C10, F.user_name C11, A.note C12 FROM `accounts` A\r\nLEFT OUTER JOIN users B on A.user_id = B.user_id\r\nLEFT OUTER JOIN sources C on A.source_id = C.source_id\r\nLEFT OUTER JOIN industries D on A.industry_id = D.industry_id\r\nLEFT OUTER JOIN users E on A.created_by = E.user_id\r\nLEFT OUTER JOIN users F on A.updated_by = F.user_id', '$bcwhere $range_date 1=1 ORDER BY A.account_name ASC\r\n"', 'popup_range_date', NULL, '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '', '');
REPLACE INTO `reports` VALUES('5', 'All contacts of selected representative(s)', 'contactsAll.xml', 'initial', 'contacts', '1', '', '', '', '', '', '', '"SELECT B.user_name C1, A.first_names C2, A.last_name C3, A.salutation C4, A.title C5, C.account_name C6, A.department C7, D.last_name C8, A.email C9, A.phone C10, A.mobile C11, A.messenger C12, A.messenger_type C13, A.fax C14, A.email_opt_out C15, A.do_not_call C16, A.assistant_id C17, A.private_phone C18, A.private_mobile C19, A.private_email C20, A.birthdate C21, A.address_1 C22, A.zipcode_1 C23, A.city_1 C24, A.state_1 C25, A.country_1 C26, A.address_2 C27, A.zipcode_2 C28, A.city_2 C29, A.state_2 C30, A.country_2 C31, A.note C32\r\nFROM contacts A\r\nLEFT OUTER JOIN users B on A.user_id = B.user_id\r\nLEFT OUTER JOIN accounts C on A.account_id = C.account_id \r\nLEFT OUTER JOIN contacts D ON A.manager_id = D.user_id', '$users_scope $range_date 1=1 "', 'popup_users_scope', NULL, '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '', '');
REPLACE INTO `reports` VALUES('6', 'All leads', 'leadsAll.xml', 'initial', 'leads', '1', 'N', '', '', '', '', '', '"SELECT  B.user_name C1, C.source_name C2, D.industry_name C3, E.type_name C4, F.rating_name C5,\r\n	A.account_name C6, A.url C7,A.employees C8,A.revenue C9, A.first_names C10,A.last_name C11,\r\n	A.salutation C12,A.title C13,A.email C14,A.phone C15,A.mobile C16,\r\n	A.fax C17,A.email_opt_out C18,A.do_not_call C19, A.address_1 C20,A.zipcode_1 C21,\r\n	A.city_1 C22, A.state_1 C23,A.country_1 C24,A.note C25,A.created C26,\r\n	A.created_by C27,A.updated C28, A.updated_by C29 FROM leads A\r\nLEFT OUTER JOIN users B \r\n ON A.user_id=B.user_id \r\nLEFT OUTER JOIN sources C\r\n  ON A.source_id=C.source_id\r\nLEFT OUTER JOIN industries D\r\n  ON A.industry_id=D.industry_id \r\nLEFT OUTER JOIN types E\r\n	  ON A.type_id=E.type_id \r\nLEFT OUTER JOIN ratings F\r\n ON A.rating_id=F.rating_id', '$users_scope $range_date 1=1 ORDER BY B.user_name ASC"', 'popup_users_scope', NULL, '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '', '');
REPLACE INTO `reports` VALUES('4', 'All opportunities', 'opportunitiesAll.xml', 'initial', 'opportunities', '1', 'N', '', '', '', '', '', '"SELECT A.opportunity_name C1, B.account_name C2, C.user_name C3, expected_amount C4, closing C5, recurring_amount C6, A.created C7, A.updated C8, D.stage_name C9\r\nFROM opportunities A\r\nleft outer join accounts B on A.account_id = B.account_id\r\nleft outer join users C on A.user_id = C.user_id\r\nleft outer join stages D on D.stage_id = A.stage_id\r\n	', '$range_date 1=1\r\n"', 'popup_range_date', NULL, '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '', '');
REPLACE INTO `reports` VALUES('12', 'My activities by Status', 'MyActivitiesByStatus.xml', 'initial', 'activities', '1', '', '', '', '', '', '', '"SELECT A.subject C0,B.user_name CB,D.status_name CD,A.activity_start C2,A.activity_end C3,A.updated C5,C.user_name CC,E.priority_name CE FROM activities A  \r\n LEFT OUTER JOIN users B on A.user_id =B.user_id\r\n LEFT OUTER JOIN users C on A.updated_by =C.user_id \r\n LEFT OUTER JOIN activities_statuses D on A.status_id =D.status_id\r\n LEFT OUTER JOIN activities_priorities E on A.priority_id=E.priority_id', ' $range_date A.user_id=''".$GLOBALS[''appshore_data''][''current_user''][''user_id'']."'' order by CB,CD "', 'popup_range_date', NULL, '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', 'initial', '');
REPLACE INTO `reports` VALUES('9', 'My contacts', 'myContacts.xml', 'initial', 'contacts', '1', 'N', '', '', '', '', '', '"SELECT B.user_name C1, A.first_names C2, A.last_name C3, A.salutation C4, A.title C5, C.account_name C6, A.department C7, D.last_name C8, A.email C9, A.phone C10, A.mobile C11, A.messenger C12, A.messenger_type C13, A.fax C14, A.email_opt_out C15, A.do_not_call C16, A.assistant_id C17, A.private_phone C18, A.private_mobile C19, A.private_email C20, A.birthdate C21, A.address_1 C22, A.zipcode_1 C23, A.city_1 C24, A.state_1 C25, A.country_1 C26, A.address_2 C27, A.zipcode_2 C28, A.city_2 C29, A.state_2 C30, A.country_2 C31, A.note C32\r\nFROM contacts A\r\nLEFT outer join users B on A.user_id = B.user_id\r\nLEFT outer join accounts C on  A.account_id = C.account_id \r\nLEFT OUTER JOIN contacts D ON A.manager_id = D.contact_id', ' A.user_id=''".$GLOBALS[''appshore_data''][''current_user''][''user_id'']."'' "', NULL, NULL, '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '', '');
REPLACE INTO `reports` VALUES('8', 'My expected revenues per quarter', 'myExRevenueQ.xml', 'initial', 'opportunities', '1', 'N', '    ', '', '', '', '', '"SELECT quarter(closing) QU, stage_name C1, opportunity_name C4, expected_amount C2, A.stage_id C3\r\nfrom opportunities A\r\nLEFT OUTER JOIN stages B on A.stage_id=B.stage_id', ' $range_date A.user_id=''".$GLOBALS[''appshore_data''][''current_user''][''user_id'']."'' order by QU asc, C3"', 'popup_range_date', NULL, '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '', '');
REPLACE INTO `reports` VALUES('10', 'My leads', 'myLeads.xml', 'initial', 'leads', '1', '', '', '', '', '', '', '"SELECT  B.user_name C1, C.source_name C2, D.industry_name C3, E.type_name C4, F.rating_name C5,\r\n    A.account_name C6, A.url C7,A.employees C8,A.revenue C9, A.first_names C10,A.last_name C11,\r\n    A.salutation C12,A.title C13,A.email C14,A.phone C15,A.mobile C16,\r\n    A.fax C17,A.email_opt_out C18,A.do_not_call C19, A.address_1 C20,A.zipcode_1 C21,\r\n    A.city_1 C22, A.state_1 C23,A.country_1 C24,A.note C25,A.created C26,\r\n    A.created_by C27,A.updated C28, A.updated_by C29 FROM leads A\r\nLEFT OUTER JOIN users B \r\n ON A.user_id=B.user_id \r\nLEFT OUTER JOIN sources C\r\n  ON A.source_id=C.source_id\r\nLEFT OUTER JOIN industries D\r\n  ON A.industry_id=D.industry_id \r\nLEFT OUTER JOIN types E\r\n      ON A.type_id=E.type_id \r\nLEFT OUTER JOIN ratings F\r\n ON A.rating_id=F.rating_id', ' $range_date A.user_id=''".$GLOBALS[''appshore_data''][''current_user''][''user_id'']."''  "', 'popup_range_date', NULL, '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '', '');
REPLACE INTO `reports` VALUES('7', 'My opportunities', 'myOpportunities.xml', 'initial', 'opportunities', '1', 'N', '    ', '', '', '', '', '"SELECT A.opportunity_name C1, B.account_name C2, C.user_name C3, expected_amount C4, closing  C5, recurring_amount C6, A.created C7, A.updated C8, D.stage_name C9 \r\nFROM opportunities A\r\n LEFT OUTER JOIN accounts B on A.account_id=B.account_id\r\n LEFT OUTER JOIN users C on A.user_id=C.user_id \r\n LEFT OUTER JOIN stages D on D.stage_id=A.stage_id', ' $range_date A.user_id=''".$GLOBALS[''appshore_data''][''current_user''][''user_id'']."''  "', 'popup_range_date', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '', '');
REPLACE INTO `reports` VALUES('13', 'USA Accounts per State', '', 'initial', 'accounts', '2', '', 'account_name/email/phone/employees/city_billing/state_billing/zipcode_billing/country_billing', '', 'country_billing:contains:usa', '', '', '', '', NULL, NULL, '', 'initial', '', 'initial', '');
REPLACE INTO `reports` VALUES('20', 'My weekly activities', '', 'initial', 'activities', '2', '', 'subject/type_id/priority_id/status_id/activity_start/activity_end/location/account_id/contact_id', '', 'activity_start:period:TW', '', '', '', '', NULL, NULL, '', 'initial', '', 'initial', '');
REPLACE INTO `reports` VALUES('21', 'My monthly activities', '', 'initial', 'activities', '2', '', 'subject/type_id/priority_id/status_id/activity_start/activity_end/location/account_id/contact_id', '', 'activity_start:period:TM', '', '', '', '', NULL, NULL, '', 'initial', '', 'initial', '');
REPLACE INTO `reports` VALUES('22', 'Leads of the month by source', '', 'initial', 'leads', '2', '', 'account_name/full_name/phone/email/address_1/city_1/zipcode_1/state_1/country_1/do_not_call/email_opt_out/industry_id/source_id', 'source_id:grp', 'created:period:TM', '', '', '', '', NULL, NULL, '', 'initial', '', 'initial', '');

UPDATE `reports_types` SET `type_name` = 'Custom' WHERE `reports_types`.`type_id` = '2';
DELETE FROM `reports_types` WHERE `reports_types`.`type_id` = '3';
DELETE FROM `reports_types` WHERE `reports_types`.`type_id` = '4';

