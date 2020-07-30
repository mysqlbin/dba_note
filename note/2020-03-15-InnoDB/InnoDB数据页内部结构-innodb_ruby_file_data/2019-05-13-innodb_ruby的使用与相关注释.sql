

要结合 InnoDB_Structures 来看。

下载ruby地址：
	https://ruby-china.org/wiki/ruby-mirror
	

参考：
http://www.cnblogs.com/cnzeno/p/6322842.html       (使用innodb_ruby探查Innodb索引结构)
https://www.jianshu.com/p/c51873ea129a             (innodb_ruby：窥探InnoDB的神器)
https://mp.weixin.qq.com/s/RIcrS_ouOBLxL4hdGwfZfA  ( 我被飞神这篇虐到了 | 深入分析索引页暨计算索引树高度 )
https://mp.weixin.qq.com/s/At3hwgU7vJqkQ4wy-qvtMw  (innodb_ruby：窥探InnoDB奥秘的神器)
http://www.cnblogs.com/zengkefu/p/5596478.html     (innodb结构解析工具---innodb_ruby)	
	
	
根节点
非叶子节点
叶子节点
	
DROP PROCEDURE IF EXISTS insertbatch;
CREATE PROCEDURE insertbatch()
BEGIN
DECLARE i INT;
  SET i=1;
	start transaction;
  WHILE(i<=1000000) DO
    INSERT INTO test_db.page_info(num)VALUES(i);
    SET i=i+1; 
  END WHILE;
	commit;
END;


call insertbatch();


CREATE TABLE `page_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `num` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_num` (`num`)
) ENGINE=InnoDB AUTO_INCREMENT=1000001 DEFAULT CHARSET=utf8mb4;


大纲:
0. innodb_space
1. Space File Structure       分析表空间文件结构
 1.1 space-indexes            统计指定数据表的所有索引信息  
 1.2 space-page-type-regions  统计相同类型页的连续空间
	
2. Page Structure	          分析数据页结构
 
3. Index Structure            分析索引结构
  3.1 index-recurse				  递归索引
    3.1.1 分析主键索引的数据结构， 包含inernal节点和叶子节点
    3.1.2 分析辅助索引的数据结构， 包含inernal节点和叶子节点
  3.2 index-level-summary          打印给定级别的所有索引页的摘要


4. Record Structure        

5. Record History

0. innodb_space
	
	[root@mgr9 ruby-2.1.10]# innodb_space --help

	Usage: innodb_space <options> <mode>

	Invocation examples:

	  innodb_space -s ibdata1 [-T tname [-I iname]] [options] <mode>
		Use ibdata1 as the system tablespace and load the tname table (and the
		iname index for modes that require it) from data located in the system
		tablespace data dictionary. This will automatically generate a record
		describer for any indexes.

	  innodb_space -f tname.ibd [-r ./desc.rb -d DescClass] [options] <mode>
		Use the tname.ibd table (and the DescClass describer where required).

1. Space File Structure
	
	1.1 space-indexes
		查看索引信息--name为索引名称，fseg为leaf表示属于叶子页的segment：
		使用 innodb_space 来查看page_info表的索引结构、数据分配情况
		[root@mgr9 data]# innodb_space -s ibdata1 -T test_db/page_info space-indexes
		id          name                            root        fseg        used        allocated   fill_factor 
		16559       PRIMARY                         3           internal    3           3           100.00%     
		16559       PRIMARY                         3           leaf        1743        1760        99.03%      
		16560       idx_num                         38          internal    1           1           100.00%     
		16560       idx_num                         38          leaf        832         992         83.87%  
		
		-- 非叶子节点统称为 internal内节点
		
		name:索引的名称；PRIMARY代表的就是聚集索引，因为InnoDB表是聚集索引组织表，行记录就是聚集索引；idx_num 就是辅助索引的名称.

		root: 索引中根节点的 page number ；可以看出聚集索引的根节点是第3个page
		（为什么是从第三个page开始，看下文 space-page-type-regions ），辅助索引的根节点是第38个page

		fseg: page的说明

		used:索引树使用了多少个page；
		可以看出聚集索引的非叶子节点使用了3个page，叶子节点使用了1743个page；辅助索引 idx_num 的叶子节点都使用了832个page            

		allocated: 
		为索引树分配了多少个page; 
			聚集索引的非叶子节点分配了3个page，叶子节点分配了1760个page；
			辅助索引 idx_num 的叶子节点都分配了992个page

		（通过 used 和 allocated 可以看到每棵索引树一共使用了多少个Page，根节点和叶子节点分别使用了多少个Page。）

		fill_factor: 索引的填充度/填充率


		/*
		alter table page_info engine=innodb;  之后
		[root@mgr9 data]# innodb_space -s ibdata1 -T test_db/page_info space-indexes
		id          name                            root        fseg        used        allocated   fill_factor 
		16561       PRIMARY                         3           internal    3           3           100.00%     
		16561       PRIMARY                         3           leaf        1743        2016        86.46%      
		16562       idx_num                         4           internal    1           1           100.00%     
		16562       idx_num                         4           leaf        832         992         83.87%     
		*/

		可以查看数据字典确认: 
		mysql> select b.name, a.name, index_id, type, a.SPACE, a.PAGE_NO, FILE_FORMAT, ROW_FORMAT from information_schema.INNODB_SYS_INDEXES a, information_schema.INNODB_SYS_TABLES b where a.table_id = b.table_id and a.space <> 0 and b.name = 'test_db/page_info';
		+-------------------+---------+----------+------+-------+---------+-------------+------------+
		| name              | name    | index_id | type | SPACE | PAGE_NO | FILE_FORMAT | ROW_FORMAT |
		+-------------------+---------+----------+------+-------+---------+-------------+------------+
		| test_db/page_info | PRIMARY |    16561 |    3 |  3994 |       3 | Barracuda   | Dynamic    |
		| test_db/page_info | idx_num |    16562 |    0 |  3994 |       4 | Barracuda   | Dynamic    |
		+-------------------+---------+----------+------+-------+---------+-------------+------------+
		2 rows in set (0.00 sec)



