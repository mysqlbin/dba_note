
监控全表扫描的sql语句
select * from sys.statements_with_full_table_scans;



1. 大部分连接来自哪里及发送的SQL情况:
select host,current_connections,statements from sys.host_summary;

2. 统计各个用户线程的连接数:
select user, count(*) from sys.`session` group by user;

3. 哪张表的IO最多？哪张表访问次数最多

select * from sys.io_global_by_file_by_bytes limit 10;

4. 机器执行最多的SQL语句是什么样?
select * from sys.statement_analysis order by exec_count desc limit 10\G;

5. 哪些语句延迟比较严重?

statement_analysis中avg_latency的最高的。(参考上面写法)
SQL语句：
select * from sys.statement_analysis order by avg_latency desc limit 10;

6. 哪些SQL语句使用了磁盘临时表?
select db, query, tmp_tables, tmp_disk_tables, tmp_tables+tmp_disk_tables as tmp_all from sys.statement_analysis where tmp_tables>0 or tmp_disk_tables >0 order by tmp_all desc limit 20;

select db, query, tmp_tables, tmp_disk_tables, tmp_tables+tmp_disk_tables as tmp_all from sys.statement_analysis where tmp_disk_tables >0 order by tmp_all desc limit 20;



10. MySQL内部现在有多个线程在运行?
select `user`, count(*) from `sys`.`processlist` group by `user`;

11. MySQL 数据库中哪些索引是冗余的、哪些索引是从未使用过的？
使用sys.schema_redundant_indexes和sys.schema_unused_indexes视图

内存相关：
	1. 哪张表占用了最多的buffer pool?
	select * from sys.innodb_buffer_stats_by_table order by pages desc limit 10;

	2. 每个库占用多少buffer pool
	select * from sys.innodb_buffer_stats_by_schema;

	3. 每个连接分配多少内存?
	select b.user, current_count_used, current_allocated, current_avg_alloc, current_max_alloc, total_allocated,current_statement from sys.memory_by_thread_by_current_bytes a, sys.session b where a.thread_id = b.thd_id;


参考：
	https://mp.weixin.qq.com/s/_Q12Xd8czL3BcVPWOlOmRA    （会话和锁信息查询视图 | 全方位认识 sys 系统库）
	https://mp.weixin.qq.com/s/3QA3Y-zmtX2AJxKg-SyEEA        （网易这样用sys schema优雅提升MySQL易用性）
	https://mp.weixin.qq.com/s/Hd-A4ymK-XkYImbRXfrw_Q          (专栏 | MySQL 5.7系列之sys schema(2) by吴炳锡)
	https://mp.weixin.qq.com/s/lq3oJYO_r0Ba455gi3SFvA            (内存分配统计视图 | 全方位认识 sys 系统库)
	https://mp.weixin.qq.com/s/lQ4N8pNgSVnL-TfcUZeTlw           (按 file 分组统计视图 | 全方位认识 sys 系统库)


mysql> select host,current_connections,statements from sys.host_summary;
+--------------+---------------------+------------+
| host         | current_connections | statements |
+--------------+---------------------+------------+
| 192.168.1.10 |                   0 |      39348 |
| 192.168.1.11 |                   6 |   46959241 |
| 192.168.1.12 |                  22 | 1560459328 |
| 192.168.1.13 |                  10 |     844310 |
| 192.168.1.14 |                   3 |     437579 |
| 192.168.1.15 |                   6 |   73503633 |
| 192.168.1.17 |                  24 |   11561692 |
| 192.168.1.18 |                  27 |   11568203 |
| 192.168.1.19 |                  39 |    4699125 |
| 192.168.1.21 |                   0 |       4446 |
| 192.168.1.30 |                   6 |    1147700 |
| 192.168.1.31 |                   6 |    1514085 |
| 192.168.1.32 |                   6 |    1171010 |
| 192.168.1.33 |                   6 |    2321640 |
| 192.168.1.34 |                   3 |     972313 |
| 192.168.1.35 |                   0 |     228303 |
| 192.168.1.36 |                   0 |     201627 |
| localhost    |                   3 |  683805608 |
+--------------+---------------------+------------+
18 rows in set (0.11 sec)



