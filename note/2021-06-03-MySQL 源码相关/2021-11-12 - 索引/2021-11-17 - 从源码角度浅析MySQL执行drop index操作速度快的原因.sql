
删除二级索引的具体流程如下：			
	Sql_cmd_alter_table::execute
		-> mysql_alter_table
			-> mysql_inplace_alter_table
				-> handler::ha_commit_inplace_alter_table 
					-> ha_innobase::commit_inplace_alter_table
						-> commit_try_norebuild  
							-> row_merge_rename_index_to_drop
						-> commit_cache_norebuild
							-> row_merge_drop_indexes_dict
								-> que_eval_sql
									-> que_run_threads
										-> que_run_threads_low
											-> que_thr_step
												-> row_upd_step
													-> row_upd
														-> row_upd_clust_step
															-> dict_drop_index_tree
																-> btr_free_if_exists
																
																
																
ha_innobase::prepare_inplace_alter_table
	
	check_if_can_drop_indexes:
		/* Check if the indexes can be dropped. */
		-- 检查索引是否可以删除。 
		
		/* Flag all indexes that are to be dropped. */
		-- 标记所有要删除的索引
		设置index->to_be_dropped = 1		
		

		
ha_innobase::commit_inplace_alter_table
	-> commit_try_norebuild  
		/* Drop any indexes that were requested to be dropped.
		Flag them in the data dictionary first. */
		-- 删除所有请求删除的索引。首先在数据字典中标记它们 
		
		-> row_merge_rename_index_to_drop
			/* We use the private SQL parser of Innobase to generate the
				query graphs needed in renaming indexes. */
			-- 重命名字典中要删除的索引，将需要drop的index 在数据词典(information_schema.INNODB_SYS_INDEXES)里rename成 TEMP_INDEX_PREFIX 前缀+index名
			static const char rename_index[] =
					"PROCEDURE RENAME_INDEX_PROC () IS\n"
					"BEGIN\n"
					"UPDATE SYS_INDEXES SET NAME=CONCAT('"
					TEMP_INDEX_PREFIX_STR "',NAME)\n"
					"WHERE TABLE_ID = :tableid AND ID = :indexid;\n"
					"END;\n";
					
			
				
	-> commit_cache_norebuild 
		-- 设置索引页为 FIL_NULL
		index->page = FIL_NULL;
		
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
						-> btr_free_if_exists
																
																
			从数据词典 information_schema.INNODB_SYS_FIELDS、information_schema.INNODB_SYS_INDEXES 中删除索引项相关记录，并释放索引树
			其中释放索引树的过程：
				1. 先删除非根节点(btr_free_but_not_root), 同时清理非根节点数据页对应的AHI项
				2. 再删除根节点(btr_free_root), 同时清理根节点数据页对应的AHI项 
				3. btr_free_but_not_root 中会先释放 leaf segment 再释放 non-leaf segment
				
		-> dict_index_remove_from_cache
			-- 从 dictionary cache 中删除索引
			
		-> trx_commit_for_mysql
			
			--  提交事务，删除索引操作完成。
			
			
			

	索引删除的流程：

		1. 检查索引是否可以删除, 并且标记所有要删除的索引(设置index->to_be_dropped = 1)
			index->to_be_dropped = 1 ： 只是标记这个索引将要被删除，不涉及到对索引的记录打删除标记。 
			
		2. 删除所有需要删除的索引，
			1. 首先在数据字典中通过重命名标记它们：
				对将需要drop的index，在数据字典(information_schema.INNODB_SYS_INDEXES)里rename成 TEMP_INDEX_PREFIX 前缀+index名
				
			2. 	设置 index->page = FIL_NULL
				Mark the index dropped in the data dictionary cache
				标记数据字典缓存中删除的索引。
				
		3. 从数据词典 information_schema.INNODB_SYS_FIELDS、information_schema.INNODB_SYS_INDEXES 中删除索引项相关记录，并释放索引树
			
			其中释放索引树的过程：
				1. 先删除非根节点(btr_free_but_not_root), 同时清理非根节点数据页对应的AHI项
				2. 再删除根节点(btr_free_root), 同时清理根节点数据页对应的AHI项 
				3. btr_free_but_not_root 中会先释放 leaf segment 再释放 non-leaf segment
				
		4. 从 dictionary cache 中删除索引
		
		5. 提交事务，删除索引操作完成。
		
		6. 由于被drop的索引段已经被设置为free，因此可以重用Page。
																		
		