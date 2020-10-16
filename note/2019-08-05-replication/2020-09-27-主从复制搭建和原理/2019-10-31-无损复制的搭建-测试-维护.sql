
实践：配置5.7增强半同步
1.安装相关的插件
	1.1 master上安装
	1.2 slave上安装
	1.3 主库相关系统变量
	1.4 从库相关系统变量
2. 启用半同步复制
	2.1  master 修改相关参数
	2.2 slave 修改相关参数
	2.3 重启从库上的I/O线程
	2.4 查看半同步是否在运行
3. 监控半同步复制

4. 测试
	4.1 正常提交事务
	4.3 退化为异步复制: 从库不开 slave IO和SQL线程, 在主库DML超时后, 会退化为异步复制
	4.4 从库重新开启 slave IO和SQL线程, 在主库DML后, 异步复制会回到半同步复制

5. 小结

	
1.安装相关的插件
	show plugins;  查看现在加载了什么模块
   （如果是MHA之类要做主从切换的环境，主从两端都把增强半同步master和slave模块都安装和开启，以便切换）
   （卸载方法：help uninstall; 查看卸载模块）
	
	1.1 master上安装
		mysql> install plugin rpl_semi_sync_master soname 'semisync_master.so';
		mysql> install plugin rpl_semi_sync_slave soname 'semisync_slave.so';
		检查主库相关系统变量的初始值：
			mysql> show variables like '%semi%';
			+-------------------------------------------+------------+
			| Variable_name                             | Value      |
			+-------------------------------------------+------------+
			| rpl_semi_sync_master_enabled              | OFF        |
			| rpl_semi_sync_master_timeout              | 10000      |
			| rpl_semi_sync_master_trace_level          | 32         |
			| rpl_semi_sync_master_wait_for_slave_count | 1          |
			| rpl_semi_sync_master_wait_no_slave        | ON         |
			| rpl_semi_sync_master_wait_point           | AFTER_SYNC |
			| rpl_semi_sync_slave_enabled               | OFF        |
			| rpl_semi_sync_slave_trace_level           | 32         |
			+-------------------------------------------+------------+
			8 rows in set (0.00 sec)
		
	1.2 slave上安装
		mysql> install plugin rpl_semi_sync_master soname 'semisync_master.so';
		mysql> install plugin rpl_semi_sync_slave soname 'semisync_slave.so';
		检查从库相关系统变量的初始值：
			mysql> show variables like '%semi%';
			+-------------------------------------------+------------+
			| Variable_name                             | Value      |
			+-------------------------------------------+------------+
			| rpl_semi_sync_master_enabled              | OFF        |
			| rpl_semi_sync_master_timeout              | 10000      |
			| rpl_semi_sync_master_trace_level          | 32         |
			| rpl_semi_sync_master_wait_for_slave_count | 1          |
			| rpl_semi_sync_master_wait_no_slave        | ON         |
			| rpl_semi_sync_master_wait_point           | AFTER_SYNC |
			| rpl_semi_sync_slave_enabled               | OFF        |
			| rpl_semi_sync_slave_trace_level           | 32         |
			+-------------------------------------------+------------+
			8 rows in set (0.00 sec)	
		
	1.3 主库相关系统变量

		rpl_semi_sync_master_enabled ：主库是否启用了半同步复制，默认为OFF。
		rpl_semi_sync_master_timeout ：等待从库的ACK回复的超时时间，默认为10秒， 如果不让半同步复制退化为异常复制，可以把这个值设置为无穷大。尽快恢复slave与master的通信，否则master将处于不可用状态
		rpl_semi_sync_master_trace_level ：半同步复制时主库的调试级别。
		rpl_semi_sync_master_wait_for_slave_count ：
			主库在超时时间内需要收到多少个ACK回复才认为此次提交成功，否则就降级为异步复制。
			该变量在MySQL 5.7.3才提供，在此之前的版本都默认为收到1个ACK则确认成功，且不可更改。MySQL 5.7.3之后该变量的默认值也是1。
		rpl_semi_sync_master_wait_no_slave ：
			默认值为ON，当状态变量 Rpl_semi_sync_master_clients 中的值小于 rpl_semi_sync_master_wait_for_slave_count 时， Rpl_semi_sync_master_status 依旧为ON，
			只有当事务提交后等待 rpl_semi_sync_master_timeout 超时后，Rpl_semi_sync_master_status 才会变为OFF，即降级为异步复制；
			为OFF时，当状态变量 Rpl_semi_sync_master_clients 中的值小于 rpl_semi_sync_master_wait_for_slave_count 时， Rpl_semi_sync_master_status 立即显示为OFF，即立即降级为异步复制。
			
		rpl_semi_sync_master_wait_point ：
			控制主库上commit、接收ack、返回消息给客户端的时间点。值为 AFTER_SYNC 或 AFTER_COMMIT。
			该选项是MySQL5.7.2后引入的，默认值为 AFTER_SYNC。此版本之前，等价于使用了 AFTER_COMMIT 模式。
		
	1.4 从库相关系统变量
		rpl_semi_sync_slave_enabled ：从库是否开启半同步复制。
		rpl_semi_sync_slave_trace_level ：从库的调试级别。	
	
