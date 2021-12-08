

原理：
	MySQL 自动探测到如果创建哈希索引能带来查询性能上的提升，那么就会建立哈希索引。

作用/目的：
	为了根据查询条件的值，直接定位到对应的叶子节点数据页上的记录位置，加速查询访问的速度。
	不再需要从根节点下降到叶子结点，同时在每个节点中还需要使用二分查找定位。
	在B+树中搜索一个记录时，需要从根节点下降到叶子结点，同时在每个节点中还需要使用二分查找定位。
	-- 理解了。
	
缺点：
	1. 只支持等值比较，=、!=、<=、>= 
	2. 可能会带来额外的CPU消耗。
	
监控：
	show engine innodb status 中可以看到 哈希索引占用内存缓冲池的大小，平均每秒使用到哈希索引查找的次数，每秒使用B+TREE查找数据的次数。
	

key是什么，value是什么？
	key: 查询条件的值
	value：值对应的索引页
	
	
innodb_adaptive_hash_index=ON	

	执行30次查询: select * from sbtest2 where id=2;
	
	-------------------------------------
	INSERT BUFFER AND ADAPTIVE HASH INDEX
	-------------------------------------
	Ibuf: size 1, free list len 2157, seg size 2159, 0 merges
	merged operations:
	 insert 0, delete mark 0, delete 0
	discarded operations:
	 insert 0, delete mark 0, delete 0
	Hash table size 1328143, node heap has 0 buffer(s)
	Hash table size 1328143, node heap has 0 buffer(s)
	Hash table size 1328143, node heap has 0 buffer(s)
	Hash table size 1328143, node heap has 0 buffer(s)
	Hash table size 1328143, node heap has 0 buffer(s)
	Hash table size 1328143, node heap has 0 buffer(s)
	Hash table size 1328143, node heap has 0 buffer(s)
	Hash table size 1328143, node heap has 1 buffer(s)
	0.00 hash searches/s, 0.00 non-hash searches/s
		
	
	set global innodb_adaptive_hash_index=OFF
	
	-------------------------------------
	INSERT BUFFER AND ADAPTIVE HASH INDEX
	-------------------------------------
	Ibuf: size 1, free list len 2157, seg size 2159, 0 merges
	merged operations:
	 insert 0, delete mark 0, delete 0
	discarded operations:
	 insert 0, delete mark 0, delete 0
	Hash table size 1328143, node heap has 0 buffer(s)
	Hash table size 1328143, node heap has 0 buffer(s)
	Hash table size 1328143, node heap has 0 buffer(s)
	Hash table size 1328143, node heap has 0 buffer(s)
	Hash table size 1328143, node heap has 0 buffer(s)
	Hash table size 1328143, node heap has 0 buffer(s)
	Hash table size 1328143, node heap has 0 buffer(s)
	Hash table size 1328143, node heap has 0 buffer(s)

	关闭AHI, 会释放AHI里面Hash table数据.
	
	