
大纲 
	0. 额外信息
	1. 慢查询
	2. 表的DDL
	3. 查看索引基数
	4. 查看执行计划和分析慢的原因
	5. 优化
	6. 小结
	
		
0. 额外信息

	mysql> select version();
	+------------+
	| version()  |
	+------------+
	| 5.6.37-log |
	+------------+
	1 row in set (0.03 sec)



	mysql> show global variables like '%read_rnd_buffer%';
	+----------------------+----------+
	| Variable_name        | Value    |
	+----------------------+----------+
	| read_rnd_buffer_size | 16777216 |
	+----------------------+----------+
	1 row in set (0.00 sec)
	-- 16MB



	mysql> show global variables like '%tmp_table_size%';
	+----------------+----------+
	| Variable_name  | Value    |
	+----------------+----------+
	| tmp_table_size | 67108864 |
	+----------------+----------+
	1 row in set (0.00 sec)
	-- 64MB


	mysql> show global variables like  '%join_buffer%';
	+------------------+----------+
	| Variable_name    | Value    |
	+------------------+----------+
	| join_buffer_size | 20971520 |
	+------------------+----------+
	1 row in set (0.00 sec)
	-- 20MB



1. 慢查询

	查总的：
		SELECT
			count(1) totalCount
		FROM
			(
				SELECT
					date_format(ActionDate, '%Y-%m-%d') ActionDate,
					sum(Count) Count,
					szNickName,
					AccountId
				FROM
					Table_DiamondActionLog
				WHERE
					ActionDate IS NOT NULL
				AND AccountId IN (
					SELECT
						nPlayerId
					FROM
						Table_User
					WHERE
						extendCode = '589794'
				)
				GROUP BY
					date_format(ActionDate, '%Y-%m-%d'),
					szNickName,
					AccountId
				ORDER BY
					ActionDate DESC
			) t;
		
		每次执行平均耗时3秒		
		+------------+
		| totalCount |
		+------------+
		|      17358 |
		+------------+
		1 row in set (2.63 sec)


		+----+-------------+------------------------+------+----------------------------+----------------------------+---------+---------------------------+------+----------------------------------------------+
		| id | select_type | table                  | type | possible_keys              | key                        | key_len | ref                       | rows | Extra                                        |
		+----+-------------+------------------------+------+----------------------------+----------------------------+---------+---------------------------+------+----------------------------------------------+
		|  1 | PRIMARY     | <derived2>             | ALL  | NULL                       | NULL                       | NULL    | NULL                      | 9796 | NULL                                         |
		|  2 | DERIVED     | Table_User             | ref  | PRIMARY,idx_Table_User     | idx_Table_User             | 5       | const                     |  316 | Using index; Using temporary; Using filesort |
		|  2 | DERIVED     | Table_DiamondActionLog | ref  | idx_Table_DiamondActionLog | idx_Table_DiamondActionLog | 4       | yldb.Table_User.nPlayerId |   31 | Using index condition                        |
		+----+-------------+------------------------+------+----------------------------+----------------------------+---------+---------------------------+------+----------------------------------------------+
		3 rows in set (0.00 sec)


	查详情：
		SELECT
			date_format(ActionDate, '%Y-%m-%d') ActionDate,
			sum(Count) Count,
			szNickName,
			AccountId
		FROM
			Table_DiamondActionLog
		WHERE
			ActionDate IS NOT NULL
		AND AccountId IN (
			SELECT
				nPlayerId
			FROM
				Table_User
			WHERE
				extendCode = '589794'
		)
		GROUP BY
			date_format(ActionDate, '%Y-%m-%d'),
			szNickName,
			AccountId
		ORDER BY
			ActionDate DESC
		LIMIT 0,10 
		
		每次执行平均耗时7秒
	
	导致 CPU 利用率高
		告警信息:Cpu user percent on  gt 80% 
		问题详情:cpu  process  percentage:90.4 % 