index-level-summary:  得到索引指定level的所有page信息：

统计主键索引的page信息:
# level=0的page太多，所以只统计行数：

[root@mgr9 data]# [root@mgr9 data]# innodb_space -s ibdata1 -T test_db/page_info -I PRIMARY -l 0  index-level-summary | wc -l
1744

/*innodb_space -s ibdata1 -T test_db/page_info -I PRIMARY -l 0  index-level-summary 的部分信息 
page    index   level   data    free    records min_key
5       16561   0       14924   1044    574     id=1
6       16561   0       14924   1044    574     id=575
8       16561   0       14924   1044    574     id=1149
9       16561   0       14924   1044    574     id=1723
10      16561   0       14924   1044    574     id=2297
11      16561   0       14924   1044    574     id=2871
12      16561   0       14924   1044    574     id=3445
13      16561   0       14924   1044    574     id=4019
14      16561   0       14924   1044    574     id=4593
15      16561   0       14924   1044    574     id=5167
16      16561   0       14924   1044    574     id=5741
*/

[root@mgr9 data]# innodb_space -s ibdata1 -T test_db/page_info -I PRIMARY -l 1  index-level-summary
page    index   level   data    free    records min_key 
7       16561   1       14664   1026    1128    id=1
38      16561   1       7995    7953    615     id=647473

[root@mgr9 data]# innodb_space -s ibdata1 -T test_db/page_info -I PRIMARY -l 2  index-level-summary
page    index   level   data    free    records min_key 
3       16561   2       26      16226   2       id=1

[root@mgr9 data]# innodb_space -s ibdata1 -T test_db/page_info -I PRIMARY -l 3  index-level-summary
page    index   level   data    free    records min_key 


我们知道level值和索引树的高度是强相关的（叶子节点的level都是0），所以通过这个命令也可以知道InnoDB索引树高度.
由上面执行命令的结果可知，level=3时没有任何数据，而level等于0 1 2有，所以示例100w数据的表的索引树高度是3。


统计普通索引树的page信息:
[root@mgr9 data]# innodb_space -s ibdata1 -T test_db/page_info -I idx_num -l 0  index-level-summary | wc -l
833

[root@mgr9 data]# innodb_space -s ibdata1 -T test_db/page_info -I idx_num -l 1  index-level-summary
page    index   level   data    free    records min_key 
4       16562   1       14144   1694    832     num=1

[root@mgr9 data]# innodb_space -s ibdata1 -T test_db/page_info -I idx_num -l 2  index-level-summary
page    index   level   data    free    records min_key 




2. space-page-type-regions:
[root@mgr9 data]# innodb_space -f /data/mysql/mysql3306/data/test_db/page_info.ibd space-page-type-regions
start       end         count       type                
0           0           1           FSP_HDR             
1           1           1           IBUF_BITMAP         
2           2           1           INODE               
3           40          38          INDEX               
41          41          1           FREE (INDEX)        
42          1770        1729        INDEX               
1771        1791        21          FREE (ALLOCATED)    
1792        1792        1           INDEX               
1793        1855        63          FREE (ALLOCATED)    
1856        1856        1           INDEX               
1857        1919        63          FREE (ALLOCATED)    
1920        1920        1           INDEX               
1921        1983        63          FREE (ALLOCATED)    
1984        1984        1           INDEX               
1985        2047        63          FREE (ALLOCATED)    
2048        2055        8           INDEX               
2056        2111        56          FREE (ALLOCATED)    
2112        2909        798         INDEX               
2910        2943        34          FREE (ALLOCATED)    
2944        2944        1           INDEX               
2945        3007        63          FREE (ALLOCATED)    
3008        3008        1           INDEX               
3009        3199        191         FREE (ALLOCATED)    


通过结果可知，page为0,1,2类型名称分别是： FSP_HDR , IBUF_BITMAP, INODE 。从page=3开始才是存放行数据和指针的页。  *******
(InnoDB_Structures 里面的介绍都是从 page=3开始)


3. Index Structure

