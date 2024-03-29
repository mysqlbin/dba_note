
1. 从数据结构角度

    二叉树、平衡二叉树、  B 树、 B+TREE、哈希索引、全文索引

2. 按物理存储角度划分

	索引类型可分为 聚集索引和非聚集索引
	
	其中聚集索引的叶子节点的存储的是整行数据
	非聚集索引的叶子节点存储的是主键索引的键值
	
	
3. 从逻辑角度划分

    主键索引、唯一索引、非唯一二级索引、联合索引
	

4. 其它
	前缀索引、覆盖索引、ICP索引下推
		
5. 相关参考
	https://www.iamshuaidi.com/1437.html
	https://imysql.com/tag/mysql-dba%E6%88%90%E9%95%BF%E4%B9%8B%E8%B7%AF
	
	
6. 普通索引和唯一索引的区别
	2020-07-29-普通索引和唯一索引的区别.sql
	
	
7. 主键索引和唯一索引的区别
	2021-03-05-主键索引和唯一索引的区别.sql
	
	
	
索引合并：使用多个单列索引组合搜索