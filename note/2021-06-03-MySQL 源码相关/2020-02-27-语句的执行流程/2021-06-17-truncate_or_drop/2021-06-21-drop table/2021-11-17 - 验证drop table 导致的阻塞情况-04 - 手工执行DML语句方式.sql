
1. 验证是否会阻塞delete和show create table语句
2. 验证是否会阻塞查询和插入语句
3. 小结

1. 验证是否会阻塞delete和show create table语句

	表的数据大小：
		[root@voice sbtest]# ls -lht sbtest1.ibd 
		-rw-r-----. 1 mysql mysql 12G Nov 17 12:14 sbtest1.ibd

		该表无脏页


	双1环境
		set global innodb_flush_log_at_trx_commit=1;
		set global sync_binlog=1;
		show global variables like '%innodb_flush_log_at_trx_commit%';
		show global variables like '%sync_binlog%';


		mysql> set global innodb_flush_log_at_trx_commit=1;
		Query OK, 0 rows affected (0.01 sec)

		mysql> set global sync_binlog=1;
		Query OK, 0 rows affected (0.00 sec)

		mysql> show global variables like '%innodb_flush_log_at_trx_commit%';
		+--------------------------------+-------+
		| Variable_name                  | Value |
		+--------------------------------+-------+
		| innodb_flush_log_at_trx_commit | 1     |
		+--------------------------------+-------+
		1 row in set (0.01 sec)

		mysql> show global variables like '%sync_binlog%';
		+---------------+-------+
		| Variable_name | Value |
		+---------------+-------+
		| sync_binlog   | 1     |
		+---------------+-------+
		1 row in set (0.00 sec)


	执行drop table语句

		drop table sbtest.sbtest1;

	执行 delete 和 show create table语句

		delete from sbtest_02.sbtest1 where id=2;

		show create table sbtest_02.sbtest2\G;


	show processlist

		mysql> show processlist;
		+-----+-----------------+--------------------+-----------+---------+-------+------------------------+------------------------------------------+
		| Id  | User            | Host               | db        | Command | Time  | State                  | Info                                     |
		+-----+-----------------+--------------------+-----------+---------+-------+------------------------+------------------------------------------+
		|   1 | event_scheduler | localhost          | NULL      | Daemon  | 46261 | Waiting on empty queue | NULL                                     |
		|  70 | root            | localhost          | sbtest_02 | Sleep   |   206 |                        | NULL                                     |
		|  71 | root            | localhost          | sbtest    | Sleep   |   202 |                        | NULL                                     |
		|  99 | root            | localhost          | NULL      | Sleep   |   208 |                        | NULL                                     |
		| 101 | root            | localhost          | NULL      | Sleep   |   193 |                        | NULL                                     |
		| 102 | root            | localhost          | NULL      | Sleep   |   189 |                        | NULL                                     |
		| 104 | root            | 192.168.1.11:56564 | NULL      | Sleep   |   236 |                        | NULL                                     |
		| 105 | root            | 192.168.1.11:56566 | NULL      | Query   |     3 | Opening tables         | delete from sbtest_02.sbtest1 where id=2 |
		| 106 | root            | 192.168.1.11:56568 | NULL      | Query   |     5 | checking permissions   | drop table sbtest.sbtest1                |
		| 109 | root            | 192.168.1.11:56702 | NULL      | Query   |     2 | Opening tables         | show create table sbtest_02.sbtest2      |
		| 110 | root            | 192.168.1.11:56714 | NULL      | Query   |     0 | starting               | show processlist                         |
		+-----+-----------------+--------------------+-----------+---------+-------+------------------------+------------------------------------------+
		11 rows in set (0.00 sec)


	耗时情况：

		mysql> drop table sbtest.sbtest1;
		Query OK, 0 rows affected (5.44 sec)


		mysql> delete from sbtest_02.sbtest1 where id=2;
		Query OK, 1 row affected (4.07 sec)


		mysql> show create table sbtest_02.sbtest2\G
		*************************** 1. row ***************************
			   Table: sbtest2
		Create Table: CREATE TABLE `sbtest2` (
		  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
		  `k` int(10) unsigned NOT NULL DEFAULT '0',
		  `c` char(120) NOT NULL DEFAULT '',
		  `pad` char(60) NOT NULL DEFAULT '',
		  PRIMARY KEY (`id`),
		  KEY `k_2` (`k`)
		) ENGINE=InnoDB AUTO_INCREMENT=100001 DEFAULT CHARSET=utf8mb4 MAX_ROWS=1000000
		1 row in set (3.32 sec)



