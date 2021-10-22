
mysql> select * from performance_schema.threads;
+-----------+----------------------------------------+------------+----------------+------------------+------------------+----------------+---------------------+------------------+------------------------+------------------------------------------+------------------+------+--------------+---------+-----------------+--------------+
| THREAD_ID | NAME                                   | TYPE       | PROCESSLIST_ID | PROCESSLIST_USER | PROCESSLIST_HOST | PROCESSLIST_DB | PROCESSLIST_COMMAND | PROCESSLIST_TIME | PROCESSLIST_STATE      | PROCESSLIST_INFO                         | PARENT_THREAD_ID | ROLE | INSTRUMENTED | HISTORY | CONNECTION_TYPE | THREAD_OS_ID |
+-----------+----------------------------------------+------------+----------------+------------------+------------------+----------------+---------------------+------------------+------------------------+------------------------------------------+------------------+------+--------------+---------+-----------------+--------------+
|         1 | thread/sql/main                        | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |            14201 | NULL                   | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        13276 |
|         2 | thread/sql/thread_timer_notifier       | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                     |                1 | NULL | YES          | YES     | NULL            |        13280 |
|         3 | thread/innodb/io_ibuf_thread           | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        13284 |
|         4 | thread/innodb/io_log_thread            | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        13285 |
|         5 | thread/innodb/io_read_thread           | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        13286 |
|         6 | thread/innodb/io_read_thread           | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        13287 |
|         7 | thread/innodb/io_read_thread           | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        13288 |
|         8 | thread/innodb/io_read_thread           | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        13289 |
|         9 | thread/innodb/io_write_thread          | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        13290 |
|        10 | thread/innodb/io_write_thread          | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        13291 |
|        11 | thread/innodb/io_write_thread          | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        13292 |
|        12 | thread/innodb/io_write_thread          | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        13293 |
|        13 | thread/innodb/page_cleaner_thread      | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        13294 |
|        15 | thread/innodb/srv_lock_timeout_thread  | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        13300 |
|        16 | thread/innodb/srv_error_monitor_thread | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        13301 |
|        17 | thread/innodb/srv_monitor_thread       | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        13302 |
|        18 | thread/innodb/srv_master_thread        | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        13303 |
|        19 | thread/innodb/srv_purge_thread         | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        13304 |
|        20 | thread/innodb/srv_worker_thread        | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        13305 |
|        21 | thread/innodb/srv_worker_thread        | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        13307 |
|        22 | thread/innodb/srv_worker_thread        | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        13306 |
|        23 | thread/innodb/buf_dump_thread          | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        13308 |
|        24 | thread/innodb/dict_stats_thread        | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                     |             NULL | NULL | YES          | YES     | NULL            |        13309 |
|        25 | thread/sql/event_scheduler             | FOREGROUND |              1 | NULL             | NULL             | NULL           | Sleep               |             NULL | Waiting on empty queue | NULL                                     |                1 | NULL | YES          | YES     | NULL            |        13320 |
|        26 | thread/sql/signal_handler              | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                     |                1 | NULL | YES          | YES     | NULL            |        13321 |
|        27 | thread/sql/compress_gtid_table         | FOREGROUND |              2 | NULL             | NULL             | NULL           | Daemon              |            14201 | Suspending             | NULL                                     |                1 | NULL | YES          | YES     | NULL            |        13322 |
|        28 | thread/sql/one_connection              | FOREGROUND |              3 | root             | localhost        | sbtest         | Query               |                0 | Sending data           | select * from performance_schema.threads |                1 | NULL | YES          | YES     | Socket          |        13368 |
+-----------+----------------------------------------+------------+----------------+------------------+------------------+----------------+---------------------+------------------+------------------------+------------------------------------------+------------------+------+--------------+---------+-----------------+--------------+
27 rows in set (0.01 sec)

mysql> select a.thd_id,b.THREAD_OS_ID,a.user,b.TYPE from  sys.processlist a,performance_schema.threads  b where b.thread_id=a.thd_id;
ERROR 1356 (HY000): View 'sys.processlist' references invalid table(s) or column(s) or function(s) or definer/invoker of view lack rights to use them
mysql>  flush privileges;
Query OK, 0 rows affected (0.01 sec)

mysql> select a.thd_id,b.THREAD_OS_ID,a.user,b.TYPE from  sys.processlist a,performance_schema.threads  b where b.thread_id=a.thd_id;
ERROR 1356 (HY000): View 'sys.processlist' references invalid table(s) or column(s) or function(s) or definer/invoker of view lack rights to use them
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| consistency_db     |
| dezhou_db          |
| mysql              |
| niuniuh5_db        |
| performance_schema |
| sbtest             |
| sbtest_02          |
| sys                |
+--------------------+
9 rows in set (0.00 sec)
