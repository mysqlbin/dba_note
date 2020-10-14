


1. 前言
2. 5.6新参数 slave_rows_search_algorithms
3. 主库和从库数据查找方式的对比
4. INDEX_SCAN,HASH_SCAN 即 ROW_LOOKUP_HASH_SCAN方式的数据查找
5. 通过案例来分析ROW_LOOKUP_HASH_SCAN方式 Ht 和 Hi
6. 案例和收获
7. 总结
8. 自己的总结
9. 相关参考
10. 对应的实验


1. 前言
	对于DML语句来讲其数据的更改将被放到对应的Event中。
	比如Delete语句会将所有删除数据的before_image放到DELETE_ROWS_EVENT中，从库只要读取这些before_image进行数据查找，然后调用相应的Delete的操作就可以完成数据的删除了。
	
2. 5.6新参数 slave_rows_search_algorithms
	
	这个参数主要用于在从库确认如何查找数据
	其中决定如何查找数据以及通过哪个索引查找正是通过参数 slave_rows_search_algorithms的设置和表中是否有合适的索引共同决定的，并不是完成由参数slave_rows_search_algorithms决定。

	参数由三个值的组合组成：TABLE_SCAN, INDEX_SCAN, HASH_SCAN，使用组合包括：

		1. TABLE_SCAN,INDEX_SCAN: 
			默认配置，表示如果有索引就用索引查找，否则使用全表扫描；

		2. INDEX_SCAN,HASH_SCAN： 
			先判断是否有主键索引或者唯一索引，有则使用INDEX_SCAN，没有则使用HASH_SCAN，接着判断是否有二级索引，有则使用索引Hash查找，没有则使用全表Hash查找。
			
		3. TABLE_SCAN,HASH_SCAN

		4. TABLE_SCAN,INDEX_SCAN,HASH_SCAN (等价于INDEX_SCAN, HASH_SCAN)
	
