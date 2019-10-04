DROP table IF EXISTS global_charsets;
DROP VIEW IF EXISTS global_charsets;
CREATE VIEW global_charsets AS select * from appshore_global_v23.charsets;		
	
DROP table IF EXISTS global_countries;
DROP VIEW IF EXISTS global_countries;
CREATE VIEW global_countries AS select * from appshore_global_v23.countries;

DROP table IF EXISTS global_countries_states;
DROP VIEW IF EXISTS global_countries_states;
CREATE VIEW global_countries_states AS select * from appshore_global_v23.countries_states;

DROP table IF EXISTS global_currencies;
DROP VIEW IF EXISTS global_currencies;
CREATE VIEW global_currencies AS select * from appshore_global_v23.currencies where (is_available = _utf8'Y');

DROP table IF EXISTS global_dashlets;
DROP VIEW IF EXISTS global_dashlets;
CREATE VIEW global_dashlets AS select * from appshore_global_v23.dashlets where (is_available = _utf8'Y');

DROP table IF EXISTS global_editions;
DROP VIEW IF EXISTS global_editions;
CREATE VIEW global_editions AS select * from appshore_global_v23.editions;

DROP table IF EXISTS global_editions_applications;
DROP VIEW IF EXISTS global_editions_applications;
CREATE VIEW global_editions_applications AS select * from appshore_global_v23.editions_applications;

DROP table IF EXISTS global_editions_metrics;
DROP VIEW IF EXISTS global_editions_metrics;
CREATE VIEW global_editions_metrics AS select * from appshore_global_v23.editions_metrics;

DROP table IF EXISTS global_editions_periods;
DROP VIEW IF EXISTS global_editions_periods;
CREATE VIEW global_editions_periods AS select * from appshore_global_v23.editions_periods;

DROP table IF EXISTS global_languages;
DROP VIEW IF EXISTS global_languages;
CREATE VIEW global_languages AS select * from appshore_global_v23.languages where (is_available = _utf8'Y');

DROP table IF EXISTS global_locales_date;
DROP VIEW IF EXISTS global_locales_date;
CREATE VIEW global_locales_date AS select * from appshore_global_v23.locales_date;

DROP table IF EXISTS global_locales_time;
DROP VIEW IF EXISTS global_locales_time;
CREATE VIEW global_locales_time AS select * from appshore_global_v23.locales_time;

DROP table IF EXISTS global_lines;
DROP VIEW IF EXISTS global_lines;
CREATE VIEW global_lines AS select * from appshore_global_v23.lines order by line_name;

DROP table IF EXISTS global_months;
DROP VIEW IF EXISTS global_months;
CREATE VIEW global_months AS select * from appshore_global_v23.months;

DROP table IF EXISTS global_notifications_periods;
DROP VIEW IF EXISTS global_notifications_periods;
CREATE VIEW global_notifications_periods AS select * from appshore_global_v23.notifications_periods;

DROP table IF EXISTS global_notifications_statuses;
DROP VIEW IF EXISTS global_notifications_statuses;
CREATE VIEW global_notifications_statuses AS select * from appshore_global_v23.notifications_statuses;

DROP table IF EXISTS global_notifications_types;
DROP VIEW IF EXISTS global_notifications_types;
CREATE VIEW global_notifications_types AS select * from appshore_global_v23.notifications_types;

DROP table IF EXISTS global_panelets;
DROP VIEW IF EXISTS global_panelets;
CREATE VIEW global_panelets AS select * from appshore_global_v23.panelets where (is_available = _utf8'Y');

DROP table IF EXISTS global_themes;
DROP VIEW IF EXISTS global_themes;
CREATE VIEW global_themes AS select * from appshore_global_v23.themes where (is_available = _utf8'Y');

DROP TABLE IF EXISTS global_translation;
DROP VIEW IF EXISTS global_translation;
CREATE VIEW global_translation AS select * from appshore_global_v23.translation;
