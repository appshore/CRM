DROP table if exists translation_backup;
RENAME TABLE translation TO translation_backup ;
create table translation AS select * from appshore_global_v23.translation where 1=0;

DROP table IF EXISTS global_translation;
DROP VIEW IF EXISTS global_translation;
CREATE VIEW global_translation AS select * from appshore_global_v23.translation;

DROP table IF EXISTS translation_view;
DROP VIEW IF EXISTS translation_view;
CREATE VIEW translation_view as SELECT * FROM translation union SELECT * FROM global_translation where phrase not in (select phrase from translation);

