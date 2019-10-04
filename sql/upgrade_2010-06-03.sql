DROP table IF EXISTS global_notifications_periods;
DROP VIEW IF EXISTS global_notifications_periods;
CREATE VIEW global_notifications_periods AS select * from appshore_global.notifications_periods;

DROP table IF EXISTS global_notifications_statuses;
DROP VIEW IF EXISTS global_notifications_statuses;
CREATE VIEW global_notifications_statuses AS select * from appshore_global.notifications_statuses;

DROP table IF EXISTS global_notifications_types;
DROP VIEW IF EXISTS global_notifications_types;
CREATE VIEW global_notifications_types AS select * from appshore_global.notifications_types;

DROP table IF EXISTS global_themes;
DROP VIEW IF EXISTS global_themes;
CREATE VIEW global_themes AS select * from appshore_global.themes where (is_available = _utf8'Y');


