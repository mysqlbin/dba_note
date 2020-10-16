
1. binlog cache 简介
2. 使用 binlog cache 的大概流程
3. binlog cache 临时文件的分配和使用
4. max_binlog_cache_size
5. 如何观察到 binlog cache 磁盘临时文件的存在	
6. 相关参数
7. 相关status状态值
8. 监控	
9. 其它相关参考



1. binlog cache 简介
	
	整个事务的 event 在 事务 commit 的时候才会真正写入 binlog log ， 在些之前这些 event 都存放在另外一个地方我们可以统称为 binlog cache。--理解了。
	
	参数 binlog_cache_size:
		用于控制单个线程内 binlog cache 所占内存的大小
		默认大小为 32768 bytes 
		会话级别的参数，如果开启了 binary log 功能，则在事务期间用于保存 event 的缓存大小
		如果经常使用大事务应该加大这个参数，避免过多的物理磁盘使用
	
		注意：
			加大 binlog_cache_size 来减少临时文件的产生，但是这样会增加内存消耗
			试想以下，假如 binlog_cache_size 增加到 32MB，当有 300 个数据库连接 时，每个连接都会分配 32MB 的 binlog_cache( 不管你用多少)，那么就是将近 10G，很容易导致内存溢出，被系统 OOM。
			因此 binlog_cache_size 不可能增加很多，根本解决方法是减少事务大小，避免在高并发下同时产生大量临时文件，撑满 tmpdir；另外可以增加 tmpdir 所在分区的大小。
			
			
	trx_cache 部分：
		binlog cache 是由 IO_CACHE 实现，其中包含两个部分:
			binlog cache 缓冲区：  由参数 binlog_cache_size 参数控制
			binlog cache 临时文件：由参数 max_binlog_cache_size 参数控制
			
2. 使用 binlog cache 的大概流程

	1. 开启读写事务
	
	2. 事务执行过程中
		2.1 执行 DML 语句，在 DML 语句第一次执行的时候，会分配内存空间给 binlog cache 缓冲区
		2.2 执行 DML 语句期间生成的 event 不断写入到 binlog cache 缓冲区
		2.3 如果 binlog cache 缓冲区已经写满了，则将 binlog cache 缓冲区的数据写入到 binlog cache 临时文件，同时清空 binlog cache，这个临时文件名以 ML 开头
		
	3. 事务提交 
		binlog cache 缓冲区 和 binlog cache 临时文件数据全部写入到 binary log 中进行固化
		
	4. 事务提交完成
		释放 binlog cache 缓冲区和 binlog cache 临时文件，此时 binlog cache 缓冲区的内存空间留用供下次事务使用。
		
	5. 使用 binlog cache 流程的小结：
		事务执行过程中，先把 binlog event 写到 binlog cache，如果 binlog cache 写满，那么写到 binlog cache 临时文件中
			临时文件写满，那么将会报错，报错信息：Multi-statement transaction required more than 'max_binlog_cache_size' bytes of storage;	
			
		事务提交的时候，执行器把 binlog cache 缓冲区 和 binlog cache 临时文件 里的完整事务写入到 binlog 中，并清空 binlog cache， 
			从而 释放 binlog cache 缓冲区和 binlog cache 临时文件
			
3. binlog cache 临时文件的分配和使用

	binlog cache 临时文件存放在参数 tmpdir 定义的目录下，文件名以 ML 开头，这个文件不能用 ls 命令看到，因为它使用了
	linux 临时文件建立的方法，以避免其它进程使用这个文件，从而破坏这个文件的内容。
	即这个文件是 MySQL 进程内部专用 的。
	对于这种文件可以使用命令 lsof | grep delete 来查看
	
	
4. max_binlog_cache_size

	会话级别参数，定义了 binlog cache 临时文件的最大容量
	如果某个事务的 event 总量大于 (binlog_cache_size + max_binlog_cache_size) 的大小那么将会报错
	报错信息：Multi-statement transaction required more than 'max_binlog_cache_size' bytes of storage;	

5. 如何观察到 binlog cache 磁盘临时文件的存在
		
		通过 命令 lsof | grep delete 来观察到 ML 开头的临时文件
		
			[root@mgr9 ~]# lsof | grep delete | grep ML
			mysqld    23023 29675   mysql  190u      REG              253,2          0  107086760 /data/mysql/mysql3306/tmp/MLwM9Cst (deleted)
			mysqld    23023 29686   mysql  190u      REG              253,2          0  107086760 /data/mysql/mysql3306/tmp/MLwM9Cst (deleted)
			
		这也是有时候我们看到磁盘空间使用率很高但是又找不到文件的一个原因
		
		file sort 可能使用 MY 开头的临时文件
		
			
6. 相关参数

	缓冲区参数
		binlog_cache_size
		
	物理磁盘参数
		max_binlog_cache_size
			控制 binlog cache 使用的磁盘临时文件能达到的上限
			
		max_binlog_size
			控制单个 binlog 文件大小能达到的上限，超过这个上限就切换binlog到下一个 binlog 来写。
			
7. 相关status状态值

	Binlog_cache_disk_use
		使用到 binlog cache 临时文件的次数
		当 binlog cache 缓冲区不够用的时候，会调用函数 my_b_flush_io_cache， 这个函数主要功能如下：
			1. 当 binlog cache 缓冲区写满后将 binlog cache 缓存区的数据全部写入到 binlog cache 临时文件
			2. 清空 binlog cache 缓冲区
			3. 最后会将 binlog_cache_disk_use 统计值增加 1 。
	Binlog_cache_use
		使用到 binlog cache 的总次数
		

8. 监控
	计算在磁盘上创建临时文件保存 binlog 的比例：
      select concat(Binlog_cache_disk_use / Binlog_cache_use * 100,’%);
      use `performance_schema`;
      select VARIABLE_VALUE into @a from global_status where VARIABLE_NAME = 'Binlog_cache_disk_use'; # 在磁盘上创建临时文件用于保存 binlog 的次数
      select VARIABLE_VALUE into @b from global_status where VARIABLE_NAME = 'binlog_cache_use'; # 缓冲 binlog 的总次数，包括 binlog 缓冲区和在磁盘上创建临时文件保存 binlog 的总次数
      select @a;
      select @b;
      select concat((@a / @b) * 100,'%');
       # 加入巡检脚本中	
	
	
9. 其它相关参考

	23：MySQL 通过binlog和redo log的完整性保证数据不丢失
	24: MySQL主从原理和binlog的3种格式
	https://mp.weixin.qq.com/s/ujs7E--QzD5jmY3o9696iQ    故障分析 | binlog flush 失败导致的 Crash


	  
