
https://blog.csdn.net/kianliu_007/article/details/38408519   (mysqldump如何保证数据一致性)



前言：
	t2 和 t3都是MyISAM表		

备份期间做数据删除操作:

	1. 在备份t3表之前删除t3.id=31999965的数据:
		delete from t3 where id=31999965;   # 会记录 binlog; 但是写 binlog的时机是在 备份获取到的 位置点之后. 
		(Query OK)
		
		mysql> select id from t3 order by id desc limit 1;
		+----------+
		| id       |
		+----------+
		| 31999964 |
		+----------+
		1 row in set (0.04 sec)

	2. 在备份t2表期间删除t2.id=31999965的数据:
		delete from t2 where id=31999965;
		(blocked) 
		然后手动 kill掉delete from t2 where id=31999965;
		
	3. 在备份t2表完成之后, 但是整个备份没有备份完成, 删除t2.id=31999965的数据:
		delete from t2 where id=31999965;
		(Query OK)
		
		mysql> select id from t2 order by id desc limit 1;
		+----------+
		| id       |
		+----------+
		| 31999964 |
		+----------+
		1 row in set (0.04 sec)

		
		
恢复备份数据archery6.sql之后, 查看 	

mysql> select id from t3 order by id desc limit 1;
+----------+
| id       |
+----------+
| 31999964 |
+----------+
1 row in set (0.00 sec)


mysql> select id from t2 order by id desc limit 1;
+----------+
| id       |
+----------+
| 31999965 |
+----------+
1 row in set (0.00 sec)
	



可以看到, MyISAM表 在备份期间, 如果在没有备份到某个表之前做DML操作, 那么备份之后恢复出来的数据, 跟 备份时间点的数据不一致;
如果通过备份之后恢复出来的数据基于复制点跟主库建立起主从关系, 那么从库在接收主库binlog之后, 写入本地的 relay log, 然后开始应用,  
这时候会发生数据不一致，如下所示:
	
	Last_SQL_Errno: 1032
	Last_SQL_Error: Could not execute Delete_rows event on table archery.t3; Can't find record in 't3', Error_code: 1032; handler error HA_ERR_KEY_NOT_FOUND; the event's master log mysql-bin.000080, end_log_pos 835570574
分析下为什么会发生这种情况：	
	在备份t3表之前删除t3.id=31999965的数据，因此没有获取到一致性视图/快照，备份到的数据是已经删除了t3.id=31999965之后的；
	同时会记录 binlog，但是写 binlog的时机是在 备份获取到位置点之后.   *******
	如果把删除t3.id=31999965的数据的binlog应用到从库，那么就会提示要删除的数据不存在了。
	
思考：
	如果是 insert语句呢？
	答：
		会出现1062主键冲突；
		binlog_format=row格式下，binlog会记录下主键， 从库在接收binlog写入到 relay log之后，再通过应用 relay log用主键匹配记录，
		当匹配到主键记录已经存在的时候， 那么就会提示 1062错误了。
	可以做实验验证下。


数据不一致的原因，在于备份到的数据是写操作生效之后的， 并且写操作会记录binlog, 如果备份的数据做从库，那么从库会应用写操作记录的 binlog；
	
	
sed -i 's/`archery6`/`archery`/g' archery6.sql  # 替换
	
grant all privileges on *.* to 'root'@'%' identified by '123456abc';
grant replication slave on *.* to 'repl_test'@'%' identified by '123456abc';

CHANGE MASTER TO master_host='192.168.0.54',master_user='repl_test',master_password='123456abc',MASTER_LOG_FILE='mysql-bin.000080', MASTER_LOG_POS=835570336;



如何统计表的存储引擎类型


备份期间做数据删除操作输出的 general log 如下:
mysql> mysqldump  -h192.168.0.54 -uroot -p123456abc --set-gtid-purged=OFF --single-transaction --master-data=2 -B archery > archery6.sql
mysqldump: [Warning] Using a password on the command line interface can be insecure.

