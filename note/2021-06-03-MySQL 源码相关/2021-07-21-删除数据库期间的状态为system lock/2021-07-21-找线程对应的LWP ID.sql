

show processlist;
select * from performance_schema.threads;
select a.thd_id,b.THREAD_OS_ID,a.user,b.TYPE from  sys.processlist a,performance_schema.threads  b where b.thread_id=a.thd_id;
pstack $(pgrep -xn mysqld) > 1.sql




mysql> show processlist;
+----+------+---------------------+-------------+---------+------+----------------+------------------------------------------------------------------------------------------------------+
| Id | User | Host                | db          | Command | Time | State          | Info                                                                                                 |
+----+------+---------------------+-------------+---------+------+----------------+------------------------------------------------------------------------------------------------------+
| 16 | root | localhost           | NULL        | Query   |  718 | System lock    | drop database sbtest                                                                                 |
| 18 | root | localhost           | niuniuh5_db | Query   |    0 | creating table | CREATE TABLE `table_clublogscore20200207` (
  `ID` bigint(20) unsigned NOT NULL COMMENT '索引',
     |
| 21 | root | 192.168.0.220:50181 | NULL        | Sleep   |   80 |                | NULL                                                                                                 |
| 22 | root | 192.168.0.220:50183 | niuniuh5_db | Sleep   |   79 |                | NULL                                                                                                 |
| 23 | root | localhost           | NULL        | Query   |    0 | starting       | show processlist                                                                                     |
+----+------+---------------------+-------------+---------+------+----------------+------------------------------------------------------------------------------------------------------+
5 rows in set (0.00 sec)

mysql>  select * from performance_schema.threads;
+-----------+----------------------------------------+------------+----------------+------------------+------------------+----------------+---------------------+------------------+-------------------+-------------------------------------------------------------------+------------------+------+--------------+---------+-----------------+--------------+
| THREAD_ID | NAME                                   | TYPE       | PROCESSLIST_ID | PROCESSLIST_USER | PROCESSLIST_HOST | PROCESSLIST_DB | PROCESSLIST_COMMAND | PROCESSLIST_TIME | PROCESSLIST_STATE | PROCESSLIST_INFO                                                  | PARENT_THREAD_ID | ROLE | INSTRUMENTED | HISTORY | CONNECTION_TYPE | THREAD_OS_ID |
+-----------+----------------------------------------+------------+----------------+------------------+------------------+----------------+---------------------+------------------+-------------------+-------------------------------------------------------------------+------------------+------+--------------+---------+-----------------+--------------+
|         1 | thread/sql/main                        | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |           513261 | NULL              | NULL                                                              |             NULL | NULL | YES          | YES     | NULL            |        12496 |
|         2 | thread/sql/thread_timer_notifier       | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                                              |                1 | NULL | YES          | YES     | NULL            |        12497 |
|         3 | thread/innodb/io_ibuf_thread           | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                                              |             NULL | NULL | YES          | YES     | NULL            |        12498 |
|         4 | thread/innodb/io_log_thread            | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                                              |             NULL | NULL | YES          | YES     | NULL            |        12499 |
|         5 | thread/innodb/io_read_thread           | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                                              |             NULL | NULL | YES          | YES     | NULL            |        12501 |
|         6 | thread/innodb/io_read_thread           | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                                              |             NULL | NULL | YES          | YES     | NULL            |        12500 |
|         7 | thread/innodb/io_read_thread           | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                                              |             NULL | NULL | YES          | YES     | NULL            |        12502 |
|         8 | thread/innodb/io_read_thread           | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                                              |             NULL | NULL | YES          | YES     | NULL            |        12503 |
|         9 | thread/innodb/io_read_thread           | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                                              |             NULL | NULL | YES          | YES     | NULL            |        12504 |
|        10 | thread/innodb/io_read_thread           | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                                              |             NULL | NULL | YES          | YES     | NULL            |        12505 |
|        11 | thread/innodb/io_read_thread           | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                                              |             NULL | NULL | YES          | YES     | NULL            |        12506 |
|        12 | thread/innodb/io_read_thread           | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                                              |             NULL | NULL | YES          | YES     | NULL            |        12507 |
|        13 | thread/innodb/io_write_thread          | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                                              |             NULL | NULL | YES          | YES     | NULL            |        12509 |
|        14 | thread/innodb/io_write_thread          | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                                              |             NULL | NULL | YES          | YES     | NULL            |        12508 |
|        15 | thread/innodb/io_write_thread          | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                                              |             NULL | NULL | YES          | YES     | NULL            |        12510 |
|        16 | thread/innodb/io_write_thread          | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                                              |             NULL | NULL | YES          | YES     | NULL            |        12511 |
|        17 | thread/innodb/io_write_thread          | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                                              |             NULL | NULL | YES          | YES     | NULL            |        12512 |
|        18 | thread/innodb/io_write_thread          | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                                              |             NULL | NULL | YES          | YES     | NULL            |        12513 |
|        19 | thread/innodb/io_write_thread          | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                                              |             NULL | NULL | YES          | YES     | NULL            |        12514 |
|        20 | thread/innodb/io_write_thread          | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                                              |             NULL | NULL | YES          | YES     | NULL            |        12515 |
|        21 | thread/innodb/page_cleaner_thread      | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                                              |             NULL | NULL | YES          | YES     | NULL            |        12516 |
|        23 | thread/innodb/srv_lock_timeout_thread  | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                                              |             NULL | NULL | YES          | YES     | NULL            |        12521 |
|        24 | thread/innodb/srv_monitor_thread       | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                                              |             NULL | NULL | YES          | YES     | NULL            |        12523 |
|        25 | thread/innodb/srv_error_monitor_thread | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                                              |             NULL | NULL | YES          | YES     | NULL            |        12522 |
|        26 | thread/innodb/srv_master_thread        | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                                              |             NULL | NULL | YES          | YES     | NULL            |        12524 |
|        27 | thread/innodb/srv_worker_thread        | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                                              |             NULL | NULL | YES          | YES     | NULL            |        12527 |
|        28 | thread/innodb/srv_purge_thread         | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                                              |             NULL | NULL | YES          | YES     | NULL            |        12525 |
|        29 | thread/innodb/srv_worker_thread        | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                                              |             NULL | NULL | YES          | YES     | NULL            |        12528 |
|        30 | thread/innodb/srv_worker_thread        | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                                              |             NULL | NULL | YES          | YES     | NULL            |        12526 |
|        31 | thread/innodb/buf_dump_thread          | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                                              |             NULL | NULL | YES          | YES     | NULL            |        12531 |
|        32 | thread/innodb/dict_stats_thread        | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                                              |             NULL | NULL | YES          | YES     | NULL            |        12532 |
|        33 | thread/sql/signal_handler              | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL              | NULL                                                              |                1 | NULL | YES          | YES     | NULL            |        12537 |
|        34 | thread/sql/compress_gtid_table         | FOREGROUND |              1 | NULL             | NULL             | NULL           | Daemon              |           513261 | Suspending        | NULL                                                              |                1 | NULL | YES          | YES     | NULL            |        12538 |
|        49 | thread/sql/one_connection              | FOREGROUND |             16 | root             | localhost        | sys            | Query               |              840 | System lock       | drop database sbtest                                              |             NULL | NULL | YES          | YES     | Socket          |        13506 |
|        51 | thread/sql/one_connection              | FOREGROUND |             18 | root             | localhost        | niuniuh5_db    | Query               |                0 | query end         | /*!40000 ALTER TABLE `table_clublogscore20210525` DISABLE KEYS */ |             NULL | NULL | YES          | YES     | Socket          |        13505 |
|        54 | thread/sql/one_connection              | FOREGROUND |             21 | root             | 192.168.0.220    | NULL           | Sleep               |              202 | NULL              | NULL                                                              |             NULL | NULL | YES          | YES     | TCP/IP          |        12541 |
|        55 | thread/sql/one_connection              | FOREGROUND |             22 | root             | 192.168.0.220    | niuniuh5_db    | Sleep               |              201 | NULL              | NULL                                                              |             NULL | NULL | YES          | YES     | TCP/IP          |        13978 |
|        56 | thread/sql/one_connection              | FOREGROUND |             23 | root             | localhost        | sys            | Query               |                0 | Sending data      | select * from performance_schema.threads                          |             NULL | NULL | YES          | YES     | Socket          |        13507 |
+-----------+----------------------------------------+------------+----------------+------------------+------------------+----------------+---------------------+------------------+-------------------+-------------------------------------------------------------------+------------------+------+--------------+---------+-----------------+--------------+
38 rows in set (0.00 sec)

mysql> select a.thd_id,b.THREAD_OS_ID,a.user,b.TYPE from  sys.processlist a,performance_schema.threads  b where b.thread_id=a.thd_id;
+--------+--------------+---------------------------------+------------+
| thd_id | THREAD_OS_ID | user                            | TYPE       |
+--------+--------------+---------------------------------+------------+
|      1 |        12496 | sql/main                        | BACKGROUND |
|      2 |        12497 | sql/thread_timer_notifier       | BACKGROUND |
|      3 |        12498 | innodb/io_ibuf_thread           | BACKGROUND |
|      4 |        12499 | innodb/io_log_thread            | BACKGROUND |
|      5 |        12501 | innodb/io_read_thread           | BACKGROUND |
|      6 |        12500 | innodb/io_read_thread           | BACKGROUND |
|      7 |        12502 | innodb/io_read_thread           | BACKGROUND |
|      8 |        12503 | innodb/io_read_thread           | BACKGROUND |
|      9 |        12504 | innodb/io_read_thread           | BACKGROUND |
|     10 |        12505 | innodb/io_read_thread           | BACKGROUND |
|     11 |        12506 | innodb/io_read_thread           | BACKGROUND |
|     12 |        12507 | innodb/io_read_thread           | BACKGROUND |
|     13 |        12509 | innodb/io_write_thread          | BACKGROUND |
|     14 |        12508 | innodb/io_write_thread          | BACKGROUND |
|     15 |        12510 | innodb/io_write_thread          | BACKGROUND |
|     16 |        12511 | innodb/io_write_thread          | BACKGROUND |
|     17 |        12512 | innodb/io_write_thread          | BACKGROUND |
|     18 |        12513 | innodb/io_write_thread          | BACKGROUND |
|     19 |        12514 | innodb/io_write_thread          | BACKGROUND |
|     20 |        12515 | innodb/io_write_thread          | BACKGROUND |
|     21 |        12516 | innodb/page_cleaner_thread      | BACKGROUND |
|     23 |        12521 | innodb/srv_lock_timeout_thread  | BACKGROUND |
|     24 |        12523 | innodb/srv_monitor_thread       | BACKGROUND |
|     25 |        12522 | innodb/srv_error_monitor_thread | BACKGROUND |
|     26 |        12524 | innodb/srv_master_thread        | BACKGROUND |
|     27 |        12527 | innodb/srv_worker_thread        | BACKGROUND |
|     28 |        12525 | innodb/srv_purge_thread         | BACKGROUND |
|     29 |        12528 | innodb/srv_worker_thread        | BACKGROUND |
|     30 |        12526 | innodb/srv_worker_thread        | BACKGROUND |
|     31 |        12531 | innodb/buf_dump_thread          | BACKGROUND |
|     32 |        12532 | innodb/dict_stats_thread        | BACKGROUND |
|     33 |        12537 | sql/signal_handler              | BACKGROUND |
|     34 |        12538 | sql/compress_gtid_table         | FOREGROUND |
|     49 |        13506 | root@localhost                  | FOREGROUND |
|     51 |        13505 | root@localhost                  | FOREGROUND |
|     54 |        12541 | root@192.168.0.220              | FOREGROUND |
|     55 |        13978 | root@192.168.0.220              | FOREGROUND |
|     56 |        13507 | root@localhost                  | FOREGROUND |
+--------+--------------+---------------------------------+------------+
38 rows in set (0.57 sec)

线程号为 49 对应的LWP ID 为 13506

	Thread 4 (Thread 0x7fba5d972700 (LWP 13506)):
	#0  0x00007fbccef3dd7d in fsync () from /lib64/libpthread.so.0
	#1  0x0000000000ff5610 in os_file_fsync_posix (file=10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:3055
	#2  os_file_flush_func (file=10) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0file.cc:3170
	#3  0x000000000118d8f9 in pfs_os_file_flush_func (src_line=5992, file=..., src_file=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/include/os0file.ic:505
	#4  fil_flush (space_id=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/fil/fil0fil.cc:5992
	#5  0x0000000000fd4af2 in log_write_flush_to_disk_low () at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/log/log0log.cc:1156
	#6  0x0000000000fd5c29 in log_write_up_to (lsn=<optimized out>, flush_to_disk=true) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/log/log0log.cc:1406
	#7  0x00000000010d1b2d in trx_flush_log_if_needed_low (lsn=147573166158) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/trx/trx0trx.cc:1794
	#8  trx_flush_log_if_needed (trx=0x7fbcc2eb4920, lsn=147573166158) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/trx/trx0trx.cc:1816
	#9  trx_commit_in_memory (serialised=<optimized out>, mtr=<optimized out>, trx=0x7fbcc2eb4920) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/trx/trx0trx.cc:2043
	#10 trx_commit_low (trx=0x7fbcc2eb4920, mtr=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/trx/trx0trx.cc:2180
	#11 0x00000000010d1d34 in trx_commit (trx=0x7fbcc2eb4920) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/trx/trx0trx.cc:2204
	#12 0x00000000010d3627 in trx_commit_for_mysql (trx=0x7fbcc2eb4920) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/trx/trx0trx.cc:2423
	#13 0x0000000001176bac in dict_stats_exec_sql (pinfo=<optimized out>, sql=0x161f450 "PROCEDURE DELETE_FROM_INDEX_STATS () IS\nBEGIN\nDELETE FROM \"mysql/innodb_index_stats\" WHERE\ndatabase_name = :database_name AND\ntable_name = :table_name;\nEND;\n", trx=0x7fbcc2eb4920) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/dict/dict0stats.cc:324
	#14 0x0000000001176ffb in dict_stats_drop_table (db_and_table=<optimized out>, errstr=0x7fba5d96c580 "", errstr_sz=1024) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/dict/dict0stats.cc:3465
	#15 0x0000000001050338 in row_drop_table_for_mysql (name=0x7fba5d96d720 "sbtest/table_clublogscore20190825", trx=0x7fbcc2eb4590, drop_db=true, nonatomic=<optimized out>, handler=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/row/row0mysql.cc:4341
	#16 0x0000000000f883c2 in ha_innobase::delete_table (this=<optimized out>, name=0x7fba5d96eb30 "./sbtest/table_clublogscore20190825") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/handler/ha_innodb.cc:12539
	#17 0x000000000081e6d8 in ha_delete_table (thd=0x7fb9f8583050, table_type=<optimized out>, path=0x7fba5d96eb30 "./sbtest/table_clublogscore20190825", db=0x7fb9f8cc1568 "sbtest", alias=0x7fb9f8cc156f "table_clublogscore20190825", generate_warning=false) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/handler.cc:2586
	#18 0x0000000000d7f6fd in mysql_rm_table_no_locks (thd=0x7fb9f8583050, tables=0x7fb9f800e300, if_exists=true, drop_temporary=false, drop_view=true, dont_log_query=true) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_table.cc:2546
	#19 0x0000000000cdf397 in mysql_rm_db (thd=0x7fb9f8583050, db=..., if_exists=<optimized out>, silent=false) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_db.cc:865
	#20 0x0000000000d1a2e5 in mysql_execute_command (thd=0x7fb9f8583050, first_level=true) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:3818
	#21 0x0000000000d1aaad in mysql_parse (thd=0x7fb9f8583050, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:5582
	#22 0x0000000000d1bcca in dispatch_command (thd=0x7fb9f8583050, com_data=0x7fba5d971da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:1458
	#23 0x0000000000d1cb74 in do_command (thd=0x7fb9f8583050) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:999
	#24 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
	#25 0x0000000001256a94 in pfs_spawn_thread (arg=0x137c2420) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
	#26 0x00007fbccef36ea5 in start_thread () from /lib64/libpthread.so.0
	#27 0x00007fbccd9ef8dd in clone () from /lib64/libc.so.6

