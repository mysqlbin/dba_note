
1. 初始化表结构和数据
2. space-indexes
3. 通过 space-index-pages-summary 得到整个索引树的概要信息
4. index-recurse 递归索引
5. 通过 page-directory-summary 分析页编号为5的数据页得到存储页目录的内容
6. 查看数据页编号为7的记录详情
7. 查看数据页编号为4的记录详情
8. 查看数据页编号为3的记录详情


1. 初始化表结构和数据
	drop table if exists page_info2;
	CREATE TABLE `page_info2` (
			  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
			  `num` int(11) NOT NULL,
			  PRIMARY KEY (`id`),
			  KEY `idx_num` (`num`)
			) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;
			-- 创建存储过程
	DROP PROCEDURE IF EXISTS insertbatch;
	CREATE PROCEDURE insertbatch()
	BEGIN
	DECLARE i INT;
	  SET i=1;
	  WHILE(i<=1000) DO
		INSERT INTO test_db.page_info2(num)VALUES(i);
		SET i=i+1; 
	  END WHILE;
	END;

	-- 调用存储过程
	call insertbatch();


2. space-indexes

	shell> innodb_space -s ibdata1 -T test_db/page_info2 space-indexes

	id          name                            root        fseg        fseg_id     used        allocated   fill_factor 
	321988      PRIMARY                         3           internal    1           1           1           100.00%     
	321988      PRIMARY                         3           leaf        2           3           3           100.00%  
	321989      idx_num                         4           internal    3           1           1           100.00%     
	321989      idx_num                         4           leaf        4           0           0           0.00%       


3. 通过 space-index-pages-summary 得到整个索引树的概要信息

 
	shell> innodb_space -s ibdata1 -T test_db/page_info2 space-index-pages-summary 
	page        index   level   data    free    records 
	3           321988  1       39      16213   3       
	4           321989  0       13000   2754    1000 
	5           321988  0       7462    8648    287     
	6           321988  0       14924   1044    574     
	7           321988  0       3614    12572   139  
	8           0       0       0       16384   0       

	level = 1: 根节点？是的。
	
	

4. index-recurse 递归索引

	innodb_space -s ibdata1 -T test_db/page_info2 -I PRIMARY index-recurse > 1.sql

	ROOT NODE #3: 3 records, 39 bytes
	  NODE POINTER RECORD ≥ (id=1) → #5
	  LEAF NODE #5: 287 records, 7462 bytes
		RECORD: (id=1) → (num=1)
		RECORD: (id=2) → (num=2)
		
	  .................................
	
		RECORD: (id=287) → (num=287)
	  NODE POINTER RECORD ≥ (id=288) → #6
	  LEAF NODE #6: 574 records, 14924 bytes
		RECORD: (id=288) → (num=288)
		RECORD: (id=289) → (num=289)

	.................................	
	  NODE POINTER RECORD ≥ (id=862) → #7
	  LEAF NODE #7: 139 records, 3614 bytes
		RECORD: (id=862) → (num=862)
		

5. 通过 page-directory-summary 分析页编号为5的数据页得到存储页目录的内容

	shell> innodb_space -s ibdata1 -T test_db/page_info2 -p 5 page-directory-summary
	slot    offset  type          owned   key
	0       99      infimum       1       
	1       203     conventional  4       (id=4)
	2       307     conventional  4       (id=8)
	3       411     conventional  4       (id=12)
	................................................
	69      7275    conventional  4       (id=276)
	70      7379    conventional  4       (id=280)
	71      7483    conventional  4       (id=284)
	72      112     supremum      4       
	   

	
	slot：槽编号 为 0-72; 槽的数量 73 个
    offset ：行记录的相对位置
    type：infimum、conventional、supremum
            
            
	owned：一个槽指针指向所在分组的行记录数量
		infimum： 1
		conventional： 4
		supremum： 5
		
    max key：
        每个槽指针指向所在分组中行记录的最大值
		
    slot: 2, owned=4， max key: id=8
	
		slot: 2 		表示槽的编号为1
		owned=4 		表示编号为2的槽拥有4行记录
		max key: id=8  表示编号为2的槽的最大记录为 id=8.
		

		
		
6. 查看数据页编号为7的记录详情

	shell> innodb_space -s ibdata1 -T test_db/page_info2 -p 7 page-records 		
		
	Record 125: (id=862) → (num=862)

	Record 151: (id=863) → (num=863)

	Record 177: (id=864) → (num=864)

	Record 203: (id=865) → (num=865)

	Record 229: (id=866) → (num=866)
	
	............................................

	Record 3635: (id=997) → (num=997)

	Record 3661: (id=998) → (num=998)

	Record 3687: (id=999) → (num=999)

	Record 3713: (id=1000) → (num=1000)


7. 查看数据页编号为4的记录详情

	shell> innodb_space -s ibdata1 -T test_db/page_info2 -p 4 page-records > 4.sql	
	
	Record 125: (num=1) → (id=1)

	Record 138: (num=2) → (id=2)

	Record 151: (num=3) → (id=3)

	Record 164: (num=4) → (id=4)

	Record 177: (num=5) → (id=5)
	
	............................................
	
	Record 13086: (num=998) → (id=998)

	Record 13099: (num=999) → (id=999)

	Record 13112: (num=1000) → (id=1000)


8. 查看数据页编号为3的记录详情
	
	shell> innodb_space -s ibdata1 -T test_db/page_info2 -p 3 page-records 		
	
	Record 125: (id=1) → #5
	Record 138: (id=288) → #6
	Record 151: (id=862) → #7








		
  