

1. 表结构 
2. pt-online-schema-change
3. general_log 
4. mysqlbinlog



1. 表结构 

	CREATE TABLE `t1` (
	  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
	  `age` int(10) NOT NULL,
	  `tEndTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  PRIMARY KEY (`ID`),
	  KEY `idx_age` (`age`)
	) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;


2. pt-online-schema-change
	set global general_log=1;

	time pt-online-schema-change --chunk-size-limit=20000 --no-check-replication-filters  --charset=utf8mb4 --execute --alter "add column filed_02 int(10) not null default 0 comment 'filed_02'" --user=root --password=@ly242yhn%. --host=192.168.0.242 D=test_db,t=t1
	No slaves found.  See --recursion-method if host localhost.localdomain has slaves.
	Not checking slave lag because no slaves were found and --check-slave-lag was not specified.
	*******************************************************************
	 Using the default of SSL_verify_mode of SSL_VERIFY_NONE for client
	 is deprecated! Please set SSL_verify_mode to SSL_VERIFY_PEER
	 possibly with SSL_ca_file|SSL_ca_path for verification.
	 If you really don't want to verify the certificate and keep the
	 connection open to Man-In-The-Middle attacks please set
	 SSL_verify_mode explicitly to SSL_VERIFY_NONE in your application.
	*******************************************************************
	  at /usr/bin/pt-online-schema-change line 6949.
	*******************************************************************
	 Using the default of SSL_verify_mode of SSL_VERIFY_NONE for client
	 is deprecated! Please set SSL_verify_mode to SSL_VERIFY_PEER
	 possibly with SSL_ca_file|SSL_ca_path for verification.
	 If you really don't want to verify the certificate and keep the
	 connection open to Man-In-The-Middle attacks please set
	 SSL_verify_mode explicitly to SSL_VERIFY_NONE in your application.
	*******************************************************************
	  at /usr/bin/pt-online-schema-change line 6949.

	# A software update is available:
	Operation, tries, wait:
	  analyze_table, 10, 1
	  copy_rows, 10, 0.25
	  create_triggers, 10, 1
	  drop_triggers, 10, 1
	  swap_tables, 10, 1
	  update_foreign_keys, 10, 1
	Altering `test_db`.`t1`...
	Creating new table...
	Created new table test_db._t1_new OK.
	Altering new table...
	Altered `test_db`.`_t1_new` OK.
	2021-03-01T10:27:43 Creating triggers...
	2021-03-01T10:27:43 Created triggers OK.
	2021-03-01T10:27:43 Copying approximately 7 rows...
	2021-03-01T10:27:43 Copied rows OK.
	2021-03-01T10:27:43 Analyzing new table...
	2021-03-01T10:27:43 Swapping tables...
	2021-03-01T10:27:44 Swapped original and new tables OK.
	2021-03-01T10:27:44 Dropping old table...
	2021-03-01T10:27:44 Dropped old table `test_db`.`_t1_old` OK.
	2021-03-01T10:27:44 Dropping triggers...
	2021-03-01T10:27:44 Dropped triggers OK.
	Successfully altered `test_db`.`t1`.

	real	0m9.768s
	user	0m0.179s
	sys	0m0.041s

3. general_log 

	2021-03-01T10:27:26.798019+08:00	13223 Query	SHOW STATUS
	2021-03-01T10:27:26.802291+08:00	13223 Query	SELECT QUERY_ID, SUM(DURATION) AS SUM_DURATION FROM INFORMATION_SCHEMA.PROFILING GROUP BY QUERY_ID
	2021-03-01T10:27:26.804519+08:00	13223 Query	SELECT STATE AS `状态`, ROUND(SUM(DURATION),7) AS `期间`, CONCAT(ROUND(SUM(DURATION)/0.000510*100,3), '%') AS `百分比` FROM INFORMATION_SCHEMA.PROFILING WHERE QUERY_ID=3 GROUP BY STATE ORDER BY SEQ
	2021-03-01T10:27:34.950305+08:00	13224 Connect	root@192.168.0.242 on test_db using TCP/IP
	2021-03-01T10:27:34.950536+08:00	13224 Query	/*!40101 SET NAMES "utf8mb4"*/
	2021-03-01T10:27:34.950692+08:00	13224 Query	SHOW VARIABLES LIKE 'innodb\_lock_wait_timeout'
	2021-03-01T10:27:34.951698+08:00	13224 Query	SET SESSION innodb_lock_wait_timeout=1
	2021-03-01T10:27:34.951773+08:00	13224 Query	SHOW VARIABLES LIKE 'lock\_wait_timeout'
	2021-03-01T10:27:34.952486+08:00	13224 Query	SET SESSION lock_wait_timeout=60
	2021-03-01T10:27:34.952544+08:00	13224 Query	SHOW VARIABLES LIKE 'wait\_timeout'
	2021-03-01T10:27:34.953253+08:00	13224 Query	SET SESSION wait_timeout=10000
	2021-03-01T10:27:34.953328+08:00	13224 Query	SELECT @@SQL_MODE
	2021-03-01T10:27:34.953396+08:00	13224 Query	SET @@SQL_QUOTE_SHOW_CREATE = 1/*!40101, @@SQL_MODE='NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION'*/
	2021-03-01T10:27:34.953471+08:00	13224 Query	SELECT @@server_id /*!50038 , @@hostname*/
	2021-03-01T10:27:34.953972+08:00	13225 Connect	root@192.168.0.242 on test_db using TCP/IP
	2021-03-01T10:27:34.954052+08:00	13225 Query	/*!40101 SET NAMES "utf8mb4"*/
	2021-03-01T10:27:34.954122+08:00	13225 Query	SHOW VARIABLES LIKE 'innodb\_lock_wait_timeout'
	2021-03-01T10:27:34.955036+08:00	13225 Query	SET SESSION innodb_lock_wait_timeout=1
	2021-03-01T10:27:34.955112+08:00	13225 Query	SHOW VARIABLES LIKE 'lock\_wait_timeout'
	2021-03-01T10:27:34.955827+08:00	13225 Query	SET SESSION lock_wait_timeout=60
	2021-03-01T10:27:34.955895+08:00	13225 Query	SHOW VARIABLES LIKE 'wait\_timeout'
	2021-03-01T10:27:34.956585+08:00	13225 Query	SET SESSION wait_timeout=10000
	2021-03-01T10:27:34.956637+08:00	13225 Query	SELECT @@SQL_MODE
	2021-03-01T10:27:34.956688+08:00	13225 Query	SET @@SQL_QUOTE_SHOW_CREATE = 1/*!40101, @@SQL_MODE='NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION'*/
	2021-03-01T10:27:34.956745+08:00	13225 Query	SELECT @@server_id /*!50038 , @@hostname*/
	2021-03-01T10:27:34.956870+08:00	13224 Query	SHOW VARIABLES LIKE 'wsrep_on'
	2021-03-01T10:27:34.957768+08:00	13224 Query	SHOW VARIABLES LIKE 'version%'
	2021-03-01T10:27:34.958599+08:00	13224 Query	SHOW ENGINES
	2021-03-01T10:27:34.958835+08:00	13224 Query	SHOW VARIABLES LIKE 'innodb_version'
	2021-03-01T10:27:34.959870+08:00	13224 Query	SHOW VARIABLES LIKE 'innodb_stats_persistent'
	2021-03-01T10:27:34.960671+08:00	13224 Query	SELECT @@SERVER_ID
	2021-03-01T10:27:34.960760+08:00	13224 Query	SHOW GRANTS FOR CURRENT_USER()
	2021-03-01T10:27:34.969450+08:00	13224 Query	SHOW FULL PROCESSLIST
	2021-03-01T10:27:34.969717+08:00	13224 Query	SHOW SLAVE HOSTS
	2021-03-01T10:27:34.969998+08:00	13224 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
	2021-03-01T10:27:34.970623+08:00	13224 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
	2021-03-01T10:27:34.971237+08:00	13224 Query	SELECT CONCAT(@@hostname, @@port)
	2021-03-01T10:27:36.981707+08:00	13224 Query	SHOW VARIABLES
	2021-03-01T10:27:38.934915+08:00	13224 Query	SHOW TABLES FROM `test_db` LIKE 't1'
	2021-03-01T10:27:38.935380+08:00	13224 Query	SELECT VERSION()
	2021-03-01T10:27:38.935585+08:00	13224 Query	SHOW TRIGGERS FROM `test_db` LIKE 't1'
	2021-03-01T10:27:38.936306+08:00	13224 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
	2021-03-01T10:27:38.936455+08:00	13224 Query	USE `test_db`
	2021-03-01T10:27:38.936621+08:00	13224 Query	SHOW CREATE TABLE `test_db`.`t1`
	2021-03-01T10:27:38.936906+08:00	13224 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
	2021-03-01T10:27:38.980552+08:00	13224 Query	EXPLAIN SELECT * FROM `test_db`.`t1` WHERE 1=1
	2021-03-01T10:27:38.981928+08:00	13224 Query	SELECT table_schema, table_name FROM information_schema.key_column_usage WHERE referenced_table_schema='test_db' AND referenced_table_name='t1'
	2021-03-01T10:27:42.492231+08:00	13224 Query	SHOW VARIABLES LIKE 'wsrep_on'
	2021-03-01T10:27:42.493440+08:00	13224 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
	2021-03-01T10:27:42.493514+08:00	13224 Query	USE `test_db`
	2021-03-01T10:27:42.493595+08:00	13224 Query	SHOW CREATE TABLE `test_db`.`t1`
	2021-03-01T10:27:42.493720+08:00	13224 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
	2021-03-01T10:27:42.493859+08:00	13224 Query	CREATE TABLE `test_db`.`_t1_new` (
	  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
	  `age` int(10) NOT NULL,
	  `tEndTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  PRIMARY KEY (`ID`),
	  KEY `idx_age` (`age`)
	) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4
	-- 如果这里是实时写入的呢？
	-- 做下实验。
	
	-- 只在新表建加字段。
	2021-03-01T10:27:42.793253+08:00	13224 Query	ALTER TABLE `test_db`.`_t1_new` add column filed_02 int(10) not null default 0 comment 'filed_02'

	2021-03-01T10:27:43.318687+08:00	13224 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
	2021-03-01T10:27:43.318845+08:00	13224 Query	USE `test_db`
	2021-03-01T10:27:43.319005+08:00	13224 Query	SHOW CREATE TABLE `test_db`.`_t1_new`
	2021-03-01T10:27:43.319196+08:00	13224 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
	2021-03-01T10:27:43.319807+08:00	13224 Query	SELECT TRIGGER_SCHEMA, TRIGGER_NAME, DEFINER, ACTION_STATEMENT, SQL_MODE,        CHARACTER_SET_CLIENT, COLLATION_CONNECTION, EVENT_MANIPULATION, ACTION_TIMING   FROM INFORMATION_SCHEMA.TRIGGERS  WHERE EVENT_MANIPULATION = 'DELETE'    AND ACTION_TIMING = 'AFTER'    AND TRIGGER_SCHEMA = 'test_db'    AND EVENT_OBJECT_TABLE = 't1'
	2021-03-01T10:27:43.320381+08:00	13224 Query	SELECT TRIGGER_SCHEMA, TRIGGER_NAME, DEFINER, ACTION_STATEMENT, SQL_MODE,        CHARACTER_SET_CLIENT, COLLATION_CONNECTION, EVENT_MANIPULATION, ACTION_TIMING   FROM INFORMATION_SCHEMA.TRIGGERS  WHERE EVENT_MANIPULATION = 'UPDATE'    AND ACTION_TIMING = 'AFTER'    AND TRIGGER_SCHEMA = 'test_db'    AND EVENT_OBJECT_TABLE = 't1'
	2021-03-01T10:27:43.320798+08:00	13224 Query	SELECT TRIGGER_SCHEMA, TRIGGER_NAME, DEFINER, ACTION_STATEMENT, SQL_MODE,        CHARACTER_SET_CLIENT, COLLATION_CONNECTION, EVENT_MANIPULATION, ACTION_TIMING   FROM INFORMATION_SCHEMA.TRIGGERS  WHERE EVENT_MANIPULATION = 'INSERT'    AND ACTION_TIMING = 'AFTER'    AND TRIGGER_SCHEMA = 'test_db'    AND EVENT_OBJECT_TABLE = 't1'
	2021-03-01T10:27:43.321218+08:00	13224 Query	SELECT TRIGGER_SCHEMA, TRIGGER_NAME, DEFINER, ACTION_STATEMENT, SQL_MODE,        CHARACTER_SET_CLIENT, COLLATION_CONNECTION, EVENT_MANIPULATION, ACTION_TIMING   FROM INFORMATION_SCHEMA.TRIGGERS  WHERE EVENT_MANIPULATION = 'DELETE'    AND ACTION_TIMING = 'BEFORE'    AND TRIGGER_SCHEMA = 'test_db'    AND EVENT_OBJECT_TABLE = 't1'
	2021-03-01T10:27:43.321615+08:00	13224 Query	SELECT TRIGGER_SCHEMA, TRIGGER_NAME, DEFINER, ACTION_STATEMENT, SQL_MODE,        CHARACTER_SET_CLIENT, COLLATION_CONNECTION, EVENT_MANIPULATION, ACTION_TIMING   FROM INFORMATION_SCHEMA.TRIGGERS  WHERE EVENT_MANIPULATION = 'UPDATE'    AND ACTION_TIMING = 'BEFORE'    AND TRIGGER_SCHEMA = 'test_db'    AND EVENT_OBJECT_TABLE = 't1'
	2021-03-01T10:27:43.322037+08:00	13224 Query	SELECT TRIGGER_SCHEMA, TRIGGER_NAME, DEFINER, ACTION_STATEMENT, SQL_MODE,        CHARACTER_SET_CLIENT, COLLATION_CONNECTION, EVENT_MANIPULATION, ACTION_TIMING   FROM INFORMATION_SCHEMA.TRIGGERS  WHERE EVENT_MANIPULATION = 'INSERT'    AND ACTION_TIMING = 'BEFORE'    AND TRIGGER_SCHEMA = 'test_db'    AND EVENT_OBJECT_TABLE = 't1'
	2021-03-01T10:27:43.322455+08:00	13224 Query	CREATE TRIGGER `pt_osc_test_db_t1_del` AFTER DELETE ON `test_db`.`t1` FOR EACH ROW DELETE IGNORE FROM `test_db`.`_t1_new` WHERE `test_db`.`_t1_new`.`id` <=> OLD.`id`
	2021-03-01T10:27:43.443939+08:00	13224 Query	CREATE TRIGGER `pt_osc_test_db_t1_upd` AFTER UPDATE ON `test_db`.`t1` FOR EACH ROW BEGIN DELETE IGNORE FROM `test_db`.`_t1_new` WHERE !(OLD.`id` <=> NEW.`id`) AND `test_db`.`_t1_new`.`id` <=> OLD.`id`;REPLACE INTO `test_db`.`_t1_new` (`id`, `age`, `tendtime`) VALUES (NEW.`id`, NEW.`age`, NEW.`tendtime`);END
	2021-03-01T10:27:43.569102+08:00	13224 Query	CREATE TRIGGER `pt_osc_test_db_t1_ins` AFTER INSERT ON `test_db`.`t1` FOR EACH ROW REPLACE INTO `test_db`.`_t1_new` (`id`, `age`, `tendtime`) VALUES (NEW.`id`, NEW.`age`, NEW.`tendtime`)
	2021-03-01T10:27:43.694662+08:00	13224 Query	EXPLAIN SELECT * FROM `test_db`.`t1` WHERE 1=1
	2021-03-01T10:27:43.695831+08:00	13224 Query	EXPLAIN SELECT `id`, `age`, `tendtime` FROM `test_db`.`t1` LOCK IN SHARE MODE /*explain pt-online-schema-change 14408 copy table*/
	2021-03-01T10:27:43.696275+08:00	13224 Query	INSERT LOW_PRIORITY IGNORE INTO `test_db`.`_t1_new` (`id`, `age`, `tendtime`) SELECT `id`, `age`, `tendtime` FROM `test_db`.`t1` LOCK IN SHARE MODE /*pt-online-schema-change 14408 copy table*/
	2021-03-01T10:27:43.736346+08:00	13224 Query	SHOW WARNINGS
	2021-03-01T10:27:43.737327+08:00	13224 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
	2021-03-01T10:27:43.741646+08:00	13224 Query	ANALYZE TABLE `test_db`.`_t1_new` /* pt-online-schema-change */
	2021-03-01T10:27:43.778228+08:00	13224 Query	RENAME TABLE `test_db`.`t1` TO `test_db`.`_t1_old`, `test_db`.`_t1_new` TO `test_db`.`t1`
	2021-03-01T10:27:44.153087+08:00	13224 Query	DROP TABLE IF EXISTS `test_db`.`_t1_old`
	2021-03-01T10:27:44.345072+08:00	13224 Query	DROP TRIGGER IF EXISTS `test_db`.`pt_osc_test_db_t1_del`
	2021-03-01T10:27:44.386688+08:00	13224 Query	DROP TRIGGER IF EXISTS `test_db`.`pt_osc_test_db_t1_upd`
	2021-03-01T10:27:44.428681+08:00	13224 Query	DROP TRIGGER IF EXISTS `test_db`.`pt_osc_test_db_t1_ins`
	2021-03-01T10:27:44.470640+08:00	13224 Query	SHOW TABLES FROM `test_db` LIKE '\_t1\_new'
	2021-03-01T10:27:44.471980+08:00	13225 Quit	
	2021-03-01T10:27:44.472197+08:00	13224 Quit	



4. mysqlbinlog
	mysqlbinlog --no-defaults -vv --base64-output=decode-rows  mysql-bin.000055  > mysqlbinlog_55.sql


