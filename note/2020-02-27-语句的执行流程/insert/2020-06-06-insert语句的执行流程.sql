

暂时不写大字段列
减少索引.

	
以页的为单位，一个页为16KB

脏页的刷盘
	主键索引页, 走 double write 进行双写 
	二级索引页，先进入内存缓冲池的change buffer，
	

create table t1(
	`ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '索引',
	name varchar(16),
	age int(10) default 0,
	PRIMARY KEY (`ID`),
	KEY `idx_name`(`name`)
) engine=InnoDB;

insert into t(id, name) values(1,'k1', 10);

一条插入语句，它涉及了5个大的部分：
    1. 内存缓冲池(InnoDB buffer pool_size)
    2. redo日志(对应的磁盘文件：ib_log_fileX)
	3. binlog 日志
    4. 数据表空间(t.ibd)
    5. 系统表空间(ibdata1：记录undo, 把二级索引的更新操作写入 change buffer)
	
	
MySQL 中事务的提交流程
	1. 事务执行过程阶段
	  1.1. 先在内存缓冲池中判断这行记录的数据页是否在内存缓冲池中：
		1.1.1 在内存缓冲池中： 
			直接把记录写入内存缓冲池的主键索引和二级索引(idx_name)各自对应的数据页中
			其中二级索引(idx_name)的记录是写入到内存缓冲池的change buffer模块中
			
		1.1.2 不在内存中： 
			从磁盘读取主键索引的数据页并加载内存缓冲池中
			从磁盘读取二级索引(idx_name)的数据页并加载内存缓冲池中
			然后才会把记录写入到内存缓冲池的主键索引和二级索引(idx_name)各自对应的数据页中
			其中二级索引(idx_name)的记录是写入到内存缓冲池的change buffer模块中
			
		1.1.3 此时内存缓冲池中数据页和对应的磁盘中数据页不一致，称为脏页，脏页最终也要进行刷盘
			由MySQL的后台线程每隔每秒或者10秒把脏页进行刷盘。
		
	  1.1 写redo日志：先写入redo log buffer
		   
	  1.2 写binlog日志：先写入到 binlog cache
			
	  1.3 写undo日志：将修改前的记录写入undo中
			
	  1.4 写change buffer：用于缓存二级索引的更新(插入、更新、删除)操作
	  
	2. 事务提交阶段即数据和日志刷盘阶段
		
		2.1 binlog日志刷盘： 
			把binlog cache中日志写入操作系统的页缓存、最后把binlog日志写入磁盘进行持久化；
			参数 sync_binlog 控制事务提交时binlog的刷盘策略:
				1. sync_binlog = 0 ：表示事务每次提交都只写入操作系统的页缓存，不进行持久化；
				2. sync_binlog = 1 ：表示事务每次提交都把binlog日志写入磁盘进行持久化；
				3. sync_binlog = N(N>1)， 表示事务每次提交都只写入操作系统的页缓存, 当累积N个事务后才执行binlog日志写入磁盘进行持久化。
			
		2.2 redo日志刷盘：	
			把redo log buffer中的数据写入操作系统的页缓存、最后把redo日志写到磁盘进行持久化；
			参数 innodb_flush_log_at_trx_commit控制事务提交时redo log的刷盘策略：
				innodb_flush_log_at_trx_commit=0 ： 事务每次提交都只把 redo log 写在 redo log buffer 中；
				innodb_flush_log_at_trx_commit=1 ： 事务每次提交都把 redo log持久化到磁盘；
				innodb_flush_log_at_trx_commit=2：事务每次提交只是把 redo log写到操作系统的 page cache中。
									
3. 事务提交完成，把数据返回给客户端。
	整个过程，数据不需要等内存缓冲池的脏页刷盘完成，就可以把数据返回给客户端。
	
	
目前知道对性能影响最大的参数，做成表格的格式：
	操作系统层面
		
	数据库层面	
		binlog日志的参数
			sync_binlog：控制binlog的刷盘策略
		
		redo日志的参数
			redo log buffer：
				redo日志能缓存的大小，设置太小, redo log buffer写满, MySQL可能会hang住,影响写入/更新/删除操作. 
			innodb_log_file_size和innodb_log_files_in_group：
				控制redo日志的大小, 如果太小, 在持续高并发的情况下, redo日志写满, MySQL可能会hang住,影响写入/更新/删除操作. 
			innodb_flush_log_at_trx_commit： 控制redo日志的刷盘策略
			
		innodb_io_capacity： 每秒或者每10秒刷新内存缓冲池中的多少个脏页到磁盘进行持久化。
		
		内存缓冲池级别的参数
			innocb_buffer_pool_size的相关监控指标：
				内存命令率下降
				状态值Innodb_buffer_pool_wait_free大于0：表示内存没有可用空闲页，插入/更新操作会产生等待，SQL语句返回慢
			innodb_max_dirty_pages_pct:
				内存缓冲池的脏页达到内存缓冲池最大占比，当内存缓冲池的脏页达到这个阀值, MySQL可能会hang住,影响写入/更新/删除操作.   
			
		innodb_flush_neighbors ：刷脏页到磁盘是否需要把相邻的脏页一起刷盘
			
		innodb_flush_method:
			
		innodb_data_file_path 
			= ibdata1:1G:autoextend 
		innodb_open_files
		
		
		
	以上参数都是根据硬件能力和数据库的压力来调整的.
	
	事务隔离级别

并发很高的情况下，3G的redo其实是很小的， 所以并发很高的情况下， 个人建设设置最少3个G：
    innodb_log_file_size = 1G
    innodb_log_files_in_group = 3  
	
可以把 binlog 不放在数据盘下.

	
硬件环境:
	CPU 4核
	IOPS: 读写各1000
	磁盘大小: 100GB, 剩余空间: 30GB
	
建议设置参数的组合做性能对比:
	目的: 在当前硬件环境下, 哪一种数据库的参数组合是最优的.
	主要查看指标:
		系统层面
			系统负载
			io压力
			CPU利用率
		MySQL层面
			TPS
			QPS
			内存命令率
			脏页占比大小
			状态wait值
				Innodb_buffer_pool_wait_free
				Innodb_log_waits
		业务层面的指标
		

		
新插入的记录的处理流程：
	   1. 要在这张表中插入一个新记录 (4,400) ；
	   2. 当这个记录要更新的目标页在内存中：
			 1. 唯一索引： 找到 3 和 5 之间的位置，判断到没有冲突，插入这个值，语句执行结束；
			 2. 普通索引： 找到 3 和 5 之间的位置，插入这个值，语句执行结束。
			 3. 因此， 如果要更新记录的数据页在内存中，普通索引和唯一索引对更新语句性能影响的差别，只是一个判断，只会耗费微小的 CPU 时间。
		3. 当这个记录要更新的目标页不在内存中：
			1. 唯一索引： 需要从磁盘读入数据页到内存中，在内存中判断到没有冲突，插入这个值，语句执行结束；
			2. 普通索引： 将更新操作记录在 change buffer 中，语句执行就结束了。
			
				
2、DML操作(例update)
　　　　1、内存读，然后进行物理读，读取所需修改的数据行
　　　　2、从磁盘调入undo页到buffer pool中
　　　　3、修改前的数据存入undo页里，产生redo
　　　　4、修改数据行(buffer pool中数据页成脏页)，产生redo
　　　　5、生成的redo先是存于用户工作空间，择机拷入log_buffer中
　　　　6、log线程不断的将log_buffer中的记录写入redo logfile中
　　　　7、修改完所有数据行，提交事务，刻意再触发一下log线程
　　　　8、待log_buffer中的相关信息都写完，响应事务提交成功
　　至此，日志写入磁盘，内存脏块还在buffer pool中(后台周期写入磁盘，释放buffer pool空间)。

设置 innodb_data_file_path = ibdata1:1G:autoextend，千万不要用默认的10M，否则在有高并发事务时，会受到不小的影响；


https://www.cnblogs.com/geaozhang/p/7214257.html   MySQL IO线程及相关参数调优

https://www.jianshu.com/p/5248ca67eac2 MySQL：一个简单insert语句的大概流程