2. 表的DDL

	CREATE TABLE `table_diamondactionlog` (
	  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
	  `AccountId` int(11) NOT NULL COMMENT '账号ID',
	  `szNickName` varchar(64) DEFAULT NULL COMMENT '昵称',
	  `Count` int(11) NOT NULL COMMENT '变化数量',
	  `szRemark` varchar(300) DEFAULT NULL COMMENT '备注',
	  `ActionDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
	  PRIMARY KEY (`ID`),
	  KEY `idx_Table_DiamondActionLog` (`AccountId`,`ActionDate`)
	) ENGINE=InnoDB AUTO_INCREMENT=27289862 DEFAULT CHARSET=utf8mb4;


	CREATE TABLE `table_user` (
	  `nPlayerId` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '玩家用户Id',
	  `nCardCount` int(11) NOT NULL DEFAULT '0' COMMENT '钻石数量',
	  `nJinBi` bigint(20) NOT NULL DEFAULT '0',
	  `szCreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  `nActive` int(11) NOT NULL DEFAULT '1' COMMENT '是否有效；0注销，1正常',
	  `nSex` int(11) NOT NULL DEFAULT '2',
	  `szPass` varchar(64) NOT NULL,
	  `szOpenId` varchar(128) DEFAULT NULL,
	  `szNickName` varchar(64) DEFAULT NULL,
	  `szHeadPicUrl` varchar(512) DEFAULT NULL,
	  `szSign` varchar(256) DEFAULT NULL,
	  `extendCode` int(11) DEFAULT '0' COMMENT '推广码',
	  `preLoginTime` timestamp NULL DEFAULT NULL,
	  `preLoginIp` varchar(64) DEFAULT NULL,
	  `onlineSta` int(11) DEFAULT NULL,
	  `reser1` int(11) DEFAULT NULL,
	  `reser2` int(11) DEFAULT NULL,
	  `reset3` int(11) DEFAULT NULL,
	  `reset4` int(11) DEFAULT NULL,
	  `reset5` int(11) DEFAULT NULL,
	  `strre1` varchar(128) DEFAULT NULL,
	  `strre2` varchar(128) DEFAULT NULL,
	  `BindingTime` timestamp NULL DEFAULT NULL,
	  `score` int(11) DEFAULT NULL COMMENT '玩家积分',
	  `phone` varchar(15) DEFAULT NULL COMMENT '手机号码',
	  `phobindtime` datetime DEFAULT NULL COMMENT '手机号绑定时间',
	  `phounbindtime` datetime DEFAULT NULL COMMENT '手机号解绑时间',
	  `nScoreDay` int(11) DEFAULT '0' COMMENT '每日积分',
	  `nScoreTotal` int(11) DEFAULT '0' COMMENT '累计积分',
	  `nBonus1` int(11) DEFAULT '0' COMMENT '累计奖励领取标记 0-不可领 1-可领 2-已领',
	  `nBonus2` int(11) DEFAULT '0' COMMENT '累计奖励领取标记 0-不可领 1-可领 2-已领',
	  `nBonus3` int(11) DEFAULT '0' COMMENT '累计奖励领取标记 0-不可领 1-可领 2-已领',
	  PRIMARY KEY (`nPlayerId`),
	  KEY `idx_Table_User` (`extendCode`),
	  KEY `idx_onlineSta` (`onlineSta`),
	  KEY `idx_szOpenId` (`szOpenId`(15)),
	  KEY `idx_szCreateTime` (`szCreateTime`)
	) ENGINE=InnoDB AUTO_INCREMENT=183369 DEFAULT CHARSET=utf8mb4;





---------------------------------------------------------------------------------------------------


