

pt-osc采用 小步快走的方式，把一个表的数据拆分成多份，也叫chunk，然后逐个击破。这样一来数据做了切分，粒度小了，阻塞的影响也会大大降低。

所以pt-osc工具实现了一个切分的思路，这个是原本的触发器不可替代的。

整个数据的复制中增量DML的replace into处理很巧妙，加上数据的粒度拆分，让这个事情变得可控可用。



pt-osc 把一个表的数据拆分成多份，也叫chunk, SQL语句执行如下:

	INSERT LOW_PRIORITY IGNORE INTO 新表 select  旧表 WHERE ((`id` >= '324960')) AND ((`id` <= '327490')) LOCK IN SHARE MODE 

	

这样一来数据做了切分，粒度小了，阻塞的影响也会大大降低。



各自的优缺点、限制、性能消耗


思考:
	拷贝过程中通过原表上的触发器在原表进行的写操作都会更新到新建的临时表； 这里会不会有问题?
	
	场景1. 
		如果在 拷贝过程中, 原表发生了 Update语句, 刚好要 执行的update的数据没有通过触发器写入到临时表中,
		那么会不会发生数据丢失?
	答: 不会, 要 执行的update的数据没有通过触发器写入到临时表中, 但是在原表已经有更新, 这时会同步到到临时表中.
	
	
	

表的大小：
索引：2.27 GB (2,437,496,832)
数据：3.33 GB (3,579,822,080)

一共 5.6G;



硬件配置：
	
内存：16G
cpu：4C
硬盘：SSD


主：

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


从：

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


shell > pt-online-schema-change --version
	pt-online-schema-change 3.0.12


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

set global max_binlog_cache_size=10737418240;



binlog占用磁盘空间大小：

延迟的大小：

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

修改这个参数会导致DDL很慢：--chunk-size-limit=20000  
在做主从数据一致性检验，遇到大表才需要配置这个参数。

mysql> alter table table_test add column filed_02 int(10) not null default 0 comment 'filed_02';
Query OK, 0 rows affected (15 min 39.57 sec)
Records: 0  Duplicates: 0  Warnings: 0

Seconds_Behind_Master: 1608



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




3.71 GB (3,979,837,440)
3.06 GB (3,290,431,488)


shell> time pt-online-schema-change  --max-lag=1000 --no-check-replication-filters  --charset=utf8mb4 --execute --alter "add column filed_04 int(10) not null default 0 comment 'filed_04'" --user=root --password=abc123456 --host=192.168.1.1 D=table_test,t=table_test
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
2019-06-12T15:31:58 Creating triggers...
2019-06-12T15:31:58 Created triggers OK.
2019-06-12T15:31:58 Copying approximately 17923788 rows...
Copying `table_test`.`table_test`:   4% 11:11 remain
Copying `table_test`.`table_test`:   8% 11:20 remain
Copying `table_test`.`table_test`:  11% 11:16 remain
Copying `table_test`.`table_test`:  15% 11:05 remain
Copying `table_test`.`table_test`:  18% 10:48 remain
Copying `table_test`.`table_test`:  22% 10:26 remain
Copying `table_test`.`table_test`:  25% 10:00 remain
Copying `table_test`.`table_test`:  29% 09:32 remain
Copying `table_test`.`table_test`:  33% 09:08 remain
Copying `table_test`.`table_test`:  36% 08:43 remain
Copying `table_test`.`table_test`:  40% 08:14 remain
Copying `table_test`.`table_test`:  43% 07:48 remain
Copying `table_test`.`table_test`:  46% 07:22 remain
Copying `table_test`.`table_test`:  50% 06:55 remain
Copying `table_test`.`table_test`:  53% 06:26 remain
Copying `table_test`.`table_test`:  57% 05:58 remain
Copying `table_test`.`table_test`:  60% 05:28 remain
Copying `table_test`.`table_test`:  64% 04:57 remain
Copying `table_test`.`table_test`:  68% 04:25 remain
Copying `table_test`.`table_test`:  71% 03:56 remain
Copying `table_test`.`table_test`:  75% 03:25 remain
Copying `table_test`.`table_test`:  79% 02:53 remain
Copying `table_test`.`table_test`:  82% 02:30 remain
Copying `table_test`.`table_test`:  85% 02:04 remain
Copying `table_test`.`table_test`:  88% 01:36 remain
Copying `table_test`.`table_test`:  92% 01:07 remain
Copying `table_test`.`table_test`:  95% 00:38 remain
Copying `table_test`.`table_test`:  99% 00:07 remain
2019-06-12T15:46:21 Copied rows OK.
2019-06-12T15:46:21 Analyzing new table...
2019-06-12T15:46:21 Swapping tables...
2019-06-12T15:46:21 Swapped original and new tables OK.
2019-06-12T15:46:21 Dropping old table...
2019-06-12T15:46:23 Dropped old table `table_test`.`_table_test_old` OK.
2019-06-12T15:46:23 Dropping triggers...
2019-06-12T15:46:23 Dropped triggers OK.
Successfully altered `table_test`.`table_test`.

real	14m26.788s
user	0m2.691s
sys	0m0.579s


time pt-online-schema-change  --max-lag=1000 --no-check-replication-filters  --charset=utf8mb4 --execute --alter "engine=InnoDB" --user=root --password=abc123456 --host=192.168.1.1 D=table_test,t=table_test
