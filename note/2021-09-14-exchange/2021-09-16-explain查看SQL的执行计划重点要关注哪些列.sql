

1. key列
	表示语句使用到的索引

2. rows 
	预计扫描的行数
	
3. extra
	是否使用到覆盖索引
	是否有group by分组使用到了临时表(using temporary) 
	using filesort ：无法利用索引完成排序，如果排序需要的空间大于sort_buffer_size，就需要产生磁盘临时表。
	是否有使用到索引合并
	