3. 主库和从库数据查找方式的对比

	主库和从库数据查找的方式不一样
	从库每条数据都需要索引定位查找数据，表上一个索引都没有，那么每条数据都需要做一次全表扫描。--代价非常高。
	对于主库来讲一般只需要一次索引定位查找即可。

	1. slave_rows_search_algorithms = TALBE_SCAN,INDEX_SCAN
	
	2. 初始化表结构和数据
		mysql> show create table tkkk \G
		*************************** 1. row ***************************
			   Table: tkkk
		Create Table: CREATE TABLE `tkkk` (
		  `a` int(11) DEFAULT NULL,
		  `b` int(11) DEFAULT NULL,
		  `c` int(11) DEFAULT NULL,
		  KEY `idx_a` (`a`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8
		1 row in set (0.00 sec)

		mysql> select * from tkkk;
		+------+------+------+
		| a    | b    | c    |
		+------+------+------+
		|    1 |    1 |    1 |
		|    2 |    2 |    2 |
		|    3 |    3 |    3 |
		|    4 |    4 |    4 |
		|    5 |    5 |    5 |
		|    6 |    6 |    6 |
		|    7 |    7 |    7 |
		|    8 |    8 |    8 |
		|    9 |    9 |    9 |
		|   10 |   10 |   10 |
		|   11 |   11 |   11 |
		|   12 |   12 |   12 |
		|   13 |   13 |   13 |
		|   15 |   15 |   15 |
		|   15 |   16 |   16 |
		|   15 |   17 |   17 |
		+------+------+------+
		16 rows in set (2.21 sec)
		
		mysql> delete from tkkk where a=15;
		Query OK, 3 rows affected (6.24 sec)
		因为我做了debug索引这里时间看起来很长
		
		这条delete语句在主库和从库各自的查找方式
		主库
			对于这样一个 delete语句来讲主库会利用索引idx_a, 删除的3条数据我们实际上只需要一次索引定位(参考btr_cur_search_to_nth_level函数)，然后顺序扫描接下来的数据进行删除就可以了。
			大概流程如下图：
				
		从库
			这条delete语句删除的3条数据的before_image将会记录到一个DELETE_ROWS_EVENT中，从库应用的时候会重新评估应该使用哪个索引，优先使用主键和唯一键。
			对于Event中的每条数据都需要进行索引定位操作，并且对于非唯一索引来讲第一次返回的第一行数据可能并不是删除的数据，还需要继续扫描下一行
				--非唯一索引需要扫描到不满足条件的第一行才会停止下来
			这些代价是比主库更大的。在这个例子中没有主键和唯一键，因此依旧使用的是索引 idx_a，大概流程如下图：
			
			如果我们在从库增加一个主键，那么在从库进行应用的时候就会根据主键来定位查找数据，大概流程如下图：
			
			如果表上一个索引都没有的话，那么从库延迟变得更加严重，大概流程如下图：
				--这种情况使用 HASH_SCAN选项也许可以提高性能。
			
			通过上面的分析得知，主库delete操作和从库应用delete操作主要的区别在于：
				1. 从库每条数据都需要索引定位查找数据，如果没有索引，意味着每条数据都需要做一次全表扫描匹配记录。
				2. 从库对于Event中的每条数据都需要进行索引定位操作，并且对于非唯一索引来讲第一次返回的第一行数据可能并不是删除的数据，还需要继续扫描下一行
			
			
4. INDEX_SCAN,HASH_SCAN 即 ROW_LOOKUP_HASH_SCAN方式的数据查找
	
	将参数 slave_rows_search_algorithms 设置为 INDEX_SCAN,HASH_SCAN，且表上没有主键和唯一键的话，那么上图的流程将会把数据查找的方式设置为 ROW_LOOKUP_HASH_SCAN 。

	ROW_LOOKUP_HASH_SCAN 的工作机制：
	
		其首先会将Event中的每一行数据读取出来存入到HASH结构中，如果能够使用到Hi那么还会额外维护一个集合（set），将索引键值存入集合，作为索引扫描的依据。
		如果没有索引这个集合（set）将不会维护直接使用全表扫描，即Ht。
	
		ROW_LOOKUP_HASH_SCAN 方式的数据查找与 TABLE_SCAN、INDEX_SCAN查找方式不同：

			ROW_LOOKUP_HASH_SCAN：它是通过表中的数据和Event中的数据进行比对
			TABLE_SCAN、INDEX_SCAN：通过event中的数据与表中的数据进行比对
				
	ROW_LOOKUP_HASH_SCAN 又包含两种数据查找的方式：

		Hi --> Hash over index：
			则会通过上面我们说的通过集合（set）来进行索引定位扫描，每行数据也会去查询hash结构来比对数据。
		Ht --> Hash over the entire table：
			会全表扫描，其中全表扫描之后得到的每行数据都会查询hash结构来比对数据。  --类似 hash join 查找数据的原理。

		这个过程的单位是Event，我们前面说过一个DELETE_ROWS_EVENT可能包含了多行数据，Event最大为8K左右。
		
		因此使用Ht --> Hash over the entire table的方式，将会从原来的每行数据进行一次全表扫描变为每个Event才进行一次全表扫描。
			CREATE TABLE `page_info` (
			  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
			  `num` int(11) NOT NULL,
			  PRIMARY KEY (`id`),
			  KEY `idx_num` (`num`)
			) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;
			-- 一个Page为16KB，没有大字段的情况下，以上面的表结构为例，主键索引叶子节点16KB的Page有574行记录
			-- 二级索引叶子节点16KB的Page，一般都有1203行记录
			-- 假设8KB的event，有600行记录，减少了599次全表扫描，速度确实提升了不了。
			
		但是对于Hi --> Hash over index来讲效果就没有那么明显了，因为如果删除的数据重复值很少的情况下，依然需要足够多的索引定位查找才行，但是如果删除的数据重复值较多那么构造的集合（set）元素将会大大减少，也就减少了索引查找定位的开销。

		如果我的每条delete语句一次只删除一行数据而不是delete一条语句删除大量的数据，那这种情况每个 DELETE_ROWS_EVENT 只有一条数据存在，那么使用ROW_LOOKUP_HASH_SCAN方式并不会提高性能，因为这条数据还是需要进行一次全表扫描或者索引定位才能查找到数据，和默认的方式没什么区别。
		
		
5. 通过案例来分析ROW_LOOKUP_HASH_SCAN方式 Ht 和 Hi
	
	1. slave_rows_search_algorithms = INDEX_SCAN,HASH_SCAN
	
	2. 初始化表结构和数据
		mysql> show create table tkkk \G
		*************************** 1. row ***************************
			   Table: tkkk
		Create Table: CREATE TABLE `tkkk` (
		  `a` int(11) DEFAULT NULL,
		  `b` int(11) DEFAULT NULL,
		  `c` int(11) DEFAULT NULL,
		  KEY `a` (`a`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8
		1 row in set (0.00 sec)

		mysql> select * from tkkk;
		+------+------+------+
		| a    | b    | c    |
		+------+------+------+
		|    1 |    1 |    1 |
		|    2 |    2 |    2 |
		|    3 |    3 |    3 |
		|    4 |    4 |    4 |
		|    5 |    5 |    5 |
		|    6 |    6 |    6 |
		|    7 |    7 |    7 |
		|    8 |    8 |    8 |
		|    9 |    9 |    9 |
		|   10 |   10 |   10 |
		|   11 |   11 |   11 |
		|   12 |   12 |   12 |
		|   13 |   13 |   13 |
		|   15 |   15 |   15 |
		|   15 |   16 |   16 |
		|   15 |   17 |   17 |
		+------+------+------+
		16 rows in set (2.21 sec)
		
		mysql> delete from tkkk where a=15;
		Query OK, 3 rows affected (6.24 sec)
		因为我做了debug索引这里时间看起来很长
	
	3. 参考图片 《24-02.png》
	
6. 案例和收获
	
	终于知道为什么大事务在从库执行很慢了
	CREATE TABLE `tusers` (
	  `id_card` varchar(32) DEFAULT NULL,
	  `name` varchar(32) DEFAULT NULL,
	  `age` int(11) DEFAULT NULL,
	  `ismale` tinyint(1) DEFAULT NULL
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
	
	假设 tusers 表有 100W 行记录， 执行 删除全表的数据：delete from tusers;
	在这个列子中没有主键和唯一键，也没有普通索引；
	因此，在从库执行的时候，每一行数据的更改都需要进行全表扫描，即进行了100W次的全表扫描，所以从库延迟会非常大；
	即每一行数据的更改都需要进行一次全表扫描，这种问题就非常严重了。
	
	因此，也得到一个结论：从库每条数据都需要索引定位查找数据，如果没有索引，意味着每条数据都需要做一次全表扫描匹配记录。
	
	因此，需要做 hash scan 做优化：
	
		
		在 ROW_LOOKUP_HASH_SCAN 又包含两种数据查找的方式：

			Hi --> Hash over index   # 散列索引
				会通过前面我们说的集合（set）来进行索引定位扫描，每行数据也会去查询hash结构来比对数据。
				
			Ht --> Hash over the entire table     # 散列整个表
   
				会全表扫描，其中每行都会查询hash结构来比对数据
				但是一个 DELETE_ROWS_EVENT 可能包含了多行数据，Event最大为8K左右。
				因此使用Ht --> Hash over the entire table的方式，将会从原来的每行数据进行一次全表扫描变为每个Event才进行一次全表扫描。
				从而减少了全表扫描的次数，提升复制从库的效率
				

	如果遇到没有索引的表做delete大事务，可以使用参数 slave_rows_search_algorithms 做优化：
		stop slave sql_thread;
		SET GLOBAL slave_rows_search_algorithms = 'INDEX_SCAN,HASH_SCAN';  # 即时生效。
		start slave sql_thread;
		
		
		
7. 总结

	1. 我记得以前有位朋友问我主库没有主键如果我在从库建立一个主键能降低延迟吗？这里我们就清楚了答案是肯定的，因为从库会根据Event中的行数据进行使用索引的选择。那么总结一下：
		建立主键，只需要一次全表扫描。
	2. slave_rows_search_algorithms参数设置了HASH_SCAN并不一定会提高性能，只有满足如下两个条件才会提高性能：
		（1）（表中没有任何索引）或者（有索引且本条update/delete的数据关键字重复值较多，减少通过索引定位的次数）。     ### 通过做实验，理解了。
			
		（2） 一个update/delete语句删除了大量的数据，形成了很多个8K左右的UPDATE_ROW_EVENT/DELETE_ROW_EVENT。
			update/delete语句只修改少量的数据（比如每个语句修改一行数据）并不能提高性能。

	3. 从库索引的利用是自行判断的，顺序为主键->唯一键->普通索引。
		
	4. 如果slave_rows_search_algorithms参数没有设置HASH_SCAN，并且没有主键/唯一键那么性能将会急剧下降造成延迟。
		如果连索引都没有那么这个情况更加严重，因为更改的每一行数据都会引发一次全表扫描。

	5. 因此我们发现在MySQL中强制设置主键又多了一个理由。

   
8. 自己的总结

	1. 对于 index_scan、Hash_scan
	
		Ht: 从原来的每行数据进行一次全表扫描变为每个Event才进行一次全表扫描，从而减少了全表扫描的次数，提升复制从库的效率
		
		Hi：会通过额外维护的集合（set）的索引键值来进行索引定位扫描，根据得到的数据去查询hash结构来比对数据。
			
			如果删除的数据重复值很少的情况下，依然需要足够多的索引定位查找才行，但是如果删除的数据重复值较多那么构造的集合（set）元素将会大大减少，也就减少了索引查找定位的开销。
	
	2. Ht 查找方式类似于 MySQL 8.0.18 的Hash join

	3. 每次看/复习/深入学习都有不一样的体会，也就是说理解得更好了，就差口头描述出来了。--加油。
	
9. 相关参考
	https://dev.mysql.com/doc/refman/5.7/en/replication-options-slave.html#sysvar_slave_rows_search_algorithms   # 官方文档是最好的参考资料
	
	https://www.jianshu.com/p/d6586baaf76e    从库数据查找和参数slave_rows_search_algorithms
	
	https://mp.weixin.qq.com/s/r0Vb8Yu6OlHnOSEhmhoxYA    技术分享 | delete大表slave回放巨慢的问题分析
	
	通过测试发现使用 slave_rows_search_algorithms= INDEX_SCAN,HASH_SCAN 配置在此场景下回放binlog会有大幅性能改善，这种方式会有一定内存开销，所以要保障内存足够创建hash表，才会看到性能提升。
	
	https://mp.weixin.qq.com/s/tr3nhNEWriLvEeRGCnHsaw  一则简单的主从延迟处理


	改进：
		日常巡检脚本也会增加这个功能，看看哪些表是没有主键的
	
		SELECT
		t.table_schema,
		t.table_name
		FROM
			information_schema. TABLES AS t
		LEFT JOIN  (
			SELECT DISTINCT
				table_schema,
				table_name
			FROM
				information_schema.`KEY_COLUMN_USAGE`
		) AS kt ON  kt.table_schema = t.table_schema
		AND kt.table_name = t.table_name
		WHERE
			t.table_schema NOT IN  (
				'mysql',
				'information_schema',
				'performance_schema',
				'sys'
			)
		AND kt.table_name IS NULL;

10. 对应的实验
	
	《2020-04-04-05-从库遇到大事务的解决办法和从库查找参数的实践》

	
