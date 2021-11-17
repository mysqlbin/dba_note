

对比常见的数据结构, 从性能、 写入、 读取的角度进行对比

0. 跟本身定位的数据库类型有关系
1. 了解MongoDB 和 MySQL 分别是属于什么类型的数据库
2. B-树 和 B+树的数据结构分析 
3. 读取和写入的角度分析
4. 用一个案例来说明两者选择对应的数据结构的原因
5. 相关参考



0. 跟本身定位的数据库类型有关系
	1. MySQL
		关系型的数据库
		在数据查找方面，范围查找对于B+树会很有优势，因为叶子节点是双向链表，所以定位到叶子节点的第一行记录之后，再向右遍历查找就可以拿到其它记录。
		
	2. MongoDB
		文档型的NoSQL数据库，因此是 Key-Value 类型的
		对于  Key-Value 类型的数据查找：因为使用的B树，叶子节点和非叶子节点都存储数据，只需要一次查找就可以拿到数据。
		范围查找，速度也很快。
		
		
1. 了解MongoDB 和 MySQL 分别是属于什么类型的数据库

	MongoDB 是文档型(聚合型)数据库，MySQL是关系型数据库
	了解数据库的类型之后
	MongoDB WT存储引擎采用 B-树的数据结构存储数据
	InnoDB 存储引擎采用 B+树的数据结构存储数据

2. B-树 和 B+树的数据结构分析 

	B-树的存储：叶子节点和非叶子节点都存储数据
	B+树的存储：只在叶子节点存储数据，叶子节点的数据页是双向链表，数据页的记录是单项链表，范围查询或者查询多行记录通过进行遍历就可以得到结果。
				非叶子节点不存储数据
	
	
3. 读取和写入的角度分析
	
	写入：
		InnoDB的B+树：
			选择自增ID列做主键，写入操作都是追加写，不会触发叶子节点数据页的分裂。
		
		
	读取：
		InnoDB的B+树：
		
			2.1  B+树以很少的高度存储大量的数据， 因此可以减少单次查询的磁盘访问次数：  
                以 InnoDB 的一个整数字段索引为例， 17亿行的记录，树高为4；
                考虑到树根的数据块/数据页总是在内存中的；
                查找一个值最多只需要访问 3 次磁盘；
                树的第二层也有很大概率在内存中，那么访问磁盘的平均次数就更少了。
				
			2.2 范围查询或者查询多条记录的性能很高同时可以减少顺序遍历产生的随机IO：
                所有的数据都存储在叶子节点， 叶子节点的数据页是双向链表，并且数据自小而大顺序递增； 
                当进行范围查询，B+树可以很快的定位第一行记录：当从根节点向上定位到叶子节点数据页的第1行记录满足搜索条件的时候，依次遍历取下一行记录，性能非常高
				
				B+ 树的所有叶子节点可以通过指针相互连接，能够减少顺序遍历时产生的额外随机 I/O。
				
		MongoDB的B-树：
			因为MongoDB的定位是文档型数据库，它更看重以文档为中心的组织方式，所以选择了查询单个文档性能较好的 B-树
			B-树在叶子节点和非叶子节点都存储数据，所以它的查询单个文档的复杂度最好为 O(1)
			
			
	
4. 用一个案例来说明两者选择对应的数据结构的原因

	有一个用户A，用户A有5个收货地址
	
	MySQL 的schema 设计如下
		
		table_user
			id     name            age
			 
			10     'mysqlbin'      28
			
		table_user_address
			user_id     address
			10  		收货地址1
			10  		收货地址2
			10  		收货地址3
			10  		收货地址4
			10  		收货地址5
			
		
	MongoDB 的文档设计如下
		把用户信息只存储在一个文档中
		在MongoDB表设计中，由于MongoDB支持文档嵌套结构，我可以把收货地址复合结构嵌套起来，从而实现一个Collection结构，可读性会更强。
		
		
		db.user_address.insert({
		"name" : "mysqlbin",
		"age" : 28,
		"addresses_list" : [
			{ "country": "china", "city": 'shenzhen', "detail": '车公庙100号', "phone": 13202096168 },
			{ "country": "china", "city": 'guangzhou', "detail": '车公庙101号', "phone": 13202095159 }
		]
		})
		

		repl_set:PRIMARY> db.user_address.findOne()
		{
			"_id" : ObjectId("5f1691dc138b226f6b19720d"),
			"name" : "mysqlbin",
			"age" : 28,
			"addresses_list" : [
				{
					"country" : "china",
					"city" : "shenzhen",
					"detail" : "车公庙100号",
					"phone" : 13202096168
				},
				{
					"country" : "china",
					"city" : "guangzhou",
					"detail" : "车公庙101号",
					"phone" : 13202095159
				}
			]
		}


	
	删除、修改、新增
	
	
	
	----------------------------------------------------------------------------------------------------
	
	db.user_address_test.insert({
	"name" : "mysqlbin",
	"age" : 28,
	"addresses_list" : 
		{ "country": "china", "city": 'shenzhen', "detail": '车公庙100号', "phone": 13202096168 },
		{ "country": "china", "city": 'guangzhou', "detail": '车公庙101号', "phone": 13202095159 }
	})
	
	2020-07-21T15:00:28.627+0800 E  QUERY    [js] uncaught exception: SyntaxError: expected property name, got '{' :


5. 相关参考


    https://mp.weixin.qq.com/s/yd49Xc4pzvGnVqeptR49vA    为什么MySQL数据库要用B+树存储索引？
    https://mp.weixin.qq.com/s/q4uq0OLYWnrdlCf5je_yzQ    为什么 MySQL 使用 B+ 树
	https://mp.weixin.qq.com/s/kRG8osOgLIenr7UeEqT7aQ 	 为什么Mongodb索引用B树，而Mysql用B+树?
	https://mp.weixin.qq.com/s/ieGfv66GstJC2cltiE_c5g    为什么 MongoDB 使用 B 树？ 
	
	https://www.cnblogs.com/kaleidoscope/p/9481991.html  为什么 MongoDB （索引）使用B-树而 Mysql 使用 B+树
	
	
	https://docs.mongodb.com/manual/indexes/
		MongoDB indexes use a B-tree data structure
	


