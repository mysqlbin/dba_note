
-1： 本文主要目的
0. 使用到的相关SQL语句 
1. 初始表结构和数据
2. MySQL 5.7.22
	2.1 环境1 --innodb_autoinc_lock_mode=1, 事务隔离级别为RR可重复读
	2.2 环境2 --innodb_autoinc_lock_mode=1, 事务隔离级别为RC读已提交
	2.3 环境3 --innodb_autoinc_lock_mode=2, 事务隔离级别为RR可重复读
	2.4 环境4 --innodb_autoinc_lock_mode=2, 事务隔离级别为RR可重复读
	2.5 环境5 --innodb_autoinc_lock_mode=1, 事务隔离级别为RR可重复读，有两个事务需要申请自增锁
3. 小结

5. 思考
6. 相关参考

-1： 本文主要目的
	验证自增长锁的释放时机


0. 使用到的相关SQL语句 

	select * from information_schema.innodb_locks\G;
	select * from information_schema.innodb_lock_waits\G;
	SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;

	select version();
	show global variables like '%innodb_autoinc_lock_mode%';
	show global variables like '%isolation%';
	select @@session.transaction_isolation;

	truncate table _t_new;
	--ALTER TABLE t auto_increment=500001;
	SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_name="t";
	SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_name="_t_new";

	show create table _t_new\G;

	set global innodb_flush_log_at_trx_commit=1;
	set global sync_binlog=1;


1. 初始表结构和数据、数据库版本

	CREATE TABLE `t` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;


	CREATE TABLE `_t_new` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  `CreateTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`) USING BTREE
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;


	DROP PROCEDURE IF EXISTS `idata`;
	DELIMITER ;;
	CREATE DEFINER=`root`@`%` PROCEDURE `idata`()
	begin
	  declare i int;
	  set i=1;
		start transaction;
	  while(i<=500000) do
		INSERT INTO t (c,d) values (i,i);
		set i=i+1;
	  end while;
		commit;
	end
	;;
	DELIMITER ;

	call idata();

	root@mysqldb 18:06:  [(none)]> select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.22-log |
	+------------+
	1 row in set (0.00 sec)

