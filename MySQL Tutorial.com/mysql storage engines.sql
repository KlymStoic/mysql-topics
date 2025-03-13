USE mysql_sample_db;


-- Query to find available storage engines:

SELECT
	engine,
    support
FROM
	information_schema.engines
ORDER BY engine;


-- Alternative query for that:

SHOW ENGINES;


-- Note: MySQL 5.5 or later uses InnoDB as the default storage engine;


/** Syntax to specify engine when we create table:
CREATE TABLE table_name(
	column_list
) [ENGINE = engine_name];
**/

-- Note: If u omit ENGINE clause it still means that table has storage engine;

-- Note: All engines extend abilities of InnoDB sacrificing other characteristics;

/** Note: InnoDB is a good engine, but even it has one weakness.
It don't have external data access.
**/