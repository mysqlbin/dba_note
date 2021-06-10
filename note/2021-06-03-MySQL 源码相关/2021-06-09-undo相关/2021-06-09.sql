

大纲
	1. Insert操作和Update操作的 Undo Record 格式

	2. 事务回滚
		2.1 Insert操作调用 row_undo_ins()回滚	
		2.2 Update操作调用 row_undo_mod()回滚

	3. undo记录的主要类型为2个大类

		3.1 源码部分
		3.2 insert的undo 
		3.3 update和delete的undo
		3.4 DML操作在undo中的记录
		3.5 原地更新的源码入口处
	
	4. DML操作对应的undo 
			
		4.1 样例1--没有二级索引-DML操作对应的undo
		4.2 样例2--有二级索引-DML操作对应的undo


1. Insert操作和Update操作的 Undo Record 格式

	/* mysql-5.7.26\storage\innobase\trx\trx0rec.cc */
	
	Insert操作的 Undo Record 格式	
		trx_undo_page_report_insert
		
			offset = trx_undo_page_report_insert(undo_page, trx, index, clust_entry, &mtr);
			/* Reports in the undo log of an insert of a clustered index record. */
			在插入聚集索引记录的undo日志中报告。
			
	Update操作的 Undo Record 格式
		trx_undo_page_report_modify
			/* Reports in the undo log of an update or delete marking of a clustered index record. */
			在undo日志中报告聚集索引记录的更新或删除标记。
			
		
trx_undo_read_v_idx




2. 事务回滚


	/***********************************************************//**
	Undoes a row operation in a table. This is a high-level function used
	in SQL execution graphs.
	@return query thread to run next or NULL */
	que_thr_t*
	row_undo_step(
	/*==========*/
		que_thr_t*	thr)	/*!< in: query thread */
		
	如果事务因为异常或者被显式的回滚了，那么所有数据变更都要改回去。这里就要借助回滚日志中的数据来进行恢复了。

	入口函数为：row_undo_step --> row_undo
	
	操作也比较简单，析取老版本记录，做逆向(反向)操作即可：
		
		对于标记删除的记录清理删除标记；
		对于in-place(原地)更新，将数据回滚到最老版本；
		对于插入操作，直接删除二级索引和主键索引的记录（row_undo_ins）。
		
		具体的操作中，先回滚二级索引记录（row_undo_mod_del_mark_sec、row_undo_mod_upd_exist_sec、row_undo_mod_upd_del_sec），再回滚聚集索引记录（row_undo_mod_clust）。


