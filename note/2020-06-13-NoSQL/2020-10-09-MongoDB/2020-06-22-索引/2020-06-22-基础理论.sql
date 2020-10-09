

mongodb 索引简介
为了方便理解后面的优化思路，先简单介绍 mongodb 的索引，但不会太详细，只会涉及到本次优化中使用到的索引类型。

mongodb 的索引类型分为：

	单键索引（Single Field Index）

	复合索引（Compound Index）

	多键索引（Multikey Index）

	地理空间索引（Geospatial Index）

	文本索引（Text Indexes）

	哈希索引（Hashed Indexes）

如果我们想要定义某个索引为唯一索引，可以使用索引的属性来定义，索引的属性有：
	
	唯一索引

	部分索引

	稀疏索引

	TTL 索引

galaxyx 存储机器资源的集合，主要使用了单键索引（唯一索引），复合索引，多键索引，以下的内容只会涉及到这三种索引，其他索引的介绍请参考 官方文档。
