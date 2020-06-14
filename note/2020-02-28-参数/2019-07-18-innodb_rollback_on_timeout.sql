

root@mysqldb 09:28:  [(none)]> select @@tx_isolation;
+----------------+
| @@tx_isolation |
+----------------+
| READ-COMMITTED |
+----------------+
1 row in set, 1 warning (0.00 sec)

mysql> show global variables like 'innodb_lock_wait_timeout';
+--------------------------+-------+
| Variable_name            | Value |
+--------------------------+-------+
| innodb_lock_wait_timeout | 60    |
+--------------------------+-------+
1 row in set (0.01 sec)


innodb_rollback_on_timeout = OFF
mysql> show global variables like '%innodb_rollback_on_timeout%';
+----------------------------+-------+
| Variable_name              | Value |
+----------------------------+-------+
| innodb_rollback_on_timeout | OFF   |
+----------------------------+-------+
1 row in set (0.01 sec)

CREATE TABLE `product` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `name` varchar(20) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `product` VALUES ('1', 'mi8', '1');
INSERT INTO `product` VALUES ('3', 'mi9', '1');


SESSION A						SESSION B
begin;
update product set amount=amount+1 where name = 'mi8';
								begin;
								update product set amount=amount+1 where name = 'mi8';
								(Blocked，超过60秒)
								ERROR 1205 (HY000): Lock wait timeout exceeded; try restarting transaction
commit;

mysql> select b.host, b.user, b.db, b.time, b.COMMAND, a.trx_id, a. trx_state,a.trx_query  from information_schema.innodb_trx a left join information_schema.PROCESSLIST b on a.trx_mysql_thread_id = b.id;
+--------------------+------+---------+------+---------+---------+-----------+-------------------------------------------------------+
| host               | user | db      | time | COMMAND | trx_id  | trx_state | trx_query                                             |
+--------------------+------+---------+------+---------+---------+-----------+-------------------------------------------------------+
| 192.168.0.54:43908 | root | test_db |   20 | Sleep   | 7882039 | RUNNING   | NULL                                                  |
| 192.168.0.54:43912 | root | test_db |   18 | Query   | 7882040 | LOCK WAIT | update product set amount=amount+1 where name = 'mi8' |
+--------------------+------+---------+------+---------+---------+-----------+-------------------------------------------------------+
2 rows in set (0.00 sec)

Blocked并且超过60秒之后：								
mysql> select b.host, b.user, b.db, b.time, b.COMMAND, a.trx_id, a. trx_state,a.trx_query  from information_schema.innodb_trx a left join information_schema.PROCESSLIST b on a.trx_mysql_thread_id = b.id;
+--------------------+------+---------+------+---------+---------+-----------+-----------+
| host               | user | db      | time | COMMAND | trx_id  | trx_state | trx_query |
+--------------------+------+---------+------+---------+---------+-----------+-----------+
| 192.168.0.54:43908 | root | test_db |   72 | Sleep   | 7882039 | RUNNING   | NULL      |
| 192.168.0.54:43912 | root | test_db |   70 | Sleep   | 7882040 | RUNNING   | NULL      |
+--------------------+------+---------+------+---------+---------+-----------+-----------+
2 rows in set (0.01 sec)



SESSION A commit:
mysql> select b.host, b.user, b.db, b.time, b.COMMAND, a.trx_id, a. trx_state,a.trx_query  from information_schema.innodb_trx a left join information_schema.PROCESSLIST b on a.trx_mysql_thread_id = b.id;
+--------------------+------+---------+------+---------+---------+-----------+-----------+
| host               | user | db      | time | COMMAND | trx_id  | trx_state | trx_query |
+--------------------+------+---------+------+---------+---------+-----------+-----------+
| 192.168.0.54:43912 | root | test_db |   86 | Sleep   | 7882040 | RUNNING   | NULL      |
+--------------------+------+---------+------+---------+---------+-----------+-----------+
1 row in set (0.01 sec)




#锁等待超时之后，显示回滚；
SESSION A						SESSION B
begin;
update product set amount=amount+1 where name = 'mi8';
								begin;
								update product set amount=amount+1 where name = 'mi8';
								(Blocked，超过60秒)
								ERROR 1205 (HY000): Lock wait timeout exceeded; try restarting transaction
commit;
								rollback;

SESSION B rollback:
mysql> select b.host, b.user, b.db, b.time, b.COMMAND, a.trx_id, a. trx_state,a.trx_query  from information_schema.innodb_trx a left join information_schema.PROCESSLIST b on a.trx_mysql_thread_id = b.id;
Empty set (0.00 sec)



innodb_rollback_on_timeout = ON:
mysql> show global variables like '%innodb_rollback_on_timeout%';
+----------------------------+-------+
| Variable_name              | Value |
+----------------------------+-------+
| innodb_rollback_on_timeout | ON   |
+----------------------------+-------+
1 row in set (0.01 sec)


SESSION A						SESSION B
begin;
update product set amount=amount+1 where name = 'mi8';
								begin;
								update product set amount=amount+1 where name = 'mi8';
								(Blocked，超过60秒)
								ERROR 1205 (HY000): Lock wait timeout exceeded; try restarting transaction
commit;


mysql> select b.host, b.user, b.db, b.time, b.COMMAND, a.trx_id, a. trx_state,a.trx_query  from information_schema.innodb_trx a left join information_schema.PROCESSLIST b on a.trx_mysql_thread_id = b.id;
+--------------------+------+---------+------+---------+---------+-----------+-------------------------------------------------------+
| host               | user | db      | time | COMMAND | trx_id  | trx_state | trx_query                                             |
+--------------------+------+---------+------+---------+---------+-----------+-------------------------------------------------------+
| 192.168.0.54:43916 | root | test_db |   23 | Query   | 7882500 | LOCK WAIT | update product set amount=amount+1 where name = 'mi8' |
| 192.168.0.54:43918 | root | test_db |   25 | Sleep   | 7882499 | RUNNING   | NULL                                                  |
+--------------------+------+---------+------+---------+---------+-----------+-------------------------------------------------------+
2 rows in set (0.01 sec)

Blocked并且超过60秒之后：
mysql> select b.host, b.user, b.db, b.time, b.COMMAND, a.trx_id, a. trx_state,a.trx_query  from information_schema.innodb_trx a left join information_schema.PROCESSLIST b on a.trx_mysql_thread_id = b.id;
+--------------------+------+---------+------+---------+---------+-----------+-----------+
| host               | user | db      | time | COMMAND | trx_id  | trx_state | trx_query |
+--------------------+------+---------+------+---------+---------+-----------+-----------+
| 192.168.0.54:43918 | root | test_db |   83 | Sleep   | 7882499 | RUNNING   | NULL      |
+--------------------+------+---------+------+---------+---------+-----------+-----------+
1 row in set (0.00 sec)


SESSION A commit:
mysql> select b.host, b.user, b.db, b.time, b.COMMAND, a.trx_id, a. trx_state,a.trx_query  from information_schema.innodb_trx a left join information_schema.PROCESSLIST b on a.trx_mysql_thread_id = b.id;
Empty set (0.00 sec)








参考：
	https://www.cnblogs.com/mydriverc/p/8297108.html MYSQL数据库INNODB_ROLLBACK_ON_TIMEOUT默认值的危害？
	
	
	