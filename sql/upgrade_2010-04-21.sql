ALTER TABLE `translation` ADD `is_template` ENUM( 'Y', 'N' ) NOT NULL DEFAULT 'N' AFTER `phrase` ;

DROP TABLE IF EXISTS global_translation;
DROP VIEW IF EXISTS global_translation;
CREATE VIEW global_translation AS select * from appshore_global.translation;

DROP table IF EXISTS translation_view;
DROP VIEW IF EXISTS translation_view;
CREATE VIEW translation_view as SELECT * FROM translation union SELECT * FROM global_translation where phrase not in (select phrase from translation);

