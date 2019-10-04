
DROP TRIGGER IF EXISTS accounts_before_insert;$$
CREATE TRIGGER accounts_before_insert
	BEFORE INSERT ON accounts
	FOR EACH ROW
	BEGIN
		SET NEW.custom_customer_number = (SELECT max(custom_customer_number)+1 FROM accounts);
	END;$$