mysql> select `user`, count(*) from `sys`.`processlist` group by `user`;
+---------------------------------+----------+
| user                            | count(*) |
+---------------------------------+----------+
| apph9_user@192.168.1.12         |       22 |
| apph9_user@192.168.1.13         |       10 |
| apph9_user@192.168.1.14         |        3 |
| apph9_user@192.168.1.15         |        6 |
| apph9_user@192.168.1.17         |       24 |
| apph9_user@192.168.1.18         |       27 |
| apph9_user@192.168.1.19         |       39 |
| apph9_user@192.168.1.30         |        6 |
| apph9_user@192.168.1.31         |        6 |
| apph9_user@192.168.1.32         |        6 |
| apph9_user@192.168.1.33         |        6 |
| apph9_user@192.168.1.34         |        3 |
| innodb/buf_dump_thread          |        1 |
| innodb/dict_stats_thread        |        1 |
| innodb/io_ibuf_thread           |        1 |
| innodb/io_log_thread            |        1 |
| innodb/io_read_thread           |        4 |
| innodb/io_write_thread          |        4 |
| innodb/page_cleaner_thread      |        1 |
| innodb/srv_error_monitor_thread |        1 |
| innodb/srv_lock_timeout_thread  |        1 |
| innodb/srv_master_thread        |        1 |
| innodb/srv_monitor_thread       |        1 |
| innodb/srv_purge_thread         |        1 |
| innodb/srv_worker_thread        |        3 |
| repl_monitor_user@192.168.1.11  |        6 |
| root@localhost                  |        1 |
| sql/compress_gtid_table         |        1 |
| sql/event_scheduler             |        1 |
| sql/main                        |        1 |
| sql/signal_handler              |        1 |
| sql/slave_io                    |        1 |
| sql/slave_sql                   |        1 |
| sql/thread_timer_notifier       |        1 |
+---------------------------------+----------+
34 rows in set (1.06 sec)


mysql> select * from sys.io_global_by_file_by_bytes limit 10;
+----------------------------------------------------------+------------+------------+-----------+-------------+---------------+-----------+------------+-----------+
| file                                                     | count_read | total_read | avg_read  | count_write | total_written | avg_write | total      | write_pct |
+----------------------------------------------------------+------------+------------+-----------+-------------+---------------+-----------+------------+-----------+
| @@datadir/ibdata1                                        |      15223 | 239.88 MiB | 16.14 KiB |   504341758 | 26.16 TiB     | 55.70 KiB | 26.16 TiB  |    100.00 |
| @@datadir/niuniuh9_db/table_clublogplatformscore.ibd     |     315833 | 4.82 GiB   | 16.00 KiB |    67070224 | 1023.41 GiB   | 16.00 KiB | 1.00 TiB   |     99.53 |
| @@datadir/ib_logfile0                                    |          5 | 4.00 KiB   | 819 bytes |   388360704 | 941.12 GiB    | 2.54 KiB  | 941.12 GiB |    100.00 |
| @@datadir/ib_logfile1                                    |          2 | 64.50 KiB  | 32.25 KiB |   370783201 | 930.80 GiB    | 2.63 KiB  | 930.80 GiB |    100.00 |
| @@datadir/niuniuh9_db/table_clubgamescorerobotdetail.ibd |    1895978 | 28.93 GiB  | 16.00 KiB |    48896003 | 746.09 GiB    | 16.00 KiB | 775.02 GiB |     96.27 |
| @@datadir/niuniuh9_db/table_clubmember.ibd               |       1712 | 26.75 MiB  | 16.00 KiB |    40553357 | 618.80 GiB    | 16.00 KiB | 618.82 GiB |    100.00 |
| @@datadir/niuniuh9_db/table_clubgamescoredetail.ibd      |     341658 | 5.21 GiB   | 16.00 KiB |    36671604 | 559.56 GiB    | 16.00 KiB | 564.78 GiB |     99.08 |
| @@datadir/niuniuh9_db/table_third_order.ibd              |      23878 | 373.09 MiB | 16.00 KiB |    21786206 | 332.43 GiB    | 16.00 KiB | 332.80 GiB |     99.89 |
| @@datadir/niuniuh9_db/table_third_token.ibd              |        186 | 2.91 MiB   | 16.00 KiB |    13717603 | 209.31 GiB    | 16.00 KiB | 209.32 GiB |    100.00 |
| @@datadir/niuniuh9_db/table_club_task_player_data.ibd    |       7091 | 110.80 MiB | 16.00 KiB |     5688300 | 86.80 GiB     | 16.00 KiB | 86.90 GiB  |     99.88 |
+----------------------------------------------------------+------------+------------+-----------+-------------+---------------+-----------+------------+-----------+
10 rows in set (0.02 sec)

