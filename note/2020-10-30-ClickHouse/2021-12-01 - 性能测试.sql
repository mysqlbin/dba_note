

服务器信息
	CPU：4核
	内存：16G
	系统：CentOS 7.6
	磁盘类型：1000GB的机械硬盘
	文件系统：ext4


Clickhouse信息
	部署方式：单机部署
	版本： 21.11.4


生成测试数据

	./dbgen -s 100 -T c
	./dbgen -s 100 -T p
	./dbgen -s 100 -T s
	./dbgen -s 100 -T l

	[root@localhost ssb-dbgen-master]# ./dbgen -s 100 -T c
	SSBM (Star Schema Benchmark) Population Generator (Version 1.0.0)
	Copyright Transaction Processing Performance Council 1994 - 2000
	[root@localhost ssb-dbgen-master]# ./dbgen -s 100 -T p
	SSBM (Star Schema Benchmark) Population Generator (Version 1.0.0)
	Copyright Transaction Processing Performance Council 1994 - 2000
	[root@localhost ssb-dbgen-master]# ./dbgen -s 100 -T s
	SSBM (Star Schema Benchmark) Population Generator (Version 1.0.0)
	Copyright Transaction Processing Performance Council 1994 - 2000
	[root@localhost ssb-dbgen-master]# ./dbgen -s 100 -T l
	SSBM (Star Schema Benchmark) Population Generator (Version 1.0.0)
	Copyright Transaction Processing Performance Council 1994 - 2000

	使用 -s 100 dbgen 生成 6 亿行（67 GB），而使用 -s 1000 生成 60 亿行（这需要很多时间）

		
		
	wc -l *tbl
		shell> wc -l *tbl
			3000000 customer.tbl
		  600037902 lineorder.tbl
			1400000 part.tbl
			 200000 supplier.tbl
		  604637902 总用量

	ls -l *tbl
		shell> ls -l *tbl
		-rw-r--r-- 1 root root   331529327 12月  1 11:56 customer.tbl
		-rw-r--r-- 1 root root 70969689336 12月  1 12:18 lineorder.tbl
		-rw-r--r-- 1 root root   140642413 12月  1 11:56 part.tbl
		-rw-r--r-- 1 root root    19462852 12月  1 11:56 supplier.tbl


创建测试库和表

	CREATE DATABASE ch_db;

		localhost.localdomain :) CREATE DATABASE ch_db;

		CREATE DATABASE ch_db

		Query id: a968ef4a-50b2-40d3-b3b2-7bc2163b2db7

		Ok.

		0 rows in set. Elapsed: 0.226 sec. 

		localhost.localdomain :) use ch_db;

		USE ch_db

		Query id: f166158c-09f4-42fd-914b-c095cdce8bff

		Ok.

		0 rows in set. Elapsed: 0.125 sec. 

		localhost.localdomain :) 


	use ch_db;

	CREATE TABLE customer(C_CUSTKEY       UInt32, C_NAME          String, C_ADDRESS       String,C_CITY          LowCardinality(String),C_NATION        LowCardinality(String),C_REGION        LowCardinality(String), C_PHONE         String,C_MKTSEGMENT    LowCardinality(String))ENGINE = MergeTree ORDER BY (C_CUSTKEY);

	CREATE TABLE lineorder(LO_ORDERKEY             UInt32,LO_LINENUMBER           UInt8,LO_CUSTKEY              UInt32, LO_PARTKEY              UInt32,LO_SUPPKEY              UInt32, LO_ORDERDATE            Date, LO_ORDERPRIORITY        LowCardinality(String),LO_SHIPPRIORITY         UInt8,LO_QUANTITY             UInt8, LO_EXTENDEDPRICE        UInt32, LO_ORDTOTALPRICE        UInt32, LO_DISCOUNT             UInt8, LO_REVENUE              UInt32, LO_SUPPLYCOST           UInt32,LO_TAX                  UInt8,LO_COMMITDATE           Date,LO_SHIPMODE             LowCardinality(String))ENGINE = MergeTree PARTITION BY toYear(LO_ORDERDATE) ORDER BY (LO_ORDERDATE, LO_ORDERKEY);

	CREATE TABLE part( P_PARTKEY       UInt32,P_NAME          String,P_MFGR          LowCardinality(String),P_CATEGORY      LowCardinality(String),P_BRAND         LowCardinality(String), P_COLOR         LowCardinality(String), P_TYPE          LowCardinality(String),P_SIZE          UInt8,P_CONTAINER     LowCardinality(String))ENGINE = MergeTree ORDER BY P_PARTKEY;

	CREATE TABLE supplier(S_SUPPKEY       UInt32,S_NAME          String,S_ADDRESS       String,S_CITY          LowCardinality(String),S_NATION        LowCardinality(String), S_REGION        LowCardinality(String),S_PHONE         String)ENGINE = MergeTree ORDER BY S_SUPPKEY;



