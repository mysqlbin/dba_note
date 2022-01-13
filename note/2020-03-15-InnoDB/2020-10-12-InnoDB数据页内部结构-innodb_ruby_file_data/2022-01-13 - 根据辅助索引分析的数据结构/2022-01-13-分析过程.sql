
1. 目的
2. 分析辅助索引idx_num
3. 先分析根节点: 根节点只有一个root页
4. 分析叶子节点
5. 使用 innodb_space 来查看page_info表的索引结构、数据分配情况
6. 辅助索引的叶子节点存储的所有行记录的计算公式
7. 查看索引的统计信息


1. 目的

	根据分析出来的二级索引结构和数据页结构，画出B+Tree索引示意图
	
	了解数据在B+树中怎么分布的
	
	
	
2. 分析辅助索引idx_num

	shell> innodb_space -s ibdata1 -T test_db/page_info -I idx_num index-recurse > not_primary_recurse.log

	shell> cat not_primary_recurse.log 
	ROOT NODE #4: 832 records, 14144 bytes
	  NODE POINTER RECORD ≥ (num=1) → #2911
	  LEAF NODE #2911: 1203 records, 15639 bytes
		RECORD: (num=1) → (id=1)
		RECORD: (num=2) → (id=2)
		RECORD: (num=2) → (id=4)
		RECORD: (num=5) → (id=3)
		RECORD: (num=5) → (id=5)
		RECORD: (num=6) → (id=6)
		RECORD: (num=7) → (id=7)
		RECORD: (num=8) → (id=8)
		RECORD: (num=9) → (id=9)
		RECORD: (num=10) → (id=10)
		..........................
		
		RECORD: (num=999995) → (id=999995)
		RECORD: (num=999996) → (id=999996)
		RECORD: (num=999997) → (id=999997)
		RECORD: (num=999998) → (id=999998)
		RECORD: (num=999999) → (id=999999)
		RECORD: (num=1000000) → (id=1000000)
		
	提取关键信息来做分析。
	ROOT NODE #4: 832 records, 14144 bytes


3. 先分析根节点: 根节点只有一个root页

	shell> innodb_space -s ibdata1 -T test_db/page_info -p 4 page-records > root_4.log

	shell> wc -l root_4.log 
	832 root_4.log



	根节点所在的数据页编号为4，有832条记录即832个分支。 就是说根节点扇出832个分支。


	根据信息得到如下 B+Tree图:
	root(level1)     
						page4	
	num			1 ... 28873  ...  999694
	id          
	level0
			page2911   page2048  page2909
		
	
4. 分析叶子节点

	分析 叶子节点编号为 2911 的数据页	
	
		shell> innodb_space -s ibdata1 -T base_db/page_info -p 2911 page-records > lead_node_2911.log

		shell> cat lead_node_39.log
		Record 7951: (num=1) → (id=1)

		Record 7964: (num=2) → (id=2)

		Record 7977: (num=2) → (id=4)

		Record 7990: (num=5) → (id=3)

		Record 8003: (num=5) → (id=5)

		Record 8016: (num=6) → (id=6)

		............................

		Record 7899: (num=1200) → (id=1200)

		Record 7912: (num=1201) → (id=1201)

		Record 7925: (num=1202) → (id=1202)

		Record 7938: (num=1203) → (id=1203)


	分析 叶子节点编号为 2048 的数据页
	
		shell> innodb_space -s ibdata1 -T base_db/page_info -p 2048 page-records > lead_node_2048.log
		
		shell> cat lead_node_2048.log

		Record 125: (num=28873) → (id=28873)

		Record 138: (num=28874) → (id=28874)

		Record 151: (num=28875) → (id=28875)

		Record 164: (num=28876) → (id=28876)

		Record 177: (num=28877) → (id=28877)

		Record 190: (num=28878) → (id=28878)

		............................

		Record 15699: (num=30071) → (id=30071)

		Record 15712: (num=30072) → (id=30072)

		Record 15725: (num=30073) → (id=30073)

		Record 15738: (num=30074) → (id=30074)

		Record 15751: (num=30075) → (id=30075)


	分析 叶子节点编号为2909的数据页	
	
		shell> innodb_space -s ibdata1 -T base_db/page_info -p 2909 page-records > lead_node_2909.log
		
		shell> cat lead_node_2909.log
		Record 125: (num=999694) → (id=999694)

		Record 138: (num=999695) → (id=999695)

		Record 151: (num=999696) → (id=999696)

		Record 164: (num=999697) → (id=999697)

		Record 177: (num=999698) → (id=999698)
		
		............................
		
		Record 4051: (num=999996) → (id=999996)

		Record 4064: (num=999997) → (id=999997)

		Record 4077: (num=999998) → (id=999998)

		Record 4090: (num=999999) → (id=999999)

		Record 4103: (num=1000000) → (id=1000000)


		
	根据信息得到如下 B+Tree图:
		
		root(level1)     
							page4	
		num			1 ... 28873  ...  999694
		-------------------------------------------------
		level0
				page2911 <-...-> page2048  <-...->  page2909
				
		num:  1.....1203   28873...30075   999694...1000000   
		id:   1.....1203   28873...30075   999694...1000000 
	
	
	
	叶子节点的数据页有1203条记录。
	最后一个叶子节点编号为 2909 的数据页有307条记录，没有填满。
	
	结论：辅助索引的叶子节点存储的是主键值。


	