2. 启用半同步复制
	2.1  master 修改相关参数
		mysql> set global rpl_semi_sync_master_enabled=1;                                # 默认为 0, 也就是OFF
		mysql> set global rpl_semi_sync_master_timeout=1000;                             # 设置等待从库回应的时间
		mysql> set global rpl_semi_sync_master_wait_point=AFTER_SYNC;                    # 默认就是AFTER_SYNC，发现这里AFTER_SYNC加不加''都可以
		mysql> set global rpl_semi_sync_master_wait_for_slave_count=1;                   # 默认就是1
		写到配置文件my.cnf里:
			[mysqld]
			rpl_semi_sync_master_enabled = 1 
			rpl_semi_sync_master_timeout = 1000 
			rpl_semi_sync_master_wait_point='AFTER_SYNC'                    
			rpl_semi_sync_master_wait_for_slave_count=1 
		
	2.2 slave 修改相关参数
		
		mysql>set global rpl_semi_sync_slave_enabled=1;               
		也可以写到配置文件my.cnf里
			[mysqld]
			rpl_semi_sync_slave_enabled = 1
		

	2.3 重启从库上的I/O线程
		stop slave io_thread;
		start slave io_thread;
	
	2.4 查看半同步是否在运行
		
		-- 主
			mysql> show status like 'Rpl_semi_sync_master_status';
			+-----------------------------+-------+
			| Variable_name               | Value |
			+-----------------------------+-------+
			| Rpl_semi_sync_master_status | ON    |
			+-----------------------------+-------+
			1 row in set (0.00 sec)
			
		-- 从
		mysql> show status like 'Rpl_semi_sync_slave_status';
			+----------------------------+-------+
			| Variable_name              | Value |
			+----------------------------+-------+
			| Rpl_semi_sync_slave_status | ON    |
			+----------------------------+-------+
			1 row in set (0.00 sec)

		
	
3. 监控半同步复制
	-- 主
	mysql>  show status like 'rpl_semi_sync_master%';
	+--------------------------------------------+-------+
	| Variable_name                              | Value |
	+--------------------------------------------+-------+
	| Rpl_semi_sync_master_clients               | 1     |
	| Rpl_semi_sync_master_net_avg_wait_time     | 0     |
	| Rpl_semi_sync_master_net_wait_time         | 0     |
	| Rpl_semi_sync_master_net_waits             | 0     |
	| Rpl_semi_sync_master_no_times              | 0     |
	| Rpl_semi_sync_master_no_tx                 | 0     |
	| Rpl_semi_sync_master_status                | ON    |
	| Rpl_semi_sync_master_timefunc_failures     | 0     |
	| Rpl_semi_sync_master_tx_avg_wait_time      | 0     |
	| Rpl_semi_sync_master_tx_wait_time          | 0     |
	| Rpl_semi_sync_master_tx_waits              | 0     |
	| Rpl_semi_sync_master_wait_pos_backtraverse | 0     |
	| Rpl_semi_sync_master_wait_sessions         | 0     |
	| Rpl_semi_sync_master_yes_tx                | 0     |
	+--------------------------------------------+-------+
	14 rows in set (0.00 sec)
	
	--从
	mysql>  show status like 'rpl_semi_sync_slave%';
	+----------------------------+-------+
	| Variable_name              | Value |
	+----------------------------+-------+
	| Rpl_semi_sync_slave_status | ON    |
	+----------------------------+-------+
	1 row in set (0.00 sec)

	
	主库有14个半同步复制相关的状态变量：
		Rpl_semi_sync_master_clients                有多少个Semi-sync的备库即 半同步从库的数量。
		Rpl_semi_sync_master_net_avg_wait_time      事务提交后，等待备库响应的平均时间
		Rpl_semi_sync_master_net_wait_time          等待网络响应的总次数
		Rpl_semi_sync_master_net_waits              主库等待从库回复的总次数
		Rpl_semi_sync_master_no_times               一共有几次从Semi-sync跌回普通状态
		Rpl_semi_sync_master_no_tx                  表示异步复制的事务数，该值如果变化了，那么也需要检查半同步复制是否已经退化为异步复制，在退化时从error log也可以看到
		Rpl_semi_sync_master_status                 主库上Semi-sync是否正常开启
		Rpl_semi_sync_master_timefunc_failures      时间函数未正常工作的次数
		Rpl_semi_sync_master_tx_avg_wait_time       开启Semi-sync，事务返回需要等待的平均时间
		Rpl_semi_sync_master_tx_wait_time           事务等待备库响应的总时间
		Rpl_semi_sync_master_tx_waits               事务等待备库响应的总次数
		Rpl_semi_sync_master_wait_pos_backtraverse  改变当前等待最小二进制日志的次数
		Rpl_semi_sync_master_wait_sessions          当前有几个线程在等备库响应
		Rpl_semi_sync_master_yes_tx                 Semi-sync模式下，从库成功确认的事务数
	
	
	从库上只有一个半同步复制相关的状态变量 Rpl_semi_sync_slave_status 为ON时表示从库使用半同步复制，OFF表示从库使用异步复制。
	