导入数据

	localhost.localdomain :) show tables;

	SHOW TABLES

	Query id: e64139fb-d23c-4839-b3d2-cd44f7d0f0ed

	┌─name──────┐
	│ customer  │
	│ lineorder │
	│ part      │
	│ supplier  │
	└───────────┘

	4 rows in set. Elapsed: 0.027 sec. 


	time clickhouse-client -h 192.168.0.242 --port 9000  -u default --password "123456abc" -d "ch_db" --query "INSERT INTO customer FORMAT CSV" < customer.tbl
	time clickhouse-client -h 192.168.0.242 --port 9000  -u default --password "123456abc" -d ch_db --query "INSERT INTO part FORMAT CSV" < part.tbl
	time clickhouse-client -h 192.168.0.242 --port 9000  -u default --password "123456abc" -d ch_db --query "INSERT INTO supplier FORMAT CSV" < supplier.tbl
	time clickhouse-client -h 192.168.0.242 --port 9000  -u default --password "123456abc" -d ch_db --query "INSERT INTO lineorder FORMAT CSV" < lineorder.tbl


	--query "INSERT INTO customer FORMAT CSV" < customer.tbl
	real	0m1.685s
	user	0m4.325s
	sys	0m0.171s

	--query "INSERT INTO part FORMAT CSV" < part.tbl
	real	0m1.400s
	user	0m2.636s
	sys	0m0.185s

			
	--query "INSERT INTO supplier FORMAT CSV" < supplier.tbl		
	real	0m0.369s
	user	0m0.285s
	sys	0m0.031s


	--query "INSERT INTO lineorder FORMAT CSV" < lineorder.tbl
	real	39m35.101s
	user	12m49.562s
	sys	0m33.242s




