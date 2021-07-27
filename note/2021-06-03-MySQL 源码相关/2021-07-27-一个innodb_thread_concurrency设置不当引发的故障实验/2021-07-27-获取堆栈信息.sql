


set global innodb_thread_concurrency=3;

mysql>  show global variables like '%innodb_thread_concurrency%';
+---------------------------+-------+
| Variable_name             | Value |
+---------------------------+-------+
| innodb_thread_concurrency | 3     |
+---------------------------+-------+
1 row in set (0.00 sec)

 
 session A                  session B                  session C                 session D         session E
 select sleep(100) from t;  select sleep(100) from t;  select sleep(100) from t; 
																			
																				 select 1; 
																				 (Query OK)
																				 /usr/local/mysql/bin/mysqlslap  --no-defaults -h192.168.1.12 -upt_user -p'#123456Abc' --create-schema="sbtest" --number-of-queries=1000000 --concurrency=5 --query='insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand()*10000), now());'


mysql> show processlist;
+------+-----------------+--------------------+--------+---------+--------+------------------------+------------------------------------------------------------------------------------------------------+
| Id   | User            | Host               | db     | Command | Time   | State                  | Info                                                                                                 |
+------+-----------------+--------------------+--------+---------+--------+------------------------+------------------------------------------------------------------------------------------------------+
|    3 | event_scheduler | localhost          | NULL   | Daemon  | 435225 | Waiting on empty queue | NULL                                                                                                 |
| 2747 | root            | localhost          | sbtest | Query   |     24 | User sleep             | select sleep(100) from t                                                                             |
| 2784 | root            | localhost          | sbtest | Query   |      0 | starting               | show processlist                                                                                     |
| 2796 | root            | localhost          | sbtest | Query   |     21 | User sleep             | select sleep(100) from t                                                                             |
| 2928 | root            | localhost          | sbtest | Query   |     18 | User sleep             | select sleep(100) from t                                                                             |
| 2929 | pt_user         | 192.168.1.12:51030 | NULL   | Sleep   |      6 |                        | NULL                                                                                                 |
| 2930 | pt_user         | 192.168.1.12:51032 | sbtest | Query   |      6 | update                 | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
| 2931 | pt_user         | 192.168.1.12:51034 | sbtest | Query   |      6 | update                 | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
| 2932 | pt_user         | 192.168.1.12:51038 | sbtest | Query   |      6 | update                 | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
| 2933 | pt_user         | 192.168.1.12:51035 | sbtest | Query   |      6 | update                 | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
| 2934 | pt_user         | 192.168.1.12:51040 | sbtest | Query   |      6 | update                 | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand( |
+------+-----------------+--------------------+--------+---------+--------+------------------------+------------------------------------------------------------------------------------------------------+
11 rows in set (0.00 sec)




找线程对应的 LWP ID

show processlist;
select * from performance_schema.threads;
select a.thd_id,b.THREAD_OS_ID,a.user,b.TYPE from  sys.processlist a,performance_schema.threads  b where b.thread_id=a.thd_id;

sudo pstack $(pgrep -xn mysqld) > 20210727.sql



mysql> select * from performance_schema.threads;
+-----------+----------------------------------------+------------+----------------+------------------+------------------+----------------+---------------------+------------------+------------------------+----------------------------------------------------------------------------------------------------------------------+------------------+------+--------------+---------+-----------------+--------------+
| THREAD_ID | NAME                                   | TYPE       | PROCESSLIST_ID | PROCESSLIST_USER | PROCESSLIST_HOST | PROCESSLIST_DB | PROCESSLIST_COMMAND | PROCESSLIST_TIME | PROCESSLIST_STATE      | PROCESSLIST_INFO                                                                                                     | PARENT_THREAD_ID | ROLE | INSTRUMENTED | HISTORY | CONNECTION_TYPE | THREAD_OS_ID |
+-----------+----------------------------------------+------------+----------------+------------------+------------------+----------------+---------------------+------------------+------------------------+----------------------------------------------------------------------------------------------------------------------+------------------+------+--------------+---------+-----------------+--------------+
|         1 | thread/sql/main                        | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |           435321 | NULL                   | NULL                                                                                                                 |             NULL | NULL | YES          | YES     | NULL            |        20583 |
|         2 | thread/sql/thread_timer_notifier       | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                                                                                                 |                1 | NULL | YES          | YES     | NULL            |        20584 |
|         3 | thread/innodb/io_ibuf_thread           | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                                                                                                 |             NULL | NULL | YES          | YES     | NULL            |        20587 |
|         4 | thread/innodb/io_log_thread            | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                                                                                                 |             NULL | NULL | YES          | YES     | NULL            |        20588 |
|         5 | thread/innodb/io_read_thread           | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                                                                                                 |             NULL | NULL | YES          | YES     | NULL            |        20589 |
|         6 | thread/innodb/io_read_thread           | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                                                                                                 |             NULL | NULL | YES          | YES     | NULL            |        20590 |
|         7 | thread/innodb/io_read_thread           | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                                                                                                 |             NULL | NULL | YES          | YES     | NULL            |        20591 |
|         8 | thread/innodb/io_read_thread           | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                                                                                                 |             NULL | NULL | YES          | YES     | NULL            |        20592 |
|         9 | thread/innodb/io_write_thread          | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                                                                                                 |             NULL | NULL | YES          | YES     | NULL            |        20594 |
|        10 | thread/innodb/io_write_thread          | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                                                                                                 |             NULL | NULL | YES          | YES     | NULL            |        20593 |
|        11 | thread/innodb/io_write_thread          | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                                                                                                 |             NULL | NULL | YES          | YES     | NULL            |        20595 |
|        12 | thread/innodb/io_write_thread          | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                                                                                                 |             NULL | NULL | YES          | YES     | NULL            |        20596 |
|        13 | thread/innodb/page_cleaner_thread      | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                                                                                                 |             NULL | NULL | YES          | YES     | NULL            |        20597 |
|      2773 | thread/sql/one_connection              | FOREGROUND |           2747 | root             | localhost        | sbtest         | Query               |              120 | User sleep             | select sleep(100) from t                                                                                             |             NULL | NULL | YES          | YES     | Socket          |         2848 |
|        16 | thread/innodb/srv_lock_timeout_thread  | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                                                                                                 |             NULL | NULL | YES          | YES     | NULL            |        20605 |
|        17 | thread/innodb/srv_error_monitor_thread | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                                                                                                 |             NULL | NULL | YES          | YES     | NULL            |        20606 |
|        18 | thread/innodb/srv_monitor_thread       | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                                                                                                 |             NULL | NULL | YES          | YES     | NULL            |        20607 |
|        19 | thread/innodb/srv_master_thread        | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                                                                                                 |             NULL | NULL | YES          | YES     | NULL            |        20608 |
|        20 | thread/innodb/srv_worker_thread        | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                                                                                                 |             NULL | NULL | YES          | YES     | NULL            |        20610 |
|        21 | thread/innodb/srv_worker_thread        | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                                                                                                 |             NULL | NULL | YES          | YES     | NULL            |        20611 |
|        22 | thread/innodb/srv_purge_thread         | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                                                                                                 |             NULL | NULL | YES          | YES     | NULL            |        20609 |
|        23 | thread/innodb/srv_worker_thread        | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                                                                                                 |             NULL | NULL | YES          | YES     | NULL            |        20612 |
|        24 | thread/innodb/dict_stats_thread        | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                                                                                                 |             NULL | NULL | YES          | YES     | NULL            |        20614 |
|        25 | thread/innodb/buf_dump_thread          | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                                                                                                 |             NULL | NULL | YES          | YES     | NULL            |        20613 |
|        28 | thread/sql/event_scheduler             | FOREGROUND |              3 | NULL             | NULL             | NULL           | Sleep               |             NULL | Waiting on empty queue | NULL                                                                                                                 |                1 | NULL | YES          | YES     | NULL            |        20620 |
|        29 | thread/sql/signal_handler              | BACKGROUND |           NULL | NULL             | NULL             | NULL           | NULL                |             NULL | NULL                   | NULL                                                                                                                 |                1 | NULL | YES          | YES     | NULL            |        20621 |
|        30 | thread/sql/compress_gtid_table         | FOREGROUND |              4 | NULL             | NULL             | NULL           | Daemon              |           435321 | Suspending             | NULL                                                                                                                 |                1 | NULL | YES          | YES     | NULL            |        20622 |
|      2810 | thread/sql/one_connection              | FOREGROUND |           2784 | root             | localhost        | sbtest         | Query               |                0 | Sending data           | select * from performance_schema.threads                                                                             |             NULL | NULL | YES          | YES     | Socket          |         3063 |
|      2822 | thread/sql/one_connection              | FOREGROUND |           2796 | root             | localhost        | sbtest         | Query               |              117 | User sleep             | select sleep(100) from t                                                                                             |             NULL | NULL | YES          | YES     | Socket          |        32682 |
|      2954 | thread/sql/one_connection              | FOREGROUND |           2928 | root             | localhost        | sbtest         | Query               |              114 | User sleep             | select sleep(100) from t                                                                                             |             NULL | NULL | YES          | YES     | Socket          |         9632 |
|      2955 | thread/sql/one_connection              | FOREGROUND |           2929 | pt_user          | 192.168.1.12     | NULL           | Sleep               |              102 | NULL                   | NULL                                                                                                                 |             NULL | NULL | YES          | YES     | TCP/IP          |         2849 |
|      2956 | thread/sql/one_connection              | FOREGROUND |           2930 | pt_user          | 192.168.1.12     | sbtest         | Query               |              102 | update                 | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand()*10000), now()) |             NULL | NULL | YES          | YES     | TCP/IP          |        30761 |
|      2957 | thread/sql/one_connection              | FOREGROUND |           2931 | pt_user          | 192.168.1.12     | sbtest         | Query               |              102 | update                 | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand()*10000), now()) |             NULL | NULL | YES          | YES     | TCP/IP          |        32679 |
|      2958 | thread/sql/one_connection              | FOREGROUND |           2932 | pt_user          | 192.168.1.12     | sbtest         | Query               |              102 | update                 | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand()*10000), now()) |             NULL | NULL | YES          | YES     | TCP/IP          |         9627 |
|      2959 | thread/sql/one_connection              | FOREGROUND |           2933 | pt_user          | 192.168.1.12     | sbtest         | Query               |              102 | update                 | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand()*10000), now()) |             NULL | NULL | YES          | YES     | TCP/IP          |        30798 |
|      2960 | thread/sql/one_connection              | FOREGROUND |           2934 | pt_user          | 192.168.1.12     | sbtest         | Query               |              102 | update                 | insert into t_20210722(name, age, createTime) values(concat(ceil(rand()*10000), "bin11"), ceil(rand()*10000), now()) |             NULL | NULL | YES          | YES     | TCP/IP          |        32677 |
+-----------+----------------------------------------+------------+----------------+------------------+------------------+----------------+---------------------+------------------+------------------------+----------------------------------------------------------------------------------------------------------------------+------------------+------+--------------+---------+-----------------+--------------+
36 rows in set (0.00 sec)



