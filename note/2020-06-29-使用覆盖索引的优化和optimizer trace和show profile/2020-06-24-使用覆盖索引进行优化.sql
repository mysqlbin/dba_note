
表结构和记录数
	CREATE TABLE `table_web_loginlog` (
	  `Idx` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
	  `nPlayerId` int(11) NOT NULL,
	  `nClubID` int(11) NOT NULL DEFAULT '0' COMMENT '俱乐部ID',
	  `szNickName` varchar(64) DEFAULT NULL,
	  `nAction` int(11) NOT NULL DEFAULT '0',
	  `szTime` timestamp NULL DEFAULT NULL,
	  `loginIp` varchar(64) DEFAULT NULL,
	  `strRe1` varchar(128) DEFAULT NULL,
	  PRIMARY KEY (`Idx`),
	  KEY `web_loginlog_idx_nPlayerId` (`nPlayerId`),
	  KEY `web_loginlog_idx_szTime` (`szTime`),
	  KEY `idx_loginIp_szTime` (`loginIp`,`szTime`)
	) ENGINE=InnoDB AUTO_INCREMENT=38222414 DEFAULT CHARSET=utf8mb4;


	mysql> SELECT count(*) FROM `table_web_loginlog` WHERE loginIp = '10.66.92.215'  AND sztime > DATE_SUB(NOW(),INTERVAL 3 DAY);
	+----------+
	| count(*) |
	+----------+
	|   445721 |
	+----------+
	1 row in set (0.61 sec)

	mysql> SELECT count(*) FROM `table_web_loginlog`;
	+----------+
	| count(*) |
	+----------+
	| 21774811 |
	+----------+
	1 row in set (14.16 sec)

	
下面的SQL语句如何优化：
	mysql>  desc SELECT count(*) FROM `table_web_loginlog` WHERE loginIp = '10.66.92.215'  AND sztime > DATE_SUB(NOW(),INTERVAL 3 DAY) and nPlayerId != 131473;
	+----+-------------+--------------------+------------+-------+-----------------------------------------------------------------------+--------------------+---------+------+--------+----------+------------------------------------+
	| id | select_type | table              | partitions | type  | possible_keys                                                         | key                | key_len | ref  | rows   | filtered | Extra                              |
	+----+-------------+--------------------+------------+-------+-----------------------------------------------------------------------+--------------------+---------+------+--------+----------+------------------------------------+
	|  1 | SIMPLE      | table_web_loginlog | NULL       | range | web_loginlog_idx_nPlayerId,web_loginlog_idx_szTime,idx_loginIp_szTime | idx_loginIp_szTime | 264     | NULL | 904450 |    51.71 | Using index condition; Using where |
	+----+-------------+--------------------+------------+-------+-----------------------------------------------------------------------+--------------------+---------+------+--------+----------+------------------------------------+
	1 row in set, 1 warning (0.00 sec)


	alter table table_web_loginlog add index idx_loginIp_szTime_nPlayerId(`loginIp`,`szTime`,`nPlayerId`);
	
	

优化开始
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


制造数据
	drop procedure idata;
	delimiter ;;
	create procedure idata()
	begin
	  declare i int;
	  set i=1;
	  start transaction;
	  while(i<=100000)do
		INSERT INTO `bak_niuniuh5_db`.`table_web_loginlog` (`nPlayerId`, `nClubID`, `szNickName`, `nAction`, `szTime`, `loginIp`, `strRe1`) VALUES ('1000', '10090', 'bfidcig', '1', '2020-06-29 05:58:19', '192.168.0.71', NULL);
		set i=i+1;
	  end while;
	  commit;
	end;;
	delimiter ;
	call idata();


	root@mysqldb 17:31:  [bak_niuniuh5_db]> select count(*) from table_web_loginlog;
	+----------+
	| count(*) |
	+----------+
	|  7133852 |
	+----------+
	1 row in set (2.39 sec)

	root@mysqldb 17:33:  [bak_niuniuh5_db]> SELECT count(*) FROM table_web_loginlog where loginIp='192.168.0.71' and szTime > '2020-06-25 16:08:36';
	+----------+
	| count(*) |
	+----------+
	|   100000 |
	+----------+
	1 row in set (0.12 sec)
	
	
	root@mysqldb 10:28:  [bak_niuniuh5_db]> SELECT count(*) FROM `table_web_loginlog` WHERE loginIp = '192.168.0.71'  AND sztime  > '2020-06-25 16:08:36' and nPlayerId = 1000;
	+----------+
	| count(*) |
	+----------+
	|   100000 |
	+----------+
	1 row in set (0.18 sec)


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

