mysql> show engine innodb status\G
*************************** 1. row ***************************
  Type: InnoDB
  Name: 
Status: 
=====================================
2020-11-20 15:53:21 0x7feaa8123700 INNODB MONITOR OUTPUT
=====================================
Per second averages calculated from the last 3 seconds
-----------------
BACKGROUND THREAD
-----------------
srv_master_thread loops: 50322297 srv_active, 0 srv_shutdown, 1305031 srv_idle
srv_master_thread log flush and writes: 51627328
----------
SEMAPHORES
----------
OS WAIT ARRAY INFO: reservation count 13682715
OS WAIT ARRAY INFO: signal count 14590748
RW-shared spins 0, rounds 11690219, OS waits 4747973
RW-excl spins 0, rounds 204813537, OS waits 1062792
RW-sx spins 4861430, rounds 140264710, OS waits 2561622
Spin rounds per wait: 11690219.00 RW-shared, 204813537.00 RW-excl, 28.85 RW-sx
------------------------
LATEST DETECTED DEADLOCK
------------------------
2020-11-20 00:32:44 0x7feaa9636700
*** (1) TRANSACTION:
TRANSACTION 2548893734, ACTIVE 0 sec starting index read
mysql tables in use 3, locked 3
LOCK WAIT 499 lock struct(s), heap size 57552, 1124 row lock(s)
MySQL thread id 1598704555, OS thread handle 140645826029312, query id 28665451532 bi-airflow 10.19.7.193 airflow Sending data
UPDATE task_instance, (
SELECT task_instance.try_number AS try_number, task_instance.task_id AS task_id, task_instance.dag_id AS dag_id, task_instance.execution_date AS execution_date, task_instance.start_date AS start_date, task_instance.end_date AS end_date, task_instance.duration AS duration, task_instance.state AS state, task_instance.max_tries AS max_tries, task_instance.hostname AS hostname, task_instance.unixname AS unixname, task_instance.job_id AS job_id, task_instance.pool AS pool, task_instance.queue AS queue, task_instance.priority_weight AS priority_weight, task_instance.operator AS operator, task_instance.queued_dttm AS queued_dttm, task_instance.pid AS pid, task_instance.executor_config AS executor_config 
FROM task_instance LEFT OUTER JOIN dag_run ON task_instance.dag_id = dag_run.dag_id AND task_instance.execution_date = dag_run.execution_date 
WHERE task_instance.dag

*** (1) WAITING FOR THIS LOCK TO BE GRANTED:
RECORD LOCKS space id 795 page no 46866 n bits 128 index PRIMARY of table `airflow_v10`.`task_instance` trx id 2548893734 lock_mode X locks rec but not gap waiting
Record lock, heap no 58 PHYSICAL RECORD: n_fields 21; compact format; info bits 0
 0: len 12; hex 766964656f5f7461675f3666; asc video_tag_6f;;
 1: len 30; hex 6d7973716c32686466735f6e6577636c75737465722e766964656f5f7461; asc mysql2hdfs_newcluster.video_ta; (total 31 bytes);
 2: len 7; hex 5fb4d4bc000000; asc _      ;;
 3: len 6; hex 000097ed0829; asc      );;
 4: len 7; hex 3b000004fc22e4; asc ;     ;;
 5: len 7; hex 5fb62da70800c4; asc _ -    ;;
 6: len 7; hex 5fb62da70800dc; asc _ -    ;;
 7: SQL NULL;
 8: len 6; hex 717565756564; asc queued;;
 9: len 4; hex 80000000; asc     ;;
 10: len 0; hex ; asc ;;
 11: len 6; hex 6861646f6f70; asc hadoop;;
 12: SQL NULL;
 13: SQL NULL;
 14: len 15; hex 6861646f6f702d706879736963616c; asc hadoop-physical;;
 15: len 4; hex 80000001; asc     ;;
 16: SQL NULL;
 17: SQL NULL;
 18: SQL NULL;
 19: len 4; hex 80000003; asc     ;;
 20: len 14; hex 80049503000000000000007d942e; asc            } .;;