4. 测试
	4.1 正常提交事务
		--主
			mysql> create database test;
			Query OK, 1 row affected (0.00 sec)

			mysql> use test;
			Database changed
			mysql> create table test.t1 (a int) engine=innodb;
			Query OK, 0 rows affected (0.05 sec)

			mysql> insert into t1 values(1);
			Query OK, 1 row affected (0.01 sec)
			
			mysql> show status like 'rpl_semi_sync_master%';
			+--------------------------------------------+-------+
			| Variable_name                              | Value |
			+--------------------------------------------+-------+
			| Rpl_semi_sync_master_clients               | 1     |
			| Rpl_semi_sync_master_net_avg_wait_time     | 0     |
			| Rpl_semi_sync_master_net_wait_time         | 0     |
			| Rpl_semi_sync_master_net_waits             | 3     |
			| Rpl_semi_sync_master_no_times              | 0     |
			| Rpl_semi_sync_master_no_tx                 | 0     |
			| Rpl_semi_sync_master_status                | ON    |
			| Rpl_semi_sync_master_timefunc_failures     | 0     |
			| Rpl_semi_sync_master_tx_avg_wait_time      | 596   |
			| Rpl_semi_sync_master_tx_wait_time          | 1790  |
			| Rpl_semi_sync_master_tx_waits              | 3     |
			| Rpl_semi_sync_master_wait_pos_backtraverse | 0     |
			| Rpl_semi_sync_master_wait_sessions         | 0     |
			| Rpl_semi_sync_master_yes_tx                | 3     |
			+--------------------------------------------+-------+
			14 rows in set (0.00 sec)
			
			Rpl_semi_sync_master_net_waits=3: 表示主库等待3个事务的确认，分别对应create database、create table、insert语句。
			平均每个事务等待596微妙，从库正常确认了3个事务。
			
		--从
			mysql> select * from test.t1;
			+------+
			| a    |
			+------+
			|    1 |
			+------+
			1 row in set (0.00 sec)
			
	4.2 回滚事务	
		
		mysql> start transaction;
		Query OK, 0 rows affected (0.00 sec)
		 
		mysql> insert into t1 values(2);                  -- 向事务表插入记录
		Query OK, 1 row affected (0.00 sec)
		 
		mysql> create table t2 (a int) engine=myisam;     -- 执行一个DDL语句，创建非事务表t2
		Query OK, 0 rows affected (0.01 sec)
		 
		mysql> insert into t1 values(3);                  -- 向事务表插入记录
		Query OK, 1 row affected (0.00 sec)
		 
		mysql> insert into t2 values(3);                  -- 向非事务表插入记录
		Query OK, 1 row affected (0.01 sec)
		 
		mysql> rollback;

		
		mysql> select * from t1;
		+------+
		| a    |
		+------+
		|    1 |
		|    2 |
		|    3 |
		+------+
		3 rows in set (0.00 sec)

		mysql> select * from t2;
		+------+
		| a    |
		+------+
		|    3 |
		+------+
		1 row in set (0.00 sec)

		mysql> show status like 'rpl_semi_sync_master%';
		+--------------------------------------------+-------+
		| Variable_name                              | Value |
		+--------------------------------------------+-------+
		| Rpl_semi_sync_master_clients               | 1     |
		| Rpl_semi_sync_master_net_avg_wait_time     | 0     |
		| Rpl_semi_sync_master_net_wait_time         | 0     |
		| Rpl_semi_sync_master_net_waits             | 15    |
		| Rpl_semi_sync_master_no_times              | 0     |
		| Rpl_semi_sync_master_no_tx                 | 0     |
		| Rpl_semi_sync_master_status                | ON    |
		| Rpl_semi_sync_master_timefunc_failures     | 0     |
		| Rpl_semi_sync_master_tx_avg_wait_time      | 634   |
		| Rpl_semi_sync_master_tx_wait_time          | 9518  |
		| Rpl_semi_sync_master_tx_waits              | 15    |
		| Rpl_semi_sync_master_wait_pos_backtraverse | 0     |
		| Rpl_semi_sync_master_wait_sessions         | 0     |
		| Rpl_semi_sync_master_yes_tx                | 15    |
		+--------------------------------------------+-------+
		14 rows in set (0.00 sec)

		--从
		mysql> select * from t1;
		+------+
		| a    |
		+------+
		|    1 |
		|    2 |
		|    3 |
		+------+
		3 rows in set (0.00 sec)

		mysql> select * from t2;
		+------+
		| a    |
		+------+
		|    3 |
		+------+
		1 row in set (0.00 sec)

		DDL语句会触发一个commit，自动提交DDL语句本身及其前面未提交的事务。
		非事务表不能回滚。
	
	4.3 退化为异步复制: 从库不开 slave IO和SQL线程, 在主库DML超时后, 会退化为异步复制
		
		mysql> show variables like '%semi%';
		+-------------------------------------------+------------+
		| Variable_name                             | Value      |
		+-------------------------------------------+------------+
		| rpl_semi_sync_master_enabled              | ON         |
		| rpl_semi_sync_master_timeout              | 3000       |
		| rpl_semi_sync_master_trace_level          | 32         |
		| rpl_semi_sync_master_wait_for_slave_count | 1          |
		| rpl_semi_sync_master_wait_no_slave        | ON         |
		| rpl_semi_sync_master_wait_point           | AFTER_SYNC |
		| rpl_semi_sync_slave_enabled               | OFF        |
		| rpl_semi_sync_slave_trace_level           | 32         |
		+-------------------------------------------+------------+
		8 rows in set (0.00 sec)
		
		
		mysql> show status like 'rpl_semi_sync_master%';
		+--------------------------------------------+-------+
		| Variable_name                              | Value |
		+--------------------------------------------+-------+
		| Rpl_semi_sync_master_clients               | 1     |
		| Rpl_semi_sync_master_net_avg_wait_time     | 0     |
		| Rpl_semi_sync_master_net_wait_time         | 0     |
		| Rpl_semi_sync_master_net_waits             | 23    |
		| Rpl_semi_sync_master_no_times              | 2     |
		| Rpl_semi_sync_master_no_tx                 | 7     |
		| Rpl_semi_sync_master_status                | ON    |
		| Rpl_semi_sync_master_timefunc_failures     | 0     |
		| Rpl_semi_sync_master_tx_avg_wait_time      | 602   |
		| Rpl_semi_sync_master_tx_wait_time          | 12654 |
		| Rpl_semi_sync_master_tx_waits              | 21    |
		| Rpl_semi_sync_master_wait_pos_backtraverse | 0     |
		| Rpl_semi_sync_master_wait_sessions         | 0     |
		| Rpl_semi_sync_master_yes_tx                | 21    |
		+--------------------------------------------+-------+
		14 rows in set (0.00 sec)

		
		slave:	
			mysql> stop slave;
			Query OK, 0 rows affected (0.01 sec)

			mysql> show slave status\G;
			*************************** 1. row ***************************

						 Slave_IO_Running: No
						Slave_SQL_Running: No

			1 row in set (0.01 sec)
			
		查看主库的错误日志:
			2019-10-31T16:22:13.196596+08:00 294935 [Note] Stop semi-sync binlog_dump to slave (server_id: 6)
			2019-10-31T16:22:13.196664+08:00 294935 [Note] Aborted connection 294935 to db: 'unconnected' user: 'repl_user' host: '11.111.11.11' (failed on flush_net())
			2019-10-31T16:22:21.173598+08:00 294928 [Warning] Timeout waiting for reply of binlog (file: mysql-bin.000356, pos: 209582766), semi-sync up to file mysql-bin.000356, position 209582513.
			2019-10-31T16:22:21.173632+08:00 294928 [Note] Semi-sync replication switched OFF
			
			说明已经退化为异步复制.
			
			
		master:		
			
		mysql> insert into t1 values(9);
													mysql> show processlist;
													+--------+-----------------+---------------------+------+-------------+-------+---------------------------------------------------------------+--------------------------+
													| Id     | User            | Host                | db   | Command     | Time  | State                                                         | Info                     |
													+--------+-----------------+---------------------+------+-------------+-------+---------------------------------------------------------------+--------------------------+
													| 294928 | root            | 11.111.11.11:6532   | test | Query       |     1 | Waiting for semi-sync ACK from slave                          | insert into t1 values(9) |
										
			Query OK, 1 row affected (3.01 sec)

		
		
		mysql> show variables like '%semi%';
		+-------------------------------------------+------------+
		| Variable_name                             | Value      |
		+-------------------------------------------+------------+
		| rpl_semi_sync_master_enabled              | ON         |
		| rpl_semi_sync_master_timeout              | 3000       |
		| rpl_semi_sync_master_trace_level          | 32         |
		| rpl_semi_sync_master_wait_for_slave_count | 1          |
		| rpl_semi_sync_master_wait_no_slave        | ON         |
		| rpl_semi_sync_master_wait_point           | AFTER_SYNC |
		| rpl_semi_sync_slave_enabled               | OFF        |
		| rpl_semi_sync_slave_trace_level           | 32         |
		+-------------------------------------------+------------+
		8 rows in set (0.00 sec)
	
		mysql> show status like 'rpl_semi_sync_master%';
		+--------------------------------------------+-------+
		| Variable_name                              | Value |
		+--------------------------------------------+-------+
		| Rpl_semi_sync_master_clients               | 0     |
		| Rpl_semi_sync_master_net_avg_wait_time     | 0     |
		| Rpl_semi_sync_master_net_wait_time         | 0     |
		| Rpl_semi_sync_master_net_waits             | 23    |
		| Rpl_semi_sync_master_no_times              | 3     |
		| Rpl_semi_sync_master_no_tx                 | 8     |
		| Rpl_semi_sync_master_status                | OFF   |
		| Rpl_semi_sync_master_timefunc_failures     | 0     |
		| Rpl_semi_sync_master_tx_avg_wait_time      | 602   |
		| Rpl_semi_sync_master_tx_wait_time          | 12654 |
		| Rpl_semi_sync_master_tx_waits              | 21    |
		| Rpl_semi_sync_master_wait_pos_backtraverse | 0     |
		| Rpl_semi_sync_master_wait_sessions         | 0     |
		| Rpl_semi_sync_master_yes_tx                | 21    |
		+--------------------------------------------+-------+
		14 rows in set (0.00 sec)
		
		rpl_semi_sync_master_wait_no_slave ：
			默认值为ON，当状态变量 Rpl_semi_sync_master_clients(为0) 中的值小于 rpl_semi_sync_master_wait_for_slave_count(为1) 时， Rpl_semi_sync_master_status 依旧为ON，
			只有当事务提交后等待 rpl_semi_sync_master_timeout 超时后， Rpl_semi_sync_master_status 才会变为OFF，即降级为异步复制；
			为OFF时，当状态变量 Rpl_semi_sync_master_clients 中的值小于 rpl_semi_sync_master_wait_for_slave_count 时，Rpl_semi_sync_master_status 立即显示为OFF，即立即降级为异步复制。
			(通过实现和观察验证了这一观点)
			
		Rpl_semi_sync_master_no_tx 被从7改为8: 表示异步复制的事务数，该值如果变化了，那么也需要检查半同步复制是否已经退化为异步复制，在退化时从error log也可以看到

		当退化为异步复制之后, 再往主库写入数据, 不会再触发 事务提交后等待 rpl_semi_sync_master_timeout 超时:
			mysql> insert into t1 values(9);
			Query OK, 1 row affected (0.00 sec)

			mysql> mysql> insert into t1 values(9);
			Query OK, 1 row affected (0.01 sec)

		
	4.4 从库重新开启 slave IO和SQL线程, 在主库DML后, 异步复制会回到半同步复制

		slave:	
			mysql> start slave;
			Query OK, 0 rows affected (0.01 sec)

			mysql> show slave status\G;
			*************************** 1. row ***************************

						 Slave_IO_Running: Yes
						Slave_SQL_Running: Yes

			1 row in set (0.01 sec)
			
		master: 	
			insert into t1 values(9);
			insert into t1 values(10);
			
		mysql> show status like 'rpl_semi_sync_master%';
		+--------------------------------------------+-------+
		| Variable_name                              | Value |
		+--------------------------------------------+-------+
		| Rpl_semi_sync_master_clients               | 1     |
		| Rpl_semi_sync_master_net_avg_wait_time     | 0     |
		| Rpl_semi_sync_master_net_wait_time         | 0     |
		| Rpl_semi_sync_master_net_waits             | 22    |
		| Rpl_semi_sync_master_no_times              | 1     |
		| Rpl_semi_sync_master_no_tx                 | 6     |
		| Rpl_semi_sync_master_status                | ON    |
		| Rpl_semi_sync_master_timefunc_failures     | 0     |
		| Rpl_semi_sync_master_tx_avg_wait_time      | 602   |
		| Rpl_semi_sync_master_tx_wait_time          | 12654 |
		| Rpl_semi_sync_master_tx_waits              | 21    |
		| Rpl_semi_sync_master_wait_pos_backtraverse | 0     |
		| Rpl_semi_sync_master_wait_sessions         | 0     |
		| Rpl_semi_sync_master_yes_tx                | 21    |
		+--------------------------------------------+-------+
		14 rows in set (0.01 sec)

		在主库执行完成两个事务之后, Rpl_semi_sync_master_no_tx 还是 为6(没有变化), 说明已经回归到 无损(全半同步/增强半同步)复制


