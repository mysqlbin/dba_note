
1. 表结构和业务场景

	CREATE TABLE `table_third_order` (
	  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
	  .......................................
	  `nStatus` int(10) NOT NULL COMMENT '订单: 0-处理中,1-成功,2-失败',
	  .......................................
	  PRIMARY KEY (`ID`),
	  KEY `idx_nStatus_CreateTime` (`nStatus`,`CreateTime`),

	) ENGINE=InnoDB AUTO_INCREMENT=12176015 DEFAULT CHARSET=utf8mb4 COMMENT='第三方平台兑换订单表';





	数据写入订单表中，nStatus=0：
		INSERT INTO `table_third_order`(..............., `nStatus`, ...............) VALUES (..............., 0, ...............);
		
		
	有多种途径把 table_third_order.szOrder 改为 1（更新语句有更新二级索引的数据，会统计到修改表行数的计数器中），同时加上表还有insert操作，因此修改表行数超过总行数的 10%，会自动更新统计信息，但是在从库并没有自动更新统计信息。
	
	这个表没有删除过数据。


2. 当前时间
   
	mysql> select now();
	+---------------------+
	| now()               |
	+---------------------+
	| 2021-11-25 10:02:53 |
	+---------------------+
	1 row in set (0.00 sec)

  
  
  
3. 表在主库更新统计信息的最新时间

	mysql> select * from mysql.innodb_table_stats  where database_name='niuniuh5_db' and table_name="table_third_order";
	+---------------+-------------------+---------------------+----------+----------------------+--------------------------+
	| database_name | table_name        | last_update         | n_rows   | clustered_index_size | sum_of_other_index_sizes |
	+---------------+-------------------+---------------------+----------+----------------------+--------------------------+
	| niuniuh5_db   | table_third_order | 2021-11-14 17:20:39 | 11967345 |                89599 |                    96024 |
	+---------------+-------------------+---------------------+----------+----------------------+--------------------------+
	1 row in set (0.00 sec)

	
	select count(*) from niuniuh5_db.table_third_order;
	select count(*) from niuniuh5_db.table_third_order where CreateTime>='2021-11-14 17:20:39';

	
	mysql> select count(*) from niuniuh5_db.table_third_order;
	+----------+
	| count(*) |
	+----------+
	| 12176022 |
	+----------+
	1 row in set (2.95 sec)

	mysql> select count(*) from niuniuh5_db.table_third_order where CreateTime>='2021-11-14 17:20:39';
	+----------+
	| count(*) |
	+----------+
	|    94092 |
	+----------+
	1 row in set (0.06 sec)
	
	

4. 表在从库更新统计信息的最后一次更新时间
	
	mysql> select * from mysql.innodb_table_stats  where database_name='niuniuh5_db' and table_name="table_third_order";
	+---------------+-------------------+---------------------+---------+----------------------+--------------------------+
	| database_name | table_name        | last_update         | n_rows  | clustered_index_size | sum_of_other_index_sizes |
	+---------------+-------------------+---------------------+---------+----------------------+--------------------------+
	| niuniuh5_db   | table_third_order | 2020-07-28 14:15:14 | 6832791 |                53823 |                    49590 |
	+---------------+-------------------+---------------------+---------+----------------------+--------------------------+
	1 row in set (0.00 sec)
	
	select count(*) from niuniuh5_db.table_third_order;
	select count(*) from niuniuh5_db.table_third_order where CreateTime>='2020-07-28 14:15:14';
	
	mysql> select count(*) from niuniuh5_db.table_third_order;

	+----------+
	| count(*) |
	+----------+
	| 12176487 |
	+----------+
	1 row in set (1.95 sec)

	mysql> select count(*) from niuniuh5_db.table_third_order where CreateTime>='2020-07-28 14:15:14';
	+----------+
	| count(*) |
	+----------+
	|  5321658 |
	+----------+
	1 row in set (3.03 sec)


	可以看到，表修改的行数，达到总表行数的40%+，也没有自动更新统计信息。(从库的案例。)




