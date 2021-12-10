

物理备份的原理比逻辑备份会复杂一点
	
	主要就是做拷贝数据文件的操作：redo、ibdata、事务引擎的数据文件、加全局读锁、非事务引擎文件、binlog位点信息、等待redo拷贝完成，释放全局读锁
	-- 自己描述出来的，更容易理解一些	

详情
	
	1. 从Last checkpoint at（上一次检查点的位置）开始复制已有的redo log，然后监听redo log变化并持续复制
		
	2. 复制ibdata1共享表空间文件和事务引擎数据文件
		Copying ./ibdata1 to /data/backup/2020-03-15_19-46-09/ibdata1
		Copying ./mysql/plugin.ibd to /data/backup/2020-03-15_19-46-09/mysql/plugin.ibd
		
	3. 等待事务引擎数据文件复制完成
		
	4. 加锁：全局读锁
		-- 此时不可以写
		
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
		-- 数据恢复的时候，从 checkpoint 检查点开始应用 redo log 到原数据页中。
		-- 记录最新的redo。
		
	8. 待redo日志拷贝完成，停止复制redo log
		xtrabackup: Stopping log copying thread.
		
	9. 解锁：全局读锁
		Executing UNLOCK TABLE
		 -- 保证 数据+redo和binlog的一致性、保证事务引擎表数据和非事务引擎表数据的一致性。
	10. 拷贝buffer pool文件
		Copying ib_buffer_pool to /data/backup/2020-03-15_19-46-09/ib_buffer_pool
		
	11. 备份完成

	-- 容易忘记
