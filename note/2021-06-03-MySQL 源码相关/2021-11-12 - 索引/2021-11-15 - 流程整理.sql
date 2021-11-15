
0. 问题
1. 初步整理
2. 最终整理
3. 删除二级索引会回收磁盘空间吗	
4. 相关参考
5. 其它问题



0. 问题

	为什么删除二级索引，执行速度很快，秒级完成？
	
	答：
		根据经验，估计是先对二级索引打删除标记(类似隐藏索引)，然后再对二级索引的记录打删除标记，最后purge二级索引的记录
		但是，如果表有5000W行记录，根据二级索引扫描这5000W行记录并打删除标记，耗时应该不可能秒级完成。


1. 初步整理
	ha_innobase::prepare_inplace_alter_table
		check_if_can_drop_indexes
			检查索引是否可以删除, 并且标记所有要删除的索引(设置index->to_be_dropped = 1)

	ha_innobase::commit_inplace_alter_table
		-> commit_try_norebuild  
			-> row_merge_rename_index_to_drop
		
				删除所有请求删除的索引，首先在数据字典中标记它们：
					重命名字典中要删除的索引，将需要drop的index 在数据词典(information_schema.INNODB_SYS_INDEXES)里rename成 TEMP_INDEX_PREFIX 前缀+index名
		
		-> commit_cache_norebuild 
			-> row_merge_drop_indexes_dict
			-> dict_index_remove_from_cache
			-> trx_commit_for_mysql
			
			设置 index->page = FIL_NULL
			
			从数据词典 information_schema.INNODB_SYS_FIELDS、information_schema.INNODB_SYS_INDEXES 中删除索引项相关记录，并释放索引树
				其中释放索引树的过程：
					1. 先删除除了根节点外的其他部分(btr_free_but_not_root)
					2. 再删除根节点(btr_free_root)。
					3. btr_free_but_not_root 中会先释放 leaf segment 再释放 non-leaf segment
			
			从 dictionary cache 中删除索引
			
			提交事务，删除索引操作完成。

			
		
		
2. 最终整理

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
				1. 先删除非根节点(btr_free_but_not_root)
				2. 再删除根节点(btr_free_root)。
				3. btr_free_but_not_root 中会先释放 leaf segment 再释放 non-leaf segment
				
		4. 从 dictionary cache 中删除索引
		
		5. 提交事务，删除索引操作完成。
		
		6. 由于被drop的索引段已经被设置为free，因此可以重用Page。
		
		
	
	
3. 删除二级索引会回收磁盘空间吗
	
	普通删除索引的话，不会释放磁盘空间。
	由于索引(二级索引)和数据(主键索引)是存储在同一个文件中，因此在使用独立表空间时，InnoDB引擎使用drop命令删除索引并不会释放磁盘空间。
	
	
	但是，索引删除后，之前索引占用的空间，可以被使用。
	
	
		
4. 相关参考
	
	https://developer.aliyun.com/article/41182	Innodb drop index 流程小记

	https://zhuanlan.zhihu.com/p/165365251		InnoDB：Tablespace management（1）



5. 其它问题

	1. 哪个步骤结束之后返回索引删除成功的信息
		trx_commit_for_mysql：事务提交后
		
	2. 如何打断点
		b dict_drop_index_tree
		b srv_is_tablespace_truncated
		b btr_free_if_exists
		
	3. 总结历史上已经对哪些函数打过断点
		
	
	4. 
		return(false);
		return(true);