Thread 39 (Thread 0x7fed04b2d700 (LWP 30761)):
#0  0x00007fef467a9e9d in nanosleep () from /lib64/libpthread.so.0
#1  0x00000000010c3dc0 in os_thread_sleep (tm=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0thread.cc:279
#2  0x0000000001159291 in srv_conc_enter_innodb_with_atomics (trx=0x7fef324b5200) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0conc.cc:213
#3  srv_conc_enter_innodb (prebuilt=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0conc.cc:257
#4  0x000000000104e735 in ha_innobase::write_row (this=0x7feccc037b90, record=0x7feccc037fa0 "\005p*") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:7595
#5  0x000000000081fe7b in handler::ha_write_row (this=0x7feccc037b90, buf=0x7feccc037fa0 "\005p*") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:8062
#6  0x0000000000ea0427 in write_record (thd=0x7feca402eaa0, table=0x7feccc0371a0, info=0x7fed04b2b4a0, update=0x7fed04b2b420) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:1873
#7  0x0000000000ea1892 in Sql_cmd_insert::mysql_insert (this=0x7feca401b7b8, thd=0x7feca402eaa0, table_list=0x7feca401a9a8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:769
#8  0x0000000000ea209a in Sql_cmd_insert::execute (this=0x7feca401b7b8, thd=0x7feca402eaa0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:3118
#9  0x0000000000d1835c in mysql_execute_command (thd=0x7feca402eaa0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:3596
#10 0x0000000000d1c86d in mysql_parse (thd=0x7feca402eaa0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#11 0x0000000000d1da95 in dispatch_command (thd=0x7feca402eaa0, com_data=0x7fed04b2cda0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#12 0x0000000000d1e944 in do_command (thd=0x7feca402eaa0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#13 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#14 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0cf60) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#15 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#16 0x00007fef4525a9fd in clone () from /lib64/libc.so.6

