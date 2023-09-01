
事务的3个阶段：
	启动
		分配事务ID
	执行
		做的操作最多, 同时也是执行时间最久
	提交commit:
		binlog 和 redo 的刷盘

 InnoDB的一条事务日志共经历4个阶段：
	创建阶段：当前最新LSN，创建一条Redo日志，此时在Buffer Pool中，记为LSN1。
	日志刷盘：记录日志持久化到磁盘上重做日志文件的LSN，记为LSN2。
	数据刷盘：脏页数据刷新到磁盘数据文件的LSN，记为LSN3。
	写Checkpoint：
		最近一次checkpoint对应的LSN，脏页数据刷新到磁盘数据文件时最老的LSN（每个数据页上也有一个lsn，表示最后被修改时的lsn，值越大表示越晚被修改）。
		此检查点之前的脏数据页都已经刷新到磁盘，同时也是崩溃恢复时指定的起点，记为LSN4。    
		
		
				
先连接到这个数据库上，这时候接待你的就是连接器。连接器负责跟客户端建立连接、获取权限、维持和管理连接。
连接命令中的 mysql 是客户端工具，用来跟服务端(mysqld)建立连接。
在完成经典的 TCP 握手后，连接器就要开始认证你的身份，这个时候用的就是你输入的用户名和密码。



一、Server层阶段:
    1. 连接器 ：负责跟客户端建立连接、获取权限、维持和管理连接
		
		#客户端通过tcp/ip发送一条sql语句到server层的SQL interface（SQL接口）
		#SQL interface接到该请求后，先对该条语句进行解析，验证权限是否匹配，验证连接数
		先连接到连接器, 在完成经典的 TCP 握手后, 连接器先对该条语句进行解析，验证权限是否匹配，验证连接数。
		
    2. 分析器 ：验证通过以后，分析器会对该语句分析, 判断是否语法有错误等。

    3. 优化器 ：选择索引，生成执行计划。
    4. 执行器 ：
        根据执行计划执行这条语句。在这一步会去open table,如果该table上有MDL元数据锁，则等待
        如果没有，则在该表上加MDL读锁
        (如果opend_table太大,表明open_table_cache太小。需要不停的去打开frm文件)
        调用存储引擎接口，进入到引擎层

		-- 元数据锁，是Server层的。
		
