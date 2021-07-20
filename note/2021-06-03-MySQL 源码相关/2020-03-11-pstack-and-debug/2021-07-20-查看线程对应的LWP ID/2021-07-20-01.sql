
在5.7中我们已经可以通过MySQL语句和LWP ID进行对应了，这让性能诊断变得更加便捷。
这里的 THREAD_OS_ID 就是线程的LWP ID。

root@mysqldb 18:04:  [(none)]> select a.thd_id,b.THREAD_OS_ID,a.user,b.TYPE from  sys.processlist a,performance_schema.threads  b where b.thread_id=a.thd_id;
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
+--------+--------------+---------------------------------+------------+
34 rows in set (0.16 sec)
