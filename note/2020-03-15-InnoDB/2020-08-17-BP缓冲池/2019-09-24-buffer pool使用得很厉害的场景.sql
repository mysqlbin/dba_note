



大表数据的扫描, 会占用 buffer pool.
	比如 pt-archiver 的归档工具, 如果是根据 非主键作为条件, 每次都会根据主键索引做全表扫描,
	多次扫描, 导致 buffer pool使用得很厉害.
	体现在 Innodb_buffer_pool_wait_free = 16
		   Innodb_buffer_pool_pages_free = 0
	
	原因：
		持续全表扫描往BP缓冲池写入数据，淘汰数据页的速度跟不上写入的速度，导致在写入BP缓冲池的时候需要等待。
		跟下面的问题类似
		问：InnoDB改进的LRU算法，如果遇到连续两次的全表扫描，会不会就把young区的3/5给覆盖掉了？因为两次扫描时间间隔会超过一秒？
		
		作者回复: 会的
		
		
		
419424 -> 422113 -> 428841
select 428841-419424 = 9417 * 16 = 150672KB = 147MB;


mysql_version: 5.7.26-log                    
因 log buffer不足导致等待的次数(Innodb_log_waits): 0 次
max_connections: 3000
Max_used_connections: 35
innodb_buffer_pool_pages_dirty: 44
innodb_buffer_pool_pages_total: 655360
Innodb_buffer_pool_pages_data: 419424
脏页占比: 0.01%
innodb_buffer_pool_read_requests: 811188867
innodb_buffer_pool_read_ahead: 311696
innodb_buffer_pool_reads: 77406
InnoDB buffer pool 命中率: 99.95%
Innodb_buffer_pool_wait_free: 0
Innodb_buffer_pool_pages_free: 234923
Innodb buffer pool空闲Page的数量(Innodb_buffer_pool_pages_free): 234923　个Page
Threads_running: 4
Innodb_row_lock_current_waits: 0
 1: result of innodb row lock current waits
no innodb row lock current waits

因 log buffer不足导致等待的次数(Innodb_log_waits): 0 次
max_connections: 3000
Max_used_connections: 35
innodb_buffer_pool_pages_dirty: 94
innodb_buffer_pool_pages_total: 655360
Innodb_buffer_pool_pages_data: 422113
脏页占比: 0.01%
innodb_buffer_pool_read_requests: 811604193
innodb_buffer_pool_read_ahead: 314384
innodb_buffer_pool_reads: 77406
InnoDB buffer pool 命中率: 99.95%
Innodb_buffer_pool_wait_free: 0
Innodb_buffer_pool_pages_free: 232234
Innodb buffer pool空闲Page的数量(Innodb_buffer_pool_pages_free): 232234　个Page
Threads_running: 4
Innodb_row_lock_current_waits: 0
 1: result of innodb row lock current waits
no innodb row lock current waits



mysql_version: 5.7.26-log                    
因 log buffer不足导致等待的次数(Innodb_log_waits): 0 次
max_connections: 3000
Max_used_connections: 35
innodb_buffer_pool_pages_dirty: 44
innodb_buffer_pool_pages_total: 655360
Innodb_buffer_pool_pages_data: 428841
脏页占比: 0.01%
innodb_buffer_pool_read_requests: 812250168
innodb_buffer_pool_read_ahead: 321038
innodb_buffer_pool_reads: 77470
InnoDB buffer pool 命中率: 99.95%
Innodb_buffer_pool_wait_free: 0
Innodb_buffer_pool_pages_free: 225506
Innodb buffer pool空闲Page的数量(Innodb_buffer_pool_pages_free): 225506　个Page
Threads_running: 4


