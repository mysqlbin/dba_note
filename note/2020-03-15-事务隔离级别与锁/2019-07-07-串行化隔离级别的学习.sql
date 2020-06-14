


set session transaction isolation level SERIALIZABLE;


mysql> select @@tx_isolation;
+----------------+
| @@tx_isolation |
+----------------+
| SERIALIZABLE   |
+----------------+


mysql> show create table t1\G;
*************************** 1. row ***************************
       Table: t1
Create Table: CREATE TABLE `t1` (
  `c1` int(10) unsigned NOT NULL DEFAULT '0',
  `c2` int(10) unsigned NOT NULL DEFAULT '0',
  `c3` int(10) unsigned NOT NULL DEFAULT '0',
  `c4` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`c1`),
  KEY `c2` (`c2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
1 row in set (0.00 sec)

mysql> select * from t1;
+----+----+----+----+
| c1 | c2 | c3 | c4 |
+----+----+----+----+
|  0 |  0 |  0 |  0 |
|  1 |  1 |  1 |  0 |
|  3 |  3 |  3 |  0 |
|  4 |  2 |  2 |  0 |
|  6 |  2 |  5 |  0 |
|  8 |  6 |  6 |  0 |
| 10 |  4 |  4 |  0 |
+----+----+----+----+
7 rows in set (0.00 sec)

SESSION A						SESSION A

begin;							

update t1 set c4=1 where c2=1;
								select * from t1 where c2=1;
								(Blocked)

可以看到，在 SERIALIZABLE串行化隔离级别下，事务是串行的；数据一致性很高，但是没有并发的能力；会影响其它事务的正常读取操作。
意味着对于同一行记录，“写”会加“写锁”，“读”会加“读锁”。当出现读写锁冲突的时候，后访问的事务必须等前一个事务执行完成，才能继续执行。
 
 
	
mysql> select * from information_schema.innodb_trx\G;
*************************** 1. row ***************************
                    trx_id: 5704469
                 trx_state: RUNNING
               trx_started: 2019-07-07 09:16:51
     trx_requested_lock_id: NULL
          trx_wait_started: NULL
                trx_weight: 5
       trx_mysql_thread_id: 28
                 trx_query: NULL
       trx_operation_state: NULL
         trx_tables_in_use: 0
         trx_tables_locked: 1
          trx_lock_structs: 4
     trx_lock_memory_bytes: 1136
           trx_rows_locked: 3
         trx_rows_modified: 1
   trx_concurrency_tickets: 0
       trx_isolation_level: SERIALIZABLE
         trx_unique_checks: 1
    trx_foreign_key_checks: 1
trx_last_foreign_key_error: NULL
 trx_adaptive_hash_latched: 0
 trx_adaptive_hash_timeout: 0
          trx_is_read_only: 0
trx_autocommit_non_locking: 0
1 row in set (0.00 sec)



mysql> select * from information_schema.INNODB_LOCK_WAITS\G;
*************************** 1. row ***************************
requesting_trx_id: 422106266076560
requested_lock_id: 422106266076560:33:4:3
  blocking_trx_id: 5704469
 blocking_lock_id: 5704469:33:4:3
1 row in set, 1 warning (0.00 sec)




