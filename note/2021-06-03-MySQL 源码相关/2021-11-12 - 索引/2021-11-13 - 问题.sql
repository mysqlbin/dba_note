
1. 哪个步骤结束之后返回索引删除成功的信息
	s：执行一行代码，如果代码函数调用，则进入函数
2. 如何打断点
	b dict_drop_index_tree
3. 总结历史上已经对哪些函数打过断点


4. 
	return(false);
	return(true);


对于drop index操作，会将其先在数据词典中rename掉(row_merge_rename_index_to_drop)，以TEMP_INDEX_PREFIX作为命名前缀，
	-- 将需要drop的index 在数据词典(information_schema.INNODB_SYS_INDEXES)里rename成 TEMP_INDEX_PREFIX 前缀+index名
然后在随后的 row_merge_drop_indexes_dict 函数再做真正的删除， 并从dict cache中删除(dict_index_remove_from_cache)。
	commit_cache_norebuild   // index->page = FIL_NULL
	-> row_merge_drop_indexes_dict
	-- 真正删除被删除的索引。
	
	
注意，只要index在数据词典中被rename掉，在crash recovery后，也会被删除掉。



普通删除索引的话，不会释放空间。
由于索引(二级索引)和数据(主键索引)是存储在同一个文件中，因此在使用独立表空间时，InnoDB引擎使用drop命令删除索引并不会释放磁盘空间。


