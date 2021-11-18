

mysql> select * from information_schema.innodb_trx\G;
*************************** 1. row ***************************
                    trx_id: 71898423
                 trx_state: RUNNING
               trx_started: 2021-11-18 11:53:11
     trx_requested_lock_id: NULL
          trx_wait_started: NULL
                trx_weight: 0
       trx_mysql_thread_id: 126
                 trx_query: alter table sbtest.sbtest1 add index k_1(`k`)
       trx_operation_state: reading clustered index
         trx_tables_in_use: 1
         trx_tables_locked: 0
          trx_lock_structs: 0
     trx_lock_memory_bytes: 1136
           trx_rows_locked: 0
         trx_rows_modified: 0
   trx_concurrency_tickets: 0
       trx_isolation_level: READ COMMITTED
         trx_unique_checks: 1
    trx_foreign_key_checks: 1
trx_last_foreign_key_error: NULL
 trx_adaptive_hash_latched: 0
 trx_adaptive_hash_timeout: 0
          trx_is_read_only: 0
trx_autocommit_non_locking: 0
1 row in set (0.00 sec)




环境：
	主机相关配置: 4核CPU、16GB内存、100GB的SSD盘
	MySQL相关：
		mysql_version: oracle mysql-5.7.26
		innodb_buffer_pool_size=8GB
		innodb_flush_log_at_trx_commit=1
		sync_binlog=1
		innodb_adaptive_hash_index=ON

数据表为sysbench标准化表结构：
	CREATE TABLE `sbtest1` (
	  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	  `k` int(10) unsigned NOT NULL DEFAULT '0',
	  `c` char(120) NOT NULL DEFAULT '',
	  `pad` char(60) NOT NULL DEFAULT '',
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
		
生成表的行数：13亿行记录



add index 耗时
	mysql> alter table sbtest.sbtest1 add index k_1(`k`);
	Query OK, 0 rows affected (19 min 46.24 sec)
	Records: 0  Duplicates: 0  Warnings: 0

期间的IO利用率
	
	shell> iostat -dmx 1
	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	sda               0.00     0.00  213.00    4.00    48.17     1.00   464.07     8.70   35.58   36.18    3.50   4.40  95.50

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	sda               0.00     0.00  240.00    8.00    47.86     2.00   411.74     6.72   32.47   33.42    4.00   3.46  85.80

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	sda               0.00     0.00  220.00    4.00    48.09     1.00   448.86     8.19   35.66   36.24    3.50   4.19  93.80

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	sda               0.00     0.00  245.00    4.00    47.92     1.00   402.38     7.18   29.73   30.16    3.50   3.97  98.90

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	sda               0.00     0.00  229.00    4.00    48.11     1.00   431.66     8.95   37.42   38.01    3.75   4.01  93.40

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	sda               0.00     0.00  216.00    8.00    47.91     2.00   456.29     8.95   40.82   42.19    3.62   3.98  89.20

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	sda               0.00     0.00  232.00    4.00    48.16     1.00   426.58     5.78   24.67   25.01    5.25   4.03  95.10

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	sda               0.00     0.00  237.00    4.00    47.86     1.00   415.20     7.61   30.70   31.14    4.50   3.87  93.20

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	sda               0.00     0.00  220.00    4.00    47.95     1.00   447.57     5.97   27.55   27.99    3.50   4.25  95.10

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	sda               0.00     0.00  230.00    8.00    48.00     2.00   430.25     7.45   31.24   32.20    3.62   3.98  94.70

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	sda               0.00     0.00  228.00    4.00    47.95     1.00   432.14     7.58   32.62   33.13    3.75   3.99  92.60

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	sda               0.00     0.00  245.00    4.00    48.17     1.00   404.43     6.71   27.04   27.41    4.00   3.71  92.40

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	sda               0.00     0.00  230.00    4.00    47.91     1.00   428.03     6.91   29.65   30.10    3.50   3.95  92.40

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	sda               0.00     0.00  263.00    8.00    48.05     2.00   378.21     4.26   15.41   15.78    3.00   3.21  87.10

八怪师兄，有空了帮忙看看我这篇文章写得有哪里不对
有空了再看，不急的
感谢


drop index 的耗时
	-- 第一次执行
	mysql> alter table sbtest1 drop index k_1;
	Query OK, 0 rows affected (2.35 sec)
	Records: 0  Duplicates: 0  Warnings: 0
	
	-- 第二次执行
	-- 先 add index k_1(`k`) 再 drop index k_1
	mysql> alter table sbtest1 drop index k_1;
	Query OK, 0 rows affected (0.12 sec)
	Records: 0  Duplicates: 0  Warnings: 0
	
		
		