执行计划
desc select sum(case when nPlayerId != 1000 then 1 else 0 end)  from table_web_loginlog where loginIp='192.168.0.71' and szTime > '2020-06-25 16:08:36';
desc SELECT count(*) FROM `table_web_loginlog` WHERE loginIp = '192.168.0.71'  AND sztime  > '2020-06-25 16:08:36' and nPlayerId != 1000;

select sum(case when nPlayerId != 1000 then 1 else 0 end)  from table_web_loginlog where loginIp='192.168.0.71' and szTime > '2020-06-25 16:08:36';
SELECT count(*) FROM `table_web_loginlog` WHERE loginIp = '192.168.0.71'  AND sztime  > '2020-06-25 16:08:36' and nPlayerId != 1000;


root@mysqldb 17:34:  [bak_niuniuh5_db]> desc select sum(case when nPlayerId != 1000 then 1 else 0 end)  from table_web_loginlog where loginIp='192.168.0.71' and szTime > '2020-06-25 16:08:36';
+----+-------------+--------------------+------------+-------+--------------------------------------------+--------------------+---------+------+--------+----------+-----------------------+
| id | select_type | table              | partitions | type  | possible_keys                              | key                | key_len | ref  | rows   | filtered | Extra                 |
+----+-------------+--------------------+------------+-------+--------------------------------------------+--------------------+---------+------+--------+----------+-----------------------+
|  1 | SIMPLE      | table_web_loginlog | NULL       | range | web_loginlog_idx_szTime,idx_loginIp_szTime | idx_loginIp_szTime | 264     | NULL | 190468 |   100.00 | Using index condition |
+----+-------------+--------------------+------------+-------+--------------------------------------------+--------------------+---------+------+--------+----------+-----------------------+
1 row in set, 1 warning (0.00 sec)

root@mysqldb 17:36:  [bak_niuniuh5_db]> desc SELECT count(*) FROM `table_web_loginlog` WHERE loginIp = '192.168.0.71'  AND sztime  > '2020-06-25 16:08:36' and nPlayerId != 1000;
+----+-------------+--------------------+------------+-------+-----------------------------------------------------------------+--------------------+---------+------+--------+----------+------------------------------------+
| id | select_type | table              | partitions | type  | possible_keys                                                   | key                | key_len | ref  | rows   | filtered | Extra                              |
+----+-------------+--------------------+------------+-------+-----------------------------------------------------------------+--------------------+---------+------+--------+----------+------------------------------------+
|  1 | SIMPLE      | table_web_loginlog | NULL       | range | web_loginlog_idx_szTime,idx_nPlayerId_szTime,idx_loginIp_szTime | idx_loginIp_szTime | 264     | NULL | 190468 |    50.00 | Using index condition; Using where |
+----+-------------+--------------------+------------+-------+-----------------------------------------------------------------+--------------------+---------+------+--------+----------+------------------------------------+
1 row in set, 1 warning (0.00 sec)

root@mysqldb 17:37:  [bak_niuniuh5_db]> select sum(case when nPlayerId != 1000 then 1 else 0 end)  from table_web_loginlog where loginIp='192.168.0.71' and szTime > '2020-06-25 16:08:36';
+----------------------------------------------------+
| sum(case when nPlayerId != 1000 then 1 else 0 end) |
+----------------------------------------------------+
|                                                  0 |
+----------------------------------------------------+
1 row in set (0.23 sec)

root@mysqldb 17:37:  [bak_niuniuh5_db]> SELECT count(*) FROM `table_web_loginlog` WHERE loginIp = '192.168.0.71'  AND sztime  > '2020-06-25 16:08:36' and nPlayerId != 1000;
+----------+
| count(*) |
+----------+
|        0 |
+----------+
1 row in set (0.24 sec)


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


添加索引 

	alter table table_web_loginlog add index idx_loginIp_szTime_nPlayerId(`loginIp`,`szTime`,`nPlayerId`);



desc select sum(case when nPlayerId != 1000 then 1 else 0 end)  from table_web_loginlog where loginIp='192.168.0.71' and szTime > '2020-06-25 16:08:36';
desc SELECT count(*) FROM `table_web_loginlog` WHERE loginIp = '192.168.0.71'  AND sztime  > '2020-06-25 16:08:36' and nPlayerId != 1000;

select sum(case when nPlayerId != 1000 then 1 else 0 end)  from table_web_loginlog where loginIp='192.168.0.71' and szTime > '2020-06-25 16:08:36';
SELECT count(*) FROM `table_web_loginlog` WHERE loginIp = '192.168.0.71'  AND sztime  > '2020-06-25 16:08:36' and nPlayerId != 1000;