Thread 34 (Thread 0x7fed047d3700 (LWP 32679)):
#0  0x00007fef467a9e9d in nanosleep () from /lib64/libpthread.so.0
#1  0x00000000010c3dc0 in os_thread_sleep (tm=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0thread.cc:279
#2  0x0000000001159291 in srv_conc_enter_innodb_with_atomics (trx=0x7fef324b5590) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0conc.cc:213
#3  srv_conc_enter_innodb (prebuilt=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0conc.cc:257
#4  0x000000000104e735 in ha_innobase::write_row (this=0x7fec88014fc0, record=0x7fec88006930 "\003p*") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:7595
#5  0x000000000081fe7b in handler::ha_write_row (this=0x7fec88014fc0, buf=0x7fec88006930 "\003p*") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:8062
#6  0x0000000000ea0427 in write_record (thd=0x7fec840079b0, table=0x7fec8800fd80, info=0x7fed047d14a0, update=0x7fed047d1420) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:1873
#7  0x0000000000ea1892 in Sql_cmd_insert::mysql_insert (this=0x7fec84012a88, thd=0x7fec840079b0, table_list=0x7fec84011c78) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:769
#8  0x0000000000ea209a in Sql_cmd_insert::execute (this=0x7fec84012a88, thd=0x7fec840079b0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:3118
#9  0x0000000000d1835c in mysql_execute_command (thd=0x7fec840079b0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:3596
#10 0x0000000000d1c86d in mysql_parse (thd=0x7fec840079b0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#11 0x0000000000d1da95 in dispatch_command (thd=0x7fec840079b0, com_data=0x7fed047d2da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#12 0x0000000000d1e944 in do_command (thd=0x7fec840079b0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#13 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#14 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x2c0da50) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#15 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#16 0x00007fef4525a9fd in clone () from /lib64/libc.so.6


