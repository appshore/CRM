
CREATE TABLE IF NOT EXISTS `panelets` (
  `user_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `panelet_name` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `panelet_sequence` tinyint(4) NOT NULL,
  `is_open` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`user_id`,`panelet_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

update db_applications set is_quickadd = "Y" where app_name in("accounts","activities","cases","contacts","documents","leads","opportunities","webmail");

DROP table IF EXISTS global_panelets;
DROP VIEW IF EXISTS global_panelets;
CREATE VIEW global_panelets AS select * from appshore_global.panelets where (is_available = _utf8'Y');

drop table if exists campaigns_records_view;
drop view if exists campaigns_records_view;
create view campaigns_records_view AS
	select list_id, account_id as record_id, concat( list_id, '_', account_id) as list_record_id, account_name as record_name, 
		account_name, '' as first_names, '' as last_name, '' as salutation,
		email, email_opt_out, do_not_call, phone, '' as mobile, created, updated, user_id,
		address_billing as address, city_billing as city, zipcode_billing as zipcode, state_billing as state, country_billing as country,
		cr.status_id, cr.table_name as record_type_id
	from campaigns_records cr
	left outer join accounts ac on ac.account_id = cr.record_id
	where table_name = 'accounts'
union
	select list_id, lead_id as record_id, concat( list_id, '_', lead_id) as list_record_id, account_name as record_name, 
		account_name, first_names, last_name, salutation,
		email, email_opt_out, do_not_call, phone, mobile, created, updated, user_id,
		address_1 as address, city_1 as city, zipcode_1 as zipcode, state_1 as state, country_1 as country,
		cr.status_id, cr.table_name as record_type_id
	from campaigns_records cr
	left outer join leads le on le.lead_id = cr.record_id
	where table_name = 'leads'
union
	select cr.list_id, co.contact_id as record_id, concat( cr.list_id, '_', co.contact_id) as list_record_id, 
		concat_ws( ' ',co.last_name,', ',co.first_names,concat(' (',ac.account_name,')') ) as record_name,
		ac.account_name, co.first_names, co.last_name, co.salutation,
		co.email, co.email_opt_out, co.do_not_call, co.phone, co.mobile, co.created, co.updated, co.user_id,
		address_1 as address, city_1 as city, zipcode_1 as zipcode, state_1 as state, country_1 as country,
		cr.status_id, cr.table_name as record_type_id
	from campaigns_records cr
	left outer join contacts co on co.contact_id = cr.record_id
	left outer join accounts ac on co.account_id = ac.account_id
	where co.account_id <> '' and table_name = 'contacts'
union
	select cr.list_id, co.contact_id as record_id, concat( cr.list_id, '_', co.contact_id) as list_record_id,
		concat_ws( ' ',co.last_name,', ',co.first_names ) as record_name,
		'' as account_name, co.first_names, co.last_name, co.salutation,
		co.email, co.email_opt_out, co.do_not_call, co.phone, co.mobile, co.created, co.updated, co.user_id,
		address_1 as address, city_1 as city, zipcode_1 as zipcode, state_1 as state, country_1 as country,
		cr.status_id, cr.table_name as record_type_id
	from campaigns_records cr
	left outer join contacts co on co.contact_id = cr.record_id
	where co.account_id = '' and table_name = 'contacts';


