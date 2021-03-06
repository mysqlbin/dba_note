



主键索引和唯一索引的区别：
	1. 在InnoDB存储引擎里，两者都是一颗B+树
	2. 主键索引一定是聚集索引，唯一索引不一定是聚集索引
	3. 加锁：唯一索引的记录加写锁，也会对主键索引加写锁
	4. 从存储的角度：
		主键索引的叶子节点存储的是整行记录
		普通索引叶子节点的内容是主键值