3. 查看索引基数

	mysql> show index from Table_DiamondActionLog;
	+------------------------+------------+----------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| Table                  | Non_unique | Key_name                   | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
	+------------------------+------------+----------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| table_diamondactionlog |          0 | PRIMARY                    |            1 | ID          | A         |     5125682 |     NULL | NULL   |      | BTREE      |         |               |
	| table_diamondactionlog |          1 | idx_Table_DiamondActionLog |            1 | AccountId   | A         |      165344 |     NULL | NULL   |      | BTREE      |         |               |
	| table_diamondactionlog |          1 | idx_Table_DiamondActionLog |            2 | ActionDate  | A         |     5125682 |     NULL | NULL   | YES  | BTREE      |         |               |
	+------------------------+------------+----------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	3 rows in set (0.00 sec)

	root@mysqldb 14:35:  [(none)]> select 5125682/165344;
	+----------------+
	| 5125682/165344 |
	+----------------+
	|        31.0001 |
	+----------------+
	1 row in set (0.00 sec)


	---------------------------------------------------------------------------------------------------


	select * from mysql.innodb_index_stats  where database_name='yldb' and table_name = 'Table_DiamondActionLog';

	mysql> select * from mysql.innodb_index_stats  where database_name='yldb' and table_name = 'table_diamondactionlog';
	+---------------+------------------------+----------------------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name             | index_name                 | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+------------------------+----------------------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| yldb          | table_diamondactionlog | PRIMARY                    | 2018-06-07 17:52:32 | n_diff_pfx01 |    5123587 |          20 | ID                                |
	| yldb          | table_diamondactionlog | PRIMARY                    | 2018-06-07 17:52:32 | n_leaf_pages |      30371 |        NULL | Number of leaf pages in the index |
	| yldb          | table_diamondactionlog | PRIMARY                    | 2018-06-07 17:52:32 | size         |      30528 |        NULL | Number of pages in the index      |
	| yldb          | table_diamondactionlog | idx_Table_DiamondActionLog | 2018-06-07 17:52:32 | n_diff_pfx01 |      82344 |          20 | AccountId                         |
	| yldb          | table_diamondactionlog | idx_Table_DiamondActionLog | 2018-06-07 17:52:32 | n_diff_pfx02 |    5306181 |          20 | AccountId,ActionDate              |
	| yldb          | table_diamondactionlog | idx_Table_DiamondActionLog | 2018-06-07 17:52:32 | n_diff_pfx03 |    5322422 |          20 | AccountId,ActionDate,ID           |
	| yldb          | table_diamondactionlog | idx_Table_DiamondActionLog | 2018-06-07 17:52:32 | n_leaf_pages |       7382 |        NULL | Number of leaf pages in the index |
	| yldb          | table_diamondactionlog | idx_Table_DiamondActionLog | 2018-06-07 17:52:32 | size         |       7406 |        NULL | Number of pages in the index      |
	+---------------+------------------------+----------------------------+---------------------+--------------+------------+-------------+-----------------------------------+
	8 rows in set (0.00 sec)


	analyze table yldb.table_diamondactionlog;

	mysql> analyze table yldb.table_diamondactionlog;
	+-----------------------------+---------+----------+----------+
	| Table                       | Op      | Msg_type | Msg_text |
	+-----------------------------+---------+----------+----------+
	| yldb.table_diamondactionlog | analyze | status   | OK       |
	+-----------------------------+---------+----------+----------+
	1 row in set (0.08 sec)

	mysql> select * from mysql.innodb_index_stats  where database_name='yldb' and table_name = 'table_diamondactionlog';
	+---------------+------------------------+----------------------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name             | index_name                 | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+------------------------+----------------------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| yldb          | table_diamondactionlog | PRIMARY                    | 2021-10-11 14:41:29 | n_diff_pfx01 |   27748165 |          20 | ID                                |
	| yldb          | table_diamondactionlog | PRIMARY                    | 2021-10-11 14:41:29 | n_leaf_pages |     155061 |        NULL | Number of leaf pages in the index |
	| yldb          | table_diamondactionlog | PRIMARY                    | 2021-10-11 14:41:29 | size         |     155776 |        NULL | Number of pages in the index      |
	| yldb          | table_diamondactionlog | idx_Table_DiamondActionLog | 2021-10-11 14:41:29 | n_diff_pfx01 |     218822 |          20 | AccountId                         |
	| yldb          | table_diamondactionlog | idx_Table_DiamondActionLog | 2021-10-11 14:41:29 | n_diff_pfx02 |   27090759 |          20 | AccountId,ActionDate              |
	| yldb          | table_diamondactionlog | idx_Table_DiamondActionLog | 2021-10-11 14:41:29 | n_diff_pfx03 |   26098423 |          20 | AccountId,ActionDate,ID           |
	| yldb          | table_diamondactionlog | idx_Table_DiamondActionLog | 2021-10-11 14:41:29 | n_leaf_pages |      50889 |        NULL | Number of leaf pages in the index |
	| yldb          | table_diamondactionlog | idx_Table_DiamondActionLog | 2021-10-11 14:41:29 | size         |      58367 |        NULL | Number of pages in the index      |
	+---------------+------------------------+----------------------------+---------------------+--------------+------------+-------------+-----------------------------------+
	8 rows in set (0.00 sec)



	mysql> show index from Table_DiamondActionLog;
	+------------------------+------------+----------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| Table                  | Non_unique | Key_name                   | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
	+------------------------+------------+----------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| table_diamondactionlog |          0 | PRIMARY                    |            1 | ID          | A         |    27748182 |     NULL | NULL   |      | BTREE      |         |               |
	| table_diamondactionlog |          1 | idx_Table_DiamondActionLog |            1 | AccountId   | A         |      440447 |     NULL | NULL   |      | BTREE      |         |               |
	| table_diamondactionlog |          1 | idx_Table_DiamondActionLog |            2 | ActionDate  | A         |    27748182 |     NULL | NULL   | YES  | BTREE      |         |               |
	+------------------------+------------+----------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	3 rows in set (0.00 sec)



	mysql> select 27748182/440447;
	+-----------------+
	| 27748182/440447 |
	+-----------------+
	|         63.0000 |
	+-----------------+
	1 row in set (0.00 sec)


---------------------------------------------------------------------------------------------------