-- 生成表并导入数据
	-- 10GB 
	SET max_memory_usage = 10737418240;

	CREATE TABLE lineorder_flat ENGINE = MergeTree PARTITION BY toYear(LO_ORDERDATE) ORDER BY (LO_ORDERDATE, LO_ORDERKEY) AS SELECT l.LO_ORDERKEY AS LO_ORDERKEY,l.LO_LINENUMBER AS LO_LINENUMBER,l.LO_CUSTKEY AS LO_CUSTKEY,l.LO_PARTKEY AS LO_PARTKEY,l.LO_SUPPKEY AS LO_SUPPKEY,l.LO_ORDERDATE AS LO_ORDERDATE,l.LO_ORDERPRIORITY AS LO_ORDERPRIORITY,l.LO_SHIPPRIORITY AS LO_SHIPPRIORITY,l.LO_QUANTITY AS LO_QUANTITY,l.LO_EXTENDEDPRICE AS LO_EXTENDEDPRICE,l.LO_ORDTOTALPRICE AS LO_ORDTOTALPRICE,l.LO_DISCOUNT AS LO_DISCOUNT,l.LO_REVENUE AS LO_REVENUE,l.LO_SUPPLYCOST AS LO_SUPPLYCOST,l.LO_TAX AS LO_TAX,l.LO_COMMITDATE AS LO_COMMITDATE,l.LO_SHIPMODE AS LO_SHIPMODE,c.C_NAME AS C_NAME,c.C_ADDRESS AS C_ADDRESS,c.C_CITY AS C_CITY,c.C_NATION AS C_NATION,c.C_REGION AS C_REGION,c.C_PHONE AS C_PHONE,c.C_MKTSEGMENT AS C_MKTSEGMENT,s.S_NAME AS S_NAME,s.S_ADDRESS AS S_ADDRESS,s.S_CITY AS S_CITY,s.S_NATION AS S_NATION,s.S_REGION AS S_REGION,s.S_PHONE AS S_PHONE,p.P_NAME AS P_NAME,p.P_MFGR AS P_MFGR,p.P_CATEGORY AS P_CATEGORY,p.P_BRAND AS P_BRAND,p.P_COLOR AS P_COLOR,p.P_TYPE AS P_TYPE,p.P_SIZE AS P_SIZE,p.P_CONTAINER AS P_CONTAINER FROM lineorder AS l INNER JOIN customer AS c ON c.C_CUSTKEY = l.LO_CUSTKEY INNER JOIN supplier AS s ON s.S_SUPPKEY = l.LO_SUPPKEY INNER JOIN part AS p ON p.P_PARTKEY = l.LO_PARTKEY;

	Query id: 79d264bc-3b70-4979-a8d8-163514eefbf8

	Ok.

	0 rows in set. Elapsed: 4882.720 sec. Processed 604.64 million rows, 26.12 GB (123.83 thousand rows/s., 5.35 MB/s.)
	
	------------------------------------------------------------------------------------------------------------------------------
	
	localhost.localdomain :) show create table lineorder_flat;

	SHOW CREATE TABLE lineorder_flat

	Query id: 51ecf9e9-7a94-41fc-b9e8-44c30f5ba6f4

	┌─statement──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
	│ CREATE TABLE ch_db.lineorder_flat
	(
		`LO_ORDERKEY` UInt32,
		`LO_LINENUMBER` UInt8,
		`LO_CUSTKEY` UInt32,
		`LO_PARTKEY` UInt32,
		`LO_SUPPKEY` UInt32,
		`LO_ORDERDATE` Date,
		`LO_ORDERPRIORITY` LowCardinality(String),
		`LO_SHIPPRIORITY` UInt8,
		`LO_QUANTITY` UInt8,
		`LO_EXTENDEDPRICE` UInt32,
		`LO_ORDTOTALPRICE` UInt32,
		`LO_DISCOUNT` UInt8,
		`LO_REVENUE` UInt32,
		`LO_SUPPLYCOST` UInt32,
		`LO_TAX` UInt8,
		`LO_COMMITDATE` Date,
		`LO_SHIPMODE` LowCardinality(String),
		`C_NAME` String,
		`C_ADDRESS` String,
		`C_CITY` LowCardinality(String),
		`C_NATION` LowCardinality(String),
		`C_REGION` LowCardinality(String),
		`C_PHONE` String,
		`C_MKTSEGMENT` LowCardinality(String),
		`S_NAME` String,
		`S_ADDRESS` String,
		`S_CITY` LowCardinality(String),
		`S_NATION` LowCardinality(String),
		`S_REGION` LowCardinality(String),
		`S_PHONE` String,
		`P_NAME` String,
		`P_MFGR` LowCardinality(String),
		`P_CATEGORY` LowCardinality(String),
		`P_BRAND` LowCardinality(String),
		`P_COLOR` LowCardinality(String),
		`P_TYPE` LowCardinality(String),
		`P_SIZE` UInt8,
		`P_CONTAINER` LowCardinality(String)
	)
	ENGINE = MergeTree
	PARTITION BY toYear(LO_ORDERDATE)
	ORDER BY (LO_ORDERDATE, LO_ORDERKEY)
	SETTINGS index_granularity = 8192 │
	└────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
	
	
	SELECT partition_id,name,table,database FROM system.parts WHERE table = 'lineorder_flat'
	localhost.localdomain :) SELECT partition_id,name,table,database FROM system.parts WHERE table = 'lineorder_flat'

	SELECT
		partition_id,
		name,
		table,
		database
	FROM system.parts
	WHERE table = 'lineorder_flat'

	Query id: eb2e885f-2c02-4c6a-ae74-3037ee5c6d0d

	┌─partition_id─┬─name───────────┬─table──────────┬─database─┐
	│ 1992         │ 1992_3_894_3   │ lineorder_flat │ ch_db    │
	│ 1992         │ 1992_895_925_2 │ lineorder_flat │ ch_db    │
	│ 1992         │ 1992_926_931_1 │ lineorder_flat │ ch_db    │
	│ 1992         │ 1992_932_937_1 │ lineorder_flat │ ch_db    │
	│ 1992         │ 1992_938_938_0 │ lineorder_flat │ ch_db    │
	│ 1992         │ 1992_939_939_0 │ lineorder_flat │ ch_db    │
	│ 1992         │ 1992_940_940_0 │ lineorder_flat │ ch_db    │
	│ 1993         │ 1993_4_158_2   │ lineorder_flat │ ch_db    │
	│ 1993         │ 1993_164_300_2 │ lineorder_flat │ ch_db    │
	│ 1993         │ 1993_304_941_2 │ lineorder_flat │ ch_db    │
	│ 1993         │ 1993_942_971_2 │ lineorder_flat │ ch_db    │
	│ 1993         │ 1993_972_977_1 │ lineorder_flat │ ch_db    │
	│ 1993         │ 1993_978_983_1 │ lineorder_flat │ ch_db    │
	│ 1993         │ 1993_984_988_1 │ lineorder_flat │ ch_db    │
	│ 1993         │ 1993_989_993_1 │ lineorder_flat │ ch_db    │
	│ 1993         │ 1993_994_994_0 │ lineorder_flat │ ch_db    │
	│ 1993         │ 1993_995_995_0 │ lineorder_flat │ ch_db    │
	│ 1993         │ 1993_996_996_0 │ lineorder_flat │ ch_db    │
	│ 1993         │ 1993_997_997_0 │ lineorder_flat │ ch_db    │
	│ 1994         │ 1994_415_506_2 │ lineorder_flat │ ch_db    │
	│ 1994         │ 1994_511_797_2 │ lineorder_flat │ ch_db    │
	│ 1994         │ 1994_798_828_2 │ lineorder_flat │ ch_db    │
	│ 1994         │ 1994_829_834_1 │ lineorder_flat │ ch_db    │
	│ 1994         │ 1994_835_840_1 │ lineorder_flat │ ch_db    │
	│ 1994         │ 1994_841_841_0 │ lineorder_flat │ ch_db    │
	│ 1994         │ 1994_842_842_0 │ lineorder_flat │ ch_db    │
	│ 1994         │ 1994_843_843_0 │ lineorder_flat │ ch_db    │
	│ 1995         │ 1995_2_855_3   │ lineorder_flat │ ch_db    │
	│ 1995         │ 1995_856_861_1 │ lineorder_flat │ ch_db    │
	│ 1995         │ 1995_862_867_1 │ lineorder_flat │ ch_db    │
	│ 1995         │ 1995_868_868_0 │ lineorder_flat │ ch_db    │
	│ 1995         │ 1995_869_869_0 │ lineorder_flat │ ch_db    │
	│ 1996         │ 1996_1_715_2   │ lineorder_flat │ ch_db    │
	│ 1996         │ 1996_716_746_2 │ lineorder_flat │ ch_db    │
	│ 1996         │ 1996_747_752_1 │ lineorder_flat │ ch_db    │
	│ 1996         │ 1996_753_758_1 │ lineorder_flat │ ch_db    │
	│ 1996         │ 1996_759_764_1 │ lineorder_flat │ ch_db    │
	│ 1996         │ 1996_765_770_1 │ lineorder_flat │ ch_db    │
	│ 1996         │ 1996_771_771_0 │ lineorder_flat │ ch_db    │
	│ 1996         │ 1996_772_772_0 │ lineorder_flat │ ch_db    │
	│ 1997         │ 1997_60_583_3  │ lineorder_flat │ ch_db    │
	│ 1997         │ 1997_586_626_2 │ lineorder_flat │ ch_db    │
	│ 1997         │ 1997_627_627_0 │ lineorder_flat │ ch_db    │
	│ 1997         │ 1997_628_628_0 │ lineorder_flat │ ch_db    │
	│ 1997         │ 1997_629_629_0 │ lineorder_flat │ ch_db    │
	│ 1997         │ 1997_630_630_0 │ lineorder_flat │ ch_db    │
	│ 1998         │ 1998_631_661_2 │ lineorder_flat │ ch_db    │
	│ 1998         │ 1998_662_667_1 │ lineorder_flat │ ch_db    │
	│ 1998         │ 1998_668_673_1 │ lineorder_flat │ ch_db    │
	│ 1998         │ 1998_674_679_1 │ lineorder_flat │ ch_db    │
	│ 1998         │ 1998_680_680_0 │ lineorder_flat │ ch_db    │
	│ 1998         │ 1998_681_681_0 │ lineorder_flat │ ch_db    │
	│ 1998         │ 1998_682_682_0 │ lineorder_flat │ ch_db    │
	└──────────────┴────────────────┴────────────────┴──────────┘

	53 rows in set. Elapsed: 0.065 sec. 




