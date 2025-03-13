USE mysql_sample_db;


/** Syntax:
TRUNCATE [TABLE] table_name;
**/

-- Note: The TABLE keyword is optional but helps avoid confussion with the TRUNCATE function;

/** Note: TRUNCATE TABLE fails if foreign key constraints exist, commits
		implicitly (non-rollbackable), and doesn't fire DELETE triggers;
**/

/** Note: TRUNCATE TABLE resets AUTO_INCREMENT to its initial value and returns 0
		affected rows, meaning no information;
**/

/** Note: TRUNCATE TABLE works like a DELETE statement without a WHERE clause or
		a DROP/CREATE sequence, but it's more efficient because it recreates
		the table rather than deleting rows one by one;
**/


-- Preparation:

CREATE TABLE books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL
) ENGINE=INNODB;

-- Next, insert dummy data into the books table by using the following stored procedure:

DELIMITER $$

CREATE PROCEDURE load_book_data(IN num INT(4))
BEGIN
	DECLARE counter INT(4) DEFAULT 0;
	DECLARE book_title VARCHAR(255) DEFAULT '';

	WHILE counter < num DO
	  SET book_title = CONCAT('Book title #',counter);
	  SET counter = counter + 1;

	  INSERT INTO books(title)
	  VALUES(book_title);
	END WHILE;
END$$

DELIMITER ;

-- Call it:
CALL load_book_data(10000);

-- Output: 1 row(s) affected 25.344 sec

-- Check:
SELECT * FROM books;


-- Example:
TRUNCATE TABLE books;

-- Output: 0 row(s) affected 0.031 sec


-- To compare:
DELETE FROM books;

-- Output: 10000 row(s) affected 0.094 sec


DROP TABLE IF EXISTS books;
-- The End :)