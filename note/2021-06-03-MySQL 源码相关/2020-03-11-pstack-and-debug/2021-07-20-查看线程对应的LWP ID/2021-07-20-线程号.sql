root@mysqldb 11:45:  [(none)]> select THREAD_ID,name,THREAD_OS_ID from performance_schema.threads where type = 'BACKGROUND';
+-----------+----------------------------------------+--------------+
| THREAD_ID | name                                   | THREAD_OS_ID |
+-----------+----------------------------------------+--------------+
|         1 | thread/sql/main                        |        13220 |
|         2 | thread/sql/thread_timer_notifier       |        13470 |
|         3 | thread/innodb/io_ibuf_thread           |        13689 |
|         4 | thread/innodb/io_log_thread            |        13690 |
|         5 | thread/innodb/io_read_thread           |        13691 |
|         6 | thread/innodb/io_read_thread           |        13692 |
|         7 | thread/innodb/io_read_thread           |        13693 |
|         8 | thread/innodb/io_read_thread           |        13694 |
|         9 | thread/innodb/io_read_thread           |        13695 |
|        10 | thread/innodb/io_read_thread           |        13696 |
|        11 | thread/innodb/io_read_thread           |        13697 |
|        12 | thread/innodb/io_read_thread           |        13698 |
|        13 | thread/innodb/io_write_thread          |        13699 |
|        14 | thread/innodb/io_write_thread          |        13700 |
|        15 | thread/innodb/io_write_thread          |        13701 |
|        16 | thread/innodb/io_write_thread          |        13702 |
|        17 | thread/innodb/io_write_thread          |        13704 |
|        18 | thread/innodb/io_write_thread          |        13705 |
|        19 | thread/innodb/io_write_thread          |        13706 |
|        20 | thread/innodb/page_cleaner_thread      |        13707 |
|        21 | thread/innodb/io_write_thread          |        13703 |
|        24 | thread/innodb/srv_lock_timeout_thread  |        14838 |
|        25 | thread/innodb/srv_error_monitor_thread |        14839 |
|        26 | thread/innodb/srv_monitor_thread       |        14840 |
|        27 | thread/innodb/srv_master_thread        |        14841 |
|        28 | thread/innodb/srv_worker_thread        |        14843 |
|        29 | thread/innodb/srv_purge_thread         |        14842 |
|        30 | thread/innodb/srv_worker_thread        |        14844 |
|        31 | thread/innodb/srv_worker_thread        |        14845 |
|        32 | thread/innodb/dict_stats_thread        |        14847 |
|        33 | thread/innodb/buf_dump_thread          |        14846 |
|        35 | thread/sql/signal_handler              |        14851 |
+-----------+----------------------------------------+--------------+
32 rows in set (0.00 sec)

root@mysqldb 11:47:  [(none)]> select a.thd_id,b.THREAD_OS_ID,a.user,b.TYPE from  sys.processlist a,performance_schema.threads  b where b.thread_id=a.thd_id;
+--------+--------------+---------------------------------+------------+
| thd_id | THREAD_OS_ID | user                            | TYPE       |
+--------+--------------+---------------------------------+------------+
|      1 |        13220 | sql/main                        | BACKGROUND |
|      2 |        13470 | sql/thread_timer_notifier       | BACKGROUND |
|      3 |        13689 | innodb/io_ibuf_thread           | BACKGROUND |
|      4 |        13690 | innodb/io_log_thread            | BACKGROUND |
|      5 |        13691 | innodb/io_read_thread           | BACKGROUND |
|      6 |        13692 | innodb/io_read_thread           | BACKGROUND |
|      7 |        13693 | innodb/io_read_thread           | BACKGROUND |
|      8 |        13694 | innodb/io_read_thread           | BACKGROUND |
|      9 |        13695 | innodb/io_read_thread           | BACKGROUND |
|     10 |        13696 | innodb/io_read_thread           | BACKGROUND |
|     11 |        13697 | innodb/io_read_thread           | BACKGROUND |
|     12 |        13698 | innodb/io_read_thread           | BACKGROUND |
|     13 |        13699 | innodb/io_write_thread          | BACKGROUND |
|     14 |        13700 | innodb/io_write_thread          | BACKGROUND |
|     15 |        13701 | innodb/io_write_thread          | BACKGROUND |
|     16 |        13702 | innodb/io_write_thread          | BACKGROUND |
|     17 |        13704 | innodb/io_write_thread          | BACKGROUND |
|     18 |        13705 | innodb/io_write_thread          | BACKGROUND |
|     19 |        13706 | innodb/io_write_thread          | BACKGROUND |
|     20 |        13707 | innodb/page_cleaner_thread      | BACKGROUND |
|     21 |        13703 | innodb/io_write_thread          | BACKGROUND |
|     24 |        14838 | innodb/srv_lock_timeout_thread  | BACKGROUND |
|     25 |        14839 | innodb/srv_error_monitor_thread | BACKGROUND |
|     26 |        14840 | innodb/srv_monitor_thread       | BACKGROUND |
|     27 |        14841 | innodb/srv_master_thread        | BACKGROUND |
|     28 |        14843 | innodb/srv_worker_thread        | BACKGROUND |
|     29 |        14842 | innodb/srv_purge_thread         | BACKGROUND |
|     30 |        14844 | innodb/srv_worker_thread        | BACKGROUND |
|     31 |        14845 | innodb/srv_worker_thread        | BACKGROUND |
|     32 |        14847 | innodb/dict_stats_thread        | BACKGROUND |
|     33 |        14846 | innodb/buf_dump_thread          | BACKGROUND |
|     34 |        14850 | sql/event_scheduler             | FOREGROUND |
|     35 |        14851 | sql/signal_handler              | BACKGROUND |
|     36 |        14852 | sql/compress_gtid_table         | FOREGROUND |      # MySQL中有一个单独的后台线程用来执行 gtid_executed表的压缩操作。