导入测试数据的耗时以及导完后表空间大小的数据

	表				表数据量		耗时（秒）		tbl文件大小		表空间大小
	customer		3,000,000		1.685			317M			116M
	part			1,400,000		1.400			135M			25M
	supplier		200,000			0.369			19M				7.7M
	lineorder		600,037,902		2375.101		67G				17G
	lineorder_flat	600,037,902		4882.720	         			54G

	

导入后结果
	
	导完后表空间大小的数据
		select table  as  "表名",sum(rows)  as  "总行数", formatReadableSize(sum(datauncompressedbytes)) as "原始大小",formatReadableSize(sum(datacompressedbytes)) as "压缩大小",round(sum(datacompressedbytes) / sum(datauncompressedbytes) * 100, 2) "压缩率" from system.parts group by table;
	
	select count(*) from lineorder_flat;
		
		localhost.localdomain :) select count(*) from lineorder_flat;

		SELECT count(*)
		FROM lineorder_flat

		Query id: 2ec0393e-0d86-44c0-8a79-6ebd91f80814

		┌───count()─┐
		│ 600037902 │
		└───────────┘

		1 rows in set. Elapsed: 0.146 sec. 



查询性能测试详情

Q1.1	
	SELECT sum(LO_EXTENDEDPRICE * LO_DISCOUNT) AS revenue FROM lineorder_flat WHERE toYear(LO_ORDERDATE) = 1993 AND LO_DISCOUNT BETWEEN 1 AND 3 AND LO_QUANTITY < 25;

