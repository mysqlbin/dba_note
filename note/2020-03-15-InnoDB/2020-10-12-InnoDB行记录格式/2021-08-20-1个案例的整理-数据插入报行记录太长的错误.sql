
0. 环境
1. 验证 blog 大字段类型是否会存储到溢出页中
2. 多个 blob 大字段发生了行溢出，导致实际存储到数据库的行记录长度大于8126
	2.1 现象
	2.2 分析
	2.3 解决办法
3. 小结
4. 源码部分
5. dynamic多个字段溢出


0. 环境
	
	测试环境的数据库版本是5.7，行记录格式为dynamic
	
	老系统的环境的数据库版本是5.6，行记录格式为compact
	

1. 验证 blog 大字段类型是否会存储到溢出页中

	drop table table_2021082002 if exists;
	CREATE TABLE `table_2021082002` (
	  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
	  `a` blob COMMENT '...',
	  PRIMARY KEY (`ID`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

	INSERT INTO `table_2021082002` 
	(`a`) 
	VALUES (
	REPEAT('a',3000)
	);
	
	[root@localhost ~]# python innodb_page_info/py_innodb_page_info.py -v /home/mysql/mysql3306/data/yldbs/table_2021082002.ibd 
	page offset 00000000, page type <File Space Header>
	page offset 00000001, page type <Insert Buffer Bitmap>
	page offset 00000002, page type <File Segment inode>
	page offset 00000003, page type <B-tree Node>, page level <0000>
	page offset 00000000, page type <Freshly Allocated Page>
	page offset 00000000, page type <Freshly Allocated Page>
	Total number of page: 6:
	Freshly Allocated Page: 2
	Insert Buffer Bitmap: 1
	File Space Header: 1
	B-tree Node: 1
	File Segment inode: 1

	-- 说明行记录溢出才会把大于 768字节 的数据字段溢出到大对象页中。
	
	--  官方文档：TEXT and BLOB columns that are less than or equal to 40 bytes are stored in line.
	--  翻译: 小于或等于 40 字节的 TEXT 和 BLOB 列存储在行中。

	
------------------------------------------------------------------------------------------------------------------------


2. 多个 blob 大字段发生了行溢出，每个blob字段保留在行记录内的长度为 768字节，导致实际存储到数据库的行记录长度大于8126

	2.1 现象
		mysql> select ROW_FORMAT from information_schema.tables where TABLE_SCHEMA='yldbs' and  TABLE_NAME='table_2021082003';
		+------------+
		| ROW_FORMAT |
		+------------+
		| Compact    |
		+------------+
		1 row in set (0.00 sec)


		drop table  if exists table_2021082003;
		CREATE TABLE `table_2021082003` (
		  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `a` blob COMMENT '...',
		  `b` blob COMMENT '...',
		  `c` blob COMMENT '...',
		  `d` blob COMMENT '...',
		  `a1` blob COMMENT '...',
		  `a2` blob COMMENT '...',
		  `a3` blob COMMENT '...',
		  `a4` blob COMMENT '...',
		  `a5` blob COMMENT '...',
		  `a6` blob COMMENT '...',
		  `a7` blob COMMENT '...',
		  `a8` blob COMMENT '...',
		  `a9` blob COMMENT '...',
		  `a10` blob COMMENT '...',
		  PRIMARY KEY (`ID`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

		INSERT INTO `table_2021082003` 
		(`a`, `b`, `c`, `d`, `a1`, `a2`, `a3`, `a4`, `a5`, `a6`, `a7`, `a8`, `a9`, `a10`) 
		VALUES (
		'{\"LogCount\":25,\"jsonlog\":[{\"1\":\"看三张新手房,底分 1\"},{\"2\":\"玩家账户:73821 座位号:1\"},{\"3\":\"玩家账户:62818 座位号:2\"},{\"4\":\"玩家账户:62371 座位号:3\"},{\"5\":\"1 号位,携带金额 1099999000.0\"},{\"6\":\"2 号位,携带金额 9634712008\"},{\"7\":\"3 号位,携带金额 326666190\"},{\"8\":\"发3张牌\"},{\"9\":\"抢庄\"},{\"10\":\"1 号位,开局第3秒,抢2倍\"},{\"11\":\"3 号位,开局第5秒,抢0倍\"},{\"12\":\"2 号位,开局第5秒,抢3倍\"},{\"13\":\"2 号位,开局第5秒,抢庄成功\"},{\"14\":\"下注\"},{\"15\":\"1 号位,开局第7秒,下11倍\"},{\"16\":\"3 号位,开局第8秒,下1倍\"},{\"17\":\"补牌\"},{\"18\":\"开牌\"},{\"19\":\"1 号位,开局第10秒,开牌\"},{\"20\":\"2 号位,开局第11秒,开牌\"},{\"21\":\"3 号位,开局第12秒,开牌\"},{\"22\":\"结算\"},{\"23\":\"1 号位,闲,本局输赢分数-66000,牌值♥1♠J♣J♥9♣5,牛五*1\"},{\"24\":\"2 号位,庄,本局输赢分数68400,牌值♠7♦6♥8♣7♦K,牛八*2\"},{\"25\":\"3 号位,闲,本局输赢分数-6000,牌值♣6♦1♣10♣2♠5,无牛*1\"}],\"jsondata\":[\"playerid=73821 chairid=1\",\"playerid=62818 chairid=2\",\"playerid=62371 chairid=3\",\" chairid=1 money=1099999000.0\",\" chairid=2 money=9634712008\",\" chairid=3 money=326666190\",\" chairid=1 time=3,BeiShu=2\",\" chairid=3 time=5,BeiShu=0\",\" chairid=2 time=5,BeiShu=3\",\" chairid=2 time=5,qiangzhang success\",\" chairid=1 time=7,PushBet=11\",\" chairid=3 time=8,PushBet=1\",\" chairid=1 time=10,OpenCard\",\" chairid=2 time=11,OpenCard\",\" chairid=3 time=12,OpenCard\",\" chairid=1 bankerUser=2,roundScore-66000,chCardData=[49,75,43,57,37],NNum=5\",\" chairid=2 bankerUser=2,roundScore68400,chCardData=[71,22,56,39,29],NNum=8\",\" chairid=3 bankerUser=2,roundScore-6000,chCardData=[38,17,42,34,69],NNum=0\"]}',
		'{\"LogCount\":25,\"jsonlog\":[{\"1\":\"看三张新手房,底分 1\"},{\"2\":\"玩家账户:73821 座位号:1\"},{\"3\":\"玩家账户:62818 座位号:2\"},{\"4\":\"玩家账户:62371 座位号:3\"},{\"5\":\"1 号位,携带金额 1099999000.0\"},{\"6\":\"2 号位,携带金额 9634712008\"},{\"7\":\"3 号位,携带金额 326666190\"},{\"8\":\"发3张牌\"},{\"9\":\"抢庄\"},{\"10\":\"1 号位,开局第3秒,抢2倍\"},{\"11\":\"3 号位,开局第5秒,抢0倍\"},{\"12\":\"2 号位,开局第5秒,抢3倍\"},{\"13\":\"2 号位,开局第5秒,抢庄成功\"},{\"14\":\"下注\"},{\"15\":\"1 号位,开局第7秒,下11倍\"},{\"16\":\"3 号位,开局第8秒,下1倍\"},{\"17\":\"补牌\"},{\"18\":\"开牌\"},{\"19\":\"1 号位,开局第10秒,开牌\"},{\"20\":\"2 号位,开局第11秒,开牌\"},{\"21\":\"3 号位,开局第12秒,开牌\"},{\"22\":\"结算\"},{\"23\":\"1 号位,闲,本局输赢分数-66000,牌值♥1♠J♣J♥9♣5,牛五*1\"},{\"24\":\"2 号位,庄,本局输赢分数68400,牌值♠7♦6♥8♣7♦K,牛八*2\"},{\"25\":\"3 号位,闲,本局输赢分数-6000,牌值♣6♦1♣10♣2♠5,无牛*1\"}],\"jsondata\":[\"playerid=73821 chairid=1\",\"playerid=62818 chairid=2\",\"playerid=62371 chairid=3\",\" chairid=1 money=1099999000.0\",\" chairid=2 money=9634712008\",\" chairid=3 money=326666190\",\" chairid=1 time=3,BeiShu=2\",\" chairid=3 time=5,BeiShu=0\",\" chairid=2 time=5,BeiShu=3\",\" chairid=2 time=5,qiangzhang success\",\" chairid=1 time=7,PushBet=11\",\" chairid=3 time=8,PushBet=1\",\" chairid=1 time=10,OpenCard\",\" chairid=2 time=11,OpenCard\",\" chairid=3 time=12,OpenCard\",\" chairid=1 bankerUser=2,roundScore-66000,chCardData=[49,75,43,57,37],NNum=5\",\" chairid=2 bankerUser=2,roundScore68400,chCardData=[71,22,56,39,29],NNum=8\",\" chairid=3 bankerUser=2,roundScore-6000,chCardData=[38,17,42,34,69],NNum=0\"]}',
		'{\"LogCount\":25,\"jsonlog\":[{\"1\":\"看三张新手房,底分 1\"},{\"2\":\"玩家账户:73821 座位号:1\"},{\"3\":\"玩家账户:62818 座位号:2\"},{\"4\":\"玩家账户:62371 座位号:3\"},{\"5\":\"1 号位,携带金额 1099999000.0\"},{\"6\":\"2 号位,携带金额 9634712008\"},{\"7\":\"3 号位,携带金额 326666190\"},{\"8\":\"发3张牌\"},{\"9\":\"抢庄\"},{\"10\":\"1 号位,开局第3秒,抢2倍\"},{\"11\":\"3 号位,开局第5秒,抢0倍\"},{\"12\":\"2 号位,开局第5秒,抢3倍\"},{\"13\":\"2 号位,开局第5秒,抢庄成功\"},{\"14\":\"下注\"},{\"15\":\"1 号位,开局第7秒,下11倍\"},{\"16\":\"3 号位,开局第8秒,下1倍\"},{\"17\":\"补牌\"},{\"18\":\"开牌\"},{\"19\":\"1 号位,开局第10秒,开牌\"},{\"20\":\"2 号位,开局第11秒,开牌\"},{\"21\":\"3 号位,开局第12秒,开牌\"},{\"22\":\"结算\"},{\"23\":\"1 号位,闲,本局输赢分数-66000,牌值♥1♠J♣J♥9♣5,牛五*1\"},{\"24\":\"2 号位,庄,本局输赢分数68400,牌值♠7♦6♥8♣7♦K,牛八*2\"},{\"25\":\"3 号位,闲,本局输赢分数-6000,牌值♣6♦1♣10♣2♠5,无牛*1\"}],\"jsondata\":[\"playerid=73821 chairid=1\",\"playerid=62818 chairid=2\",\"playerid=62371 chairid=3\",\" chairid=1 money=1099999000.0\",\" chairid=2 money=9634712008\",\" chairid=3 money=326666190\",\" chairid=1 time=3,BeiShu=2\",\" chairid=3 time=5,BeiShu=0\",\" chairid=2 time=5,BeiShu=3\",\" chairid=2 time=5,qiangzhang success\",\" chairid=1 time=7,PushBet=11\",\" chairid=3 time=8,PushBet=1\",\" chairid=1 time=10,OpenCard\",\" chairid=2 time=11,OpenCard\",\" chairid=3 time=12,OpenCard\",\" chairid=1 bankerUser=2,roundScore-66000,chCardData=[49,75,43,57,37],NNum=5\",\" chairid=2 bankerUser=2,roundScore68400,chCardData=[71,22,56,39,29],NNum=8\",\" chairid=3 bankerUser=2,roundScore-6000,chCardData=[38,17,42,34,69],NNum=0\"]}',
		'{\"LogCount\":25,\"jsonlog\":[{\"1\":\"看三张新手房,底分 1\"},{\"2\":\"玩家账户:73821 座位号:1\"},{\"3\":\"玩家账户:62818 座位号:2\"},{\"4\":\"玩家账户:62371 座位号:3\"},{\"5\":\"1 号位,携带金额 1099999000.0\"},{\"6\":\"2 号位,携带金额 9634712008\"},{\"7\":\"3 号位,携带金额 326666190\"},{\"8\":\"发3张牌\"},{\"9\":\"抢庄\"},{\"10\":\"1 号位,开局第3秒,抢2倍\"},{\"11\":\"3 号位,开局第5秒,抢0倍\"},{\"12\":\"2 号位,开局第5秒,抢3倍\"},{\"13\":\"2 号位,开局第5秒,抢庄成功\"},{\"14\":\"下注\"},{\"15\":\"1 号位,开局第7秒,下11倍\"},{\"16\":\"3 号位,开局第8秒,下1倍\"},{\"17\":\"补牌\"},{\"18\":\"开牌\"},{\"19\":\"1 号位,开局第10秒,开牌\"},{\"20\":\"2 号位,开局第11秒,开牌\"},{\"21\":\"3 号位,开局第12秒,开牌\"},{\"22\":\"结算\"},{\"23\":\"1 号位,闲,本局输赢分数-66000,牌值♥1♠J♣J♥9♣5,牛五*1\"},{\"24\":\"2 号位,庄,本局输赢分数68400,牌值♠7♦6♥8♣7♦K,牛八*2\"},{\"25\":\"3 号位,闲,本局输赢分数-6000,牌值♣6♦1♣10♣2♠5,无牛*1\"}],\"jsondata\":[\"playerid=73821 chairid=1\",\"playerid=62818 chairid=2\",\"playerid=62371 chairid=3\",\" chairid=1 money=1099999000.0\",\" chairid=2 money=9634712008\",\" chairid=3 money=326666190\",\" chairid=1 time=3,BeiShu=2\",\" chairid=3 time=5,BeiShu=0\",\" chairid=2 time=5,BeiShu=3\",\" chairid=2 time=5,qiangzhang success\",\" chairid=1 time=7,PushBet=11\",\" chairid=3 time=8,PushBet=1\",\" chairid=1 time=10,OpenCard\",\" chairid=2 time=11,OpenCard\",\" chairid=3 time=12,OpenCard\",\" chairid=1 bankerUser=2,roundScore-66000,chCardData=[49,75,43,57,37],NNum=5\",\" chairid=2 bankerUser=2,roundScore68400,chCardData=[71,22,56,39,29],NNum=8\",\" chairid=3 bankerUser=2,roundScore-6000,chCardData=[38,17,42,34,69],NNum=0\"]}',
		REPEAT('a',3000),
		REPEAT('a',3000),
		REPEAT('a',3000),
		REPEAT('a',3000),
		REPEAT('a',3000),
		REPEAT('a',3000),
		REPEAT('a',3000),
		REPEAT('a',3000),
		REPEAT('a',3000),
		REPEAT('a',3000)
		);

		ERROR 1118 (42000): Row size too large (> 8126). Changing some columns to TEXT or BLOB or using ROW_FORMAT=DYNAMIC or ROW_FORMAT=COMPRESSED may help. 
			In current row format, BLOB prefix of 768 bytes is stored inline.
		
		
		行记录长度大于 8126，在当前compact行格式格式下，大字段溢出，会把数据的前768个字节+20个字节的指针保留在行记录内
		解决办法：可以把行记录格式改为 dynamic
	
		-- 问题和原因
			某天的下午5点多业务日志报数据插入失败，多个 blob 大字段发生了行溢出，导致行内保留的字节数大于8126，产生SQL语句插入失败的问题。
		
		
		
	2.2 分析
		
		行记录格式为compact
		
			对于 blob，text，varchar(8099) 这样的大字段（如果blob，text有导致行溢出），采用的是部分溢出的方式，InnoDB 只会存放前 768 字节+20个字节的指针在数据页中，而剩余的数据则会存储在溢出段中（发生溢出情况的时候适用）
				
			innoDB 存储引擎表是索引组织的，即 B+Tree 的结构，这样每个16KB的数据页中至少应该有两条行记录（否则失去了B+Tree的意义，变成链表了）。
			根据Innodb的ROW_FORMAT的存储格式确定行内保留的字节数 > 8126 字节，超过8KB，就会出现这个溢出的错误。
			
			
			-- 对于行溢出的字段，会把数据的前768个字节+20个字节的指针 存储到行记录中，剩余的数据则会存储在大对象页中
			
			
		行记录格式为dynamic
		
			对于 blob，text，varchar(8099) 这样的大字段（如果blob，text有导致行溢出），采用的是完全溢出的方式，InnoDB 只会存放 20个字节的指针在数据页的行记录中
			
			假设有行溢出，实际存储的数据长度超过768字节的字段都会用溢出页作为数据存储的方式
			
			本案例有10个字段有大于768字节，那么compact格式在行内需要存储 768+20 * 10 的字节数据，dynamic格式在行内只需要存储 20*10 的字节数据。
			
			因此，把行记录格式改为 dynamic 可以彻底解决这个问题。
			
			-- 行记录格式为dynamic, 对于行溢出的字段，只会存储20个字节的指针到行记录中，溢出的字段会存储到大对象页中
			
		
	2.3 解决办法
		
		1. 不需要修改业务逻辑
		
		2. 首先要结合业务情况，找业务低峰期，游戏业务在凌晨5点-早上8点是业务低峰期。
			
		3. 游戏日志有报错插入错误的SQL语句，把这个插入语句放在表的行记录格式为dynamic下执行，没有报错。
		
		4. 修改表的行记录格式需要重建表，不是很紧急的修改要在业务低峰期执行
			
			4.1 主从模式下的修改
				先在从库下修改该表的行记录格式为 dynamic
				
				再在主库下修改该表的行记录格式为 dynamic

				避免主从复制报错。
			
			4.2 当日晚上先修改从库的，从库只是有一些读取报表数据的查询。
					
			4.3 凌晨5点起来把所有的表的行记录格式都改为 dynamic，也是先修改从库的，再修改主库的。
			
			4.4 通过业务端的日志，手工补插入失败的数据。
			
		5. 耗时：
			
			从5点到6点半，耗时约1个半小时，把约50个GB的实例数据的所有表的行记录格式都改为了 dynamic 格式。
			
			
	
3. 小结
	1. 要能口述出来
		上班时间不利于于口述，在早上或者空闲的时候，可以开口表达出来。
		
	2. 有时候需要追根溯源，特别对于数据库相关的，原理性的东西弄明白就会好解释一些问题了。
	3. 做数据库相关调整，要考虑对业务的影响，要把影响降到最低甚至没有影响。
	4. 不包括溢出到大对象页单独存储的部分，实际存储到行记录中的长度，大于8KB，就会报插入数据错误。

	系统库呢
		
		
	
4. 源码部分

	/**********************************************************************
	Issue a warning that the row is too big. */
	void
	ib_warn_row_too_big(const dict_table_t*	table)
	{
		/* If prefix is true then a 768-byte prefix is stored
		locally for BLOB fields. Refer to dict_table_get_format() */
		const bool prefix = (dict_tf_get_format(table->flags)
					 == UNIV_FORMAT_A);

		const ulint	free_space = page_get_free_space_of_empty(
			table->flags & DICT_TF_COMPACT) / 2;

		THD*	thd = current_thd;

		push_warning_printf(
			thd, Sql_condition::SL_WARNING, HA_ERR_TOO_BIG_ROW,
			"Row size too large (> %lu). Changing some columns to TEXT"
			" or BLOB %smay help. In current row format, BLOB prefix of"
			" %d bytes is stored inline.", free_space
			, prefix ? "or using ROW_FORMAT=DYNAMIC or"
			" ROW_FORMAT=COMPRESSED ": ""
			, prefix ? DICT_MAX_FIXED_COL_LEN : 0);
	}

	-- 可以讲讲这部分的源码
	
5. dynamic多个字段溢出

	drop table  if exists table_20211103;
	CREATE TABLE `table_20211103` (
	  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
	  `a` blob COMMENT '...',
	  `b` blob COMMENT '...',
	  `c` blob COMMENT '...',
	  `d` blob COMMENT '...',
	  `a1` blob COMMENT '...',
	  `a2` blob COMMENT '...',
	  `a3` blob COMMENT '...',
	  `a4` blob COMMENT '...',
	  `a5` blob COMMENT '...',
	  `a6` blob COMMENT '...',
	  `a7` blob COMMENT '...',
	  `a8` blob COMMENT '...',
	  `a9` blob COMMENT '...',
	  `a10` blob COMMENT '...',
	  PRIMARY KEY (`ID`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=dynamic;

	INSERT INTO `table_20211103` 
	(`a`, `b`, `c`, `d`, `a1`, `a2`, `a3`, `a4`, `a5`, `a6`, `a7`, `a8`, `a9`, `a10`) 
	VALUES (
	REPEAT('a',3000),
	REPEAT('a',3000),
	REPEAT('a',3000),
	REPEAT('a',3000),
	REPEAT('a',3000),
	REPEAT('a',3000),
	REPEAT('a',3000),
	REPEAT('a',3000),
	REPEAT('a',3000),
	REPEAT('a',3000),
	REPEAT('a',3000),
	REPEAT('a',3000),
	REPEAT('a',3000),
	REPEAT('a',3000)
	);
	
	
	shell> python innodb_page_info/py_innodb_page_info.py -v /home/mysql/mysql3306/data/test_db/table_20211103.ibd 
	page offset 00000000, page type <Freshly Allocated Page>
	page offset 00000000, page type <Freshly Allocated Page>
	page offset 00000000, page type <Freshly Allocated Page>
	page offset 00000000, page type <Freshly Allocated Page>
	page offset 00000000, page type <Freshly Allocated Page>
	page offset 00000000, page type <Freshly Allocated Page>
	page offset 00000000, page type <Freshly Allocated Page>
	page offset 00000000, page type <Freshly Allocated Page>
	page offset 00000000, page type <Freshly Allocated Page>
	page offset 00000000, page type <Freshly Allocated Page>
	page offset 00000000, page type <Freshly Allocated Page>
	page offset 00000000, page type <Freshly Allocated Page>
	page offset 00000000, page type <Freshly Allocated Page>
	page offset 00000000, page type <Freshly Allocated Page>
	page offset 00000000, page type <Freshly Allocated Page>
	page offset 00000000, page type <Freshly Allocated Page>
	Total number of page: 16:
	Freshly Allocated Page: 16
