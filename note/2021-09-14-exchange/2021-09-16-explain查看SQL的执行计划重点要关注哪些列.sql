 

1. key列
	表示语句使用到的索引，可以知道使用了联合索引的前几列

2. rows 
	预计扫描的行数
	
3. extra
	using index: 是否使用到覆盖索引
	using temporary： group by分组字段没有索引，使用到了临时表
	using filesort ：排序字段没有索引，如果排序需要的空间大于sort_buffer_size，就需要产生磁盘临时表。
	Using intersect：使用到了索引合并扫描
	using join buffer: 被驱动表的关联字段没有索引
	
	
	
	