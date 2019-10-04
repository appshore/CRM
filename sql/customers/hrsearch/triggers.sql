DROP TRIGGER IF EXISTS opportunities_before_insert;$$
CREATE TRIGGER opportunities_before_insert
	BEFORE INSERT ON opportunities
	FOR EACH ROW
	BEGIN
		IF NEW.account_id THEN
			SET NEW.custom_salary = (select custom_salary from accounts where account_id = NEW.account_id);
		END IF;
	END;$$
	
DROP TRIGGER IF EXISTS opportunities_before_update;$$
CREATE TRIGGER opportunities_before_update
	BEFORE UPDATE ON opportunities
	FOR EACH ROW
	BEGIN
		IF NEW.account_id <> OLD.account_id THEN
			SET NEW.custom_salary = (select custom_salary from accounts where account_id = NEW.account_id);
		END IF;
	END;$$	
	
DROP TRIGGER IF EXISTS accounts_after_update;$$
CREATE TRIGGER accounts_after_update
	AFTER UPDATE ON accounts
	FOR EACH ROW
	BEGIN
		IF NEW.custom_salary <> OLD.custom_salary THEN
			UPDATE opportunities SET 
				custom_salary = NEW.custom_salary
				WHERE opportunities.account_id = NEW.account_id;
		END IF;
	END;$$		
	