5. 小结
	在增强半同步的架构下，退化为异步复制的时机:
		
		总的来说就是:
			rpl_semi_sync_master_wait_no_slave = ON
				
				当状态变量 Rpl_semi_sync_master_clients 中的值小于 rpl_semi_sync_master_wait_for_slave_count 时, 并且  事务提交后等待 rpl_semi_sync_master_timeout 超时后，Rpl_semi_sync_master_status 才会变为OFF，即降级为异步复制；
				
				翻译过来就是:
					有多少个Semi-sync的备库(1个从库停止之后, Rpl_semi_sync_master_clients的值会减1) 小于 需要多少个从库发送 ack 回复, 并且  事务提交后等待超时后, 就会降级为异步复制.
					
			rpl_semi_sync_master_wait_no_slave = OFF
				当状态变量 Rpl_semi_sync_master_clients 中的值小于 rpl_semi_sync_master_wait_for_slave_count 时， Rpl_semi_sync_master_status 立即显示为OFF，即立即降级为异步复制。

			
		参考:
			Rpl_semi_sync_master_clients                有多少个Semi-sync的备库
			
			rpl_semi_sync_master_wait_for_slave_count ：
				主库在超时时间内需要收到多少个ACK回复才认为此次提交成功，否则就降级为异步复制。
				该变量在MySQL 5.7.3才提供，在此之前的版本都默认为收到1个ACK则确认成功，且不可更改。MySQL 5.7.3之后该变量的默认值也是1。
			rpl_semi_sync_master_wait_no_slave ：
				默认值为ON，当状态变量 Rpl_semi_sync_master_clients 中的值小于 rpl_semi_sync_master_wait_for_slave_count 时， Rpl_semi_sync_master_status 依旧为ON，
					只有当事务提交后等待 rpl_semi_sync_master_timeout 超时后，Rpl_semi_sync_master_status 才会变为OFF，即降级为异步复制；
				为OFF时，当状态变量 Rpl_semi_sync_master_clients 中的值小于 rpl_semi_sync_master_wait_for_slave_count 时， Rpl_semi_sync_master_status 立即显示为OFF，即立即降级为异步复制。
				(通过实现和观察验证了这一观点)
			
		
		
	如果出现增强半同步下并且不允许退化为异步复制的情况下，可以让数据库还是处在等待状态(rpl_semi_sync_master_timeout参数设置为无穷大)，尽快恢复slave与master的通信，否则master将处于不可用状态.
	
	
	
