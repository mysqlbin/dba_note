

1. 线程简介
2. pid、lwp id、thread id
3. 如何将MySQL的线程和LWP ID进行对应
4. 相关参考

1. 线程简介
	我们知道 MySQLD 是一个单进程多线程的用户程序，因此我们有必要了解一下什么是线程。
	实际上 MySQL 中的线程都是 POSIX 线程，比如我们的会话线程、DUMP线程、IO 线程以及其他一些 InnoDB 线程都是 POSIX 线程。
	进程实际上就是运行中的程序，一个进程中可以包含多个线程也可以只包含一个线程。
	在Linux中线程也叫轻量级进程（ light-weight process ）简称为 LWP ，进程的第一个线程通常称为主控线程。
	进程: 是内存分配的最小单位
	线程: 是CPU调度的最小单位，也就是说如果CPU有足够多核，那么多个线程可以达到并行处理的效果，内核直接调度线程。
	
	
2. pid、lwp id、thread id

	PID：       内核分配，用于识别各个进程的ID。这个应该是大家最熟悉的。
	LWP ID：    内核分配，用于识别各个线程的ID，它就像是线程是‘PID’一样。同一个进程下的所有线程有相同的PID，但是LWP ID却不一样，主控线程的LWP ID就是进程PID。
	Thread TID：  进程内部用于识别各个线程的内部ID，这个ID用得不多。

	