2.1 环境1 --innodb_autoinc_lock_mode=1, 事务隔离级别为RR可重复读


	root@mysqldb 14:32:  [sbtest]>  show global variables like '%innodb_autoinc_lock_mode%';
	+--------------------------+-------+
	| Variable_name            | Value |
	+--------------------------+-------+
	| innodb_autoinc_lock_mode | 1     |
	+--------------------------+-------+
	1 row in set (0.00 sec)

	root@mysqldb 14:32:  [sbtest]>  show global variables like '%isolation%';
	+-----------------------+-----------------+
	| Variable_name         | Value           |
	+-----------------------+-----------------+
	| transaction_isolation | REPEATABLE-READ |
	| tx_isolation          | REPEATABLE-READ |
	+-----------------------+-----------------+
	2 rows in set (0.00 sec)


	root@mysqldb 14:53:  [sbtest]> SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_name="t";
	+----------------+
	| AUTO_INCREMENT |
	+----------------+
	|             15 |
	|         500001 |
	+----------------+
	2 rows in set (0.00 sec)

	root@mysqldb 14:53:  [sbtest]> SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_name="_t_new";
	+----------------+
	| AUTO_INCREMENT |
	+----------------+
	|              1 |
	+----------------+
	1 row in set (0.00 sec)


	root@mysqldb 14:51:  [sbtest]> show create table _t_new\G;
	*************************** 1. row ***************************
	       Table: _t_new
	Create Table: CREATE TABLE `_t_new` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  `CreateTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`) USING BTREE
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
	1 row in set (0.00 sec)



	session A             session B

	begin;
	INSERT LOW_PRIORITY IGNORE INTO `_t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '500000')) LOCK IN SHARE MODE;
						  replace INTO `_t_new` (`id`, `c`, `d`) VALUES ('500001', '500001', '500001'); 
						  (Blocked)
	Query OK, 500000 rows affected (4.81 sec)
	Records: 500000  Duplicates: 0  Warnings: 0
						  Query OK, 1 row affected (4.16 sec)
							
	commit;

	自增锁等待信息
		root@mysqldb 14:58:  [(none)]> select * from information_schema.innodb_locks\G;
		*************************** 1. row ***************************
		    lock_id: 166082911:448
		lock_trx_id: 166082911
		  lock_mode: AUTO_INC
		  lock_type: TABLE
		 lock_table: `sbtest`.`_t_new`
		 lock_index: NULL
		 lock_space: NULL
		  lock_page: NULL
		   lock_rec: NULL
		  lock_data: NULL
		*************************** 2. row ***************************
		    lock_id: 166082906:448
		lock_trx_id: 166082906
		  lock_mode: AUTO_INC
		  lock_type: TABLE
		 lock_table: `sbtest`.`_t_new`
		 lock_index: NULL
		 lock_space: NULL
		  lock_page: NULL
		   lock_rec: NULL
		  lock_data: NULL
		2 rows in set, 1 warning (0.00 sec)

		ERROR: 
		No query specified

		root@mysqldb 14:58:  [(none)]> select * from information_schema.innodb_lock_waits\G;
		*************************** 1. row ***************************
		requesting_trx_id: 166082911
		requested_lock_id: 166082911:448
		  blocking_trx_id: 166082906
		 blocking_lock_id: 166082906:448
		1 row in set, 1 warning (0.00 sec)

		ERROR: 
		No query specified

		root@mysqldb 14:58:  [(none)]> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
		+--------------+-------------+-------------------------------------------------------------------+-------------------+--------------------+
		| locked_index | locked_type | waiting_query                                                     | waiting_lock_mode | blocking_lock_mode |
		+--------------+-------------+-------------------------------------------------------------------+-------------------+--------------------+
		| NULL         | TABLE       | replace INTO `_t_new` (`id`, ... ('500001', '500001', '500001') | AUTO_INC          | AUTO_INC           |
		+--------------+-------------+-------------------------------------------------------------------+-------------------+--------------------+
		1 row in set, 3 warnings (0.00 sec)

	查看数据

		root@mysqldb 14:58:  [sbtest]> select * from _t_new order by id desc limit 5;
		+--------+--------+--------+-------------------------+
		| id     | c      | d      | CreateTime              |
		+--------+--------+--------+-------------------------+
		| 500001 | 500001 | 500001 | 2020-05-15 14:58:28.773 |
		| 500000 | 500000 | 500000 | 2020-05-15 14:58:28.080 |
		| 499999 | 499999 | 499999 | 2020-05-15 14:58:28.080 |
		| 499998 | 499998 | 499998 | 2020-05-15 14:58:28.080 |
		| 499997 | 499997 | 499997 | 2020-05-15 14:58:28.080 |
		+--------+--------+--------+-------------------------+
		5 rows in set (0.00 sec)

	查看 binlog
		show binlog events in 'mysql-bin.000087';
		参考文件 087.sql


2.2 环境2 --innodb_autoinc_lock_mode=1, 事务隔离级别为RC读已提交
	
	root@mysqldb 18:06:  [(none)]> show global variables like '%innodb_autoinc_lock_mode%';
	+--------------------------+-------+
	| Variable_name            | Value |
	+--------------------------+-------+
	| innodb_autoinc_lock_mode | 1     |
	+--------------------------+-------+
	1 row in set (0.00 sec)

	root@mysqldb 18:06:  [(none)]> show global variables like '%isolation%';
	+-----------------------+----------------+
	| Variable_name         | Value          |
	+-----------------------+----------------+
	| transaction_isolation | READ-COMMITTED |
	| tx_isolation          | READ-COMMITTED |
	+-----------------------+----------------+
	2 rows in set (0.00 sec)

	root@mysqldb 18:06:  [sbtest]> SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_name="t";
	+----------------+
	| AUTO_INCREMENT |
	+----------------+
	|             15 |
	|         500001 |
	+----------------+
	2 rows in set (0.00 sec)

	root@mysqldb 18:06:  [sbtest]> SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_name="_t_new";
	+----------------+
	| AUTO_INCREMENT |
	+----------------+
	|              1 |
	+----------------+
	1 row in set (0.00 sec)



	session A             session B

	begin;
	INSERT LOW_PRIORITY IGNORE INTO `_t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '500000')) LOCK IN SHARE MODE;
						  replace INTO `_t_new` (`id`, `c`, `d`) VALUES ('500001', '500001', '500001'); 
						   (Blocked)
	Query OK, 500000 rows affected (5.55 sec)
	Records: 500000  Duplicates: 0  Warnings: 0
						  Query OK, 1 row affected (5.17 sec)


    自增锁等待信息
		root@mysqldb 18:22:  [sbtest]> select * from information_schema.innodb_locks\G;
		*************************** 1. row ***************************
		    lock_id: 166083045:454
		lock_trx_id: 166083045
		  lock_mode: AUTO_INC
		  lock_type: TABLE
		 lock_table: `sbtest`.`_t_new`
		 lock_index: NULL
		 lock_space: NULL
		  lock_page: NULL
		   lock_rec: NULL
		  lock_data: NULL
		*************************** 2. row ***************************
		    lock_id: 166083040:454
		lock_trx_id: 166083040
		  lock_mode: AUTO_INC
		  lock_type: TABLE
		 lock_table: `sbtest`.`_t_new`
		 lock_index: NULL
		 lock_space: NULL
		  lock_page: NULL
		   lock_rec: NULL
		  lock_data: NULL
		2 rows in set, 1 warning (0.00 sec)

		ERROR: 
		No query specified

		root@mysqldb 18:23:  [sbtest]> select * from information_schema.innodb_lock_waits\G;
		*************************** 1. row ***************************
		requesting_trx_id: 166083045
		requested_lock_id: 166083045:454
		  blocking_trx_id: 166083040
		 blocking_lock_id: 166083040:454
		1 row in set, 1 warning (0.00 sec)

		ERROR: 
		No query specified

		root@mysqldb 18:23:  [sbtest]> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
		+--------------+-------------+-------------------------------------------------------------------+-------------------+--------------------+
		| locked_index | locked_type | waiting_query                                                     | waiting_lock_mode | blocking_lock_mode |
		+--------------+-------------+-------------------------------------------------------------------+-------------------+--------------------+
		| NULL         | TABLE       | replace INTO `_t_new` (`id`,  ... ('500001', '500001', '500001') | AUTO_INC          | AUTO_INC           |
		+--------------+-------------+-------------------------------------------------------------------+-------------------+--------------------+
		1 row in set, 3 warnings (0.00 sec)


	查看 binlog
		show binlog events in 'mysql-bin.000093';
		参考文件 093.sql


2.3 环境3 --innodb_autoinc_lock_mode=2, 事务隔离级别为RR可重复读

	
	root@mysqldb 18:46:  [sbtest]> show global variables like '%innodb_autoinc_lock_mode%';
	+--------------------------+-------+
	| Variable_name            | Value |
	+--------------------------+-------+
	| innodb_autoinc_lock_mode | 2     |
	+--------------------------+-------+
	1 row in set (0.00 sec)

	root@mysqldb 18:46:  [sbtest]> show global variables like '%isolation%';
	+-----------------------+-----------------+
	| Variable_name         | Value           |
	+-----------------------+-----------------+
	| transaction_isolation | REPEATABLE-READ |
	| tx_isolation          | REPEATABLE-READ |
	+-----------------------+-----------------+
	2 rows in set (0.00 sec)


	root@mysqldb 18:46:  [sbtest]> truncate table _t_new;
	Query OK, 0 rows affected (0.06 sec)

	root@mysqldb 18:46:  [sbtest]> --ALTER TABLE t auto_increment=500001;
	ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '--ALTER TABLE t auto_increment=500001' at line 1
	root@mysqldb 18:46:  [sbtest]> SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_name="t";
	+----------------+
	| AUTO_INCREMENT |
	+----------------+
	|             15 |
	|         500001 |
	+----------------+
	2 rows in set (0.24 sec)

	root@mysqldb 18:46:  [sbtest]> SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_name="_t_new";
	+----------------+
	| AUTO_INCREMENT |
	+----------------+
	|              1 |
	+----------------+
	1 row in set (0.00 sec)

	session A             session B

	begin;
	INSERT LOW_PRIORITY IGNORE INTO `_t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '500000')) LOCK IN SHARE MODE;
							replace INTO `_t_new` (`id`, `c`, `d`) VALUES ('500001', '500001', '500001'); 
							Query OK, 1 row affected (0.01 sec)


	Query OK, 500000 rows affected (6.02 sec)
	Records: 500000  Duplicates: 0  Warnings: 0

	(No Blocked)

	root@mysqldb 18:53:  [sbtest]> show global status like '%row_lock%';
	+-------------------------------+-------+
	| Variable_name                 | Value |
	+-------------------------------+-------+
	| Innodb_row_lock_current_waits | 0     |
	| Innodb_row_lock_time          | 0     |
	| Innodb_row_lock_time_avg      | 0     |
	| Innodb_row_lock_time_max      | 0     |
	| Innodb_row_lock_waits         | 0     |
	+-------------------------------+-------+
	5 rows in set (0.00 sec)



2.4 环境4 --innodb_autoinc_lock_mode=2, 事务隔离级别为RC读已提交

	root@mysqldb 18:53:  [sbtest]> select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.22-log |
	+------------+
	1 row in set (0.00 sec)

	root@mysqldb 18:53:  [sbtest]> show global variables like '%innodb_autoinc_lock_mode%';
	+--------------------------+-------+
	| Variable_name            | Value |
	+--------------------------+-------+
	| innodb_autoinc_lock_mode | 2     |
	+--------------------------+-------+
	1 row in set (0.00 sec)

	root@mysqldb 18:53:  [sbtest]> show global variables like '%isolation%';
	+-----------------------+----------------+
	| Variable_name         | Value          |
	+-----------------------+----------------+
	| transaction_isolation | READ-COMMITTED |
	| tx_isolation          | READ-COMMITTED |
	+-----------------------+----------------+
	2 rows in set (0.00 sec)

	root@mysqldb 18:53:  [sbtest]> truncate table _t_new;
	Query OK, 0 rows affected (0.02 sec)

	root@mysqldb 18:53:  [sbtest]> --ALTER TABLE t auto_increment=500001;
	ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '--ALTER TABLE t auto_increment=500001' at line 1
	root@mysqldb 18:53:  [sbtest]> SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_name="t";
	+----------------+
	| AUTO_INCREMENT |
	+----------------+
	|             15 |
	|         500001 |
	+----------------+
	2 rows in set (0.00 sec)

	root@mysqldb 18:53:  [sbtest]> SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_name="_t_new";
	+----------------+
	| AUTO_INCREMENT |
	+----------------+
	|              1 |
	+----------------+
	1 row in set (0.00 sec)



	session A             session B

	begin;
	INSERT LOW_PRIORITY IGNORE INTO `_t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '500000')) LOCK IN SHARE MODE;
						  replace INTO `_t_new` (`id`, `c`, `d`) VALUES ('500001', '500001', '500001'); 
						  Query OK, 1 row affected (0.01 sec)

	Query OK, 500000 rows affected (5.42 sec)
	Records: 500000  Duplicates: 0  Warnings: 0
	
	(No Blocked)

	root@mysqldb 18:53:  [sbtest]> show global status like '%row_lock%';
	+-------------------------------+-------+
	| Variable_name                 | Value |
	+-------------------------------+-------+
	| Innodb_row_lock_current_waits | 0     |
	| Innodb_row_lock_time          | 0     |
	| Innodb_row_lock_time_avg      | 0     |
	| Innodb_row_lock_time_max      | 0     |
	| Innodb_row_lock_waits         | 0     |
	+-------------------------------+-------+
	5 rows in set (0.00 sec)


