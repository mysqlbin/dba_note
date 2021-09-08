

mysql> show global variables like '%iso%';
+-----------------------+-----------------+
| Variable_name         | Value           |
+-----------------------+-----------------+
| transaction_isolation | REPEATABLE-READ |
+-----------------------+-----------------+
1 row in set (0.00 sec)


mysql> select version();
+-----------+
| version() |
+-----------+
| 8.0.18    |
+-----------+
1 row in set (0.00 sec)

drop table t;
CREATE TABLE `t` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`c` int(11) DEFAULT NULL,
`d` int(11) DEFAULT NULL,
PRIMARY KEY (`id`),
UNIQUE KEY `c` (`c`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;



insert into t values(null, 1,1);
insert into t values(null, 2,2);
insert into t values(null, 5,5);
	
	
mysql> select * from t;
+----+------+------+
| id | c    | d    |
+----+------+------+
|  1 |    1 |    1 |
|  2 |    2 |    2 |
|  3 |    5 |    5 |
+----+------+------+
3 rows in set (0.00 sec)

	
时间点		session A      			session B      			session C     
			begin;					begin;
			insert into t values(null, 4, 4);
				
									insert into t values(null, 4, 4);
									(Blocked)
			rollback;
									(Query OK)

															begin;
															insert into t values(null, 3, 3);
															(Blocked)
T1 

T1
	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE              | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	| 140138352832824:1075:140138273382728   |                 55153 |        72 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
	| 140138352832824:18:5:5:140138273379848 |                 55153 |        72 | t           | c          | RECORD    | X,GAP,INSERT_INTENTION | WAITING     | 4, 5      |

	| 140138352831952:1075:140138273376744   |                 55152 |        71 | t           | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
	| 140138352831952:18:5:4:140138273374160 |                 55152 |        70 | t           | c          | RECORD    | S,GAP                  | GRANTED     | 5, 3      |
	| 140138352831952:18:5:5:140138273374160 |                 55152 |        70 | t           | c          | RECORD    | S,GAP                  | GRANTED     | 4, 5      |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	5 rows in set (0.00 sec)

