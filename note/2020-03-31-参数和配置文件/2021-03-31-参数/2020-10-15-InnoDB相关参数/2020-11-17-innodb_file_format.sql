

innodb_file_format
	该参数用于设置InnoDB表内部存储的文件格式，该参数可设置为Antelope,Barracuda两种格式。
	The innodb_file_format default value was changed to Barracuda in MySQL 5.7.

	MySQL 8.0下没有 innodb_file_format 参数.

innodb_default_row_format
	设置行记录的格式
	新的配置选项innodb_default_row_format指定默认的InnoDB行格式。
	允许的值包括DYNAMIC（默认值），COMPACT和REDUNDANT。
	
	  In MySQL 5.7.9, DYNAMIC replaces COMPACT as the implicit default row format for InnoDB tables.
	  A new configuration option, innodb_default_row_format, specifies the default InnoDB row format.
	  Permitted values include DYNAMIC (the default), COMPACT, and REDUNDANT.
	  
	  
	  
https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_file_format

	
mysql> select version();
+------------+
| version()  |
+------------+
| 5.7.22-log |
+------------+
1 row in set (0.00 sec)


mysql> show global variables like '%innodb_file_format%';
+--------------------------+-----------+
| Variable_name            | Value     |
+--------------------------+-----------+
| innodb_file_format       | Barracuda |
| innodb_file_format_check | ON        |
| innodb_file_format_max   | Barracuda |
+--------------------------+-----------+
3 rows in set (0.00 sec)


---------------------------------------------------------------

mysql> show global variables like '%innodb_default_row_format%';
+---------------------------+---------+
| Variable_name             | Value   |
+---------------------------+---------+
| innodb_default_row_format | dynamic |
+---------------------------+---------+
1 row in set (0.00 sec)