3. 如何将MySQL的线程和LWP ID进行对应

	在5.7中我们已经可以通过MySQL语句和LWP ID进行对应了，这让性能诊断变得更加便捷。
	
	
	select a.thd_id,b.THREAD_OS_ID,a.user,b.TYPE from  sys.processlist a,performance_schema.threads  b where b.thread_id=a.thd_id;


	root@mysqldb 12:08:  [(none)]> select a.thd_id,b.THREAD_OS_ID,a.user,b.TYPE from  sys.processlist a,performance_schema.threads  b where b.thread_id=a.thd_id;
	ERROR 1104 (42000): The SELECT would examine more than MAX_JOIN_SIZE rows; check your WHERE and use SET SQL_BIG_SELECTS=1 or SET MAX_JOIN_SIZE=# if the SELECT is okay

	root@mysqldb 12:08:  [(none)]> set MAX_JOIN_SIZE = 100000000;
	Query OK, 0 rows affected (0.00 sec)
	root@mysqldb 12:11:  [(none)]> select a.thd_id,b.THREAD_OS_ID,a.user,b.TYPE from  sys.processlist a,performance_schema.threads  b where b.thread_id=a.thd_id;
	ERROR 1104 (42000): The SELECT would examine more than MAX_JOIN_SIZE rows; check your WHERE and use SET SQL_BIG_SELECTS=1 or SET MAX_JOIN_SIZE=# if the SELECT is okay

	root@mysqldb 12:11:  [(none)]> SET SQL_BIG_SELECTS=1;
	Query OK, 0 rows affected (0.00 sec)

	root@mysqldb 12:11:  [(none)]> select a.thd_id,b.THREAD_OS_ID,a.user,b.TYPE from  sys.processlist a,performance_schema.threads  b where b.thread_id=a.thd_id;
	+--------+--------------+---------------------------------+------------+
	| thd_id | THREAD_OS_ID | user                            | TYPE       |
	+--------+--------------+---------------------------------+------------+
	|      1 |        19542 | sql/main                        | BACKGROUND |
	|      2 |        19543 | sql/thread_timer_notifier       | BACKGROUND |
	|      3 |        19544 | innodb/io_ibuf_thread           | BACKGROUND |
	|      4 |        19545 | innodb/io_log_thread            | BACKGROUND |
	|      5 |        19546 | innodb/io_read_thread           | BACKGROUND |
	|      6 |        19547 | innodb/io_read_thread           | BACKGROUND |
	|      7 |        19548 | innodb/io_read_thread           | BACKGROUND |
	|      8 |        19549 | innodb/io_read_thread           | BACKGROUND |
	|      9 |        19550 | innodb/io_read_thread           | BACKGROUND |
	|     10 |        19551 | innodb/io_read_thread           | BACKGROUND |
	|     11 |        19552 | innodb/io_read_thread           | BACKGROUND |
	|     12 |        19553 | innodb/io_read_thread           | BACKGROUND |
	|     13 |        19554 | innodb/io_write_thread          | BACKGROUND |
	|     14 |        19555 | innodb/io_write_thread          | BACKGROUND |
	|     15 |        19556 | innodb/io_write_thread          | BACKGROUND |
	|     16 |        19557 | innodb/io_write_thread          | BACKGROUND |
	|     17 |        19558 | innodb/io_write_thread          | BACKGROUND |
	|     18 |        19559 | innodb/io_write_thread          | BACKGROUND |
	|     19 |        19560 | innodb/io_write_thread          | BACKGROUND |
	|     20 |        19561 | innodb/io_write_thread          | BACKGROUND |
	|     21 |        19562 | innodb/page_cleaner_thread      | BACKGROUND |
	|     23 |        19567 | innodb/srv_lock_timeout_thread  | BACKGROUND |
	|     24 |        19568 | innodb/srv_error_monitor_thread | BACKGROUND |
	|     25 |        19569 | innodb/srv_monitor_thread       | BACKGROUND |
	|     26 |        19570 | innodb/srv_master_thread        | BACKGROUND |
	|     27 |        19572 | innodb/srv_worker_thread        | BACKGROUND |
	|     28 |        19571 | innodb/srv_purge_thread         | BACKGROUND |
	|     29 |        19573 | innodb/srv_worker_thread        | BACKGROUND |
	|     30 |        19574 | innodb/srv_worker_thread        | BACKGROUND |
	|     31 |        19575 | innodb/buf_dump_thread          | BACKGROUND |
	|     32 |        19576 | innodb/dict_stats_thread        | BACKGROUND |
	|     33 |        19579 | sql/event_scheduler             | FOREGROUND |
	|     34 |        19580 | sql/signal_handler              | BACKGROUND |
	|     35 |        19581 | sql/compress_gtid_table         | FOREGROUND |
	........................................................................
	+--------+--------------+---------------------------------+------------+
	118 rows in set (0.90 sec)
	
	
	这里的 THREAD_OS_ID 就是线程的LWP ID。然后我们使用刚才的 ps -eLlf 命令再看一下，如下：
	
	[root@voice ~]# ps -eLlf|grep mysql
	0 S root      8864  8825  8864  0    1  80   0 - 28162 pipe_w 14:35 pts/0    00:00:00 grep --color=auto mysql
	4 S root     18146     1 18146  0    1  80   0 - 28312 wait   Mar02 ?        00:00:00 /bin/sh /usr/local/mysql/bin/mysqld_safe --datadir=/mydata/mysql/mysql3306/data --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid
	4 S mysql    19542 18146 19542  0  139  80   0 - 1516278 poll_s Mar02 ?      00:00:00 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19543  0  139  80   0 - 1516278 sigtim Mar02 ?      00:00:00 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19544  0  139  80   0 - 1516278 read_e Mar02 ?      00:00:26 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19545  0  139  80   0 - 1516278 read_e Mar02 ?      00:00:29 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19546  0  139  80   0 - 1516278 read_e Mar02 ?      00:00:27 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19547  0  139  80   0 - 1516278 read_e Mar02 ?      00:00:27 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19548  0  139  80   0 - 1516278 read_e Mar02 ?      00:00:26 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19549  0  139  80   0 - 1516278 read_e Mar02 ?      00:00:26 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19550  0  139  80   0 - 1516278 read_e Mar02 ?      00:00:25 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19551  0  139  80   0 - 1516278 read_e Mar02 ?      00:00:26 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19552  0  139  80   0 - 1516278 read_e Mar02 ?      00:00:25 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19553  0  139  80   0 - 1516278 read_e Mar02 ?      00:00:25 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19554  0  139  80   0 - 1516278 read_e Mar02 ?      00:00:26 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19555  0  139  80   0 - 1516278 read_e Mar02 ?      00:00:26 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19556  0  139  80   0 - 1516278 read_e Mar02 ?      00:00:25 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19557  0  139  80   0 - 1516278 read_e Mar02 ?      00:00:27 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19558  0  139  80   0 - 1516278 read_e Mar02 ?      00:00:28 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19559  0  139  80   0 - 1516278 read_e Mar02 ?      00:00:28 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19560  0  139  80   0 - 1516278 read_e Mar02 ?      00:00:29 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19561  0  139  80   0 - 1516278 read_e Mar02 ?      00:00:27 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19562  0  139  80   0 - 1516278 futex_ Mar02 ?      00:00:30 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19563  0  139  80   0 - 1516278 futex_ Mar02 ?      00:00:01 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19567  0  139  80   0 - 1516278 futex_ Mar02 ?      00:00:18 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19568  0  139  80   0 - 1516278 futex_ Mar02 ?      00:01:10 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19569  0  139  80   0 - 1516278 futex_ Mar02 ?      00:00:15 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19570  0  139  80   0 - 1516278 hrtime Mar02 ?      00:00:44 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19571  0  139  80   0 - 1516278 futex_ Mar02 ?      00:00:01 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19572  0  139  80   0 - 1516278 futex_ Mar02 ?      00:00:00 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19573  0  139  80   0 - 1516278 futex_ Mar02 ?      00:00:00 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19574  0  139  80   0 - 1516278 futex_ Mar02 ?      00:00:00 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19575  0  139  80   0 - 1516278 futex_ Mar02 ?      00:00:00 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19576  0  139  80   0 - 1516278 futex_ Mar02 ?      00:00:02 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19577  0  139  80   0 - 1516278 futex_ Mar02 ?      00:00:03 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19578  0  139  80   0 - 1516278 futex_ Mar02 ?      00:00:00 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19579  0  139  80   0 - 1516278 futex_ Mar02 ?      00:00:00 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19580  0  139  80   0 - 1516278 sigtim Mar02 ?      00:00:00 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/tmp/mysql3306.sock --port=3306
	1 S mysql    19542 18146 19581  0  139  80   0 - 1516278 futex_ Mar02 ?      00:00:00 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data 


4. 相关参考

	https://mp.weixin.qq.com/s/Lrx-YYYWtHHaxLfY_UZ8GQ  玩转MySQL 8.0源码编译

	https://mp.weixin.qq.com/s/Ov-mw-crQ6-UdBCobOUZ-A  线程简介和MySQL调试环境搭建

	https://blog.51cto.com/hzde0128/2299593     mysql-5.7.23源码编译安装

	
	
