
DROP TRIGGER IF EXISTS leads_before_insert;$$
CREATE TRIGGER leads_before_insert
	BEFORE INSERT ON leads
	FOR EACH ROW
	BEGIN
		SET NEW.custom_client_id = (SELECT max(custom_client_id)+1 FROM leads);
	END;$$
