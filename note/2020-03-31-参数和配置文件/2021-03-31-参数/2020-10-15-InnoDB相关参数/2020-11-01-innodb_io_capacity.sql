
0. 遇到一个场景，

	
	在单机实例上进行逻辑备份期间，导致磁盘IO利用率达到了100%，此时的错误日志有如下提示：
	
		[Note] InnoDB: page_cleaner: 1000ms intended loop took 8351ms. 
		The settings might not be optimal. (flushed=3507 and evicted=0, during the time.) 	
		
		因为脏页刷盘需要占用IO资源，此时IO资源不足，导致脏页的刷盘操作拉长了。
	
	需要验证下，ftwrl 锁是否会造成 脏页刷新会变长？
		会的。
		
1. 是什么: 
	用于告诉 InnoDB 所在主机磁盘的IO能力, 这样InnoDB才能知道需要全力刷脏页的时候， 可以刷多快
	
	也可以理解为 InnoDB 后台线程刷脏页的最大磁盘iops上限; 


2. 工作机制: 

	InnDB有后台线程(page cleaner)在不断地做 Flush（刷新脏页到磁盘） 操作, 影响这个操作频率的就是 innodb_io_capacity 参数）
	innodb_io_capacity越大，一次刷新的脏页的数量也就越大，在SSD的场景下，由于IO能力大大增强，所以 innodb_io_capacity需要调高
	但是对于普通机械磁盘，由于其随机IO的IOPS最多也就是300，所以 innodb_io_capacity设置过大，反而会造成磁盘IO不均匀。

	（By MySQL 运维内参346页）

3. innodb_io_capacity参数设置不合理的造成的问题:
	
	心中要有这个概念:
		数据的更新操作都是先写到内存中成为脏页
		更新操作频率, 脏页也就会生成得很快
			
	若设置太大：
		首先,脏页刷盘需要占用IO资源
		更新操作频率, 脏页的生成速度也很快, 脏数据页也会频繁并且快速刷新到磁盘, 超出了磁盘的I/O性能,跟实际情况不符，
			导致刷新循环时间大大拉长，下一次需要刷新时，上一次的刷新还没有执行完成。
			(innodb_io_capacity设置过大，反而会造成磁盘IO不均匀。)
		
	设置太小：  
		缓冲池的全部脏页数就会增加(脏页堆积)，redo空闲空间就会减少, 磁盘的性能发挥不了。

		