2.1 Insert操作调用 row_undo_ins()回滚
	
	
	假如是 Insert 操作，则调用 row_undo_ins() 回滚，直接删除二级索引和主键索引上的数据  -- 通过源码验证了这一理论。
		
	具体的操作中，先回滚二级索引记录（row_undo_mod_del_mark_sec、row_undo_mod_upd_exist_sec、row_undo_mod_upd_del_sec），再回滚聚集索引记录（row_undo_mod_clust）。
	
	/* mysql-5.7.26\storage\innobase\row\row0uins.cc */

	/***********************************************************//**
	Undoes a fresh insert of a row to a table. A fresh insert means that
	the same clustered index unique key did not have any record, even delete
	marked, at the time of the insert.  InnoDB is eager in a rollback:
	if it figures out that an index record will be removed in the purge
	anyway, it will remove it in the rollback.
	@return DB_SUCCESS or DB_OUT_OF_FILE_SPACE */

	/*
	撤消对表的新行插入。 一个新的插入意味着相同的聚集索引唯一键在插入时没有任何记录，甚至没有删除标记。 InnoDB 渴望回滚：
		如果它发现将在清除中删除索引记录
		无论如何，它会在回滚中删除它。
	*/

	dberr_t
	row_undo_ins(

		row_undo_ins_parse_undo_rec(node, dict_locked);

		if (node->table == NULL) {
			return(DB_SUCCESS);
		}
		
		/* 先删除二级索引的记录 */
		err = row_undo_ins_remove_sec_rec(node, thr);
		
		
		// FIXME: We need to update the dict_index_t::space and
		// page number fields too.
		
		/* 删除主键索引的记录 */
		err = row_undo_ins_remove_clust_rec(node);
		
		
		------------------------------------------------------------------------------------------------------
		
		row_undo_ins->row_undo_ins_remove_sec_rec
		/* 先删除二级索引的记录 */
		/***************************************************************//**
		Removes secondary index records.
		@return DB_SUCCESS or DB_OUT_OF_FILE_SPACE */
		
		static MY_ATTRIBUTE((nonnull, warn_unused_result))
		dberr_t
		row_undo_ins_remove_sec_rec(
		/*========================*/
			undo_node_t*	node,	/*!< in/out: row undo node */
			que_thr_t*	thr)	/*!< in: query thread */
			
		
		------------------------------------------------------------------------------------------------------
		
		row_undo_ins->row_undo_ins_remove_clust_rec
		/* 删除主键索引的记录 */
		/***************************************************************//**
		Removes a clustered index record. The pcur in node was positioned on the
		record, now it is detached.
		@return DB_SUCCESS or DB_OUT_OF_FILE_SPACE */
		static  MY_ATTRIBUTE((nonnull, warn_unused_result))
		dberr_t
		row_undo_ins_remove_clust_rec(
		/*==========================*/
			undo_node_t*	node)	/*!< in: undo node */
			
		
		

		
2.2 Update操作调用 row_undo_mod()回滚
		
		
	Update 操作选择 row_undo_mod()将更新过的数据利用 Undo Log 还原, 与数据直接写入原理相同(btr_cur_optimistic_insert()).


	/* mysql-5.7.26\storage\innobase\row\row0umod.cc */

	/***********************************************************//**
	Undoes a modify operation on a row of a table.
	@return DB_SUCCESS or error code */
	dberr_t
	row_undo_mod(

		switch (node->rec_type) {
		/* UPDATE的undo日志类型为TRX_UNDO_UPD_EXIST_REC */
		case TRX_UNDO_UPD_EXIST_REC:
			err = row_undo_mod_upd_exist_sec(node, thr);
			break;
			
		/* DELETE 的undo日志类型为 TRX_UNDO_DEL_MARK_REC */
		case TRX_UNDO_DEL_MARK_REC:
			err = row_undo_mod_del_mark_sec(node, thr);
			break;
			
		case TRX_UNDO_UPD_DEL_REC:
			err = row_undo_mod_upd_del_sec(node, thr);
			break;
		default:
			ut_error;
			err = DB_ERROR;
		}
		
		
		if (err == DB_SUCCESS) {

			err = row_undo_mod_clust(node, thr);
		}
		
		
		------------------------------------------------------------------------------------------------------
		
		row_undo_mod->row_undo_mod_upd_exist_sec
		/***********************************************************//**
		Undoes a modify in secondary indexes when undo record type is UPD_EXIST.  当撤消记录类型为 UPD_EXIST 时，撤消二级索引中的修改。
		@return DB_SUCCESS or DB_OUT_OF_FILE_SPACE */
		static MY_ATTRIBUTE((nonnull, warn_unused_result))
		dberr_t
		row_undo_mod_upd_exist_sec(
		/*=======================*/
			undo_node_t*	node,	/*!< in: row undo node */
			que_thr_t*	thr)	/*!< in: query thread */	
			
			
		
		------------------------------------------------------------------------------------------------------

		
		/***********************************************************//**
		Undoes a modify in secondary indexes when undo record type is DEL_MARK.  当撤消记录类型为 DEL_MARK 时，撤消二级索引中的修改。
		@return DB_SUCCESS or DB_OUT_OF_FILE_SPACE */
		static MY_ATTRIBUTE((nonnull, warn_unused_result))
		dberr_t
		row_undo_mod_del_mark_sec(
		/*======================*/
			undo_node_t*	node,	/*!< in: row undo node */
			que_thr_t*	thr)	/*!< in: query thread */

		
		------------------------------------------------------------------------------------------------------
		
		/***********************************************************//**
		Undoes a modify in secondary indexes when undo record type is UPD_DEL.   当撤消记录类型为 UPD_DEL 时，撤消二级索引中的修改。
		@return DB_SUCCESS or DB_OUT_OF_FILE_SPACE */
		static MY_ATTRIBUTE((nonnull, warn_unused_result))
		dberr_t
		row_undo_mod_upd_del_sec(
		/*=====================*/
			undo_node_t*	node,	/*!< in: row undo node */
			que_thr_t*	thr)	/*!< in: query thread */



--------------------------------------------------------------------------------------------------------------------------------------

3. undo记录的主要类型为2个大类

	3.1 源码部分

		/* mysql-5.7.26\storage\innobase\include\trx0rec.h */

		/* Types of an undo log record: these have to be smaller than 16, as the
		compilation info multiplied by 16 is ORed to this value in an undo log
		record */

		#define	TRX_UNDO_INSERT_REC	11	/* fresh insert into clustered index */
		#define	TRX_UNDO_UPD_EXIST_REC	12	/* update of a non-delete-marked
							record */                             更新未被标记delete的记录
		#define	TRX_UNDO_UPD_DEL_REC	13	/* update of a delete marked record to
							a not delete marked record; also the
							fields of the record can change */    将delete的记录标记为not delete, 记录的字段也可以更改

		#define	TRX_UNDO_DEL_MARK_REC	14	/* delete marking of a record; fields
							do not change */					  将记录标记为delete
		#define	TRX_UNDO_CMPL_INFO_MULT	16	/* compilation info is multiplied by
							this and ORed to the type above */
		#define	TRX_UNDO_UPD_EXTERN	128	/* This bit can be ORed to type_cmpl
							to denote that we updated external
							storage fields: used by purge to
							free the external storage */
							
							
						
		其中 TRX_UNDO_INSERT_REC 为insert的undo，其他为update和delete的undo。

		之所以把undo日志分成两个大类，是因为类型为TRX_UNDO_INSERT_REC的undo日志在事务提交后可以直接删除掉，而其他类型的undo日志还需要为所谓的MVCC服务，不能直接删除掉，对它们的处理需要区别对待。
			https://juejin.cn/book/6844733769996304392/section/6844733770071801869
			
		
	3.2 insert的undo 
		INSERT操作对应的undo日志： TRX_UNDO_INSERT_REC 日志

	3.3 update和delete的undo
	
		总共3种 update undo 类型:
		
			2.1 TRX_UNDO_UPD_EXIST_REC: 
				更新未被标记delete的记录
				-- 标记删除操作, 未修改任何列值, 这既可能是普通的删除操作产生, 也可能是使用delete mark + insert 的更新导致(例如修改聚集索引键值: delete mark + insert)
				-- 原地更新: 				 更新记录时，对于被更新的每个列来说，如果更新后的列和更新前的列占用的存储空间都一样大，那么就可以进行就地更新，也就是直接在原记录的基础上修改对应列的值。
				-- 非原地更新(先删除再插入): 如果有任何一个被更新的列更新前和更新后占用的存储空间大小不一致，那么就需要先把这条旧的记录从聚簇索引页面中删除掉，然后再根据更新后列的值创建一条新的记录插入到页面中。
				
			2.2 TRX_UNDO_UPD_DEL_REC:    
				将delete的记录标记为not delete
				-- 更新一个已被标记删除的记录, 列值可被修改;
				-- 在 InnoDB里 这是允许的, 例如某个记录被删除后,再很快插入相同键值的记录, 之前的记录若还未被purge, 就可能重用该记录所在的位置
				-- 先不看
			
				
			2.3 TRX_UNDO_DEL_MARK_REC:
				将记录标记为delete
				-- 更新一个未被标识删除的记录(普通更新)	
				
	
	3.4 DML操作在undo中的记录
	
		1. 对于insert和delete，undo中会记录键值(主键索引和二级索引的值)，delete操作只是标记删除(delete mark)记录。
	
		2. 对于update：
			1. 原地更新：undo中会记录键值(主键索引和二级索引的值)和老值(非索引值)。
			2. 非原地更新：
				通过delete+insert方式进行的，则undo中记录主键值(方便查找这一行记录)，不需记录老值; 其中delete也是标记删除记录。
				-- 回滚的时候，清除删除标识就行了。
		
			3. 对于update操作有原地更新和delete+insert两种，那么怎么区分undo记录使用的哪种方式呢？
	 
				原地更新条件：更新没有改变值的长度且也没有更新行外数据，具体可参考 row_upd_changes_field_size_or_external
				
	
		3. 二级索引的更新总是delete+insert方式进行。具体日志格式参考 trx_undo_report_row_operation 。


	
	3.5 原地更新的源码入口处
	
		/* mysql-5.7.26\storage\innobase\row\row0upd.cc */
		
		/***********************************************************//**
		Updates a clustered index record of a row when the ordering fields do
		not change.
		@return DB_SUCCESS if operation successfully completed, else error
		code or DB_LOCK_WAIT */
		static MY_ATTRIBUTE((warn_unused_result))
		dberr_t
		row_upd_clust_rec(
		
		
			/* Try optimistic updating of the record, keeping changes within
			the page; we do not check locks because we assume the x-lock on the
			record to update */

			if (node->cmpl_info & UPD_NODE_NO_SIZE_CHANGE) {
				err = btr_cur_update_in_place(
					flags | BTR_NO_LOCKING_FLAG, btr_cur,
					offsets, node->update,
					node->cmpl_info, thr, thr_get_trx(thr)->id, mtr);
			} else {
				err = btr_cur_optimistic_update(
					flags | BTR_NO_LOCKING_FLAG, btr_cur,
					&offsets, offsets_heap, node->update,
					node->cmpl_info, thr, thr_get_trx(thr)->id, mtr);
			}

		------------------------------------------------------------------------------------------------------------------------------------------------
		
		/* mysql-5.7.26\storage\innobase\btr\btr0cur.cc */
		dberr_t
		btr_cur_optimistic_update(
		){		
					
				
			if (!row_upd_changes_field_size_or_external(index, *offsets, update)) {

				/* The simplest and the most common case: the update does not
				change the size of any field and none of the updated fields is
				externally stored in rec or update, and there is enough space
				on the compressed page to log the update. */
				
				/*最简单最常见的情况：更新不更改任何字段的大小，并且没有更新的字段是外部存储在rec或update中（更新的列字段长度没有变化，并且没有更新外行记录），并且有足够的空间在压缩页面上记录更新。*/
				
				return(btr_cur_update_in_place(
						   flags, cursor, *offsets, update,
						   cmpl_info, thr, trx_id, mtr));
			}
		}
				



		
4. DML操作对应的undo 
		
	4.1 样例1--没有二级索引-DML操作对应的undo
		t(id PK, name);

		数据为：

		1, lujianbin

		2, zhangsan

		3, lisi	
		
		
		最新数据                                   		           回滚段(此时没有事务未提交，故回滚段是空的。)
		t(id PK, name);
		
		1, lujianbin

		2, zhangsan

		3, lisi	
		
		
		update原地更新:
			-- 对于update，如果是原地更新，undo中会记录键值和老值。
			
			接着启动了一个事务,并且事务处于未提交的状态：	           回滚段			            
																	  t(id PK, name);
			start transaction;
				 
			delete from t where id=1;                                 (1)           # 对于delete，undo中会记录键值
			
			update set  name = 'lili' where id=3;                     (3, 'lisi')   # 对于update，如果是原地更新，undo中会记录键值和老值(name='lisi')；如果需要回滚，直接回滚到最老版本。
				
			insert into t(name) values('wangwu');                     (4)           # 对于insert，undo中会记录键值
			
			
			最新数据
			
			t(id PK, name);
			
			1, lujianbin

			2, zhangsan

			3, lisi	
			
			
		
		update通过 delete+insert 方式进行:
			-- update如果是通过delete+insert方式进行的，则undo中记录键值，不需记录老值。
				
			接着启动了一个事务,并且事务处于未提交的状态：	           回滚段			            
																	  t(id PK, name);
			start transaction;
				 
			update set  name = 'lilis' where id=3;                    (id=3)   
																	  update如果是通过delete+insert方式进行的，则undo中记录键值，不需记录老值。
																		delete from where id=3; 
																		insert into t(id, name)  values(3,'lilis'); 
																		
																	  如果需要回滚：
																		先把 insert into t(id, name)  values(3,'lilis'); 插入的记录直接删除，
																		再对 delete from where id=3; 的记录 清理删除标记，回滚完成。
		
			此时的最新数据
			
			t(id PK, name);

			3, lilis	
			
		画图会更好理解。
		

	4.2 样例2--有二级索引-DML操作对应的undo
			
		
	对于insert和delete，undo中会记录键值(主键索引和二级索引的值)，delete操作只是标记删除(delete mark)记录。
	
	样例
		CREATE TABLE `mytest_undo_demo` (
		  `id` int(11) NOT NULL,
		  `name` varchar(100) DEFAULT NULL,
		  `age` int(100) DEFAULT NULL,
		  PRIMARY KEY (`id`),
		  KEY `idx_name` (`name`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

		INSERT INTO `mytest_undo_demo` (`id`, `name`, `age`) VALUES ('1', 'lujianbin', '28');
		INSERT INTO `mytest_undo_demo` (`id`, `name`, `age`) VALUES ('2', 'zhangsan', '25');
		INSERT INTO `mytest_undo_demo` (`id`, `name`, `age`) VALUES ('3', 'lisi', '23');

		数据

		1, lujianbin

		2, zhangsan

		3, lisi	
		
		
		最新数据                                   		           回滚段(此时没有事务未提交，故回滚段是空的。)
		
		1, lujianbin

		2, zhangsan

		3, lisi	
		
	
	delete-mark 
	
		接着启动了一个事务,并且事务处于未提交的状态：	           回滚段			            
																	
			start transaction;
			delete from mytest_undo_demo where id=1;               (id=1,name='lujianbin')      # 对于delete，undo中会记录键值, 所以这里记录的是id=1,name='lujianbin'。
			(delete-mark)
			rollback;
			
		回滚的步骤:
			析取老版本记录，做逆向操作即可: 清理delete-mark删除标识.


	update通过 delete+insert 方式进行:
	
		-- update如果是通过delete+insert方式进行的，则undo中记录键值，不需记录老值。
		
		接着启动了一个事务,并且事务处于未提交的状态：	           回滚段			            
																  t(id PK, name);
		start transaction;
			 
		update set  name = 'ljb', age=15 where id=1;              (id=1, name="lujianbin")   
																  update如果是通过delete+insert方式进行的，则undo中记录键值，不需记录老值, 所以不需要记录 age=28 的值。
																	delete: delete from where id=1; 
																	insert: insert into t(id, name)  values(1,'ljb'); 
																	
																  如果需要回滚：
																	先把 insert into t(id, name)  values(1,'ljb'); 插入的记录直接删除
																		先删除二级索引的记录，再删除主键索引的记录。
																	再对 delete from where id=1; 的记录 清理删除标记，回滚完成。
	
		此时的最新数据
		
		t(id PK, name);

		3, lilis	
			
			




	
purge:

	undo回收
		undo中保存老记录的历史版本, 当这些历史版本不再需要时，交由purge清理。
		
	删除记录
		事务提交后，仍然可能有标记删除的记录存在。这些记录在purge时真正删除, 释放物理页空间作为碎片/空间可以复用。 (没毛病)
	
	 	
	一条事务执行期间InnoDB对undo的处理:
	
		事务执行过程中: 写undo
			1. 对于insert和delete，undo中会记录主键值，delete操作只是标记删除(delete mark)记录。
		
			2. 对于update：
				1. 原地更新：undo中会记录键值和老值。
				2. 非原地更新：
					通过delete+insert方式进行的，则undo中记录主键值(方便查找这一行记录)，不需记录老值; 其中delete也是标记删除记录。
					-- 回滚的时候，清除删除标识就行了。
			
				3. 对于update操作有原地更新和delete+insert两种，那么怎么区分undo记录使用的哪种方式呢？
		 
					原地更新条件：更新没有改变值的长度且也没有更新行外数据，具体可参考 row_upd_changes_field_size_or_external
					
		
			3. 二级索引的更新总是delete+insert方式进行。具体日志格式参考 trx_undo_report_row_operation 。

	
		事务提交过程中:
		
			会将undo信息加入purge列表(history list)，供purge线程处理。
		
		事务提交后:
			purge线程真正删除，释放物理页空间。
		
		事务提交后，会将undo日志信息(保存在trx_rseg_t中）加入到队列purge_queue中，purge_queue是以trx->id排序的最小堆。
			purge线程从purge_queue中获取符合条件（trx->id < oldest_view->m_low_limit_no)的undo并依次purge回收。
			https://mp.weixin.qq.com/s/UxawgHGembMKK2lA33ZQDA
			
	小结
		undo日志应该及时purge，undo日志的堆积不仅会导致回滚段空间的增长，而且delete mark的记录没有真正删除，也会影响查询的效率。	
	
	注意:
		事务回滚和 MVCC，这就需要 undo。undo 是逻辑日志，只是将数据库逻辑恢复到原来的样子，但是数据结构和页本身在回滚之后可能不同。
		例如：用户执行 insert 10w 条数据的事务，表空间因而增大。用户执行 ROLLBACK 之后，会对插入的数据回滚，但是表空间大小不会因此收缩。
		
		

	https://www.cnblogs.com/exceptioneye/p/5451960.html  MySQL事务提交过程（一）
  
	从上述流程可以看出，提交过程中，主要做了4件事情，

	1、清理undo段信息，对于innodb存储引擎的更新操作来说，undo段需要purge，这里的purge主要职能是，真正删除物理记录。
		在执行delete或update操作时，实际旧记录没有真正删除，只是在记录上打了一个标记，而是在事务提交后，purge线程真正删除，释放物理页空间。因此，提交过程中会将undo信息加入purge列表，供purge线程处理。
		

	
	
https://www.leviathan.vip/2019/03/20/InnoDB%E7%9A%84%E4%BA%8B%E5%8A%A1%E5%88%86%E6%9E%90-MVCC/