二、InnoDB引擎层阶段： 

	0. 进入 InnoDB 存储引擎层前，会先判断引擎层的并发线程数是否达到上限, 一旦并发线程数达到上限，InnoDB 在接收到新请求的时候，就会进入等待状态，直到有线程退出。
	   由参数  innodb_thread_concurrency 控制.
	   参数innodb_thread_concurrency 源码在MySQL 5.7.22版本 的 /storage/innobase/srv/srv0conc.cc 目录文件下
	   由 srv_conc_enter_innodb_with_atomics 和 srv_conc_enter_innodb 两个参数控制
			
			
    1. 事务执行阶段： 

        进入InnoDB后引擎层，首先会判断该SQL涉及到的页是否存在于缓存中，如果不存在则从磁盘读取该行记录所在的数据页并加载到BP缓冲池。
		
        假设不存在，然后通过 B+Tree 读取到磁盘的索引页加载到BP缓冲池中 ，如何加载到BP缓冲池中：
            首先 通过 space id 和 page no 哈希计算之后把 索引页加载到指定的 buffer pool instance 中
            判断 free list 是否有空闲页可用(Innodb_buffer_pool_pages_free、 Innodb_buffer_pool_wait_free)，没有则淘汰脏页或者lru list尾部的Old页
            把数据页 copy到 free list中，然后加载到 lru list的 old区的 midpoint（头部）；

        通过二分法查找该页对应的记录，试图给这个SQL涉及到的行记录加上排他锁，过程如下：
            如果事务当前记录的行锁被其他事务占用的话，就需要进入锁等待
            进入锁等待之后，同时判断会不会由于自己的加入导致了死锁
            检测到没有锁等待和不会造成死锁之后，行记录加上排他锁;
         	在这个步骤/阶段获取行锁。
			
        写逻辑的undo： 
            将修改前的记录写入undo中
            修改当前行的值，填写事务编号，使用回滚指针指向undo log中的修改前的行
            从而构建回滚段，用于回滚数据和实现MVCC的多版本
            完成Undo log写入后，构建新的回滚段指针并返回（trx_undo_build_roll_ptr），回滚段指针包括undo log所在的回滚段id、日志所在的page no、以及page内的偏移量，需要记录到聚集索引记录中。
			http://mysql.taobao.org/monthly/2015/04/01/
		

        写change buffer:
            之后把这条sql, 需要在二级索引上做的修改，写入到change buffer page，等到下次有其他sql需要读取该二级索引时，再去与二级索引做merge
            (随机I/O变为顺序I/O,但是由于现在的磁盘都是SSD,所以对于寻址来说,随机I/O和顺序I/O差距不大)

            在事务提交的时候，把 change buffer 的操作也记录到 redo log 里了，所以崩溃恢复的时候，change buffer 也能找回来。
		
        写redo log buffer：

            先判断redo log buffer是否够用，redo log buffer不够用就等待，体现在状态值 Innodb_log_waits 上;

            在 BP缓冲池 的 Lru list中old区的midpont中对该数据页的行记录的字段值做更新操作，并把修改之后的字段值写入到redo log buffer中
			
            并给 Log sequence number(简称LSN, 写入redo log的总大小,单位为字节) 加上当前redo log写入的长度(写入长度为 length 的redo log，LSN就会加上 length)
			
			字段值在BP缓冲池更新成功以后，对应的数据页就是脏页了
			
			这个脏页在页结构的 file header 也会记录此次产生的LSN大小, 表示该页最后被修改的日志序列位置LSN（Log Sequence Number） 即该页最后刷新时LSN的大小；
			
            （因为redo group commit的原因，这次事务所产生的redo log buffer可能会跟随其它事务一同flush并且fsync到磁盘上）
		
        写binlog cache： 
            同时修改的信息，会按照event的格式,记录到binlog_cache（binlog_cache的大小由参数binlog_cache_size控制）中。
            (这里注意binlog_cache_size是transaction级别的,不是session级别的参数, 一旦commit之后，dump线程会从binlog_cache里把event主动发送给slave的I/O线程)
            # 这里待验证
			binlog_cache_size 写满，会把binlog_cache_size的数据写入到 max_binlog_cache_size（临时文件） 中， 如果写入的数据大于 binlog_cache_size + max_binlog_cache_size，
			那么会报错：Multi-statement transaction required more than 'max_binlog_cache_size' bytes of storage;
			


        事务commit or rollback: 
            此时update语句已经完成，需要commit或者rollback。这里讨论双1即sync_binlog=1 和 innodb_flush_log_at_trx_commit=1；
        
    2. 假设事务COMMIT
		
		2.0 如果在事务要做commit操作的时候遇到 FTWRL 并且没有 解锁（执行 unlock tables;） 会堵塞 commit 操作， 堵塞状态为  'Waiting for commit lock'
    		https://www.jianshu.com/p/56d268983822    MySQL：简单记录一下Waiting for commit lock
			
        2.1. 事务的COMMIT 分为prepare阶段与commit阶段
           事务的COMMIT操作，在存储引擎层与server层之间采用的是内部XA；
           两阶段提交协议, 保证两个事务的一致性,这里主要保证redo log和binlog的原子性；

        2.2. redo log prepare: 
            写入 redo log处于prepare状态 并且写入事务的xid；
            将 redo log buffer 刷新到 redo log磁盘文件中，用于崩溃恢复；  #刷盘的方式由 innodb_flush_log_at_trx_commit 决定
		
        2.3. binlog write&fsync: 执行器把 binlog cache 里的完整事务和 redo log prepare中的XID 写入到 binlog files 中 并且生成 GTID
			
			这里验证了一个binlog执行过程: 事务在执行过程中，先把日志写到 binlog cache，事务在提交的时候，再把 binlog cache 写到 binlog files 中。
            #事务中写 binlog 的部分日志：
                190511 11:06:54 server id 123306  end_log_pos 439 CRC32 0x1c809de0     Xid = 614
                COMMIT/*!*/;
             binlog刷盘的方式由 sync_binlog 决定；binlog写入完成并且binlog是完整的，该事务就算是执行成功。
             
    
        2.4. 由于 binlog 已经写入完成 到 binlog files（os cache）中, 之后主从复制线程的dump线程会从binlog_cache里把event主动发送给slave的I/O线程，同时执行 fsync刷盘(大事务的话这步非常耗时)，并清空 binlog cache。
			主库必须等事务执行完成才会写binlog，然后再发给从库，如果主库执行这个事务需要10分钟，那么这个事务可能会导致从库延迟10分钟；
			来源： MySQL 实战45讲
				   23：MySQL 通过binlog和redo log的完整性保证数据不丢失
				   25：主备延迟-MySQL是怎么保证高可用的
				   
		2.5. 假设执行到这里遇到MySQL异常重启, 那么需要触发崩溃恢复的逻辑
			 
			 因为 binlog 已经写入完成, 带有Xid标识, 可以认为这个binlog是完整的, 所以此时会把这个事务提交. （保证了主从数据的一致性）
			 
			 没有遇到 MySQL 异常重启, 就往下执行.
			 
        2.6. redo log commit: commit阶段，由于之前该事务产生的redo log已经sync到磁盘了。所以这步只是在redo log里标记commit，说明事务提交成功。
          
       
        2.7. 事务提交成功，释放行记录持有的排他锁； 
			 这里验证了InnoDB事务的两阶段加锁规则: 行锁是在需要的时候就会加上, 并不是不需要了就会释放, 而是要等到事务结束时才释放.        	 
			
        2.8. 当binlog和redo log都已经落盘以后，如果触发了刷新脏页的操作:
            先把该脏页复制到doublewrite buffer里，其次把doublewrite buffer里的刷新到共享表空间（ibdata），然后才是把脏页写入到磁盘中；
            这时候内存页与磁盘的数据页一致, 该数据页在内存中变为干净页
            
        （所以，如果事务成功写binlog, 那么可以认为这个事务是执行成功的）
        
    3. 假设事务ROLLBACK
        如果事务因为异常或者被显式的回滚了，那么所有数据变更都要改回去。这里就要借助回滚日志中的数据来进行恢复了。
        对于in-place(原地)更新，将数据回滚到最老版本；
        对于delete+insert方式进行的，标记删除的记录清理删除标记，同时把插入的聚集索引和二级索引记录也会被直接删除。

