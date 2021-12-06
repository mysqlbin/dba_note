

配置信息介绍
名称 				版本
Port 				6379
Config file 		/data/redis/6379/conf/redis.conf
Log file 			/data/redis/6379/data/redis_6379.log
Data dir 			/data/redis/6379/data
Executable 			/usr/local/bin/redis-server
Cli Executable 	    /usr/local/bin/redis-cli


Redis主从环境
	hostname    主机IP         Role     Version
	redis01     192.168.0.111  Master   4.0.9
	redis02     192.168.0.112  Slave    4.0.9  
	redis03     192.168.0.113  Slave    4.0.9  

	
修改配置文件

	redis 主从复制配置起来还是比较简单的，master 上只需要修改 bind 的 ip，没有其他特殊配置。	
	Master的Bind
		bind 192.168.0.111 127.0.0.1 

	Slave的Bind
		bind 192.168.0.112 127.0.0.1 
		
	Slave的Bind
		bind 192.168.0.113 127.0.0.1
		
		
要从库执行 slaveof 命令:		
	[root@redis02 src]# redis-cli -h 192.168.0.112
	192.168.0.112:6379> slaveof 192.168.0.111 6379
	
	从库与主库进行了一次完全重新同步的日志:

		6316:S 11 Nov 14:45:45.882 * Before turning into a slave, using my master parameters to synthesize a cached master: I may be able to synchronize with the new master with just a partial transfer.
		6316:S 11 Nov 14:45:45.882 * SLAVE OF 192.168.0.111:6379 enabled (user request from 'id=3 addr=192.168.0.112:47586 fd=9 name= age=36 idle=0 flags=N db=0 sub=0 psub=0 multi=-1 qbuf=0 qbuf-free=32768 obl=0 oll=0 omem=0 events=r cmd=slaveof')
		6316:S 11 Nov 14:45:45.917 * Connecting to MASTER 192.168.0.111:6379
		6316:S 11 Nov 14:45:45.918 * MASTER <-> SLAVE sync started
		6316:S 11 Nov 14:45:45.918 * Non blocking connect for SYNC fired the event.
		6316:S 11 Nov 14:45:45.919 * Master replied to PING, replication can continue...
		6316:S 11 Nov 14:45:45.920 * Trying a partial resynchronization (request 0e99498c08a427c0899b97273470403e66528020:1).
		6316:S 11 Nov 14:45:45.923 * Full resync from master: 7f53e96e4f2076c05c7727f3442461da9f4289ee:0
		6316:S 11 Nov 14:45:45.924 * Discarding previously cached master state.
		6316:S 11 Nov 14:45:45.994 * MASTER <-> SLAVE sync: receiving 175 bytes from master
		6316:S 11 Nov 14:45:45.994 * MASTER <-> SLAVE sync: Flushing old data
		6316:S 11 Nov 14:45:45.996 * MASTER <-> SLAVE sync: Loading DB in memory
		6316:S 11 Nov 14:45:45.997 * MASTER <-> SLAVE sync: Finished with success
		6316:S 11 Nov 14:45:45.997 * Background append only file rewriting started by pid 14723
		6316:S 11 Nov 14:45:46.024 * AOF rewrite child asks to stop sending diffs.
		14723:C 11 Nov 14:45:46.024 * Parent agreed to stop sending diffs. Finalizing AOF...
		14723:C 11 Nov 14:45:46.024 * Concatenating 0.00 MB of AOF diff received from parent.
		14723:C 11 Nov 14:45:46.026 * SYNC append only file rewrite performed
		14723:C 11 Nov 14:45:46.026 * AOF rewrite: 6 MB of memory used by copy-on-write
		6316:S 11 Nov 14:45:46.120 * Background AOF rewrite terminated with success
		6316:S 11 Nov 14:45:46.120 * Residual parent diff successfully flushed to the rewritten AOF (0.00 MB)
		6316:S 11 Nov 14:45:46.120 * Background AOF rewrite finished successfully
		
	主库的日志:
		5052:M 11 Nov 14:54:11.527 * Slave 192.168.0.112:6379 asks for synchronization
		5052:M 11 Nov 14:54:11.527 * Partial resynchronization not accepted: Replication ID mismatch (Slave asked for '0e99498c08a427c0899b97273470403e66528020', my replication IDs are 'b19f1d7225353c9dd2d31a1e66e9ca0ad4071a90' and '0000000000000000000000000000000000000000')
		5052:M 11 Nov 14:54:11.528 * Starting BGSAVE for SYNC with target: disk
		5052:M 11 Nov 14:54:11.529 * Background saving started by pid 5063
		5063:C 11 Nov 14:54:11.534 * DB saved on disk
		5063:C 11 Nov 14:54:11.535 * RDB: 6 MB of memory used by copy-on-write
		5052:M 11 Nov 14:54:11.601 * Background saving terminated with success
		5052:M 11 Nov 14:54:11.601 * Synchronization with slave 192.168.0.112:6379 succeeded

