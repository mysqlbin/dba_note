

CREATE TABLE `t1_2500` (
  `id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP PROCEDURE IF EXISTS insertbatch_2500;
CREATE PROCEDURE insertbatch_2500()
BEGIN
DECLARE i INT;
  SET i=1;
	start transaction;
  WHILE(i<=2500) DO
    INSERT INTO sbtest.t1_2500(id)VALUES(i);
    SET i=i+1; 
  END WHILE;
	commit;
END;


call insertbatch_2500();


root@mysqldb 17:56:  [sbtest]> select count(*) from t1_2500;
+----------+
| count(*) |
+----------+
|     2500 |
+----------+
1 row in set (0.62 sec)



time /root/ghost/gh-ost --user="app_user" --password="123456abc" --host=192.168.0.91  --database="sbtest" --table="t1_2500" --alter="engine=innodb" --allow-on-master --execute

[root@kp04 ghost]#  time /root/ghost/gh-ost --user="app_user" --password="123456abc" --host=192.168.0.91  --database="sbtest" --table="t1_2500" --alter="engine=innodb" --allow-on-master --execute
[2020/05/06 17:58:28] [info] binlogsyncer.go:133 create BinlogSyncer with config {99999 mysql 192.168.0.91 3306 app_user    false false <nil> false UTC true 0 0s 0s 0 false}
[2020/05/06 17:58:28] [info] binlogsyncer.go:354 begin to sync binlog from position (mysql-bin.000003, 69535147)
[2020/05/06 17:58:28] [info] binlogsyncer.go:203 register slave for master server 192.168.0.91:3306
[2020/05/06 17:58:29] [info] binlogsyncer.go:723 rotate to (mysql-bin.000003, 69535147)
# Migrating `sbtest`.`t1_2500`; Ghost table is `sbtest`.`_t1_2500_gho`
# Migrating kp04:3306; inspecting kp04:3306; executing on kp04
# Migration started at Wed May 06 17:58:25 +0800 2020
# chunk-size: 1000; max-lag-millis: 1500ms; dml-batch-size: 10; max-load: ; critical-load: ; nice-ratio: 0.000000
# throttle-additional-flag-file: /tmp/gh-ost.throttle 
# Serving on unix socket: /tmp/gh-ost.sbtest.t1_2500.sock
Copy: 0/2500 0.0%; Applied: 0; Backlog: 0/1000; Time: 9s(total), 0s(copy); streamer: mysql-bin.000003:69537308; Lag: 0.39s, State: migrating; ETA: N/A
Copy: 0/2500 0.0%; Applied: 0; Backlog: 0/1000; Time: 10s(total), 1s(copy); streamer: mysql-bin.000003:69542205; Lag: 0.14s, State: migrating; ETA: N/A
Copy: 2000/2500 80.0%; Applied: 0; Backlog: 0/1000; Time: 11s(total), 2s(copy); streamer: mysql-bin.000003:69555217; Lag: 0.10s, State: migrating; ETA: 0s
Copy: 2500/2500 100.0%; Applied: 0; Backlog: 0/1000; Time: 11s(total), 2s(copy); streamer: mysql-bin.000003:69558862; Lag: 0.33s, State: migrating; ETA: due
Copy: 2500/2500 100.0%; Applied: 0; Backlog: 1/1000; Time: 12s(total), 2s(copy); streamer: mysql-bin.000003:69563617; Lag: 0.03s, State: migrating; ETA: due
# Migrating `sbtest`.`t1_2500`; Ghost table is `sbtest`.`_t1_2500_gho`
# Migrating kp04:3306; inspecting kp04:3306; executing on kp04
# Migration started at Wed May 06 17:58:25 +0800 2020
# chunk-size: 1000; max-lag-millis: 1500ms; dml-batch-size: 10; max-load: ; critical-load: ; nice-ratio: 0.000000
# throttle-additional-flag-file: /tmp/gh-ost.throttle 
# Serving on unix socket: /tmp/gh-ost.sbtest.t1_2500.sock
Copy: 2500/2500 100.0%; Applied: 0; Backlog: 0/1000; Time: 12s(total), 2s(copy); streamer: mysql-bin.000003:69565505; Lag: 0.03s, State: migrating; ETA: due
Copy: 2500/2500 100.0%; Applied: 0; Backlog: 0/1000; Time: 13s(total), 2s(copy); streamer: mysql-bin.000003:69567012; Lag: 0.59s, State: migrating; ETA: due
[2020/05/06 17:58:38] [info] binlogsyncer.go:164 syncer is closing...
[2020/05/06 17:58:38] [error] binlogstreamer.go:77 close sync with err: sync is been closing...
[2020/05/06 17:58:38] [info] binlogsyncer.go:179 syncer is closed
2020-05-06 17:58:39 ERROR Error 1146: Table 'sbtest._t1_2500_ghc' doesn t exist
# Done

real	0m14.063s
user	0m0.059s
sys	0m0.059s


general log
	
	2020-05-06T09:58:25.227826Z	 4743 Connect	app_user@192.168.0.91 on sbtest using TCP/IP
	2020-05-06T09:58:25.250639Z	 4743 Query	SET autocommit=true
	2020-05-06T09:58:25.722662Z	 4743 Query	SET NAMES utf8mb4
	2020-05-06T09:58:25.724184Z	 4743 Query	select @@global.version
	2020-05-06T09:58:25.804277Z	 4743 Query	select @@global.port
	2020-05-06T09:58:25.821793Z	 4743 Query	select @@global.hostname, @@global.port
	权限验证
	2020-05-06T09:58:25.823092Z	 4743 Query	show /* gh-ost */ grants for current_user()
	
	获取 binlog 相关信息:包括 是否开启binlog、row格式、位图格式
	2020-05-06T09:58:25.873312Z	 4743 Query	select @@global.log_bin, @@global.binlog_format
	2020-05-06T09:58:25.874109Z	 4743 Query	select @@global.binlog_row_image
root@mysqldb 18:09:  [sbtest]> select @@global.log_bin, @@global.binlog_format;
+------------------+------------------------+
| @@global.log_bin | @@global.binlog_format |
+------------------+------------------------+
|                1 | ROW                    |
+------------------+------------------------+
1 row in set (0.00 sec)
root@mysqldb 18:09:  [sbtest]> select @@global.binlog_row_image;
+---------------------------+
| @@global.binlog_row_image |
+---------------------------+
| FULL                      |
+---------------------------+
1 row in set (0.00 sec)
	


	2020-05-06T09:58:25.875726Z	 4744 Connect	app_user@192.168.0.91 on information_schema using TCP/IP
	2020-05-06T09:58:25.876335Z	 4744 Query	SET autocommit=true
	2020-05-06T09:58:25.877005Z	 4744 Query	SET NAMES utf8mb4
	2020-05-06T09:58:25.877600Z	 4744 Query	show slave status
	2020-05-06T09:58:25.936999Z	 4744 Quit	
	2020-05-06T09:58:25.946867Z	 4743 Query	show /* gh-ost */ table status from `sbtest` like 't1_2500'
	
	检查有没有外键
	2020-05-06T09:58:26.451686Z	 4743 Query	SELECT
				SUM(REFERENCED_TABLE_NAME IS NOT NULL AND TABLE_SCHEMA='sbtest' AND TABLE_NAME='t1_2500') as num_child_side_fk,
				SUM(REFERENCED_TABLE_NAME IS NOT NULL AND REFERENCED_TABLE_SCHEMA='sbtest' AND REFERENCED_TABLE_NAME='t1_2500') as num_parent_side_fk
			FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
			WHERE
					REFERENCED_TABLE_NAME IS NOT NULL
					AND ((TABLE_SCHEMA='sbtest' AND TABLE_NAME='t1_2500')
						OR (REFERENCED_TABLE_SCHEMA='sbtest' AND REFERENCED_TABLE_NAME='t1_2500')
					)
	检查有没有触发器
	2020-05-06T09:58:27.989751Z	 4743 Query	SELECT COUNT(*) AS num_triggers
				FROM INFORMATION_SCHEMA.TRIGGERS
				WHERE
					TRIGGER_SCHEMA='sbtest'
					AND EVENT_OBJECT_TABLE='t1_2500'
					
	预估行数	
	2020-05-06T09:58:28.003785Z	 4743 Query	explain select /* gh-ost */ * from `sbtest`.`t1_2500` where 1=1
root@mysqldb 18:10:  [sbtest]> explain select /* gh-ost */ * from `sbtest`.`t1_2500` where 1=1;
+----+-------------+---------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
| id | select_type | table   | partitions | type  | possible_keys | key     | key_len | ref  | rows | filtered | Extra       |
+----+-------------+---------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | t1_2500 | NULL       | index | NULL          | PRIMARY | 4       | NULL | 2500 |   100.00 | Using index |
+----+-------------+---------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
1 row in set, 1 warning (0.14 sec)

	
	检查表的主键信息
	2020-05-06T09:58:28.033331Z	 4743 Query	SELECT
		  COLUMNS.TABLE_SCHEMA,
		  COLUMNS.TABLE_NAME,
		  COLUMNS.COLUMN_NAME,
		  UNIQUES.INDEX_NAME,
		  UNIQUES.COLUMN_NAMES,
		  UNIQUES.COUNT_COLUMN_IN_INDEX,
		  COLUMNS.DATA_TYPE,
		  COLUMNS.CHARACTER_SET_NAME,
				LOCATE('auto_increment', EXTRA) > 0 as is_auto_increment,
		  has_nullable
		FROM INFORMATION_SCHEMA.COLUMNS INNER JOIN (
		  SELECT
			TABLE_SCHEMA,
			TABLE_NAME,
			INDEX_NAME,
			COUNT(*) AS COUNT_COLUMN_IN_INDEX,
			GROUP_CONCAT(COLUMN_NAME ORDER BY SEQ_IN_INDEX ASC) AS COLUMN_NAMES,
			SUBSTRING_INDEX(GROUP_CONCAT(COLUMN_NAME ORDER BY SEQ_IN_INDEX ASC), ',', 1) AS FIRST_COLUMN_NAME,
			SUM(NULLABLE='YES') > 0 AS has_nullable
		  FROM INFORMATION_SCHEMA.STATISTICS
		  WHERE
					NON_UNIQUE=0
					AND TABLE_SCHEMA = 'sbtest'
			AND TABLE_NAME = 't1_2500'
		  GROUP BY TABLE_SCHEMA, TABLE_NAME, INDEX_NAME
		) AS UNIQUES
		ON (
		  COLUMNS.COLUMN_NAME = UNIQUES.FIRST_COLUMN_NAME
		)
		WHERE
		  COLUMNS.TABLE_SCHEMA = 'sbtest'
		  AND COLUMNS.TABLE_NAME = 't1_2500'
		ORDER BY
		  COLUMNS.TABLE_SCHEMA, COLUMNS.TABLE_NAME,
		  CASE UNIQUES.INDEX_NAME
			WHEN 'PRIMARY' THEN 0
			ELSE 1
		  END,
		  CASE has_nullable
			WHEN 0 THEN 0
			ELSE 1
		  END,
		  CASE IFNULL(CHARACTER_SET_NAME, '')
			  WHEN '' THEN 0
			  ELSE 1
		  END,
		  CASE DATA_TYPE
			WHEN 'tinyint' THEN 0
			WHEN 'smallint' THEN 1
			WHEN 'int' THEN 2
			WHEN 'bigint' THEN 3
			ELSE 100
		  END,
		  COUNT_COLUMN_IN_INDEX
		  
	检查连接到主库或从库，是否开启log_slave_updates，以及binlog信息 	  
	2020-05-06T09:58:28.058318Z	 4743 Query	show columns from `sbtest`.`t1_2500`
	2020-05-06T09:58:28.062061Z	 4745 Connect	app_user@192.168.0.91 on information_schema using TCP/IP
	2020-05-06T09:58:28.062606Z	 4745 Query	SET autocommit=true
	2020-05-06T09:58:28.063235Z	 4745 Query	SET NAMES utf8mb4
	2020-05-06T09:58:28.064023Z	 4745 Query	show slave status
	2020-05-06T09:58:28.065133Z	 4745 Quit	
	2020-05-06T09:58:28.078810Z	 4743 Query	select @@global.log_slave_updates
	2020-05-06T09:58:28.079705Z	 4743 Query	select @@global.version
	2020-05-06T09:58:28.080662Z	 4743 Query	select @@global.port
	
	模拟slave，获取当前的位点信息，创建 binlog streamer 监听binlog
	2020-05-06T09:58:28.081307Z	 4743 Query	show /* gh-ost readCurrentBinlogCoordinates */ master status
	2020-05-06T09:58:28.177537Z	 4746 Connect	app_user@192.168.0.91 on  using TCP/IP
	2020-05-06T09:58:28.190111Z	 4746 Query	SHOW GLOBAL VARIABLES LIKE 'BINLOG_CHECKSUM'
	2020-05-06T09:58:28.746216Z	 4746 Query	SET @master_binlog_checksum='NONE'
	2020-05-06T09:58:29.055733Z	 4743 Query	select @@global.version
	2020-05-06T09:58:29.056526Z	 4746 Binlog Dump	Log: 'mysql-bin.000003'  Pos: 69535147
	----------------------------------------------------------------------------------------
	
	
	2020-05-06T09:58:29.058703Z	 4743 Query	select @@global.port
	2020-05-06T09:58:29.061453Z	 4747 Connect	app_user@192.168.0.91 on sbtest using TCP/IP
	2020-05-06T09:58:29.062254Z	 4747 Query	SET autocommit=true
	2020-05-06T09:58:29.064461Z	 4747 Query	SET NAMES utf8mb4
	2020-05-06T09:58:29.064973Z	 4747 Query	select @@global.version
	2020-05-06T09:58:29.185912Z	 4747 Query	select @@global.port
	2020-05-06T09:58:29.186541Z	 4743 Query	select @@global.time_zone
	2020-05-06T09:58:29.187149Z	 4743 Query	select @@global.hostname, @@global.port
	2020-05-06T09:58:29.187722Z	 4743 Query	show columns from `sbtest`.`t1_2500`
	
	2020-05-06T09:58:29.190966Z	 4743 Query	show /* gh-ost */ table status from `sbtest` like '_t1_2500_gho'
	2020-05-06T09:58:29.195216Z	 4743 Query	show /* gh-ost */ table status from `sbtest` like '_t1_2500_del'
	2020-05-06T09:58:29.199201Z	 4743 Query	drop /* gh-ost */ table if exists `sbtest`.`_t1_2500_ghc`
	
	创建 日志记录表 xx_ghc 和 影子表 xx_gho 并且执行alter语句将影子表 变更为目标表结构。如下日志记录了该过程，gh-ost会将核心步骤记录到 _b_ghc 中。

	2020-05-06T09:58:29.692729Z	 4743 Query	create /* gh-ost */ table `sbtest`.`_t1_2500_ghc` (
				id bigint auto_increment,
				last_update timestamp not null DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
				hint varchar(64) charset ascii not null,
				value varchar(4096) charset ascii not null,
				primary key(id),
				unique key hint_uidx(hint)
			) auto_increment=256
	2020-05-06T09:58:30.839471Z	 4743 Query	create /* gh-ost */ table `sbtest`.`_t1_2500_gho` like `sbtest`.`t1_2500`
	2020-05-06T09:58:30.977963Z	 4743 Query	alter /* gh-ost */ table `sbtest`.`_t1_2500_gho` engine=innodb
	
	2020-05-06T09:58:33.583353Z	 4743 Query	insert /* gh-ost */ into `sbtest`.`_t1_2500_ghc`
					(id, hint, value)
				values
					(NULLIF(2, 0), 'state', 'GhostTableMigrated')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	2020-05-06T09:58:34.118578Z	 4743 Query	insert /* gh-ost */ into `sbtest`.`_t1_2500_ghc`
					(id, hint, value)
				values
					(NULLIF(0, 0), 'state at 1588759114117806354', 'GhostTableMigrated')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	2020-05-06T09:58:34.215006Z	 4743 Query	insert /* gh-ost */ into `sbtest`.`_t1_2500_ghc`
					(id, hint, value)
				values
					(NULLIF(1, 0), 'heartbeat', '2020-05-06T17:58:34.214257821+08:00')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	2020-05-06T09:58:34.243389Z	 4748 Connect	app_user@192.168.0.91 on information_schema using TCP/IP
	2020-05-06T09:58:34.244821Z	 4748 Query	SET autocommit=true
	2020-05-06T09:58:34.245376Z	 4748 Query	SET NAMES utf8mb4
	2020-05-06T09:58:34.245920Z	 4748 Query	show slave status
	2020-05-06T09:58:34.248842Z	 4749 Connect	app_user@192.168.0.91 on sbtest using TCP/IP
	2020-05-06T09:58:34.258668Z	 4749 Query	SET autocommit=true
	2020-05-06T09:58:34.259555Z	 4749 Query	SET NAMES utf8mb4
	2020-05-06T09:58:34.346062Z	 4749 Query	SELECT
		  COLUMNS.TABLE_SCHEMA,
		  COLUMNS.TABLE_NAME,
		  COLUMNS.COLUMN_NAME,
		  UNIQUES.INDEX_NAME,
		  UNIQUES.COLUMN_NAMES,
		  UNIQUES.COUNT_COLUMN_IN_INDEX,
		  COLUMNS.DATA_TYPE,
		  COLUMNS.CHARACTER_SET_NAME,
				LOCATE('auto_increment', EXTRA) > 0 as is_auto_increment,
		  has_nullable
		FROM INFORMATION_SCHEMA.COLUMNS INNER JOIN (
		  SELECT
			TABLE_SCHEMA,
			TABLE_NAME,
			INDEX_NAME,
			COUNT(*) AS COUNT_COLUMN_IN_INDEX,
			GROUP_CONCAT(COLUMN_NAME ORDER BY SEQ_IN_INDEX ASC) AS COLUMN_NAMES,
			SUBSTRING_INDEX(GROUP_CONCAT(COLUMN_NAME ORDER BY SEQ_IN_INDEX ASC), ',', 1) AS FIRST_COLUMN_NAME,
			SUM(NULLABLE='YES') > 0 AS has_nullable
		  FROM INFORMATION_SCHEMA.STATISTICS
		  WHERE
					NON_UNIQUE=0
					AND TABLE_SCHEMA = 'sbtest'
			AND TABLE_NAME = '_t1_2500_gho'
		  GROUP BY TABLE_SCHEMA, TABLE_NAME, INDEX_NAME
		) AS UNIQUES
		ON (
		  COLUMNS.COLUMN_NAME = UNIQUES.FIRST_COLUMN_NAME
		)
		WHERE
		  COLUMNS.TABLE_SCHEMA = 'sbtest'
		  AND COLUMNS.TABLE_NAME = '_t1_2500_gho'
		ORDER BY
		  COLUMNS.TABLE_SCHEMA, COLUMNS.TABLE_NAME,
		  CASE UNIQUES.INDEX_NAME
			WHEN 'PRIMARY' THEN 0
			ELSE 1
		  END,
		  CASE has_nullable
			WHEN 0 THEN 0
			ELSE 1
		  END,
		  CASE IFNULL(CHARACTER_SET_NAME, '')
			  WHEN '' THEN 0
			  ELSE 1
		  END,
		  CASE DATA_TYPE
			WHEN 'tinyint' THEN 0
			WHEN 'smallint' THEN 1
			WHEN 'int' THEN 2
			WHEN 'bigint' THEN 3
			ELSE 100
		  END,
		  COUNT_COLUMN_IN_INDEX
	2020-05-06T09:58:34.572877Z	 4743 Query	insert /* gh-ost */ into `sbtest`.`_t1_2500_ghc`
					(id, hint, value)
				values
					(NULLIF(1, 0), 'heartbeat', '2020-05-06T17:58:34.57261983+08:00')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	2020-05-06T09:58:34.578506Z	 4749 Query	show columns from `sbtest`.`_t1_2500_gho`
	2020-05-06T09:58:34.580284Z	 4749 Query	select
					*
				from
					information_schema.columns
				where
					table_schema='sbtest'
					and table_name='t1_2500'
	2020-05-06T09:58:34.581993Z	 4749 Query	select
					*
				from
					information_schema.columns
				where
					table_schema='sbtest'
					and table_name='t1_2500'
	2020-05-06T09:58:34.583405Z	 4749 Query	select
					*
				from
					information_schema.columns
				where
					table_schema='sbtest'
					and table_name='_t1_2500_gho'
					
				
	获取当前的最大主键和最小主键
	2020-05-06T09:58:34.584642Z	 4749 Query	select /* gh-ost `sbtest`.`t1_2500` */ `id`
					from
						`sbtest`.`t1_2500`
					order by
						`id` asc
					limit 1
	2020-05-06T09:58:34.604594Z	 4749 Query	select /* gh-ost `sbtest`.`t1_2500` */ `id`
					from
						`sbtest`.`t1_2500`
					order by
						`id` desc
					limit 1
	
	
	2020-05-06T09:58:34.605010Z	 4749 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	2020-05-06T09:58:34.659601Z	 4749 Query	insert /* gh-ost */ into `sbtest`.`_t1_2500_ghc`
					(id, hint, value)
				values
					(NULLIF(0, 0), 'copy iteration 0 at 1588759114', 'Copy: 0/2500 0.0%; Applied: 0; Backlog: 0/1000; Time: 9s(total), 0s(copy); streamer: mysql-bin.000003:69537308; Lag: 0.39s, State: migrating; ETA: N/A')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	2020-05-06T09:58:34.672592Z	 4743 Query	insert /* gh-ost */ into `sbtest`.`_t1_2500_ghc`
					(id, hint, value)
				values
					(NULLIF(1, 0), 'heartbeat', '2020-05-06T17:58:34.672326922+08:00')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	2020-05-06T09:58:34.705470Z	 4749 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	2020-05-06T09:58:34.772650Z	 4749 Query	insert /* gh-ost */ into `sbtest`.`_t1_2500_ghc`
					(id, hint, value)
				values
					(NULLIF(1, 0), 'heartbeat', '2020-05-06T17:58:34.772383891+08:00')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	2020-05-06T09:58:34.805478Z	 4743 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	2020-05-06T09:58:34.872643Z	 4749 Query	insert /* gh-ost */ into `sbtest`.`_t1_2500_ghc`
					(id, hint, value)
				values
					(NULLIF(1, 0), 'heartbeat', '2020-05-06T17:58:34.872364562+08:00')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	2020-05-06T09:58:34.905622Z	 4743 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	2020-05-06T09:58:34.972128Z	 4749 Query	insert /* gh-ost */ into `sbtest`.`_t1_2500_ghc`
					(id, hint, value)
				values
					(NULLIF(1, 0), 'heartbeat', '2020-05-06T17:58:34.971956175+08:00')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	2020-05-06T09:58:35.006359Z	 4743 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	2020-05-06T09:58:35.072551Z	 4749 Query	insert /* gh-ost */ into `sbtest`.`_t1_2500_ghc`
					(id, hint, value)
				values
					(NULLIF(1, 0), 'heartbeat', '2020-05-06T17:58:35.072306939+08:00')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	2020-05-06T09:58:35.105550Z	 4743 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	2020-05-06T09:58:35.172507Z	 4749 Query	insert /* gh-ost */ into `sbtest`.`_t1_2500_ghc`
					(id, hint, value)
				values
					(NULLIF(1, 0), 'heartbeat', '2020-05-06T17:58:35.172304619+08:00')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	2020-05-06T09:58:35.205618Z	 4743 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	2020-05-06T09:58:35.272605Z	 4749 Query	insert /* gh-ost */ into `sbtest`.`_t1_2500_ghc`
					(id, hint, value)
				values
					(NULLIF(1, 0), 'heartbeat', '2020-05-06T17:58:35.272392589+08:00')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	2020-05-06T09:58:35.305921Z	 4743 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	2020-05-06T09:58:35.372361Z	 4743 Query	insert /* gh-ost */ into `sbtest`.`_t1_2500_ghc`
					(id, hint, value)
				values
					(NULLIF(1, 0), 'heartbeat', '2020-05-06T17:58:35.372221712+08:00')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	2020-05-06T09:58:35.405913Z	 4749 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	2020-05-06T09:58:35.472399Z	 4749 Query	insert /* gh-ost */ into `sbtest`.`_t1_2500_ghc`
					(id, hint, value)
				values
					(NULLIF(1, 0), 'heartbeat', '2020-05-06T17:58:35.472233137+08:00')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	2020-05-06T09:58:35.505979Z	 4743 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	2020-05-06T09:58:35.572137Z	 4743 Query	insert /* gh-ost */ into `sbtest`.`_t1_2500_ghc`
					(id, hint, value)
				values
					(NULLIF(1, 0), 'heartbeat', '2020-05-06T17:58:35.571966405+08:00')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	2020-05-06T09:58:35.607249Z	 4750 Connect	app_user@192.168.0.91 on sbtest using TCP/IP
	2020-05-06T09:58:35.608119Z	 4750 Query	SET autocommit=true
	2020-05-06T09:58:35.608792Z	 4750 Query	SET NAMES utf8mb4
	
	获取第一个 chunk
	2020-05-06T09:58:35.610061Z	 4750 Query	select  /* gh-ost `sbtest`.`t1_2500` iteration:0 */
							`id`
						from
							`sbtest`.`t1_2500`
						where ((`id` > _binary'1') or ((`id` = _binary'1'))) and ((`id` < _binary'2500') or ((`id` = _binary'2500')))
						order by
							`id` asc
						limit 1
						offset 999
						
	2020-05-06T09:58:35.612424Z	 4749 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	
	
	开启事务，循环插入到目标表: 按照主键id把源表数据写入到gho结尾的表上，再提交，以及应用binlog

	2020-05-06T09:58:35.613940Z	 4750 Query	START TRANSACTION
	2020-05-06T09:58:35.614610Z	 4750 Query	SET SESSION time_zone = 'SYSTEM', sql_mode = CONCAT(@@session.sql_mode, ',,NO_AUTO_VALUE_ON_ZERO,STRICT_ALL_TABLES')
	
	insert /* gh-ost `sbtest`.`t1_2500` */ ignore into
	2020-05-06T09:58:35.615893Z	 4750 Query	insert /* gh-ost `sbtest`.`t1_2500` */ ignore into `sbtest`.`_t1_2500_gho` (`id`)
		  (select `id` from `sbtest`.`t1_2500` force index (`PRIMARY`)
			where (((`id` > _binary'1') or ((`id` = _binary'1'))) and ((`id` < _binary'1000') or ((`id` = _binary'1000')))) lock in share mode
		  )
		  
		  
		 
	2020-05-06T09:58:35.672563Z	 4749 Query	insert /* gh-ost */ into `sbtest`.`_t1_2500_ghc`
					(id, hint, value)
				values
					(NULLIF(1, 0), 'heartbeat', '2020-05-06T17:58:35.672274457+08:00')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	2020-05-06T09:58:35.700909Z	 4743 Query	insert /* gh-ost */ into `sbtest`.`_t1_2500_ghc`
					(id, hint, value)
				values
					(NULLIF(0, 0), 'copy iteration 0 at 1588759115', 'Copy: 0/2500 0.0%; Applied: 0; Backlog: 0/1000; Time: 10s(total), 1s(copy); streamer: mysql-bin.000003:69542205; Lag: 0.14s, State: migrating; ETA: N/A')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	2020-05-06T09:58:35.706568Z	 4751 Connect	app_user@192.168.0.91 on sbtest using TCP/IP
	2020-05-06T09:58:35.707189Z	 4751 Query	SET autocommit=true
	2020-05-06T09:58:35.707907Z	 4751 Query	SET NAMES utf8mb4
	2020-05-06T09:58:35.708522Z	 4751 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	2020-05-06T09:58:35.805731Z	 4751 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	提交
	2020-05-06T09:58:35.838232Z	 4750 Query	COMMIT
	
	
	
	2020-05-06T09:58:35.851739Z	 4751 Query	insert /* gh-ost */ into `sbtest`.`_t1_2500_ghc`
					(id, hint, value)
				values
					(NULLIF(1, 0), 'heartbeat', '2020-05-06T17:58:35.849986322+08:00')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	2020-05-06T09:58:35.905606Z	 4749 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	2020-05-06T09:58:35.919946Z	 4743 Query	insert /* gh-ost */ into `sbtest`.`_t1_2500_ghc`
					(id, hint, value)
				values
					(NULLIF(1, 0), 'heartbeat', '2020-05-06T17:58:35.917432759+08:00')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	2020-05-06T09:58:35.929401Z	 4751 Quit	
	
	获取第二个chunk 
	2020-05-06T09:58:35.930082Z	 4749 Query	select  /* gh-ost `sbtest`.`t1_2500` iteration:1 */
							`id`
						from
							`sbtest`.`t1_2500`
						where ((`id` > _binary'1000')) and ((`id` < _binary'2500') or ((`id` = _binary'2500')))
						order by
							`id` asc
						limit 1
						offset 999
	2020-05-06T09:58:35.979090Z	 4750 Query	START TRANSACTION
	2020-05-06T09:58:35.979831Z	 4750 Query	SET SESSION time_zone = 'SYSTEM', sql_mode = CONCAT(@@session.sql_mode, ',,NO_AUTO_VALUE_ON_ZERO,STRICT_ALL_TABLES')
	
	开启事务，循环插入到目标表: 按照主键id把源表数据写入到gho结尾的表上，再提交，以及应用binlog

	2020-05-06T09:58:35.980362Z	 4750 Query	insert /* gh-ost `sbtest`.`t1_2500` */ ignore into `sbtest`.`_t1_2500_gho` (`id`)
		  (select `id` from `sbtest`.`t1_2500` force index (`PRIMARY`)
			where (((`id` > _binary'1000')) and ((`id` < _binary'2000') or ((`id` = _binary'2000')))) lock in share mode
		  )
		  
	2020-05-06T09:58:36.021701Z	 4749 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	2020-05-06T09:58:36.105487Z	 4749 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	2020-05-06T09:58:36.205737Z	 4749 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	2020-05-06T09:58:36.305737Z	 4749 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	2020-05-06T09:58:36.406413Z	 4749 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	2020-05-06T09:58:36.505883Z	 4749 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	2020-05-06T09:58:36.508568Z	 4743 Query	insert /* gh-ost */ into `sbtest`.`_t1_2500_ghc`
					(id, hint, value)
				values
					(NULLIF(1, 0), 'heartbeat', '2020-05-06T17:58:36.508284771+08:00')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	提交
	2020-05-06T09:58:36.541505Z	 4750 Query	COMMIT
	
	
	2020-05-06T09:58:36.580079Z	 4749 Query	insert /* gh-ost */ into `sbtest`.`_t1_2500_ghc`
					(id, hint, value)
				values
					(NULLIF(1, 0), 'heartbeat', '2020-05-06T17:58:36.579871798+08:00')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	2020-05-06T09:58:36.605569Z	 4743 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	2020-05-06T09:58:36.668775Z	 4743 Query	select  /* gh-ost `sbtest`.`t1_2500` iteration:2 */
							`id`
						from
							`sbtest`.`t1_2500`
						where ((`id` > _binary'2000')) and ((`id` < _binary'2500') or ((`id` = _binary'2500')))
						order by
							`id` asc
						limit 1
						offset 999
	2020-05-06T09:58:36.669013Z	 4750 Quit	
	2020-05-06T09:58:36.672285Z	 4749 Query	insert /* gh-ost */ into `sbtest`.`_t1_2500_ghc`
					(id, hint, value)
				values
					(NULLIF(1, 0), 'heartbeat', '2020-05-06T17:58:36.672175188+08:00')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
					
	/*
	获取第二个chunk 
	2020-05-06T09:58:35.930082Z	 4749 Query	select  /* gh-ost `sbtest`.`t1_2500` iteration:1 */
	/*
							`id`
						from
							`sbtest`.`t1_2500`
						where ((`id` > _binary'1000')) and ((`id` < _binary'2500') or ((`id` = _binary'2500')))
						order by
							`id` asc
						limit 1
						offset 999	
	*/
	
	获取第三个chunk				
	2020-05-06T09:58:36.722389Z	 4743 Query	select /* gh-ost `sbtest`.`t1_2500` iteration:2 */ `id`
					from (
						select
								`id`
							from
								`sbtest`.`t1_2500`
							where ((`id` > _binary'2000')) and ((`id` < _binary'2500') or ((`id` = _binary'2500')))
							order by
								`id` asc
							limit 1000
					) select_osc_chunk
				order by
					`id` desc
				limit 1
				
	开启事务，循环插入到目标表: 按照主键id把源表数据写入到gho结尾的表上，再提交，以及应用binlog

	2020-05-06T09:58:36.723044Z	 4743 Query	START TRANSACTION
	2020-05-06T09:58:36.723251Z	 4743 Query	SET SESSION time_zone = 'SYSTEM', sql_mode = CONCAT(@@session.sql_mode, ',,NO_AUTO_VALUE_ON_ZERO,STRICT_ALL_TABLES')
	2020-05-06T09:58:36.723573Z	 4743 Query	insert /* gh-ost `sbtest`.`t1_2500` */ ignore into `sbtest`.`_t1_2500_gho` (`id`)
		  (select `id` from `sbtest`.`t1_2500` force index (`PRIMARY`)
			where (((`id` > _binary'2000')) and ((`id` < _binary'2500') or ((`id` = _binary'2500')))) lock in share mode
		  )
	2020-05-06T09:58:36.751844Z	 4752 Connect	app_user@192.168.0.91 on sbtest using TCP/IP
	2020-05-06T09:58:36.752109Z	 4753 Connect	app_user@192.168.0.91 on sbtest using TCP/IP
	2020-05-06T09:58:36.752385Z	 4752 Query	SET autocommit=true
	2020-05-06T09:58:36.752544Z	 4753 Query	SET autocommit=true
	2020-05-06T09:58:36.752691Z	 4753 Query	SET NAMES utf8mb4
	2020-05-06T09:58:36.752897Z	 4753 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	2020-05-06T09:58:36.753113Z	 4752 Query	SET NAMES utf8mb4
	2020-05-06T09:58:36.753325Z	 4752 Query	insert /* gh-ost */ into `sbtest`.`_t1_2500_ghc`
					(id, hint, value)
				values
					(NULLIF(0, 0), 'copy iteration 2 at 1588759116', 'Copy: 2000/2500 80.0%; Applied: 0; Backlog: 0/1000; Time: 11s(total), 2s(copy); streamer: mysql-bin.000003:69555217; Lag: 0.10s, State: migrating; ETA: 0s')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	2020-05-06T09:58:36.805507Z	 4753 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	提交
	2020-05-06T09:58:36.813230Z	 4743 Query	COMMIT
	
	
	2020-05-06T09:58:36.893171Z	 4753 Query	insert /* gh-ost */ into `sbtest`.`_t1_2500_ghc`
					(id, hint, value)
				values
					(NULLIF(1, 0), 'heartbeat', '2020-05-06T17:58:36.892616199+08:00')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	2020-05-06T09:58:36.905947Z	 4749 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	2020-05-06T09:58:36.996464Z	 4749 Query	select  /* gh-ost `sbtest`.`t1_2500` iteration:3 */
							`id`
						from
							`sbtest`.`t1_2500`
						where ((`id` > _binary'2500')) and ((`id` < _binary'2500') or ((`id` = _binary'2500')))
						order by
							`id` asc
						limit 1
						offset 999
	2020-05-06T09:58:36.998836Z	 4752 Query	select /* gh-ost `sbtest`.`t1_2500` iteration:3 */ `id`
					from (
						select
								`id`
							from
								`sbtest`.`t1_2500`
							where ((`id` > _binary'2500')) and ((`id` < _binary'2500') or ((`id` = _binary'2500')))
							order by
								`id` asc
							limit 1000
					) select_osc_chunk
				order by
					`id` desc
				limit 1
	2020-05-06T09:58:36.999984Z	 4743 Quit	
	2020-05-06T09:58:37.005743Z	 4749 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	2020-05-06T09:58:37.038801Z	 4749 Query	insert /* gh-ost */ into `sbtest`.`_t1_2500_ghc`
					(id, hint, value)
				values
					(NULLIF(0, 0), 'copy iteration 3 at 1588759117', 'Copy: 2500/2500 100.0%; Applied: 0; Backlog: 0/1000; Time: 11s(total), 2s(copy); streamer: mysql-bin.000003:69558862; Lag: 0.33s, State: migrating; ETA: due')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	2020-05-06T09:58:37.074585Z	 4752 Query	insert /* gh-ost */ into `sbtest`.`_t1_2500_ghc`
					(id, hint, value)
				values
					(NULLIF(1, 0), 'heartbeat', '2020-05-06T17:58:37.074119456+08:00')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	2020-05-06T09:58:37.105577Z	 4753 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	
	
	思考: 哪一个步骤是把数据写入 _t1_2500_del 表中
	
	cut-over阶段
	
	2020-05-06T09:58:37.177252Z	 4753 Query	START TRANSACTION
	2020-05-06T09:58:37.178875Z	 4753 Query	select connection_id()
	2020-05-06T09:58:37.179405Z	 4753 Query	select get_lock('gh-ost.4753.lock', 0)
	2020-05-06T09:58:37.179842Z	 4753 Query	set session lock_wait_timeout:=6
	
	创建 _t1_2500_del 表
	2020-05-06T09:58:37.180554Z	 4749 Query	show /* gh-ost */ table status from `sbtest` like '_t1_2500_del'
	2020-05-06T09:58:37.183732Z	 4749 Query	create /* gh-ost */ table `sbtest`.`_t1_2500_del` (
				id int auto_increment primary key
			) engine=InnoDB comment='ghost-cut-over-sentry'
	2020-05-06T09:58:37.206015Z	 4754 Connect	app_user@192.168.0.91 on sbtest using TCP/IP
	2020-05-06T09:58:37.206684Z	 4754 Query	SET autocommit=true
	2020-05-06T09:58:37.206909Z	 4754 Query	SET NAMES utf8mb4

	lock源表
	2020-05-06T09:58:37.421282Z	 4753 Query	lock /* gh-ost */ tables `sbtest`.`t1_2500` write, `sbtest`.`_t1_2500_del` write
	
	
	cut-over阶段
	2020-05-06T09:58:38.049538Z	 4752 Query	START TRANSACTION
	2020-05-06T09:58:38.050813Z	 4752 Query	select connection_id()
	2020-05-06T09:58:38.051498Z	 4752 Query	set session lock_wait_timeout:=3
	rename表：rename源表 to 源_del表，_gho表 to 源表。
	2020-05-06T09:58:38.052025Z	 4752 Query	rename /* gh-ost */ table `sbtest`.`t1_2500` to `sbtest`.`_t1_2500_del`, `sbtest`.`_t1_2500_gho` to `sbtest`.`t1_2500`
	
	2020-05-06T09:58:38.052702Z	 4754 Query	select id
				from information_schema.processlist
				where
					id != connection_id()
					and 4752 in (0, id)
					and state like concat('%', 'metadata lock', '%')
					and info  like concat('%', 'rename', '%')
					
	2020-05-06T09:58:38.073019Z	 4755 Connect	app_user@192.168.0.91 on sbtest using TCP/IP
	2020-05-06T09:58:38.073690Z	 4755 Query	SET NAMES utf8mb4
	2020-05-06T09:58:38.074008Z	 4755 Query	SET autocommit=true
	2020-05-06T09:58:38.074506Z	 4755 Query	insert /* gh-ost */ into `sbtest`.`_t1_2500_ghc`
					(id, hint, value)
				values
					(NULLIF(1, 0), 'heartbeat', '2020-05-06T17:58:38.072252297+08:00')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	2020-05-06T09:58:38.106316Z	 4756 Connect	app_user@192.168.0.91 on sbtest using TCP/IP
	2020-05-06T09:58:38.106938Z	 4756 Query	SET autocommit=true
	2020-05-06T09:58:38.107340Z	 4756 Query	SET NAMES utf8mb4
	2020-05-06T09:58:38.107818Z	 4756 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	2020-05-06T09:58:38.205595Z	 4756 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	2020-05-06T09:58:38.305768Z	 4756 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	2020-05-06T09:58:38.326078Z	 4756 Query	select is_used_lock('gh-ost.4753.lock')
	
	drop _t1_2500_del 表
	2020-05-06T09:58:38.326612Z	 4753 Query	drop /* gh-ost */ table if exists `sbtest`.`_t1_2500_del`
	2020-05-06T09:58:38.405974Z	 4754 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	2020-05-06T09:58:38.410315Z	 4755 Quit	
	2020-05-06T09:58:38.411985Z	 4756 Query	insert /* gh-ost */ into `sbtest`.`_t1_2500_ghc`
					(id, hint, value)
				values
					(NULLIF(1, 0), 'heartbeat', '2020-05-06T17:58:38.410219183+08:00')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	2020-05-06T09:58:38.505929Z	 4754 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	2020-05-06T09:58:38.605462Z	 4754 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	解锁
	2020-05-06T09:58:38.662140Z	 4753 Query	unlock tables
	
	2020-05-06T09:58:38.664175Z	 4753 Query	ROLLBACK
	
	
	2020-05-06T09:58:38.684723Z	 4756 Quit	
	2020-05-06T09:58:38.685256Z	 4754 Query	insert /* gh-ost */ into `sbtest`.`_t1_2500_ghc`
					(id, hint, value)
				values
					(NULLIF(1, 0), 'heartbeat', '2020-05-06T17:58:38.68420369+08:00')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	2020-05-06T09:58:38.696673Z	 4753 Query	insert /* gh-ost */ into `sbtest`.`_t1_2500_ghc`
					(id, hint, value)
				values
					(NULLIF(0, 0), 'copy iteration 3 at 1588759118', 'Copy: 2500/2500 100.0%; Applied: 0; Backlog: 0/1000; Time: 13s(total), 2s(copy); streamer: mysql-bin.000003:69567012; Lag: 0.59s, State: migrating; ETA: due')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	2020-05-06T09:58:38.705768Z	 4757 Connect	app_user@192.168.0.91 on sbtest using TCP/IP
	2020-05-06T09:58:38.706690Z	 4757 Query	SET autocommit=true
	2020-05-06T09:58:38.707208Z	 4757 Query	SET NAMES utf8mb4
	2020-05-06T09:58:38.707366Z	 4757 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	2020-05-06T09:58:38.726978Z	 4753 Quit	
	2020-05-06T09:58:38.772318Z	 4757 Query	insert /* gh-ost */ into `sbtest`.`_t1_2500_ghc`
					(id, hint, value)
				values
					(NULLIF(1, 0), 'heartbeat', '2020-05-06T17:58:38.772183272+08:00')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	2020-05-06T09:58:38.778261Z	 4754 Query	show /* gh-ost */ table status from `sbtest` like '_t1_2500_del'
	2020-05-06T09:58:38.779201Z	 4752 Query	ROLLBACK
	2020-05-06T09:58:38.805470Z	 4752 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	2020-05-06T09:58:38.905815Z	 4752 Query	select hint, value from `sbtest`.`_t1_2500_ghc` where hint = 'heartbeat' and id <= 255
	2020-05-06T09:58:38.910009Z	 4752 Query	insert /* gh-ost */ into `sbtest`.`_t1_2500_ghc`
					(id, hint, value)
				values
					(NULLIF(1, 0), 'heartbeat', '2020-05-06T17:58:38.909487301+08:00')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	2020-05-06T09:58:38.928244Z	 4757 Query	drop /* gh-ost */ table if exists `sbtest`.`_t1_2500_ghc`
	2020-05-06T09:58:38.972344Z	 4754 Query	insert /* gh-ost */ into `sbtest`.`_t1_2500_ghc`
					(id, hint, value)
				values
					(NULLIF(1, 0), 'heartbeat', '2020-05-06T17:58:38.972226375+08:00')
				on duplicate key update
					last_update=NOW(),
					value=VALUES(value)
	2020-05-06T09:58:39.001537Z	 4752 Quit	
	2020-05-06T09:58:39.001750Z	 4748 Quit	
	2020-05-06T09:58:39.001814Z	 4747 Quit	
	2020-05-06T09:58:39.003026Z	 4754 Quit	
	2020-05-06T09:58:39.013575Z	 4757 Quit	







