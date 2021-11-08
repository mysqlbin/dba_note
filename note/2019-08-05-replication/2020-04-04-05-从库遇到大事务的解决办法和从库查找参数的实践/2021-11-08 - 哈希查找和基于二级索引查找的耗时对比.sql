

环境：
	4核CPU、16GB内存、100GB的SSD盘

全表没有二级索引也没有主键索引在 INDEX_SCAN,TABLE_SCAN 和 INDEX_SCAN,HASH_SCAN 的对比
	

20W行记录
	从库查找方式   'INDEX_SCAN,TABLE_SCAN'   'INDEX_SCAN,HASH_SCAN'  
	耗时            估计要1300S                     147S  
	
	有10倍左右的性能提升。


50W行记录
	从库查找方式   'INDEX_SCAN,TABLE_SCAN'   						'INDEX_SCAN,HASH_SCAN'  
	耗时            2000s=33分钟(1W行要40秒/5W行要200s=3.5分钟)			 158S  
					5W行延迟200s

520W行记录
	从库查找方式   'INDEX_SCAN,TABLE_SCAN'   'INDEX_SCAN,HASH_SCAN'  
	耗时                                 		约 5613S = 93分钟 = 1个半小时 
	


	
50W行左右的小表可以用，大于50W行记录的大表还是会慢。




