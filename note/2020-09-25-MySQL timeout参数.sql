

mysql> select version();
+------------+
| version()  |
+------------+
| 5.7.22-log |
+------------+
1 row in set (0.00 sec)


timeout参数列表：
	mysql> show global variables like '%timeout%';
	+-----------------------------+----------+
	| Variable_name               | Value    |
	+-----------------------------+----------+
	| connect_timeout             | 10       |    --向数据库连接的超时时长
	| delayed_insert_timeout      | 300      |
	| have_statement_timeout      | YES      |
	| innodb_flush_log_at_timeout | 1        |    -- master线程刷写日志的频率。可以增大此参数设置来减少redo日志刷盘写次数，避免对binlog group commit带来影响。默认值是1.
	| innodb_lock_wait_timeout    | 10       |    --行锁超时时长
	| innodb_rollback_on_timeout  | ON       |    --如果这个参数为true，则当发生因为等待行锁而产生的超时时，回滚掉整个事务，否则只回滚当前的语句。这个就是隐式回滚机制。
	| interactive_timeout         | 31536000 |
	| lock_wait_timeout           | 3600     |    --锁的超时时长
	| net_read_timeout            | 30       |
	| net_write_timeout           | 60       |
	| rpl_stop_slave_timeout      | 31536000 |    --执行 stop slave; 命令没有关闭复制的超时时间
	| slave_net_timeout           | 60       |    --从库连接主库的超时时长
	| wait_timeout                | 31536000 |
	+-----------------------------+----------+
	13 rows in set (0.00 sec)



https://blog.csdn.net/u010027484/article/details/58585589  MySQL几个超时参数（timeout）解释

	1. connect_timeout

		mysql客户端在尝试与mysql服务器建立连接时，mysql服务器返回错误握手协议前等待客户端数据包的最大时限。默认10秒。


	2. interactive_timeout / wait_timeout

		mysql关闭交互/非交互连接前等待的最大时限。默认28800秒。


	3. lock_wait_timeout 

		sql语句请求元数据锁的最长等待时间，默认为一年。
		此锁超时对于隐式访问Mysql库中系统表的sql语句无效，但是对于使用select，update语句直接访问mysql库中标的sql语句有效。


	4. net_read_timeout / net_write_timeout

		mysql服务器端等待从客户端读取数据 / 向客户端写入数据的最大时限，默认30秒。


	5. slave_net_timeout

		mysql从复制连结等待读取数据的最大时限，默认3600秒。


https://www.cnblogs.com/xiaoboluo768/p/6222862.html  MySQL 各种超时参数的含义


rpl_stop_slave_timeout:

	正常的stop slave流程
		学习从库正常关闭做了哪些工作即 stop slave 命令发起后做了哪些工作
		在第23章节的学习中,我们知道单 SQL 线程会以 event 为单位进行应用,最前面有一层循环用于循环读取 event 并且应用, 响应 stop slave 正是在这个循环的判断条件中
		
		stop slave 命令是用户线程发起的, 需要作用于 SQL 线程和 IO 线程, IO 线程和 SQL 线程要达到判断点, 需要将上一个 event 处理完成再次循环的时候才能进行
		如果  IO 线程和 SQL 线程 没有正常终止, 那么用户线程执行的 stop slave 命令需要一直堵塞等待其完成, 参数 rpl_stop_slave_timeout 可以控制等待多久,虽然
		这个参数可以让用户线程退出, 但是实际 IO 线程 和 SQL 线程 的关闭操作可能还是没有完成, 它们依然在继续关闭
		
		通过 stop slave 命令正常的关闭从库一般不会有任何问题, 因为我们的重要信息都已经强制持久化了, 包含: slave_master_info 表 slave_relay_log_info 表 和 relay log
		在 MTS 中还会刷新 slave_worker_info 表和进行检查点
			
	-- 执行 stop slave; 命令，如果  IO 线程和 SQL 线程 没有正常终止, 那么用户线程执行的 stop slave 命令需要一直堵塞等待其完成， 参数 rpl_stop_slave_timeout 可以控制等待多久
	-- 总的来说就是执行 stop slave; 命令没有关闭复制的超时时间

innodb_flush_log_at_timeout:

	Write and flush the logs every N seconds. innodb_flush_log_at_timeout allows the timeout period between flushes to be increased in order to reduce flushing and avoid impacting performance of binary log group commit. The default setting for innodb_flush_log_at_timeout is once per second.
	每N秒写入和刷新日志一次。 innodb_flush_log_at_timeout允许增加两次刷新之间的超时时间，以减少刷新并避免影响二进制日志组提交的性能。 innodb_flush_log_at_timeout的默认设置是每秒一次。

	master线程刷写日志的频率。可以增大此参数设置来减少redo日志刷盘写次数，避免对binlog group commit带来影响。默认值是1.
	
	
	https://blog.csdn.net/sun_ashe/article/details/81319520   innodb_flush_log_at_timeout
	
	http://www.xuchanggang.cn/archives/567.html    mysql 5.6 新特性中，自定义刷新日志时间：innodb_flush_log_at_timeout
		innodb_flush_log_at_trx_commit这个参数一般都是 1，这样的话，innodb_flush_log_at_timeout 的设置对其就不起作用。innodb_flush_log_at_timeout 的设置只针对 innodb_flush_log_at_trx_commit为0/2 起作用
		所以，此参数可暂时不做研究！
		
	https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_flush_log_at_timeout

