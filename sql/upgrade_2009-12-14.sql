drop table if exists campaigns_records_view;
drop view if exists campaigns_records_view;
create view campaigns_records_view AS
	select list_id, account_id as record_id, concat( list_id, '_', account_id) as list_record_id, account_name as record_name, 
		account_name, '' as first_names, '' as last_name, '' as salutation,
		email, '' as email_opt_out, '' as do_not_call, phone, '' as mobile, created, updated, user_id,
		address_billing as address, city_billing as city, zipcode_billing as zipcode, state_billing as state, country_billing as country,
		campaigns_records.status_id, campaigns_records.table_name as record_type_id
	from accounts, campaigns_records 
	where accounts.account_id = campaigns_records.record_id
union
	select list_id, lead_id as record_id, concat( list_id, '_', lead_id) as list_record_id, account_name as record_name, 
		account_name, first_names, last_name, salutation,
		email, email_opt_out, do_not_call, phone, mobile, created, updated, user_id,
		address_1 as address, city_1 as city, zipcode_1 as zipcode, state_1 as state, country_1 as country,
		campaigns_records.status_id, campaigns_records.table_name as record_type_id
	from leads, campaigns_records 
	where leads.lead_id = campaigns_records.record_id
union
	select cr.list_id, co.contact_id as record_id, concat( cr.list_id, '_', co.contact_id) as list_record_id, 
		concat_ws( ' ',co.last_name,', ',co.first_names,concat(' (',ac.account_name,')') ) as record_name,
		ac.account_name, co.first_names, co.last_name, co.salutation,
		co.email, co.email_opt_out, co.do_not_call, co.phone, co.mobile, co.created, co.updated, co.user_id,
		address_1 as address, city_1 as city, zipcode_1 as zipcode, state_1 as state, country_1 as country,
		cr.status_id, cr.table_name as record_type_id
	from contacts co, accounts ac, campaigns_records cr 
	where co.contact_id = cr.record_id
	and co.account_id = ac.account_id
	and co.account_id <> ''
union
	select cr.list_id, co.contact_id as record_id, concat( cr.list_id, '_', co.contact_id) as list_record_id,
		concat_ws( ' ',co.last_name,', ',co.first_names ) as record_name,
		'' as account_name, co.first_names, co.last_name, co.salutation,
		co.email, co.email_opt_out, co.do_not_call, co.phone, co.mobile, co.created, co.updated, co.user_id,
		address_1 as address, city_1 as city, zipcode_1 as zipcode, state_1 as state, country_1 as country,
		cr.status_id, cr.table_name as record_type_id
	from contacts co, campaigns_records cr 
	where co.contact_id = cr.record_id
	and co.account_id = '';	
