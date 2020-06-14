

1. union 和 union all
	1.1 union
	1.2 union all
2. between and 
3. group by
4. avg/max/min


1. union 和 union all


	192.168.0.201
	
		root@mysqldb 20:15:  [db2]> select * from db1.test1;
		+-----+------+---------------------+
		| ID  | name | CreateTime          |
		+-----+------+---------------------+
		| 317 | lujb | 2020-03-01 00:00:00 |
		+-----+------+---------------------+
		1 row in set (0.00 sec)

		root@mysqldb 20:16:  [db2]> select * from db2.test1;
		+-----+------+---------------------+
		| ID  | name | CreateTime          |
		+-----+------+---------------------+
		| 318 | lujb | 2020-03-11 00:00:00 |
		+-----+------+---------------------+
		1 row in set (0.00 sec)

		root@mysqldb 18:51:  [db2]> select * from db2.test2;
		+-----+-----------+---------+
		| id  | nPlayerID | szToken |
		+-----+-----------+---------+
		| 814 |         2 | 123     |
		| 816 |         4 | 123     |
		| 818 |         6 | 123     |
		| 820 |         8 | 123     |
		| 822 |        10 | 123     |
		| 824 |        12 | 123     |
		+-----+-----------+---------+
		6 rows in set (0.00 sec)


	192.168.0.202		
		root@mysqldb 08:59:  [db2]> select * from db2.test2;
		+-----+-----------+---------+
		| id  | nPlayerID | szToken |
		+-----+-----------+---------+
		| 813 |         1 | 123     |
		| 815 |         3 | 123     |
		| 817 |         5 | 123     |
		| 819 |         7 | 123     |
		| 821 |         9 | 123     |
		| 823 |        11 | 123     |
		+-----+-----------+---------+
		6 rows in set (0.00 sec)
		
		
	1.1 union
		mycat_user@mysqldb 20:38:  [mycat_db]> select * from test1;
		+-----+------+---------------------+
		| ID  | name | CreateTime          |
		+-----+------+---------------------+
		| 317 | lujb | 2020-03-01 00:00:00 |
		| 318 | lujb | 2020-03-11 00:00:00 |
		| 319 | lujb | 2020-03-22 00:00:00 |
		+-----+------+---------------------+
		3 rows in set (0.02 sec)

		mycat_user@mysqldb 20:38:  [mycat_db]> select * from test2;
		+-----+-----------+---------+
		| id  | nPlayerID | szToken |
		+-----+-----------+---------+
		| 814 |         2 | 123     |
		| 816 |         4 | 123     |
		| 818 |         6 | 123     |
		| 820 |         8 | 123     |
		| 822 |        10 | 123     |
		| 824 |        12 | 123     |
		| 813 |         1 | 123     |
		| 815 |         3 | 123     |
		| 817 |         5 | 123     |
		| 819 |         7 | 123     |
		| 821 |         9 | 123     |
		| 823 |        11 | 123     |
		+-----+-----------+---------+
		12 rows in set (0.01 sec)


		mycat_user@mysqldb 20:39:  [mycat_db]> explain select id from test1 union  select id from test2;
		+-----------+--------------------------------------------------+
		| DATA_NODE | SQL                                              |
		+-----------+--------------------------------------------------+
		| dn2       | select id from test1 union  select id from test2 |
		+-----------+--------------------------------------------------+
		1 row in set (0.02 sec)
		
		select id from test1  limit 2
		union 
		select id from test2 limit 2;

		mycat_user@mysqldb 20:37:  [mycat_db]> select id from test1
			-> union 
			-> select id from test2;
		+-----+
		| id  |
		+-----+
		| 318 |
		| 814 |
		| 816 |
		| 818 |
		| 820 |
		| 822 |
		| 824 |
		+-----+
		7 rows in set (0.03 sec)


	1.2 union all
	
		select id from test1  limit 2
		union all
		select id from test2 limit 2;
			
		mycat_user@mysqldb 20:40:  [mycat_db]> select id from test1 union all select id from test2;
		+-----+
		| id  |
		+-----+
		| 318 |
		| 814 |
		| 816 |
		| 818 |
		| 820 |
		| 822 |
		| 824 |
		+-----+
		7 rows in set (0.01 sec)

		mycat_user@mysqldb 20:40:  [mycat_db]> explain select id from test1 union all select id from test2;
		+-----------+-----------------------------------------------------+
		| DATA_NODE | SQL                                                 |
		+-----------+-----------------------------------------------------+
		| dn2       | select id from test1 union all select id from test2 |
		+-----------+-----------------------------------------------------+
		1 row in set (0.00 sec)

	
		