三、至此，一条update SQL在MySQL中结束生命历程
   
最后：    
    本人水平有限，上述回答也是在日常工作中学习MySQL原理的时候通过相关资料整理而来，希望能得到纠正
    由于还没接触过MySQL的源码，希望后期能进一步提升，根据源码来学习原理
    通过工作和学习MySQL的过程中, 根据掌握的知识点, 会持续维护update语句的生命周期

	-- 画下流程图
	
	
----------------------------------------------------------------------------------------------------------------------------------------------------------

redo log和undo log的机制：

    redo log 是物理逻辑日志，也就是说常说的重做日志，记录的是 在某个数据页上做了什么修改 也就是 记录的是数据被修改之后的值；
    作用：用来保证数据的持久化和用于两阶段提交的崩溃恢复
	
	undo log是回滚日志，记录的是数据修改前的值
	作用：是实现MVCC的一部分和实现事务的回滚。

redo log和undo log具体的实现流程：

	假如某个时刻数据库崩溃，在崩溃之前有事务A和事务B在执行，事务A已经提交而且脏页没有刷盘，而事务B还未提交。
	当数据库重启进行 crash-recovery 时，就会通过Redo log将已经提交事务的更改写到数据文件，而还没有提交的就通过Undo log进行roll back。


	Redo log将已经提交事务的更改写到数据文件：
		把数据页从磁盘读取出来加载到内存中，应用redo log到内存的数据页中，然后该数据页成为脏页。
		
-----------------------------------------------------------------------------

		
事务回滚要做的操作: http://mysql.taobao.org/monthly/2015/04/01/
	
	  
	如果事务因为异常或者被显式的回滚了，那么所有数据变更都要改回去。这里就要借助回滚日志中的数据来进行恢复了。

	入口函数为：row_undo_step --> row_undo

	操作也比较简单，析取老版本记录，做逆向(反向)操作即可：
		对于标记删除的记录清理标记删除标记；
		对于in-place(原地)更新，将数据回滚到最老版本；
		对于插入操作，直接删除聚集索引和二级索引记录（row_undo_ins）。

	具体的操作中，先回滚二级索引记录（row_undo_mod_del_mark_sec、row_undo_mod_upd_exist_sec、row_undo_mod_upd_del_sec），再回滚聚集索引记录（row_undo_mod_clust）。

			