通过 info replication命令来检查是否成功地建立了复制关系:
	在主库查看复制信息:	
		192.168.0.112:6379> info replication
		# Replication
		role:slave
		master_host:192.168.0.111
		master_port:6379
		master_link_status:up
		master_last_io_seconds_ago:3
		master_sync_in_progress:0
		slave_repl_offset:126
		slave_priority:100
		slave_read_only:1
		connected_slaves:0
		master_replid:7f53e96e4f2076c05c7727f3442461da9f4289ee
		master_replid2:0000000000000000000000000000000000000000
		master_repl_offset:126
		second_repl_offset:-1
		repl_backlog_active:1
		repl_backlog_size:1048576
		repl_backlog_first_byte_offset:1
		repl_backlog_histlen:126


	在从库查看复制信息:	
		192.168.0.111:6379> info replication
		# Replication
		role:master
		connected_slaves:1
		slave0:ip=192.168.0.112,port=6379,state=online,offset=140,lag=0
		master_replid:7f53e96e4f2076c05c7727f3442461da9f4289ee
		master_replid2:0000000000000000000000000000000000000000
		master_repl_offset:140
		second_repl_offset:-1
		repl_backlog_active:1
		repl_backlog_size:1048576
		repl_backlog_first_byte_offset:1
		repl_backlog_histlen:140