4. 由 innodb_io_capacity 参数设计不合理或者磁盘IO存在瓶颈引起的问题：

	1. innodb_io_capacity 设置过大:
	
		HDD或者普通的本地硬盘 把 innodb_io_capacity 设置为 4000. 会发生以下故障.
		
		[Note] InnoDB: page_cleaner: 1000ms intended loop took 8351ms. 
		The settings might not be optimal. (flushed=3507 and evicted=0, during the time.) 

		The settings might not be optimal : 设置可能不是最优的
		
		分析: 
		
			可以看到实际经历的时间比原定的循环时间next_loop_time多8351多毫秒
			导致刷新循环时间大大拉长，下一次需要刷新时，上一次的刷新还没有执行完成    ******
			另外 (flushed=3507 and evicted=0, during the time.)对应n_flushed_last与n_evicted 变量，
				而这两个变量由n_flushed_list与n_flushed_lru赋值，函数pc_wait_finished(&n_flushed_lru, &n_flushed_list)调用

			/**
			Wait until all flush requests are finished.
			@param n_flushed_lru    number of pages flushed from the end of the LRU list.
			@param n_flushed_list    number of pages flushed from the end of the
			            flush_list.
			@return            true if all flush_list flushing batch were success. */

			说明

			n_flushed_lru  表示从 lru 列表尾部刷新的页数
			n_flushed_list  这个是从刷新列表中刷新的页数，也就是脏页数，也就是日志中flushed=3507 的值
		
		原因:
			
			磁盘IO能力太差 同时 innodb_io_capacity参数设置太高, 导致刷脏页的时间所需要时间比实际时间长
				
		解决办法:
			调低 innodb_io_capacity参数的值, 设置为 磁盘的IOPS
			持续观察, 之后再也没有出现过 这个告警
	
	2. innodb_io_capacity设置过小:
		InnoDB就认为这个系统的能力就这么差， 所以刷脏页刷得特别慢， 甚至比脏页生成的速度还慢， 导致了脏页累积， 影响了查询和更新性能
        现象：MySQL的写入速度慢，TPS很低，但是数据库主机的IO压力并不大
		
		
	3. 磁盘IO存在瓶颈:
	
		SSD盘把 innodb_io_capacity 设置为 200 这个默认值
				innodb_io_capacity_max 设置为 2000 这个默认值
				innodb_max_dirty_pages_pct 设置 75 这个默认值
				
		
		2019-09-24T07:13:53.186865+08:00 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 4138ms. The settings might not be optimal. (flushed=2002 and evicted=0, during the time.)
		2019-09-24T07:14:39.344652+08:00 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 7140ms. The settings might not be optimal. (flushed=2002 and evicted=0, during the time.)
		2019-09-24T15:31:12.731415+08:00 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 5810ms. The settings might not be optimal. (flushed=200 and evicted=0, during the time.)

		可以看到实际经历的时间比原定的循环时间next_loop_time多4000多毫秒
		可以看到实际经历的时间比原定的循环时间next_loop_time多7000多毫秒
		可以看到实际经历的时间比原定的循环时间next_loop_time多5000多毫秒
		
		
		另外 (flushed=... and evicted=0, during the time.)对应n_flushed_last与n_evicted 变量，
			而这两个变量由n_flushed_list与n_flushed_lru赋值，函数pc_wait_finished(&n_flushed_lru, &n_flushed_list)调用

		/**
		Wait until all flush requests are finished.
		@param n_flushed_lru    number of pages flushed from the end of the LRU list.
		@param n_flushed_list    number of pages flushed from the end of the
		            flush_list.
		@return            true if all flush_list flushing batch were success. */

		说明

		n_flushed_lru 表示从lru 列表尾部刷新的页数

		n_flushed_list  这个是从刷新列表中刷新的页数，也就是脏页数，也就是日志中flushed=2002 的值
		n_flushed_list  这个是从刷新列表中刷新的页数，也就是脏页数，也就是日志中flushed=200 的值
		
		复现当时的磁盘IO利用率:
		
		-d 显示磁盘使用情况
		-m 以 M 为单位显示
		-x 显示详细信息
		shell> iostat -dmx 1
		Linux 3.10.0-693.21.1.el7.x86_64 (db-a) 	09/25/2019 	_x86_64_	(4 CPU)

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sda               0.00     0.03    0.02    0.25     0.00     0.01    61.45     0.00   15.02   43.68   12.88   0.73   0.02
		sdb               0.00     0.02    0.01   15.75     0.00     0.26    34.37     0.02    1.01    6.90    1.00   0.47   0.74

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sdb               0.00     0.00    0.00  340.00     0.00    48.12   289.88    12.88   36.04    0.00   36.04   2.82  95.80

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sdb               0.00     0.00    0.00  371.00     0.00    47.89   264.35     7.56   22.14    0.00   22.14   2.57  95.50
		
		
		shell> iostat
		Linux 3.10.0-693.21.1.el7.x86_64 (db-a) 	09/25/2019 	_x86_64_	(4 CPU)

		avg-cpu:  %user   %nice %system %iowait  %steal   %idle
				   0.14    0.00    0.07    0.08    0.00   99.70

		Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
		sda               0.27         1.77         6.59   79045332  293522080
		sdb              15.76         1.12       269.82   49744140 12021937088
		
		分析:
			1. sdb盘是数据盘, 数据都是写入操作
			1. 刷200个脏数据页, 实际需要的时间比原定的循环时间next_loop_time多5000多毫秒
			2. 复现当时的磁盘IO利用率:
				%util 接近 100%，说明产生的I/O请求太多，I/O系统已经满负荷，该磁盘可能存在瓶颈	
				如果 svctm 比较接近 await ，说明 I/O 几乎没有等待时间	
				await 远大于 svctm，说明I/O 队列太长，io响应太慢，则需要进行必要优化。

		原因:
		
			说明了数据库更新操作频率(写为主)，导致脏页生成频繁, 刷脏页频率过高, 导致了IO能力不足
			
	
5. InnoDB: page_cleaner: 1000ms intended loop took 8351ms的分析思路与处理办法：

	1.InnoDB: page_cleaner说明问题出在InnoDB引擎上。
	2.脏页清理比预定的时间长了很多，问题可能是设定的时间过于严苛，或者刷新的速度过慢。
	3.原因： 有可能是因为 IO 能力不足， 或参数不合理
		总的来说还是过快的脏页清理刷盘操作和过低的硬盘IO性能之间的矛盾。
	4.对于HDD来说，优化写入IO基本就是把离散随机的IO操作变成顺序的IO操作。
	5.将InnoDB_io_capacity的值由原来不合理的4000改成HDD适用的1000，引擎会自动增大脏页刷新和落盘的间隔，尽量将离散的IO顺序化，在HDD上提升写入性能。


		
6. innodb_io_capacity_max参数:
	只是用来控制 innodb_io_capacity 的值不能设置超过这个值，真正生效的还是innodb_io_capacity.

	
7. 相关参考:
	http://blog.itpub.net/7728585/viewspace-2157988/
	http://blog.itpub.net/7728585/viewspace-2157990/
	https://blog.csdn.net/jc_benben/article/details/82251891
	
		
