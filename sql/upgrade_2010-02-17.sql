ALTER TABLE  `company_orders` ADD  `amount` INT( 11 ) NOT NULL AFTER  `price` ;
ALTER TABLE  `company_orders` ADD  `due_date` DATE NOT NULL AFTER  `metric` ;
ALTER TABLE  `company_orders` CHANGE  `period`  `period` TINYINT NOT NULL;
update `company_orders` set period = 12 where period = 2;