Thread 13 (Thread 0x7fed046cb700 (LWP 9627)):
#0  0x00007fef467a9e9d in nanosleep () from /lib64/libpthread.so.0
#1  0x00000000010c3dc0 in os_thread_sleep (tm=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0thread.cc:279
#2  0x0000000001159291 in srv_conc_enter_innodb_with_atomics (trx=0x7fef324b6040) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0conc.cc:213
#3  srv_conc_enter_innodb (prebuilt=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0conc.cc:257
#4  0x000000000104e735 in ha_innobase::write_row (this=0x7fecd00044d0, record=0x7fecd00395f0 "\006p*") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:7595
#5  0x000000000081fe7b in handler::ha_write_row (this=0x7fecd00044d0, buf=0x7fecd00395f0 "\006p*") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:8062
#6  0x0000000000ea0427 in write_record (thd=0x7fecc0028230, table=0x7fecd0b138d0, info=0x7fed046c94a0, update=0x7fed046c9420) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:1873
#7  0x0000000000ea1892 in Sql_cmd_insert::mysql_insert (this=0x7fecc0005c48, thd=0x7fecc0028230, table_list=0x7fecc0004e38) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:769
#8  0x0000000000ea209a in Sql_cmd_insert::execute (this=0x7fecc0005c48, thd=0x7fecc0028230) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:3118
#9  0x0000000000d1835c in mysql_execute_command (thd=0x7fecc0028230, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:3596
#10 0x0000000000d1c86d in mysql_parse (thd=0x7fecc0028230, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#11 0x0000000000d1da95 in dispatch_command (thd=0x7fecc0028230, com_data=0x7fed046cada0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#12 0x0000000000d1e944 in do_command (thd=0x7fecc0028230) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#13 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#14 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0cc10) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#15 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#16 0x00007fef4525a9fd in clone () from /lib64/libc.so.6



