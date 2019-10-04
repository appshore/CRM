
DROP table IF EXISTS global_editions_periods;
DROP VIEW IF EXISTS global_editions_periods;
CREATE VIEW global_editions_periods AS select * from appshore_global.editions_periods;