1. index-recurse (递归索引)


	分析主键索引的数据结构， 包含inernal节点和叶子节点

[root@mgr9 data]# innodb_space -s ibdata1 -T test_db/page_info -I PRIMARY index-recurse > primary_recurse.log
[root@mgr9 data]# wc -l primary_recurse.log 
1003491 primary_recurse.log	  
	
# 部分内容(前10行内容)如下：

[root@mgr9 data]# head -10 primary_recurse.log 
ROOT NODE #3: 2 records, 26 bytes
  NODE POINTER RECORD ≥ (id=1) → #7
  INTERNAL NODE #7: 1128 records, 14664 bytes
    NODE POINTER RECORD ≥ (id=1) → #5
    LEAF NODE #5: 574 records, 14924 bytes
      RECORD: (id=1) → (num=1)
      RECORD: (id=2) → (num=2)
      RECORD: (id=3) → (num=3)
      RECORD: (id=4) → (num=4)
      RECORD: (id=5) → (num=5)	  

从结果可知，ROOT NODE即根节点是page=3的页。通过space-page-type-regions的分析可知，0,1,2这三个page类型是FSP_HDR, IBUF_BITMAP, INODE。其他的就是INTERNAL节点和LEAF节点。
LEAF NODE:
	叶子节点存储的是整行数据.
	

分析辅助索引 idx_num
[root@mgr9 data]# innodb_space -s ibdata1 -T test_db/page_info -I idx_num index-recurse > not_primary_recurse.log

[root@mgr9 data]# wc -l not_primary_recurse.log 
1001665 not_primary_recurse.log

[root@mgr9 data]# head -10 not_primary_recurse.log 
ROOT NODE #4: 832 records, 14144 bytes
  NODE POINTER RECORD ≥ (num=1) → #39
  LEAF NODE #39: 1203 records, 15639 bytes
    RECORD: (num=1) → (id=1)
    RECORD: (num=2) → (id=2)
    RECORD: (num=3) → (id=3)
    RECORD: (num=4) → (id=4)
    RECORD: (num=5) → (id=5)
    RECORD: (num=6) → (id=6)
    RECORD: (num=7) → (id=7)

从结果可知，ROOT NODE即根节点是page=4的页, 辅助索引的叶子节点存储的是主键值.


Page Structure

1. page-records:  统计某一页中的数据(有多少行)。
主键索引的root页.
统计 page=3 这个数据页的数据, 以刚才index-recurse的结果为例，page=3是root页，这个page的数据如下，
由结果可知，page=3有两个record，与primary_recurse.log的结果是吻合的（ROOT NODE #3: 2 records, 26 bytes）：
[root@mgr9 data]# innodb_space -s ibdata1 -T test_db/page_info -p 3 page-records > page_no_3_page_records.log
[root@mgr9 data]# wc -l page_no_3_page_records.log
2 page_no_3_page_records.log
[root@mgr9 data]# cat page_no_3_page_records.log 
Record 125: (id=1) → #7
Record 138: (id=647473) → #38

结论: 
从这个结果也能看出来，root页是不保存具体数据，只保存主键索引的值和指针。


我们再从primary_recurse.log中找几个LEAF节点，如下所示，page=1766，1767这些都是LEAF节点：
[root@mgr9 data]# grep "LEAF" primary_recurse.log  | tail -5
    LEAF NODE #1766: 574 records, 14924 bytes
    LEAF NODE #1767: 574 records, 14924 bytes
    LEAF NODE #1768: 574 records, 14924 bytes
    LEAF NODE #1769: 574 records, 14924 bytes
    LEAF NODE #1770: 92 records, 2392 bytes

其中，page=1766的部分数据如下，一个页大概能574条记录，而page=1770还没有填满，只有92条数据：

[root@mgr9 data]# innodb_space -s ibdata1 -T test_db/page_info -p 1770 page-records > lead_node_1770.log
[root@mgr9 data]# head lead_node_1770.log 
Record 125: (id=999909) → (num=999909)

Record 151: (id=999910) → (num=999910)

Record 177: (id=999911) → (num=999911)

Record 203: (id=999912) → (num=999912)

Record 229: (id=999913) → (num=999913)


结论: 
从这个结果也能看出来，叶子页会保存具体数据，不只是主键，非主键其他列（num列）的数据也有保存。




space-indexes
查看索引信息--name为索引名称，fseg为leaf表示属于叶子页的segment：
使用 innodb_space 来查看page_info表的索引结构、数据分配情况
[root@mgr9 data]# innodb_space -s ibdata1 -T test_db/page_info space-indexes
id          name                            root        fseg        used        allocated   fill_factor 
16559       PRIMARY                         3           internal    3           3           100.00%     
16559       PRIMARY                         3           leaf        1743        1760        99.03%      
16560       idx_num                         38          internal    1           1           100.00%     
16560       idx_num                         38          leaf        832         992         83.87% 

space-index-pages-summary模式能够得到整个索引树的概要信息，结果如下所示：
[root@mgr9 data]# innodb_space -s ibdata1 -T test_db/page_info space-index-pages-summary > pages-summary.log
	


	