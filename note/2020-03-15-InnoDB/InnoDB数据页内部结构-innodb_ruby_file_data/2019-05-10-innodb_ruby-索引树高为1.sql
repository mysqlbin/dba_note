

要结合 InnoDB_Structures 来看。

下载ruby地址：
	https://ruby-china.org/wiki/ruby-mirror
	

参考：
http://www.cnblogs.com/cnzeno/p/6322842.html       (使用innodb_ruby探查Innodb索引结构)
https://www.jianshu.com/p/c51873ea129a             (innodb_ruby：窥探InnoDB的神器)
https://mp.weixin.qq.com/s/RIcrS_ouOBLxL4hdGwfZfA  ( 我被飞神这篇虐到了 | 深入分析索引页暨计算索引树高度 )
https://mp.weixin.qq.com/s/At3hwgU7vJqkQ4wy-qvtMw  (innodb_ruby：窥探InnoDB奥秘的神器)
http://www.cnblogs.com/zengkefu/p/5596478.html     (innodb结构解析工具---innodb_ruby)	
	
CREATE TABLE `ruby_block` (
  `id1` int(11) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `id3` int(11) DEFAULT NULL,
  PRIMARY KEY (`id1`),
  KEY `name` (`name`),
  KEY `id3` (`id3`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


insert into ruby_block values(1,'lu',1),(2,'lu',2),(3,'lu',3),(4,'lu',4);


大纲:

1. Space File Structure
	space-indexes
	space-page-type-regions
	
2. Page Structure	
3. Index Structure
4. Record Structure
5. Record History

	
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

问题：
[root@mgr9 data]# innodb_space -s ibdata1 -T /data/mysql/mysql3306/data/test_db/ruby_block space-indexes
/usr/local/lib/ruby/gems/2.1.0/gems/innodb_ruby-0.9.15/lib/innodb/system.rb:101:in `space_by_table_name': Table /data/mysql/mysql3306/data/test_db/ruby_block not found (RuntimeError)
	from /usr/local/lib/ruby/gems/2.1.0/gems/innodb_ruby-0.9.15/bin/innodb_space:1896:in `<top (required)>'
	from /usr/local/bin/innodb_space:23:in `load'
	from /usr/local/bin/innodb_space:23:in `<main>'

原因:
  -T后面用了绝对路径.
解决办法:
	不要用绝对路径.
 
Space File Structure

1. space-indexes
查看索引信息--name为索引名称，fseg为leaf表示属于叶子页的segment：
使用 innodb_space 来查看ruby_block表的索引结构、数据分配情况
[root@mgr9 data]# innodb_space -s ibdata1 -T test_db/ruby_block space-indexes
id          name                            root        fseg        used        allocated   fill_factor 
16556       PRIMARY                         3           internal    1           1           100.00%     
16556       PRIMARY                         3           leaf        0           0           0.00%       
16557       name                            4           internal    1           1           100.00%     
16557       name                            4           leaf        0           0           0.00%       
16558       id3                             5           internal    1           1           100.00%     
16558       id3                             5           leaf        0           0           0.00%      


name:索引的名称；PRIMARY代表的就是聚集索引，因为InnoDB表是聚集所以组织表，行记录就是聚集索引；name和id3 就是辅助索引的名称.

root:索引中根节点的 page number ；可以看出聚集索引的根节点是第3个page（为什么是从第三个page开始，看下文 space-page-type-regions ），辅助索引的根节点是第4个page

fseg: page的说明

used:索引树使用了多少个page；可以看出聚集索引的根几点使用了1个page，叶子节点使用了0个page；辅助索引name 和 id3 的叶子节点都使用了0个page            

allocated: 为索引树分配了多少个page；可以看出聚集索引的根几点分配了1个page，叶子节点分配了0个page；辅助索引 name 和 id3 的叶子节点都分配了0个page

（通过 used 和 allocated 可以看到每棵索引树一共使用了多少个Page，根节点和叶子节点分别使用了多少个Page。）

fill_factor:索引的填充度；所有的填充度都是100%

/*
[root@MySQL56_L1 data]# innodb_space -s ibdata1 -T zeno3376/t2 space-indexes
id          name                            root        fseg        used        allocated   fill_factor
42          PRIMARY                         3           internal    1           1           100.00%     
42          PRIMARY                         3           leaf        9           9           100.00%     
43          ix_t2_name                      4           internal    1           1           100.00%     
43          ix_t2_name                      4           leaf        4           4           100.00%   
name:索引的名称；PRIMARY代表的就是聚集索引，因为InnoDB表是聚集所以组织表，行记录就是聚集索引；ix_t2_name就是辅助索引的名称

root:索引中根节点的 page number ；可以看出聚集索引的根节点是第3个page（为什么是从第三个page开始，看下文 space-page-type-regions ），辅助索引的根节点是第4个page

fseg: page的说明

used:索引树使用了多少个page；可以看出聚集索引的根几点使用了1个page，叶子节点使用了9个page；辅助索引ix_t2_name的叶子节点使用了4个page **********           

allocated: 为索引树分配了多少个page；可以看出聚集索引的根几点分配了1个page，叶子节点分配了9个page；辅助索引ix_t2_name的叶子节点分配了4个page

（通过 used 和 allocated 可以看到每棵索引树一共使用了多少个Page，根节点和叶子节点分别使用了多少个Page。）

fill_factor:索引的填充度；所有的填充度都是100%
*/

index-level-summary:  得到指定level的所有page信息：

[root@mgr9 data]# innodb_space -s ibdata1 -T test_db/ruby_block -I PRIMARY -l 0  index-level-summary
page    index   level   data    free    records min_key 
3       16556   0       124     16128   4       id1=1

[root@mgr9 data]# innodb_space -s ibdata1 -T test_db/ruby_block -I PRIMARY -l 1  index-level-summary
page    index   level   data    free    records min_key 

[root@mgr9 data]# innodb_space -s ibdata1 -T test_db/ruby_block -I PRIMARY -l 2  index-level-summary
page    index   level   data    free    records min_key

我们知道level值和索引树的高度是强相关的（叶子节点的level都是0），所以通过这个命令也可以知道InnoDB索引树高度.
由上面执行命令的结果可知，level=1时没有任何数据，而level等于0有，所以示例4行记录(数据)的表的索引树高度是1。



2. space-page-type-regions:
[root@mgr9 data]# innodb_space -f /data/mysql/mysql3306/data/test_db/ruby_block.ibd space-page-type-regions
start       end         count       type                
0           0           1           FSP_HDR             
1           1           1           IBUF_BITMAP         
2           2           1           INODE               
3           5           3           INDEX               
6           7           2           FREE (ALLOCATED) 

通过结果可知，page为0,1,2类型名称分别是： FSP_HDR , IBUF_BITMAP, INODE 。从page=3开始才是存放行数据和指针的页。  *******
(InnoDB_Structures 里面的介绍都是从 page=3开始)



Index Structure

1. index-recurse (递归索引)
分析主键索引
[root@mgr9 data]# innodb_space -s ibdata1 -T test_db/ruby_block -I PRIMARY index-recurse
ROOT NODE #3: 4 records, 124 bytes
  RECORD: (id1=1) → (name="lu", id3=1)
  RECORD: (id1=2) → (name="lu", id3=2)
  RECORD: (id1=3) → (name="lu", id3=3)
  RECORD: (id1=4) → (name="lu", id3=4)

因为树的高度是1, 所以 根节点也是叶子节点.

从结果可知，ROOT NODE即根节点是page=3的页, 有4条记录. 主键索引树的叶子节点/根节点存储了整行数据.


分析辅助索引 name
[root@mgr9 data]# innodb_space -s ibdata1 -T test_db/ruby_block -I name index-recurse
ROOT NODE #4: 4 records, 56 bytes
  RECORD: (name="lu") → (id1=1)
  RECORD: (name="lu") → (id1=2)
  RECORD: (name="lu") → (id1=3)
  RECORD: (name="lu") → (id1=4)

因为树的高度是1, 所以 根节点也是叶子节点.

从结果可知，ROOT NODE即根节点是page=4的页, 有4条记录. 辅助索引存储的是主键值.


Page Structure

1. page-records:  统计某一页中的数据(有多少行)。
统计 page=3 数据页的数据:
[root@mgr9 data]# innodb_space -s ibdata1 -T test_db/ruby_block -p 3 page-records 
Record 127: (id1=1) → (name="lu", id3=1)

Record 158: (id1=2) → (name="lu", id3=2)

Record 189: (id1=3) → (name="lu", id3=3)

Record 220: (id1=4) → (name="lu", id3=4)

从结果可知，ROOT NODE即根节点是page=3的页, 有4条记录. 主键索引树的叶子节点/根节点存储了整行数据.  参考: index-recurse

统计 page=4 数据页的数据:

[root@mgr9 data]# innodb_space -s ibdata1 -T test_db/ruby_block -p 4 page-records
Record 127: (name="lu") → (id1=1)

Record 141: (name="lu") → (id1=2)

Record 155: (name="lu") → (id1=3)

Record 169: (name="lu") → (id1=4)

辅助索引存储的是主键值.



	
	

	