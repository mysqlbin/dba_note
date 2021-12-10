

两阶段提交
	binlog 是Server层的， Redo log是InnoDB存储引擎层的， 是两个互不想干的逻辑，为了让它们保持逻辑上的一致，因此需要两阶段提交，把Redo log的写入操作拆分成 redo log prepare 和 commit 这2个阶段。
	先写redo log 后写 binlog，或者先写 binlog 后写 redo log，都会存在问题。
		-- 结合半同步/增强半同步场景，在宕机后HA发生切换，导致数据丢失。
		


组提交发生在哪个阶段
	1. 同时处于 prepare 状态的事务
	2. 处于 prepare 状态的事务，与处于 commit 状态的事务之间



并行复制
	
	
	writeset是先根据commit_order分配last_committed和sequence_number，然后在根据writeset hash表进行冲突检测，再确定last_commit的值。


last_committed：
	组提交中，记录每组的leader序列号，即每组事务的最小序列号

sequence_number：
	记录每个事务的序列号，唯一值
	
	