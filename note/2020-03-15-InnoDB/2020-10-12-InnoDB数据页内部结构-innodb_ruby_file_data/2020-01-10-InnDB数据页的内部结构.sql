
 


show global variables like '%checksum%';



表和数据初始化:
	CREATE TABLE t (
	a INT UNSIGNED NOT NULL AUTO_INCREMENT,
	b CHAR(10),
	PRIMARY KEY(a)
	) ENGINE=INNODB CHARSET=LATIN1 ROW_FORMAT=COMPACT;

	DELIMITER 
	CREATE PROCEDURE load_t (count INT UNSIGNED)
	BEGIN
	SET @c=0;
	WHILE @c < count DO
	INSERT INTO t SELECT NULL,REPEAT(CHAR(97+RAND()*26),10);
	SET @c=@c+1;
	END WHILE;
	END;
	DELIMITER ;


	CALL load_t(100);


python py_innodb_page_info.py -v /data/mysql/mysql3306/data/test_db/t.ibd 

[root@mgr9 py_innodb_page_info-master]# python py_innodb_page_info.py -v /data/mysql/mysql3306/data/test_db/t.ibd 
page offset 00000000, page type <File Space Header>
page offset 00000001, page type <Insert Buffer Bitmap>
page offset 00000002, page type <File Segment inode>
page offset 00000003, page type <B-tree Node>, page level <0000>
page offset 00000004, page type <B-tree Node>, page level <0000>
page offset 00000000, page type <Freshly Allocated Page>
Total number of page: 6:
Freshly Allocated Page: 1
Insert Buffer Bitmap: 1
File Space Header: 1
B-tree Node: 2
File Segment inode: 1



通过 space-indexes 查看索引信息
	--name为索引名称，fseg为leaf表示属于叶子页的segment：
	[root@mgr9 data]# innodb_space -s ibdata1 -T test_db/t space-indexes
	id          name                            root        fseg        used        allocated   fill_factor 
	35155       PRIMARY                         3           internal    1           1           100.00%     
	35155       PRIMARY                         3           leaf        0           0           0.00%  

	

space-page-type-regions : 

	[root@mgr9 data]# innodb_space -f /data/mysql/mysql3306/data/test_db/t.ibd space-page-type-regions
	start       end         count       type                
	0           0           1           FSP_HDR             
	1           1           1           IBUF_BITMAP         
	2           2           1           INODE               
	3           3           1           INDEX               
	4           4           1           FREE (INDEX)        
	5           5           1           FREE (ALLOCATED) 

	通过结果可知，page为0,1,2类型名称分别是： FSP_HDR , IBUF_BITMAP, INODE 。从page=3开始才是存放行数据和指针的页。  *******
(InnoDB_Structures 里面的介绍都是从 page=3开始)
	
通过 space-index-pages-summary 得到整个索引树的概要信息：

 
	shell> innodb_space -s ibdata1 -T test_db/t space-index-pages-summary 
	page        index   level   data    free    records 
	3           35155   0       3300    12904   100     
	4           35155   0       3300    12904   100     
	5           0       0       0       16384   0 
	
通过 page-directory-summary 分析页编号为3的数据页，得到存储页目录的内容：
	shell> innodb_space -s ibdata1 -T test_db/t -p 3 page-directory-summary
	slot    offset  type          owned   key
	0       99      infimum       1       
	1       225     conventional  4       (a=4)
	2       357     conventional  4       (a=8)
	3       489     conventional  4       (a=12)
	4       621     conventional  4       (a=16)
	5       753     conventional  4       (a=20)
	6       885     conventional  4       (a=24)
	7       1017    conventional  4       (a=28)
	8       1149    conventional  4       (a=32)
	9       1281    conventional  4       (a=36)
	10      1413    conventional  4       (a=40)
	11      1545    conventional  4       (a=44)
	12      1677    conventional  4       (a=48)
	13      1809    conventional  4       (a=52)
	14      1941    conventional  4       (a=56)
	15      2073    conventional  4       (a=60)
	16      2205    conventional  4       (a=64)
	17      2337    conventional  4       (a=68)
	18      2469    conventional  4       (a=72)
	19      2601    conventional  4       (a=76)
	20      2733    conventional  4       (a=80)
	21      2865    conventional  4       (a=84)
	22      2997    conventional  4       (a=88)
	23      3129    conventional  4       (a=92)
	24      3261    conventional  4       (a=96)
	25      112     supremum      5       

	1. slot：槽编号 为 0-25,说明 槽的数量 26 个
    2. offset ：行记录的相对位置
    3. type：槽的类型: infimum、conventional、supremum
                  
	4. owned：一个槽指针指向的行记录数量
		infimum： 1
			说明 指向页内第1个行记录的记录头
		conventional： 4
			说明 该槽指针指向页内4个行记录
		supremum： 5
			说明 该槽指针指向页内5个行记录:  between a 97 and 100 和 一个虚拟的页内最大记录
			
    5. key：
        槽指针指向行记录的主键
        slot: 1, owned=4， key: a=4, 说明 slot1 指针指向的记录数为4行, 分别为 between a 1 and 4; 
		
	
通过 page-directory-summary 分析页编号为4的数据页，得到存储页目录的内容：

	shell> innodb_space -s ibdata1 -T test_db/t -p 4 page-directory-summary
	slot    offset  type          owned   key
	0       99      infimum       1       
	1       225     conventional  4       (a=4)
	2       357     conventional  4       (a=8)
	3       489     conventional  4       (a=12)
	4       621     conventional  4       (a=16)
	5       753     conventional  4       (a=20)
	6       885     conventional  4       (a=24)
	7       1017    conventional  4       (a=28)
	8       1149    conventional  4       (a=32)
	9       1281    conventional  4       (a=36)
	10      1413    conventional  4       (a=40)
	11      1545    conventional  4       (a=44)
	12      1677    conventional  4       (a=48)
	13      1809    conventional  4       (a=52)
	14      1941    conventional  4       (a=56)
	15      2073    conventional  4       (a=60)
	16      2205    conventional  4       (a=64)
	17      2337    conventional  4       (a=68)
	18      2469    conventional  4       (a=72)
	19      2601    conventional  4       (a=76)
	20      2733    conventional  4       (a=80)
	21      2865    conventional  4       (a=84)
	22      2997    conventional  4       (a=88)
	23      3129    conventional  4       (a=92)
	24      3261    conventional  4       (a=96)
	25      112     supremum      5       
	

	
[root@mgr9 test_db]# hexdump -C -v t.ibd > 2020-01-13-hexdump分析数据页结构.sql
	
	
	

相关参考:
	InnoDB 存储引擎 第2版
	https://dev.mysql.com/doc/internals/en/innodb-page-overview.html    
	https://mp.weixin.qq.com/s/Wc6Gw6S5xMy2DhTCrogxVQ                 通过MySQL存储原理来分析排序和锁
	http://zhongmingmao.me/2017/05/08/innodb-table-page-structure/ 
	https://www.cnblogs.com/coderyuhui/p/8884717.html#4204546         MySQL · 引擎特性 · InnoDB 数据页解析
	