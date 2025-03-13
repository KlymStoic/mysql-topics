USE mysql_sample_db;


/** Syntax:
CREATE TRIGGER trigger_name
{BEFORE | AFTER} {UPDATE | DELETE | INSERT}
ON table_name
FOR EACH ROW
BEGIN
	-- Trigger body(SQL statements)
END;
**/


-- Creating tables to experiment on it:

CREATE TABLE items(
	id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE item_changes(
	change_id INT PRIMARY KEY AUTO_INCREMENT,
    item_id INT,
    change_type VARCHAR(10),
    change_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_id
    FOREIGN KEY (item_id)
    REFERENCES items(id)
);

-- Creating trigger:

DELIMITER $$

CREATE TRIGGER update_items_trigger
AFTER UPDATE
ON items
FOR EACH ROW
BEGIN
	INSERT INTO item_changes(item_id, change_type)
    VALUES
		(NEW.id, 'UPDATE');
END $$

DELIMITER ;

-- Check time!

INSERT INTO items
VALUES
	(1, 'Some Item', 99.9);
    
SELECT * FROM items;
SELECT * FROM item_changes;

-- Note: Nothing changed because only 'UPDATE' trigger the trigger;

UPDATE items
SET price = 49.9
WHERE id = 1;

SELECT * FROM items;
SELECT * FROM item_changes;


-- How to show the trigger info:

SHOW triggers;

-- Note: Use the 'Toggle Wrap Cell Content' button on 'Statement' column;
