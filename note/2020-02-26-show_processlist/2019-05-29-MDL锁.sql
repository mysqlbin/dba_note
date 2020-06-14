

      SESSION A						SESSION B	                    SESSION C
begin;
select * from table_clubgamescoredetail limit 1;

							alter table  table_clubgamescoredetail \ 
							add column test_filed int(11);
							(block)
																   select * from table_clubgamescoredetail limit 1; 				
																   (blocked)
mysql> show processlist;
+-----+-----------------+---------------------+------------------+-------------+---------+---------------------------------------------------------------+----------------------------------------------------------------------+
| Id  | User            | Host                | db               | Command     | Time    | State                                                         | Info                                                                 |
+-----+-----------------+---------------------+------------------+-------------+---------+---------------------------------------------------------------+----------------------------------------------------------------------+
|   1 | event_scheduler | localhost           | NULL             | Daemon      |   11555 | Waiting for next activation                                   | NULL                                                                 |
|   3 | repl_user       | 39.108.17.15:55716  | NULL             | Binlog Dump | 1007432 | Master has sent all binlog to slave; waiting for more updates | NULL                                                                 |
| 371 | root            | 121.35.100.98:32076 | NULL             | Sleep       |    1063 |                                                               | NULL                                                                 |
| 372 | root            | 121.35.100.98:32144 | nnh5_recovery_db | Sleep       |    1061 |                                                               | NULL                                                                 |
| 373 | root            | 39.108.17.17:52072  | nnh5_recovery_db | Sleep       |     404 |                                                               | NULL                                                                 |
| 374 | root            | 39.108.17.17:52074  | nnh5_recovery_db | Query       |     755 | Waiting for table metadata lock                               | alter table  table_clubgamescoredetail add column test_filed int(11) |
| 375 | root            | 121.35.100.98:31907 | nnh5_recovery_db | Sleep       |     748 |                                                               | NULL                                                                 |                                                             | NULL                                                                 |
| 379 | root            | 121.35.100.98:33779 | NULL             | Sleep       |     627 |                                                               | NULL                                                                 |
| 380 | root            | 39.108.17.17:52078  | nnh5_recovery_db | Query       |       0 | starting                                                      | show processlist                                                     |
| 381 | root            | 121.35.100.98:33498 | nnh5_recovery_db | Sleep       |      60 |                                                               | NULL                                                                 |
| 382 | root            | 121.35.100.98:29847 | nnh5_recovery_db | Query       |      45 | Waiting for table metadata lock                               | select * from table_clubgamescoredetail limit 1                      |
| 383 | root            | 121.35.100.98:30097 | NULL             | Sleep       |       3 |                                                               | NULL                                                                 |
+-----+-----------------+---------------------+------------------+-------------+---------+---------------------------------------------------------------+----------------------------------------------------------------------+

session A先启动, 对表加一个MDL读锁;
session B被blocked, 因为session A的MDL读锁还没有释放,
	session B需要 MDL写锁, 因此只能被阻塞.
	session B被阻塞, 之后所有要在表上新申请MDL读锁的请求也会被 session B阻塞
	所有对表的增删改查操作都需要先申请MDL读锁,就都被锁住,等于这个表现在完成不可读写了.
	

      SESSION A						SESSION B	                    SESSION C
begin;
update table_clubgamescoredetail set nPlayerID = 0 WHERE id=9242416;

							alter table  table_clubgamescoredetail \ 
							add column test_filed int(11);
							(block)
																   select * from table_clubgamescoredetail limit 1; 				
																   (blocked)
																   
