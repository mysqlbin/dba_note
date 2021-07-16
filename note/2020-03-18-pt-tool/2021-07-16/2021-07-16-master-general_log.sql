2021-07-16T03:48:52.371112Z	332454 Connect	pt_user@192.168.1.10 on  using TCP/IP
2021-07-16T03:48:52.371578Z	332454 Query	SHOW VARIABLES LIKE 'innodb\_lock_wait_timeout'
2021-07-16T03:48:52.373617Z	332454 Query	SET SESSION innodb_lock_wait_timeout=1
2021-07-16T03:48:52.373835Z	332454 Query	SHOW VARIABLES LIKE 'wait\_timeout'
2021-07-16T03:48:52.374961Z	332454 Query	SET SESSION wait_timeout=10000
2021-07-16T03:48:52.375123Z	332454 Query	SELECT @@SQL_MODE
2021-07-16T03:48:52.375258Z	332454 Query	SET @@SQL_QUOTE_SHOW_CREATE = 1/*!40101, @@SQL_MODE='NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION'*/
2021-07-16T03:48:52.375431Z	332454 Query	SELECT @@server_id /*!50038 , @@hostname*/
2021-07-16T03:48:52.375600Z	332454 Query	SELECT @@SQL_MODE
2021-07-16T03:48:52.375757Z	332454 Query	SET SQL_MODE='NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION'
2021-07-16T03:48:52.375984Z	332454 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:52.377299Z	332454 Query	SHOW ENGINES
2021-07-16T03:48:52.377760Z	332454 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:52.379113Z	332454 Query	SELECT @@binlog_format
2021-07-16T03:48:52.379264Z	332454 Query	/*!50108 SET @@binlog_format := 'STATEMENT'*/
2021-07-16T03:48:52.379375Z	332454 Query	SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ
2021-07-16T03:48:52.379587Z	332454 Query	SHOW /*!40103 GLOBAL*/ VARIABLES
2021-07-16T03:48:52.381584Z	332454 Query	SELECT VERSION()
2021-07-16T03:48:52.381937Z	332454 Query	SHOW ENGINES
2021-07-16T03:48:52.382459Z	332454 Query	SHOW VARIABLES LIKE 'wsrep_on'
2021-07-16T03:48:52.383778Z	332454 Query	SELECT @@SERVER_ID
2021-07-16T03:48:52.383983Z	332454 Query	SHOW GRANTS FOR CURRENT_USER()
2021-07-16T03:48:52.384190Z	332454 Query	SHOW FULL PROCESSLIST
2021-07-16T03:48:52.407292Z	332454 Query	SHOW VARIABLES LIKE 'wsrep_on'
2021-07-16T03:48:52.408949Z	332454 Query	SELECT @@SERVER_ID
2021-07-16T03:48:52.411848Z	332454 Query	SHOW VARIABLES LIKE 'wsrep_on'
2021-07-16T03:48:52.413244Z	332454 Query	SELECT @@SERVER_ID
2021-07-16T03:48:52.417201Z	332454 Query	SHOW DATABASES LIKE 'consistency_db'
2021-07-16T03:48:52.417679Z	332454 Query	CREATE DATABASE IF NOT EXISTS `consistency_db` /* pt-table-checksum */
2021-07-16T03:48:52.419696Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:52.419917Z	332454 Query	SHOW TABLES FROM `consistency_db` LIKE 'checksums'
2021-07-16T03:48:52.422380Z	332454 Query	CREATE TABLE IF NOT EXISTS `consistency_db`.`checksums` (
     db             CHAR(64)     NOT NULL,
     tbl            CHAR(64)     NOT NULL,
     chunk          INT          NOT NULL,
     chunk_time     FLOAT            NULL,
     chunk_index    VARCHAR(200)     NULL,
     lower_boundary TEXT             NULL,
     upper_boundary TEXT             NULL,
     this_crc       CHAR(40)     NOT NULL,
     this_cnt       INT          NOT NULL,
     master_crc     CHAR(40)         NULL,
     master_cnt     INT              NULL,
     ts             TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
     PRIMARY KEY (db, tbl, chunk),
     INDEX ts_db_tbl (ts, db, tbl)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8
2021-07-16T03:48:52.425772Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:52.427310Z	332454 Query	SELECT CONCAT(@@hostname, @@port)
2021-07-16T03:48:52.428590Z	332454 Query	SELECT CRC32('test-string')
2021-07-16T03:48:52.428850Z	332454 Query	SELECT CRC32('a')
2021-07-16T03:48:52.429023Z	332454 Query	SELECT CRC32('a')
2021-07-16T03:48:52.429231Z	332454 Query	SHOW VARIABLES LIKE 'wsrep_on'
2021-07-16T03:48:52.430783Z	332454 Query	SHOW DATABASES
2021-07-16T03:48:52.431288Z	332454 Query	SHOW /*!50002 FULL*/ TABLES FROM `niuniuh5_db`
2021-07-16T03:48:52.447400Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:52.447666Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.447957Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`accountinfo`
2021-07-16T03:48:52.448843Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:52.449946Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`accountinfo` WHERE 1=1
2021-07-16T03:48:52.458829Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:52.459058Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'accountinfo'
2021-07-16T03:48:52.462836Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.463218Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `accountid`, convert(`enterpriseid` using utf8mb4), convert(`treecode` using utf8mb4), `accounttype`, convert(`accountname` using utf8mb4), convert(`password` using utf8mb4), convert(`realname` using utf8mb4), convert(`phone` using utf8mb4), convert(`qq` using utf8mb4), convert(`email` using utf8mb4), `status`, UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`updatetime`), UNIX_TIMESTAMP(`logintime`), convert(`logintoken` using utf8mb4), convert(`extendcode` using utf8mb4), convert(`ip` using utf8mb4), CONCAT(ISNULL(`realname`), ISNULL(`phone`), ISNULL(`qq`), ISNULL(`email`), ISNULL(`updatetime`), ISNULL(`logintime`), ISNULL(`logintoken`), ISNULL(`extendcode`), ISNULL(`ip`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`accountinfo` /*explain checksum table*/
2021-07-16T03:48:52.463865Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'accountinfo', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `accountid`, convert(`enterpriseid` using utf8mb4), convert(`treecode` using utf8mb4), `accounttype`, convert(`accountname` using utf8mb4), convert(`password` using utf8mb4), convert(`realname` using utf8mb4), convert(`phone` using utf8mb4), convert(`qq` using utf8mb4), convert(`email` using utf8mb4), `status`, UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`updatetime`), UNIX_TIMESTAMP(`logintime`), convert(`logintoken` using utf8mb4), convert(`extendcode` using utf8mb4), convert(`ip` using utf8mb4), CONCAT(ISNULL(`realname`), ISNULL(`phone`), ISNULL(`qq`), ISNULL(`email`), ISNULL(`updatetime`), ISNULL(`logintime`), ISNULL(`logintoken`), ISNULL(`extendcode`), ISNULL(`ip`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`accountinfo` /*checksum table*/
2021-07-16T03:48:52.467424Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:52.467762Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'accountinfo' AND chunk = '1'
2021-07-16T03:48:52.468070Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003665', master_crc = '734880f9', master_cnt = '55' WHERE db = 'niuniuh5_db' AND tbl = 'accountinfo' AND chunk = '1'
2021-07-16T03:48:52.473233Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:52.474542Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:52.484806Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:52.484984Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.485222Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`accountinrole`
2021-07-16T03:48:52.485899Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:52.486744Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`accountinrole` WHERE 1=1
2021-07-16T03:48:52.494470Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:52.494696Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'accountinrole'
2021-07-16T03:48:52.497936Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.498322Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, convert(`enterpriseid` using utf8mb4), convert(`treecode` using utf8mb4), `accountid`, `roleid`, `status`, UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`updatetime`), CONCAT(ISNULL(`updatetime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`accountinrole` /*explain checksum table*/
2021-07-16T03:48:52.498833Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'accountinrole', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, convert(`enterpriseid` using utf8mb4), convert(`treecode` using utf8mb4), `accountid`, `roleid`, `status`, UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`updatetime`), CONCAT(ISNULL(`updatetime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`accountinrole` /*checksum table*/
2021-07-16T03:48:52.501568Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:52.501930Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'accountinrole' AND chunk = '1'
2021-07-16T03:48:52.502231Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.002759', master_crc = 'ccb045fe', master_cnt = '11' WHERE db = 'niuniuh5_db' AND tbl = 'accountinrole' AND chunk = '1'
2021-07-16T03:48:52.507374Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:52.508668Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:52.518547Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:52.518726Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.518940Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`accountorroleinrule`
2021-07-16T03:48:52.519559Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:52.520349Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`accountorroleinrule` WHERE 1=1
2021-07-16T03:48:52.528386Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:52.528577Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'accountorroleinrule'
2021-07-16T03:48:52.532240Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.532584Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, convert(`enterpriseid` using utf8mb4), convert(`treecode` using utf8mb4), `accountorroleid`, `ruleid`, `relationtype`, `status`, UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`updatetime`), CONCAT(ISNULL(`updatetime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`accountorroleinrule` /*explain checksum table*/
2021-07-16T03:48:52.533115Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'accountorroleinrule', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, convert(`enterpriseid` using utf8mb4), convert(`treecode` using utf8mb4), `accountorroleid`, `ruleid`, `relationtype`, `status`, UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`updatetime`), CONCAT(ISNULL(`updatetime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`accountorroleinrule` /*checksum table*/
2021-07-16T03:48:52.536467Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:52.536833Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'accountorroleinrule' AND chunk = '1'
2021-07-16T03:48:52.537144Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003365', master_crc = '3d18448', master_cnt = '120' WHERE db = 'niuniuh5_db' AND tbl = 'accountorroleinrule' AND chunk = '1'
2021-07-16T03:48:52.542182Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:52.543494Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:52.553558Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:52.553738Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.553919Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`admin_ipapilib`
2021-07-16T03:48:52.554594Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:52.555384Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`admin_ipapilib` WHERE 1=1
2021-07-16T03:48:52.563292Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:52.563485Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'admin_ipapilib'
2021-07-16T03:48:52.567078Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.567416Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, convert(`ipaddress` using utf8mb4), convert(`remark` using utf8mb4), `userid`, `nclubid`, `createuserid`, `valid`, UNIX_TIMESTAMP(`createtime`), CONCAT(ISNULL(`remark`), ISNULL(`createtime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`admin_ipapilib` /*explain checksum table*/
2021-07-16T03:48:52.567972Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'admin_ipapilib', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, convert(`ipaddress` using utf8mb4), convert(`remark` using utf8mb4), `userid`, `nclubid`, `createuserid`, `valid`, UNIX_TIMESTAMP(`createtime`), CONCAT(ISNULL(`remark`), ISNULL(`createtime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`admin_ipapilib` /*checksum table*/
2021-07-16T03:48:52.571142Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:52.571457Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'admin_ipapilib' AND chunk = '1'
2021-07-16T03:48:52.571760Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003200', master_crc = 'ba8f61f4', master_cnt = '2' WHERE db = 'niuniuh5_db' AND tbl = 'admin_ipapilib' AND chunk = '1'
2021-07-16T03:48:52.576998Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:52.578282Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:52.587896Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:52.588062Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.588241Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`admin_iplib`
2021-07-16T03:48:52.588609Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:52.589350Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`admin_iplib` WHERE 1=1
2021-07-16T03:48:52.597124Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:52.597303Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'admin_iplib'
2021-07-16T03:48:52.600676Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.601030Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, convert(`ipaddress` using utf8mb4), convert(`remark` using utf8mb4), `userid`, `createuserid`, `valid`, UNIX_TIMESTAMP(`createtime`), CONCAT(ISNULL(`remark`), ISNULL(`createtime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`admin_iplib` /*explain checksum table*/
2021-07-16T03:48:52.601540Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'admin_iplib', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, convert(`ipaddress` using utf8mb4), convert(`remark` using utf8mb4), `userid`, `createuserid`, `valid`, UNIX_TIMESTAMP(`createtime`), CONCAT(ISNULL(`remark`), ISNULL(`createtime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`admin_iplib` /*checksum table*/
2021-07-16T03:48:52.605186Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:52.605505Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'admin_iplib' AND chunk = '1'
2021-07-16T03:48:52.605802Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003671', master_crc = '2b5cfc1e', master_cnt = '365' WHERE db = 'niuniuh5_db' AND tbl = 'admin_iplib' AND chunk = '1'
2021-07-16T03:48:52.611252Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:52.612509Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:52.622669Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:52.622859Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.623031Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`admin_log`
2021-07-16T03:48:52.623363Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:52.624176Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`admin_log` WHERE 1=1
2021-07-16T03:48:52.632052Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:52.632238Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'admin_log'
2021-07-16T03:48:52.635733Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.636061Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `type`, `userid`, `targetid`, `amount`, convert(`des` using utf8mb4), UNIX_TIMESTAMP(`createtime`), CONCAT(ISNULL(`nclubid`), ISNULL(`type`), ISNULL(`userid`), ISNULL(`targetid`), ISNULL(`amount`), ISNULL(`des`), ISNULL(`createtime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`admin_log` /*explain checksum table*/
2021-07-16T03:48:52.636607Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'admin_log', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `type`, `userid`, `targetid`, `amount`, convert(`des` using utf8mb4), UNIX_TIMESTAMP(`createtime`), CONCAT(ISNULL(`nclubid`), ISNULL(`type`), ISNULL(`userid`), ISNULL(`targetid`), ISNULL(`amount`), ISNULL(`des`), ISNULL(`createtime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`admin_log` /*checksum table*/
2021-07-16T03:48:52.645709Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:52.646071Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'admin_log' AND chunk = '1'
2021-07-16T03:48:52.646404Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.009122', master_crc = '1438d651', master_cnt = '3085' WHERE db = 'niuniuh5_db' AND tbl = 'admin_log' AND chunk = '1'
2021-07-16T03:48:52.651187Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:52.652489Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:52.662533Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:52.662701Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.662882Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`admin_module`
2021-07-16T03:48:52.663287Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:52.664164Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`admin_module` WHERE 1=1
2021-07-16T03:48:52.672373Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:52.672579Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'admin_module'
2021-07-16T03:48:52.675700Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.676033Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `moduleid`, `modulepid`, convert(`modulename` using utf8mb4), `moduletype`, convert(`modulepagepath` using utf8mb4), convert(`moduleclassname` using utf8mb4), `valid`, convert(`des` using utf8mb4), `modulesortid`, UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`modifytime`), `systype`, `buttontype`, CONCAT(ISNULL(`moduletype`), ISNULL(`modulepagepath`), ISNULL(`moduleclassname`), ISNULL(`valid`), ISNULL(`des`), ISNULL(`modulesortid`), ISNULL(`createtime`), ISNULL(`modifytime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`admin_module` /*explain checksum table*/
2021-07-16T03:48:52.676589Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'admin_module', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `moduleid`, `modulepid`, convert(`modulename` using utf8mb4), `moduletype`, convert(`modulepagepath` using utf8mb4), convert(`moduleclassname` using utf8mb4), `valid`, convert(`des` using utf8mb4), `modulesortid`, UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`modifytime`), `systype`, `buttontype`, CONCAT(ISNULL(`moduletype`), ISNULL(`modulepagepath`), ISNULL(`moduleclassname`), ISNULL(`valid`), ISNULL(`des`), ISNULL(`modulesortid`), ISNULL(`createtime`), ISNULL(`modifytime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`admin_module` /*checksum table*/
2021-07-16T03:48:52.681207Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:52.681582Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'admin_module' AND chunk = '1'
2021-07-16T03:48:52.681920Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.004665', master_crc = '9e56037a', master_cnt = '581' WHERE db = 'niuniuh5_db' AND tbl = 'admin_module' AND chunk = '1'
2021-07-16T03:48:52.687233Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:52.688469Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:52.698159Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:52.698342Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.698526Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`admin_proxy`
2021-07-16T03:48:52.698810Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:52.699790Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`admin_proxy` WHERE 1=1
2021-07-16T03:48:52.707476Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:52.707649Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'admin_proxy'
2021-07-16T03:48:52.711181Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.711560Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `userid`, `proxytype`, `userpid`, `rate`, `nplayerid`, `nclubid`, `iscreate`, `createuserid`, UNIX_TIMESTAMP(`createtime`), convert(`deskey` using utf8mb4), convert(`md5key` using utf8mb4), `nscore`, `ntype`, convert(`username` using utf8mb4), `gameproxytype`, `nlevel`, `istest`, CONCAT(ISNULL(`proxytype`), ISNULL(`nplayerid`), ISNULL(`nclubid`), ISNULL(`createtime`), ISNULL(`deskey`), ISNULL(`md5key`), ISNULL(`username`), ISNULL(`gameproxytype`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`admin_proxy` /*explain checksum table*/
2021-07-16T03:48:52.712108Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'admin_proxy', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `userid`, `proxytype`, `userpid`, `rate`, `nplayerid`, `nclubid`, `iscreate`, `createuserid`, UNIX_TIMESTAMP(`createtime`), convert(`deskey` using utf8mb4), convert(`md5key` using utf8mb4), `nscore`, `ntype`, convert(`username` using utf8mb4), `gameproxytype`, `nlevel`, `istest`, CONCAT(ISNULL(`proxytype`), ISNULL(`nplayerid`), ISNULL(`nclubid`), ISNULL(`createtime`), ISNULL(`deskey`), ISNULL(`md5key`), ISNULL(`username`), ISNULL(`gameproxytype`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`admin_proxy` /*checksum table*/
2021-07-16T03:48:52.715678Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:52.716024Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'admin_proxy' AND chunk = '1'
2021-07-16T03:48:52.716296Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003596', master_crc = 'cc6b234c', master_cnt = '101' WHERE db = 'niuniuh5_db' AND tbl = 'admin_proxy' AND chunk = '1'
2021-07-16T03:48:52.721448Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:52.722797Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:52.732508Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:52.732676Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.732879Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`admin_role`
2021-07-16T03:48:52.733580Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:52.734349Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`admin_role` WHERE 1=1
2021-07-16T03:48:52.742182Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:52.742379Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'admin_role'
2021-07-16T03:48:52.745609Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.745938Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `roleid`, convert(`rolename` using utf8mb4), `valid`, convert(`des` using utf8mb4), UNIX_TIMESTAMP(`createtime`), `systype`, `createuserid`, `userpid`, `topuserid`, CONCAT(ISNULL(`valid`), ISNULL(`des`), ISNULL(`createtime`), ISNULL(`systype`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`admin_role` /*explain checksum table*/
2021-07-16T03:48:52.746496Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'admin_role', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `roleid`, convert(`rolename` using utf8mb4), `valid`, convert(`des` using utf8mb4), UNIX_TIMESTAMP(`createtime`), `systype`, `createuserid`, `userpid`, `topuserid`, CONCAT(ISNULL(`valid`), ISNULL(`des`), ISNULL(`createtime`), ISNULL(`systype`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`admin_role` /*checksum table*/
2021-07-16T03:48:52.749665Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:52.750023Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'admin_role' AND chunk = '1'
2021-07-16T03:48:52.750316Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003222', master_crc = '25390a9c', master_cnt = '28' WHERE db = 'niuniuh5_db' AND tbl = 'admin_role' AND chunk = '1'
2021-07-16T03:48:52.755426Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:52.756784Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:52.766519Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:52.766670Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.766869Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`admin_rolemodule`
2021-07-16T03:48:52.767385Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:52.768098Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`admin_rolemodule` WHERE 1=1
2021-07-16T03:48:52.775901Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:52.776104Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'admin_rolemodule'
2021-07-16T03:48:52.779502Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.779831Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `roleid`, `moduleid`, UNIX_TIMESTAMP(`createtime`), CONCAT(ISNULL(`createtime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`admin_rolemodule` /*explain checksum table*/
2021-07-16T03:48:52.780351Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'admin_rolemodule', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `roleid`, `moduleid`, UNIX_TIMESTAMP(`createtime`), CONCAT(ISNULL(`createtime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`admin_rolemodule` /*checksum table*/
2021-07-16T03:48:52.784359Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:52.784734Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'admin_rolemodule' AND chunk = '1'
2021-07-16T03:48:52.785016Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.004031', master_crc = 'b6d85abb', master_cnt = '831' WHERE db = 'niuniuh5_db' AND tbl = 'admin_rolemodule' AND chunk = '1'
2021-07-16T03:48:52.789686Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:52.790923Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:52.800501Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:52.800675Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.800881Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`admin_user`
2021-07-16T03:48:52.801283Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:52.802229Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`admin_user` WHERE 1=1
2021-07-16T03:48:52.810454Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:52.810640Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'admin_user'
2021-07-16T03:48:52.813961Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.814296Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `userid`, `usertype`, convert(`username` using utf8mb4), convert(`userpassord` using utf8mb4), convert(`usernickname` using utf8mb4), convert(`userphone` using utf8mb4), convert(`useremail` using utf8mb4), convert(`remark` using utf8mb4), `status`, UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`lastlogintime`), CONCAT(ISNULL(`usertype`), ISNULL(`username`), ISNULL(`usernickname`), ISNULL(`userphone`), ISNULL(`useremail`), ISNULL(`remark`), ISNULL(`createtime`), ISNULL(`lastlogintime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`admin_user` /*explain checksum table*/
2021-07-16T03:48:52.814878Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'admin_user', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `userid`, `usertype`, convert(`username` using utf8mb4), convert(`userpassord` using utf8mb4), convert(`usernickname` using utf8mb4), convert(`userphone` using utf8mb4), convert(`useremail` using utf8mb4), convert(`remark` using utf8mb4), `status`, UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`lastlogintime`), CONCAT(ISNULL(`usertype`), ISNULL(`username`), ISNULL(`usernickname`), ISNULL(`userphone`), ISNULL(`useremail`), ISNULL(`remark`), ISNULL(`createtime`), ISNULL(`lastlogintime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`admin_user` /*checksum table*/
2021-07-16T03:48:52.818136Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:52.818481Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'admin_user' AND chunk = '1'
2021-07-16T03:48:52.818786Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003322', master_crc = '3f1ba3c5', master_cnt = '117' WHERE db = 'niuniuh5_db' AND tbl = 'admin_user' AND chunk = '1'
2021-07-16T03:48:52.823552Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:52.824814Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:52.834559Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:52.834793Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.835036Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`admin_usermodule`
2021-07-16T03:48:52.835628Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:52.836462Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`admin_usermodule` WHERE 1=1
2021-07-16T03:48:52.844211Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:52.844377Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'admin_usermodule'
2021-07-16T03:48:52.847504Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.847845Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `userid`, `moduleid`, UNIX_TIMESTAMP(`createtime`), CONCAT(ISNULL(`createtime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`admin_usermodule` /*explain checksum table*/
2021-07-16T03:48:52.848321Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'admin_usermodule', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `userid`, `moduleid`, UNIX_TIMESTAMP(`createtime`), CONCAT(ISNULL(`createtime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`admin_usermodule` /*checksum table*/
2021-07-16T03:48:52.851876Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:52.852239Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'admin_usermodule' AND chunk = '1'
2021-07-16T03:48:52.852543Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003585', master_crc = 'f0011bdf', master_cnt = '820' WHERE db = 'niuniuh5_db' AND tbl = 'admin_usermodule' AND chunk = '1'
2021-07-16T03:48:52.857654Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:52.858918Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:52.869055Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:52.869228Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.869408Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`admin_userrole`
2021-07-16T03:48:52.869995Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:52.870594Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`admin_userrole` WHERE 1=1
2021-07-16T03:48:52.878319Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:52.878498Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'admin_userrole'
2021-07-16T03:48:52.881962Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.882432Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `userid`, `roleid`, UNIX_TIMESTAMP(`createtime`), CONCAT(ISNULL(`createtime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`admin_userrole` /*explain checksum table*/
2021-07-16T03:48:52.882985Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'admin_userrole', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `userid`, `roleid`, UNIX_TIMESTAMP(`createtime`), CONCAT(ISNULL(`createtime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`admin_userrole` /*checksum table*/
2021-07-16T03:48:52.886114Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:52.886433Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'admin_userrole' AND chunk = '1'
2021-07-16T03:48:52.886710Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003181', master_crc = 'adaf019a', master_cnt = '56' WHERE db = 'niuniuh5_db' AND tbl = 'admin_userrole' AND chunk = '1'
2021-07-16T03:48:52.891892Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:52.893152Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:52.902665Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:52.902841Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.903002Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`admin_usersub`
2021-07-16T03:48:52.903625Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:52.904339Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`admin_usersub` WHERE 1=1
2021-07-16T03:48:52.912032Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:52.912190Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'admin_usersub'
2021-07-16T03:48:52.915316Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.915617Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `userid`, convert(`username` using utf8mb4), `userpid`, `nlevel`, UNIX_TIMESTAMP(`createtime`), CONCAT(ISNULL(`nlevel`), ISNULL(`createtime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`admin_usersub` /*explain checksum table*/
2021-07-16T03:48:52.916118Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'admin_usersub', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `userid`, convert(`username` using utf8mb4), `userpid`, `nlevel`, UNIX_TIMESTAMP(`createtime`), CONCAT(ISNULL(`nlevel`), ISNULL(`createtime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`admin_usersub` /*checksum table*/
2021-07-16T03:48:52.919108Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:52.919416Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'admin_usersub' AND chunk = '1'
2021-07-16T03:48:52.919684Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003022', master_crc = '852b596a', master_cnt = '14' WHERE db = 'niuniuh5_db' AND tbl = 'admin_usersub' AND chunk = '1'
2021-07-16T03:48:52.924742Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:52.925941Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:52.935886Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:52.936035Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.936188Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`effectivenumber_daylog`
2021-07-16T03:48:52.936742Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:52.937533Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`effectivenumber_daylog` WHERE 1=1
2021-07-16T03:48:52.945371Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:52.945522Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'effectivenumber_daylog'
2021-07-16T03:48:52.948788Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.949114Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `sum`, `mnnsum`, `mylsum`, `mslsum`, `mhxsum`, `mggsum`, `mlssum`, `mlzsum`, `mglsum`, `pbzsum`, `psysum`, UNIX_TIMESTAMP(`createtime`), `psszsum`, `mwzsum`, `pddzsum`, CONCAT(ISNULL(`sum`), ISNULL(`mnnsum`), ISNULL(`mylsum`), ISNULL(`mslsum`), ISNULL(`mhxsum`), ISNULL(`mggsum`), ISNULL(`mlssum`), ISNULL(`mlzsum`), ISNULL(`mglsum`), ISNULL(`pbzsum`), ISNULL(`psysum`), ISNULL(`createtime`), ISNULL(`psszsum`), ISNULL(`mwzsum`), ISNULL(`pddzsum`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`effectivenumber_daylog` /*explain checksum table*/
2021-07-16T03:48:52.949741Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'effectivenumber_daylog', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `sum`, `mnnsum`, `mylsum`, `mslsum`, `mhxsum`, `mggsum`, `mlssum`, `mlzsum`, `mglsum`, `pbzsum`, `psysum`, UNIX_TIMESTAMP(`createtime`), `psszsum`, `mwzsum`, `pddzsum`, CONCAT(ISNULL(`sum`), ISNULL(`mnnsum`), ISNULL(`mylsum`), ISNULL(`mslsum`), ISNULL(`mhxsum`), ISNULL(`mggsum`), ISNULL(`mlssum`), ISNULL(`mlzsum`), ISNULL(`mglsum`), ISNULL(`pbzsum`), ISNULL(`psysum`), ISNULL(`createtime`), ISNULL(`psszsum`), ISNULL(`mwzsum`), ISNULL(`pddzsum`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`effectivenumber_daylog` /*checksum table*/
2021-07-16T03:48:52.952728Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:52.953077Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'effectivenumber_daylog' AND chunk = '1'
2021-07-16T03:48:52.953368Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003055', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'effectivenumber_daylog' AND chunk = '1'
2021-07-16T03:48:52.958327Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:52.959676Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:52.969217Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:52.969369Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.969654Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`enterpricemanage`
2021-07-16T03:48:52.970244Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:52.971001Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`enterpricemanage` WHERE 1=1
2021-07-16T03:48:52.979120Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:52.979327Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'enterpricemanage'
2021-07-16T03:48:52.982111Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.982439Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, convert(`enterpriceid` using utf8mb4), `nclubid`, `nplayerid`, `nstatus`, UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`modifytime`), CONCAT(ISNULL(`modifytime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`enterpricemanage` /*explain checksum table*/
2021-07-16T03:48:52.982930Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'enterpricemanage', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, convert(`enterpriceid` using utf8mb4), `nclubid`, `nplayerid`, `nstatus`, UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`modifytime`), CONCAT(ISNULL(`modifytime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`enterpricemanage` /*checksum table*/
2021-07-16T03:48:52.985829Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:52.986111Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'enterpricemanage' AND chunk = '1'
2021-07-16T03:48:52.986390Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.002939', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'enterpricemanage' AND chunk = '1'
2021-07-16T03:48:52.991434Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:52.992705Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:53.002557Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:53.002747Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.002925Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`enterprise`
2021-07-16T03:48:53.003662Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:53.005156Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`enterprise` WHERE 1=1
2021-07-16T03:48:53.014053Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:53.014264Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'enterprise'
2021-07-16T03:48:53.017859Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.018259Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', convert(`enterpriseid` using utf8mb4), convert(`name` using utf8mb4), convert(`treecode` using utf8mb4), convert(`pid` using utf8mb4), `grade`, `accountid`, convert(`entersignature` using utf8mb4), `balancemoney`, `zmsprice`, `smsprice`, `mmsprice`, `xmsprice`, `dmsprice`, `balance`, convert(`contact` using utf8mb4), convert(`telephone` using utf8mb4), convert(`address` using utf8mb4), convert(`weixin` using utf8mb4), convert(`remark` using utf8mb4), `status`, UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`updatetime`), convert(`ipauthentication` using utf8mb4), convert(`extendcode` using utf8mb4), `groupno`, `prompt`, `nplayerid`, convert(`openid` using utf8mb4), `waitpaymoney`, `enterprisetype`, `twolevel`, `threelevel`, convert(`pageopenid` using utf8mb4), `gameplayerid`, CONCAT(ISNULL(`entersignature`), ISNULL(`zmsprice`), ISNULL(`smsprice`), ISNULL(`mmsprice`), ISNULL(`xmsprice`), ISNULL(`dmsprice`), ISNULL(`balance`), ISNULL(`contact`), ISNULL(`telephone`), ISNULL(`address`), ISNULL(`weixin`), ISNULL(`remark`), ISNULL(`ipauthentication`), ISNULL(`extendcode`), ISNULL(`groupno`), ISNULL(`prompt`), ISNULL(`nplayerid`), ISNULL(`openid`), ISNULL(`waitpaymoney`), ISNULL(`enterprisetype`), ISNULL(`twolevel`), ISNULL(`threelevel`), ISNULL(`pageopenid`), ISNULL(`gameplayerid`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`enterprise` /*explain checksum table*/
2021-07-16T03:48:53.019051Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'enterprise', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', convert(`enterpriseid` using utf8mb4), convert(`name` using utf8mb4), convert(`treecode` using utf8mb4), convert(`pid` using utf8mb4), `grade`, `accountid`, convert(`entersignature` using utf8mb4), `balancemoney`, `zmsprice`, `smsprice`, `mmsprice`, `xmsprice`, `dmsprice`, `balance`, convert(`contact` using utf8mb4), convert(`telephone` using utf8mb4), convert(`address` using utf8mb4), convert(`weixin` using utf8mb4), convert(`remark` using utf8mb4), `status`, UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`updatetime`), convert(`ipauthentication` using utf8mb4), convert(`extendcode` using utf8mb4), `groupno`, `prompt`, `nplayerid`, convert(`openid` using utf8mb4), `waitpaymoney`, `enterprisetype`, `twolevel`, `threelevel`, convert(`pageopenid` using utf8mb4), `gameplayerid`, CONCAT(ISNULL(`entersignature`), ISNULL(`zmsprice`), ISNULL(`smsprice`), ISNULL(`mmsprice`), ISNULL(`xmsprice`), ISNULL(`dmsprice`), ISNULL(`balance`), ISNULL(`contact`), ISNULL(`telephone`), ISNULL(`address`), ISNULL(`weixin`), ISNULL(`remark`), ISNULL(`ipauthentication`), ISNULL(`extendcode`), ISNULL(`groupno`), ISNULL(`prompt`), ISNULL(`nplayerid`), ISNULL(`openid`), ISNULL(`waitpaymoney`), ISNULL(`enterprisetype`), ISNULL(`twolevel`), ISNULL(`threelevel`), ISNULL(`pageopenid`), ISNULL(`gameplayerid`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`enterprise` /*checksum table*/
2021-07-16T03:48:53.022425Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:53.022835Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'enterprise' AND chunk = '1'
2021-07-16T03:48:53.023156Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003489', master_crc = '1ad58fe2', master_cnt = '41' WHERE db = 'niuniuh5_db' AND tbl = 'enterprise' AND chunk = '1'
2021-07-16T03:48:53.028203Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:53.029523Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:53.039240Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:53.039462Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.039639Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`enterpriselog`
2021-07-16T03:48:53.040263Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:53.040983Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`enterpriselog` WHERE 1=1
2021-07-16T03:48:53.048800Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:53.048976Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'enterpriselog'
2021-07-16T03:48:53.052468Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.052793Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `operatetype`, `operateplayerid`, `targetplayerid`, convert(`remark` using utf8mb4), UNIX_TIMESTAMP(`createtime`), CONCAT(ISNULL(`nclubid`), ISNULL(`operatetype`), ISNULL(`operateplayerid`), ISNULL(`targetplayerid`), ISNULL(`remark`), ISNULL(`createtime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`enterpriselog` /*explain checksum table*/
2021-07-16T03:48:53.053308Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'enterpriselog', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `operatetype`, `operateplayerid`, `targetplayerid`, convert(`remark` using utf8mb4), UNIX_TIMESTAMP(`createtime`), CONCAT(ISNULL(`nclubid`), ISNULL(`operatetype`), ISNULL(`operateplayerid`), ISNULL(`targetplayerid`), ISNULL(`remark`), ISNULL(`createtime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`enterpriselog` /*checksum table*/
2021-07-16T03:48:53.059734Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:53.060074Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'enterpriselog' AND chunk = '1'
2021-07-16T03:48:53.060382Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.006456', master_crc = '96357984', master_cnt = '1851' WHERE db = 'niuniuh5_db' AND tbl = 'enterpriselog' AND chunk = '1'
2021-07-16T03:48:53.065624Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:53.066962Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:53.076867Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:53.077083Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.077330Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`operationslog`
2021-07-16T03:48:53.078027Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:53.078910Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`operationslog` WHERE 1=1
2021-07-16T03:48:53.086787Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:53.086979Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'operationslog'
2021-07-16T03:48:53.090218Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.090560Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `operateid`, `adminid`, `otype`, CRC32(`omsg`), UNIX_TIMESTAMP(`createtime`), convert(`adminname` using utf8mb4), convert(`pkid` using utf8mb4), convert(`formobject` using utf8mb4), `availflag`, `operationstype`, convert(`enterpriseid` using utf8mb4), `gametype`, CONCAT(ISNULL(`omsg`), ISNULL(`pkid`), ISNULL(`formobject`), ISNULL(`enterpriseid`), ISNULL(`gametype`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`operationslog` /*explain checksum table*/
2021-07-16T03:48:53.091156Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'operationslog', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `operateid`, `adminid`, `otype`, CRC32(`omsg`), UNIX_TIMESTAMP(`createtime`), convert(`adminname` using utf8mb4), convert(`pkid` using utf8mb4), convert(`formobject` using utf8mb4), `availflag`, `operationstype`, convert(`enterpriseid` using utf8mb4), `gametype`, CONCAT(ISNULL(`omsg`), ISNULL(`pkid`), ISNULL(`formobject`), ISNULL(`enterpriseid`), ISNULL(`gametype`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`operationslog` /*checksum table*/
2021-07-16T03:48:53.096170Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:53.096468Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'operationslog' AND chunk = '1'
2021-07-16T03:48:53.096769Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.005080', master_crc = 'd039254f', master_cnt = '689' WHERE db = 'niuniuh5_db' AND tbl = 'operationslog' AND chunk = '1'
2021-07-16T03:48:53.101680Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:53.102940Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:53.112573Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:53.112745Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.112910Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`rechargedetail`
2021-07-16T03:48:53.113633Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:53.114825Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`rechargedetail` WHERE 1=1
2021-07-16T03:48:53.123079Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:53.123247Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'rechargedetail'
2021-07-16T03:48:53.126533Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.126999Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `type`, convert(`batchid` using utf8mb4), convert(`batchname` using utf8mb4), `price`, `msgcount`, `amount`, `opaccountid`, convert(`opaccountname` using utf8mb4), convert(`openterpriseid` using utf8mb4), convert(`openterprisetreecode` using utf8mb4), convert(`enterpriseid` using utf8mb4), convert(`enterprisetreecode` using utf8mb4), `currentbalance`, UNIX_TIMESTAMP(`createtime`), convert(`remark` using utf8mb4), convert(`usercode` using utf8mb4), `consumemoney`, convert(`orderid` using utf8mb4), `deducemoney`, `gametype`, CONCAT(ISNULL(`batchid`), ISNULL(`batchname`), ISNULL(`price`), ISNULL(`msgcount`), ISNULL(`opaccountid`), ISNULL(`opaccountname`), ISNULL(`openterpriseid`), ISNULL(`openterprisetreecode`), ISNULL(`remark`), ISNULL(`usercode`), ISNULL(`consumemoney`), ISNULL(`orderid`), ISNULL(`deducemoney`), ISNULL(`gametype`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`rechargedetail` /*explain checksum table*/
2021-07-16T03:48:53.127729Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'rechargedetail', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `type`, convert(`batchid` using utf8mb4), convert(`batchname` using utf8mb4), `price`, `msgcount`, `amount`, `opaccountid`, convert(`opaccountname` using utf8mb4), convert(`openterpriseid` using utf8mb4), convert(`openterprisetreecode` using utf8mb4), convert(`enterpriseid` using utf8mb4), convert(`enterprisetreecode` using utf8mb4), `currentbalance`, UNIX_TIMESTAMP(`createtime`), convert(`remark` using utf8mb4), convert(`usercode` using utf8mb4), `consumemoney`, convert(`orderid` using utf8mb4), `deducemoney`, `gametype`, CONCAT(ISNULL(`batchid`), ISNULL(`batchname`), ISNULL(`price`), ISNULL(`msgcount`), ISNULL(`opaccountid`), ISNULL(`opaccountname`), ISNULL(`openterpriseid`), ISNULL(`openterprisetreecode`), ISNULL(`remark`), ISNULL(`usercode`), ISNULL(`consumemoney`), ISNULL(`orderid`), ISNULL(`deducemoney`), ISNULL(`gametype`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`rechargedetail` /*checksum table*/
2021-07-16T03:48:53.130978Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:53.131390Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'rechargedetail' AND chunk = '1'
2021-07-16T03:48:53.131623Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003345', master_crc = 'e6d04b53', master_cnt = '30' WHERE db = 'niuniuh5_db' AND tbl = 'rechargedetail' AND chunk = '1'
2021-07-16T03:48:53.136792Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:53.138059Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:53.147738Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:53.147906Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.148075Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`roleinfo`
2021-07-16T03:48:53.148843Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:53.149556Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`roleinfo` WHERE 1=1
2021-07-16T03:48:53.157323Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:53.157517Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'roleinfo'
2021-07-16T03:48:53.160585Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.161079Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `roleid`, convert(`enterpriseid` using utf8mb4), convert(`treecode` using utf8mb4), convert(`rolename` using utf8mb4), convert(`describe` using utf8mb4), `status`, UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`updatetime`), CONCAT(ISNULL(`describe`), ISNULL(`updatetime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`roleinfo` /*explain checksum table*/
2021-07-16T03:48:53.161733Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'roleinfo', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `roleid`, convert(`enterpriseid` using utf8mb4), convert(`treecode` using utf8mb4), convert(`rolename` using utf8mb4), convert(`describe` using utf8mb4), `status`, UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`updatetime`), CONCAT(ISNULL(`describe`), ISNULL(`updatetime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`roleinfo` /*checksum table*/
2021-07-16T03:48:53.164975Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:53.165339Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'roleinfo' AND chunk = '1'
2021-07-16T03:48:53.165675Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003321', master_crc = '3211ff2', master_cnt = '2' WHERE db = 'niuniuh5_db' AND tbl = 'roleinfo' AND chunk = '1'
2021-07-16T03:48:53.171014Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:53.172274Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:53.181795Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:53.181975Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.182142Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`ruleinfo`
2021-07-16T03:48:53.182761Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:53.183632Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`ruleinfo` WHERE 1=1
2021-07-16T03:48:53.191504Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:53.191676Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'ruleinfo'
2021-07-16T03:48:53.195109Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.195494Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `ruleid`, `pid`, convert(`rulename` using utf8mb4), `ruletype`, convert(`describe` using utf8mb4), convert(`pagepath` using utf8mb4), convert(`btnclientclick` using utf8mb4), convert(`btnserverclick` using utf8mb4), convert(`btnicon` using utf8mb4), `datascope`, `sequeueno`, `status`, UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`updatetime`), convert(`handlepath` using utf8mb4), CONCAT(ISNULL(`describe`), ISNULL(`pagepath`), ISNULL(`btnclientclick`), ISNULL(`btnserverclick`), ISNULL(`btnicon`), ISNULL(`datascope`), ISNULL(`updatetime`), ISNULL(`handlepath`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`ruleinfo` /*explain checksum table*/
2021-07-16T03:48:53.196051Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'ruleinfo', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `ruleid`, `pid`, convert(`rulename` using utf8mb4), `ruletype`, convert(`describe` using utf8mb4), convert(`pagepath` using utf8mb4), convert(`btnclientclick` using utf8mb4), convert(`btnserverclick` using utf8mb4), convert(`btnicon` using utf8mb4), `datascope`, `sequeueno`, `status`, UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`updatetime`), convert(`handlepath` using utf8mb4), CONCAT(ISNULL(`describe`), ISNULL(`pagepath`), ISNULL(`btnclientclick`), ISNULL(`btnserverclick`), ISNULL(`btnicon`), ISNULL(`datascope`), ISNULL(`updatetime`), ISNULL(`handlepath`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`ruleinfo` /*checksum table*/
2021-07-16T03:48:53.199831Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:53.200145Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'ruleinfo' AND chunk = '1'
2021-07-16T03:48:53.200437Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003819', master_crc = '1deab261', master_cnt = '115' WHERE db = 'niuniuh5_db' AND tbl = 'ruleinfo' AND chunk = '1'
2021-07-16T03:48:53.205444Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:53.206692Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:53.216284Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:53.216426Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.216573Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`script_status`
2021-07-16T03:48:53.217149Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:53.217841Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`script_status` WHERE 1=1
2021-07-16T03:48:53.225402Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:53.225579Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'script_status'
2021-07-16T03:48:53.228598Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.228929Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, convert(`script_name` using utf8mb4), `end_point`, `status`, `end_date`, UNIX_TIMESTAMP(`start_date`), CONCAT(ISNULL(`end_date`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`script_status` /*explain checksum table*/
2021-07-16T03:48:53.229370Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'script_status', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, convert(`script_name` using utf8mb4), `end_point`, `status`, `end_date`, UNIX_TIMESTAMP(`start_date`), CONCAT(ISNULL(`end_date`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`script_status` /*checksum table*/
2021-07-16T03:48:53.232979Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:53.233293Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'script_status' AND chunk = '1'
2021-07-16T03:48:53.233552Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003614', master_crc = '2fc4a0f9', master_cnt = '1' WHERE db = 'niuniuh5_db' AND tbl = 'script_status' AND chunk = '1'
2021-07-16T03:48:53.238936Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:53.240198Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:53.249845Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:53.250004Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.250162Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`sys_code`
2021-07-16T03:48:53.250755Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:53.251468Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`sys_code` WHERE 1=1
2021-07-16T03:48:53.259133Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:53.259316Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'sys_code'
2021-07-16T03:48:53.262650Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.263011Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `code`, convert(`codename` using utf8mb4), `type`, convert(`typename` using utf8mb4), `sortid`, `valid`, CONCAT(ISNULL(`codename`), ISNULL(`typename`), ISNULL(`sortid`), ISNULL(`valid`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`sys_code` /*explain checksum table*/
2021-07-16T03:48:53.263529Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'sys_code', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `code`, convert(`codename` using utf8mb4), `type`, convert(`typename` using utf8mb4), `sortid`, `valid`, CONCAT(ISNULL(`codename`), ISNULL(`typename`), ISNULL(`sortid`), ISNULL(`valid`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`sys_code` /*checksum table*/
2021-07-16T03:48:53.267127Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:53.267497Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'sys_code' AND chunk = '1'
2021-07-16T03:48:53.267821Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003676', master_crc = '7d95d3e1', master_cnt = '396' WHERE db = 'niuniuh5_db' AND tbl = 'sys_code' AND chunk = '1'
2021-07-16T03:48:53.272952Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:53.274223Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:53.283992Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:53.284154Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.284379Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`systemlog`
2021-07-16T03:48:53.284997Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:53.285772Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`systemlog` WHERE 1=1
2021-07-16T03:48:53.293457Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:53.293633Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'systemlog'
2021-07-16T03:48:53.296538Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.296976Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `logid`, convert(`loglevel` using utf8mb4), convert(`msg` using utf8mb4), convert(`logthread` using utf8mb4), CRC32(`exception`), convert(`logger` using utf8mb4), UNIX_TIMESTAMP(`createtime`), `gametype`, CONCAT(ISNULL(`msg`), ISNULL(`logthread`), ISNULL(`exception`), ISNULL(`logger`), ISNULL(`gametype`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`systemlog` /*explain checksum table*/
2021-07-16T03:48:53.297497Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'systemlog', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `logid`, convert(`loglevel` using utf8mb4), convert(`msg` using utf8mb4), convert(`logthread` using utf8mb4), CRC32(`exception`), convert(`logger` using utf8mb4), UNIX_TIMESTAMP(`createtime`), `gametype`, CONCAT(ISNULL(`msg`), ISNULL(`logthread`), ISNULL(`exception`), ISNULL(`logger`), ISNULL(`gametype`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`systemlog` /*checksum table*/
2021-07-16T03:48:53.300460Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:53.300753Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'systemlog' AND chunk = '1'
2021-07-16T03:48:53.301016Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003043', master_crc = '84f72e84', master_cnt = '11' WHERE db = 'niuniuh5_db' AND tbl = 'systemlog' AND chunk = '1'
2021-07-16T03:48:53.305774Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:53.306970Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:53.316442Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:53.316600Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.316802Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_agent_apply`
2021-07-16T03:48:53.317517Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:53.318350Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_agent_apply` WHERE 1=1
2021-07-16T03:48:53.326417Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:53.326588Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_agent_apply'
2021-07-16T03:48:53.329712Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.330028Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `namount`, `beforepaybalance`, `afterpaybalance`, UNIX_TIMESTAMP(`applytime`), UNIX_TIMESTAMP(`approvaltime`), `nstatus`, convert(`backinfo` using utf8mb4), convert(`remarks` using utf8mb4), convert(`sztoken` using utf8mb4), CONCAT(ISNULL(`approvaltime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_agent_apply` /*explain checksum table*/
2021-07-16T03:48:53.330491Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_agent_apply', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `namount`, `beforepaybalance`, `afterpaybalance`, UNIX_TIMESTAMP(`applytime`), UNIX_TIMESTAMP(`approvaltime`), `nstatus`, convert(`backinfo` using utf8mb4), convert(`remarks` using utf8mb4), convert(`sztoken` using utf8mb4), CONCAT(ISNULL(`approvaltime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_agent_apply` /*checksum table*/
2021-07-16T03:48:53.333472Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:53.333801Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_agent_apply' AND chunk = '1'
2021-07-16T03:48:53.334061Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003039', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_agent_apply' AND chunk = '1'
2021-07-16T03:48:53.338665Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:53.339900Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:53.349429Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:53.349582Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.349754Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_agent_commission`
2021-07-16T03:48:53.350346Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:53.351149Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_agent_commission` WHERE 1=1
2021-07-16T03:48:53.359226Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:53.359386Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_agent_commission'
2021-07-16T03:48:53.362507Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.362789Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `nsubagentid`, `nsourceid`, `ntype`, `ratio`, `namount`, `nrecharge`, UNIX_TIMESTAMP(`createtime`))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_agent_commission` /*explain checksum table*/
2021-07-16T03:48:53.363264Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_agent_commission', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `nsubagentid`, `nsourceid`, `ntype`, `ratio`, `namount`, `nrecharge`, UNIX_TIMESTAMP(`createtime`))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_agent_commission` /*checksum table*/
2021-07-16T03:48:53.366129Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:53.366408Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_agent_commission' AND chunk = '1'
2021-07-16T03:48:53.366689Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.002902', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_agent_commission' AND chunk = '1'
2021-07-16T03:48:53.371907Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:53.373128Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:53.382827Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:53.382992Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.383150Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_agent_info`
2021-07-16T03:48:53.383750Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:53.384461Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_agent_info` WHERE 1=1
2021-07-16T03:48:53.392419Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:53.392577Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_agent_info'
2021-07-16T03:48:53.396049Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.396391Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `upagentid`, `nlevel`, `namount`, `ratio`, convert(`aliaccount` using utf8mb4), convert(`aliname` using utf8mb4), UNIX_TIMESTAMP(`createtime`))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_agent_info` /*explain checksum table*/
2021-07-16T03:48:53.396924Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_agent_info', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `upagentid`, `nlevel`, `namount`, `ratio`, convert(`aliaccount` using utf8mb4), convert(`aliname` using utf8mb4), UNIX_TIMESTAMP(`createtime`))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_agent_info` /*checksum table*/
2021-07-16T03:48:53.400122Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:53.400416Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_agent_info' AND chunk = '1'
2021-07-16T03:48:53.400663Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003288', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_agent_info' AND chunk = '1'
2021-07-16T03:48:53.405854Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:53.407092Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:53.416567Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:53.416745Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.416948Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_agent_tree`
2021-07-16T03:48:53.417549Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:53.418165Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_agent_tree` WHERE 1=1
2021-07-16T03:48:53.425901Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:53.426062Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_agent_tree'
2021-07-16T03:48:53.429440Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.429767Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `nnextplayerid`, UNIX_TIMESTAMP(`createtime`))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_agent_tree` /*explain checksum table*/
2021-07-16T03:48:53.430216Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_agent_tree', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `nnextplayerid`, UNIX_TIMESTAMP(`createtime`))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_agent_tree` /*checksum table*/
2021-07-16T03:48:53.433518Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:53.433846Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_agent_tree' AND chunk = '1'
2021-07-16T03:48:53.434090Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003321', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_agent_tree' AND chunk = '1'
2021-07-16T03:48:53.439087Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:53.440334Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:53.450084Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:53.450256Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.450428Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_agentgameresult`
2021-07-16T03:48:53.451029Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:53.451827Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_agentgameresult` WHERE 1=1
2021-07-16T03:48:53.459749Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:53.459910Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_agentgameresult'
2021-07-16T03:48:53.463098Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.463415Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `extendcode`, convert(`sznickname` using utf8mb4), `ntableid`, `ngameid`, `cost`, `playercount`, `round`, `gameround`, UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`modifytime`), `checkstatus`, CONCAT(ISNULL(`modifytime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_agentgameresult` /*explain checksum table*/
2021-07-16T03:48:53.463961Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_agentgameresult', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `extendcode`, convert(`sznickname` using utf8mb4), `ntableid`, `ngameid`, `cost`, `playercount`, `round`, `gameround`, UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`modifytime`), `checkstatus`, CONCAT(ISNULL(`modifytime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_agentgameresult` /*checksum table*/
2021-07-16T03:48:53.466913Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:53.467236Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_agentgameresult' AND chunk = '1'
2021-07-16T03:48:53.467502Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.002989', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_agentgameresult' AND chunk = '1'
2021-07-16T03:48:53.472417Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:53.473666Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:53.483290Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:53.483451Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.483615Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_agentrec`
2021-07-16T03:48:53.484265Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:53.485153Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_agentrec` WHERE 1=1
2021-07-16T03:48:53.493275Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:53.493442Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_agentrec'
2021-07-16T03:48:53.496930Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.497276Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `extendcode`, convert(`sznickname` using utf8mb4), `ntableid`, `ngameid`, `nmode`, `cost`, `playercount`, `round`, convert(`roominfo` using utf8mb4), `nstatus`, UNIX_TIMESTAMP(`createtime`), `endtime`, CONCAT(ISNULL(`endtime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_agentrec` /*explain checksum table*/
2021-07-16T03:48:53.497734Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_agentrec', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `extendcode`, convert(`sznickname` using utf8mb4), `ntableid`, `ngameid`, `nmode`, `cost`, `playercount`, `round`, convert(`roominfo` using utf8mb4), `nstatus`, UNIX_TIMESTAMP(`createtime`), `endtime`, CONCAT(ISNULL(`endtime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_agentrec` /*checksum table*/
2021-07-16T03:48:53.500712Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:53.501077Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_agentrec' AND chunk = '1'
2021-07-16T03:48:53.501338Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003007', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_agentrec' AND chunk = '1'
2021-07-16T03:48:53.506682Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:53.507949Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:53.517556Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:53.517732Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.517895Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_bet_inout`
2021-07-16T03:48:53.518491Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:53.519289Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_bet_inout` WHERE 1=1
2021-07-16T03:48:53.520072Z	332454 Query	SELECT /*!40001 SQL_NO_CACHE */ `id` FROM `niuniuh5_db`.`table_bet_inout` FORCE INDEX(`PRIMARY`) ORDER BY `id` LIMIT 1 /*first lower boundary*/
2021-07-16T03:48:53.526675Z	332454 Query	SELECT /*!40001 SQL_NO_CACHE */ `id` FROM `niuniuh5_db`.`table_bet_inout` FORCE INDEX (`PRIMARY`) WHERE `id` IS NOT NULL ORDER BY `id` LIMIT 1 /*key_len*/
2021-07-16T03:48:53.527006Z	332454 Query	EXPLAIN SELECT /*!40001 SQL_NO_CACHE */ * FROM `niuniuh5_db`.`table_bet_inout` FORCE INDEX (`PRIMARY`) WHERE `id` >= '1' /*key_len*/
2021-07-16T03:48:53.527382Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:53.527541Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_bet_inout'
2021-07-16T03:48:53.530815Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.531090Z	332454 Query	EXPLAIN SELECT /*!40001 SQL_NO_CACHE */ `id` FROM `niuniuh5_db`.`table_bet_inout` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '1')) ORDER BY `id` LIMIT 51645, 2 /*next chunk boundary*/
2021-07-16T03:48:53.531469Z	332454 Query	SELECT /*!40001 SQL_NO_CACHE */ `id` FROM `niuniuh5_db`.`table_bet_inout` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '1')) ORDER BY `id` LIMIT 51645, 2 /*next chunk boundary*/
2021-07-16T03:48:53.544752Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `tableid`, `ninouttype`, `namount`, `nfreeamount`, `nplayerscore`, `nplayerfreescore`, `ntablescore`, `ntablefreescore`, UNIX_TIMESTAMP(`createtime`))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_bet_inout` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '1')) AND ((`id` <= '51646')) /*explain checksum chunk*/
2021-07-16T03:48:53.545364Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_bet_inout', '1', 'PRIMARY', '1', '51646', COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `tableid`, `ninouttype`, `namount`, `nfreeamount`, `nplayerscore`, `nplayerfreescore`, `ntablescore`, `ntablefreescore`, UNIX_TIMESTAMP(`createtime`))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_bet_inout` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '1')) AND ((`id` <= '51646')) /*checksum chunk*/
2021-07-16T03:48:53.637429Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:53.637908Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_bet_inout' AND chunk = '1'
2021-07-16T03:48:53.638248Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.092035', master_crc = '30058458', master_cnt = '51646' WHERE db = 'niuniuh5_db' AND tbl = 'table_bet_inout' AND chunk = '1'
2021-07-16T03:48:53.643555Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:53.644936Z	332454 Query	EXPLAIN SELECT /*!40001 SQL_NO_CACHE */ `id` FROM `niuniuh5_db`.`table_bet_inout` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '51647')) ORDER BY `id` LIMIT 280577, 2 /*next chunk boundary*/
2021-07-16T03:48:53.645346Z	332454 Query	SELECT /*!40001 SQL_NO_CACHE */ `id` FROM `niuniuh5_db`.`table_bet_inout` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '51647')) ORDER BY `id` LIMIT 280577, 2 /*next chunk boundary*/
2021-07-16T03:48:53.696962Z	332454 Query	SELECT /*!40001 SQL_NO_CACHE */ `id` FROM `niuniuh5_db`.`table_bet_inout` FORCE INDEX(`PRIMARY`) ORDER BY `id` DESC LIMIT 1 /*last upper boundary*/
2021-07-16T03:48:53.697447Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `tableid`, `ninouttype`, `namount`, `nfreeamount`, `nplayerscore`, `nplayerfreescore`, `ntablescore`, `ntablefreescore`, UNIX_TIMESTAMP(`createtime`))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_bet_inout` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '51647')) AND ((`id` <= '278785')) /*explain checksum chunk*/
2021-07-16T03:48:53.698132Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_bet_inout', '2', 'PRIMARY', '51647', '278785', COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `tableid`, `ninouttype`, `namount`, `nfreeamount`, `nplayerscore`, `nplayerfreescore`, `ntablescore`, `ntablefreescore`, UNIX_TIMESTAMP(`createtime`))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_bet_inout` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '51647')) AND ((`id` <= '278785')) /*checksum chunk*/
2021-07-16T03:48:54.088156Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:54.088581Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_bet_inout' AND chunk = '2'
2021-07-16T03:48:54.088947Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.390014', master_crc = 'ccb13324', master_cnt = '227139' WHERE db = 'niuniuh5_db' AND tbl = 'table_bet_inout' AND chunk = '2'
2021-07-16T03:48:54.094457Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:54.095773Z	332454 Query	EXPLAIN SELECT  COUNT(*), '0' FROM `niuniuh5_db`.`table_bet_inout` FORCE INDEX(`PRIMARY`) WHERE ((`id` < '1')) ORDER BY `id` /*explain past lower chunk*/
2021-07-16T03:48:54.096266Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_bet_inout', '3', 'PRIMARY', NULL, '1', COUNT(*), '0' FROM `niuniuh5_db`.`table_bet_inout` FORCE INDEX(`PRIMARY`) WHERE ((`id` < '1')) ORDER BY `id` /*past lower chunk*/
2021-07-16T03:48:54.099391Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:54.099710Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_bet_inout' AND chunk = '3'
2021-07-16T03:48:54.099997Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003132', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_bet_inout' AND chunk = '3'
2021-07-16T03:48:54.105185Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:54.106412Z	332454 Query	EXPLAIN SELECT  COUNT(*), '0' FROM `niuniuh5_db`.`table_bet_inout` FORCE INDEX(`PRIMARY`) WHERE ((`id` > '278785')) ORDER BY `id` /*explain past upper chunk*/
2021-07-16T03:48:54.106927Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_bet_inout', '4', 'PRIMARY', '278785', NULL, COUNT(*), '0' FROM `niuniuh5_db`.`table_bet_inout` FORCE INDEX(`PRIMARY`) WHERE ((`id` > '278785')) ORDER BY `id` /*past upper chunk*/
2021-07-16T03:48:54.110207Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:54.110518Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_bet_inout' AND chunk = '4'
2021-07-16T03:48:54.110820Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003305', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_bet_inout' AND chunk = '4'
2021-07-16T03:48:54.116127Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:54.117294Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:54.496325Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:54.496552Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.496771Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_arrears`
2021-07-16T03:48:54.497441Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:54.498198Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_arrears` WHERE 1=1
2021-07-16T03:48:54.506383Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:54.506544Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_arrears'
2021-07-16T03:48:54.510538Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.510843Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `nclubid`, `namount`, `nstatus`, UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`donetime`), CONCAT(ISNULL(`donetime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_arrears` /*explain checksum table*/
2021-07-16T03:48:54.511341Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_arrears', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `nclubid`, `namount`, `nstatus`, UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`donetime`), CONCAT(ISNULL(`donetime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_arrears` /*checksum table*/
2021-07-16T03:48:54.514350Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:54.514648Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_arrears' AND chunk = '1'
2021-07-16T03:48:54.514930Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003039', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_arrears' AND chunk = '1'
2021-07-16T03:48:54.520428Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:54.521726Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:54.531708Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:54.531874Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.532037Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_cc`
2021-07-16T03:48:54.532693Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:54.533454Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_cc` WHERE 1=1
2021-07-16T03:48:54.541610Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:54.541812Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_cc'
2021-07-16T03:48:54.545382Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.545697Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ngameid`, `ncode`, `ntaxrate`, convert(`szdesc` using utf8mb4), `nstatus`, CONCAT(ISNULL(`nstatus`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_cc` /*explain checksum table*/
2021-07-16T03:48:54.546144Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_cc', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ngameid`, `ncode`, `ntaxrate`, convert(`szdesc` using utf8mb4), `nstatus`, CONCAT(ISNULL(`nstatus`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_cc` /*checksum table*/
2021-07-16T03:48:54.550204Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:54.550534Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_cc' AND chunk = '1'
2021-07-16T03:48:54.550802Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.004059', master_crc = '1280975d', master_cnt = '1018' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_cc' AND chunk = '1'
2021-07-16T03:48:54.555903Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:54.557173Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:54.567033Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:54.567186Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.567375Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_cc_code`
2021-07-16T03:48:54.567965Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:54.568564Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_cc_code` WHERE 1=1
2021-07-16T03:48:54.568968Z	332454 Query	SHOW INDEXES FROM `niuniuh5_db`.`table_club_cc_code` WHERE Key_name = 'idx_ncode'
2021-07-16T03:48:54.576626Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:54.576806Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_cc_code'
2021-07-16T03:48:54.580213Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.580505Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `ncode`, convert(`szdesc` using utf8mb4))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_cc_code` /*explain checksum table*/
2021-07-16T03:48:54.581016Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_cc_code', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `ncode`, convert(`szdesc` using utf8mb4))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_cc_code` /*checksum table*/
2021-07-16T03:48:54.584253Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:54.584544Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_cc_code' AND chunk = '1'
2021-07-16T03:48:54.584833Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003248', master_crc = '5c569dab', master_cnt = '19' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_cc_code' AND chunk = '1'
2021-07-16T03:48:54.590081Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:54.591303Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:54.600750Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:54.600924Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.601081Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_cc_low`
2021-07-16T03:48:54.601668Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:54.602375Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_cc_low` WHERE 1=1
2021-07-16T03:48:54.610271Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:54.610447Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_cc_low'
2021-07-16T03:48:54.613882Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.614201Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ngameid`, `ncode`, `ntaxrate`, convert(`szdesc` using utf8mb4), `nstatus`, CONCAT(ISNULL(`nstatus`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_cc_low` /*explain checksum table*/
2021-07-16T03:48:54.614738Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_cc_low', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ngameid`, `ncode`, `ntaxrate`, convert(`szdesc` using utf8mb4), `nstatus`, CONCAT(ISNULL(`nstatus`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_cc_low` /*checksum table*/
2021-07-16T03:48:54.618754Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:54.619090Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_cc_low' AND chunk = '1'
2021-07-16T03:48:54.619402Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.004032', master_crc = '46688422', master_cnt = '439' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_cc_low' AND chunk = '1'
2021-07-16T03:48:54.624670Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:54.625958Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:54.635939Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:54.636111Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.636287Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_custom_msg`
2021-07-16T03:48:54.636926Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:54.637578Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_custom_msg` WHERE 1=1
2021-07-16T03:48:54.645364Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:54.645525Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_custom_msg'
2021-07-16T03:48:54.649149Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.649450Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `nclubid`, convert(`szmsg` using utf8mb4), UNIX_TIMESTAMP(`createtime`))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_custom_msg` /*explain checksum table*/
2021-07-16T03:48:54.649848Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_custom_msg', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `nclubid`, convert(`szmsg` using utf8mb4), UNIX_TIMESTAMP(`createtime`))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_custom_msg` /*checksum table*/
2021-07-16T03:48:54.653403Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:54.653765Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_custom_msg' AND chunk = '1'
2021-07-16T03:48:54.654069Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003544', master_crc = 'a569ddd9', master_cnt = '123' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_custom_msg' AND chunk = '1'
2021-07-16T03:48:54.659194Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:54.660435Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:54.670159Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:54.670326Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.670498Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_exswitch_config`
2021-07-16T03:48:54.671113Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:54.671752Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_exswitch_config` WHERE 1=1
2021-07-16T03:48:54.679613Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:54.679780Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_exswitch_config'
2021-07-16T03:48:54.682990Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.683288Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntype`, `nstatus`)) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_exswitch_config` /*explain checksum table*/
2021-07-16T03:48:54.683757Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_exswitch_config', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntype`, `nstatus`)) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_exswitch_config` /*checksum table*/
2021-07-16T03:48:54.687940Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:54.688242Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_exswitch_config' AND chunk = '1'
2021-07-16T03:48:54.688517Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.004236', master_crc = 'f2454464', master_cnt = '1386' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_exswitch_config' AND chunk = '1'
2021-07-16T03:48:54.693634Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:54.694877Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:54.704665Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:54.704824Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.704972Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_exten_config`
2021-07-16T03:48:54.705520Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:54.706158Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_exten_config` WHERE 1=1
2021-07-16T03:48:54.713960Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:54.714116Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_exten_config'
2021-07-16T03:48:54.717923Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.718197Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `namountlow`, `namounthigh`, `nextenrate`)) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_exten_config` /*explain checksum table*/
2021-07-16T03:48:54.718646Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_exten_config', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `namountlow`, `namounthigh`, `nextenrate`)) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_exten_config` /*checksum table*/
2021-07-16T03:48:54.722139Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:54.722429Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_exten_config' AND chunk = '1'
2021-07-16T03:48:54.722712Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003526', master_crc = 'e71144c8', master_cnt = '8' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_exten_config' AND chunk = '1'
2021-07-16T03:48:54.727683Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:54.728909Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:54.738515Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:54.738674Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.738834Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_flow_data`
2021-07-16T03:48:54.739462Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:54.740122Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_flow_data` WHERE 1=1
2021-07-16T03:48:54.748243Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:54.748397Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_flow_data'
2021-07-16T03:48:54.751777Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.752072Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `nplayerid`, UNIX_TIMESTAMP(`createtime`), `nstatus`, CONCAT(ISNULL(`createtime`), ISNULL(`nstatus`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_flow_data` /*explain checksum table*/
2021-07-16T03:48:54.752535Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_flow_data', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `nplayerid`, UNIX_TIMESTAMP(`createtime`), `nstatus`, CONCAT(ISNULL(`createtime`), ISNULL(`nstatus`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_flow_data` /*checksum table*/
2021-07-16T03:48:54.755686Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:54.755995Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_flow_data' AND chunk = '1'
2021-07-16T03:48:54.756370Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003195', master_crc = '9d0ae896', master_cnt = '8' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_flow_data' AND chunk = '1'
2021-07-16T03:48:54.761273Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:54.762509Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:54.771960Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:54.772106Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.772253Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_game_cfg`
2021-07-16T03:48:54.772881Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:54.773523Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_game_cfg` WHERE 1=1
2021-07-16T03:48:54.781232Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:54.781394Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_game_cfg'
2021-07-16T03:48:54.784455Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.784710Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ngametype`, `nstatus`, `ndudiamondmode`, `nextstatus`, CONCAT(ISNULL(`nstatus`), ISNULL(`ndudiamondmode`), ISNULL(`nextstatus`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_game_cfg` /*explain checksum table*/
2021-07-16T03:48:54.785171Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_game_cfg', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ngametype`, `nstatus`, `ndudiamondmode`, `nextstatus`, CONCAT(ISNULL(`nstatus`), ISNULL(`ndudiamondmode`), ISNULL(`nextstatus`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_game_cfg` /*checksum table*/
2021-07-16T03:48:54.789628Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:54.789935Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_game_cfg' AND chunk = '1'
2021-07-16T03:48:54.790233Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.004491', master_crc = '6c173ca5', master_cnt = '1659' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_game_cfg' AND chunk = '1'
2021-07-16T03:48:54.795061Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:54.796226Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:54.805778Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:54.805923Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.806071Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_game_dudiamond_rate`
2021-07-16T03:48:54.806633Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:54.807295Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_game_dudiamond_rate` WHERE 1=1
2021-07-16T03:48:54.815122Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:54.815281Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_game_dudiamond_rate'
2021-07-16T03:48:54.818132Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.818406Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ngametype`, `nscore`, `ndudiamondmode`, `ndudiamondrate`, CONCAT(ISNULL(`ndudiamondmode`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_game_dudiamond_rate` /*explain checksum table*/
2021-07-16T03:48:54.818990Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_game_dudiamond_rate', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ngametype`, `nscore`, `ndudiamondmode`, `ndudiamondrate`, CONCAT(ISNULL(`ndudiamondmode`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_game_dudiamond_rate` /*checksum table*/
2021-07-16T03:48:54.822303Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:54.822598Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_game_dudiamond_rate' AND chunk = '1'
2021-07-16T03:48:54.822882Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003416', master_crc = '2cee148a', master_cnt = '30' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_game_dudiamond_rate' AND chunk = '1'
2021-07-16T03:48:54.827796Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:54.829107Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:54.838681Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:54.838857Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.839008Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_hundred_cc`
2021-07-16T03:48:54.839597Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:54.840320Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_hundred_cc` WHERE 1=1
2021-07-16T03:48:54.848358Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:54.848533Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_cc'
2021-07-16T03:48:54.851845Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.852283Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ngameid`, `nhundredtype`, `ncode`, `ntaxrate`, convert(`szdesc` using utf8mb4), `nstatus`, CONCAT(ISNULL(`nclubid`), ISNULL(`ngameid`), ISNULL(`nhundredtype`), ISNULL(`ncode`), ISNULL(`ntaxrate`), ISNULL(`szdesc`), ISNULL(`nstatus`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_hundred_cc` /*explain checksum table*/
2021-07-16T03:48:54.852836Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_hundred_cc', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ngameid`, `nhundredtype`, `ncode`, `ntaxrate`, convert(`szdesc` using utf8mb4), `nstatus`, CONCAT(ISNULL(`nclubid`), ISNULL(`ngameid`), ISNULL(`nhundredtype`), ISNULL(`ncode`), ISNULL(`ntaxrate`), ISNULL(`szdesc`), ISNULL(`nstatus`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_hundred_cc` /*checksum table*/
2021-07-16T03:48:54.855759Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:54.856064Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_cc' AND chunk = '1'
2021-07-16T03:48:54.856419Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.002962', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_cc' AND chunk = '1'
2021-07-16T03:48:54.861399Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:54.862730Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:54.872361Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:54.872528Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.872740Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_hundred_cfg`
2021-07-16T03:48:54.873406Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:54.874215Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_hundred_cfg` WHERE 1=1
2021-07-16T03:48:54.882136Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:54.882303Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_cfg'
2021-07-16T03:48:54.885413Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.885708Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ngametype`, `nhundredtype`, `nopen`, `nallowplaybank`, `nemptysysbank`, `nmaxunionbanknum`, `nunbankvalsyswin`, `nunbankvalsyslose`, CONCAT(ISNULL(`nclubid`), ISNULL(`ngametype`), ISNULL(`nhundredtype`), ISNULL(`nopen`), ISNULL(`nallowplaybank`), ISNULL(`nemptysysbank`), ISNULL(`nmaxunionbanknum`), ISNULL(`nunbankvalsyswin`), ISNULL(`nunbankvalsyslose`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_hundred_cfg` /*explain checksum table*/
2021-07-16T03:48:54.886260Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_hundred_cfg', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ngametype`, `nhundredtype`, `nopen`, `nallowplaybank`, `nemptysysbank`, `nmaxunionbanknum`, `nunbankvalsyswin`, `nunbankvalsyslose`, CONCAT(ISNULL(`nclubid`), ISNULL(`ngametype`), ISNULL(`nhundredtype`), ISNULL(`nopen`), ISNULL(`nallowplaybank`), ISNULL(`nemptysysbank`), ISNULL(`nmaxunionbanknum`), ISNULL(`nunbankvalsyswin`), ISNULL(`nunbankvalsyslose`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_hundred_cfg` /*checksum table*/
2021-07-16T03:48:54.889413Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:54.889735Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_cfg' AND chunk = '1'
2021-07-16T03:48:54.890021Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003184', master_crc = '1b0e47af', master_cnt = '3' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_cfg' AND chunk = '1'
2021-07-16T03:48:54.895287Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:54.896587Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:54.906455Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:54.906630Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.906808Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_hundred_dudiamond_cfg`
2021-07-16T03:48:54.907414Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:54.908086Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_hundred_dudiamond_cfg` WHERE 1=1
2021-07-16T03:48:54.915920Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:54.916115Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_dudiamond_cfg'
2021-07-16T03:48:54.919802Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.920092Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ngametype`, `nhundredtype`, `namount`)) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_hundred_dudiamond_cfg` /*explain checksum table*/
2021-07-16T03:48:54.920564Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_hundred_dudiamond_cfg', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ngametype`, `nhundredtype`, `namount`)) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_hundred_dudiamond_cfg` /*checksum table*/
2021-07-16T03:48:54.923688Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:54.924019Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_dudiamond_cfg' AND chunk = '1'
2021-07-16T03:48:54.924292Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003128', master_crc = '7f8aafb9', master_cnt = '3' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_dudiamond_cfg' AND chunk = '1'
2021-07-16T03:48:54.929283Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:54.930508Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:54.940433Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:54.940587Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.940782Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_hundred_free_charge`
2021-07-16T03:48:54.941385Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:54.942097Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_hundred_free_charge` WHERE 1=1
2021-07-16T03:48:54.950023Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:54.950179Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_free_charge'
2021-07-16T03:48:54.953560Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.953864Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ngameid`, `nhundredtype`, `nplayerid`, `nstatus`)) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_hundred_free_charge` /*explain checksum table*/
2021-07-16T03:48:54.954314Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_hundred_free_charge', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ngameid`, `nhundredtype`, `nplayerid`, `nstatus`)) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_hundred_free_charge` /*checksum table*/
2021-07-16T03:48:54.957649Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:54.957944Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_free_charge' AND chunk = '1'
2021-07-16T03:48:54.958234Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003339', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_free_charge' AND chunk = '1'
2021-07-16T03:48:54.963237Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:54.964460Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:54.974413Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:54.974557Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.974704Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_hundred_game_score`
2021-07-16T03:48:54.975416Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:54.976814Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_hundred_game_score` WHERE 1=1
2021-07-16T03:48:54.985683Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:54.985854Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_game_score'
2021-07-16T03:48:54.989097Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.989503Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ngameid`, `ngametype`, `nhundredtype`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `ntableid`, `nround`, `nsystembank`, `ndiamond_playcount`, `ndiamond_betscore`, `ndiamond_betfreescore`, convert(`ndiamond_carddata` using utf8mb4), convert(`ndiamond_cardtype` using utf8mb4), `nclub_playcount`, `nclub_betscore`, `nclub_betfreescore`, convert(`nclub_carddata` using utf8mb4), convert(`nclub_cardtype` using utf8mb4), `nheart_playcount`, `nheart_betscore`, `nheart_betfreescore`, convert(`nheart_carddata` using utf8mb4), convert(`nheart_cardtype` using utf8mb4), `nspade_playcount`, `nspade_betscore`, `nspade_betfreescore`, convert(`nspade_carddata` using utf8mb4), convert(`nspade_cardtype` using utf8mb4), convert(`szbankcarddata` using utf8mb4), convert(`szbankcardtype` using utf8mb4), `nbanktotalscore`, `nbankresult`, `ntotalplayercount`, `ntotalbet`, CONCAT(ISNULL(`ndiamond_playcount`), ISNULL(`ndiamond_betscore`), ISNULL(`ndiamond_betfreescore`), ISNULL(`ndiamond_carddata`), ISNULL(`ndiamond_cardtype`), ISNULL(`nclub_playcount`), ISNULL(`nclub_betscore`), ISNULL(`nclub_betfreescore`), ISNULL(`nclub_carddata`), ISNULL(`nclub_cardtype`), ISNULL(`nheart_playcount`), ISNULL(`nheart_betscore`), ISNULL(`nheart_betfreescore`), ISNULL(`nheart_carddata`), ISNULL(`nheart_cardtype`), ISNULL(`nspade_playcount`), ISNULL(`nspade_betscore`), ISNULL(`nspade_betfreescore`), ISNULL(`nspade_carddata`), ISNULL(`nspade_cardtype`), ISNULL(`szbankcarddata`), ISNULL(`szbankcardtype`), ISNULL(`nbanktotalscore`), ISNULL(`nbankresult`), ISNULL(`ntotalplayercount`), ISNULL(`ntotalbet`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_hundred_game_score` /*explain checksum table*/
2021-07-16T03:48:54.990342Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_hundred_game_score', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ngameid`, `ngametype`, `nhundredtype`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `ntableid`, `nround`, `nsystembank`, `ndiamond_playcount`, `ndiamond_betscore`, `ndiamond_betfreescore`, convert(`ndiamond_carddata` using utf8mb4), convert(`ndiamond_cardtype` using utf8mb4), `nclub_playcount`, `nclub_betscore`, `nclub_betfreescore`, convert(`nclub_carddata` using utf8mb4), convert(`nclub_cardtype` using utf8mb4), `nheart_playcount`, `nheart_betscore`, `nheart_betfreescore`, convert(`nheart_carddata` using utf8mb4), convert(`nheart_cardtype` using utf8mb4), `nspade_playcount`, `nspade_betscore`, `nspade_betfreescore`, convert(`nspade_carddata` using utf8mb4), convert(`nspade_cardtype` using utf8mb4), convert(`szbankcarddata` using utf8mb4), convert(`szbankcardtype` using utf8mb4), `nbanktotalscore`, `nbankresult`, `ntotalplayercount`, `ntotalbet`, CONCAT(ISNULL(`ndiamond_playcount`), ISNULL(`ndiamond_betscore`), ISNULL(`ndiamond_betfreescore`), ISNULL(`ndiamond_carddata`), ISNULL(`ndiamond_cardtype`), ISNULL(`nclub_playcount`), ISNULL(`nclub_betscore`), ISNULL(`nclub_betfreescore`), ISNULL(`nclub_carddata`), ISNULL(`nclub_cardtype`), ISNULL(`nheart_playcount`), ISNULL(`nheart_betscore`), ISNULL(`nheart_betfreescore`), ISNULL(`nheart_carddata`), ISNULL(`nheart_cardtype`), ISNULL(`nspade_playcount`), ISNULL(`nspade_betscore`), ISNULL(`nspade_betfreescore`), ISNULL(`nspade_carddata`), ISNULL(`nspade_cardtype`), ISNULL(`szbankcarddata`), ISNULL(`szbankcardtype`), ISNULL(`nbanktotalscore`), ISNULL(`nbankresult`), ISNULL(`ntotalplayercount`), ISNULL(`ntotalbet`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_hundred_game_score` /*checksum table*/
2021-07-16T03:48:54.993418Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:54.993765Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_game_score' AND chunk = '1'
2021-07-16T03:48:54.994035Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003228', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_game_score' AND chunk = '1'
2021-07-16T03:48:54.999002Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:55.000214Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:55.010359Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.010544Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.010768Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_hundred_game_score_banker`
2021-07-16T03:48:55.011419Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.012286Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_hundred_game_score_banker` WHERE 1=1
2021-07-16T03:48:55.020707Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:55.020884Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_game_score_banker'
2021-07-16T03:48:55.024338Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.024657Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `tid`, `nbankid`, `nshares`, `nfreeshares`, `nbankresult`, `nbankfreeresult`, `nbankscore`, `nbankfreescore`, `nfrozenscore`, `nfrozenfreescore`, `ntax`, CONCAT(ISNULL(`nshares`), ISNULL(`nfreeshares`), ISNULL(`nbankresult`), ISNULL(`nbankfreeresult`), ISNULL(`nbankscore`), ISNULL(`nbankfreescore`), ISNULL(`nfrozenscore`), ISNULL(`nfrozenfreescore`), ISNULL(`ntax`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_hundred_game_score_banker` /*explain checksum table*/
2021-07-16T03:48:55.025278Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_hundred_game_score_banker', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `tid`, `nbankid`, `nshares`, `nfreeshares`, `nbankresult`, `nbankfreeresult`, `nbankscore`, `nbankfreescore`, `nfrozenscore`, `nfrozenfreescore`, `ntax`, CONCAT(ISNULL(`nshares`), ISNULL(`nfreeshares`), ISNULL(`nbankresult`), ISNULL(`nbankfreeresult`), ISNULL(`nbankscore`), ISNULL(`nbankfreescore`), ISNULL(`nfrozenscore`), ISNULL(`nfrozenfreescore`), ISNULL(`ntax`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_hundred_game_score_banker` /*checksum table*/
2021-07-16T03:48:55.028528Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:55.028867Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_game_score_banker' AND chunk = '1'
2021-07-16T03:48:55.029158Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003302', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_game_score_banker' AND chunk = '1'
2021-07-16T03:48:55.034089Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:55.035337Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:55.045097Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.045264Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.045426Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_hundred_game_score_detail`
2021-07-16T03:48:55.046141Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.047545Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_hundred_game_score_detail` WHERE 1=1
2021-07-16T03:48:55.056360Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:55.056538Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_game_score_detail'
2021-07-16T03:48:55.060123Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.060551Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `tid`, `nplayerid`, `nclubid`, `ngameid`, `ngametype`, `nhundredtype`, `ntableid`, `nround`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `ndiamondbet`, `ndiamondbetfree`, `ndiamondresult`, `ndiamondfreeresult`, `nclubbet`, `nclubbetfree`, `nclubresult`, `nclubfreeresult`, `nheartbet`, `nheartbetfree`, `nheartresult`, `nheartfreeresult`, `nspadebet`, `nspadebetfree`, `nspaderesult`, `nspadefreeresult`, `nwinscore`, `nwinfreescore`, `nplayerscore`, `nplayerfreescore`, `ntax`, CONCAT(ISNULL(`tid`), ISNULL(`nplayerid`), ISNULL(`nclubid`), ISNULL(`ngameid`), ISNULL(`ngametype`), ISNULL(`nhundredtype`), ISNULL(`ntableid`), ISNULL(`nround`), ISNULL(`tstarttime`), ISNULL(`tendtime`), ISNULL(`ndiamondbet`), ISNULL(`ndiamondbetfree`), ISNULL(`ndiamondresult`), ISNULL(`ndiamondfreeresult`), ISNULL(`nclubbet`), ISNULL(`nclubbetfree`), ISNULL(`nclubresult`), ISNULL(`nclubfreeresult`), ISNULL(`nheartbet`), ISNULL(`nheartbetfree`), ISNULL(`nheartresult`), ISNULL(`nheartfreeresult`), ISNULL(`nspadebet`), ISNULL(`nspadebetfree`), ISNULL(`nspaderesult`), ISNULL(`nspadefreeresult`), ISNULL(`nwinscore`), ISNULL(`nwinfreescore`), ISNULL(`nplayerscore`), ISNULL(`nplayerfreescore`), ISNULL(`ntax`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_hundred_game_score_detail` /*explain checksum table*/
2021-07-16T03:48:55.061419Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_hundred_game_score_detail', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `tid`, `nplayerid`, `nclubid`, `ngameid`, `ngametype`, `nhundredtype`, `ntableid`, `nround`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `ndiamondbet`, `ndiamondbetfree`, `ndiamondresult`, `ndiamondfreeresult`, `nclubbet`, `nclubbetfree`, `nclubresult`, `nclubfreeresult`, `nheartbet`, `nheartbetfree`, `nheartresult`, `nheartfreeresult`, `nspadebet`, `nspadebetfree`, `nspaderesult`, `nspadefreeresult`, `nwinscore`, `nwinfreescore`, `nplayerscore`, `nplayerfreescore`, `ntax`, CONCAT(ISNULL(`tid`), ISNULL(`nplayerid`), ISNULL(`nclubid`), ISNULL(`ngameid`), ISNULL(`ngametype`), ISNULL(`nhundredtype`), ISNULL(`ntableid`), ISNULL(`nround`), ISNULL(`tstarttime`), ISNULL(`tendtime`), ISNULL(`ndiamondbet`), ISNULL(`ndiamondbetfree`), ISNULL(`ndiamondresult`), ISNULL(`ndiamondfreeresult`), ISNULL(`nclubbet`), ISNULL(`nclubbetfree`), ISNULL(`nclubresult`), ISNULL(`nclubfreeresult`), ISNULL(`nheartbet`), ISNULL(`nheartbetfree`), ISNULL(`nheartresult`), ISNULL(`nheartfreeresult`), ISNULL(`nspadebet`), ISNULL(`nspadebetfree`), ISNULL(`nspaderesult`), ISNULL(`nspadefreeresult`), ISNULL(`nwinscore`), ISNULL(`nwinfreescore`), ISNULL(`nplayerscore`), ISNULL(`nplayerfreescore`), ISNULL(`ntax`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_hundred_game_score_detail` /*checksum table*/
2021-07-16T03:48:55.065113Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:55.065452Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_game_score_detail' AND chunk = '1'
2021-07-16T03:48:55.065765Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003831', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_game_score_detail' AND chunk = '1'
2021-07-16T03:48:55.071146Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:55.072408Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:55.082144Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.082307Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.082467Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_hundred_roominfo`
2021-07-16T03:48:55.083102Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.083957Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_hundred_roominfo` WHERE 1=1
2021-07-16T03:48:55.092072Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:55.092245Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_roominfo'
2021-07-16T03:48:55.095485Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.095822Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, convert(`szclubname` using utf8mb4), `ntableid`, `ngameid`, `ngametype`, `nhundredtype`, `nbasescore`, `nenterminscore`, `nbankminscore`, UNIX_TIMESTAMP(`tstarttime`), CONCAT(ISNULL(`nclubid`), ISNULL(`szclubname`), ISNULL(`ntableid`), ISNULL(`ngameid`), ISNULL(`ngametype`), ISNULL(`nhundredtype`), ISNULL(`nbasescore`), ISNULL(`nenterminscore`), ISNULL(`nbankminscore`), ISNULL(`tstarttime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_hundred_roominfo` /*explain checksum table*/
2021-07-16T03:48:55.096377Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_hundred_roominfo', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, convert(`szclubname` using utf8mb4), `ntableid`, `ngameid`, `ngametype`, `nhundredtype`, `nbasescore`, `nenterminscore`, `nbankminscore`, UNIX_TIMESTAMP(`tstarttime`), CONCAT(ISNULL(`nclubid`), ISNULL(`szclubname`), ISNULL(`ntableid`), ISNULL(`ngameid`), ISNULL(`ngametype`), ISNULL(`nhundredtype`), ISNULL(`nbasescore`), ISNULL(`nenterminscore`), ISNULL(`nbankminscore`), ISNULL(`tstarttime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_hundred_roominfo` /*checksum table*/
2021-07-16T03:48:55.099596Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:55.099922Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_roominfo' AND chunk = '1'
2021-07-16T03:48:55.100205Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003275', master_crc = '337c9464', master_cnt = '95' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_roominfo' AND chunk = '1'
2021-07-16T03:48:55.105394Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:55.106665Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:55.116454Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.116612Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.116790Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_hundred_user_enter_info`
2021-07-16T03:48:55.117440Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.118231Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_hundred_user_enter_info` WHERE 1=1
2021-07-16T03:48:55.126292Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:55.126445Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_user_enter_info'
2021-07-16T03:48:55.130127Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.130566Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `ngameid`, `nplayerid`, `ngametype`, `nhundredtype`, UNIX_TIMESTAMP(`tentertime`), UNIX_TIMESTAMP(`tquittime`), CONCAT(ISNULL(`tquittime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_hundred_user_enter_info` /*explain checksum table*/
2021-07-16T03:48:55.131145Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_hundred_user_enter_info', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `ngameid`, `nplayerid`, `ngametype`, `nhundredtype`, UNIX_TIMESTAMP(`tentertime`), UNIX_TIMESTAMP(`tquittime`), CONCAT(ISNULL(`tquittime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_hundred_user_enter_info` /*checksum table*/
2021-07-16T03:48:55.134146Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:55.134437Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_user_enter_info' AND chunk = '1'
2021-07-16T03:48:55.134708Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003051', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_user_enter_info' AND chunk = '1'
2021-07-16T03:48:55.139493Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:55.140736Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:55.150431Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.150584Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.150758Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_info_notauthority`
2021-07-16T03:48:55.151327Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.151997Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_info_notauthority` WHERE 1=1
2021-07-16T03:48:55.159958Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:55.160116Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_info_notauthority'
2021-07-16T03:48:55.163822Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.164126Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `nlevel`, `nstatus`, `createtime`, `tmodifytime`)) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_info_notauthority` /*explain checksum table*/
2021-07-16T03:48:55.164551Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_info_notauthority', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `nlevel`, `nstatus`, `createtime`, `tmodifytime`)) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_info_notauthority` /*checksum table*/
2021-07-16T03:48:55.167695Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:55.168058Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_info_notauthority' AND chunk = '1'
2021-07-16T03:48:55.168353Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003160', master_crc = '28466fbc', master_cnt = '25' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_info_notauthority' AND chunk = '1'
2021-07-16T03:48:55.173701Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:55.174933Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:55.184680Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.184851Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.185002Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_match_game_cfg`
2021-07-16T03:48:55.185498Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.186156Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_match_game_cfg` WHERE 1=1
2021-07-16T03:48:55.193961Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:55.194132Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_match_game_cfg'
2021-07-16T03:48:55.197288Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.197613Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ngametype`, `nmatchtype`, `nserverid`, `nstatus`)) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_match_game_cfg` /*explain checksum table*/
2021-07-16T03:48:55.198012Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_match_game_cfg', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ngametype`, `nmatchtype`, `nserverid`, `nstatus`)) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_match_game_cfg` /*checksum table*/
2021-07-16T03:48:55.200934Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:55.201185Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_match_game_cfg' AND chunk = '1'
2021-07-16T03:48:55.201472Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.002943', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_match_game_cfg' AND chunk = '1'
2021-07-16T03:48:55.206454Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:55.207670Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:55.217442Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.217611Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.217777Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_member_authority`
2021-07-16T03:48:55.218394Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.219139Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_member_authority` WHERE 1=1
2021-07-16T03:48:55.227279Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:55.227432Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_member_authority'
2021-07-16T03:48:55.230812Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.231125Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `nplayerid`, `nlevel`, `nstatus`, UNIX_TIMESTAMP(`tcreatetime`), `tmodifytime`, CONCAT(ISNULL(`nlevel`), ISNULL(`nstatus`), ISNULL(`tcreatetime`), ISNULL(`tmodifytime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_member_authority` /*explain checksum table*/
2021-07-16T03:48:55.231572Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_member_authority', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `nplayerid`, `nlevel`, `nstatus`, UNIX_TIMESTAMP(`tcreatetime`), `tmodifytime`, CONCAT(ISNULL(`nlevel`), ISNULL(`nstatus`), ISNULL(`tcreatetime`), ISNULL(`tmodifytime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_member_authority` /*checksum table*/
2021-07-16T03:48:55.234663Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:55.234940Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_member_authority' AND chunk = '1'
2021-07-16T03:48:55.235169Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003129', master_crc = 'ac1cf08e', master_cnt = '189' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_member_authority' AND chunk = '1'
2021-07-16T03:48:55.240365Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:55.241650Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:55.251649Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.251829Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.251988Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_member_exswitch_config`
2021-07-16T03:48:55.252634Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.253313Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_member_exswitch_config` WHERE 1=1
2021-07-16T03:48:55.261157Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:55.261317Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_member_exswitch_config'
2021-07-16T03:48:55.264925Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.265222Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `nplayerid`, `ntype`, `nstatus`)) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_member_exswitch_config` /*explain checksum table*/
2021-07-16T03:48:55.265663Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_member_exswitch_config', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `nplayerid`, `ntype`, `nstatus`)) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_member_exswitch_config` /*checksum table*/
2021-07-16T03:48:55.269118Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:55.269452Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_member_exswitch_config' AND chunk = '1'
2021-07-16T03:48:55.269712Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003489', master_crc = '9165edcb', master_cnt = '11' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_member_exswitch_config' AND chunk = '1'
2021-07-16T03:48:55.275179Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:55.276437Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:55.286156Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.286308Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.286463Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_task_clubdata`
2021-07-16T03:48:55.287041Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.287763Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_task_clubdata` WHERE 1=1
2021-07-16T03:48:55.295616Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:55.295802Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_task_clubdata'
2021-07-16T03:48:55.299018Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.299346Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, convert(`sztaskname` using utf8mb4), `ntaskid`, `nstatus`, convert(`szdesc` using utf8mb4), UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`modifytime`), CONCAT(ISNULL(`szdesc`), ISNULL(`modifytime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_task_clubdata` /*explain checksum table*/
2021-07-16T03:48:55.299869Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_task_clubdata', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, convert(`sztaskname` using utf8mb4), `ntaskid`, `nstatus`, convert(`szdesc` using utf8mb4), UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`modifytime`), CONCAT(ISNULL(`szdesc`), ISNULL(`modifytime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_task_clubdata` /*checksum table*/
2021-07-16T03:48:55.302853Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:55.303137Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_task_clubdata' AND chunk = '1'
2021-07-16T03:48:55.303414Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003054', master_crc = '4f491b40', master_cnt = '30' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_task_clubdata' AND chunk = '1'
2021-07-16T03:48:55.308373Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:55.309588Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:55.319355Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.319530Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.319683Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_task_complete`
2021-07-16T03:48:55.320187Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.321007Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_task_complete` WHERE 1=1
2021-07-16T03:48:55.329106Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:55.329272Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_task_complete'
2021-07-16T03:48:55.332863Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.333169Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `nplayerid`, convert(`sznickname` using utf8mb4), `ntaskid`, `ngametype`, `amount`, `eamount`, convert(`szmask` using utf8mb4), convert(`szmask1` using utf8mb4), convert(`szmask2` using utf8mb4), UNIX_TIMESTAMP(`tcreatetime`), `nproperty`, CONCAT(ISNULL(`amount`), ISNULL(`eamount`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_task_complete` /*explain checksum table*/
2021-07-16T03:48:55.333671Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_task_complete', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `nplayerid`, convert(`sznickname` using utf8mb4), `ntaskid`, `ngametype`, `amount`, `eamount`, convert(`szmask` using utf8mb4), convert(`szmask1` using utf8mb4), convert(`szmask2` using utf8mb4), UNIX_TIMESTAMP(`tcreatetime`), `nproperty`, CONCAT(ISNULL(`amount`), ISNULL(`eamount`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_task_complete` /*checksum table*/
2021-07-16T03:48:55.342273Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:55.342583Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_task_complete' AND chunk = '1'
2021-07-16T03:48:55.342870Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.008671', master_crc = 'a86a4ced', master_cnt = '2564' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_task_complete' AND chunk = '1'
2021-07-16T03:48:55.347991Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:55.349262Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:55.359477Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.359633Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.359814Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_task_player_data`
2021-07-16T03:48:55.360107Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.360835Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_task_player_data` WHERE 1=1
2021-07-16T03:48:55.368464Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:55.368620Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_task_player_data'
2021-07-16T03:48:55.371871Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.372146Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `nplayerid`, `nvalidbet`, CRC32(`taskdata`), CONCAT(ISNULL(`nvalidbet`), ISNULL(`taskdata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_task_player_data` /*explain checksum table*/
2021-07-16T03:48:55.372560Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_task_player_data', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `nplayerid`, `nvalidbet`, CRC32(`taskdata`), CONCAT(ISNULL(`nvalidbet`), ISNULL(`taskdata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_task_player_data` /*checksum table*/
2021-07-16T03:48:55.386601Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:55.386878Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_task_player_data' AND chunk = '1'
2021-07-16T03:48:55.387101Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.014065', master_crc = '90a41f33', master_cnt = '7852' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_task_player_data' AND chunk = '1'
2021-07-16T03:48:55.392185Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:55.393420Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:55.403377Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.403536Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.403707Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_task_recdata`
2021-07-16T03:48:55.404387Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.405153Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_task_recdata` WHERE 1=1
2021-07-16T03:48:55.412995Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:55.413150Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_task_recdata'
2021-07-16T03:48:55.416537Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.416834Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `nclubid`, `ntaskid`, `amount`, `currentbet`, `targetbet`, `lockflag`, `doneflag`, UNIX_TIMESTAMP(`tcreatetime`), CONCAT(ISNULL(`amount`), ISNULL(`currentbet`), ISNULL(`targetbet`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_task_recdata` /*explain checksum table*/
2021-07-16T03:48:55.417299Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_task_recdata', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `nclubid`, `ntaskid`, `amount`, `currentbet`, `targetbet`, `lockflag`, `doneflag`, UNIX_TIMESTAMP(`tcreatetime`), CONCAT(ISNULL(`amount`), ISNULL(`currentbet`), ISNULL(`targetbet`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_task_recdata` /*checksum table*/
2021-07-16T03:48:55.422793Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:55.423094Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_task_recdata' AND chunk = '1'
2021-07-16T03:48:55.423382Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.005506', master_crc = 'a83786c8', master_cnt = '1554' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_task_recdata' AND chunk = '1'
2021-07-16T03:48:55.428297Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:55.429538Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:55.439633Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.439824Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.439989Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_clubapplication`
2021-07-16T03:48:55.440635Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.441364Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_clubapplication` WHERE 1=1
2021-07-16T03:48:55.449522Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:55.449759Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubapplication'
2021-07-16T03:48:55.453200Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.453529Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `nplayerid`, UNIX_TIMESTAMP(`createtime`), `nstatus`, UNIX_TIMESTAMP(`toperationtime`), `nmsgid`, CONCAT(ISNULL(`toperationtime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubapplication` /*explain checksum table*/
2021-07-16T03:48:55.454077Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_clubapplication', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `nplayerid`, UNIX_TIMESTAMP(`createtime`), `nstatus`, UNIX_TIMESTAMP(`toperationtime`), `nmsgid`, CONCAT(ISNULL(`toperationtime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubapplication` /*checksum table*/
2021-07-16T03:48:55.458283Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:55.458618Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubapplication' AND chunk = '1'
2021-07-16T03:48:55.458949Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.004223', master_crc = 'c305ace2', master_cnt = '704' WHERE db = 'niuniuh5_db' AND tbl = 'table_clubapplication' AND chunk = '1'
2021-07-16T03:48:55.464425Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:55.465730Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:55.475400Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.475556Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.475707Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_clubbiggamescore`
2021-07-16T03:48:55.476452Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.477775Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_clubbiggamescore` WHERE 1=1
2021-07-16T03:48:55.486877Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:55.487064Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubbiggamescore'
2021-07-16T03:48:55.490746Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.491108Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `ntableid`, `nround`, `ntian_playcount`, `ntian_bet`, convert(`ntian_carddata` using utf8mb4), convert(`ntian_cardtype` using utf8mb4), `ndi_playcount`, `ndi_bet`, convert(`ndi_carddata` using utf8mb4), convert(`ndi_cardtype` using utf8mb4), `nxuan_playcount`, `nxuan_bet`, convert(`nxuan_carddata` using utf8mb4), convert(`nxuan_cardtype` using utf8mb4), `nhuang_playcount`, `nhuang_bet`, convert(`nhuang_carddata` using utf8mb4), convert(`nhuang_cardtype` using utf8mb4), `ntotalplayercount`, `ntotalbet`, `nbankid`, convert(`szbankcarddata` using utf8mb4), convert(`szbankcardtype` using utf8mb4), `nbankresult`, `nbankscore`, `ntaxrate`, `ntax`, `ngametype`, CONCAT(ISNULL(`tendtime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubbiggamescore` /*explain checksum table*/
2021-07-16T03:48:55.491765Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_clubbiggamescore', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `ntableid`, `nround`, `ntian_playcount`, `ntian_bet`, convert(`ntian_carddata` using utf8mb4), convert(`ntian_cardtype` using utf8mb4), `ndi_playcount`, `ndi_bet`, convert(`ndi_carddata` using utf8mb4), convert(`ndi_cardtype` using utf8mb4), `nxuan_playcount`, `nxuan_bet`, convert(`nxuan_carddata` using utf8mb4), convert(`nxuan_cardtype` using utf8mb4), `nhuang_playcount`, `nhuang_bet`, convert(`nhuang_carddata` using utf8mb4), convert(`nhuang_cardtype` using utf8mb4), `ntotalplayercount`, `ntotalbet`, `nbankid`, convert(`szbankcarddata` using utf8mb4), convert(`szbankcardtype` using utf8mb4), `nbankresult`, `nbankscore`, `ntaxrate`, `ntax`, `ngametype`, CONCAT(ISNULL(`tendtime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubbiggamescore` /*checksum table*/
2021-07-16T03:48:55.494974Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:55.495323Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubbiggamescore' AND chunk = '1'
2021-07-16T03:48:55.495611Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003284', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_clubbiggamescore' AND chunk = '1'
2021-07-16T03:48:55.500984Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:55.502306Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:55.511993Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.512164Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.512333Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_clubbiggamescoredetail`
2021-07-16T03:48:55.513053Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.514101Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_clubbiggamescoredetail` WHERE 1=1
2021-07-16T03:48:55.522365Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:55.522543Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubbiggamescoredetail'
2021-07-16T03:48:55.526395Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.526790Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `tid`, `nplayerid`, `nclubid`, `ntableid`, `nround`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `ntianbet`, `ntianresult`, `ndibet`, `ndiresult`, `nxuanbet`, `nxuanresult`, `nhuangbet`, `nhuangresult`, `nwinscore`, `nplayerscore`, `ntaxrate`, `ntax`, `ngametype`, CONCAT(ISNULL(`tendtime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubbiggamescoredetail` /*explain checksum table*/
2021-07-16T03:48:55.527388Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_clubbiggamescoredetail', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `tid`, `nplayerid`, `nclubid`, `ntableid`, `nround`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `ntianbet`, `ntianresult`, `ndibet`, `ndiresult`, `nxuanbet`, `nxuanresult`, `nhuangbet`, `nhuangresult`, `nwinscore`, `nplayerscore`, `ntaxrate`, `ntax`, `ngametype`, CONCAT(ISNULL(`tendtime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubbiggamescoredetail` /*checksum table*/
2021-07-16T03:48:55.530803Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:55.531137Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubbiggamescoredetail' AND chunk = '1'
2021-07-16T03:48:55.531403Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003389', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_clubbiggamescoredetail' AND chunk = '1'
2021-07-16T03:48:55.536907Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:55.538289Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:55.548171Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.548347Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.548512Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_clubevent`
2021-07-16T03:48:55.549172Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.549877Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_clubevent` WHERE 1=1
2021-07-16T03:48:55.557891Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:55.558065Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubevent'
2021-07-16T03:48:55.561802Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.562162Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, UNIX_TIMESTAMP(`createtime`), `neventtype`, convert(`szdesc` using utf8mb4), CONCAT(ISNULL(`nclubid`), ISNULL(`neventtype`), ISNULL(`szdesc`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubevent` /*explain checksum table*/
2021-07-16T03:48:55.562697Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_clubevent', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, UNIX_TIMESTAMP(`createtime`), `neventtype`, convert(`szdesc` using utf8mb4), CONCAT(ISNULL(`nclubid`), ISNULL(`neventtype`), ISNULL(`szdesc`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubevent` /*checksum table*/
2021-07-16T03:48:55.566659Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:55.567026Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubevent' AND chunk = '1'
2021-07-16T03:48:55.567317Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003987', master_crc = 'a64fd3cd', master_cnt = '392' WHERE db = 'niuniuh5_db' AND tbl = 'table_clubevent' AND chunk = '1'
2021-07-16T03:48:55.572607Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:55.573892Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:55.583545Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.583724Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.583882Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_clubgamelog`
2021-07-16T03:48:55.584479Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.585242Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_clubgamelog` WHERE 1=1
2021-07-16T03:48:55.593259Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:55.593426Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamelog'
2021-07-16T03:48:55.596945Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.597264Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, convert(`sztoken` using utf8mb4), UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `ngametype`, `nserverid`, CRC32(`logdata`), CRC32(`carddata`), CONCAT(ISNULL(`tendtime`), ISNULL(`logdata`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamelog` /*explain checksum table*/
2021-07-16T03:48:55.597825Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_clubgamelog', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, convert(`sztoken` using utf8mb4), UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `ngametype`, `nserverid`, CRC32(`logdata`), CRC32(`carddata`), CONCAT(ISNULL(`tendtime`), ISNULL(`logdata`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamelog` /*checksum table*/
2021-07-16T03:48:55.601019Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:55.601330Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamelog' AND chunk = '1'
2021-07-16T03:48:55.601604Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003250', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamelog' AND chunk = '1'
2021-07-16T03:48:55.606604Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:55.607881Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:55.617710Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.617912Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.618071Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_clubgamescoredetail`
2021-07-16T03:48:55.618451Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.619743Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_clubgamescoredetail` WHERE 1=1
2021-07-16T03:48:55.628455Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:55.628654Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail'
2021-07-16T03:48:55.632257Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.632634Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail` /*explain checksum table*/
2021-07-16T03:48:55.633288Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_clubgamescoredetail', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail` /*checksum table*/
2021-07-16T03:48:55.636546Z	300444 Query	call pr_pyramid_get_examine()
2021-07-16T03:48:55.636640Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:55.636937Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail' AND chunk = '1'
2021-07-16T03:48:55.637160Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003433', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail' AND chunk = '1'
2021-07-16T03:48:55.642180Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:55.643424Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:55.653074Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.653254Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.653423Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_clubgamescoredetail20210101`
2021-07-16T03:48:55.654255Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.655447Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_clubgamescoredetail20210101` WHERE 1=1
2021-07-16T03:48:55.664068Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:55.664252Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210101'
2021-07-16T03:48:55.668090Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.668444Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210101` /*explain checksum table*/
2021-07-16T03:48:55.669162Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_clubgamescoredetail20210101', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210101` /*checksum table*/
2021-07-16T03:48:55.672490Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:55.672829Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210101' AND chunk = '1'
2021-07-16T03:48:55.673126Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003404', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210101' AND chunk = '1'
2021-07-16T03:48:55.678130Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:55.679395Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:55.689211Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.689430Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.689602Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_clubgamescoredetail20210102`
2021-07-16T03:48:55.690387Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.691615Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_clubgamescoredetail20210102` WHERE 1=1
2021-07-16T03:48:55.700273Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:55.700429Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210102'
2021-07-16T03:48:55.703849Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.704185Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210102` /*explain checksum table*/
2021-07-16T03:48:55.704840Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_clubgamescoredetail20210102', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210102` /*checksum table*/
2021-07-16T03:48:55.707810Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:55.708115Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210102' AND chunk = '1'
2021-07-16T03:48:55.708412Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003028', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210102' AND chunk = '1'
2021-07-16T03:48:55.713427Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:55.714671Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:55.724216Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.724373Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.724523Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_clubgamescoredetail20210103`
2021-07-16T03:48:55.725250Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.726414Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_clubgamescoredetail20210103` WHERE 1=1
2021-07-16T03:48:55.735022Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:55.735179Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210103'
2021-07-16T03:48:55.738566Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.738939Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210103` /*explain checksum table*/
2021-07-16T03:48:55.739542Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_clubgamescoredetail20210103', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210103` /*checksum table*/
2021-07-16T03:48:55.742682Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:55.742984Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210103' AND chunk = '1'
2021-07-16T03:48:55.743264Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003208', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210103' AND chunk = '1'
2021-07-16T03:48:55.748321Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:55.749539Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:55.759241Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.759400Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.759553Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_clubgamescoredetail20210104`
2021-07-16T03:48:55.760276Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.761427Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_clubgamescoredetail20210104` WHERE 1=1
2021-07-16T03:48:55.770020Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:55.770176Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210104'
2021-07-16T03:48:55.773703Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.774053Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210104` /*explain checksum table*/
2021-07-16T03:48:55.774697Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_clubgamescoredetail20210104', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210104` /*checksum table*/
2021-07-16T03:48:55.777848Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:55.778138Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210104' AND chunk = '1'
2021-07-16T03:48:55.778426Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003227', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210104' AND chunk = '1'
2021-07-16T03:48:55.783376Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:55.784595Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:55.794402Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.794555Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.794705Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_clubgamescoredetail20210105`
2021-07-16T03:48:55.795434Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.796592Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_clubgamescoredetail20210105` WHERE 1=1
2021-07-16T03:48:55.805180Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:55.805363Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210105'
2021-07-16T03:48:55.808833Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.809211Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210105` /*explain checksum table*/
2021-07-16T03:48:55.809825Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_clubgamescoredetail20210105', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210105` /*checksum table*/
2021-07-16T03:48:55.813094Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:55.813460Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210105' AND chunk = '1'
2021-07-16T03:48:55.813731Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003363', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210105' AND chunk = '1'
2021-07-16T03:48:55.819250Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:55.820497Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:55.830416Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.830604Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.830823Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_clubgamescoredetail20210106`
2021-07-16T03:48:55.831586Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.832829Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_clubgamescoredetail20210106` WHERE 1=1
2021-07-16T03:48:55.841661Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:55.841890Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210106'
2021-07-16T03:48:55.845157Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.845528Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210106` /*explain checksum table*/
2021-07-16T03:48:55.846169Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_clubgamescoredetail20210106', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210106` /*checksum table*/
2021-07-16T03:48:55.849429Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:55.849843Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210106' AND chunk = '1'
2021-07-16T03:48:55.850214Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003336', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210106' AND chunk = '1'
2021-07-16T03:48:55.855445Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:55.856740Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:55.866284Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.866442Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.866601Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_clubgamescoredetail20210107`
2021-07-16T03:48:55.867348Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.868557Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_clubgamescoredetail20210107` WHERE 1=1
2021-07-16T03:48:55.877069Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:55.877237Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210107'
2021-07-16T03:48:55.880654Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.881034Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210107` /*explain checksum table*/
2021-07-16T03:48:55.881732Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_clubgamescoredetail20210107', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210107` /*checksum table*/
2021-07-16T03:48:55.884944Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:55.885256Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210107' AND chunk = '1'
2021-07-16T03:48:55.885532Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003321', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210107' AND chunk = '1'
2021-07-16T03:48:55.890608Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:55.891887Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:55.902017Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.902192Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.902372Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_clubgamescoredetail20210108`
2021-07-16T03:48:55.903170Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.904385Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_clubgamescoredetail20210108` WHERE 1=1
2021-07-16T03:48:55.913144Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:55.913327Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210108'
2021-07-16T03:48:55.917144Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.917497Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210108` /*explain checksum table*/
2021-07-16T03:48:55.918192Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_clubgamescoredetail20210108', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210108` /*checksum table*/
2021-07-16T03:48:55.921595Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:55.921988Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210108' AND chunk = '1'
2021-07-16T03:48:55.922294Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003480', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210108' AND chunk = '1'
2021-07-16T03:48:55.927349Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:55.928635Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:55.938405Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.938565Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.938762Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_clubgamescoredetail20210109`
2021-07-16T03:48:55.939553Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.940762Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_clubgamescoredetail20210109` WHERE 1=1
2021-07-16T03:48:55.949194Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:55.949366Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210109'
2021-07-16T03:48:55.953071Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.953403Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210109` /*explain checksum table*/
2021-07-16T03:48:55.954132Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_clubgamescoredetail20210109', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210109` /*checksum table*/
2021-07-16T03:48:55.956970Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:55.957258Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210109' AND chunk = '1'
2021-07-16T03:48:55.957518Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.002952', master_crc = '4993baf', master_cnt = '1' WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210109' AND chunk = '1'
2021-07-16T03:48:55.962651Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:55.963904Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:55.973485Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.973645Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.973831Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_clubgamescoredetail20210110`
2021-07-16T03:48:55.974544Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.975757Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_clubgamescoredetail20210110` WHERE 1=1
2021-07-16T03:48:55.984584Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:55.984785Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210110'
2021-07-16T03:48:55.988855Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.989209Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210110` /*explain checksum table*/
2021-07-16T03:48:55.989855Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_clubgamescoredetail20210110', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210110` /*checksum table*/
2021-07-16T03:48:55.993132Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:55.993453Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210110' AND chunk = '1'
2021-07-16T03:48:55.993768Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003353', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210110' AND chunk = '1'
2021-07-16T03:48:55.999114Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:56.000420Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:56.010801Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:56.010983Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:56.011155Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_clubgamescoredetail20210111`
2021-07-16T03:48:56.011960Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:56.013207Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_clubgamescoredetail20210111` WHERE 1=1
2021-07-16T03:48:56.022059Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:56.022229Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210111'
2021-07-16T03:48:56.025590Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:56.025977Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210111` /*explain checksum table*/
2021-07-16T03:48:56.026641Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_clubgamescoredetail20210111', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210111` /*checksum table*/
2021-07-16T03:48:56.030040Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:56.030358Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210111' AND chunk = '1'
2021-07-16T03:48:56.030643Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003477', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210111' AND chunk = '1'
2021-07-16T03:48:56.035733Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:56.037068Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:56.047146Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:56.047356Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:56.047523Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_clubgamescoredetail20210112`
2021-07-16T03:48:56.048354Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:56.049593Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_clubgamescoredetail20210112` WHERE 1=1
2021-07-16T03:48:56.058408Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:56.058592Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210112'
2021-07-16T03:48:56.062437Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:56.062843Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210112` /*explain checksum table*/
2021-07-16T03:48:56.063636Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_clubgamescoredetail20210112', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210112` /*checksum table*/
2021-07-16T03:48:56.067013Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:56.067362Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210112' AND chunk = '1'
2021-07-16T03:48:56.067688Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003484', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210112' AND chunk = '1'
2021-07-16T03:48:56.073082Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:56.074437Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:56.084908Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:56.085083Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:56.085274Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_clubgamescoredetail20210113`
2021-07-16T03:48:56.086065Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:56.087288Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_clubgamescoredetail20210113` WHERE 1=1
2021-07-16T03:48:56.095894Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:56.096056Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210113'
2021-07-16T03:48:56.099763Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:56.100122Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210113` /*explain checksum table*/
2021-07-16T03:48:56.100795Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_clubgamescoredetail20210113', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210113` /*checksum table*/
2021-07-16T03:48:56.103854Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:56.104160Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210113' AND chunk = '1'
2021-07-16T03:48:56.104446Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003158', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210113' AND chunk = '1'
2021-07-16T03:48:56.109846Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:56.111234Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:56.121152Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:56.121311Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:56.121469Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_clubgamescoredetail20210114`
2021-07-16T03:48:56.122223Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:56.123369Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_clubgamescoredetail20210114` WHERE 1=1
2021-07-16T03:48:56.131874Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:56.132035Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210114'
2021-07-16T03:48:56.135551Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:56.135942Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210114` /*explain checksum table*/
2021-07-16T03:48:56.136600Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_clubgamescoredetail20210114', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210114` /*checksum table*/
2021-07-16T03:48:56.139821Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:56.140127Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210114' AND chunk = '1'
2021-07-16T03:48:56.140417Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003311', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210114' AND chunk = '1'
2021-07-16T03:48:56.145559Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:56.146804Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:56.156650Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:56.156854Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:56.157032Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_clubgamescoredetail20210115`
2021-07-16T03:48:56.157897Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:56.159178Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_clubgamescoredetail20210115` WHERE 1=1
2021-07-16T03:48:56.168182Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:56.168375Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210115'
2021-07-16T03:48:56.171949Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:56.172333Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210115` /*explain checksum table*/
2021-07-16T03:48:56.173009Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_clubgamescoredetail20210115', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210115` /*checksum table*/
2021-07-16T03:48:56.176184Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:56.176532Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210115' AND chunk = '1'
2021-07-16T03:48:56.176850Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003244', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210115' AND chunk = '1'
2021-07-16T03:48:56.182423Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:56.183761Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:56.194216Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:56.194394Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:56.194560Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_clubgamescoredetail20210116`
2021-07-16T03:48:56.195380Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:56.196581Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_clubgamescoredetail20210116` WHERE 1=1
2021-07-16T03:48:56.205366Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:56.205536Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210116'
2021-07-16T03:48:56.209452Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:56.209855Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210116` /*explain checksum table*/
2021-07-16T03:48:56.210583Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_clubgamescoredetail20210116', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210116` /*checksum table*/
2021-07-16T03:48:56.214016Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:56.214344Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210116' AND chunk = '1'
2021-07-16T03:48:56.214669Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003500', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210116' AND chunk = '1'
2021-07-16T03:48:56.220164Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:56.221471Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:56.231681Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:56.231856Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:56.232027Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_clubgamescoredetail20210117`
2021-07-16T03:48:56.232863Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:56.234072Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_clubgamescoredetail20210117` WHERE 1=1
2021-07-16T03:48:56.242933Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:56.243096Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210117'
2021-07-16T03:48:56.246464Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:56.246830Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210117` /*explain checksum table*/
2021-07-16T03:48:56.247445Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_clubgamescoredetail20210117', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210117` /*checksum table*/
2021-07-16T03:48:56.250814Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:56.251139Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210117' AND chunk = '1'
2021-07-16T03:48:56.251415Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003424', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210117' AND chunk = '1'
2021-07-16T03:48:56.256637Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:56.257969Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:56.268111Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:56.268283Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:56.268440Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_clubgamescoredetail20210118`
2021-07-16T03:48:56.269221Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:56.270399Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_clubgamescoredetail20210118` WHERE 1=1
2021-07-16T03:48:56.279184Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:56.279350Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210118'
2021-07-16T03:48:56.282594Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:56.283013Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210118` /*explain checksum table*/
2021-07-16T03:48:56.283610Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_clubgamescoredetail20210118', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210118` /*checksum table*/
2021-07-16T03:48:56.287028Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:56.287305Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210118' AND chunk = '1'
2021-07-16T03:48:56.287538Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003474', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210118' AND chunk = '1'
2021-07-16T03:48:56.292533Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
2021-07-16T03:48:56.293823Z	332454 Query	SHOW MASTER STATUS
2021-07-16T03:48:56.303863Z	332454 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:56.304024Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:56.304182Z	332454 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_clubgamescoredetail20210119`
2021-07-16T03:48:56.305006Z	332454 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:56.306270Z	332454 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_clubgamescoredetail20210119` WHERE 1=1
2021-07-16T03:48:56.315084Z	332454 Query	USE `consistency_db`
2021-07-16T03:48:56.315262Z	332454 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210119'
2021-07-16T03:48:56.318845Z	332454 Query	USE `niuniuh5_db`
2021-07-16T03:48:56.319216Z	332454 Query	EXPLAIN SELECT COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210119` /*explain checksum table*/
2021-07-16T03:48:56.319866Z	332454 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_clubgamescoredetail20210119', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `nchairid`, convert(`sztoken` using utf8mb4), `nround`, `nbasescore`, `nplaycount`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `nplayerid`, `brobot`, convert(`szcarddata` using utf8mb4), `nenterscore`, `nbetscore`, `nvalidbet`, `nresultmoney`, `nplayerscore`, `ntax`, `ngametype`, `nserverid`, convert(`ncarddata` using utf8mb4), `nbankid`, CRC32(`szextchar`), CRC32(`carddata`), CONCAT(ISNULL(`nchairid`), ISNULL(`sztoken`), ISNULL(`tendtime`), ISNULL(`nplayerid`), ISNULL(`szcarddata`), ISNULL(`nenterscore`), ISNULL(`nbetscore`), ISNULL(`nvalidbet`), ISNULL(`nresultmoney`), ISNULL(`nplayerscore`), ISNULL(`ntax`), ISNULL(`nserverid`), ISNULL(`szextchar`), ISNULL(`carddata`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_clubgamescoredetail20210119` /*checksum table*/
2021-07-16T03:48:56.322980Z	332454 Query	SHOW WARNINGS
2021-07-16T03:48:56.323289Z	332454 Query	SELECT this_crc, this_cnt FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210119' AND chunk = '1'
2021-07-16T03:48:56.323617Z	332454 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003201', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_clubgamescoredetail20210119' AND chunk = '1'
2021-07-16T03:48:56.328817Z	332454 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'