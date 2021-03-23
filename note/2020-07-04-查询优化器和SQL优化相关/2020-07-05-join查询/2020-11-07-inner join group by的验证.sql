
1. 初始化表结构和数据
2. inner join相关的实验
3. 小结

1. 初始化表结构和数据
	
	CREATE TABLE  t_user(
		aID int(1) AUTO_INCREMENT PRIMARY KEY,
		nClubID int(11) not null default 0 comment '俱乐部ID',	
		nPlayerID int(11) not null default 0 comment '玩家ID',	
		score int(11) NOT NULL COMMENT '分数',
		KEY `idx_nClubID` (`nClubID`),
		KEY `idx_nPlayerID` (`nPlayerID`)
	);
	
	CREATE TABLE  t_detail(
		aID int(1) AUTO_INCREMENT PRIMARY KEY,
		nClubID int(11) not null default 0 comment '俱乐部ID',	
		nPlayerID int(11) not null default 0 comment '玩家ID',	
		nTotalResult int(11) not null default 0 comment '总成绩',
		KEY `idx_nClubID` (`nClubID`),
		KEY `idx_nPlayerID` (`nPlayerID`)
	);
	

	
	INSERT INTO `t_user` (`nClubID`, `nPlayerID`, `score`) VALUES (10, 5, 5);
	INSERT INTO `t_user` (`nClubID`, `nPlayerID`, `score`) VALUES (10, 10, 10);
	INSERT INTO `t_user` (`nClubID`, `nPlayerID`, `score`) VALUES (20, 20, 20);

	INSERT INTO `t_detail` (`nClubID`, `nPlayerID`, `nTotalResult`) VALUES (10, 5, 5);
	INSERT INTO `t_detail` (`nClubID`, `nPlayerID`, `nTotalResult`) VALUES (10, 10, 10);
	INSERT INTO `t_detail` (`nClubID`, `nPlayerID`, `nTotalResult`) VALUES (10, 10, 15);
	INSERT INTO `t_detail` (`nClubID`, `nPlayerID`, `nTotalResult`) VALUES (20, 20, 20);
	
	
	select * from t_user;
	select * from t_detail;
	
	root@localhost [test2_Db]>select * from t_user;
	+-----+---------+-----------+-------+
	| aID | nClubID | nPlayerID | score |
	+-----+---------+-----------+-------+
	|   1 |      10 |         5 |     5 |
	|   2 |      10 |        10 |    10 |
	|   3 |      20 |        20 |    20 |
	+-----+---------+-----------+-------+
	3 rows in set (0.00 sec)

	root@localhost [test2_Db]>select * from t_detail;
	+-----+---------+-----------+--------------+
	| aID | nClubID | nPlayerID | nTotalResult |
	+-----+---------+-----------+--------------+
	|   1 |      10 |         5 |            5 |
	|   2 |      10 |        10 |           10 |
	|   3 |      10 |        10 |           15 |
	|   4 |      20 |        20 |           20 |
	+-----+---------+-----------+--------------+
	4 rows in set (0.00 sec)