mysql> show processlist;
+-----+-----------------+---------------------+------------------+-------------+---------+---------------------------------------------------------------+----------------------------------------------------------------------+
| Id  | User            | Host                | db               | Command     | Time    | State                                                         | Info                                                                 |
+-----+-----------------+---------------------+------------------+-------------+---------+---------------------------------------------------------------+----------------------------------------------------------------------+
|   1 | event_scheduler | localhost           | NULL             | Daemon      |   14052 | Waiting for next activation                                   | NULL                                                                 |
|   3 | repl_user       | 39.108.17.15:55716  | NULL             | Binlog Dump | 1009929 | Master has sent all binlog to slave; waiting for more updates | NULL                                                                 |
| 371 | root            | 121.35.100.98:32076 | NULL             | Sleep       |    3560 |                                                               | NULL                                                                 |                                                            | NULL                                                                 |
| 379 | root            | 121.35.100.98:33779 | NULL             | Sleep       |    3124 |                                                               | NULL                                                                 |
| 380 | root            | 39.108.17.17:52078  | nnh5_recovery_db | Query       |       0 | starting                                                      | show processlist                                                     |
| 381 | root            | 121.35.100.98:33498 | nnh5_recovery_db | Sleep       |    2557 |                                                               | NULL                                                                 |
| 384 | root            | 121.35.100.98:31126 | nnh5_recovery_db | Sleep       |    2500 |                                                               | NULL                                                                 |
| 386 | root            | 121.35.100.98:29843 | nnh5_recovery_db | Sleep       |    2386 |                                                               | NULL                                                                 |
| 388 | root            | 39.108.17.17:52096  | nnh5_recovery_db | Query       |      23 | Waiting for table metadata lock                               | alter table  table_clubgamescoredetail add column test_filed int(11) |
| 389 | root            | 121.35.100.98:31087 | NULL             | Sleep       |      59 |                                                               | NULL                                                                 |                                   |
| 395 | root            | 121.35.100.98:32419 | nnh5_recovery_db | Sleep       |       8 |                                                               | NULL                                                                 |
| 396 | root            | 121.35.100.98:32475 | nnh5_recovery_db | Sleep       |       6 |                                                               | NULL                                                                 |
| 397 | root            | 121.35.100.98:32505 | nnh5_recovery_db | Query       |       5 | Waiting for table metadata lock                               | select * from table_clubgamescoredetail limit 1                      |
+-----+-----------------+---------------------+------------------+-------------+---------+---------------------------------------------------------------+----------------------------------------------------------------------+


session A先启动, 对表加一个MDL读锁;
session B被blocked, 因为session A的MDL读锁还没有释放,
	session B需要 MDL写锁, 因此只能被阻塞.
	session B被阻塞, 之后所有要在表上新申请MDL读锁的请求也会被 session B阻塞
	所有对表的增删改查操作都需要先申请MDL读锁,就都被锁住,等于这个表现在完成不可读写了.
	



产生MDL锁之后的解决方案:  进行业务评估, 需要跟业务反馈
	1. 解决长事务，事务不提交，就会一直占着 MDL 读锁。
	2. 第一种方案: 处理掉未提交事务/正在执行的事务 也就是 kill 掉产生MDL锁源头的SQL, 记为session A
	3. 第二种方案: 处理掉DDL的事务, 记为 session B
	
	如果 session A的事务是只读操作, 那么 kill session A, 否则 kill session B, 然后看情况 把 session B 的DDL再次执行.
	
1. 未提交事务/正在执行的事务 通过 information_schema.INNODB_TRX 确认		
mysql> select * from information_schema.INNODB_TRX\G;
*************************** 1. row ***************************
                    trx_id: 60825638
                 trx_state: RUNNING
               trx_started: 2019-05-29 11:08:44
     trx_requested_lock_id: NULL
          trx_wait_started: NULL
                trx_weight: 3
       trx_mysql_thread_id: 373
                 trx_query: NULL
       trx_operation_state: NULL
         trx_tables_in_use: 0
         trx_tables_locked: 1
          trx_lock_structs: 2
     trx_lock_memory_bytes: 1136
           trx_rows_locked: 1
         trx_rows_modified: 1
   trx_concurrency_tickets: 0
       trx_isolation_level: REPEATABLE READ
         trx_unique_checks: 1
    trx_foreign_key_checks: 1
trx_last_foreign_key_error: NULL
 trx_adaptive_hash_latched: 0
 trx_adaptive_hash_timeout: 0
          trx_is_read_only: 0
trx_autocommit_non_locking: 0
1 row in set (0.00 sec)

#kill 掉线程ID: trx_mysql_thread_id 的值
kill 373; 

2. 查看session B DDL对应的SQL:  show processlist;


mysql> select * from information_schema.INNODB_TRX\G;
*************************** 1. row ***************************
                    trx_id: 60825674
                 trx_state: RUNNING
               trx_started: 2019-05-29 11:16:51
     trx_requested_lock_id: NULL
          trx_wait_started: NULL
                trx_weight: 0
       trx_mysql_thread_id: 388
                 trx_query: alter table  table_clubgamescoredetail add column test_filed int(11)
       trx_operation_state: reading clustered index
         trx_tables_in_use: 1
         trx_tables_locked: 0
          trx_lock_structs: 0
     trx_lock_memory_bytes: 1136
           trx_rows_locked: 0
         trx_rows_modified: 0
   trx_concurrency_tickets: 0
       trx_isolation_level: REPEATABLE READ
         trx_unique_checks: 1
    trx_foreign_key_checks: 1
trx_last_foreign_key_error: NULL
 trx_adaptive_hash_latched: 0
 trx_adaptive_hash_timeout: 0
          trx_is_read_only: 0
trx_autocommit_non_locking: 0
1 row in set (0.00 sec)


小结：读/写长事务持有MDL读锁，DDL需要持有MDL写锁， MDL读锁没有释放，MDL写锁就会一直处于阻塞状态。


 