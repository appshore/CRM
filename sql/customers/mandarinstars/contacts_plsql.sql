-- OLD version
--DROP TRIGGER IF EXISTS `mandarinstars`.`insertAge`//
--CREATE TRIGGER `mandarinstars`.`insertAge` BEFORE INSERT ON `mandarinstars`.`contacts`
-- FOR EACH ROW BEGIN
--SET new.custom_age=(YEAR(CURDATE())-YEAR(new.birthdate))-(RIGHT(CURDATE(),5)<RIGHT(new.birthdate,5));
--IF new.custom_age < 1 or new.custom_age > 120 THEN
--    set new.custom_age = 0;
--end IF;
--END
--//

--DROP TRIGGER IF EXISTS `mandarinstars`.`updateAge`//
--CREATE TRIGGER `mandarinstars`.`updateAge` BEFORE UPDATE ON `mandarinstars`.`contacts`
-- FOR EACH ROW BEGIN
--SET new.custom_age=(YEAR(CURDATE())-YEAR(new.birthdate))-(RIGHT(CURDATE(),5)<RIGHT(new.birthdate,5));
--IF new.custom_age < 1 or new.custom_age > 120 THEN
--    set new.custom_age = 0;
--end IF;
--END
--//

-- NEW version

DROP PROCEDURE IF EXISTS update_age;$$
CREATE PROCEDURE update_age()
	BEGIN
		UPDATE contacts
		SET custom_age = (YEAR(CURDATE())-YEAR(birthdate))-(RIGHT(CURDATE(),5)<RIGHT(birthdate,5))
		WHERE birthdate BETWEEN '0000-00-01' AND now();
	END;$$	
	
DROP TRIGGER IF EXISTS users_after_update;$$
CREATE TRIGGER users_after_update
	AFTER UPDATE ON users
	FOR EACH ROW
	BEGIN
		CALL update_age();
	END;$$		

DROP TRIGGER IF EXISTS contacts_before_insert;$$
CREATE TRIGGER contacts_before_insert
	BEFORE INSERT ON contacts
	FOR EACH ROW
	BEGIN
		SET NEW.custom_age = (YEAR(CURDATE())-YEAR(NEW.birthdate))-(RIGHT(CURDATE(),5)<RIGHT(NEW.birthdate,5));
		IF NEW.custom_age < 1 OR NEW.custom_age > 130 THEN
			SET NEW.custom_age = 0;
		END IF;
	END;$$
	
DROP TRIGGER IF EXISTS contacts_before_update;$$
CREATE TRIGGER contacts_before_update
	BEFORE UPDATE ON contacts
	FOR EACH ROW
	BEGIN
		IF NEW.birthdate <> OLD.birthdate THEN
			SET NEW.custom_age = (YEAR(CURDATE())-YEAR(NEW.birthdate))-(RIGHT(CURDATE(),5)<RIGHT(NEW.birthdate,5));
		END IF;
		IF NEW.custom_age < 1 OR NEW.custom_age > 130 THEN
			SET NEW.custom_age = 0;
		end IF;
	END;$$	