2. 验证是否会阻塞查询和插入语句


	表的数据大小：
	
		[root@voice sbtest]# ls -lht sbtest1.ibd 
		-rw-r-----. 1 mysql mysql 32G Nov 17 14:10 sbtest1.ibd

		-------------------------------------
		INSERT BUFFER AND ADAPTIVE HASH INDEX
		-------------------------------------
		Ibuf: size 1, free list len 3059, seg size 3061, 478 merges
		merged operations:
		 insert 0, delete mark 479, delete 0
		discarded operations:
		 insert 0, delete mark 0, delete 0
		Hash table size 3187201, node heap has 1 buffer(s)
		Hash table size 3187201, node heap has 1 buffer(s)
		Hash table size 3187201, node heap has 1 buffer(s)
		Hash table size 3187201, node heap has 613 buffer(s)
		Hash table size 3187201, node heap has 260 buffer(s)
		Hash table size 3187201, node heap has 2 buffer(s)
		Hash table size 3187201, node heap has 1 buffer(s)
		Hash table size 3187201, node heap has 1 buffer(s)
		0.00 hash searches/s, 0.00 non-hash searches/s
		---
		LOG
		---
		Log sequence number 751177899581
		Log flushed up to   751177899581
		Pages flushed up to 751177899581
		Last checkpoint at  751177899572
		0 pending log flushes, 0 pending chkp writes
		305523 log i/o's done, 0.00 log i/o's/second


	双1环境
		set global innodb_flush_log_at_trx_commit=1;
		set global sync_binlog=1;
		show global variables like '%innodb_flush_log_at_trx_commit%';
		show global variables like '%sync_binlog%';


		mysql> set global innodb_flush_log_at_trx_commit=1;
		Query OK, 0 rows affected (0.01 sec)

		mysql> set global sync_binlog=1;
		Query OK, 0 rows affected (0.00 sec)

		mysql> show global variables like '%innodb_flush_log_at_trx_commit%';
		+--------------------------------+-------+
		| Variable_name                  | Value |
		+--------------------------------+-------+
		| innodb_flush_log_at_trx_commit | 1     |
		+--------------------------------+-------+
		1 row in set (0.01 sec)

		mysql> show global variables like '%sync_binlog%';
		+---------------+-------+
		| Variable_name | Value |
		+---------------+-------+
		| sync_binlog   | 1     |
		+---------------+-------+
		1 row in set (0.00 sec)
		
		
	执行drop table语句

		drop table sbtest.sbtest1;


	查询语句

		select * from sbtest_02.sbtest1 where id=1;
	
	插入语句：
		
		insert into sbtest_02.sbtest2(k, c) values(1,2);
	
	show processlist
		mysql> show processlist;
		+-----+-----------------+--------------------+-----------+---------+-------+------------------------+-------------------------------------------------+
		| Id  | User            | Host               | db        | Command | Time  | State                  | Info                                            |
		+-----+-----------------+--------------------+-----------+---------+-------+------------------------+-------------------------------------------------+
		|   1 | event_scheduler | localhost          | NULL      | Daemon  | 53533 | Waiting on empty queue | NULL                                            |
		|  70 | root            | localhost          | sbtest_02 | Sleep   |   206 |                        | NULL                                            |
		| 104 | root            | 192.168.1.11:56564 | NULL      | Sleep   |     5 |                        | NULL                                            |
		| 105 | root            | 192.168.1.11:56566 | NULL      | Query   |     3 | Opening tables         | insert into sbtest_02.sbtest2(k, c) values(1,2) |
		| 106 | root            | 192.168.1.11:56568 | NULL      | Query   |     6 | checking permissions   | drop table sbtest.sbtest1                       |
		| 109 | root            | 192.168.1.11:56702 | NULL      | Query   |     0 | starting               | show processlist                                |
		| 110 | root            | 192.168.1.11:56714 | NULL      | Sleep   |    62 |                        | NULL                                            |
		+-----+-----------------+--------------------+-----------+---------+-------+------------------------+-------------------------------------------------+
		11 rows in set (0.00 sec)
	
	耗时和阻塞情况：
	
		drop table语句
			mysql> drop table sbtest.sbtest1;
			Query OK, 0 rows affected (14.11 sec)
		
		查询语句
			mysql> select * from sbtest_02.sbtest1 where id=1;
			+----+-------+-------------------------------------------------------------------------------------------------------------------------+-------------------------------------------------------------+
			| id | k     | c                                                                                                                       | pad                                                         |
			+----+-------+-------------------------------------------------------------------------------------------------------------------------+-------------------------------------------------------------+
			|  1 | 42833 | 83868641912-28773972837-60736120486-75162659906-27563526494-20381887404-41576422241-93426793964-56405065102-33518432330 | 67847967377-48000963322-62604785301-91415491898-96926520291 |
			+----+-------+-------------------------------------------------------------------------------------------------------------------------+-------------------------------------------------------------+
			1 row in set (0.00 sec)

		插入语句：
			
			mysql> insert into sbtest_02.sbtest2(k, c) values(1,2);
			Query OK, 1 row affected (10.78 sec)


	磁盘IO利用率
		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sda               0.00     0.00   14.00   41.00     0.81     4.03   180.07     0.15    2.65    1.93    2.90   0.69   3.80

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sda               0.00     0.00    0.00   93.00     0.00     1.77    39.05     0.23    2.49    0.00    2.49   0.23   2.10

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sda               0.00     0.00    0.00   28.00     0.00     0.52    37.71     0.03    1.00    0.00    1.00   0.79   2.20

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sda               0.00     0.00    0.00   31.00     0.00     0.74    48.77     0.03    0.94    0.00    0.94   0.58   1.80

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sda               0.00     0.00    0.00   60.00     0.00     1.00    34.00     0.04    0.60    0.00    0.60   0.53   3.20

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sda               0.00     0.00    0.00   28.00     0.00     0.89    65.14     0.03    1.00    0.00    1.00   0.57   1.60

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sda               0.00     0.00    0.00   37.00     0.00     1.14    62.92     0.03    0.89    0.00    0.89   0.51   1.90

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sda               0.00     0.00    0.00   63.00     0.00     1.95    63.37     0.08    1.24    0.00    1.24   0.49   3.10

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sda               0.00     0.00    3.00   48.00     0.62     1.61    89.88     0.06    1.20    5.67    0.92   0.57   2.90

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sda               0.00     0.00    6.00  150.00     0.32     5.10    71.13     0.29    1.84    0.83    1.88   0.26   4.10

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sda               0.00     0.00  100.00   60.00     0.41     0.98    17.80     0.14    0.86    0.92    0.75   0.77  12.30

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sda               0.00     0.00    0.00    4.00     0.00     0.02     8.00     0.00    0.75    0.00    0.75   0.75   0.30

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sda               0.00     0.00    0.00    4.00     0.00     0.02     8.00     0.00    0.75    0.00    0.75   0.75   0.30

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sda               0.00    51.00    1.00  103.00     0.02     0.87    17.46     0.24    2.31    1.00    2.32   0.05   0.50

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00


3. 小结

	1. 会阻塞DML语句和show create 语句，不会阻塞查询语句。
	2. drop table语句的状态为 checking permissions, 被阻塞的DML语句的状态为 opening tables;
	3. 不会导致IO利用率高。
	
	
	
	