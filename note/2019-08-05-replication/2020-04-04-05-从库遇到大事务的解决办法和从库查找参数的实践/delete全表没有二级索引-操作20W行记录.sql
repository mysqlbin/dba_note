1. 初始化数据
2. INDEX_SCAN,TABLE_SCAN
3. INDEX_SCAN,HASH_SCAN
4. INDEX_SCAN,TABLE_SCAN 和 INDEX_SCAN,HASH_SCAN 的对比
5. 小结



1. 初始化数据

	mysqldump --set-gtid-purged=OFF -uroot -p123456abc -B sbtest --tables sbtest1 > sbtest.sql

	alter table  sbtest1 drop column id;

	mysqldump --set-gtid-purged=OFF -uroot -p123456abc -B sbtest --tables sbtest1 > sbtest2.sql

	root@localhost [sbtest]>show create table sbtest1\G;
	*************************** 1. row ***************************
		   Table: sbtest1
	Create Table: CREATE TABLE `sbtest1` (
	  `k` int(10) unsigned NOT NULL DEFAULT '0',
	  `c` char(120) NOT NULL DEFAULT '',
	  `pad` char(60) NOT NULL DEFAULT '',
	  KEY `k_1` (`k`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 MAX_ROWS=1000000
	1 row in set (0.00 sec)

	root@localhost [sbtest]>select count(*) as counts, k from sbtest1 group by k having counts > 95 order by counts desc limit 20;
	+--------+--------+
	| counts | k      |
	+--------+--------+
	|    109 | 100874 |
	|    105 | 100977 |
	|    103 |  99832 |
	|    103 |  99407 |
	|    102 | 100660 |
	|    101 | 100882 |
	|    100 | 100394 |
	|     99 |  99110 |
	|     99 |  99612 |
	|     98 |  99589 |
	|     98 |  99797 |
	|     98 |  99094 |
	|     98 | 100684 |
	|     97 | 100659 |
	|     97 | 100870 |
	|     97 | 100439 |
	|     97 |  99111 |
	|     97 | 100344 |
	|     97 |  99162 |
	|     97 | 100283 |
	+--------+--------+
	20 rows in set (0.15 sec)
	
	alter table sbtest1 drop index k_1;

	root@localhost [sbtest]>show create table sbtest1\G;
	*************************** 1. row ***************************
		   Table: sbtest1
	Create Table: CREATE TABLE `sbtest1` (
	  `k` int(10) unsigned NOT NULL DEFAULT '0',
	  `c` char(120) NOT NULL DEFAULT '',
	  `pad` char(60) NOT NULL DEFAULT ''
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 MAX_ROWS=1000000
	1 row in set (0.00 sec)

	
2. INDEX_SCAN,TABLE_SCAN
	slave
		stop slave;	
		SET GLOBAL slave_rows_search_algorithms = 'INDEX_SCAN,TABLE_SCAN';
		start slave; 

		show global variables like 'slave_rows_search_algorithms';

		root@localhost [(none)]>show global variables like 'slave_rows_search_algorithms';
		+------------------------------+-----------------------+
		| Variable_name                | Value                 |
		+------------------------------+-----------------------+
		| slave_rows_search_algorithms | TABLE_SCAN,INDEX_SCAN |
		+------------------------------+-----------------------+
		1 row in set (0.00 sec)
	
	master
		delete from sbtest1;
		
		
	slave
		[root@env29 ~]# date
		Sun Mar 22 12:53:30 CST 2020
		
		通过正在执行的事务查看进度, trx_weight 这个步骤很重要
		root@localhost [(none)]>select * from information_schema.innodb_trx\G;
		*************************** 1. row ***************************
							trx_id: 5889218
						 trx_state: RUNNING
					   trx_started: 2020-03-22 12:47:08
			 trx_requested_lock_id: NULL
				  trx_wait_started: NULL
						trx_weight: 44199
			   trx_mysql_thread_id: 101
						 trx_query: NULL
			   trx_operation_state: NULL
				 trx_tables_in_use: 1
				 trx_tables_locked: 1
				  trx_lock_structs: 607
			 trx_lock_memory_bytes: 73936
				   trx_rows_locked: 43592
				 trx_rows_modified: 43592
		   trx_concurrency_tickets: 0
			   trx_isolation_level: READ COMMITTED
				 trx_unique_checks: 1
			trx_foreign_key_checks: 1
		trx_last_foreign_key_error: NULL
		 trx_adaptive_hash_latched: 0
		 trx_adaptive_hash_timeout: 0
				  trx_is_read_only: 0
		trx_autocommit_non_locking: 0
		1 row in set (0.00 sec)
				
		show slave status\G;
			Seconds_Behind_Master: 395
		
		约390S才跑完了 44199 行记录.
		
		遇到这种问题的解决办法：
			set gtid_next='f7323d17-6442-11ea-8a77-080027758761:161320';
			begin;
			commit;
			set gtid_next=automatic;
			
			delete from sbtest1;
				root@localhost [sbtest]>delete from sbtest1;
				Query OK, 200000 rows affected (2.52 sec)
			
			start slave;
		
		
		
		
3. INDEX_SCAN,HASH_SCAN
	
	
	slave:
		stop slave;	
		SET GLOBAL slave_rows_search_algorithms = 'INDEX_SCAN,HASH_SCAN';
		start slave

		root@localhost [sbtest]>show global variables like 'slave_rows_search_algorithms';
		+------------------------------+----------------------+
		| Variable_name                | Value                |
		+------------------------------+----------------------+
		| slave_rows_search_algorithms | INDEX_SCAN,HASH_SCAN |
		+------------------------------+----------------------+
		1 row in set (0.30 sec)
	
	master
		delete from sbtest1;
		root@localhost [sbtest]>delete from sbtest1;
		Query OK, 200000 rows affected (2.33 sec)
	
		
	slave
		show engine innodb status\G;	
			---TRANSACTION 5889092, ACTIVE 146 sec
			mysql tables in use 1, locked 1
			3040 lock struct(s), heap size 336080, 399998 row lock(s), undo log entries 199933
			MySQL thread id 97, OS thread handle 140085862483712, query id 102720 Reading event from the relay log
		show slave status\G;
			Seconds_Behind_Master: 146
			
4. INDEX_SCAN,TABLE_SCAN 和 INDEX_SCAN,HASH_SCAN 的对比
	
	从库查找方式   'INDEX_SCAN,TABLE_SCAN'   'INDEX_SCAN,HASH_SCAN'  
	耗时            估计要1300S                     147S  

	
5. 小结
	从库查找参数 slave_rows_search_algorithms 设置为 'INDEX_SCAN,HASH_SCAN' 并不一定能提升性能即 update/delete语句只修改少量的数据（比如每个语句修改一行数据）并不能提高性能。
	slave_rows_search_algorithms参数设置了HASH_SCAN并不一定会提高性能，只有满足如下两个条件才会提高性能：
		（1）（表中没有任何索引）或者（有索引且本条update/delete的数据关键字重复值较多）。
			delete 删除大表在没有索引的情况， INDEX_SCAN,HASH_SCAN 比 INDEX_SCAN,TABLE_SCAN 快不少。
		（2） 一个update/delete语句删除了大量的数据，形成了很多个8K左右的UPDATE_ROW_EVENT/DELETE_ROW_EVENT。
			


			