2. between and 

	分片类型: 取模分片
	mycat_user@mysqldb 19:20:  [mycat_db]> select * from test2;
		+-----+-----------+---------+
		| id  | nPlayerID | szToken |
		+-----+-----------+---------+
		| 814 |         2 | 123     |
		| 816 |         4 | 123     |
		| 818 |         6 | 123     |
		| 820 |         8 | 123     |
		| 822 |        10 | 123     |
		| 824 |        12 | 123     |
		| 813 |         1 | 123     |
		| 815 |         3 | 123     |
		| 817 |         5 | 123     |
		| 819 |         7 | 123     |
		| 821 |         9 | 123     |
		| 823 |        11 | 123     |
		+-----+-----------+---------+
		12 rows in set (0.04 sec)	
	
	mycat_user@mysqldb 05:07:  [mycat_db]> select count(*) from test2;
		+--------+
		| COUNT0 |
		+--------+
		|     12 |
		+--------+
		1 row in set (0.01 sec)

		
	192.168.0.201
		root@mysqldb 18:51:  [db2]> select * from db2.test2;
		+-----+-----------+---------+
		| id  | nPlayerID | szToken |
		+-----+-----------+---------+
		| 814 |         2 | 123     |
		| 816 |         4 | 123     |
		| 818 |         6 | 123     |
		| 820 |         8 | 123     |
		| 822 |        10 | 123     |
		| 824 |        12 | 123     |
		+-----+-----------+---------+
		6 rows in set (0.00 sec)


	192.168.0.202		
		root@mysqldb 08:59:  [db2]> select * from db2.test2;
		+-----+-----------+---------+
		| id  | nPlayerID | szToken |
		+-----+-----------+---------+
		| 813 |         1 | 123     |
		| 815 |         3 | 123     |
		| 817 |         5 | 123     |
		| 819 |         7 | 123     |
		| 821 |         9 | 123     |
		| 823 |        11 | 123     |
		+-----+-----------+---------+
		6 rows in set (0.00 sec)

			
			
			
			
	mycat_user@mysqldb 19:26:  [mycat_db]> select * from test2 where nPlayerID between 2 and 6 order by nPlayerID asc;
	+-----+-----------+---------+
	| id  | nPlayerID | szToken |
	+-----+-----------+---------+
	| 814 |         2 | 123     |
	| 815 |         3 | 123     |
	| 816 |         4 | 123     |
	| 817 |         5 | 123     |
	| 818 |         6 | 123     |
	+-----+-----------+---------+
	5 rows in set (0.02 sec)



3. group by
	
	Group by务必使用标准语法 select count(*),type from tab_a group by type;
		select count(*) from test2 group by szToken;
		
		mycat_user@mysqldb 19:54:  [mycat_db]> select count(*) from test2 group by szToken;
		ERROR 2013 (HY000): Lost connection to MySQL server during query

	
	mycat_user@mysqldb 19:57:  [mycat_db]> select nPlayerID, count(*) from test2 group by szToken;
	ERROR 2013 (HY000): Lost connection to MySQL server during query
	 
	 mycat_user@mysqldb 19:55:  [mycat_db]> select nPlayerID, szToken, count(*) from test2 group by szToken;
	+-----------+---------+--------+
	| nPlayerID | szToken | COUNT2 |
	+-----------+---------+--------+
	|         1 | 123     |     12 |
	+-----------+---------+--------+
	1 row in set (0.01 sec)


	mycat_user@mysqldb 19:57:  [mycat_db]>  select szToken, count(*) from test2 group by szToken;
	+---------+--------+
	| szToken | COUNT1 |
	+---------+--------+
	| 123     |     12 |
	+---------+--------+
	1 row in set (0.01 sec)


4. avg/max/min
	
	mycat_user@mysqldb 20:11:  [mycat_db]> select avg(nPlayerID) from test2;
	+--------+
	| AVG0   |
	+--------+
	| 6.5000 |
	+--------+
	1 row in set (0.00 sec)

	
	mycat_user@mysqldb 20:09:  [mycat_db]> select max(nPlayerID) from test2;
	+------+
	| MAX0 |
	+------+
	|   12 |
	+------+
	1 row in set (0.01 sec)
	
	mycat_user@mysqldb 20:11:  [mycat_db]> select min(nPlayerID) from test2;
	+------+
	| MIN0 |
	+------+
	|    1 |
	+------+
	1 row in set (0.00 sec)