2.5 环境5 --innodb_autoinc_lock_mode=1, 事务隔离级别为RR可重复读，有两个事务需要申请自增锁

	root@localhost [(none)]>select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.19-log |
	+------------+
	1 row in set (0.00 sec)

	root@localhost [(none)]>show global variables like '%innodb_autoinc_lock_mode%';
	+--------------------------+-------+
	| Variable_name            | Value |
	+--------------------------+-------+
	| innodb_autoinc_lock_mode | 1     |
	+--------------------------+-------+
	1 row in set (0.00 sec)

	root@localhost [(none)]>show global variables like '%isolation%';
	+---------------+-----------------+
	| Variable_name | Value           |
	+---------------+-----------------+
	| tx_isolation  | REPEATABLE-READ |
	+---------------+-----------------+
	1 row in set (0.00 sec)


	session A                 session B    				session C

	begin;
	INSERT LOW_PRIORITY IGNORE INTO `_t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '500000')) LOCK IN SHARE MODE;
							 insert INTO `_t_new` ( `c`, `d`) VALUES ('500001', '500001'); 
							 （Blocked）
							 						   insert INTO `_t_new` (`c`, `d`) VALUES ('500002', '500002'); 
							 						   （Blocked）
	Query OK, 500000 rows affected (6.74 sec)
	Records: 500000  Duplicates: 0  Warnings: 0
							  Query OK, 1 row affected (6.43 sec)
							  							Query OK, 1 row affected (5.56 sec)
						  		
	root@localhost [(none)]>select * from information_schema.innodb_locks\G;
	*************************** 1. row ***************************
	    lock_id: 5893242:241
	lock_trx_id: 5893242
	  lock_mode: AUTO_INC
	  lock_type: TABLE
	 lock_table: `sbtest`.`_t_new`
	 lock_index: NULL
	 lock_space: NULL
	  lock_page: NULL
	   lock_rec: NULL
	  lock_data: NULL
	*************************** 2. row ***************************
	    lock_id: 5893241:241
	lock_trx_id: 5893241
	  lock_mode: AUTO_INC
	  lock_type: TABLE
	 lock_table: `sbtest`.`_t_new`
	 lock_index: NULL
	 lock_space: NULL
	  lock_page: NULL
	   lock_rec: NULL
	  lock_data: NULL
	*************************** 3. row ***************************
	    lock_id: 5893236:241
	lock_trx_id: 5893236
	  lock_mode: AUTO_INC
	  lock_type: TABLE
	 lock_table: `sbtest`.`_t_new`
	 lock_index: NULL
	 lock_space: NULL
	  lock_page: NULL
	   lock_rec: NULL
	  lock_data: NULL
	3 rows in set, 1 warning (0.00 sec)

	ERROR: 
	No query specified

	root@localhost [(none)]>select * from information_schema.innodb_lock_waits\G;
	*************************** 1. row ***************************
	requesting_trx_id: 5893242
	requested_lock_id: 5893242:241
	  blocking_trx_id: 5893241
	 blocking_lock_id: 5893241:241
	*************************** 2. row ***************************
	requesting_trx_id: 5893242
	requested_lock_id: 5893242:241
	  blocking_trx_id: 5893236
	 blocking_lock_id: 5893236:241
	*************************** 3. row ***************************
	requesting_trx_id: 5893241
	requested_lock_id: 5893241:241
	  blocking_trx_id: 5893236
	 blocking_lock_id: 5893236:241
	3 rows in set, 1 warning (0.00 sec)

	ERROR: 
	No query specified

	root@localhost [(none)]>SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
	+--------------+-------------+--------------------------------------------------------------+-------------------+--------------------+
	| locked_index | locked_type | waiting_query                                                | waiting_lock_mode | blocking_lock_mode |
	+--------------+-------------+--------------------------------------------------------------+-------------------+--------------------+
	| NULL         | TABLE       | insert INTO `_t_new` ( `c`, `d`) VALUES ('500001', '500001') | AUTO_INC          | AUTO_INC           |
	| NULL         | TABLE       | insert INTO `_t_new` ( `c`, `d`) VALUES ('500002', '500002') | AUTO_INC          | AUTO_INC           |
	| NULL         | TABLE       | insert INTO `_t_new` ( `c`, `d`) VALUES ('500002', '500002') | AUTO_INC          | AUTO_INC           |
	+--------------+-------------+--------------------------------------------------------------+-------------------+--------------------+
	3 rows in set, 3 warnings (0.01 sec)


	root@localhost [sbtest]>select id,c,d from _t_new;
	+--------+--------+--------+
	| id     | c      | d      |
	+--------+--------+--------+
	| 500001 | 500001 | 500001 |
	| 500002 | 500002 | 500002 |
	+--------+--------+--------+
	2 rows in set (0.18 sec)

3. 小结
	1. 通过实验和理解，'insert into _t_new ... select ... from ... WHERE ((`id` >= '1')) AND ((`id` <= '500000')) lock in share mode;' 语句 _t_new表自增长锁的释放时机：
		innodb_autoinc_lock_mode=2： 1 and 500001 的自增长锁全部申请完就释放，插入动作在自增长锁全部申请完成之后执行；
		innodb_autoinc_lock_mode=1： 1 and 500001 的自增长锁是等语句执行结束(注意：不是事务提交)才释放;
		对应的实验： 
			2.1 环境1 --innodb_autoinc_lock_mode=1, 事务隔离级别为RR可重复读
			3.2 环境2 --innodb_autoinc_lock_mode=1, 事务隔离级别为RC读已提交
			3.3 环境3 --innodb_autoinc_lock_mode=2, 事务隔离级别为RR可重复读
			2.4 环境4 --innodb_autoinc_lock_mode=2, 事务隔离级别为RR可重复读
			2.5 环境5 --innodb_autoinc_lock_mode=1, 事务隔离级别为RR可重复读，有两个事务需要申请自增锁	

5. 思考
	

	1. innodb_autoinc_lock_mode=1： INSERT LOW_PRIORITY IGNORE INTO `_t_new` (`id`, `c`, `d`) SELECT `id`, `c`, `d` from t WHERE ((`id` >= '1')) AND ((`id` <= '500000')) LOCK IN SHARE MODE;
		 在 8.0.18 以上的版本中还需要持有 _t_new.id = 500001 的自增锁吗

		答： 需要。 实验如下：
			3.1 环境1 --innodb_autoinc_lock_mode=1, 事务隔离级别为RC读已提交
			3.2 环境2 --innodb_autoinc_lock_mode=1, 事务隔离级别为RR可重复读
				
	2. innodb_autoinc_lock_mode=1： WHERE ((`id` >= '1')) AND ((`id` <= '500000')) lock in share mode; 在 5.7 版本中RC隔离级别还需要持有 id = 500001 的行锁吗


	3. 唯一索引范围 bug，在RC隔离级别中也存在吗

6. 相关参考
	https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_autoinc_lock_mode
	https://dev.mysql.com/doc/refman/8.0/en/innodb-auto-increment-handling.html#innodb-auto-increment-lock-modes


