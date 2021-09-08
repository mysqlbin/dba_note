
大纲
	1. mini transation 主要作用

	2. mini-transaction遵循以下三个协议

		2.1 The FIX Rules

		2.2 Write-Ahead Log

		2.3 Force-log-at-commit

	3. mtr案例

		3.1 案例1 

	4. mini transaction、LATCH、数据插入的函数堆栈
	5. 每个 mini-transaction 会遵守下面的几个规则
	6. 相关参考



1. mini transation 主要作用

	主要用于innodb redo log 和 undo log写入的时候，保证两种日志的ACID特性。
		
		
		
2.1 The FIX Rules
	
	修改一个页需要获得该页的x-latch

	访问一个页是需要获得该页的s-latch或者x-latch

	持有该页的latch直到修改或者访问该页的操作完成

2.2 Write-Ahead Log

	持久化一个数据页之前，必须先将内存中相应的日志页持久化

	每个页有一个LSN,每次页修改需要维护这个LSN,当一个页需要写入到持久化设备时，要求内存中小于该页LSN的日志先写入到持久化设备中
	-- WAL 先行
	
2.3 Force-log-at-commit
	
	一个事务可以同时修改了多个页，Write-AheadLog可以保证单个数据页的一致性，无法保证事务的持久性

	Force -log-at-commit要求当一个事务提交时，其产生所有的mini-transaction日志必须刷到持久设备中

	这样即使在脏页数据刷盘的时候宕机，也可以通过日志进行redo恢复。

	
	
3.1 案例1 

	-- insert 语句修改了多个页
	
	CREATE TABLE `t1` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `key1` varchar(100) DEFAULT NULL,
	  `key2` int(11) DEFAULT NULL,
	  `key3` varchar(100) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `idx_key1` (`key1`),
	  KEY `idx_key3` (`key3`)
	) ENGINE=InnoDB AUTO_INCREMENT=10001 DEFAULT CHARSET=utf8mb4;
	
	首先，redo log 记录的是某个表空间某个数据页的偏移量对应的位置做了什么修改。

	insert 语句：

		INSERT INTO `t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('1', '1', '1', '1');
	
	这里的t1表有3个索引，即3棵B+TREE
	
	当插入一行记录，就需要分别往3棵B+TREE的数据页中写入数据(修改了不同B+TREE的不同page)

	这样的一条语句就会生成3个redo log和1个undo log，因为要保证这些操作是原子的。
	
	所以这3个redo log成为一组，mtr包含了这一组的redo log + 1个undo log。

	所以一个所谓的mtr可以包含一组redo日志，在进行崩溃恢复时这一组redo日志作为一个不可分割的整体。 --理解了。
	
	
4. mini transaction、LATCH、数据插入的函数堆栈
	
	函数堆栈为：row_ins_clust_index_entry_low -> btr_cur_search_to_nth_level -> btr_cur_latch_leaves。
	-- 后面可以根据这些函数堆栈进行扩展

	UNIV_INTERN
	dberr_t
	row_ins_clust_index_entry_low(
	/*==========================*/
		ulint        flags,    /*!< in: undo logging and locking flags */
		ulint        mode,    /*!< in: BTR_MODIFY_LEAF or BTR_MODIFY_TREE,
					depending on whether we wish optimistic or
					pessimistic descent down the index tree */
		dict_index_t*    index,    /*!< in: clustered index */
		ulint        n_uniq,    /*!< in: 0 or index->n_uniq */
		dtuple_t*    entry,    /*!< in/out: index entry to insert */
		ulint        n_ext,    /*!< in: number of externally stored columns */
		que_thr_t*    thr)    /*!< in: query thread */
	{
		/* 开启一个 mini-transaction */
		mtr_start(&mtr);
		 
		-- 调用 btr_cur_latch_leaves -> btr_block_get 加 RW_X_LATCH 
		btr_cur_search_to_nth_level(index, 0, entry, PAGE_CUR_LE, mode,
						&cursor, 0, __FILE__, __LINE__, &mtr);
		 
		if (mode != BTR_MODIFY_TREE) {
			/* 不需要修改 BTR_TREE，乐观插入 */
			err = btr_cur_optimistic_insert(
				flags, &cursor, &offsets, &offsets_heap,
				entry, &insert_rec, &big_rec,
				n_ext, thr, &mtr);
		} else {
			/* 需要修改 BTR_TREE，先乐观插入，乐观插入失败则进行悲观插入 */
			err = btr_cur_optimistic_insert(
				flags, &cursor,
				&offsets, &offsets_heap,
				entry, &insert_rec, &big_rec,
				n_ext, thr, &mtr);
			if (err == DB_FAIL) {
				err = btr_cur_pessimistic_insert(
					flags, &cursor,
					&offsets, &offsets_heap,
					entry, &insert_rec, &big_rec,
					n_ext, thr, &mtr);
			}
		}
		 
		/* 提交 mini-transaction */
		mtr_commit(&mtr);
	}



5. 每个 mini-transaction 会遵守下面的几个规则

	修改一个页需要获得该页的 X-LATCH；
	访问一个页需要获得该页的 S-LATCH 或 X-LATCH；
	持有该页的 LATCH 直到修改或者访问该页的操作完成。
	
	
6. 相关参考
	https://xnerv.wang/what-innodb-mini-transation/		
	https://segmentfault.com/a/1190000017888478		浅析MySQL事务中的redo与undo
	