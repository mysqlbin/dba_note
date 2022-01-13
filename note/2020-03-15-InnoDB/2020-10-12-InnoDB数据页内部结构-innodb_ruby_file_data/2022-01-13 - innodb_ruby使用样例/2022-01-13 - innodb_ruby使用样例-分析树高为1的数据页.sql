


大纲

	1. 初始表结构和数据
	2. space-indexes
	3. index-level-summary
	4. space-page-type-regions
	5. index-recurse 
	6. page-records
	7. 相关参考	

1. 初始表结构和数据

	CREATE TABLE `ruby_block` (
	  `id1` int(11) NOT NULL,
	  `name` varchar(30) DEFAULT NULL,
	  `id3` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id1`),
	  KEY `name` (`name`),
	  KEY `id3` (`id3`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


	insert into ruby_block values(1,'lu',1),(2,'lu',2),(3,'lu',3),(4,'lu',4);


2. space-indexes

	shell> innodb_space -s ibdata1 -T test_db/ruby_block space-indexes
	id          name                            root        fseg        used        allocated   fill_factor 
	16556       PRIMARY                         3           internal    1           1           100.00%     
	16556       PRIMARY                         3           leaf        0           0           0.00%       
	16557       name                            4           internal    1           1           100.00%     
	16557       name                            4           leaf        0           0           0.00%       
	16558       id3                             5           internal    1           1           100.00%     
	16558       id3                             5           leaf        0           0           0.00%      

	
	使用 innodb_space 来查看ruby_block表的索引结构、数据分配情况


	name:
		索引的名称
		PRIMARY代表的就是聚集索引，因为InnoDB表是聚集所以组织表，行记录就是聚集索引
		name和id3 就是辅助索引的名称.

	root:
		索引中根节点的 page number ；
		可以看出聚集索引的根节点是第3个page(为什么是从第三个page开始，看下文 space-page-type-regions )
		辅助索引的根节点是第4个page

	fseg: 
		page的说明

	used:
		索引树使用了多少个page；
		可以看出聚集索引的根几点使用了1个page，叶子节点使用了0个page；
		辅助索引name 和 id3 的叶子节点都使用了0个page, 原因：B+树只有1层。  -- 这里需要验证下。            

	allocated: 
		为索引树分配了多少个page；可以看出聚集索引的根几点分配了1个page，叶子节点分配了0个page；辅助索引 name 和 id3 的叶子节点都分配了0个page

	通过 used 和 allocated 可以看到每棵索引树一共使用了多少个Page，索引树的内节点和叶子节点分别使用了多少个Page。

	fill_factor:
		索引的填充度；所有的填充度都是100%




3. index-level-summary

	得到指定level的所有page信息：

	shell> innodb_space -s ibdata1 -T test_db/ruby_block -I PRIMARY -l 0  index-level-summary
	page    index   level   data    free    records min_key 
	3       16556   0       124     16128   4       id1=1

	shell> innodb_space -s ibdata1 -T test_db/ruby_block -I PRIMARY -l 1  index-level-summary
	page    index   level   data    free    records min_key 

	shell> innodb_space -s ibdata1 -T test_db/ruby_block -I PRIMARY -l 2  index-level-summary
	page    index   level   data    free    records min_key

	我们知道level值和索引树的高度是强相关的(叶子节点的level都是0)，所以通过这个命令也可以知道InnoDB索引树高度.
	由上面执行命令的结果可知，level=1时没有任何数据，而level等于0有，本样例数据表的几个索引树的高度是1。



4. space-page-type-regions

	shell> innodb_space -f /data/mysql/mysql3306/data/test_db/ruby_block.ibd space-page-type-regions
	start       end         count       type                
	0           0           1           FSP_HDR             
	1           1           1           IBUF_BITMAP         
	2           2           1           INODE               
	3           5           3           INDEX               
	6           7           2           FREE (ALLOCATED) 

	通过结果可知，page为0,1,2类型名称分别是： FSP_HDR , IBUF_BITMAP, INODE 。从page=3开始才是存放行数据和指针的页。  *******
	(InnoDB_Structures 里面的介绍都是从 page=3开始)

5. index-recurse 

	递归索引

	分析主键索引
		
		shell> innodb_space -s ibdata1 -T test_db/ruby_block -I PRIMARY index-recurse
		ROOT NODE #3: 4 records, 124 bytes
		  RECORD: (id1=1) → (name="lu", id3=1)
		  RECORD: (id1=2) → (name="lu", id3=2)
		  RECORD: (id1=3) → (name="lu", id3=3)
		  RECORD: (id1=4) → (name="lu", id3=4)

		因为树的高度是1, 所以 根节点也是叶子节点.

		从结果可知，ROOT NODE即根节点是page=3的页, 有4条记录. 主键索引树只有1层高的场景下，叶子节点/根节点存储了整行数据.


	分析辅助索引 name
		
		shell> innodb_space -s ibdata1 -T test_db/ruby_block -I name index-recurse
		ROOT NODE #4: 4 records, 56 bytes
		  RECORD: (name="lu") → (id1=1)
		  RECORD: (name="lu") → (id1=2)
		  RECORD: (name="lu") → (id1=3)
		  RECORD: (name="lu") → (id1=4)

		因为树的高度是1, 所以 根节点也是叶子节点.

		从结果可知，ROOT NODE即根节点是page=4的页, 有4条记录. 辅助索引存储的是主键值.


6. page-records

	统计某一页中的数据(有多少行)。
	
	统计 page no=3 数据页的数据:
		shell> innodb_space -s ibdata1 -T test_db/ruby_block -p 3 page-records 
		Record 127: (id1=1) → (name="lu", id3=1)

		Record 158: (id1=2) → (name="lu", id3=2)

		Record 189: (id1=3) → (name="lu", id3=3)

		Record 220: (id1=4) → (name="lu", id3=4)

		从结果可知，ROOT NODE即根节点是page=3的页, 有4条记录. 主键索引树的叶子节点/根节点存储了整行数据.  参考: index-recurse

	统计 page no=4 数据页的数据:

		shell> innodb_space -s ibdata1 -T test_db/ruby_block -p 4 page-records
		Record 127: (name="lu") → (id1=1)

		Record 141: (name="lu") → (id1=2)

		Record 155: (name="lu") → (id1=3)

		Record 169: (name="lu") → (id1=4)

		辅助索引存储的是主键值.



	
7. 相关参考	

	下载ruby地址
		https://ruby-china.org/wiki/ruby-mirror
		

	innodb_ruby 参考
	
		http://www.cnblogs.com/cnzeno/p/6322842.html       (使用innodb_ruby探查Innodb索引结构)
		https://www.jianshu.com/p/c51873ea129a             (innodb_ruby：窥探InnoDB的神器)
		https://mp.weixin.qq.com/s/RIcrS_ouOBLxL4hdGwfZfA  ( 我被飞神这篇虐到了 | 深入分析索引页暨计算索引树高度 )
		https://mp.weixin.qq.com/s/At3hwgU7vJqkQ4wy-qvtMw  (innodb_ruby：窥探InnoDB奥秘的神器)
		http://www.cnblogs.com/zengkefu/p/5596478.html     (innodb结构解析工具---innodb_ruby)	








	