4. 查看执行计划和分析慢的原因

	SELECT
		nPlayerId
	FROM
		Table_User
	WHERE
		extendCode = '589794'
	316 rows in set (0.01 sec)
	

	desc SELECT
		count(1) totalCount
	FROM
		(
		SELECT
			AccountId
		FROM
			Table_DiamondActionLog
		WHERE
			ActionDate IS NOT NULL
		AND AccountId IN (
			SELECT
				nPlayerId
			FROM
				Table_User
			WHERE
				extendCode = '589794'
		)
		GROUP BY
			date_format(ActionDate, '%Y-%m-%d'),
			szNickName,
			AccountId
	) t;


	+----+-------------+------------------------+------+----------------------------+----------------------------+---------+---------------------------+-------+----------------------------------------------+
	| id | select_type | table                  | type | possible_keys              | key                        | key_len | ref                       | rows  | Extra                                        |
	+----+-------------+------------------------+------+----------------------------+----------------------------+---------+---------------------------+-------+----------------------------------------------+
	|  1 | PRIMARY     | <derived2>             | ALL  | NULL                       | NULL                       | NULL    | NULL                      | 19908 | NULL                                         |
	|  2 | DERIVED     | Table_User             | ref  | PRIMARY,idx_Table_User     | idx_Table_User             | 5       | const                     |   316 | Using index; Using temporary; Using filesort |
	|  2 | DERIVED     | Table_DiamondActionLog | ref  | idx_Table_DiamondActionLog | idx_Table_DiamondActionLog | 4       | yldb.Table_User.nPlayerId |    63 | Using index condition                        |
	+----+-------------+------------------------+------+----------------------------+----------------------------+---------+---------------------------+-------+----------------------------------------------+
	3 rows in set (0.00 sec)


	-- 改为 left join
		SELECT
			t_d.AccountId
		FROM
			Table_User t_u
		left join  Table_DiamondActionLog t_d 
		on t_u.nPlayerId=t_d.AccountId
		WHERE
			t_u.extendCode = '589794'
		and t_d.ActionDate IS NOT NULL
		GROUP BY
			date_format(t_d.ActionDate, '%Y-%m-%d'),
			t_d.szNickName,
			t_d.AccountId;
			
		17361 rows in set (2.45 sec)
		
		-- 同样执行慢。	



	-- left join + 去除 ordre by null 
		desc SELECT
			t_d.AccountId
		FROM
			Table_User t_u
		left join  Table_DiamondActionLog t_d 
		on t_u.nPlayerId=t_d.AccountId
		WHERE
			t_u.extendCode = '589794'

		and t_d.ActionDate IS NOT NULL

		GROUP BY
			date_format(t_d.ActionDate, '%Y-%m-%d'),
			t_d.szNickName,
			t_d.AccountId
		order by null;

		+----+-------------+-------+------+----------------------------+----------------------------+---------+--------------------+------+------------------------------+
		| id | select_type | table | type | possible_keys              | key                        | key_len | ref                | rows | Extra                        |
		+----+-------------+-------+------+----------------------------+----------------------------+---------+--------------------+------+------------------------------+
		|  1 | SIMPLE      | t_u   | ref  | PRIMARY,idx_Table_User     | idx_Table_User             | 5       | const              |  316 | Using index; Using temporary |
		|  1 | SIMPLE      | t_d   | ref  | idx_Table_DiamondActionLog | idx_Table_DiamondActionLog | 4       | yldb.t_u.nPlayerId |   63 | Using index condition        |
		+----+-------------+-------+------+----------------------------+----------------------------+---------+--------------------+------+------------------------------+
		2 rows in set (0.00 sec)

		-- 同样执行慢。
	

		
	-- left join + BKA 
		set optimizer_switch='mrr=on,mrr_cost_based=off,batched_key_access=on';	

		+----+-------------+-------+------+----------------------------+----------------------------+---------+--------------------+------+---------------------------------------------------------------+
		| id | select_type | table | type | possible_keys              | key                        | key_len | ref                | rows | Extra                                                         |
		+----+-------------+-------+------+----------------------------+----------------------------+---------+--------------------+------+---------------------------------------------------------------+
		|  1 | SIMPLE      | t_u   | ref  | PRIMARY,idx_Table_User     | idx_Table_User             | 5       | const              |  316 | Using index; Using temporary; Using filesort                  |
		|  1 | SIMPLE      | t_d   | ref  | idx_Table_DiamondActionLog | idx_Table_DiamondActionLog | 4       | yldb.t_u.nPlayerId |   63 | Using index condition; Using join buffer (Batched Key Access) |
		+----+-------------+-------+------+----------------------------+----------------------------+---------+--------------------+------+---------------------------------------------------------------+
		2 rows in set (0.00 sec)
		-- 开启BKA后，查询性能没有提升。

		set optimizer_switch='mrr=on,mrr_cost_based=off,batched_key_access=on';	
		select count(*) from (
		SELECT
			t_d.AccountId
		FROM
			Table_User t_u
		left join  Table_DiamondActionLog t_d 
		on t_u.nPlayerId=t_d.AccountId
		WHERE
			t_u.extendCode = '589794'
		and t_d.ActionDate IS NOT NULL
		GROUP BY
			date_format(t_d.ActionDate, '%Y-%m-%d'),
			t_d.szNickName,
			t_d.AccountId
		)temp;
		1 row in set (3.14 sec)

		-- 同样执行慢。

	

	-- 去除group by 

		SELECT
			count(1) totalCount
		FROM
			(
				SELECT
					1
				FROM
					Table_DiamondActionLog
				WHERE
					ActionDate IS NOT NULL
				AND AccountId IN (
					SELECT
						nPlayerId
					FROM
						Table_User
					WHERE
						extendCode = '589794'
				)
			) t;
		+------------+
		| totalCount |
		+------------+
		|     427821 |
		+------------+
		1 row in set (0.35 sec)

		-- 需要对 427821 行记录做 group by，不慢才怪
		-- 终于找到了语句执行慢的原因。