2. inner join相关的实验
	
		
		mysql> desc select * from t_detail td inner join t_user tu on td.nPlayerID=tu.nPlayerID where td.nClubID=10;
		+----+-------------+-------+------------+------+---------------------------+------+---------+------+------+----------+----------------------------------------------------+
		| id | select_type | table | partitions | type | possible_keys             | key  | key_len | ref  | rows | filtered | Extra                                              |
		+----+-------------+-------+------------+------+---------------------------+------+---------+------+------+----------+----------------------------------------------------+
		|  1 | SIMPLE      | tu    | NULL       | ALL  | idx_nPlayerID             | NULL | NULL    | NULL |    3 |   100.00 | NULL                                               |
		|  1 | SIMPLE      | td    | NULL       | ALL  | idx_nClubID,idx_nPlayerID | NULL | NULL    | NULL |    4 |    25.00 | Using where; Using join buffer (Block Nested Loop) |
		+----+-------------+-------+------------+------+---------------------------+------+---------+------+------+----------+----------------------------------------------------+
		2 rows in set, 1 warning (0.00 sec)
		
		mysql> select * from t_detail td inner join t_user tu on td.nPlayerID=tu.nPlayerID where td.nClubID=10;
		+-----+---------+-----------+--------------+-----+---------+-----------+-------+
		| aID | nClubID | nPlayerID | nTotalResult | aID | nClubID | nPlayerID | score |
		+-----+---------+-----------+--------------+-----+---------+-----------+-------+
		|   1 |      10 |         5 |            5 |   1 |      10 |         5 |     5 |
		|   2 |      10 |        10 |           10 |   2 |      10 |        10 |    10 |
		|   3 |      10 |        10 |           15 |   2 |      10 |        10 |    10 |
		+-----+---------+-----------+--------------+-----+---------+-----------+-------+
		3 rows in set (0.00 sec)

		
		mysql> select sum(td.nTotalResult) from t_detail td inner join t_user tu on td.nPlayerID=tu.nPlayerID where td.nClubID=10;
		+----------------------+
		| sum(td.nTotalResult) |
		+----------------------+
		|                   30 |
		+----------------------+
		1 row in set (0.01 sec)

		group by
		
			group by td.nClubID
				mysql> select * from t_detail td inner join t_user tu on td.nPlayerID=tu.nPlayerID where td.nClubID=10 group by td.nClubID;
				+-----+---------+-----------+--------------+-----+---------+-----------+-------+
				| aID | nClubID | nPlayerID | nTotalResult | aID | nClubID | nPlayerID | score |
				+-----+---------+-----------+--------------+-----+---------+-----------+-------+
				|   1 |      10 |         5 |            5 |   1 |      10 |         5 |     5 |
				+-----+---------+-----------+--------------+-----+---------+-----------+-------+
				1 row in set (0.00 sec)
							
				
				mysql> select sum(td.nTotalResult) from t_detail td inner join t_user tu on td.nPlayerID=tu.nPlayerID where td.nClubID=10 group by td.nClubID;
				+----------------------+
				| sum(td.nTotalResult) |
				+----------------------+
				|                   30 |
				+----------------------+
				1 row in set (0.00 sec)
				
			group by td.nPlayerID
				mysql> select td.nPlayerID, sum(td.nTotalResult) from t_detail td inner join t_user tu on td.nPlayerID=tu.nPlayerID where td.nClubID=10 group by td.nPlayerID;
				+-----------+----------------------+
				| nPlayerID | sum(td.nTotalResult) |
				+-----------+----------------------+
				|         5 |                    5 |
				|        10 |                   25 |
				+-----------+----------------------+
				2 rows in set (0.00 sec)
							
				
			
			
		-- inner join + sum()函数之类的 要加 group by, 
		
		------------------------------------------------------------------------------------------------------------------------------------------------

		-- 当join两边都没有符合条件的记录时
			mysql>desc  select * from t_detail td inner join t_user tu on td.nPlayerID=tu.nPlayerID where td.nClubID=10 and td.nPlayerID=10 and nTotalResult>100;
			+----+-------------+-------+------------+------+---------------------------+---------------+---------+-------+------+----------+-------------+
			| id | select_type | table | partitions | type | possible_keys             | key           | key_len | ref   | rows | filtered | Extra       |
			+----+-------------+-------+------------+------+---------------------------+---------------+---------+-------+------+----------+-------------+
			|  1 | SIMPLE      | td    | NULL       | ref  | idx_nClubID,idx_nPlayerID | idx_nPlayerID | 4       | const |    2 |    25.00 | Using where |
			|  1 | SIMPLE      | tu    | NULL       | ref  | idx_nPlayerID             | idx_nPlayerID | 4       | const |    1 |   100.00 | NULL        |
			+----+-------------+-------+------------+------+---------------------------+---------------+---------+-------+------+----------+-------------+
			2 rows in set, 1 warning (0.04 sec)
			
			
			mysql> select * from t_detail td inner join t_user tu on td.nPlayerID=tu.nPlayerID where td.nClubID=10 and td.nPlayerID=10 and nTotalResult>100;
			Empty set (0.00 sec)
			
			mysql>select sum(td.nTotalResult) from t_detail td inner join t_user tu on td.nPlayerID=tu.nPlayerID where td.nClubID=10 and td.nPlayerID=10 and nTotalResult>100;
			+----------------------+
			| sum(td.nTotalResult) |
			+----------------------+
			|                 NULL |
			+----------------------+
			1 row in set (0.00 sec)
			-- 没有group by的结果集不正确。
			
			mysql> select sum(td.nTotalResult) from t_detail td inner join t_user tu on td.nPlayerID=tu.nPlayerID where td.nClubID=10 and td.nPlayerID=10 and nTotalResult>100 group by td.nPlayerID;
			Empty set (0.00 sec)
			-- 有group by的结果集正确。
			
			
3. 小结
	1. 当join两边都没有符合条件的记录时， 有group by的结果集正确。
	2. inner join，要加 group by。
	
	
			