Thread 36 (Thread 0x7fed0519f700 (LWP 30798)):
#0  0x00007fef467a9e9d in nanosleep () from /lib64/libpthread.so.0
#1  0x00000000010c3dc0 in os_thread_sleep (tm=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0thread.cc:279
#2  0x0000000001159291 in srv_conc_enter_innodb_with_atomics (trx=0x7fef324b5cb0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0conc.cc:213
#3  srv_conc_enter_innodb (prebuilt=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0conc.cc:257
#4  0x000000000104e735 in ha_innobase::write_row (this=0x7fec840064d0, record=0x7fec840217f0 "\004p*") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:7595
#5  0x000000000081fe7b in handler::ha_write_row (this=0x7fec840064d0, buf=0x7fec840217f0 "\004p*") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:8062
#6  0x0000000000ea0427 in write_record (thd=0x7fecc4070290, table=0x7fec84020e40, info=0x7fed0519d4a0, update=0x7fed0519d420) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:1873
#7  0x0000000000ea1892 in Sql_cmd_insert::mysql_insert (this=0x7fecc406c9b8, thd=0x7fecc4070290, table_list=0x7fecc406bba8) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:769
#8  0x0000000000ea209a in Sql_cmd_insert::execute (this=0x7fecc406c9b8, thd=0x7fecc4070290) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:3118
#9  0x0000000000d1835c in mysql_execute_command (thd=0x7fecc4070290, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:3596
#10 0x0000000000d1c86d in mysql_parse (thd=0x7fecc4070290, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#11 0x0000000000d1da95 in dispatch_command (thd=0x7fecc4070290, com_data=0x7fed0519eda0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#12 0x0000000000d1e944 in do_command (thd=0x7fecc4070290) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#13 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#14 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x2c05720) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#15 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#16 0x00007fef4525a9fd in clone () from /lib64/libc.so.6


Thread 35 (Thread 0x7fed04647700 (LWP 32677)):
#0  0x00007fef467a9e9d in nanosleep () from /lib64/libpthread.so.0
#1  0x00000000010c3dc0 in os_thread_sleep (tm=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/os/os0thread.cc:279
#2  0x0000000001159291 in srv_conc_enter_innodb_with_atomics (trx=0x7fef324b63d0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0conc.cc:213
#3  srv_conc_enter_innodb (prebuilt=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/srv/srv0conc.cc:257
#4  0x000000000104e735 in ha_innobase::write_row (this=0x7feca40364c0, record=0x7feca4013390 "\ap*") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:7595
#5  0x000000000081fe7b in handler::ha_write_row (this=0x7feca40364c0, buf=0x7feca4013390 "\ap*") at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/handler.cc:8062
#6  0x0000000000ea0427 in write_record (thd=0x7fecac04e4d0, table=0x7feca4003e70, info=0x7fed046454a0, update=0x7fed04645420) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:1873
#7  0x0000000000ea1892 in Sql_cmd_insert::mysql_insert (this=0x7fecac00cb18, thd=0x7fecac04e4d0, table_list=0x7fecac00bd08) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:769
#8  0x0000000000ea209a in Sql_cmd_insert::execute (this=0x7fecac00cb18, thd=0x7fecac04e4d0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_insert.cc:3118
#9  0x0000000000d1835c in mysql_execute_command (thd=0x7fecac04e4d0, first_level=true) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:3596
#10 0x0000000000d1c86d in mysql_parse (thd=0x7fecac04e4d0, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:5570
#11 0x0000000000d1da95 in dispatch_command (thd=0x7fecac04e4d0, com_data=0x7fed04646da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1484
#12 0x0000000000d1e944 in do_command (thd=0x7fecac04e4d0) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/sql_parse.cc:1025
#13 0x0000000000deffa4 in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
#14 0x0000000000fc8f64 in pfs_spawn_thread (arg=0x10a0ef70) at /export/home/pb2/build/sb_0-33648028-1555164244.06/mysql-5.7.26/storage/perfschema/pfs.cc:2190
#15 0x00007fef467a2ea5 in start_thread () from /lib64/libpthread.so.0
#16 0x00007fef4525a9fd in clone () from /lib64/libc.so.6