
1. 前言
2. Xtrabackup 2.4 全量备份流程总结
3. 全备还原流程
4. 别人总结的工作流程
5. 物理备份的3个关键字
6. 口述物理备份的流程


1. 前言
	
	物理备份直接包含了数据库的数据文件，适用于大数据量，需要快速恢复的数据库。
	逻辑备份包含的是一系列文本文件，其中是代表数据库中数据结构和内容的SQL语句，适用于较小数据量或是跨版本的数据库备份恢复。 

	xtrabackup主要是用于热备份innodb,或者是 xtradb表中数据的工具，不能备份其他类型的表，也不能备份数据表结构； 
	innobackupex是将xtrabackup进行封装的perl脚本，可以备份和恢复MyISAM表以及数据表结构。

2. Xtrabackup 2.4 全量备份流程总结

	1. 从Last checkpoint at（上一次检查点的位置）开始复制已有的redo log，然后监听redo log变化并持续复制
		作用：
			因为在备份过程中可能有持续的数据写入，所以要先拷贝redo log
			从备份开始到备份结束期间的增量数据。
			在备份恢复的时候，应用redo log到数据页中，保证在备份结束后，数据页是一致的。
			
		200315 19:46:17 >> log scanned up to (18238654367)
		open("/home/mysql/data/mysqldata1/innodb_log/ib_logfile0", O_RDONLY) = 4  #重新打开ib_logfile0，读取文件头，找到checkpoint点
		pread(4, "\200\3\306\7\2\0\0000\0\0\0\37\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 65536, 126611968) = 65536  #从checkpoint点位置开始读取redo log

	2. 复制ibdata1共享表空间文件和事务引擎数据文件
		Copying ./ibdata1 to /data/backup/2020-03-15_19-46-09/ibdata1
		Copying ./mysql/plugin.ibd to /data/backup/2020-03-15_19-46-09/mysql/plugin.ibd
		
	3. 等待事务引擎数据文件复制完成
		
	4. 加锁：全局读锁
		
		FLUSH TABLES WITH READ LOCK
		用途/作用：
			通过获取全局读锁，让整个实例不能写，只能读， 这时候就可以获取到一致性的 show master status; 命令的信息，包括 File、Position和GTID。(这里的结论是在实验中得到的。)
			不加锁的话，备份系统的备份得到的库不是一个逻辑时间点，这个视图是逻辑不一致的。
			不通过FTWRL命令对整个实例加锁， 备份得到的数据跟备份的逻辑时间点不一致，最终结果导致备份数据会产生不一致。  
		
		造成的影响：
			期间整个实例不能写，只能读；
			如果在主库进行备份，释放全局读锁之前不能写，对在线业务造成影响；
			如果在从库进行备份，释放全局读锁之前不能写，也就意味应用relay log不能进行SQL的重放，造成延迟；

		所以，备份要在从库并且是业务低峰期进行备份，这时候造成的影响最小。 可见，了解原理挺重要的。
	
	5. 复制非事务引擎数据文件及其他文件
		copy .frm;.myd;.myi;misc files  复制frm、myd等文件
		Copying ./mysql/db.frm to /data/backup/2020-03-15_19-46-09/mysql/db.frm
		Copying ./mysql/db.MYI to /data/backup/2020-03-15_19-46-09/mysql/db.MYI
		Copying ./mysql/db.MYD to /data/backup/2020-03-15_19-46-09/mysql/db.MYD
		如果表的个数很多，比如有3w张表，这一步会很比较耗时，导致加锁的时间也会很长。
		-- 后期验证下。
		
	6. 获取binlog位点信息等元数据
		xtrabackup_binlog_info
		Writing /data/backup/2020-03-15_19-46-09/xtrabackup_binlog_info

	7. 获取 备份结束时，数据库中的 checkpoint 点和 已经刷新到重做日志文件的LSN ，会写入到 xtrabackup_checkpoints 文件中

	8. 待redo日志拷贝完成，停止复制redo log
		xtrabackup: Stopping log copying thread.
		
	9. 解锁：全局读锁
		Executing UNLOCK TABLE
		 -- 保证 数据+redo和binlog的一致性、保证事务引擎表数据和非事务引擎表数据的一致性。
	10. 拷贝buffer pool文件
		Copying ib_buffer_pool to /data/backup/2020-03-15_19-46-09/ib_buffer_pool
		
	11. 备份完成
	
	
	TIPS:
		非事务引擎数据文件较多时，全局读锁的时间会较长。
		
	FAQ:
	
		1. 为什么要先复制redo log，而不是直接开始复制数据文件？
		
			因为XtraBackup是基于InnoDB的crash recovery机制进行工作的。如上图2中的页2，由于是热备操作，在备份过程中可能有持续的数据写入，直接复制出来的数据文件可能有缺失或被修改的页，而redo log记录了InnoDB引擎的所有事务日志，可以在还原时应用redo log来补全数据文件中缺失或修改的页。
			所以为了确保redo log一定包含备份过程中涉及的数据页，需要首先开始复制redo log。
	 
		2. 加全局读锁的作用？ 

			因为要保证”非事务资源 自身的一致性“ 和 ”非事务资源与 事务资源的一致性“。
			在加锁期间，没有新数据写入，XtraBackup会复制此时的binlog位置信息，frm表结构，MyISAM等非事务表。    

		3. 为什么要先停止复制redo log，再解锁全局读锁？ 

			也是因为要保证“非事务资源与事务资源的一致性”，保证通过redo log回放后的InnoDB数据与非InnoDB数据都是处于读锁期间取得的位点。
			即 为了保证备份 非事务资源与事务资源的一致性.
			
			
	XtraBackup基于InnoDB的crash recovery机制，在备份还原时利用redo log得到完整的数据文件，并通过全局读锁，保证InnoDB数据与非InnoDB数据的一致性，最终完成备份还原的功能

	https://mp.weixin.qq.com/s/G6X1pur3QY3Q8WsEdR5RYA  [原理解析] XtraBackup全量备份还原
	
	参考备份日志：innobackupex.log
	
3. 全备还原流程
	1. xtrabackup --prepare 阶段
		模拟MySQL进行 recovery， 将 redo log 回放到数据文件中
		等于 recovery 完成
		重建 redo log， 为启动数据库做准备
		
	2. xtrabackup --copy-back
		将数据文件复制回MySQL数据目录 
		还原完成。
		
	3. 用的是 xtrabackup
	
4. 别人总结的工作流程
	
	工作流程
		1. start xtrabbackup_log
		2. copy ibdata1、.ibd; ： 复制 ibdata1、.ibd 数据文件
			Copying ./ibdata1 to /data/backup/2018-03-14_15-32-08/ibdata1
			Copying ./sys/sys_config.ibd to /data/backup/2018-03-14_15-04-12/sys/sys_config.ibd
			
			备份时间最长就是这一步
			
		3. flush tables with read lock; 数据表不可以写，可以读

		4. copy .frm;.myd;.myi;misc files  复制frm、myd等文件
			Copying ./mysql/db.frm to /data/backup/2018-03-14_15-04-12/mysql/db.frm
			
		5. get binary log position 获取二进制日志的位置

		# UNLOCK BINLOG
		6. unlock tables; 释放全局读锁

		7. stop and copy xtrbackup_log


	innobackupex的基本流程如下： 
		1. 开启redo日志拷贝线程，从最新的检查点开始顺序拷贝redo日志； 
		2. 开启ibd文件拷贝线程，拷贝innodb表的数据 
		3. ibd文件拷贝结束，通知调用FTWRL，获取一致性位点 
		4. 备份非innodb表(系统表)和frm文件 
		5. 由于此时没有新事务提交，等待redo日志拷贝完成 
		6. 最新的redo日志拷贝完成后，相当于此时的innodb表和非innodb表数据都是最新的 
		7. 获取binlog位点，此时数据库的状态是一致的。 
		8. 释放锁，备份结束。

	首先我们要清楚 Xtrabackup 2.4 的备份流程，大致如下：
		
		1. start backup

		2. copy ibdata1 / copy .ibd file

		3. Excuted ftwrl

		4. backup non-InnoDB tables and files

		5. Writing xtrabackup_binlog_info

		6. Executed FLUSH NO_WRITE_TO_BINLOG ENGINE LOGS

		7. Executed UNLOCK TABLES

		8. Copying ib_buffer_pool

		9. completed OK!

		结合备份时的 general log 可知，Xtrabackup 在执行 ftwrl 并备份完所有非 InnoDB 表格的文件后通过 show master status 获取了 binlog position 和 GTID 的信息，将其记录到 xtrabackup_binlog_info 文件中。
		
		
5. 物理备份的3个关键字
	一致性备份、事务表数据和非事务表数据、redo crash
	
	
6. 口述物理备份的流程
	1. 先拷贝redo日志，持续监听redo变化并持续复制redo
	2. 拷贝事务引擎的文件：拷贝ibdata共享表空间文件和ibd数据文件
	3. 待拷贝事务引擎文件完成，开启ftwrl全局读锁，此时数据库是处于只读状态，不可以写。
	4. 开始拷贝 frm表结构和非事务引擎文件
	5. 记录binlog位点
	6. 停止复制redo
	7. 释放全局读锁
	8. 复制内存缓冲池文件
	9. 备份完成。
	

	