2019-07-03T13:43:30.905846+08:00	   54 Connect	root@192.168.0.54 on  using TCP/IP
2019-07-03T13:43:30.931557+08:00	   54 Query	/*!40100 SET @@SQL_MODE='' */
2019-07-03T13:43:30.961609+08:00	   54 Query	/*!40103 SET TIME_ZONE='+00:00' */
2019-07-03T13:43:30.962183+08:00	   54 Query	FLUSH /*!40101 LOCAL */ TABLES
2019-07-03T13:43:31.010250+08:00	   54 Query	FLUSH TABLES WITH READ LOCK
2019-07-03T13:43:31.010544+08:00	   54 Query	SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ
2019-07-03T13:43:31.010688+08:00	   54 Query	START TRANSACTION /*!40100 WITH CONSISTENT SNAPSHOT */
2019-07-03T13:43:31.010877+08:00	   54 Query	SHOW MASTER STATUS
2019-07-03T13:43:31.011046+08:00	   54 Query	UNLOCK TABLES
2019-07-03T13:43:31.011271+08:00	   54 Query	SELECT LOGFILE_GROUP_NAME, FILE_NAME, TOTAL_EXTENTS, INITIAL_SIZE, ENGINE, EXTRA FROM INFORMATION_SCHEMA.FILES WHERE FILE_TYPE = 'UNDO LOG' AND FILE_NAME IS NOT NULL AND LOGFILE_GROUP_NAME IS NOT NULL AND LOGFILE_GROUP_NAME IN (SELECT DISTINCT LOGFILE_GROUP_NAME FROM INFORMATION_SCHEMA.FILES WHERE FILE_TYPE = 'DATAFILE' AND TABLESPACE_NAME IN (SELECT DISTINCT TABLESPACE_NAME FROM INFORMATION_SCHEMA.PARTITIONS WHERE TABLE_SCHEMA IN ('archery'))) GROUP BY LOGFILE_GROUP_NAME, FILE_NAME, ENGINE, TOTAL_EXTENTS, INITIAL_SIZE ORDER BY LOGFILE_GROUP_NAME
2019-07-03T13:43:31.082971+08:00	   54 Query	SELECT DISTINCT TABLESPACE_NAME, FILE_NAME, LOGFILE_GROUP_NAME, EXTENT_SIZE, INITIAL_SIZE, ENGINE FROM INFORMATION_SCHEMA.FILES WHERE FILE_TYPE = 'DATAFILE' AND TABLESPACE_NAME IN (SELECT DISTINCT TABLESPACE_NAME FROM INFORMATION_SCHEMA.PARTITIONS WHERE TABLE_SCHEMA IN ('archery')) ORDER BY TABLESPACE_NAME, LOGFILE_GROUP_NAME
2019-07-03T13:43:31.084961+08:00	   54 Query	SHOW VARIABLES LIKE 'ndbinfo\_version'
2019-07-03T13:43:31.103091+08:00	   54 Init DB	archery
2019-07-03T13:43:31.103308+08:00	   54 Query	SHOW CREATE DATABASE IF NOT EXISTS `archery`
2019-07-03T13:43:31.103446+08:00	   54 Query	SAVEPOINT sp
2019-07-03T13:43:31.103728+08:00	   54 Query	show tables
2019-07-03T13:43:31.103984+08:00	   54 Query	show table status like 'mysql\_slow\_query\_review'
2019-07-03T13:43:31.104221+08:00	   54 Query	SET SQL_QUOTE_SHOW_CREATE=1
2019-07-03T13:43:31.104341+08:00	   54 Query	SET SESSION character_set_results = 'binary'
2019-07-03T13:43:31.110947+08:00	   54 Query	show create table `mysql_slow_query_review`
2019-07-03T13:43:31.111155+08:00	   54 Query	SET SESSION character_set_results = 'utf8'
2019-07-03T13:43:31.111335+08:00	   54 Query	show fields from `mysql_slow_query_review`
2019-07-03T13:43:31.111769+08:00	   54 Query	show fields from `mysql_slow_query_review`
2019-07-03T13:43:31.112160+08:00	   54 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `mysql_slow_query_review`
2019-07-03T13:43:31.112389+08:00	   54 Query	SET SESSION character_set_results = 'binary'
2019-07-03T13:43:31.112623+08:00	   54 Query	use `archery`
2019-07-03T13:43:31.112749+08:00	   54 Query	select @@collation_database
2019-07-03T13:43:31.112968+08:00	   54 Query	SHOW TRIGGERS LIKE 'mysql\_slow\_query\_review'
2019-07-03T13:43:31.113260+08:00	   54 Query	SET SESSION character_set_results = 'utf8'
2019-07-03T13:43:31.113374+08:00	   54 Query	ROLLBACK TO SAVEPOINT sp
2019-07-03T13:43:31.113494+08:00	   54 Query	show table status like 'mysql\_slow\_query\_review\_history'
2019-07-03T13:43:31.113845+08:00	   54 Query	SET SQL_QUOTE_SHOW_CREATE=1
2019-07-03T13:43:31.114093+08:00	   54 Query	SET SESSION character_set_results = 'binary'
2019-07-03T13:43:31.114236+08:00	   54 Query	show create table `mysql_slow_query_review_history`
2019-07-03T13:43:31.114510+08:00	   54 Query	SET SESSION character_set_results = 'utf8'
2019-07-03T13:43:31.114737+08:00	   54 Query	show fields from `mysql_slow_query_review_history`
2019-07-03T13:43:31.115469+08:00	   54 Query	show fields from `mysql_slow_query_review_history`
2019-07-03T13:43:31.116253+08:00	   54 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `mysql_slow_query_review_history`
2019-07-03T13:43:31.116619+08:00	   54 Query	SET SESSION character_set_results = 'binary'
2019-07-03T13:43:31.116819+08:00	   54 Query	use `archery`
2019-07-03T13:43:31.117020+08:00	   54 Query	select @@collation_database
2019-07-03T13:43:31.117157+08:00	   54 Query	SHOW TRIGGERS LIKE 'mysql\_slow\_query\_review\_history'
2019-07-03T13:43:31.117505+08:00	   54 Query	SET SESSION character_set_results = 'utf8'
2019-07-03T13:43:31.117690+08:00	   54 Query	ROLLBACK TO SAVEPOINT sp
2019-07-03T13:43:31.117845+08:00	   54 Query	show table status like 't2'
2019-07-03T13:43:31.118153+08:00	   54 Query	SET SQL_QUOTE_SHOW_CREATE=1
2019-07-03T13:43:31.118264+08:00	   54 Query	SET SESSION character_set_results = 'binary'
2019-07-03T13:43:31.118444+08:00	   54 Query	show create table `t2`
2019-07-03T13:43:31.118594+08:00	   54 Query	SET SESSION character_set_results = 'utf8'
2019-07-03T13:43:31.118713+08:00	   54 Query	show fields from `t2`
2019-07-03T13:43:31.119112+08:00	   54 Query	show fields from `t2`
2019-07-03T13:43:31.119490+08:00	   54 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `t2`
2019-07-03T13:43:35.218264+08:00	   43 Query	SET PROFILING=1
2019-07-03T13:43:35.218699+08:00	   43 Query	SHOW STATUS
2019-07-03T13:43:35.291620+08:00	   43 Query	SHOW STATUS