Q1.2	
	SELECT sum(LO_EXTENDEDPRICE * LO_DISCOUNT) AS revenue FROM lineorder_flat WHERE toYYYYMM(LO_ORDERDATE) = 199401 AND LO_DISCOUNT BETWEEN 4 AND 6 AND LO_QUANTITY BETWEEN 26 AND 35;

Q1.3	
	SELECT sum(LO_EXTENDEDPRICE * LO_DISCOUNT) AS revenue FROM lineorder_flat WHERE toISOWeek(LO_ORDERDATE) = 6 AND toYear(LO_ORDERDATE) = 1994 AND LO_DISCOUNT BETWEEN 5 AND 7 AND LO_QUANTITY BETWEEN 26 AND 35;

Q2.1
	SELECT sum(LO_REVENUE),toYear(LO_ORDERDATE) AS year, P_BRAND FROM lineorder_flat WHERE P_CATEGORY = 'MFGR#12' AND S_REGION = 'AMERICA' GROUP BY year,P_BRAND ORDER BY year,P_BRAND;
	
Q2.2
	SELECT sum(LO_REVENUE),toYear(LO_ORDERDATE) AS year,P_BRAND FROM lineorder_flat WHERE P_BRAND >= 'MFGR#2221' AND P_BRAND <= 'MFGR#2228' AND S_REGION = 'ASIA' GROUP BY year,P_BRAND ORDER BY year, P_BRAND;

Q2.3
	SELECT sum(LO_REVENUE),toYear(LO_ORDERDATE) AS year,P_BRAND FROM lineorder_flat WHERE P_BRAND = 'MFGR#2239' AND S_REGION = 'EUROPE' GROUP BY  year,P_BRAND ORDER BY year,P_BRAND;

Q3.1 
	SELECT C_NATION,S_NATION, toYear(LO_ORDERDATE) AS year,sum(LO_REVENUE) AS revenue FROM lineorder_flat WHERE C_REGION = 'ASIA' AND S_REGION = 'ASIA' AND year >= 1992 AND year <= 1997 GROUP BY C_NATION,S_NATION,year ORDER BY year ASC,revenue DESC;

Q3.2 
	SELECT C_CITY,S_CITY,toYear(LO_ORDERDATE) AS year,sum(LO_REVENUE) AS revenue FROM lineorder_flat WHERE C_NATION = 'UNITED STATES' AND S_NATION = 'UNITED STATES' AND year >= 1992 AND year <= 1997 GROUP BY C_CITY,S_CITY,year ORDER BY year ASC,revenue DESC;

Q3.3 
	SELECT C_CITY, S_CITY,toYear(LO_ORDERDATE) AS year,sum(LO_REVENUE) AS revenue FROM lineorder_flat WHERE (C_CITY = 'UNITED KI1' OR C_CITY = 'UNITED KI5') AND (S_CITY = 'UNITED KI1' OR S_CITY = 'UNITED KI5') AND year >= 1992 AND year <= 1997 GROUP BY C_CITY,S_CITY,year ORDER BY year ASC, revenue DESC;

