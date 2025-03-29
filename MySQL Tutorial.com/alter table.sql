-- Setting sample db and tables:

CREATE SCHEMA sample_tables;

USE sample_tables;

CREATE TABLE vehicles (
	vehicleId INT,
    `year` INT NOT NULL,
	make VARCHAR(100) NOT NULL,
    PRIMARY KEY(vehicleId)
) ENGINE=INNODB;


-- ALTER TABLE ADD statement:

/** Syntax:
ALTER TABLE table_name
ADD
	new_column_name column_definition
    [FIRST|AFTER column_name];
**/

-- Example:

ALTER TABLE vehicles
ADD	model VARCHAR(100) NOT NULL;

-- Check:
SELECT *
FROM vehicles;

DESCRIBE vehicles;

-- Note: 'DESCRIBE' statement shows the column list of the table;

/** To add multiple columns to a table, u use next syntax:
ALTER TABLE table_name
ADD new_column_name column_definition
[FIRST|AFTER column_name],
ADD new_column_name column_definition
[FIRST|AFTER column_name],
...;
**/

-- Example:

ALTER TABLE vehicles
ADD color VARCHAR(50),
ADD note VARCHAR(255);

-- Check:
DESCRIBE vehicles;


-- ALTER TABLE MODIFY statement:

/** Syntax:
ALTER TABLE table_name
MODIFY column_name column_definition
[FIRST|AFTER column_name];
**/

-- Note: It's a good practice to view the attributes of a column before modifying it;

DESCRIBE vehicles;

-- Example:

ALTER TABLE vehicles
MODIFY note VARCHAR(100) NOT NULL;

-- Check:
DESCRIBE vehicles;

/** Syntax for modifying multiple columns:
ALTER TABLE table_name
MODIFY column_name column_definition
[FIRST|AFTER column_name],
MODIFY column_name column_definition
[FIRST|AFTER column_name],
...;
**/

-- Example:

ALTER TABLE vehicles
MODIFY `year` SMALLINT NOT NULL,
MODIFY color VARCHAR(20) NOT NULL
AFTER make;

-- Check:
DESCRIBE vehicles;


-- ALTER TABLE CHANGE COLUMN statement:

/** Syntax:
ALTER TABLE table_name
CHANGE COLUMN original_column_name new_column_name column_definition
[FIRST|AFTER column_name];
**/

-- Note: 'CHANGE COLUMN' statement used for renaming columns;

-- Example:

ALTER TABLE vehicles
CHANGE COLUMN note vehicleCondition VARCHAR(100) NOT NULL;

-- Check:
DESCRIBE vehicles;


-- ALTER TABLE DROP COLUMN statement:

/** Syntax:
ALTER TABLE table_name
DROP COLUMN column_name;
**/

-- Example:

ALTER TABLE vehicles
DROP COLUMN vehicleCondition;

-- Check:
DESCRIBE vehicles;


-- ALTER TABLE RENAME TO statement:

/** Syntax:
ALTER TABLE table_name
RENAME TO new_table_name;
**/

-- Example:

ALTER TABLE vehicles
RENAME TO cars;


-- The End :-)