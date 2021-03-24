
1. 索引各个值的解释
2. 实验
3. 总结
4. 收获
5. 相关参考



1. 索引各个值的解释
	
	1. Handler_read_first 
	
		文档解释：
			The number of times the first entry in an index was read. If this value is high, it suggests that the server is doing a lot of full index scans; 
			for example, SELECT col1 FROM foo, assuming that col1 is indexed
			
			
			The number of times the first entry in an index was read.
			索引第一条记录被读的次数
			
			If this value is high, it suggests that the server is doing a lot of full index scans; 
			如果高,则它表明服务器正执行大量全索引扫描
			
		总的来说就是	
			索引第一条记录被读的次数,如果高,则它表明服务器正执行大量全索引扫描	
			用于定位索引的第一条数据, 实际上也是封装的 ha_innobase::index_read 函数(如全表扫描/全索引扫描调用)
			用于定位索引的第一条数据
			
	2. Handler_read_key  
	
		文档解释：
			The number of requests to read a row based on a key. If this value is high, it is a good indication that your tables are properly indexed for your queries.
			根据索引读一行的请求数，如果该值较高，说明查询和表的索引正确
		
		总的来说就是
			根据索引读一行的请求数，如果该值较高，说明查询和表的索引正确
			这个函数是访问索引的时候定位到值所在的位置用到的函数，因为必须要知道读取索引的开始位置才能向下访问。
			增加1次这是用于初次定位
			
	3. Handler_read_next
	
		文档解释：	
			The number of requests to read the next row in key order. This value is incremented if you are querying an index column with a range constraint or if you are doing an index scan.
			
			The number of requests to read the next row in key order.
				按照索引顺序读下一行的请求数
			This value is incremented if you are querying an index column with a range constraint or if you are doing an index scan.
				范围range查询 或者 进行全索引扫描,则此值将增加
			
		总的来说就是
			按照索引顺序读下一行的请求数
			范围range查询 或者 进行全索引扫描,则此值将增加
			访问索引的下一条数据封装的 ha_innobase::general_fetch 函数，index_next_same 和 index_next 不同在于访问的方式不一样，
			比如范围range查询需要用到和索引全扫描也会用到 index_next ，而ref访问方式会使用 index_next_same
			
		
	
	4. Handler_read_rnd 
		这个状态值在我测试期间只发现对临时表做排序的时候会用到，而且是Memory引擎的，具体只能按照文档理解了。 
		BKA算法中也有用到。
		
		文档解释：
			The number of requests to read a row based on a fixed position. This value is high if you are doing a lot of queries that require sorting of the result. You probably have a lot of queries that require MySQL to scan entire tables or you have joins that do not use keys properly.

			The number of requests to read a row based on a fixed position:
				表示基于固定位置读取行的请求数
			
			This value is high if you are doing a lot of queries that require sorting of the result:
				如果您要执行很多需要对结果进行排序的查询，则此值很高.
			
			you probably have a lot of queries that require MySQL to scan entire tables or you have joins that do not use keys properly.	
				可能有很多查询需要MySQL扫描整个表，或者有一些连接没有正确使用键。
				
		总结的来说就是
			根据固定位置读一行的请求数，如果值较高，说明可能使用了大量需要mysql扫整个表的查询或没有正确使用索引
		
			就是查询直接操作了数据文件，很多时候表现为没有使用索引或者文件排序。
		
		
	5. Handler_read_rnd_next 
		
		文档解释：
			The number of requests to read the next row in the data file. This value is high if you are doing a lot of table scans. Generally this suggests that your tables are not properly indexed or that your queries are not written to take advantage of the indexes you have.
			
			The number of requests to read the next row in the data file. This value is high if you are doing a lot of table scans.
				在数据文件中读下一行的请求数，如果你正进行大量的表扫描，该值会较高
			
			Generally this suggests that your tables are not properly indexed or that your queries are not written to take advantage of the indexes you have.	
				一般来说，这意味着您的表没有建立正确的索引，或者您的查询没有利用到索引。
				
		总的来说就是
			全表扫描访问下一条数据
			实际上也是封装的 ha_innobase::general_fetch，在访问之前会调用 ha_innobase::index_first
		
		
	6. Handler_read_prev 
		Innodb接口为 ha_innobase::index_prev 访问索引的上一条数据，实际上也是封装的 ha_innobase::general_fetch 函数，用于ORDER BY DESC 索引扫描避免排序，内部状态值 ha_read_prev_count 增加。
		按照索引顺序读前一行（上一行）的请求数
		
	7. Handler_read_last 
		文档解释
			The number of requests to read the last key in an index. With ORDER BY, the server will issue a first-key request followed by several next-key requests, whereas with ORDER BY DESC, the server will issue a last-key request followed by several previous-key requests. This variable was added in MySQL 5.6.1.
			
		总的来说就是
			查询读索引最后一个索引键请求数
			Innodb接口为 ha_innobase::index_last 访问索引的最后一条数据作为定位，实际上也是封装的 ha_innobase::index_read 函数，用于ORDER BY DESC 索引扫描避免排序，内部状态值 ha_read_last_count 增加。
		
		
	8. Handler_commit   内部交语句

	9. Handler_rollback 内部 rollback语句数量

2. 实验
	参考笔记 <2020-02-11-InnoDB Handler_read_变量的实验-参考八怪的文章.sql>
	
3. 总结
	索引使用
		Handler_read_rnd_next 通常代表着全表扫描。
		Handler_read_first    通常代表着全表或者全索引扫描。
		Handler_read_next     通常代表着合理的使用了索引或者全索引扫描。
		Handler_read_key      不管全表全索引或者正确使用的索引实际上都会增加，只是一次索引定位而已。
		InnoDB中全表扫描也是主键的全索引扫描。
		顺序访问的一条记录实际上都是调用ha_innobase::general_fetch函数，另外一个功能innodb_thread_concurrency参数的功能就在里面实现，下次在说。
		
	索引定位
		Handler_read_key      用于初次定位
		Handler_read_first    用于定位索引的第一条数据	
		Handler_read_next     根据索引读取下一行的请求数
		Handler_read_prev     根据索引读取上一行的请求数
		Handler_read_last     访问索引的最后一条数据
	
4. 收获
	5.6 和 5.7 版本默认都没有开启 BKA， 可以开启，做为一种优化的方法。
	SQL 优化步骤：
		1. 执行计划
		2. show warnings 查看SQL的改写
		3. profile 查看SQL在各个阶段执行的代价
		4. 执行完成select后，查看 Handler_read_* 的指标增长情况 
		
5. 相关参考
	https://www.jianshu.com/p/25fed8f1f05e               MySQL:Innodb Handler_read_*变量解释
	https://yq.aliyun.com/articles/693718				 mysql的handler_read_next理解
	http://blog.itpub.net/7728585/viewspace-2215202/     MySQL：sending data状态包含了什么
	http://blog.itpub.net/15498/viewspace-2137068/       MySQL handler相关状态参数解释
	https://www.cnblogs.com/qcfeng/p/6476392.html        0227浅谈MySQL之 Handler_read_*参数
	http://blog.itpub.net/22664653/viewspace-1715511/    【MySQL】MySQL5.6新特性之Batched Key Access
	https://dev.mysql.com/doc/refman/5.7/en/index-extensions.html 
	
			

如果你想要稳定地使用 MRR 优化的话，需要设置set optimizer_switch="mrr_cost_based=off"。
（官方文档的说法，是现在的优化器策略，判断消耗的时候，会更倾向于不使用 MRR，把 mrr_cost_based 设置为 off，就是固定使用 MRR 了。）
		
					
					
				