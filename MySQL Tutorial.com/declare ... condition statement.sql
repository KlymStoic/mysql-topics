USE mysql_sample_db;


/** Syntax:
DECLARE condition_name CONDITION FOR condition_value

condition_value: {
	mysql_error_code
	| SQLSTATE [VALUE] sqlstate_value
}
**/

-- Note: You should not use MySQL error code 0 or SQLSTATE value that stars with '00';

/** Example of handler:
DECLARE CONTINUE HANDLER FOR 1051
	BEGIN
		-- body of handler
	END;
**/