root@mysqldb 17:39:  [bak_niuniuh5_db]> desc select sum(case when nPlayerId != 1000 then 1 else 0 end)  from table_web_loginlog where loginIp='192.168.0.71' and szTime > '2020-06-25 16:08:36';
+----+-------------+--------------------+------------+-------+-------------------------------------------------------------------------+------------------------------+---------+------+--------+----------+--------------------------+
| id | select_type | table              | partitions | type  | possible_keys                                                           | key                          | key_len | ref  | rows   | filtered | Extra                    |
+----+-------------+--------------------+------------+-------+-------------------------------------------------------------------------+------------------------------+---------+------+--------+----------+--------------------------+
|  1 | SIMPLE      | table_web_loginlog | NULL       | range | web_loginlog_idx_szTime,idx_loginIp_szTime,idx_loginIp_szTime_nPlayerId | idx_loginIp_szTime_nPlayerId | 264     | NULL | 195588 |   100.00 | Using where; Using index |
+----+-------------+--------------------+------------+-------+-------------------------------------------------------------------------+------------------------------+---------+------+--------+----------+--------------------------+
1 row in set, 1 warning (0.00 sec)

root@mysqldb 17:39:  [bak_niuniuh5_db]> desc SELECT count(*) FROM `table_web_loginlog` WHERE loginIp = '192.168.0.71'  AND sztime  > '2020-06-25 16:08:36' and nPlayerId != 1000;
+----+-------------+--------------------+------------+-------+----------------------------------------------------------------------------------------------+------------------------------+---------+------+--------+----------+--------------------------+
| id | select_type | table              | partitions | type  | possible_keys                                                                                | key                          | key_len | ref  | rows   | filtered | Extra                    |
+----+-------------+--------------------+------------+-------+----------------------------------------------------------------------------------------------+------------------------------+---------+------+--------+----------+--------------------------+
|  1 | SIMPLE      | table_web_loginlog | NULL       | range | web_loginlog_idx_szTime,idx_nPlayerId_szTime,idx_loginIp_szTime,idx_loginIp_szTime_nPlayerId | idx_loginIp_szTime_nPlayerId | 264     | NULL | 195588 |    50.00 | Using where; Using index |
+----+-------------+--------------------+------------+-------+----------------------------------------------------------------------------------------------+------------------------------+---------+------+--------+----------+--------------------------+
1 row in set, 1 warning (0.00 sec)


root@mysqldb 17:39:  [bak_niuniuh5_db]> select sum(case when nPlayerId != 1000 then 1 else 0 end)  from table_web_loginlog where loginIp='192.168.0.71' and szTime > '2020-06-25 16:08:36';
+----------------------------------------------------+
| sum(case when nPlayerId != 1000 then 1 else 0 end) |
+----------------------------------------------------+
|                                                  0 |
+----------------------------------------------------+
1 row in set (0.13 sec)

root@mysqldb 17:39:  [bak_niuniuh5_db]> SELECT count(*) FROM `table_web_loginlog` WHERE loginIp = '192.168.0.71'  AND sztime  > '2020-06-25 16:08:36' and nPlayerId != 1000;
+----------+
| count(*) |
+----------+
|        0 |
+----------+
1 row in set (0.09 sec)
	

索引基数
	root@mysqldb 10:26:  [bak_niuniuh5_db]> show index from table_web_loginlog;
	+--------------------+------------+------------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| Table              | Non_unique | Key_name                     | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
	+--------------------+------------+------------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| table_web_loginlog |          0 | PRIMARY                      |            1 | Idx         | A         |     6534338 |     NULL | NULL   |      | BTREE      |         |               |
	| table_web_loginlog |          1 | idx_loginIp_szTime_nPlayerId |            1 | loginIp     | A         |      832761 |     NULL | NULL   | YES  | BTREE      |         |               |
	| table_web_loginlog |          1 | idx_loginIp_szTime_nPlayerId |            2 | szTime      | A         |     6634611 |     NULL | NULL   | YES  | BTREE      |         |               |
	| table_web_loginlog |          1 | idx_loginIp_szTime_nPlayerId |            3 | nPlayerId   | A         |     6634611 |     NULL | NULL   |      | BTREE      |         |               |
	| table_web_loginlog |          1 | idx_loginIp_szTime           |            1 | loginIp     | A         |      830219 |     NULL | NULL   | YES  | BTREE      |         |               |
	| table_web_loginlog |          1 | idx_loginIp_szTime           |            2 | szTime      | A         |     6634611 |     NULL | NULL   | YES  | BTREE      |         |               |
	+--------------------+------------+------------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	6 rows in set (0.00 sec)
