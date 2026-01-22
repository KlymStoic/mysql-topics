USE mysql_sample_db;


-- Note: The `HELP` statement returns online information from the MySQL Reference Manual;

/** Syntax:
HELP 'search_string';
**/

/** Note: The `HELP` statement searches the help tables for the given `search_string` and displays the result of the search.
        The `search_string` is not case-sensitive;
**/

/** Note: The `search_string` can contain the wildcard characters `%` and `_`. These have the same meaning as for pattern-matching operations
        performed with the `LIKE` operator. (e.g. `HELP 'rep%'` returns a list of topics that begin with `rep`);
**/


-- Example:

-- Note: At the most general level, use 'contents' to retrieve a list of the top-level help categories:

HELP 'contents';

-- Note: For a list of topics in a given help category, such as `Data Types`, use the category name:

HELP 'data types';


/** Note: For help on a specific help topic, such as the `ASCII()` function or the `CREATE TABLE` statement, 
        use the associated keyword or keywords:
**/

HELP 'asci_';

HELP 'cr%table';


-- Empty result:

HELP 'fake';


-- Result set containing a single row:

HELP 'log';

-- Note: To view long output use `Open Value in Viewer`, then choose `Text` option instead of `Binary`;


-- List of topics(Search string matched multiple help topics):

HELP 'status';

-- Note: A list is also displayed if the `search_string` matches a category;

HELP 'functions';


-- EnD !_!;