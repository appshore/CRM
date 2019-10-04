drop table if exists campaigns_history_view;
drop view if exists campaigns_history_view;
CREATE VIEW campaigns_history_view AS  
	SELECT ch.* , ca.campaign_name, cl.list_name
	FROM campaigns_history ch, campaigns ca, campaigns_lists cl
	WHERE ch.campaign_id = ca.campaign_id
	AND ch.list_id = cl.list_id;

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

DROP table IF EXISTS global_charsets;
DROP VIEW IF EXISTS global_charsets;
CREATE VIEW global_charsets AS select * from appshore_global.charsets;		
	
DROP table IF EXISTS global_countries;
DROP VIEW IF EXISTS global_countries;
CREATE VIEW global_countries AS select * from appshore_global.countries;

DROP table IF EXISTS global_countries_states;
DROP VIEW IF EXISTS global_countries_states;
CREATE VIEW global_countries_states AS select * from appshore_global.countries_states;

DROP table IF EXISTS global_currencies;
DROP VIEW IF EXISTS global_currencies;
CREATE VIEW global_currencies AS select * from appshore_global.currencies where (is_available = _utf8'Y');

DROP table IF EXISTS global_dashlets;
DROP VIEW IF EXISTS global_dashlets;
CREATE VIEW global_dashlets AS select * from appshore_global.dashlets where (is_available = _utf8'Y');

DROP table IF EXISTS global_editions;
DROP VIEW IF EXISTS global_editions;
CREATE VIEW global_editions AS select * from appshore_global.editions;

DROP table IF EXISTS global_editions_applications;
DROP VIEW IF EXISTS global_editions_applications;
CREATE VIEW global_editions_applications AS select * from appshore_global.editions_applications;

DROP table IF EXISTS global_editions_metrics;
DROP VIEW IF EXISTS global_editions_metrics;
CREATE VIEW global_editions_metrics AS select * from appshore_global.editions_metrics;

DROP table IF EXISTS global_editions_periods;
DROP VIEW IF EXISTS global_editions_periods;
CREATE VIEW global_editions_periods AS select * from appshore_global.editions_periods;

DROP table IF EXISTS global_languages;
DROP VIEW IF EXISTS global_languages;
CREATE VIEW global_languages AS select * from appshore_global.languages where (is_available = _utf8'Y');

DROP table IF EXISTS global_locales_date;
DROP VIEW IF EXISTS global_locales_date;
CREATE VIEW global_locales_date AS select * from appshore_global.locales_date;

DROP table IF EXISTS global_locales_time;
DROP VIEW IF EXISTS global_locales_time;
CREATE VIEW global_locales_time AS select * from appshore_global.locales_time;

DROP table IF EXISTS global_lines;
DROP VIEW IF EXISTS global_lines;
CREATE VIEW global_lines AS select * from appshore_global.lines order by line_name;

DROP table IF EXISTS global_months;
DROP VIEW IF EXISTS global_months;
CREATE VIEW global_months AS select * from appshore_global.months;

DROP table IF EXISTS global_notifications_fields;
DROP VIEW IF EXISTS global_notifications_fields;
CREATE VIEW global_notifications_fields AS select * from appshore_global.notifications_fields;

DROP table IF EXISTS global_notifications_periods;
DROP VIEW IF EXISTS global_notifications_periods;
CREATE VIEW global_notifications_periods AS select * from appshore_global.notifications_periods;

DROP table IF EXISTS global_notifications_statuses;
DROP VIEW IF EXISTS global_notifications_statuses;
CREATE VIEW global_notifications_statuses AS select * from appshore_global.notifications_statuses;

DROP table IF EXISTS global_notifications_types;
DROP VIEW IF EXISTS global_notifications_types;
CREATE VIEW global_notifications_types AS select * from appshore_global.notifications_types;

DROP table IF EXISTS global_panelets;
DROP VIEW IF EXISTS global_panelets;
CREATE VIEW global_panelets AS select * from appshore_global.panelets where (is_available = _utf8'Y');

DROP table IF EXISTS global_themes;
DROP VIEW IF EXISTS global_themes;
CREATE VIEW global_themes AS select * from appshore_global.themes where (is_available = _utf8'Y');

DROP TABLE IF EXISTS global_translation;
DROP VIEW IF EXISTS global_translation;
CREATE VIEW global_translation AS select * from appshore_global.translation;

CREATE TABLE IF NOT EXISTS translation (PRIMARY KEY(phrase)) select * from global_translation where 1=2;

DROP table IF EXISTS translation_view;
DROP VIEW IF EXISTS translation_view;
CREATE VIEW translation_view as SELECT * FROM translation union SELECT * FROM global_translation where phrase not in (select phrase from translation);

DROP table IF EXISTS backoffice_support_faqs;
DROP VIEW IF EXISTS backoffice_support_faqs;
CREATE VIEW backoffice_support_faqs AS select * from appshore_backoffice.support_faqs;

DROP table IF EXISTS backoffice_support_faqs_categories;
DROP VIEW IF EXISTS backoffice_support_faqs_categories;
CREATE VIEW backoffice_support_faqs_categories AS select * from appshore_backoffice.support_faqs_categories;

DROP table IF EXISTS backoffice_support_faqs_editions;
DROP VIEW IF EXISTS backoffice_support_faqs_editions;
CREATE VIEW backoffice_support_faqs_editions AS select * from appshore_backoffice.support_faqs_editions;

DROP table IF EXISTS backoffice_support_tickets;
DROP VIEW IF EXISTS backoffice_support_tickets;
CREATE VIEW backoffice_support_tickets AS select * from appshore_backoffice.support_tickets;

DROP table IF EXISTS backoffice_support_tickets_categories;
DROP VIEW IF EXISTS backoffice_support_tickets_categories;
CREATE VIEW backoffice_support_tickets_categories AS select * from appshore_backoffice.support_tickets_categories;

DROP table IF EXISTS backoffice_support_tickets_editions;
DROP VIEW IF EXISTS backoffice_support_tickets_editions;
CREATE VIEW backoffice_support_tickets_editions AS select * from appshore_backoffice.support_tickets_editions;

DROP table IF EXISTS backoffice_support_tickets_priorities;
DROP VIEW IF EXISTS backoffice_support_tickets_priorities;
CREATE VIEW backoffice_support_tickets_priorities AS select * from appshore_backoffice.support_tickets_priorities;

DROP table IF EXISTS backoffice_support_tickets_statuses;
DROP VIEW IF EXISTS backoffice_support_tickets_statuses;
CREATE VIEW backoffice_support_tickets_statuses AS select * from appshore_backoffice.support_tickets_statuses;

