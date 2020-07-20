


https://www.cnblogs.com/kaleidoscope/p/9481991.html  为什么 MongoDB （索引）使用B-树而 Mysql 使用 B+树
https://mp.weixin.qq.com/s/ieGfv66GstJC2cltiE_c5g    为什么 MongoDB 使用 B 树？ 
	使用MongoDB, 要清楚MongoDB的设计方式跟传统关系型数据库的设计方式的区别 
	不能单方面的说哪个数据库好, 哪个数据库不好, 其实大多数都是使用姿势不对造成的
	
	
1. 首先, MongoDB 定位的是文档型的数据库, 是一种 nosql，它使用类 Json 格式保存数据;

	文档型数据库和我们常见的关系型数据库不同，一般使用 XML 或 Json 格式来保存数据，归属于聚合型数据库。

2. B 树数据结构:
	B 树能够在非叶节点中存储数据(即根节点、中间索引节点、叶子节点都能存储数据), 即 B-树恰好 key 和 data 域聚合在一起
	B 树的查询最好时间复杂度是 O(1), 跟 哈希表一样.
	
3. 	B 树带来的性能提升
	MongoDB 这类 nosql 适用于数据模型简单，性能要求高的场合。
	尽可能少的磁盘 IO 是提高性能的有效手段。MongoDB 是聚合型数据库，而 B 树恰好 key 和 data 域聚合在一起。
	
	 
4. 小结:
	选择什么数据结构, 是根据数据库属于什么类型来定的
	WiredTiger存储引擎选择B 树
	InnoDB存储引擎选择B+ 树
	
	