思考： 数据库重启后 THREAD_OS_ID 会变化吗
		会的，下面就是重启后的 THREAD_OS_ID 列表
		root@mysqldb 12:38:  [(none)]> select a.thd_id,b.THREAD_OS_ID,a.user,b.TYPE from  sys.processlist a,performance_schema.threads  b where b.thread_id=a.thd_id;
		+--------+--------------+---------------------------------+------------+
		| thd_id | THREAD_OS_ID | user                            | TYPE       |
		+--------+--------------+---------------------------------+------------+
		|      1 |        19765 | sql/main                        | BACKGROUND |
		|      2 |        19766 | sql/thread_timer_notifier       | BACKGROUND |
		|      3 |        19768 | innodb/io_log_thread            | BACKGROUND |
		|      4 |        19769 | innodb/io_read_thread           | BACKGROUND |
		|      5 |        19767 | innodb/io_ibuf_thread           | BACKGROUND |
		|      6 |        19770 | innodb/io_read_thread           | BACKGROUND |
		|      7 |        19771 | innodb/io_read_thread           | BACKGROUND |
		|      8 |        19772 | innodb/io_read_thread           | BACKGROUND |
		|      9 |        19773 | innodb/io_read_thread           | BACKGROUND |
		|     10 |        19774 | innodb/io_read_thread           | BACKGROUND |
		|     11 |        19775 | innodb/io_read_thread           | BACKGROUND |
		|     12 |        19776 | innodb/io_read_thread           | BACKGROUND |
		|     13 |        19777 | innodb/io_write_thread          | BACKGROUND |
		|     14 |        19778 | innodb/io_write_thread          | BACKGROUND |
		|     15 |        19779 | innodb/io_write_thread          | BACKGROUND |
		|     16 |        19780 | innodb/io_write_thread          | BACKGROUND |
		|     17 |        19781 | innodb/io_write_thread          | BACKGROUND |
		|     18 |        19782 | innodb/io_write_thread          | BACKGROUND |
		|     19 |        19783 | innodb/io_write_thread          | BACKGROUND |
		|     20 |        19784 | innodb/io_write_thread          | BACKGROUND |
		|     21 |        19785 | innodb/page_cleaner_thread      | BACKGROUND |
		|     23 |        19790 | innodb/srv_lock_timeout_thread  | BACKGROUND |
		|     24 |        19791 | innodb/srv_error_monitor_thread | BACKGROUND |
		|     25 |        19792 | innodb/srv_monitor_thread       | BACKGROUND |
		|     26 |        19793 | innodb/srv_master_thread        | BACKGROUND |
		|     27 |        19794 | innodb/srv_purge_thread         | BACKGROUND |
		|     28 |        19796 | innodb/srv_worker_thread        | BACKGROUND |
		|     29 |        19795 | innodb/srv_worker_thread        | BACKGROUND |
		|     30 |        19797 | innodb/srv_worker_thread        | BACKGROUND |
		|     31 |        19798 | innodb/buf_dump_thread          | BACKGROUND |
		|     32 |        19799 | innodb/dict_stats_thread        | BACKGROUND |
		|     33 |        19803 | sql/event_scheduler             | FOREGROUND |
		|     34 |        19804 | sql/signal_handler              | BACKGROUND |
		|     35 |        19805 | sql/compress_gtid_table         | FOREGROUND |
		|     36 |        19807 | liaodaiguo@39.108.193.40        | FOREGROUND |
		|     37 |        19808 | root@localhost                  | FOREGROUND |
		+--------+--------------+---------------------------------+------------+
		36 rows in set (0.09 sec)