2019-07-03T13:43:35.486519+08:00	   43 Query	delete from t3 where id=31999965

2019-07-03T13:43:35.899387+08:00	   43 Query	SHOW STATUS
2019-07-03T13:43:35.901536+08:00	   43 Query	SELECT QUERY_ID, SUM(DURATION) AS SUM_DURATION FROM INFORMATION_SCHEMA.PROFILING GROUP BY QUERY_ID
2019-07-03T13:43:35.903430+08:00	   43 Query	SELECT STATE AS `状态`, ROUND(SUM(DURATION),7) AS `期间`, CONCAT(ROUND(SUM(DURATION)/0.406721*100,3), '%') AS `百分比` FROM INFORMATION_SCHEMA.PROFILING WHERE QUERY_ID=24 GROUP BY STATE ORDER BY SEQ
2019-07-03T13:43:37.712544+08:00	   43 Query	SET PROFILING=1
2019-07-03T13:43:37.713049+08:00	   43 Query	SHOW STATUS
2019-07-03T13:43:37.733543+08:00	   43 Query	SHOW STATUS

2019-07-03T13:43:37.795867+08:00	   43 Query	delete from t2 where id=31999965

2019-07-03T13:43:48.885024+08:00	   54 Query	SET SESSION character_set_results = 'binary'
2019-07-03T13:43:48.885296+08:00	   54 Query	use `archery`
2019-07-03T13:43:48.885561+08:00	   54 Query	select @@collation_database
2019-07-03T13:43:48.885770+08:00	   54 Query	SHOW TRIGGERS LIKE 't2'
2019-07-03T13:43:48.886613+08:00	   54 Query	SET SESSION character_set_results = 'utf8'
2019-07-03T13:43:48.886788+08:00	   54 Query	ROLLBACK TO SAVEPOINT sp