未完成：	
	1. DML锁    # done
	2. 脏页 	# 什么时候修改内存数据页
	2. 刷脏页
	3. redo log buffer 不够用
	4. redo 写满
	5. redo 和 binlog 的组提交
	6. LSN   	      数据页写到redo log的位置
	7. checkpoint     刷的脏页到了哪个位置, 作为崩溃恢复的起点
	8. 表空间 段 区 页
	9. MVCC
	10. 后台线程
	11. 主从
	12. MTR
	
	
	LSN，每次写redo log都带的一个数字， 数据页上也有，对比大小的，因为太细节没有写到文章中。
 
 介绍日志逻辑序列号（log sequence number，LSN）的概念:
	LSN 是单调递增的，用来对应 redo log 的一个个写入点。每次写入长度为 length 的 redo log， LSN 的值就会加上 length。
	LSN 也会写到 InnoDB 的数据页中，来确保数据页不会被多次执行重复的 redo log。
 关于 LSN 和 redo log、checkpoint 的关系，我会在后面的文章中详细展开。  这里要看一下，搞懂来。
 (By 23|MySQL 是怎么保证数据不丢失的？)

两阶段提交细化:  这里可以做最后补充
	redo log prepare write
	binlog write
	redo log prepare fsync
	binlog fsync
	redo log commit

由于 redo log和binlog都支持组提交，但是
一般情况下，redo log prepare 在fsync阶段的速度是很快的，所以binlog的 write和fsync操作的间隔时间比较短，导致能集合到一起持久化的binlog比较少，因此binlog组提交往往没有redo组提交的效果好。
所以 binlog新增两个参数用于提升binlog组提交的效果，分别是
binlog_group_commit_sync_delay 表示延迟多少微秒把binlog fsync到磁盘 和
binlog_group_commit_sync_no_delay_count 表示 累积多少次后才把binlog fsync到磁盘。


 
写操作：innodb_write_io_threads
　　1、发起者：page_cleaner线程发起
　　2、完成者：写线程执行请求队列中的写请求操作
　　3、如何调整写线程的数量

即  page_cleaner线程 发起 innodb_write_io_threads 写操作

InnoDB的一条事务日志共经历4个阶段：
    创建阶段：当前最新LSN，创建一条Redo日志，此时在Buffer Pool中，记为LSN1。
    日志刷盘：记录日志持久化到磁盘上重做日志文件的LSN，记为LSN2。
    数据刷盘：脏页数据刷新到磁盘数据文件的LSN，记为LSN3。
    写Checkpoint：最近一次检查点对应的LSN，脏页数据刷新到磁盘数据文件时最老的LSN。
                      此检查点之前的脏数据页都已经刷新到磁盘，同时也是崩溃恢复时指定的起点，记为LSN4。
							
							
A538-张上仑-上海 2018/10/25 9:42:38
	他会把那些页需要刷新找出来，然后传送给io线程去完成具体刷脏页的动作。
A538-张上仑-上海 2018/10/25 9:43:38
	至于这里的io线程，因为刷脏页是从内存落到磁盘，属于写操作，那就由写线程来完成
	所以发起者是 page_cleaner
A538-张上仑-上海 2018/10/25 9:45:21
	具体干活的就是io写线程了

八怪师兄  10:04:56
	innodb_write_io_threads 这是后台的   异步IO只需要将请求丢给 io threads 就好了。
八怪师兄  10:05:42
	page_cleanr线程将IO丢给 异步IO线程 。由异步IO线程去做，完了返回一个信号给 page_cleanr线程

	
	
page_cleaner线程发起刷脏页请求， 把这部分脏页传送给 异步io thread, 由异步io thread 做最后的脏页刷盘操作.
操作完成后返回一个信号给 page_cleaner线程.


系统平稳刷脏页的方式是最优的。

log buffer 写满了，数据库会hang住

触发了刷新脏页的操作，先把该脏页复制到doublewrite buffer里，把doublewrite buffer里的刷新到共享表空间，然后才是通过page cleaner线程把脏页写入到磁盘中。

page_cleaner线程发起刷脏页请求， 

将脏页刷新落地到磁盘的过程：
将脏页拷到double write buffer(memory)
将double write buffer写dblwr文件并sync到磁盘
将dirty page写到数据(.ibd)文件并sync到磁盘