5. 优化
		
		
	SELECT
		count(1) totalCount
	FROM
		(
		SELECT
			1
		FROM
			Table_DiamondActionLog
		WHERE
			ActionDate IS NOT NULL
		AND AccountId IN (
			SELECT
				nPlayerId
			FROM
				Table_User
			WHERE
				extendCode = '589794'
		)
		GROUP BY
			AccountId,
			date_format(ActionDate, '%Y-%m-%d')
	) t;
		
	+------------+
	| totalCount |
	+------------+
	|      17397 |
	+------------+
	1 row in set (1.29 sec)


	+----+-------------+------------------------+------+----------------------------+----------------------------+---------+---------------------------+-------+----------------------------------------------+
	| id | select_type | table                  | type | possible_keys              | key                        | key_len | ref                       | rows  | Extra                                        |
	+----+-------------+------------------------+------+----------------------------+----------------------------+---------+---------------------------+-------+----------------------------------------------+
	|  1 | PRIMARY     | <derived2>             | ALL  | NULL                       | NULL                       | NULL    | NULL                      | 19971 | NULL                                         |
	|  2 | DERIVED     | Table_User             | ref  | PRIMARY,idx_Table_User     | idx_Table_User             | 5       | const                     |   317 | Using index; Using temporary; Using filesort |
	|  2 | DERIVED     | Table_DiamondActionLog | ref  | idx_Table_DiamondActionLog | idx_Table_DiamondActionLog | 4       | yldb.Table_User.nPlayerId |    63 | Using where; Using index                     |
	+----+-------------+------------------------+------+----------------------------+----------------------------+---------+---------------------------+-------+----------------------------------------------+
	3 rows in set (0.01 sec)
	
	-- 覆盖索引带来了性能上的提升。

	-- 慢在 group by 这里

	
	对比优化前

		SELECT
			count(1) totalCount
		FROM
		(
			SELECT
				date_format(ActionDate, '%Y-%m-%d') ActionDate,
				sum(Count) Count,
				szNickName,
				AccountId
			FROM
				Table_DiamondActionLog
			WHERE
				ActionDate IS NOT NULL
			AND AccountId IN (
				SELECT
					nPlayerId
				FROM
					Table_User
				WHERE
					extendCode = '589794'
			)
			GROUP BY
				date_format(ActionDate, '%Y-%m-%d'),
				szNickName,
				AccountId
			ORDER BY
				ActionDate DESC
		) t;
		+------------+
		| totalCount |
		+------------+
		|      17538 |
		+------------+
		1 row in set (3.07 sec)			
					
	-- 同时，发现了SQL语句语义存在的问题，也就是根据 (AccountId,szNickName,date_format(ActionDate, '%Y-%m-%d')) 做分组， AccountId 和 szNickName 代表的是同1个人，用 (AccountId,date_format(ActionDate, '%Y-%m-%d')) 做分组就行。
	
	
6. 小结
	1. 找到SQL语句慢在那里，慢的原因，就好对症下药了。
	2. 对 40W 行记录做 group by + 回表，确实会慢。这里利用覆盖索引带来了1倍的查询性能提升。
		优化前    优化后
		2.63秒    1.29秒
	
	
	
