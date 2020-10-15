
  1.1 binlog cache：
	
       1. 大小由参数binlog_cache_size 控制；
       2. 一个事务的binlog是不能被拆开的，不管事务多大，也要确保一次性写入；
       3. 系统给 binlog cache 分配了一片内存，每个线程一个（所以要session级别参数），参数 binlog_cache_size  用于控制单个线程内 binlog cache 所占内存的大小
            如果超过了这个参数规定的大小，就要暂存到磁盘。
		   show global status like 'Binlog_cache_disk_use';             # 在磁盘上创建临时文件用于保存 binlog 的次数
		   show global status like 'Binlog_cache_use';                     # 缓冲 binlog 的总次数，包括 binlog 缓冲区和在磁盘上创建临时文件保存 binlog 的总次数
		   如果发现在磁盘上创建临时文件保存 binlog 的次数过多，则表示 binlog 缓冲区内存不够，可以考虑加大binlog_cache_size 的值。
		   计算在磁盘上创建临时文件保存 binlog 的比例：
			   select concat(Binlog_cache_disk_use / Binlog_cache_use * 100,’%);
			  use `performance_schema`;
			  select VARIABLE_VALUE into @a from global_status where VARIABLE_NAME = 'Binlog_cache_disk_use'; # 在磁盘上创建临时文件用于保存 binlog 的次数
			  select VARIABLE_VALUE into @b from global_status where VARIABLE_NAME = 'binlog_cache_use'; # 缓冲 binlog 的总次数，包括 binlog 缓冲区和在磁盘上创建临时文件保存 binlog 的总次数
			  select @a;
			  select @b;
			  select concat((@a / @b) * 100,'%');
			   # 加入巡检脚本中
			通过计算在磁盘上创建临时文件保 binlog 的比例，可反映出数据库 binlog 的情况，该比例越小越好。
			
      4. 事务执行过程中，先把日志写到 binlog cache， 事务提交的时候，执行器把 binlog cache 里的完整事务写入到 binlog 中，并清空 binlog cache。
	  

系统给 binlog cache 分配了一片内存，每个线程一个，参数 binlog_cache_size 用于控制单个线程内 binlog cache 所占内存的大小。如果超过了这个参数规定的大小，就要暂存到磁盘。
事务提交的时候，执行器把 binlog cache 里的完整事务写入到 binlog 中，并清空 binlog cache。

参考笔记：《13-binlog cache 简介.sql》、 《23：MySQL 通过binlog和redo log的完整性保证数据不丢失既保证事务的完成性》

binlog_cache_size = 1M
max_binlog_cache_size = 2G



