
1. 表的数据量大小
2. 硬件配置
3. 主库相关参数
4. 从库相关参数
5. 单个binlog超过max_binlog_size(1073741824即1G)的大小
6. 解决办法
7. 关于chunk-size-limit参数
8. 原生Online DDL的延迟大小 
9. pt-online-schema-change操作的耗时 



1. 表的数据量大小
	索引：2.27 GB (2,437,496,832)
	数据：3.33 GB (3,579,822,080)
	一共 5.6G;

2. 硬件配置
	内存：16G
	cpu：4C
	硬盘：SSD


3. 主库相关参数

	mysql> show global variables like 'sync_binlog';
	+---------------+-------+
	| Variable_name | Value |
	+---------------+-------+
	| sync_binlog   | 1     |
	+---------------+-------+
	1 row in set (0.00 sec)

	mysql> show global variables like 'innodb_flush_log_at_trx_commit';
	+--------------------------------+-------+
	| Variable_name                  | Value |
	+--------------------------------+-------+
	| innodb_flush_log_at_trx_commit | 1     |
	+--------------------------------+-------+
	1 row in set (0.01 sec)

	mysql> show global variables like 'max_binlog_cache_size';
	+-----------------------+------------+
	| Variable_name         | Value      |
	+-----------------------+------------+
	| max_binlog_cache_size | 1073741824 |
	+-----------------------+------------+
	1 row in set (0.01 sec)


	mysql> show global variables like 'max_binlog_size';
	+-----------------+------------+
	| Variable_name   | Value      |
	+-----------------+------------+
	| max_binlog_size | 1073741824 |
	+-----------------+------------+
	1 row in set (0.00 sec)


4. 从库相关参数

	mysql> show global variables like 'max_binlog_cache_size';
	+-----------------------+------------+
	| Variable_name         | Value      |
	+-----------------------+------------+
	| max_binlog_cache_size | 1073741824 |
	+-----------------------+------------+
	1 row in set (0.00 sec)

	mysql> show global variables like 'sync_binlog';
	+---------------+-------+
	| Variable_name | Value |
	+---------------+-------+
	| sync_binlog   | 1000  |
	+---------------+-------+
	1 row in set (0.00 sec)

	mysql>  show global variables like 'innodb_flush_log_at_trx_commit';
	+--------------------------------+-------+
	| Variable_name                  | Value |
	+--------------------------------+-------+
	| innodb_flush_log_at_trx_commit | 2     |
	+--------------------------------+-------+
	1 row in set (0.01 sec)

	mysql> show global variables like 'max_binlog_size';
	+-----------------+------------+
	| Variable_name   | Value      |
	+-----------------+------------+
	| max_binlog_size | 1073741824 |
	+-----------------+------------+
	1 row in set (0.00 sec)


