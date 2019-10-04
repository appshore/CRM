drop table if exists campaigns_records_accounts_view;
drop view if exists campaigns_records_accounts_view;
create view campaigns_records_accounts_view AS
	select cr.list_id, cr.record_id, concat( cr.list_id, '_', cr.record_id) as list_record_id, 
		concat(', ',account_name) as record_name, 
		account_name, '' as first_names, '' as last_name, '' as salutation,
		email, email_opt_out, do_not_call, phone, '' as mobile, created, updated, user_id,
		address_billing as address, city_billing as city, zipcode_billing as zipcode, state_billing as state, country_billing as country,
		cr.status_id, cr.table_name as record_type_id
	from accounts ac, campaigns_records cr
	where table_name = 'accounts' and cr.record_id = ac.account_id;

drop table if exists campaigns_records_leads_view;
drop view if exists campaigns_records_leads_view;
create view campaigns_records_leads_view AS
	select cr.list_id, cr.record_id, concat( cr.list_id, '_', cr.record_id) as list_record_id, 
		concat(full_name,', ',account_name) as record_name,
		account_name, first_names, last_name, salutation,
		email, email_opt_out, do_not_call, phone, mobile, created, updated, user_id,
		address_1 as address, city_1 as city, zipcode_1 as zipcode, state_1 as state, country_1 as country,
		cr.status_id, cr.table_name as record_type_id
	from leads le, campaigns_records cr
	where cr.table_name = 'leads' and cr.record_id = le.lead_id;

drop table if exists campaigns_records_contacts_view;
drop view if exists campaigns_records_contacts_view;
create view campaigns_records_contacts_view AS
	select cr.list_id, cr.record_id, concat( cr.list_id, '_', cr.record_id) as list_record_id, 
		concat(co.full_name,', ',ac.account_name) as record_name,
		ac.account_name, co.first_names, co.last_name, co.salutation,
		co.email, co.email_opt_out, co.do_not_call, co.phone, co.mobile, co.created, co.updated, co.user_id,
		address_1 as address, city_1 as city, zipcode_1 as zipcode, state_1 as state, country_1 as country,
		cr.status_id, cr.table_name as record_type_id
	from contacts co, campaigns_records cr
	left outer join accounts ac on ac.account_id = record_id
	where cr.table_name = 'contacts'  and cr.record_id = co.contact_id;

drop table if exists campaigns_records_view;
drop view if exists campaigns_records_view;
create view campaigns_records_view AS
	SELECT * FROM campaigns_records_accounts_view
UNION
	SELECT * FROM campaigns_records_leads_view
UNION
	SELECT * FROM campaigns_records_contacts_view;
	
	
DROP VIEW IF EXISTS `global_timezones`;


DROP TABLE IF EXISTS `webmail_accounts`;
CREATE TABLE IF NOT EXISTS `webmail_accounts` (
  `account_id` varchar(32) NOT NULL DEFAULT '',
  `account_name` varchar(250) NOT NULL DEFAULT '',
  `user_id` varchar(32) NOT NULL DEFAULT '',
  `signature_id` varchar(32) NOT NULL DEFAULT '',
  `is_enable` enum('Y','N') NOT NULL DEFAULT 'Y',
  `email` varchar(250) NOT NULL DEFAULT '',
  `email_reply` varchar(250) NOT NULL DEFAULT '',
  `pop3_server` varchar(250) NOT NULL DEFAULT '',
  `pop3_port` varchar(10) NOT NULL DEFAULT '110',
  `pop3_ssl` enum('Y','N') NOT NULL DEFAULT 'N',
  `pop3_username` varchar(250) NOT NULL DEFAULT '',
  `pop3_password` varchar(250) NOT NULL DEFAULT '',
  `pop3_lmos` enum('Y','N') NOT NULL DEFAULT 'Y',
  `smtp_server` varchar(250) NOT NULL DEFAULT '',
  `smtp_port` varchar(10) NOT NULL DEFAULT '25',
  `smtp_ssl` enum('Y','N') NOT NULL DEFAULT 'N',
  `smtp_username` varchar(250) NOT NULL DEFAULT '',
  `smtp_password` varchar(250) NOT NULL DEFAULT '',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` varchar(32) NOT NULL DEFAULT '',
  `updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`account_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

