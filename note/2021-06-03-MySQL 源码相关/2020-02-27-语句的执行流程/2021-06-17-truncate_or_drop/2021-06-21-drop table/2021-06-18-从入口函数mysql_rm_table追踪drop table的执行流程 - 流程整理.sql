
E:\github\mysql-5.7.26\sql\sql_table.cc
	mysql  sql 目录 是什么文件
	MySQL服务器主要代码，这里包含了main函数（main.cc），将会生成mysqld可执行文件；


0. DROP TABLE的源代码调用关系大致为
	row_drop_table_for_mysql --> row_mysql_lock_data_dictionary
							 |__ trx_start_for_ddl
							 |__ clean up data dictionary
							 |__ row_drop_table_from_cache
							 |__ row_drop_single_table_tablespace --> fil_delete_tablespace --> buf_LRU_flush_or_remove_pages
							 |                                                              |__ os_file_delete --> unlink
							 |__ row_mysql_unlock_data_dictionary
							 
							 

1. mysql_rm_table
	
	1.1 mysql_rm_table
	1.2 mysql_rm_table->find_table_for_mdl_upgrade
	1.3 mysql_rm_table->mysql_rm_table_no_locks
		-- 获得表的MDL写锁
	1.4 mysql_rm_table->mysql_rm_table_no_locks->ha_delete_table
	1.5 mysql_rm_table->mysql_rm_table_no_locks->ha_delete_table->handler::ha_delete_table
	1.6 mysql_rm_table->mysql_rm_table_no_locks->ha_delete_table->handler::ha_delete_table->handler::delete_table


2. ha_innobase::delete_table

	2.1 ha_innobase::delete_table
	
	2.2 ha_innobase::delete_table->row_drop_table_for_mysql
	
	2.3 ha_innobase::delete_table->row_drop_table_for_mysql->row_mysql_lock_data_dictionary
		-- 锁住数据字典（独占锁）
		-- 通过代码我们可以看到drop table调用row_drop_table_for_mysql函数时，在row_mysql_lock_data_dictionary(trx);位置对元数据加了排它锁
		
	2.4 ha_innobase::delete_table->row_drop_table_for_mysql->trx_start_for_ddl
	
	2.5 clean up data dictionary
		-- 拼接了一个巨大的SQL，用来从系统表中清理信息
		-- 其中， 从 SYS_INDEXES 表中删除一行也会释放与索引关联的 B 树的文件段(释放索引树)。	
			-- que_eval_sql 
	
				-> row_drop_table_for_mysql	
					-> que_eval_sql	
						-> que_run_threads	
							-> que_run_threads_low	
								-> que_thr_step	
									 -> row_upd_step	
										-> row_upd	
											-> row_upd_clust_step	
												-> dict_drop_index_tree	
													-> btr_free_if_exists	
														-> btr_free_root	
															-> btr_search_drop_page_hash_index	
																-> ha_remove_all_nodes_to_page				
			
	2.6 ha_innobase::delete_table->row_drop_table_for_mysql->row_drop_table_from_cache
		-- 清缓存，从数据字典缓存中删除表
		
	2.7 ha_innobase::delete_table->row_drop_table_for_mysql->row_drop_single_table_tablespace
	
	2.8 ha_innobase::delete_table->row_drop_table_for_mysql->row_drop_single_table_tablespace->fil_delete_tablespace
	
	2.9 ha_innobase::delete_table->row_drop_table_for_mysql->row_drop_single_table_tablespace->fil_delete_tablespace->buf_LRU_flush_or_remove_pages
	
	2.10 ha_innobase::delete_table->row_drop_table_for_mysql->row_drop_single_table_tablespace->fil_delete_tablespace->os_file_delete
	
	2.11 ha_innobase::delete_table->row_drop_table_for_mysql->row_mysql_unlock_data_dictionary
	
		-- 释放数据字典的排他锁。
		
