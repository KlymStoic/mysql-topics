USE mysql_sample_db;

/** Syntax:
CREATE TABLE [IF NOT EXISTS] table_name (
	column1 datatype constraints,
    column2 datatype constraints,
    ...
) [ENGINE=engine_storage];
**/

/** List of the most common constraints:
NOT NULL -> Ensures a column cannot have NULL values.
PRIMARY KEY -> Combines UNIQUE + NOT NULL, uniquely identifies each row.
FOREIGN KEY -> Enforces referential integrity by linking to another table.
AUTO_INCREMENT -> Automatically generates unique numeric values.
UNIQUE -> Ensures all values in a column are distinct.
DEFAULT -> Assigns a default value if none is provided;
**/

/** Note: InnoDB is the default storage engine in MySQL v5.5+
		MyISAM was the default before that;
**/


-- Basic example:

CREATE TABLE tasks (
	id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    start_date DATE,
    due_date DATE
);

-- To check:
SHOW TABLES;


-- Example with keys:

CREATE TABLE checklists (
	id INT,
    task_id INT,
    title VARCHAR(255) NOT NULL,
    is_completed BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (id, task_id),
    FOREIGN KEY (task_id)
		REFERENCES tasks (id)
        ON UPDATE RESTRICT
        ON DELETE CASCADE
);

/** Note: 'ON UPDATE RESTRICT' prevents updating the 'id' column in the tasks table
		if referenced by checklists;
	Note: 'ON DELETE CASCADE' removes all related checklist items when a task is deleted;
**/

-- The end :/