*** (2) TRANSACTION:
TRANSACTION 2548893737, ACTIVE 0 sec updating or deleting
mysql tables in use 1, locked 1
3 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 1
MySQL thread id 1598892351, OS thread handle 140645840938752, query id 28665451577 data-hdphysical-master1 10.42.31.63 airflow updating
UPDATE task_instance SET state='queued' WHERE task_instance.task_id = 'video_tag_6f' AND task_instance.dag_id = 'mysql2hdfs_newcluster.video_tag' AND task_instance.execution_date = '2020-11-18 16:01:00'
*** (2) HOLDS THE LOCK(S):
RECORD LOCKS space id 795 page no 46866 n bits 128 index PRIMARY of table `airflow_v10`.`task_instance` trx id 2548893737 lock_mode X locks rec but not gap
Record lock, heap no 58 PHYSICAL RECORD: n_fields 21; compact format; info bits 0
 0: len 12; hex 766964656f5f7461675f3666; asc video_tag_6f;;
 1: len 30; hex 6d7973716c32686466735f6e6577636c75737465722e766964656f5f7461; asc mysql2hdfs_newcluster.video_ta; (total 31 bytes);
 2: len 7; hex 5fb4d4bc000000; asc _      ;;
 3: len 6; hex 000097ed0829; asc      );;
 4: len 7; hex 3b000004fc22e4; asc ;     ;;
 5: len 7; hex 5fb62da70800c4; asc _ -    ;;
 6: len 7; hex 5fb62da70800dc; asc _ -    ;;
 7: SQL NULL;
 8: len 6; hex 717565756564; asc queued;;
 9: len 4; hex 80000000; asc     ;;
 10: len 0; hex ; asc ;;
 11: len 6; hex 6861646f6f70; asc hadoop;;
 12: SQL NULL;
 13: SQL NULL;
 14: len 15; hex 6861646f6f702d706879736963616c; asc hadoop-physical;;
 15: len 4; hex 80000001; asc     ;;
 16: SQL NULL;
 17: SQL NULL;
 18: SQL NULL;
 19: len 4; hex 80000003; asc     ;;
 20: len 14; hex 80049503000000000000007d942e; asc            } .;;

*** (2) WAITING FOR THIS LOCK TO BE GRANTED:
RECORD LOCKS space id 795 page no 47344 n bits 296 index ti_state of table `airflow_v10`.`task_instance` trx id 2548893737 lock_mode X locks rec but not gap waiting
Record lock, heap no 206 PHYSICAL RECORD: n_fields 4; compact format; info bits 0
 0: len 9; hex 7363686564756c6564; asc scheduled;;
 1: len 12; hex 766964656f5f7461675f3666; asc video_tag_6f;;
 2: len 30; hex 6d7973716c32686466735f6e6577636c75737465722e766964656f5f7461; asc mysql2hdfs_newcluster.video_ta; (total 31 bytes);
 3: len 7; hex 5fb4d4bc000000; asc _      ;;

*** WE ROLL BACK TRANSACTION (2)
------------
TRANSACTIONS
------------
Trx id counter 2550518781
Purge done for trxs n:o < 2550518775 undo n:o < 0 state: running but idle
History list length 12
LIST OF TRANSACTIONS FOR EACH SESSION:
---TRANSACTION 422121607087072, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607106224, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607099840, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607103488, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607089808, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607086160, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607094368, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607108048, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607087984, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607079776, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607102576, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607073392, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607090720, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607083424, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607111696, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607084336, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607190128, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607189216, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607226608, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607221136, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607151824, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607171888, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607097104, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607085248, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607212016, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607170064, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607175536, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607136320, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607223872, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607149088, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607159120, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607198336, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607170976, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607152736, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607143616, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607141792, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607101664, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607108960, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607092544, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607091632, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607125376, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607075216, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607120816, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607142704, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607146352, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607114432, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607080688, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607112608, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607128112, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607122640, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607109872, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607076128, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607104400, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607110784, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607123552, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607121728, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607140880, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607161856, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607133584, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607082512, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607093456, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607144528, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607134496, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607129936, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607100752, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607139056, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607124464, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607201072, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607081600, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607072480, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607098928, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607095280, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607077040, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607074304, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607115344, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607078864, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607204720, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607088896, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607107136, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607096192, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607098016, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607077952, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 422121607071568, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
--------
FILE I/O
--------
I/O thread 0 state: waiting for completed aio requests (insert buffer thread)
I/O thread 1 state: waiting for completed aio requests (log thread)
I/O thread 2 state: waiting for completed aio requests (read thread)
I/O thread 3 state: waiting for completed aio requests (read thread)
I/O thread 4 state: waiting for completed aio requests (read thread)
I/O thread 5 state: waiting for completed aio requests (read thread)
I/O thread 6 state: waiting for completed aio requests (write thread)
I/O thread 7 state: waiting for completed aio requests (write thread)
I/O thread 8 state: waiting for completed aio requests (write thread)
I/O thread 9 state: waiting for completed aio requests (write thread)
Pending normal aio reads: [0, 0, 0, 0] , aio writes: [0, 0, 0, 0] ,
 ibuf aio reads:, log i/o's:, sync i/o's:
Pending flushes (fsync) log: 0; buffer pool: 0
85372052 OS file reads, 592665254 OS file writes, 401855989 OS fsyncs
0.00 reads/s, 0 avg bytes/read, 11.00 writes/s, 7.33 fsyncs/s
-------------------------------------
INSERT BUFFER AND ADAPTIVE HASH INDEX
-------------------------------------
Ibuf: size 1, free list len 1461, seg size 1463, 1789910 merges
merged operations:
 insert 1913023, delete mark 127627, delete 40926