Q3.4 
	SELECT C_CITY,S_CITY, toYear(LO_ORDERDATE) AS year, sum(LO_REVENUE) AS revenue FROM lineorder_flat WHERE (C_CITY = 'UNITED KI1' OR C_CITY = 'UNITED KI5') AND (S_CITY = 'UNITED KI1' OR S_CITY = 'UNITED KI5') AND toYYYYMM(LO_ORDERDATE) = 199712 GROUP BY C_CITY, S_CITY, year ORDER BY year ASC, revenue DESC;


Q4.1
	SELECT toYear(LO_ORDERDATE) AS year, C_NATION,sum(LO_REVENUE - LO_SUPPLYCOST) AS profit FROM lineorder_flat WHERE C_REGION = 'AMERICA' AND S_REGION = 'AMERICA' AND (P_MFGR = 'MFGR#1' OR P_MFGR = 'MFGR#2') GROUP BY year,C_NATION ORDER BY year ASC,C_NATION ASC;

Q4.2
	SELECT toYear(LO_ORDERDATE) AS year,S_NATION, P_CATEGORY, sum(LO_REVENUE - LO_SUPPLYCOST) AS profit FROM lineorder_flat WHERE C_REGION = 'AMERICA' AND S_REGION = 'AMERICA' AND (year = 1997 OR year = 1998) AND (P_MFGR = 'MFGR#1' OR P_MFGR = 'MFGR#2') GROUP BY year,S_NATION,P_CATEGORY ORDER BY year ASC, S_NATION ASC, P_CATEGORY ASC;
	
Q4.3
	SELECT toYear(LO_ORDERDATE) AS year, S_CITY,P_BRAND,sum(LO_REVENUE - LO_SUPPLYCOST) AS profit FROM lineorder_flat WHERE S_NATION = 'UNITED STATES' AND (year = 1997 OR year = 1998) AND P_CATEGORY = 'MFGR#14' GROUP BY year,S_CITY, P_BRAND ORDER BY year ASC,S_CITY ASC,P_BRAND ASC;


Q1.1	

	-- 第1次执行
	localhost.localdomain :) SELECT sum(LO_EXTENDEDPRICE * LO_DISCOUNT) AS revenue FROM lineorder_flat WHERE toYear(LO_ORDERDATE) = 1993 AND LO_DISCOUNT BETWEEN 1 AND 3 AND LO_QUANTITY < 25;

	SELECT sum(LO_EXTENDEDPRICE * LO_DISCOUNT) AS revenue
	FROM lineorder_flat
	WHERE (toYear(LO_ORDERDATE) = 1993) AND ((LO_DISCOUNT >= 1) AND (LO_DISCOUNT <= 3)) AND (LO_QUANTITY < 25)

	Query id: a83c0bc4-5142-4130-b704-58e3e2173a3b

	┌────────revenue─┐
	│ 44652567249651 │
	└────────────────┘

	1 rows in set. Elapsed: 13.055 sec. Processed 91.01 million rows, 728.06 MB (6.97 million rows/s., 55.77 MB/s.)


	-- 第2次执行
	localhost.localdomain :) SELECT sum(LO_EXTENDEDPRICE * LO_DISCOUNT) AS revenue FROM lineorder_flat WHERE toYear(LO_ORDERDATE) = 1993 AND LO_DISCOUNT BETWEEN 1 AND 3 AND LO_QUANTITY < 25;

	SELECT sum(LO_EXTENDEDPRICE * LO_DISCOUNT) AS revenue
	FROM lineorder_flat
	WHERE (toYear(LO_ORDERDATE) = 1993) AND ((LO_DISCOUNT >= 1) AND (LO_DISCOUNT <= 3)) AND (LO_QUANTITY < 25)

	Query id: c4ea1a0e-02e5-43b7-a191-47998ce19179

	┌────────revenue─┐
	│ 44652567249651 │
	└────────────────┘

	1 rows in set. Elapsed: 0.535 sec. Processed 91.01 million rows, 728.06 MB (170.22 million rows/s., 1.36 GB/s.)



