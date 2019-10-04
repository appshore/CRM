drop table if exists beyondforestry_activities_webmail_completed;
drop view if exists beyondforestry_activities_webmail_completed;
CREATE VIEW beyondforestry_activities_webmail_completed AS  
	SELECT 
		account_name, 
		full_name, 
		type_name, 
		DATE( activity_start ) AS start_date, 
		subject, 
		activities.note
	FROM activities
	LEFT OUTER JOIN accounts ON activities.account_id = accounts.account_id
	LEFT OUTER JOIN contacts ON activities.contact_id = contacts.contact_id
	LEFT OUTER JOIN activities_types ON activities.type_id = activities_types.type_id
	where activities.status_id = 'CO'
UNION
	select
		'' as account_name, 
		mail_to as full_name,
		'webmail' as type_name,
		date(mail_date) as start_date,
		subject,
		body_text as note
	from webmail
	;
	
drop table if exists beyondforestry_activities_inprogress;
drop view if exists beyondforestry_activities_inprogress;
CREATE VIEW beyondforestry_activities_inprogress AS  
	SELECT 
		account_name, 
		full_name, 
		type_name, 
		DATE( activity_start ) AS start_date, 
		subject, 
		activities.note
	FROM activities
	LEFT OUTER JOIN accounts ON activities.account_id = accounts.account_id
	LEFT OUTER JOIN contacts ON activities.contact_id = contacts.contact_id
	LEFT OUTER JOIN activities_types ON activities.type_id = activities_types.type_id
	where activities.status_id <> 'CO'
	;	
	
INSERT INTO `reports` (`report_id`, `report_name`, `template`, `user_id`, `table_name`, `type_id`, `is_private`, `selectedfields`, `groupbyfields`, `filtercriterias`, `orderbyfields`, `orderbygroupfields`, `quickselect`, `quickwhere`, `quickparameter`, `pre_process`, `created`, `created_by`, `updated`, `updated_by`, `note`) VALUES
('activities_webmails', 'Activities and Webmails', 'beyondforestry_activities_webmail.xml', 'initial', 'activities', '1', 'N', '', '', '', '', '', '"SELECT \r\nA.account_name account_name,\r\nA.full_name full_name,\r\nA.type_name type_name,\r\nA.start_date start_date,\r\nA.end_date end_date,\r\nA.subject subject,\r\nA.note note \r\nFROM beyondforestry_activities_webmail_view  A  ', ' $range_date 1=1 order by A.start_date desc "', 'beyondforestry.start_popup', NULL, '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', 'initial', '');


	
drop procedure if exists act1;$$
CREATE procedure act1()
BEGIN
select * from links where from_table = "webmail" and to_table = "accounts"
union
select * from links where to_table = "webmail" and from_table = "accounts"
;
END;$$

drop procedure if exists act1;$$
CREATE procedure act1()
BEGIN
select webmail.subject, accounts.account_name, to_id as id from links
left outer join webmail on from_id = webmail.mail_id
left outer join accounts on to_id = accounts.account_id
where from_table = "webmail" and to_table = "accounts"
union
select webmail.subject, accounts.account_name, from_id as id from links
left outer join webmail on to_id = webmail.mail_id
left outer join accounts on from_id = accounts.account_id
where to_table = "webmail" and from_table = "accounts"
;
END;$$

drop procedure if exists get_account_name;$$
CREATE procedure get_account_name(in in_account_id varchar(32), out out_account_name varchar(250))
BEGIN
select accounts.account_name 
from links
left outer join accounts on to_id = accounts.account_id
where from_table = "webmail" and to_table = "accounts" and to_id = in_account_id
union
select accounts.account_name 
from links
left outer join accounts on from_id = accounts.account_id
where to_table = "webmail" and from_table = "accounts" and from_id = in_account_id
;
END;$$