discarded operations:
 insert 0, delete mark 0, delete 0
Hash table size 34673, node heap has 42 buffer(s)
Hash table size 34673, node heap has 1 buffer(s)
Hash table size 34673, node heap has 37 buffer(s)
Hash table size 34673, node heap has 108 buffer(s)
Hash table size 34673, node heap has 2 buffer(s)
Hash table size 34673, node heap has 54 buffer(s)
Hash table size 34673, node heap has 1 buffer(s)
Hash table size 34673, node heap has 1 buffer(s)
6594.80 hash searches/s, 252.58 non-hash searches/s
---
LOG
---
Log sequence number 297396720714
Log flushed up to   297396720714
Pages flushed up to 297396669973
Last checkpoint at  297396669358
0 pending log flushes, 0 pending chkp writes
359501700 log i/o's done, 5.33 log i/o's/second
----------------------
BUFFER POOL AND MEMORY
----------------------
Total large memory allocated 137428992
Dictionary memory allocated 308759
Buffer pool size   8191
Free buffers       1024
Database pages     6921
Old database pages 2534
Modified db pages  150
Pending reads      0
Pending writes: LRU 0, flush list 0, single page 0
Pages made young 133926062, not young 4650710598
0.00 youngs/s, 0.00 non-youngs/s
Pages read 85372012, created 424113, written 214229279
0.00 reads/s, 0.00 creates/s, 4.67 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 6921, unzip_LRU len: 0
I/O sum[565]:cur[0], unzip sum[0]:cur[0]
--------------
ROW OPERATIONS
--------------
0 queries inside InnoDB, 0 queries in queue
0 read views open inside InnoDB
Process ID=1469, Main thread ID=140646300190464, state: sleeping
Number of rows inserted 9784089, updated 333338010, deleted 197568, read 142156612291
0.00 inserts/s, 4.33 updates/s, 0.00 deletes/s, 6784.74 reads/s
----------------------------
END OF INNODB MONITOR OUTPUT
============================

1 row in set (0.01 sec)

mysql> 
mysql> explain UPDATE task_instance SET state='queued' WHERE task_instance.task_id = 'video_tag_6f' AND task_instance.dag_id = 'mysql2hdfs_newcluster.video_tag' AND task_instance.execution_date = '2020-11-18 16:01:00';
+----+-------------+---------------+------------+-------+-----------------------------------+---------+---------+-------------------+------+----------+-------------+
| id | select_type | table         | partitions | type  | possible_keys                     | key     | key_len | ref               | rows | filtered | Extra       |
+----+-------------+---------------+------------+-------+-----------------------------------+---------+---------+-------------------+------+----------+-------------+
|  1 | UPDATE      | task_instance | NULL       | range | PRIMARY,ti_dag_state,ti_state_lkp | PRIMARY | 1511    | const,const,const |    1 |   100.00 | Using where |
+----+-------------+---------------+------------+-------+-----------------------------------+---------+---------+-------------------+------+----------+-------------+
1 row in set (0.05 sec)

mysql> select count(*) from task_instance where task_instance.task_id = 'video_tag_6f' AND task_instance.dag_id = 'mysql2hdfs_newcluster.video_tag' AND task_instance.execution_date = '2020-11-18 16:01:00';
+----------+
| count(*) |
+----------+
|        1 |
+----------+
1 row in set (0.00 sec)

mysql> show create table task_instance;
+---------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table         | Create Table                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
+---------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| task_instance | CREATE TABLE `task_instance` (
  `task_id` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `dag_id` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `execution_date` timestamp(6) NOT NULL,
  `start_date` timestamp(6) NULL DEFAULT NULL,
  `end_date` timestamp(6) NULL DEFAULT NULL,
  `duration` float DEFAULT NULL,
  `state` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `try_number` int(11) DEFAULT NULL,
  `hostname` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `unixname` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `job_id` int(11) DEFAULT NULL,
  `pool` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `queue` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `priority_weight` int(11) DEFAULT NULL,
  `operator` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `queued_dttm` timestamp(6) NULL DEFAULT NULL,
  `pid` int(11) DEFAULT NULL,
  `max_tries` int(11) DEFAULT '-1',
  `executor_config` blob,
  PRIMARY KEY (`task_id`,`dag_id`,`execution_date`),
  KEY `ti_dag_state` (`dag_id`,`state`),
  KEY `ti_pool` (`pool`,`state`,`priority_weight`),
  KEY `ti_state_lkp` (`dag_id`,`task_id`,`execution_date`,`state`),
  KEY `ti_state` (`state`),
  KEY `ti_job_id` (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci |