

CREATE TABLE t2 (
id int(11) DEFAULT NULL,
name char(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8

 insert delayed into t2(id,name) values(2,'c');
 
在MySQL 5.6中不推荐使用DELAYED插入和替换。 
在MySQL 5.7中，不支持DELAYED。 服务器识别但忽略DELAYED关键字，将插入作为非延迟插入进行处理。



1、delayed:

	  如果您使用DELAYED关键字，则服务器会把待插入的行放到一个缓冲器中，而发送INSERT DELAYED语句的客户端会继续运行。

	  如果表正在被使用，则服务器会保留这些行。当表空闲时，服务器开始插入行，并定期检查是否有新的读取请求。

	  如果有新的读取请求，则被延迟的行被延缓执行，直到表再次空闲时为止。

2、low_priority:

	  如果您使用LOW_PRIORITY关键词，则INSERT的执行被延迟，直到没有其它客户端从表中读取为止。当原有客户端正在读取时，

	  有些客户端刚开始读取。这些客户端也被包括在内。此时，INSERT LOW_PRIORITY语句等候。因此，在读取量很大的情况下，

	  发出INSERT LOW_PRIORITY语句的客户端有可能需要等待很长一段时间（甚至是永远等待下去）。

	（这与INSERT DELAYED形成对比，INSERT DELAYED立刻让客户端继续执行。）

	  注意LOW_PRIORITY通常不应用于MyISAM表，因为这么做会取消同时进行的插入。

3、high_priority:

	  如果您指定了HIGH_PRIORITY，同时服务器采用--low-priority-updates选项启动，则HIGH_PRIORITY将覆盖--low-priority-updates选项。这么做还会导                         致同时进行的插入被取消。

4、ignore:

	  如果您在一个INSERT语句中使用IGNORE关键词，在执行语句时出现的错误被当作警告处理。行还是不会被插入。
	  
pt-osc：
	INSERT LOW_PRIORITY IGNORE INTO …SELECT ...... FROM … FORCE INDEX(`PRIMARY`) WHERE 主键范围  LOCK IN SHARE MODE ;  	
	
	
相关参考	  
	https://www.cnblogs.com/JiangLe/p/4010288.html MYSQL insert
	
	

help insert
	root@mysqldb 13:42:  [test_db]> help insert;
	Name: 'INSERT'
	Description:
	Syntax:
	
	INSERT [LOW_PRIORITY | DELAYED | HIGH_PRIORITY] [IGNORE]
		[INTO] tbl_name
		[PARTITION (partition_name [, partition_name] ...)]
		[(col_name [, col_name] ...)]
		{VALUES | VALUE} (value_list) [, (value_list)] ...
		[ON DUPLICATE KEY UPDATE assignment_list]

	INSERT [LOW_PRIORITY | DELAYED | HIGH_PRIORITY] [IGNORE]
		[INTO] tbl_name
		[PARTITION (partition_name [, partition_name] ...)]
		SET assignment_list
		[ON DUPLICATE KEY UPDATE assignment_list]

	INSERT [LOW_PRIORITY | HIGH_PRIORITY] [IGNORE]
		[INTO] tbl_name
		[PARTITION (partition_name [, partition_name] ...)]
		[(col_name [, col_name] ...)]
		SELECT ...
		[ON DUPLICATE KEY UPDATE assignment_list]

	value:
		{expr | DEFAULT}

	value_list:
		value [, value] ...

	assignment:
		col_name = value

	assignment_list:
		assignment [, assignment] ...

	INSERT inserts new rows into an existing table. The INSERT ... VALUES
	and INSERT ... SET forms of the statement insert rows based on
	explicitly specified values. The INSERT ... SELECT form inserts rows
	selected from another table or tables. INSERT with an ON DUPLICATE KEY
	UPDATE clause enables existing rows to be updated if a row to be
	inserted would cause a duplicate value in a UNIQUE index or PRIMARY
	KEY.

	For additional information about INSERT ... SELECT and INSERT ... ON
	DUPLICATE KEY UPDATE, see [HELP INSERT SELECT], and
	http://dev.mysql.com/doc/refman/5.7/en/insert-on-duplicate.html.

	In MySQL 5.7, the DELAYED keyword is accepted but ignored by the
	server. For the reasons for this, see [HELP INSERT DELAYED],

	Inserting into a table requires the INSERT privilege for the table. If
	the ON DUPLICATE KEY UPDATE clause is used and a duplicate key causes
	an UPDATE to be performed instead, the statement requires the UPDATE
	privilege for the columns to be updated. For columns that are read but
	not modified you need only the SELECT privilege (such as for a column
	referenced only on the right hand side of an col_name=expr assignment
	in an ON DUPLICATE KEY UPDATE clause).

	When inserting into a partitioned table, you can control which
	partitions and subpartitions accept new rows. The PARTITION option
	takes a list of the comma-separated names of one or more partitions or
	subpartitions (or both) of the table. If any of the rows to be inserted
	by a given INSERT statement do not match one of the partitions listed,
	the INSERT statement fails with the error Found a row not matching the
	given partition set. For more information and examples, see
	http://dev.mysql.com/doc/refman/5.7/en/partitioning-selection.html.

	URL: http://dev.mysql.com/doc/refman/5.7/en/insert.html


