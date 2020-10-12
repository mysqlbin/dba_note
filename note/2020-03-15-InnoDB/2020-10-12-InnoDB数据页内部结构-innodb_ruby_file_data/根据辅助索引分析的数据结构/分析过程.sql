


目的:
	根据分析出来的 索引结构和数据页结构，画出B+Tree索引示意图

	
分析辅助索引 idx_num
[root@mgr9 data]# innodb_space -s ibdata1 -T test_db/page_info -I idx_num index-recurse > not_primary_recurse.log

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
	
提取关键信息来做分析。
ROOT NODE #4: 832 records, 14144 bytes


1. 先分析根节点: 根节点只能有一个root页。

[root@mgr9 data]# innodb_space -s ibdata1 -T test_db/page_info -p 4 page-records > root_4.log

[root@mgr9 data]# wc -l root_4.log 
832 root_4.log



根节点所在的数据页编号为4，有832条记录即832个分支。 就是说根节点扇出832个分支。


根据信息得到如下 B+Tree图:
root(level1)     
					page4	
num			39 ... 2500  ...  2909
	
	
2. 分析叶子节点:

#分析 叶子节点编号为39的数据页	
[root@mgr9 data]# innodb_space -s ibdata1 -T test_db/page_info -p 39 page-records > lead_node_39.log

[root@mgr9 data]# cat lead_node_39.log
Record 125: (num=1) → (id=1)
Record 138: (num=2) → (id=2)
Record 151: (num=3) → (id=3)
截断---------------------
Record 15725: (num=1201) → (id=1201)
Record 15738: (num=1202) → (id=1202)
Record 15751: (num=1203) → (id=1203)


#分析 叶子节点编号为2500的数据页	
[root@mgr9 data]# innodb_space -s ibdata1 -T test_db/page_info -p 2500 page-records > lead_node_2500.log
[root@mgr9 data]# cat lead_node_2500.log
Record 125: (num=505261) → (id=505261)
Record 138: (num=505262) → (id=505262)
Record 151: (num=505263) → (id=50526
截断---------------------
Record 15725: (num=506461) → (id=506461)
Record 15738: (num=506462) → (id=506462)
Record 15751: (num=506463) → (id=506463)




#分析 叶子节点编号为2909的数据页	
[root@mgr9 data]# innodb_space -s ibdata1 -T test_db/page_info -p 2909 page-records > lead_node_2909.log
[root@mgr9 data]# cat lead_node_2909.log
Record 125: (num=999694) → (id=999694)
Record 138: (num=999695) → (id=999695)
Record 151: (num=999696) → (id=999696)
截断---------------------
Record 4077: (num=999998) → (id=999998)
Record 4090: (num=999999) → (id=999999)
Record 4103: (num=1000000) → (id=1000000)
根据信息得到如下 B+Tree图:

root(level1)     
					page4	
num			39 ... 2500  ...  2909
-------------------------------------------------
level0
		page39 <-...-> 2500  <-...->  page2909
		
num:  1.....1203   505261...506463   999694...1000000   
id:   1.....1203   505261...506463   999694...1000000 
	
	
一个叶子节点的数据页有1203条记录。
最后一个叶子节点编号为 2909 的数据页有307条记录，没有填满。
结论：
	辅助索引的叶子节点存储的是主键值。


	
使用 innodb_space 来查看page_info表的索引结构、数据分配情况
#old:
[root@mgr9 data]# innodb_space -s ibdata1 -T test_db/page_info space-indexes
id          name                            root        fseg        used        allocated   fill_factor 
16559       PRIMARY                         3           internal    3           3           100.00%     
16559       PRIMARY                         3           leaf        1743        1760        99.03%      
16560       idx_num                         38          internal    1           1           100.00%     
16560       idx_num                         38          leaf        832         992         83.87%  

#new: 
[root@mgr9 data]# innodb_space -s ibdata1 -T test_db/page_info space-indexes
id          name                            root        fseg        used        allocated   fill_factor 
16561       PRIMARY                         3           internal    3           3           100.00%     
16561       PRIMARY                         3           leaf        1743        2016        86.46%      
16562       idx_num                         4           internal    1           1           100.00%     
16562       idx_num                         4           leaf        832         992         83.87% 



辅助索引的叶子节点存储的所有行记录的计算公式:
辅助索引的叶子节点使用了 1743 个page;
一个叶子节点页有 1203条记录;
辅助索引的叶子节点最后一个数据页有 307行记录;
	832*1203=1000896
	1203-307  = 896
	1000896-896=1000000条记录.

	
查看索引的统计信息:	
root@mysqldb 23:36:  [(none)]> select * from mysql.innodb_index_stats  where table_name = 'page_info';
+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
| test_db       | page_info  | PRIMARY    | 2019-05-12 01:17:36 | n_diff_pfx01 |     998739 |          20 | id                                |
| test_db       | page_info  | PRIMARY    | 2019-05-12 01:17:36 | n_leaf_pages |       1743 |        NULL | Number of leaf pages in the index |
| test_db       | page_info  | PRIMARY    | 2019-05-12 01:17:36 | size         |       2019 |        NULL | Number of pages in the index      |
| test_db       | page_info  | idx_num    | 2019-05-12 01:17:36 | n_diff_pfx01 |    1000064 |          20 | num                               |
| test_db       | page_info  | idx_num    | 2019-05-12 01:17:36 | n_diff_pfx02 |    1000064 |          20 | num,id                            |
| test_db       | page_info  | idx_num    | 2019-05-12 01:17:36 | n_leaf_pages |        832 |        NULL | Number of leaf pages in the index |
| test_db       | page_info  | idx_num    | 2019-05-12 01:17:36 | size         |        993 |        NULL | Number of pages in the index      |
+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
7 rows in set (0.07 sec)

stat_name=n_leaf_pages时：stat_value 表示叶子节点使用的数据页的数量为 832个Page; 
stat_name=size时：        stat_value 表示为叶子节点和非叶子节点分配的数据页的数量的 993个Page; 
	参考: https://mp.weixin.qq.com/s/698g5lm9CWqbU0B_p0nLMw?  (MySQL统计信息简介 )
	
