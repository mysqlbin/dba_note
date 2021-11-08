

环境：
	4核CPU、16GB内存、100GB的SSD盘

全表没有二级索引也没有主键索引在 INDEX_SCAN,TABLE_SCAN 和 INDEX_SCAN,HASH_SCAN 的对比
	

20W行记录
	从库查找方式   'INDEX_SCAN,TABLE_SCAN'   'INDEX_SCAN,HASH_SCAN'  
	耗时            估计要1300S                     147S  
	
	有10倍左右的性能提升。


50W行记录
	从库查找方式   'INDEX_SCAN,TABLE_SCAN'   'INDEX_SCAN,HASH_SCAN'  
	耗时            			                    158S  


520W行记录
	从库查找方式   'INDEX_SCAN,TABLE_SCAN'   'INDEX_SCAN,HASH_SCAN'  
	耗时                                 		约 5613S

	
	
	