5. 使用 innodb_space 来查看page_info表的索引结构、数据分配情况

	shell> innodb_space -s ibdata1 -T base_db/page_info space-indexes
	id          name                            root        fseg        fseg_id     used        allocated   fill_factor 
	5825        PRIMARY                         3           internal    1           3           3           100.00%     
	5825        PRIMARY                         3           leaf        2           1743        2016        86.46%      
	5826        idx_num                         4           internal    3           1           1           100.00%     
	5826        idx_num                         4           leaf        4           832         991         83.96%  


6. 辅助索引的叶子节点存储的所有行记录的计算公式

	辅助索引的叶子节点使用了 832 个page;
	
	一个叶子节点页有 1203 条记录;
	
	辅助索引的叶子节点最后一个数据页有 307行记录;
	
	mysql> select 831 * 1203 + 307;
	+------------------+
	| 831 * 1203 + 307 |
	+------------------+
	|          1000000 |
	+------------------+
	1 row in set (0.00 sec)

	
7. 查看索引的统计信息
	
	mysql> select * from mysql.innodb_index_stats  where table_name = 'page_info';
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| base_db       | page_info  | PRIMARY    | 2020-07-31 10:51:26 | n_diff_pfx01 |     998739 |          20 | id                                |
	| base_db       | page_info  | PRIMARY    | 2020-07-31 10:51:26 | n_leaf_pages |       1743 |        NULL | Number of leaf pages in the index |
	| base_db       | page_info  | PRIMARY    | 2020-07-31 10:51:26 | size         |       2019 |        NULL | Number of pages in the index      |
	| base_db       | page_info  | idx_num    | 2020-07-31 10:51:26 | n_diff_pfx01 |    1000064 |          20 | num                               |
	| base_db       | page_info  | idx_num    | 2020-07-31 10:51:26 | n_diff_pfx02 |    1000064 |          20 | num,id                            |
	| base_db       | page_info  | idx_num    | 2020-07-31 10:51:26 | n_leaf_pages |        832 |        NULL | Number of leaf pages in the index |
	| base_db       | page_info  | idx_num    | 2020-07-31 10:51:26 | size         |        993 |        NULL | Number of pages in the index      |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	7 rows in set (0.06 sec)

	
	stat_name=n_leaf_pages时：stat_value 表示叶子节点使用的数据页的数量为 832个Page; 
	stat_name=size时：        stat_value 表示为叶子节点和非叶子节点分配的数据页的数量的 993个Page; 
		参考: https://mp.weixin.qq.com/s/698g5lm9CWqbU0B_p0nLMw?  (MySQL统计信息简介 )
		