主从数据测试:

	在主实例上, 创建一个新的键
		192.168.0.111:6379> set "new_key" "value"
		OK
	
		主库日志:
			5052:M 11 Nov 15:14:24.309 * 1 changes in 900 seconds. Saving...
			5052:M 11 Nov 15:14:24.310 * Background saving started by pid 5078
			5078:C 11 Nov 15:14:24.315 * DB saved on disk
			5078:C 11 Nov 15:14:24.315 * RDB: 6 MB of memory used by copy-on-write
			5052:M 11 Nov 15:14:24.410 * Background saving terminated with success
		从库日志:
			6316:S 11 Nov 15:05:58.751 * 1 changes in 900 seconds. Saving...
			6316:S 11 Nov 15:05:58.752 * Background saving started by pid 15716
			15716:C 11 Nov 15:05:58.757 * DB saved on disk
			15716:C 11 Nov 15:05:58.758 * RDB: 6 MB of memory used by copy-on-write
			6316:S 11 Nov 15:05:58.853 * Background saving terminated with success
		
	在从实例, 尝试获取新键的值	
		192.168.0.112:6379> get "new_key"
		"value"
		
	在从实例上, 尝试创建一个新的键
		192.168.0.112:6379> set "new_key2" "value2"
		(error) READONLY You can t write against a read only slave.
		
	关闭从实例
		192.168.0.112:6379> shutdown save
		
		
		主库日志:	
			5052:M 11 Nov 15:14:24.309 * 1 changes in 900 seconds. Saving...
			5052:M 11 Nov 15:14:24.310 * Background saving started by pid 5078
			5078:C 11 Nov 15:14:24.315 * DB saved on disk
			5078:C 11 Nov 15:14:24.315 * RDB: 6 MB of memory used by copy-on-write
			5052:M 11 Nov 15:14:24.410 * Background saving terminated with success
			5052:M 11 Nov 15:17:44.598 # Connection with slave 192.168.0.112:6379 lost.

		从库日志:
			6316:S 11 Nov 15:09:18.985 # User requested shutdown...
			6316:S 11 Nov 15:09:18.985 * Calling fsync() on the AOF file.
			6316:S 11 Nov 15:09:18.987 * Saving the final RDB snapshot before exiting.
			6316:S 11 Nov 15:09:18.990 * DB saved on disk
			6316:S 11 Nov 15:09:18.990 * Removing the pid file.
			6316:S 11 Nov 15:09:18.991 # Redis is now ready to exit, bye bye...
		
	在主实例上, 创建另一个新的键
		192.168.0.111:6379> set "new_key3" "value3"
		OK
	
	重启从实例
		redis-server /data/redis/6379/conf/redis.conf
	
		查看从库日志:
			16057:C 11 Nov 15:13:01.232 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
			16057:C 11 Nov 15:13:01.232 # Redis version=4.0.9, bits=64, commit=00000000, modified=0, pid=16057, just started
			16057:C 11 Nov 15:13:01.232 # Configuration loaded
			16058:M 11 Nov 15:13:01.236 * Increased maximum number of open files to 10032 (it was originally set to 1024).
							_._                                                  
					   _.-``__ ''-._                                             
				  _.-``    `.  `_.  ''-._           Redis 4.0.9 (00000000/0) 64 bit
			  .-`` .-```.  ```\/    _.,_ ''-._                                   
			 (    '      ,       .-`  | `,    )     Running in standalone mode
			 |`-._`-...-` __...-.``-._|'` _.-'|     Port: 6379
			 |    `-._   `._    /     _.-'    |     PID: 16058
			  `-._    `-._  `-./  _.-'    _.-'                                   
			 |`-._`-._    `-.__.-'    _.-'_.-'|                                  
			 |    `-._`-._        _.-'_.-'    |           http://redis.io        
			  `-._    `-._`-.__.-'_.-'    _.-'                                   
			 |`-._`-._    `-.__.-'    _.-'_.-'|                                  
			 |    `-._`-._        _.-'_.-'    |                                  
			  `-._    `-._`-.__.-'_.-'    _.-'                                   
				  `-._    `-.__.-'    _.-'                                       
					  `-._        _.-'                                           
						  `-.__.-'                                               

			16058:M 11 Nov 15:13:01.238 # WARNING: The TCP backlog setting of 511 cannot be enforced because /proc/sys/net/core/somaxconn is set to the lower value of 128.
			16058:M 11 Nov 15:13:01.238 # Server initialized
			16058:M 11 Nov 15:13:01.238 # WARNING overcommit_memory is set to 0! Background save may fail under low memory condition. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
			16058:M 11 Nov 15:13:01.238 # WARNING you have Transparent Huge Pages (THP) support enabled in your kernel. This will create latency and memory usage issues with Redis. To fix this issue run the command 'echo never > /sys/kernel/mm/transparent_hugepage/enabled' as root, and add it to your /etc/rc.local in order to retain the setting after a reboot. Redis must be restarted after THP is disabled.
			16058:M 11 Nov 15:13:01.238 * DB loaded from append only file: 0.000 seconds
			16058:M 11 Nov 15:13:01.238 * Ready to accept connections
		
		检查从实例上是否存在 new_key3:
			192.168.0.112:6379> get "new_key3"
			(nil)
		
		
		进入部分重新同步失败:
			现象: 关闭从实例->在主实例上, 创建另一个新的键->重启从实例, 数据并没有同步到从实例
			原因: slaveof 192.168.0.111 6379 命令没有写入配置文件中.
			
			解决办法:
				在从实例重新执行 slaveof 192.168.0.111 6379命令并写入配置文件中
				
				192.168.0.112:6379> slaveof 192.168.0.111 6379
				OK

				主库日志:				
					5052:M 11 Nov 15:46:46.846 * Slave 192.168.0.112:6379 asks for synchronization
					5052:M 11 Nov 15:46:46.846 * Partial resynchronization not accepted: Replication ID mismatch (Slave asked for 'd062ce47bf0efd734851d51490a416dc5388f815', my replication IDs are '7f53e96e4f2076c05c7727f3442461da9f4289ee' and '0000000000000000000000000000000000000000')
					5052:M 11 Nov 15:46:46.846 * Starting BGSAVE for SYNC with target: disk
					5052:M 11 Nov 15:46:46.847 * Background saving started by pid 5083
					5083:C 11 Nov 15:46:46.861 * DB saved on disk
					5083:C 11 Nov 15:46:46.866 * RDB: 6 MB of memory used by copy-on-write
					5052:M 11 Nov 15:46:46.873 * Background saving terminated with success
					5052:M 11 Nov 15:46:46.873 * Synchronization with slave 192.168.0.112:6379 succeeded

				从库日志:			
					16058:S 11 Nov 15:38:20.730 * Before turning into a slave, using my master parameters to synthesize a cached master: I may be able to synchronize with the new master with just a partial transfer.
					16058:S 11 Nov 15:38:20.730 * SLAVE OF 192.168.0.111:6379 enabled (user request from 'id=4 addr=192.168.0.112:47594 fd=9 name= age=836 idle=0 flags=N db=0 sub=0 psub=0 multi=-1 qbuf=0 qbuf-free=32768 obl=0 oll=0 omem=0 events=r cmd=slaveof')
					16058:S 11 Nov 15:38:21.236 * Connecting to MASTER 192.168.0.111:6379
					16058:S 11 Nov 15:38:21.236 * MASTER <-> SLAVE sync started
					16058:S 11 Nov 15:38:21.237 * Non blocking connect for SYNC fired the event.
					16058:S 11 Nov 15:38:21.237 * Master replied to PING, replication can continue...
					16058:S 11 Nov 15:38:21.239 * Trying a partial resynchronization (request d062ce47bf0efd734851d51490a416dc5388f815:1).
					16058:S 11 Nov 15:38:21.241 * Full resync from master: 7f53e96e4f2076c05c7727f3442461da9f4289ee:2112
					16058:S 11 Nov 15:38:21.242 * Discarding previously cached master state.
					16058:S 11 Nov 15:38:21.267 * MASTER <-> SLAVE sync: receiving 230 bytes from master
					16058:S 11 Nov 15:38:21.267 * MASTER <-> SLAVE sync: Flushing old data
					16058:S 11 Nov 15:38:21.268 * MASTER <-> SLAVE sync: Loading DB in memory
					16058:S 11 Nov 15:38:21.268 * MASTER <-> SLAVE sync: Finished with success
					16058:S 11 Nov 15:38:21.269 * Background append only file rewriting started by pid 17311
					16058:S 11 Nov 15:38:21.297 * AOF rewrite child asks to stop sending diffs.
					17311:C 11 Nov 15:38:21.297 * Parent agreed to stop sending diffs. Finalizing AOF...
					17311:C 11 Nov 15:38:21.297 * Concatenating 0.00 MB of AOF diff received from parent.
					17311:C 11 Nov 15:38:21.298 * SYNC append only file rewrite performed
					17311:C 11 Nov 15:38:21.299 * AOF rewrite: 6 MB of memory used by copy-on-write
					16058:S 11 Nov 15:38:21.336 * Background AOF rewrite terminated with success
					16058:S 11 Nov 15:38:21.336 * Residual parent diff successfully flushed to the rewritten AOF (0.00 MB)
					16058:S 11 Nov 15:38:21.336 * Background AOF rewrite finished successfully
				
				查看主实例的数据是否同步从实例中:
					192.168.0.112:6379> get "new_key3"
					"value3"
					192.168.0.112:6379> get "new_key4"
					"value4"

				
思考

	1. 是否可以在线做主从?
		答: 可以.

	2. 如果终止从库跟主库之前的复制?
		
	3. 设置密码如何做主从复制
		已解决
	

	同步错误：
		27939:S 14 Nov 19:28:31.653 * Connecting to MASTER 192.168.0.113:6379
		27939:S 14 Nov 19:28:31.654 * MASTER <-> SLAVE sync started
		27939:S 14 Nov 19:28:31.654 * Non blocking connect for SYNC fired the event.
		27939:S 14 Nov 19:28:31.655 * Master replied to PING, replication can continue...
		27939:S 14 Nov 19:28:31.656 # Unable to AUTH to MASTER: -ERR Client sent AUTH, but no password is set

		解决办法： 
			1. 在主实例执行命令： config set requirepass "123456"
			2. 修改配置文件：
				#requirepass foobared
				去掉前面的注释，并修改为所需要的密码：
				requirepass myPassword （其中myPassword就是要设置的密码）

				
			

	
	