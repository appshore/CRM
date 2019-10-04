DROP FUNCTION IF EXISTS yearmonth;$$
CREATE FUNCTION yearmonth( this_date date)
	RETURNS VARCHAR(50)
	READS SQL DATA
	BEGIN
		DECLARE years INT(11);
		DECLARE months INT(11);
		DECLARE this_year VARCHAR(50);
		DECLARE this_month VARCHAR(50);
	
		SET months = PERIOD_DIFF( EXTRACT(YEAR_MONTH FROM NOW()), EXTRACT(YEAR_MONTH FROM this_date));
		SET years = floor(months/12);
		SET months = months % 12;

		IF years > 1000 THEN
			RETURN '';
		ELSEIF years > 0 THEN
			SET this_year = concat(years,'年');
		ELSE
			SET this_year = '';
		END IF;
			
		IF months > 0 THEN
			SET this_month = concat(months,'月');
		ELSE
			SET this_month = '';
		END IF;

		RETURN concat(this_year,this_month);
	END;$$	
	
DROP FUNCTION IF EXISTS tsubo;$$
CREATE FUNCTION tsubo( this_surface INT(11))
	RETURNS DECIMAL(11,2)
	READS SQL DATA
	BEGIN
		IF this_surface > 0 THEN
			RETURN this_surface*121/400;
		ELSE
			RETURN 0;
		END IF;
	END;$$		

DROP PROCEDURE IF EXISTS update_contacts;$$
CREATE PROCEDURE update_contacts()
	BEGIN
		UPDATE contacts
		SET custom_passed_time = yearmonth(custom_build_year)
		WHERE custom_build_year BETWEEN '0000-00-01' AND now();
	END;$$	
	
DROP TRIGGER IF EXISTS users_after_update;$$
CREATE TRIGGER users_after_update
	AFTER UPDATE ON users
	FOR EACH ROW
	BEGIN
		CALL update_contacts();
	END;$$		

DROP TRIGGER IF EXISTS contacts_before_insert;$$
CREATE TRIGGER contacts_before_insert
	BEFORE INSERT ON contacts
	FOR EACH ROW
	BEGIN
		SET NEW.custom_passed_time = yearmonth(NEW.custom_build_year);
		SET NEW.custom_square_tsubo = tsubo(NEW.custom_square_m);
		SET NEW.custom_square2_tsubo = tsubo(NEW.custom_square2_m2);
		SET NEW.custom_item_no = (SELECT max(custom_item_no)+1 FROM contacts);
	END;$$
	
DROP TRIGGER IF EXISTS contacts_before_update;$$
CREATE TRIGGER contacts_before_update
	BEFORE UPDATE ON contacts
	FOR EACH ROW
	BEGIN
		IF NEW.custom_build_year <> OLD.custom_build_year THEN
			SET NEW.custom_passed_time = yearmonth(NEW.custom_build_year);
		END IF;
		IF NEW.custom_square_m <> OLD.custom_square_m THEN
			SET NEW.custom_square_tsubo = tsubo(NEW.custom_square_m);
		END IF;
		IF NEW.custom_square2_m2 <> OLD.custom_square2_m2 THEN
			SET NEW.custom_square2_tsubo = tsubo(NEW.custom_square2_m2);
		END IF;
	END;$$	
	
	
	
	
