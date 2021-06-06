

mysql> select version();
+------------+
| version()  |
+------------+
| 5.7.22-log |
+------------+
1 row in set (0.00 sec)

set global innodb_thread_concurrency=2;

CREATE TABLE `t` (
  `id` int(11) NOT NULL,
  `c` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

 insert into t values(1,1);

 pstack 2844 > 1629-pstack.log 


 session A                  session B                    session C                 session D             session E       
 select sleep(100) from t;  select sleep(100) from t;  
																			
														 select 1; 
														 (Query OK)
														 select * from t;
														 (blocked)
														 pstack 2844 > 1630-pstack.log 
														 pstack 2844 > 1631-pstack.log 
																											insert into t values(2,2);
																											pstack 2844 > 1632-pstack.log			
																		           show processlist;
																								   

root@mysqldb 12:01:  [db1]> show processlist;
+----+----------+--------------------+------+---------+------+--------------+--------------------------+
| Id | User     | Host               | db   | Command | Time | State        | Info                     |
+----+----------+--------------------+------+---------+------+--------------+--------------------------+
|  6 | app_user | 192.168.0.71:13751 | db1  | Sleep   |  113 |              | NULL                     |
|  7 | app_user | 192.168.0.71:13757 | db1  | Sleep   |  133 |              | NULL                     |
|  8 | app_user | 192.168.0.71:13794 | db1  | Sleep   |  109 |              | NULL                     |
|  9 | app_user | 192.168.0.71:13795 | db1  | Sleep   |  108 |              | NULL                     |
| 10 | root     | 192.168.0.54:40426 | db1  | Query   |   26 | User sleep   | select sleep(100) from t |
| 11 | root     | 192.168.0.54:40428 | db1  | Query   |    6 | Sending data | select * from t          |
| 12 | root     | 192.168.0.54:40430 | db1  | Query   |    0 | starting     | show processlist         |
| 13 | root     | 192.168.0.54:40432 | db1  | Query   |   30 | User sleep   | select sleep(100) from t |
+----+----------+--------------------+------+---------+------+--------------+--------------------------+
8 rows in set (0.00 sec)



分析：
	一共pstack了4次，如下：
		1629-pstack数据库异常之前-01.log
		1630-pstack数据库异常之后-02.log
		1631-pstack数据库异常之后-03.log
		0924-pstack数据库没有出现异常的情况-04.log
		
	通过对比 “1631-pstack数据库异常之后-03.log” 和 “0924-pstack数据库没有出现异常的情况-04.log” 并没有发现可疑线程栈；
	通过对比 “1630-pstack数据库异常之后-02.log” 和 “0924-pstack数据库没有出现异常的情况-04.log”
	分析可能出现的线程栈如下：
			
		Thread 4 (Thread 0x7f81184b4700 (LWP 29238)):
		#0  0x00007f82cd536f3d in nanosleep () from /lib64/libpthread.so.0
		#1  0x0000000000ffb7a0 in os_thread_sleep (tm=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/os/os0thread.cc:279
		#2  0x000000000108fea1 in srv_conc_enter_innodb_with_atomics (trx=0x7f82c138ecb0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0conc.cc:213
		#3  srv_conc_enter_innodb (prebuilt=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/srv/srv0conc.cc:257
		#4  0x0000000000f85e2c in ha_innobase::index_read (this=0x7f81040186c0, buf=0x7f81040189b0 "\377", key_ptr=<optimized out>, key_len=0, find_flag=HA_READ_AFTER_KEY) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/handler/ha_innodb.cc:8692
		#5  0x0000000000f73929 in ha_innobase::index_first (this=0x7f81040186c0, buf=0x7f81040189b0 "\377") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/handler/ha_innodb.cc:9125
		#6  0x0000000000f85b48 in ha_innobase::rnd_next (this=0x7f81040186c0, buf=0x7f81040189b0 "\377") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/innobase/handler/ha_innodb.cc:9223
		#7  0x000000000081a816 in handler::ha_rnd_next (this=0x7f81040186c0, buf=0x7f81040189b0 "\377") at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/handler.cc:2947
		#8  0x0000000000c7dbce in rr_sequential (info=0x7f8104010d88) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/records.cc:510
		#9  0x0000000000cead7a in sub_select (join=0x7f8104010658, qep_tab=0x7f8104010d38, end_of_records=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_executor.cc:1277
		#10 0x0000000000cea2ba in do_select (join=0x7f8104010658) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_executor.cc:950
		#11 JOIN::exec (this=0x7f8104010658) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_executor.cc:199
		#12 0x0000000000d54a10 in handle_query (thd=0x7f810400a560, lex=0x7f810400c6c8, result=0x7f8104010308, added_options=1, removed_options=0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_select.cc:184
		#13 0x0000000000d15353 in execute_sqlcom_select (thd=0x7f810400a560, all_tables=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:5156
		#14 0x0000000000d18bce in mysql_execute_command (thd=0x7f810400a560, first_level=true) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:2792
		#15 0x0000000000d1aaad in mysql_parse (thd=0x7f810400a560, parser_state=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:5582
		#16 0x0000000000d1bcca in dispatch_command (thd=0x7f810400a560, com_data=0x7f81184b3da0, command=COM_QUERY) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:1458
		#17 0x0000000000d1cb74 in do_command (thd=0x7f810400a560) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/sql_parse.cc:999
		#18 0x0000000000dedaec in handle_connection (arg=<optimized out>) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/sql/conn_handler/connection_handler_per_thread.cc:300
		#19 0x0000000001256a94 in pfs_spawn_thread (arg=0xee9d1a0) at /export/home/pb2/build/sb_0-27500212-1520171728.22/mysql-5.7.22/storage/perfschema/pfs.cc:2190
		#20 0x00007f82cd52fe25 in start_thread () from /lib64/libpthread.so.0
		#21 0x00007f82cbfe8bad in clone () from /lib64/libc.so.6
			
	
		然后找下面两个函数的源码：
			srv_conc_enter_innodb_with_atomics 和 srv_conc_enter_innodb
			
			在 /storage/innobase/srv/srv0conc.cc 目录文件下
			
				
		好了有了这些栈帧视乎发现一些共同点他们都处于 srv_conc_enter_innodb_with_atomics 函数下，本函数正是下面参数实现的方式(这里是怎么知道的？)：
			
			innodb_thread_concurrency
			innodb_concurrency_tickets
			所以我随即告诉他检查这两个参数，如果设置了可以尝试取消。过后数据库故障得到解决。
			
			mysql> show global variables like 'innodb_thread_concurrency';
			+---------------------------+-------+
			| Variable_name             | Value |
			+---------------------------+-------+
			| innodb_thread_concurrency | 2     |
			+---------------------------+-------+
			1 row in set (0.00 sec)
			
			
			
		/*********************************************************************//**
		如果并发线程太多，则让 OS 线程等待(>= srv_thread_concurrency) 在 InnoDB 中。 线程在 FIFO 队列中等待。

		Puts an OS thread to wait if there are too many concurrent threads
		(>= srv_thread_concurrency) inside InnoDB. The threads wait in a FIFO queue.
		@param[in,out]	prebuilt	row prebuilt handler */
		void
		srv_conc_enter_innodb(
			row_prebuilt_t*	prebuilt)
		{
			trx_t*	trx	= prebuilt->trx;

		#ifdef UNIV_DEBUG
			{
				btrsea_sync_check	check(trx->has_search_latch);

				ut_ad(!sync_check_iterate(check));
			}
		#endif /* UNIV_DEBUG */

			srv_conc_enter_innodb_with_atomics(trx);
		}