t3表的备份:
2019-07-03T13:43:48.887121+08:00	   54 Query	show table status like 't3'
2019-07-03T13:43:48.887502+08:00	   54 Query	SET SQL_QUOTE_SHOW_CREATE=1
2019-07-03T13:43:48.887679+08:00	   54 Query	SET SESSION character_set_results = 'binary'
2019-07-03T13:43:48.887948+08:00	   54 Query	show create table `t3`
2019-07-03T13:43:48.888264+08:00	   54 Query	SET SESSION character_set_results = 'utf8'
2019-07-03T13:43:48.888510+08:00	   54 Query	show fields from `t3`
2019-07-03T13:43:48.889098+08:00	   54 Query	show fields from `t3`
2019-07-03T13:43:48.889563+08:00	   54 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `t3`

2019-07-03T13:43:49.481203+08:00	   43 Query	SHOW STATUS
2019-07-03T13:43:49.491595+08:00	   43 Query	SELECT QUERY_ID, SUM(DURATION) AS SUM_DURATION FROM INFORMATION_SCHEMA.PROFILING GROUP BY QUERY_ID
2019-07-03T13:43:49.495247+08:00	   43 Query	SELECT STATE AS `状态`, ROUND(SUM(DURATION),7) AS `期间`, CONCAT(ROUND(SUM(DURATION)/11.653407*100,3), '%') AS `百分比` FROM INFORMATION_SCHEMA.PROFILING WHERE QUERY_ID=31 GROUP BY STATE ORDER BY SEQ
2019-07-03T13:44:08.916138+08:00	   54 Query	SET SESSION character_set_results = 'binary'
2019-07-03T13:44:08.916414+08:00	   54 Query	use `archery`
2019-07-03T13:44:09.176690+08:00	   54 Query	select @@collation_database
2019-07-03T13:44:09.327847+08:00	   54 Query	SHOW TRIGGERS LIKE 't3'
2019-07-03T13:44:09.329272+08:00	   54 Query	SET SESSION character_set_results = 'utf8'
2019-07-03T13:44:09.330120+08:00	   54 Query	ROLLBACK TO SAVEPOINT sp
2019-07-03T13:44:09.330620+08:00	   54 Query	RELEASE SAVEPOINT sp
2019-07-03T13:44:16.854677+08:00	   54 Quit	