Q1.2	


	localhost.localdomain :) SELECT sum(LO_EXTENDEDPRICE * LO_DISCOUNT) AS revenue FROM lineorder_flat WHERE toYYYYMM(LO_ORDERDATE) = 199401 AND LO_DISCOUNT BETWEEN 4 AND 6 AND LO_QUANTITY BETWEEN 26 AND 35;


	Query id: 54139fd0-dd1c-483e-b25e-4351f1a312d4

	┌───────revenue─┐
	│ 9624332170119 │
	└───────────────┘

	1 rows in set. Elapsed: 2.505 sec. Processed 7.76 million rows, 62.00 MB (3.10 million rows/s., 24.75 MB/s.)
		
		
Q1.3
	
	localhost.localdomain :) SELECT sum(LO_EXTENDEDPRICE * LO_DISCOUNT) AS revenue FROM lineorder_flat WHERE toISOWeek(LO_ORDERDATE) = 6 AND toYear(LO_ORDERDATE) = 1994 AND LO_DISCOUNT BETWEEN 5 AND 7 AND LO_QUANTITY BETWEEN 26 AND 35;


	Query id: 2fbb42d5-2e52-4d6e-b189-27a812be6e5e

	┌───────revenue─┐
	│ 2611093671163 │
	└───────────────┘

	1 rows in set. Elapsed: 0.711 sec. Processed 1.86 million rows, 14.80 MB (2.62 million rows/s., 20.81 MB/s.)

	
	
Q2.1

	localhost.localdomain :) SELECT sum(LO_REVENUE),toYear(LO_ORDERDATE) AS year, P_BRAND FROM lineorder_flat WHERE P_CATEGORY = 'MFGR#12' AND S_REGION = 'AMERICA' GROUP BY year,P_BRAND ORDER BY year,P_BRAND;

	280 rows in set. Elapsed: 148.872 sec. Processed 600.04 million rows, 6.22 GB (4.03 million rows/s., 41.77 MB/s.)


Q2.2 

	localhost.localdomain :) SELECT sum(LO_REVENUE),toYear(LO_ORDERDATE) AS year,P_BRAND FROM lineorder_flat WHERE P_BRAND >= 'MFGR#2221' AND P_BRAND <= 'MFGR#2228' AND S_REGION = 'ASIA' GROUP BY year,P_BRAND ORDER BY year, P_BRAND;

	56 rows in set. Elapsed: 1.973 sec. Processed 600.04 million rows, 5.61 GB (304.07 million rows/s., 2.84 GB/s.)

	
Q2.3 
	localhost.localdomain :) SELECT sum(LO_REVENUE),toYear(LO_ORDERDATE) AS year,P_BRAND FROM lineorder_flat WHERE P_BRAND = 'MFGR#2239' AND S_REGION = 'EUROPE' GROUP BY  year,P_BRAND ORDER BY year,P_BRAND;


	Query id: 56c0dc5b-0d9e-48ee-bb1e-8b95ae3ef58c

	┌─sum(LO_REVENUE)─┬─year─┬─P_BRAND───┐
	│     65751589723 │ 1992 │ MFGR#2239 │
	│     64532844801 │ 1993 │ MFGR#2239 │
	│     64722599002 │ 1994 │ MFGR#2239 │
	│     65616432683 │ 1995 │ MFGR#2239 │
	│     64802884686 │ 1996 │ MFGR#2239 │
	│     64485541165 │ 1997 │ MFGR#2239 │
	│     37276536361 │ 1998 │ MFGR#2239 │
	└─────────────────┴──────┴───────────┘

	7 rows in set. Elapsed: 1.845 sec. Processed 600.04 million rows, 5.61 GB (325.22 million rows/s., 3.04 GB/s.)

Q3.1

	localhost.localdomain :) SELECT C_NATION,S_NATION, toYear(LO_ORDERDATE) AS year,sum(LO_REVENUE) AS revenue FROM lineorder_flat WHERE C_REGION = 'ASIA' AND S_REGION = 'ASIA' AND year >= 1992 AND year <= 1997 GROUP BY C_NATION,S_NATION,year ORDER BY year ASC,revenue DESC

	150 rows in set. Elapsed: 37.426 sec. Processed 546.67 million rows, 5.48 GB (14.61 million rows/s., 146.35 MB/s.)


