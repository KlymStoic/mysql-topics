USE mysql_sample_db;


/** Syntax:
DROP TRIGGER [IF EXISTS] [schema_name.]trigger_name;
**/

-- Note: If u omit schema (database) name MySQL will choose trigger from your current db;

-- Note: If you drop table with triggers, MySQL will automatically drop them too;


-- Let's create a table for demonstration!

CREATE TABLE billings(
	billingNo INT AUTO_INCREMENT,
    customerNo INT,
    billingDate DATE,
    amount DEC(10, 2), 
    PRIMARY KEY (billingNo)
) ENGINE=INNODB;

-- Note: DEC = DECIMAL; 

DELIMITER $$

CREATE TRIGGER before_billing_update
	BEFORE UPDATE
    ON billings
    FOR EACH ROW
BEGIN
	IF NEW.amount > OLD.amount * 10 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = "New amount cannot be 10 times greater than the current amount.";
	END IF;
END $$

DELIMITER ;

-- Checking time!

SHOW TRIGGERS;

DROP TRIGGER IF EXISTS before_billing_update;

SHOW TRIGGERS;

/** Note: Cool that I didn't even need to check if that complex trigger even works,
		  so now I will (;
**/

-- Preparation:

INSERT INTO billings(customerNo, billingDate, amount)
VALUES
	(102, '1995-01-23', 44);
    
-- Trigger check:

UPDATE billings
SET amount = 999
WHERE billingNo = 1;

-- Error Code: 1644. New amount cannot be 10 times greater than the current amount.

-- Note: Surprisingly it works! Jokes aside, I still needed to fix it a little;