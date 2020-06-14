

4CPU 16G内存 100G SSD

master:
binlog_group_commit_sync_delay = 0
binlog_group_commit_sync_no_delay_count = 0
transaction_write_set_extraction       = XXHASH64
binlog_transaction_dependency_tracking = WRITESET
sync_binlog=1
 
slave:
slave_parallel_type=LOGICAL_CLOCK                 
slave_parallel_workers=4                                      
master_info_repository=TABLE
relay_log_info_repository=TABLE
relay_log_recovery=ON
sync_binlog=1


实验目的:
	1. 查看主从延迟情况
	2. 查看并发度:
		mysqlbinlog --no-defaults mysql-bin.000018 |grep last_committed


	SELECT thread_id,count_star

	FROM performance_schema.events_transactions_summary_by_thread_by_event_name 

	WHERE thread_id IN (
	
		SELECT thread_id FROM performance_schema.replication_applier_status_by_worker

	); 
	
	+-----------+------------+
	| thread_id | count_star |
	+-----------+------------+
	|      4544 |          0 |
	|      4545 |          0 |
	|      4542 |          0 |
	|      4543 |          0 |
	+-----------+------------+
	4 rows in set (0.00 sec)


	
./sysbench --mysql-host=11.111.11.11 --mysql-port=3306 --mysql-user=root --mysql-password=123456123 --test=tests/db/oltp.lua --oltp_tables_count=10 --oltp-table-size=1000000 --rand-init=on prepare
	
./sysbench --mysql-host=11.111.11.11 --mysql-port=3306 --mysql-user=root \
--mysql-password=123456123 --test=tests/db/oltp.lua --oltp_tables_count=10 \
--oltp-table-size=1000000 --num-threads=10 --oltp-read-only=off \
--report-interval=10 --rand-type=uniform --max-time=3600 \
 --max-requests=0 --percentile=99 run >> /home/dba2/log/sysbench_oltpX_12_2019-08-05_5.7.24_writeset_MTS.log
 
 
 
 mysql> show processlist;
+------+-----------------+----------------------+------+---------+------+---------------------------------------------------+------------------+
| Id   | User            | Host                 | db   | Command | Time | State                                             | Info             |
+------+-----------------+----------------------+------+---------+------+---------------------------------------------------+------------------+
|    3 | event_scheduler | localhost            | NULL | Daemon  | 4728 | Waiting for next activation                       | NULL             |
| 4507 | root            | 111.11.111.111:28435 | NULL | Sleep   | 7607 |                                                   | NULL             |
| 4508 | root            | 111.11.111.111:28448 | NULL | Sleep   | 7597 |                                                   | NULL             |
| 4510 | root            | 111.11.111.111:26844 | NULL | Sleep   | 1523 |                                                   | NULL             |
| 4511 | root            | 111.11.111.111:26977 | NULL | Sleep   | 1465 |                                                   | NULL             |
| 4512 | root            | 111.11.111.111:29194 | NULL | Sleep   |  222 |                                                   | NULL             |
| 4513 | root            | 111.11.111.111:25707 | NULL | Sleep   |   95 |                                                   | NULL             |
| 4514 | root            | 11.111.11.11:52154   | NULL | Query   |    0 | starting                                          | show processlist |
| 4515 | system user     |                      | NULL | Connect |   53 | Waiting for master to send event                  | NULL             |
| 4516 | system user     |                      | NULL | Connect |    0 | Waiting for slave workers to process their queues | NULL             |
| 4517 | system user     |                      | NULL | Connect |   32 | invalidating query cache entries (table)          | NULL             |
| 4518 | system user     |                      | NULL | Connect |   32 | System lock                                       | NULL             |
| 4519 | system user     |                      | NULL | Connect |   32 | invalidating query cache entries (table)          | NULL             |
| 4520 | system user     |                      | NULL | Connect |   32 | System lock                                       | NULL             |
+------+-----------------+----------------------+------+---------+------+---------------------------------------------------+------------------+
14 rows in set (0.00 sec)



mysql> show processlist;
+------+-----------------+----------------------+------+---------+------+---------------------------------------------------+------------------+
| Id   | User            | Host                 | db   | Command | Time | State                                             | Info             |
+------+-----------------+----------------------+------+---------+------+---------------------------------------------------+------------------+
|    3 | event_scheduler | localhost            | NULL | Daemon  | 4750 | Waiting for next activation                       | NULL             |
| 4507 | root            | 111.11.111.111:28435 | NULL | Sleep   | 7629 |                                                   | NULL             |
| 4508 | root            | 111.11.111.111:28448 | NULL | Sleep   | 7619 |                                                   | NULL             |
| 4510 | root            | 111.11.111.111:26844 | NULL | Sleep   | 1545 |                                                   | NULL             |
| 4511 | root            | 111.11.111.111:26977 | NULL | Sleep   | 1487 |                                                   | NULL             |
| 4512 | root            | 111.11.111.111:29194 | NULL | Sleep   |  244 |                                                   | NULL             |
| 4513 | root            | 111.11.111.111:25707 | NULL | Sleep   |  117 |                                                   | NULL             |
| 4514 | root            | 11.111.11.11:52154   | NULL | Query   |    0 | starting                                          | show processlist |
| 4515 | system user     |                      | NULL | Connect |   75 | Waiting for master to send event                  | NULL             |
| 4516 | system user     |                      | NULL | Connect |    0 | Waiting for slave workers to process their queues | NULL             |
| 4517 | system user     |                      | NULL | Connect |   31 | System lock                                       | NULL             |
| 4518 | system user     |                      | NULL | Connect |   31 | Waiting for an event from Coordinator             | NULL             |
| 4519 | system user     |                      | NULL | Connect |   31 | System lock                                       | NULL             |
| 4520 | system user     |                      | NULL | Connect |   31 | System lock                                       | NULL             |
+------+-----------------+----------------------+------+---------+------+---------------------------------------------------+------------------+