Q3.2 

	localhost.localdomain :) SELECT C_CITY,S_CITY,toYear(LO_ORDERDATE) AS year,sum(LO_REVENUE) AS revenue FROM lineorder_flat WHERE C_NATION = 'UNITED STATES' AND S_NATION = 'UNITED STATES' AND year >= 1992 AND year <= 1997 GROUP BY C_CITY,S_CITY,year ORDER BY year ASC,revenue DESC;

	600 rows in set. Elapsed: 34.341 sec. Processed 546.67 million rows, 5.57 GB (15.92 million rows/s., 162.17 MB/s.)


Q3.3 

	localhost.localdomain :) SELECT C_CITY, S_CITY,toYear(LO_ORDERDATE) AS year,sum(LO_REVENUE) AS revenue FROM lineorder_flat WHERE (C_CITY = 'UNITED KI1' OR C_CITY = 'UNITED KI5') AND (S_CITY = 'UNITED KI1' OR S_CITY = 'UNITED KI5') AND year >= 1992 AND year <= 1997 GROUP BY C_CITY,S_CITY,year ORDER BY year ASC, revenue DESC;

	24 rows in set. Elapsed: 2.048 sec. Processed 546.67 million rows, 4.48 GB (266.94 million rows/s., 2.19 GB/s.)

Q3.4 
	
	localhost.localdomain :) SELECT C_CITY,S_CITY, toYear(LO_ORDERDATE) AS year, sum(LO_REVENUE) AS revenue FROM lineorder_flat WHERE (C_CITY = 'UNITED KI1' OR C_CITY = 'UNITED KI5') AND (S_CITY = 'UNITED KI1' OR S_CITY = 'UNITED KI5') AND toYYYYMM(LO_ORDERDATE) = 199712 GROUP BY C_CITY, S_CITY, year ORDER BY year ASC, revenue DESC;

	┌─C_CITY─────┬─S_CITY─────┬─year─┬───revenue─┐
	│ UNITED KI1 │ UNITED KI1 │ 1997 │ 481119563 │
	│ UNITED KI5 │ UNITED KI5 │ 1997 │ 386477033 │
	│ UNITED KI5 │ UNITED KI1 │ 1997 │ 378048353 │
	│ UNITED KI1 │ UNITED KI5 │ 1997 │ 366630529 │
	└────────────┴────────────┴──────┴───────────┘

	4 rows in set. Elapsed: 0.065 sec. Processed 7.75 million rows, 63.41 MB (120.03 million rows/s., 982.50 MB/s.)


Q4.1
	localhost.localdomain :) SELECT toYear(LO_ORDERDATE) AS year, C_NATION,sum(LO_REVENUE - LO_SUPPLYCOST) AS profit FROM lineorder_flat WHERE C_REGION = 'AMERICA' AND S_REGION = 'AMERICA' AND (P_MFGR = 'MFGR#1' OR P_MFGR = 'MFGR#2') GROUP BY year,C_NATION ORDER BY year ASC,C_NATION ASC;

	35 rows in set. Elapsed: 97.199 sec. Processed 600.04 million rows, 8.41 GB (6.17 million rows/s., 86.51 MB/s.)


Q4.2
	localhost.localdomain :) SELECT toYear(LO_ORDERDATE) AS year,S_NATION, P_CATEGORY, sum(LO_REVENUE - LO_SUPPLYCOST) AS profit FROM lineorder_flat WHERE C_REGION = 'AMERICA' AND S_REGION = 'AMERICA' AND (year = 1997 OR year = 1998) AND (P_MFGR = 'MFGR#1' OR P_MFGR = 'MFGR#2') GROUP BY year,S_NATION,P_CATEGORY ORDER BY year ASC, S_NATION ASC, P_CATEGORY ASC;
	
	100 rows in set. Elapsed: 6.330 sec. Processed 144.42 million rows, 2.17 GB (22.82 million rows/s., 342.71 MB/s.)
		
Q4.3

	localhost.localdomain :) SELECT toYear(LO_ORDERDATE) AS year, S_CITY,P_BRAND,sum(LO_REVENUE - LO_SUPPLYCOST) AS profit FROM lineorder_flat WHERE S_NATION = 'UNITED STATES' AND (year = 1997 OR year = 1998) AND P_CATEGORY = 'MFGR#14' GROUP BY year,S_CITY, P_BRAND ORDER BY year ASC,S_CITY ASC,P_BRAND ASC;

	800 rows in set. Elapsed: 1.533 sec. Processed 144.42 million rows, 2.24 GB (94.22 million rows/s., 1.46 GB/s.)


	

