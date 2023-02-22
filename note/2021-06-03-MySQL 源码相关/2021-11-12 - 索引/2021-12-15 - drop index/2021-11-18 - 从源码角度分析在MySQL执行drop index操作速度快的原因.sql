
一、导读
二、MySQL drop index的执行速度
三、堆栈调用关系如下所示	
四、分析删除二级索引的核心执行流程
五、总结删除索引的流程
六、小结


一、导读
	
	在MySQL中执行drop index操作，几乎都是秒删除，这里的原理是我一直比较疑惑的地方。
	因此，本文主要分析在MySQL中执行drop index操作的流程。
	
二、MySQL drop index的执行速度
	
	环境：
		主机相关配置: 4核CPU、16GB内存、100GB的SSD盘
		MySQL相关：
			mysql_version: Oracle mysql-5.7.26
			innodb_buffer_pool_size=8GB
			innodb_flush_log_at_trx_commit=1
			sync_binlog=1
			innodb_adaptive_hash_index=ON
	
	数据表为sysbench标准化表结构：
		CREATE TABLE `sbtest1` (
		  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
		  `k` int(10) unsigned NOT NULL DEFAULT '0',
		  `c` char(120) NOT NULL DEFAULT '',
		  `pad` char(60) NOT NULL DEFAULT '',
		  PRIMARY KEY (`id`),
		  KEY `k_1` (`k`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
			
	生成表的行数：13亿行记录
	表的.ibd文件大小：37GB
	
	二级索引k_1的大小？
	
	
	drop index 的耗时
		mysql> alter table sbtest1 drop index k_1;
		Query OK, 0 rows affected (2.35 sec)
		Records: 0  Duplicates: 0  Warnings: 0
		
		# 耗时2.35秒
	
	drop index期间的IO利用率
		shell> iostat -dmx 1
		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sda               0.00     0.00   55.00    4.00     2.29     0.04    80.81     0.18    3.02    3.16    1.00   0.56   3.30

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sda               0.00     0.00    0.00   41.00     0.00     1.14    57.17     0.04    0.98    0.00    0.98   0.32   1.30

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sda               0.00     0.00    2.00  211.00     0.02     5.53    53.33     0.33    1.54    0.50    1.55   0.22   4.70
		
		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	
		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	
		
三、堆栈调用关系如下所示

	# 初始化表结构和数据

	DROP TABLE IF EXISTS  t1;

	CREATE TABLE `t1` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `idx_c` (`c`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

	insert into t1(`c`,`d`) values(1,1);
	insert into t1(`c`,`d`) values(3,3);
	insert into t1(`c`,`d`) values(5,5);
	
	
	# 在 btr_free_if_exists 函数打断点

	session A                           session B 
	b btr_free_if_exists
										alter table t1 drop index idx_c;	
										
	(gdb) bt
	#0  btr_free_if_exists (page_id=..., page_size=..., index_id=48592, mtr=0x7f475811eba0) at /usr/local/mysql/storage/innobase/btr/btr0btr.cc:1194
	#1  0x0000000001b8a229 in dict_drop_index_tree (rec=0x7f476a74d598 "", pcur=0x7f47741c8d48, mtr=0x7f475811eba0) at /usr/local/mysql/storage/innobase/dict/dict0crea.cc:1160
	#2  0x0000000001a73b0e in row_upd_clust_step (node=0x7f47741ca4f0, thr=0x7f47741ca998) at /usr/local/mysql/storage/innobase/row/row0upd.cc:2886
	#3  0x0000000001a74202 in row_upd (node=0x7f47741ca4f0, thr=0x7f47741ca998) at /usr/local/mysql/storage/innobase/row/row0upd.cc:3046
	#4  0x0000000001a746e1 in row_upd_step (thr=0x7f47741ca998) at /usr/local/mysql/storage/innobase/row/row0upd.cc:3192
	#5  0x00000000019bd8ef in que_thr_step (thr=0x7f47741ca998) at /usr/local/mysql/storage/innobase/que/que0que.cc:1031
	#6  0x00000000019bdbcb in que_run_threads_low (thr=0x7f47741ca998) at /usr/local/mysql/storage/innobase/que/que0que.cc:1111
	#7  0x00000000019bdd81 in que_run_threads (thr=0x7f47741ca998) at /usr/local/mysql/storage/innobase/que/que0que.cc:1151
	#8  0x00000000019be037 in que_eval_sql (info=0x7f4774061200, 
		sql=0x2237fa0 <row_merge_drop_indexes_dict(trx_t*, unsigned long)::sql> "PROCEDURE DROP_INDEXES_PROC () IS\nixid CHAR;\nfound INT;\nDECLARE CURSOR index_cur IS\n SELECT ID FROM SYS_INDEXES\n WHERE TABLE_ID=:tableid AND\n SUBSTR(NAME,0,1)='\377'\nFOR UPDATE;\nBEGIN\nfound := 1;\nOPEN in"..., reserve_dict_mutex=0, trx=0x7f4771bfed08) at /usr/local/mysql/storage/innobase/que/que0que.cc:1228
	#9  0x0000000001a02609 in row_merge_drop_indexes_dict (trx=0x7f4771bfed08, table_id=7714) at /usr/local/mysql/storage/innobase/row/row0merge.cc:3458
	#10 0x000000000190ffa8 in commit_cache_norebuild (ctx=0x7f4774011d50, table=0x7f47740347c0, trx=0x7f4771bfed08) at /usr/local/mysql/storage/innobase/handler/handler0alter.cc:8043
	#11 0x000000000190b2fa in ha_innobase::commit_inplace_alter_table (this=0x7f4774030070, altered_table=0x7f477405f2b0, ha_alter_info=0x7f4758120b90, commit=true) at /usr/local/mysql/storage/innobase/handler/handler0alter.cc:8699
	#12 0x0000000000f2fcfb in handler::ha_commit_inplace_alter_table (this=0x7f4774030070, altered_table=0x7f477405f2b0, ha_alter_info=0x7f4758120b90, commit=true) at /usr/local/mysql/sql/handler.cc:4832
	#13 0x00000000015c549e in mysql_inplace_alter_table (thd=0x7f477400caf0, table_list=0x7f4774010c18, table=0x7f47740347c0, altered_table=0x7f477405f2b0, ha_alter_info=0x7f4758120b90, inplace_supported=HA_ALTER_INPLACE_NO_LOCK_AFTER_PREPARE, 
		target_mdl_request=0x7f47581205d0, alter_ctx=0x7f4758121120) at /usr/local/mysql/sql/sql_table.cc:7626
	#14 0x00000000015ca43a in mysql_alter_table (thd=0x7f477400caf0, new_db=0x7f47740111a0 "test_db", new_name=0x0, create_info=0x7f4758121dc0, table_list=0x7f4774010c18, alter_info=0x7f4758121d10) at /usr/local/mysql/sql/sql_table.cc:9798
	#15 0x0000000001743165 in Sql_cmd_alter_table::execute (this=0x7f47740111d0, thd=0x7f477400caf0) at /usr/local/mysql/sql/sql_alter.cc:327
	#16 0x0000000001538aa0 in mysql_execute_command (thd=0x7f477400caf0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:4835
	#17 0x000000000153a849 in mysql_parse (thd=0x7f477400caf0, parser_state=0x7f4758123690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#18 0x00000000015302d8 in dispatch_command (thd=0x7f477400caf0, com_data=0x7f4758123df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#19 0x000000000152f20c in do_command (thd=0x7f477400caf0) at /usr/local/mysql/sql/sql_parse.cc:1025
	#20 0x000000000165f7c8 in handle_connection (arg=0x411de40) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#21 0x0000000001ce7612 in pfs_spawn_thread (arg=0x42eea50) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#22 0x00007f4781c76ea5 in start_thread () from /lib64/libpthread.so.0
	#23 0x00007f4780b3c9fd in clone () from /lib64/libc.so.6
	
	# 整理堆栈调用关系
	Sql_cmd_alter_table::execute —> mysql_alter_table -> mysql_inplace_alter_table 
	   -> handler::ha_commit_inplace_alter_table 
		 -> ha_innobase::commit_inplace_alter_table
			--> commit_try_norebuild  
				-> row_merge_rename_index_to_drop	
			--> commit_cache_norebuild
				-> row_merge_drop_indexes_dict
					-> que_eval_sql -> que_run_threads -> que_run_threads_low -> que_thr_step -> row_upd_step -> row_upd
						-> row_upd_clust_step -> dict_drop_index_tree
							-> btr_free_if_exists
								--> btr_free_but_not_root
									-> fseg_free_step  -> fseg_free_extent -> btr_search_drop_page_hash_when_freed    
										-> btr_search_drop_page_hash_index -> ha_remove_all_nodes_to_page	
								--> btr_free_root	
									-> btr_search_drop_page_hash_index -> ha_remove_all_nodes_to_page																	
							
		

四、分析删除二级索引的核心执行流程

ha_innobase::prepare_inplace_alter_table
	
	check_if_can_drop_indexes:
		/* Check if the indexes can be dropped. */
		/* 检查索引是否可以删除。*/
		
		/* Flag all indexes that are to be dropped. */
		/* 标记所有要删除的索引 */
		设置index->to_be_dropped = 1		
		

--------------------------------------------------------
		
ha_innobase::commit_inplace_alter_table
	-> commit_try_norebuild  
		/* Drop any indexes that were requested to be dropped.
		Flag them in the data dictionary first. */
		/* 删除所有请求删除的索引。首先在数据字典中标记它们 */
		
		-> row_merge_rename_index_to_drop
			/* We use the private SQL parser of Innobase to generate the
				query graphs needed in renaming indexes. */
			/* 在数据字典中重命名要删除的索引，在数据字典(information_schema.INNODB_SYS_INDEXES)里重命名成 TEMP_INDEX_PREFIX 前缀+index名 */
			static const char rename_index[] =
					"PROCEDURE RENAME_INDEX_PROC () IS\n"
					"BEGIN\n"
					"UPDATE SYS_INDEXES SET NAME=CONCAT('"
					TEMP_INDEX_PREFIX_STR "',NAME)\n"
					"WHERE TABLE_ID = :tableid AND ID = :indexid;\n"
					"END;\n";
					
			
				
	-> commit_cache_norebuild 
		/* 设置索引页为 FIL_NULL */
		index->page = FIL_NULL;
		
		/*													
		从数据字典 information_schema.INNODB_SYS_FIELDS、information_schema.INNODB_SYS_INDEXES 中删除索引项相关记录，并释放索引树
		其中释放索引树的过程：
			1. 先删除非根节点(btr_free_but_not_root), 同时清理非根节点数据页对应的AHI项
			2. 再删除根节点(btr_free_root), 同时清理根节点数据页对应的AHI项 
			3. btr_free_but_not_root 中会先释放 leaf segment 再释放 non-leaf segment
		*/
		-> row_merge_drop_indexes_dict
			"BEGIN\n"
			"found := 1;\n"
			"OPEN index_cur;\n"
			"WHILE found = 1 LOOP\n"
			"  FETCH index_cur INTO ixid;\n"
			"  IF (SQL % NOTFOUND) THEN\n"
			"    found := 0;\n"
			"  ELSE\n"
			"    DELETE FROM SYS_FIELDS WHERE INDEX_ID=ixid;\n"
			"    DELETE FROM SYS_INDEXES WHERE CURRENT OF index_cur;\n"
			"  END IF;\n"
			"END LOOP;\n"
			"CLOSE index_cur;\n"
			
			-> que_eval_sql
				.....
					-> dict_drop_index_tree
						-> btr_free_if_exists(){
			
							btr_free_but_not_root(root, mtr->get_log_mode());
							mtr->set_named_space(page_id.space());
							btr_free_root(root, mtr);
							btr_free_root_invalidate(root, mtr);
						}
																

		/* 从 dictionary cache 中删除索引 */ 	
		-> dict_index_remove_from_cache
			
		/* 提交事务，删除索引操作完成。*/
		-> trx_commit_for_mysql 
			


五、总结删除索引的流程


	1. 检查索引是否可以删除, 并且标记所有要删除的索引(设置index->to_be_dropped = 1)；不需要对二级索引的记录打删除标记。 
		
	2. 删除所有需要删除的索引。
	
		1. 在数据字典中通过重命名索引: 对将需要drop的index，在数据字典(information_schema.INNODB_SYS_INDEXES)里rename成 TEMP_INDEX_PREFIX 前缀+index名。
			
		2. 在数据字典缓存中标记要删除的索引: 设置 index->page = FIL_NULL。
			
	3. 从数据字典 information_schema.INNODB_SYS_FIELDS、information_schema.INNODB_SYS_INDEXES 中删除索引项相关记录，并释放索引树。
		
		释放索引树的过程：
			先删除非根节点(btr_free_but_not_root), 同时清理非根节点数据页对应的AHI项;
			再删除根节点(btr_free_root), 同时清理根节点数据页对应的AHI项;
			btr_free_but_not_root 中会先释放 leaf segment 再释放 non-leaf segment。
			
	4. 从 dictionary cache 中删除索引。
	
	5. 提交事务，删除索引操作完成。
	
	6. 由于被drop的索引段已经被设置为free，因此可以重用Page。
																	

六、小结


	删除二级索引，会直接释放索引树，并不需要扫描二级索引的记录并对其打删除标记，因此执行速度很快。
		


	B+树数据结构，释放一个二级索引树的速度会很快？
	
	