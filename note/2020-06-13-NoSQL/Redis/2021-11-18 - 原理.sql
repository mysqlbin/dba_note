

主从原理:
	1. 执行 slaveof 命令跟主库建立连接
	2. 连接成功之后, 从数据库向主数据库发送 sync (同步)命令。
	3. 主数据库接收 sync (同步)命令后，执行 bgsave 命令（保存快照），把数据备份到RDB文件，在创建RDB文件期间的命令(增量数据)将保存在缓冲区中。
	4. 当主数据库执行完bgsave时，会向从数据库发送RDB文件，
	5. 从服务器收到快照文件后丢弃自己的所有旧数据，载入收到的快照   Flushing old data(会清空当前从服务器的所有数据), Loading DB in memory
	6. 主数据库将缓冲区的所有写命令发给从服务器执行。
	7. 以上处理完之后，之后主数据库每执行一个写命令，都会将被执行的写命令发送给从数据库。

	从库的日志:
		第一步:
		执行 slaveof 命令跟主库建立连接
		6316:S 11 Nov 14:45:45.882 * SLAVE OF 192.168.0.111:6379 enabled (
			user request from 'id=3 addr=192.168.0.112:47586 fd=9 name= age=36 idle=0 flags=N db=0 sub=0 psub=0 multi=-1 qbuf=0 qbuf-free=32768 obl=0 oll=0 omem=0 events=r cmd=slaveof')
		
		6316:S 11 Nov 14:45:45.917 * Connecting to MASTER 192.168.0.111:6379
		6316:S 11 Nov 14:45:45.918 * MASTER <-> SLAVE sync started
		6316:S 11 Nov 14:45:45.918 * Non blocking connect for SYNC fired the event.
		连接成功后, 发送 sync 命令
		6316:S 11 Nov 14:45:45.919 * Master replied to PING, replication can continue...
		6316:S 11 Nov 14:45:45.920 * Trying a partial resynchronization (request 0e99498c08a427c0899b97273470403e66528020:1).
		6316:S 11 Nov 14:45:45.923 * Full resync from master: 7f53e96e4f2076c05c7727f3442461da9f4289ee:0   (完全从主同步)
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
		第二步: 主服务器接收到SYNC命令后，开始执行 BGSAVE 命令生成RDB文件并使用缓冲区记录此后执行的所有写命令；
		5052:M 11 Nov 14:54:11.528 * Starting BGSAVE for SYNC with target: disk
		5052:M 11 Nov 14:54:11.529 * Background saving started by pid 5063
		5063:C 11 Nov 14:54:11.534 * DB saved on disk
		5063:C 11 Nov 14:54:11.535 * RDB: 6 MB of memory used by copy-on-write
			copy-on-write: 表示写时复制(简称COW)机制.
		5052:M 11 Nov 14:54:11.601 * Background saving terminated with success
		5052:M 11 Nov 14:54:11.601 * Synchronization with slave 192.168.0.112:6379 succeeded

个人口述:
	1. 从库执行 slaveof 连接到 master
	2. 连接成功后, 从库向master发送请求 sync命令
	3. 主库收到 sync命令之后, 开始执行 bgsave命令进行全量备份, 生成 RDB文件
	4. 备份完成之后, 把RDB文件传给 slave
	5. slave 接收完成并应用 RDB文件
	6. 增量的数据保存在 backlog 缓冲区:
		主数据库将缓冲区的所有写命令发给从服务器执行。
	
					
完全重新同步:
	场景:
		从实例第一次连接主实例即Slave初始化阶段
	流程:
		从实例连接主实例
		因为从实例没有持有上次同步的最后一个快照,所以从实例请求主实例进行完全重新同步
		主实例创建一个后台进程转储 RDB 文件
		主实例向从实例发送RDB文件
	
	主库的日志:
		5052:M 11 Nov 14:54:11.527 * Slave 192.168.0.112:6379 asks for synchronization
		5052:M 11 Nov 14:54:11.527 * Partial resynchronization not accepted: 
			Replication ID mismatch (Slave asked for '0e99498c08a427c0899b97273470403e66528020', my replication IDs are 'b19f1d7225353c9dd2d31a1e66e9ca0ad4071a90' and '0000000000000000000000000000000000000000')
		5052:M 11 Nov 14:54:11.528 * Starting BGSAVE for SYNC with target: disk
		5052:M 11 Nov 14:54:11.529 * Background saving started by pid 5063
		5063:C 11 Nov 14:54:11.534 * DB saved on disk
		5063:C 11 Nov 14:54:11.535 * RDB: 6 MB of memory used by copy-on-write
		5052:M 11 Nov 14:54:11.601 * Background saving terminated with success
		5052:M 11 Nov 14:54:11.601 * Synchronization with slave 192.168.0.112:6379 succeeded
	
	
部分重新同步:
	场景:
		从实例跟主实例断开连接之后的再次连接
	流程:
		从实例连接主实例
		既然是部分重新同步, 意味着从实例持有上次同步的最后一个快照, 所以从实例使用最后一个快照(master_replied, offset) 请求部分重新同步
		主实例接收部分重新同步请求
		主实例将 backlog 缓冲区中的数据发送给从实例
		
	主库日志:				
		5052:M 11 Nov 15:46:46.846 * Slave 192.168.0.112:6379 asks for synchronization
		5052:M 11 Nov 15:46:46.846 * Partial resynchronization not accepted: Replication ID mismatch (Slave asked for 'd062ce47bf0efd734851d51490a416dc5388f815', my replication IDs are '7f53e96e4f2076c05c7727f3442461da9f4289ee' and '0000000000000000000000000000000000000000')
		5052:M 11 Nov 15:46:46.846 * Starting BGSAVE for SYNC with target: disk
		5052:M 11 Nov 15:46:46.847 * Background saving started by pid 5083
		5083:C 11 Nov 15:46:46.861 * DB saved on disk
		5083:C 11 Nov 15:46:46.866 * RDB: 6 MB of memory used by copy-on-write
		5052:M 11 Nov 15:46:46.873 * Background saving terminated with success
		5052:M 11 Nov 15:46:46.873 * Synchronization with slave 192.168.0.112:6379 succeeded
		
		