5. 单个binlog超过max_binlog_size(1073741824即1G)的大小

	shell > pt-online-schema-change --version
		pt-online-schema-change 3.0.12


	shell> time pt-online-schema-change --chunk-size-limit=20000 --no-check-replication-filters  --charset=utf8mb4 --execute --alter "add column filed_02 int(10) not null default 0 comment 'filed_02'" --user=root --password=abc123456 --host=192.168.1.1 D=table_test,t=table_test
	Found 1 slaves:
	database-06.system.com -> 39.108.17.15:socket
	Will check slave lag on:
	database-06.system.com -> 39.108.17.15:socket
	Operation, tries, wait:
	  analyze_table, 10, 1
	  copy_rows, 10, 0.25
	  create_triggers, 10, 1
	  drop_triggers, 10, 1
	  swap_tables, 10, 1
	  update_foreign_keys, 10, 1
	Altering `table_test`.`table_test`...
	Creating new table...
	Created new table table_test._table_test_new OK.
	Altering new table...
	Altered `table_test`.`_table_test_new` OK.
	2019-06-12T10:39:23 Creating triggers...
	2019-06-12T10:39:23 Created triggers OK.
	2019-06-12T10:39:23 Copying approximately 17419178 rows...
	2019-06-12T10:49:28 Dropping triggers...
	2019-06-12T10:49:28 Dropped triggers OK.
	2019-06-12T10:49:28 Dropping new table...
	2019-06-12T10:49:28 Dropped new table OK.
	`table_test`.`table_test` was not altered.
	2019-06-12T10:49:28 Error copying rows from `table_test`.`table_test` to `table_test`.`_table_test_new`: 
	2019-06-12T10:49:28 DBD::mysql::st execute failed: Multi-statement transaction required more than 'max_binlog_cache_size' bytes of storage; 
	increase this mysqld variable and try again 
	[for Statement "INSERT LOW_PRIORITY IGNORE INTO `table_test`.`_table_test_new` 
	(`id`, `nclubid`, `ntableid`, `nchairid`, `sztoken`, `nround`, `nbasescore`, `nplaycount`, `tstarttime`, `tendtime`, `nplayerid`, `brobot`, `szcarddata`, `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, `ncarddata`, `nbankid`, `szextchar`, `test_filed`, `aa`) 
	SELECT `id`, `nclubid`, `ntableid`, `nchairid`, `sztoken`, `nround`, `nbasescore`, `nplaycount`, `tstarttime`, `tendtime`, `nplayerid`, `brobot`, `szcarddata`, `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, `ncarddata`, `nbankid`, `szextchar`, `test_filed`, `aa` 
	FROM `table_test`.`table_test` LOCK IN SHARE MODE /*pt-online-schema-change 13423 copy table*/"] 
	at /usr/bin/pt-online-schema-change line 11444.

	#没有加字段成功。

	原因：
	pt-osc对大表操作，有个比较严重的问题就是会导致单个binlog超过max_binlog_size(1073741824即1G)的大小。

	-rw-r----- 1 mysql mysql 2.6G 2019-06-12 11:19 mysql-bin.000082
	-rw-r----- 1 mysql mysql 2.0G 2019-06-12 10:20 mysql-bin.000080
	-rw-r----- 1 mysql mysql 1.9G 2019-06-12 09:44 mysql-bin.000079


6. 解决办法

	set global max_binlog_cache_size=10737418240;


	执行时间：27m5; 


	[root@database-05 data]# time pt-online-schema-change --chunk-size-limit=20000 --no-check-replication-filters  --charset=utf8mb4 --execute --alter "add column filed_02 int(10) not null default 0 comment 'filed_02'" --user=root --password=abc123456 --host=192.168.1.1 D=table_test,t=table_test
	Found 1 slaves:
	database-06.system.com -> 39.108.17.15:socket
	Will check slave lag on:
	database-06.system.com -> 39.108.17.15:socket
	Operation, tries, wait:
	  analyze_table, 10, 1
	  copy_rows, 10, 0.25
	  create_triggers, 10, 1
	  drop_triggers, 10, 1
	  swap_tables, 10, 1
	  update_foreign_keys, 10, 1
	Altering `table_test`.`table_test`...
	Creating new table...
	Created new table table_test._table_test_new OK.
	Altering new table...
	Altered `table_test`.`_table_test_new` OK.
	2019-06-12T11:05:40 Creating triggers...
	2019-06-12T11:05:40 Created triggers OK.
	2019-06-12T11:05:40 Copying approximately 17419178 rows...
	Replica lag is 253 seconds on database-06.system.com.  Waiting.
	Replica lag is 283 seconds on database-06.system.com.  Waiting.
	Replica lag is 313 seconds on database-06.system.com.  Waiting.
	Replica lag is 343 seconds on database-06.system.com.  Waiting.
	Replica lag is 373 seconds on database-06.system.com.  Waiting.
	Replica lag is 403 seconds on database-06.system.com.  Waiting.
	Replica lag is 433 seconds on database-06.system.com.  Waiting.
	Replica lag is 463 seconds on database-06.system.com.  Waiting.
	Replica lag is 493 seconds on database-06.system.com.  Waiting.
	Replica lag is 523 seconds on database-06.system.com.  Waiting.
	Replica lag is 553 seconds on database-06.system.com.  Waiting.
	Replica lag is 583 seconds on database-06.system.com.  Waiting.
	Replica lag is 613 seconds on database-06.system.com.  Waiting.
	Replica lag is 643 seconds on database-06.system.com.  Waiting.
	Replica lag is 673 seconds on database-06.system.com.  Waiting.
	Replica lag is 703 seconds on database-06.system.com.  Waiting.
	Replica lag is 733 seconds on database-06.system.com.  Waiting.
	Replica lag is 763 seconds on database-06.system.com.  Waiting.
	Replica lag is 793 seconds on database-06.system.com.  Waiting.
	Replica lag is 823 seconds on database-06.system.com.  Waiting.
	Replica lag is 853 seconds on database-06.system.com.  Waiting.
	Replica lag is 883 seconds on database-06.system.com.  Waiting.
	Replica lag is 913 seconds on database-06.system.com.  Waiting.
	Replica lag is 943 seconds on database-06.system.com.  Waiting.
	Replica lag is 973 seconds on database-06.system.com.  Waiting.
	Replica lag is 1003 seconds on database-06.system.com.  Waiting.
	Replica lag is 1033 seconds on database-06.system.com.  Waiting.
	2019-06-12T11:33:29 Copied rows OK.
	2019-06-12T11:33:29 Analyzing new table...
	2019-06-12T11:33:29 Swapping tables...
	2019-06-12T11:33:29 Swapped original and new tables OK.
	2019-06-12T11:33:29 Dropping old table...
	2019-06-12T11:33:30 Dropped old table `table_test`.`_table_test_old` OK.
	2019-06-12T11:33:30 Dropping triggers...
	2019-06-12T11:33:30 Dropped triggers OK.
	Successfully altered `table_test`.`table_test`.

	real	27m50.996s
	user	0m0.585s
	sys	0m0.118s

7. 关于chunk-size-limit参数

	修改这个参数会导致DDL很慢：--chunk-size-limit=20000  
	在做主从数据一致性检验，遇到大表才需要配置这个参数。


8. 原生Online DDL的延迟大小 

	mysql> alter table table_test add column filed_02 int(10) not null default 0 comment 'filed_02';
	Query OK, 0 rows affected (15 min 39.57 sec)
	Records: 0  Duplicates: 0  Warnings: 0

	Seconds_Behind_Master: 1608


9. pt-online-schema-change操作的耗时 

	shell >  time pt-online-schema-change --no-check-replication-filters  --charset=utf8mb4 --execute --alter "add column filed_03 int(10) not null default 0 comment 'filed_03'" --user=root --password=abc123456 --host=192.168.1.1 D=table_test,t=table_test
	Found 1 slaves:
	database-06.system.com -> 39.108.17.15:socket
	Will check slave lag on:
	database-06.system.com -> 39.108.17.15:socket
	Operation, tries, wait:
	  analyze_table, 10, 1
	  copy_rows, 10, 0.25
	  create_triggers, 10, 1
	  drop_triggers, 10, 1
	  swap_tables, 10, 1
	  update_foreign_keys, 10, 1
	Altering `table_test`.`table_test`...
	Creating new table...
	Created new table table_test._table_test_new OK.
	Altering new table...
	Altered `table_test`.`_table_test_new` OK.
	2019-06-12T15:12:11 Creating triggers...
	2019-06-12T15:12:11 Created triggers OK.
	2019-06-12T15:12:11 Copying approximately 17849904 rows...
	Copying `table_test`.`table_test`:   3% 13:30 remain     #13:30 表示预计要完成的时间。
	Copying `table_test`.`table_test`:   6% 13:45 remain
	Copying `table_test`.`table_test`:  10% 13:07 remain
	Copying `table_test`.`table_test`:  13% 13:00 remain
	Copying `table_test`.`table_test`:  16% 12:35 remain
	Copying `table_test`.`table_test`:  19% 12:28 remain
	Copying `table_test`.`table_test`:  22% 11:50 remain
	Copying `table_test`.`table_test`:  25% 11:24 remain
	Copying `table_test`.`table_test`:  29% 10:51 remain
	Copying `table_test`.`table_test`:  32% 10:34 remain
	Copying `table_test`.`table_test`:  35% 09:56 remain
	Copying `table_test`.`table_test`:  38% 09:33 remain
	Copying `table_test`.`table_test`:  41% 09:15 remain
	Copying `table_test`.`table_test`:  44% 08:55 remain
	Copying `table_test`.`table_test`:  47% 08:29 remain
	Copying `table_test`.`table_test`:  50% 08:01 remain
	Copying `table_test`.`table_test`:  52% 07:36 remain
	Copying `table_test`.`table_test`:  56% 07:05 remain
	Copying `table_test`.`table_test`:  59% 06:35 remain
	Copying `table_test`.`table_test`:  62% 06:06 remain
	Copying `table_test`.`table_test`:  65% 05:27 remain
	Copying `table_test`.`table_test`:  69% 04:56 remain
	Copying `table_test`.`table_test`:  72% 04:28 remain
	Copying `table_test`.`table_test`:  75% 03:58 remain
	Copying `table_test`.`table_test`:  78% 03:22 remain
	Copying `table_test`.`table_test`:  81% 03:01 remain
	Copying `table_test`.`table_test`:  83% 02:36 remain
	Copying `table_test`.`table_test`:  86% 02:08 remain
	Copying `table_test`.`table_test`:  90% 01:36 remain
	Copying `table_test`.`table_test`:  93% 01:03 remain
	Copying `table_test`.`table_test`:  96% 00:33 remain
	Copying `table_test`.`table_test`:  99% 00:06 remain
	2019-06-12T15:28:40 Copied rows OK.
	2019-06-12T15:28:40 Analyzing new table...
	2019-06-12T15:28:40 Swapping tables...
	2019-06-12T15:28:40 Swapped original and new tables OK.
	2019-06-12T15:28:40 Dropping old table...
	2019-06-12T15:28:44 Dropped old table `table_test`.`_table_test_old` OK.
	2019-06-12T15:28:44 Dropping triggers...
	2019-06-12T15:28:44 Dropped triggers OK.
	Successfully altered `table_test`.`table_test`.

	real	16m34.209s
	user	0m2.703s
	sys	0m0.579s



