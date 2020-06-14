

参考： 
https://mp.weixin.qq.com/s/8nRdTa0ruovAi8juL_H8yQ   两个INSERT发生死锁原因剖析


mysql> select @@tx_isolation;
+----------------+
| @@tx_isolation |
+----------------+
| READ-COMMITTED |
+----------------+
1 row in set, 1 warning (0.00 sec)


drop table  if exists t1;

CREATE TABLE t1 (i INT, PRIMARY KEY (i)) ENGINE = InnoDB;

INSERT INTO t1 values(1);


session A                    	     session B            session C

begin;
select * from t1 where i=1 lock in share mode; 
								     begin;
								     select i from t1 where i=1 for update; 

								    (被SESSION A Blocked)

														   begin;
														   select * from t1 where i=1 for update; 
														   (被SESSION A Blocked)

commit;											
													

session A未提交，session C未执行：
mysql> select locked_index, locked_type, waiting_query, waiting_lock_mode, blocking_lock_mode from sys.INNODB_LOCK_WAITS;
+--------------+-------------+---------------------------------------+-------------------+--------------------+
| locked_index | locked_type | waiting_query                         | waiting_lock_mode | blocking_lock_mode |
+--------------+-------------+---------------------------------------+-------------------+--------------------+
| PRIMARY      | RECORD      | select i from t1 where i=1 for update | X                 | S                  |
+--------------+-------------+---------------------------------------+-------------------+--------------------+
1 row in set, 3 warnings (0.01 sec)


session A未提交，session B和session C已经执行：
mysql> select locked_index, locked_type, waiting_query, waiting_lock_mode, blocking_lock_mode from sys.INNODB_LOCK_WAITS;
+--------------+-------------+---------------------------------------+-------------------+--------------------+
| locked_index | locked_type | waiting_query                         | waiting_lock_mode | blocking_lock_mode |
+--------------+-------------+---------------------------------------+-------------------+--------------------+
| PRIMARY      | RECORD      | select i from t1 where i=1 for update | X                 | S                  |
| PRIMARY      | RECORD      | select * from t1 where i=1 for update | X                 | X                  |
| PRIMARY      | RECORD      | select * from t1 where i=1 for update | X                 | S                  |
+--------------+-------------+---------------------------------------+-------------------+--------------------+
3 rows in set, 3 warnings (0.00 sec)



session A提交, session C被session B阻塞：
mysql> select locked_index, locked_type, waiting_query, waiting_lock_mode, blocking_lock_mode from sys.INNODB_LOCK_WAITS;
+--------------+-------------+---------------------------------------+-------------------+--------------------+
| locked_index | locked_type | waiting_query                         | waiting_lock_mode | blocking_lock_mode |
+--------------+-------------+---------------------------------------+-------------------+--------------------+
| PRIMARY      | RECORD      | select * from t1 where i=1 for update | X                 | X                  |
+--------------+-------------+---------------------------------------+-------------------+--------------------+
1 row in set, 3 warnings (0.00 sec)

