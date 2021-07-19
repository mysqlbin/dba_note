2021-07-16T03:48:52.390023Z	61678 Connect	pt_user@192.168.1.10 on  using TCP/IP
2021-07-16T03:48:52.391004Z	61678 Query	SHOW VARIABLES LIKE 'innodb\_lock_wait_timeout'
2021-07-16T03:48:52.393356Z	61678 Query	SET SESSION innodb_lock_wait_timeout=1
2021-07-16T03:48:52.394286Z	61678 Query	SHOW VARIABLES LIKE 'wait\_timeout'
2021-07-16T03:48:52.396041Z	61678 Query	SET SESSION wait_timeout=10000
2021-07-16T03:48:52.396887Z	61678 Query	SELECT @@SQL_MODE
2021-07-16T03:48:52.397768Z	61678 Query	SET @@SQL_QUOTE_SHOW_CREATE = 1/*!40101, @@SQL_MODE='NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION'*/
2021-07-16T03:48:52.398602Z	61678 Query	SELECT @@SERVER_ID
2021-07-16T03:48:52.400407Z	61678 Query	SELECT @@server_id /*!50038 , @@hostname*/
2021-07-16T03:48:52.401292Z	61678 Query	SHOW VARIABLES LIKE 'wsrep_on'
2021-07-16T03:48:52.403061Z	61678 Query	SHOW GRANTS FOR CURRENT_USER()
2021-07-16T03:48:52.403983Z	61678 Query	SHOW FULL PROCESSLIST
2021-07-16T03:48:52.406522Z	61678 Query	SHOW SLAVE HOSTS
2021-07-16T03:48:52.409528Z	61678 Query	SHOW VARIABLES LIKE 'wsrep_on'
2021-07-16T03:48:52.411303Z	61678 Query	SELECT @@SERVER_ID
2021-07-16T03:48:52.413848Z	61678 Query	SHOW VARIABLES LIKE 'wsrep_on'
2021-07-16T03:48:52.415678Z	61678 Query	SELECT @@SERVER_ID
2021-07-16T03:48:52.420134Z	11767 Query	CREATE DATABASE IF NOT EXISTS `consistency_db` /* pt-table-checksum */
2021-07-16T03:48:52.424766Z	61678 Query	SHOW TABLES FROM `consistency_db` LIKE 'checksums'
2021-07-16T03:48:52.424957Z	11767 Query	CREATE TABLE IF NOT EXISTS `consistency_db`.`checksums` (
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
2021-07-16T03:48:52.427957Z	61678 Query	SELECT CONCAT(@@hostname, @@port)
2021-07-16T03:48:52.451089Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'accountinfo'
2021-07-16T03:48:52.453458Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:52.454347Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.455193Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`accountinfo`
2021-07-16T03:48:52.456724Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:52.458059Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`accountinfo` WHERE 1=1
2021-07-16T03:48:52.463180Z	11767 Query	BEGIN
2021-07-16T03:48:52.463439Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'accountinfo'
2021-07-16T03:48:52.463469Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.467787Z	11767 Query	BEGIN
2021-07-16T03:48:52.468425Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'accountinfo', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `accountid`, convert(`enterpriseid` using utf8mb4), convert(`treecode` using utf8mb4), `accounttype`, convert(`accountname` using utf8mb4), convert(`password` using utf8mb4), convert(`realname` using utf8mb4), convert(`phone` using utf8mb4), convert(`qq` using utf8mb4), convert(`email` using utf8mb4), `status`, UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`updatetime`), UNIX_TIMESTAMP(`logintime`), convert(`logintoken` using utf8mb4), convert(`extendcode` using utf8mb4), convert(`ip` using utf8mb4), CONCAT(ISNULL(`realname`), ISNULL(`phone`), ISNULL(`qq`), ISNULL(`email`), ISNULL(`updatetime`), ISNULL(`logintime`), ISNULL(`logintoken`), ISNULL(`extendcode`), ISNULL(`ip`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`accountinfo` /*checksum table*/
2021-07-16T03:48:52.468489Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.471381Z	11767 Query	BEGIN
2021-07-16T03:48:52.471669Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003665', master_crc = '734880f9', master_cnt = '55' WHERE db = 'niuniuh5_db' AND tbl = 'accountinfo' AND chunk = '1'
2021-07-16T03:48:52.471705Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.472231Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:52.475234Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:52.476504Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:52.478387Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:52.479463Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:52.481509Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2086037, 60 )
2021-07-16T03:48:52.482507Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='accountinfo' AND master_crc IS NOT NULL
2021-07-16T03:48:52.483732Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='accountinfo')
2021-07-16T03:48:52.487785Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'accountinrole'
2021-07-16T03:48:52.489999Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:52.490799Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.491621Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`accountinrole`
2021-07-16T03:48:52.492718Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:52.493815Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`accountinrole` WHERE 1=1
2021-07-16T03:48:52.498323Z	11767 Query	BEGIN
2021-07-16T03:48:52.498579Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'accountinrole'
2021-07-16T03:48:52.498626Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.501962Z	11767 Query	BEGIN
2021-07-16T03:48:52.502307Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'accountinrole', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, convert(`enterpriseid` using utf8mb4), convert(`treecode` using utf8mb4), `accountid`, `roleid`, `status`, UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`updatetime`), CONCAT(ISNULL(`updatetime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`accountinrole` /*checksum table*/
2021-07-16T03:48:52.502351Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.505577Z	11767 Query	BEGIN
2021-07-16T03:48:52.505814Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.002759', master_crc = 'ccb045fe', master_cnt = '11' WHERE db = 'niuniuh5_db' AND tbl = 'accountinrole' AND chunk = '1'
2021-07-16T03:48:52.505847Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.506432Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:52.509304Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:52.510539Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:52.512471Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:52.513554Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:52.515579Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2087746, 60 )
2021-07-16T03:48:52.516502Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='accountinrole' AND master_crc IS NOT NULL
2021-07-16T03:48:52.517580Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='accountinrole')
2021-07-16T03:48:52.521352Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'accountorroleinrule'
2021-07-16T03:48:52.523663Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:52.524530Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.525393Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`accountorroleinrule`
2021-07-16T03:48:52.526568Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:52.527732Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`accountorroleinrule` WHERE 1=1
2021-07-16T03:48:52.532638Z	11767 Query	BEGIN
2021-07-16T03:48:52.532896Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'accountorroleinrule'
2021-07-16T03:48:52.532934Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.536820Z	11767 Query	BEGIN
2021-07-16T03:48:52.537331Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'accountorroleinrule', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, convert(`enterpriseid` using utf8mb4), convert(`treecode` using utf8mb4), `accountorroleid`, `ruleid`, `relationtype`, `status`, UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`updatetime`), CONCAT(ISNULL(`updatetime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`accountorroleinrule` /*checksum table*/
2021-07-16T03:48:52.537380Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.540321Z	11767 Query	BEGIN
2021-07-16T03:48:52.540572Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003365', master_crc = '3d18448', master_cnt = '120' WHERE db = 'niuniuh5_db' AND tbl = 'accountorroleinrule' AND chunk = '1'
2021-07-16T03:48:52.540613Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.541182Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:52.544146Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:52.545384Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:52.547223Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:52.548307Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:52.550492Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2089501, 60 )
2021-07-16T03:48:52.551413Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='accountorroleinrule' AND master_crc IS NOT NULL
2021-07-16T03:48:52.552594Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='accountorroleinrule')
2021-07-16T03:48:52.556320Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'admin\_ipapilib'
2021-07-16T03:48:52.558553Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:52.559414Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.560264Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`admin_ipapilib`
2021-07-16T03:48:52.561489Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:52.562643Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`admin_ipapilib` WHERE 1=1
2021-07-16T03:48:52.567444Z	11767 Query	BEGIN
2021-07-16T03:48:52.567693Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'admin_ipapilib'
2021-07-16T03:48:52.567724Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.571562Z	11767 Query	BEGIN
2021-07-16T03:48:52.571888Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'admin_ipapilib', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, convert(`ipaddress` using utf8mb4), convert(`remark` using utf8mb4), `userid`, `nclubid`, `createuserid`, `valid`, UNIX_TIMESTAMP(`createtime`), CONCAT(ISNULL(`remark`), ISNULL(`createtime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`admin_ipapilib` /*checksum table*/
2021-07-16T03:48:52.571950Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.575271Z	11767 Query	BEGIN
2021-07-16T03:48:52.575569Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003200', master_crc = 'ba8f61f4', master_cnt = '2' WHERE db = 'niuniuh5_db' AND tbl = 'admin_ipapilib' AND chunk = '1'
2021-07-16T03:48:52.575598Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.576039Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:52.578881Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:52.580112Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:52.581904Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:52.582949Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:52.584927Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2091209, 60 )
2021-07-16T03:48:52.585829Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='admin_ipapilib' AND master_crc IS NOT NULL
2021-07-16T03:48:52.586935Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='admin_ipapilib')
2021-07-16T03:48:52.590319Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'admin\_iplib'
2021-07-16T03:48:52.592525Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:52.593359Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.594199Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`admin_iplib`
2021-07-16T03:48:52.595345Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:52.596498Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`admin_iplib` WHERE 1=1
2021-07-16T03:48:52.601071Z	11767 Query	BEGIN
2021-07-16T03:48:52.601291Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'admin_iplib'
2021-07-16T03:48:52.601322Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.605642Z	11767 Query	BEGIN
2021-07-16T03:48:52.606721Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'admin_iplib', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, convert(`ipaddress` using utf8mb4), convert(`remark` using utf8mb4), `userid`, `createuserid`, `valid`, UNIX_TIMESTAMP(`createtime`), CONCAT(ISNULL(`remark`), ISNULL(`createtime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`admin_iplib` /*checksum table*/
2021-07-16T03:48:52.606776Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.609465Z	11767 Query	BEGIN
2021-07-16T03:48:52.609700Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003671', master_crc = '2b5cfc1e', master_cnt = '365' WHERE db = 'niuniuh5_db' AND tbl = 'admin_iplib' AND chunk = '1'
2021-07-16T03:48:52.609738Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.610301Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:52.613206Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:52.614418Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:52.616462Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:52.617527Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:52.619646Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2092896, 60 )
2021-07-16T03:48:52.620574Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='admin_iplib' AND master_crc IS NOT NULL
2021-07-16T03:48:52.621658Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='admin_iplib')
2021-07-16T03:48:52.625152Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'admin\_log'
2021-07-16T03:48:52.627377Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:52.628226Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.629060Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`admin_log`
2021-07-16T03:48:52.630268Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:52.631400Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`admin_log` WHERE 1=1
2021-07-16T03:48:52.636084Z	11767 Query	BEGIN
2021-07-16T03:48:52.636303Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'admin_log'
2021-07-16T03:48:52.636335Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.646020Z	11767 Query	BEGIN
2021-07-16T03:48:52.650226Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:52.652907Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'admin_log', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `type`, `userid`, `targetid`, `amount`, convert(`des` using utf8mb4), UNIX_TIMESTAMP(`createtime`), CONCAT(ISNULL(`nclubid`), ISNULL(`type`), ISNULL(`userid`), ISNULL(`targetid`), ISNULL(`amount`), ISNULL(`des`), ISNULL(`createtime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`admin_log` /*checksum table*/
2021-07-16T03:48:52.652960Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.653126Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:52.653224Z	11767 Query	BEGIN
2021-07-16T03:48:52.653495Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.009122', master_crc = '1438d651', master_cnt = '3085' WHERE db = 'niuniuh5_db' AND tbl = 'admin_log' AND chunk = '1'
2021-07-16T03:48:52.653542Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.654457Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:52.656304Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:52.657401Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:52.659408Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2094641, 60 )
2021-07-16T03:48:52.660440Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='admin_log' AND master_crc IS NOT NULL
2021-07-16T03:48:52.661575Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='admin_log')
2021-07-16T03:48:52.665277Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'admin\_module'
2021-07-16T03:48:52.667507Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:52.668392Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.669259Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`admin_module`
2021-07-16T03:48:52.670432Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:52.671646Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`admin_module` WHERE 1=1
2021-07-16T03:48:52.676146Z	11767 Query	BEGIN
2021-07-16T03:48:52.676385Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'admin_module'
2021-07-16T03:48:52.676432Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.681589Z	11767 Query	BEGIN
2021-07-16T03:48:52.683459Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'admin_module', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `moduleid`, `modulepid`, convert(`modulename` using utf8mb4), `moduletype`, convert(`modulepagepath` using utf8mb4), convert(`moduleclassname` using utf8mb4), `valid`, convert(`des` using utf8mb4), `modulesortid`, UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`modifytime`), `systype`, `buttontype`, CONCAT(ISNULL(`moduletype`), ISNULL(`modulepagepath`), ISNULL(`moduleclassname`), ISNULL(`valid`), ISNULL(`des`), ISNULL(`modulesortid`), ISNULL(`createtime`), ISNULL(`modifytime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`admin_module` /*checksum table*/
2021-07-16T03:48:52.683499Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.685449Z	11767 Query	BEGIN
2021-07-16T03:48:52.685693Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.004665', master_crc = '9e56037a', master_cnt = '581' WHERE db = 'niuniuh5_db' AND tbl = 'admin_module' AND chunk = '1'
2021-07-16T03:48:52.685727Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.686282Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:52.689078Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:52.690352Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:52.692240Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:52.693279Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:52.695201Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2096626, 60 )
2021-07-16T03:48:52.696109Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='admin_module' AND master_crc IS NOT NULL
2021-07-16T03:48:52.697225Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='admin_module')
2021-07-16T03:48:52.700779Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'admin\_proxy'
2021-07-16T03:48:52.702984Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:52.703773Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.704593Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`admin_proxy`
2021-07-16T03:48:52.705479Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:52.706807Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`admin_proxy` WHERE 1=1
2021-07-16T03:48:52.711579Z	11767 Query	BEGIN
2021-07-16T03:48:52.711764Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'admin_proxy'
2021-07-16T03:48:52.711793Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.716042Z	11767 Query	BEGIN
2021-07-16T03:48:52.716674Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'admin_proxy', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `userid`, `proxytype`, `userpid`, `rate`, `nplayerid`, `nclubid`, `iscreate`, `createuserid`, UNIX_TIMESTAMP(`createtime`), convert(`deskey` using utf8mb4), convert(`md5key` using utf8mb4), `nscore`, `ntype`, convert(`username` using utf8mb4), `gameproxytype`, `nlevel`, `istest`, CONCAT(ISNULL(`proxytype`), ISNULL(`nplayerid`), ISNULL(`nclubid`), ISNULL(`createtime`), ISNULL(`deskey`), ISNULL(`md5key`), ISNULL(`username`), ISNULL(`gameproxytype`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`admin_proxy` /*checksum table*/
2021-07-16T03:48:52.716711Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.719762Z	11767 Query	BEGIN
2021-07-16T03:48:52.719947Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003596', master_crc = 'cc6b234c', master_cnt = '101' WHERE db = 'niuniuh5_db' AND tbl = 'admin_proxy' AND chunk = '1'
2021-07-16T03:48:52.719979Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.720521Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:52.723472Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:52.724741Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:52.726584Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:52.727655Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:52.729659Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2098584, 60 )
2021-07-16T03:48:52.730559Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='admin_proxy' AND master_crc IS NOT NULL
2021-07-16T03:48:52.731607Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='admin_proxy')
2021-07-16T03:48:52.735371Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'admin\_role'
2021-07-16T03:48:52.737589Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:52.738409Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.739251Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`admin_role`
2021-07-16T03:48:52.740386Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:52.741553Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`admin_role` WHERE 1=1
2021-07-16T03:48:52.745986Z	11767 Query	BEGIN
2021-07-16T03:48:52.746229Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'admin_role'
2021-07-16T03:48:52.746258Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.750013Z	11767 Query	BEGIN
2021-07-16T03:48:52.750345Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'admin_role', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `roleid`, convert(`rolename` using utf8mb4), `valid`, convert(`des` using utf8mb4), UNIX_TIMESTAMP(`createtime`), `systype`, `createuserid`, `userpid`, `topuserid`, CONCAT(ISNULL(`valid`), ISNULL(`des`), ISNULL(`createtime`), ISNULL(`systype`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`admin_role` /*checksum table*/
2021-07-16T03:48:52.750407Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.753721Z	11767 Query	BEGIN
2021-07-16T03:48:52.753909Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003222', master_crc = '25390a9c', master_cnt = '28' WHERE db = 'niuniuh5_db' AND tbl = 'admin_role' AND chunk = '1'
2021-07-16T03:48:52.753948Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.754473Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:52.757441Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:52.758685Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:52.760540Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:52.761534Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:52.763501Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2100324, 60 )
2021-07-16T03:48:52.764439Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='admin_role' AND master_crc IS NOT NULL
2021-07-16T03:48:52.765527Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='admin_role')
2021-07-16T03:48:52.769108Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'admin\_rolemodule'
2021-07-16T03:48:52.771339Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:52.772219Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.773110Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`admin_rolemodule`
2021-07-16T03:48:52.774151Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:52.775245Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`admin_rolemodule` WHERE 1=1
2021-07-16T03:48:52.779903Z	11767 Query	BEGIN
2021-07-16T03:48:52.780104Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'admin_rolemodule'
2021-07-16T03:48:52.780132Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.784748Z	11767 Query	BEGIN
2021-07-16T03:48:52.785951Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'admin_rolemodule', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `roleid`, `moduleid`, UNIX_TIMESTAMP(`createtime`), CONCAT(ISNULL(`createtime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`admin_rolemodule` /*checksum table*/
2021-07-16T03:48:52.786000Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.787931Z	11767 Query	BEGIN
2021-07-16T03:48:52.788245Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.004031', master_crc = 'b6d85abb', master_cnt = '831' WHERE db = 'niuniuh5_db' AND tbl = 'admin_rolemodule' AND chunk = '1'
2021-07-16T03:48:52.788280Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.788803Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:52.791620Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:52.792894Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:52.794622Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:52.795626Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:52.797480Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2101931, 60 )
2021-07-16T03:48:52.798404Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='admin_rolemodule' AND master_crc IS NOT NULL
2021-07-16T03:48:52.799623Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='admin_rolemodule')
2021-07-16T03:48:52.803276Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'admin\_user'
2021-07-16T03:48:52.805619Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:52.806565Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.807434Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`admin_user`
2021-07-16T03:48:52.808546Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:52.809776Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`admin_user` WHERE 1=1
2021-07-16T03:48:52.814396Z	11767 Query	BEGIN
2021-07-16T03:48:52.814652Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'admin_user'
2021-07-16T03:48:52.814682Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.818500Z	11767 Query	BEGIN
2021-07-16T03:48:52.819149Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'admin_user', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `userid`, `usertype`, convert(`username` using utf8mb4), convert(`userpassord` using utf8mb4), convert(`usernickname` using utf8mb4), convert(`userphone` using utf8mb4), convert(`useremail` using utf8mb4), convert(`remark` using utf8mb4), `status`, UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`lastlogintime`), CONCAT(ISNULL(`usertype`), ISNULL(`username`), ISNULL(`usernickname`), ISNULL(`userphone`), ISNULL(`useremail`), ISNULL(`remark`), ISNULL(`createtime`), ISNULL(`lastlogintime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`admin_user` /*checksum table*/
2021-07-16T03:48:52.819186Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.821868Z	11767 Query	BEGIN
2021-07-16T03:48:52.822053Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003322', master_crc = '3f1ba3c5', master_cnt = '117' WHERE db = 'niuniuh5_db' AND tbl = 'admin_user' AND chunk = '1'
2021-07-16T03:48:52.822089Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.822632Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:52.825449Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:52.826725Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:52.828492Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:52.829557Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:52.831445Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2103917, 60 )
2021-07-16T03:48:52.832433Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='admin_user' AND master_crc IS NOT NULL
2021-07-16T03:48:52.833608Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='admin_user')
2021-07-16T03:48:52.837455Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'admin\_usermodule'
2021-07-16T03:48:52.839693Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:52.840527Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.841394Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`admin_usermodule`
2021-07-16T03:48:52.842460Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:52.843598Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`admin_usermodule` WHERE 1=1
2021-07-16T03:48:52.847861Z	11767 Query	BEGIN
2021-07-16T03:48:52.848045Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'admin_usermodule'
2021-07-16T03:48:52.848074Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.852254Z	11767 Query	BEGIN
2021-07-16T03:48:52.853368Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'admin_usermodule', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `userid`, `moduleid`, UNIX_TIMESTAMP(`createtime`), CONCAT(ISNULL(`createtime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`admin_usermodule` /*checksum table*/
2021-07-16T03:48:52.853408Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.855834Z	11767 Query	BEGIN
2021-07-16T03:48:52.856059Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003585', master_crc = 'f0011bdf', master_cnt = '820' WHERE db = 'niuniuh5_db' AND tbl = 'admin_usermodule' AND chunk = '1'
2021-07-16T03:48:52.856091Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.856670Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:52.859564Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:52.860841Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:52.862767Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:52.863836Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:52.866075Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2105524, 60 )
2021-07-16T03:48:52.867010Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='admin_usermodule' AND master_crc IS NOT NULL
2021-07-16T03:48:52.868092Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='admin_usermodule')
2021-07-16T03:48:52.871504Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'admin\_userrole'
2021-07-16T03:48:52.873903Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:52.874728Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.875561Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`admin_userrole`
2021-07-16T03:48:52.876653Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:52.877698Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`admin_userrole` WHERE 1=1
2021-07-16T03:48:52.882251Z	11767 Query	BEGIN
2021-07-16T03:48:52.882480Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'admin_userrole'
2021-07-16T03:48:52.882532Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.886531Z	11767 Query	BEGIN
2021-07-16T03:48:52.886858Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'admin_userrole', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `userid`, `roleid`, UNIX_TIMESTAMP(`createtime`), CONCAT(ISNULL(`createtime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`admin_userrole` /*checksum table*/
2021-07-16T03:48:52.886901Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.890144Z	11767 Query	BEGIN
2021-07-16T03:48:52.890394Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003181', master_crc = 'adaf019a', master_cnt = '56' WHERE db = 'niuniuh5_db' AND tbl = 'admin_userrole' AND chunk = '1'
2021-07-16T03:48:52.890429Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.890968Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:52.893729Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:52.894926Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:52.896798Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:52.897853Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:52.899762Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2107120, 60 )
2021-07-16T03:48:52.900703Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='admin_userrole' AND master_crc IS NOT NULL
2021-07-16T03:48:52.901764Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='admin_userrole')
2021-07-16T03:48:52.905293Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'admin\_usersub'
2021-07-16T03:48:52.907495Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:52.908306Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.909146Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`admin_usersub`
2021-07-16T03:48:52.910206Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:52.911397Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`admin_usersub` WHERE 1=1
2021-07-16T03:48:52.915713Z	11767 Query	BEGIN
2021-07-16T03:48:52.915957Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'admin_usersub'
2021-07-16T03:48:52.915993Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.919531Z	11767 Query	BEGIN
2021-07-16T03:48:52.919952Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'admin_usersub', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `userid`, convert(`username` using utf8mb4), `userpid`, `nlevel`, UNIX_TIMESTAMP(`createtime`), CONCAT(ISNULL(`nlevel`), ISNULL(`createtime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`admin_usersub` /*checksum table*/
2021-07-16T03:48:52.919998Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.922989Z	11767 Query	BEGIN
2021-07-16T03:48:52.923260Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003022', master_crc = '852b596a', master_cnt = '14' WHERE db = 'niuniuh5_db' AND tbl = 'admin_usersub' AND chunk = '1'
2021-07-16T03:48:52.923297Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.923727Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:52.926546Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:52.927761Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:52.929686Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:52.930768Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:52.932759Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2108776, 60 )
2021-07-16T03:48:52.933760Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='admin_usersub' AND master_crc IS NOT NULL
2021-07-16T03:48:52.934926Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='admin_usersub')
2021-07-16T03:48:52.938492Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'effectivenumber\_daylog'
2021-07-16T03:48:52.940674Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:52.941487Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.942379Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`effectivenumber_daylog`
2021-07-16T03:48:52.943577Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:52.944700Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`effectivenumber_daylog` WHERE 1=1
2021-07-16T03:48:52.949188Z	11767 Query	BEGIN
2021-07-16T03:48:52.949458Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'effectivenumber_daylog'
2021-07-16T03:48:52.949491Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.953138Z	11767 Query	BEGIN
2021-07-16T03:48:52.953573Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'effectivenumber_daylog', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `sum`, `mnnsum`, `mylsum`, `mslsum`, `mhxsum`, `mggsum`, `mlssum`, `mlzsum`, `mglsum`, `pbzsum`, `psysum`, UNIX_TIMESTAMP(`createtime`), `psszsum`, `mwzsum`, `pddzsum`, CONCAT(ISNULL(`sum`), ISNULL(`mnnsum`), ISNULL(`mylsum`), ISNULL(`mslsum`), ISNULL(`mhxsum`), ISNULL(`mggsum`), ISNULL(`mlssum`), ISNULL(`mlzsum`), ISNULL(`mglsum`), ISNULL(`pbzsum`), ISNULL(`psysum`), ISNULL(`createtime`), ISNULL(`psszsum`), ISNULL(`mwzsum`), ISNULL(`pddzsum`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`effectivenumber_daylog` /*checksum table*/
2021-07-16T03:48:52.953619Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.956676Z	11767 Query	BEGIN
2021-07-16T03:48:52.956961Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003055', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'effectivenumber_daylog' AND chunk = '1'
2021-07-16T03:48:52.956998Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.957412Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:52.960292Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:52.961537Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:52.963350Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:52.964406Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:52.966353Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2110750, 60 )
2021-07-16T03:48:52.967255Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='effectivenumber_daylog' AND master_crc IS NOT NULL
2021-07-16T03:48:52.968326Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='effectivenumber_daylog')
2021-07-16T03:48:52.972071Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'enterpricemanage'
2021-07-16T03:48:52.974300Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:52.975157Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:52.976026Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`enterpricemanage`
2021-07-16T03:48:52.977222Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:52.978377Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`enterpricemanage` WHERE 1=1
2021-07-16T03:48:52.982553Z	11767 Query	BEGIN
2021-07-16T03:48:52.982785Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'enterpricemanage'
2021-07-16T03:48:52.982819Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.986203Z	11767 Query	BEGIN
2021-07-16T03:48:52.986555Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'enterpricemanage', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, convert(`enterpriceid` using utf8mb4), `nclubid`, `nplayerid`, `nstatus`, UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`modifytime`), CONCAT(ISNULL(`modifytime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`enterpricemanage` /*checksum table*/
2021-07-16T03:48:52.986603Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.989770Z	11767 Query	BEGIN
2021-07-16T03:48:52.990080Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.002939', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'enterpricemanage' AND chunk = '1'
2021-07-16T03:48:52.990125Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:52.990528Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:52.993265Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:52.994473Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:52.996331Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:52.997377Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:52.999337Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2112414, 60 )
2021-07-16T03:48:53.000263Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='enterpricemanage' AND master_crc IS NOT NULL
2021-07-16T03:48:53.001496Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='enterpricemanage')
2021-07-16T03:48:53.006241Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'enterprise'
2021-07-16T03:48:53.008556Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:53.009410Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.010265Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`enterprise`
2021-07-16T03:48:53.011603Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:53.013266Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`enterprise` WHERE 1=1
2021-07-16T03:48:53.018309Z	11767 Query	BEGIN
2021-07-16T03:48:53.018580Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'enterprise'
2021-07-16T03:48:53.018613Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.022843Z	11767 Query	BEGIN
2021-07-16T03:48:53.023657Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'enterprise', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', convert(`enterpriseid` using utf8mb4), convert(`name` using utf8mb4), convert(`treecode` using utf8mb4), convert(`pid` using utf8mb4), `grade`, `accountid`, convert(`entersignature` using utf8mb4), `balancemoney`, `zmsprice`, `smsprice`, `mmsprice`, `xmsprice`, `dmsprice`, `balance`, convert(`contact` using utf8mb4), convert(`telephone` using utf8mb4), convert(`address` using utf8mb4), convert(`weixin` using utf8mb4), convert(`remark` using utf8mb4), `status`, UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`updatetime`), convert(`ipauthentication` using utf8mb4), convert(`extendcode` using utf8mb4), `groupno`, `prompt`, `nplayerid`, convert(`openid` using utf8mb4), `waitpaymoney`, `enterprisetype`, `twolevel`, `threelevel`, convert(`pageopenid` using utf8mb4), `gameplayerid`, CONCAT(ISNULL(`entersignature`), ISNULL(`zmsprice`), ISNULL(`smsprice`), ISNULL(`mmsprice`), ISNULL(`xmsprice`), ISNULL(`dmsprice`), ISNULL(`balance`), ISNULL(`contact`), ISNULL(`telephone`), ISNULL(`address`), ISNULL(`weixin`), ISNULL(`remark`), ISNULL(`ipauthentication`), ISNULL(`extendcode`), ISNULL(`groupno`), ISNULL(`prompt`), ISNULL(`nplayerid`), ISNULL(`openid`), ISNULL(`waitpaymoney`), ISNULL(`enterprisetype`), ISNULL(`twolevel`), ISNULL(`threelevel`), ISNULL(`pageopenid`), ISNULL(`gameplayerid`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`enterprise` /*checksum table*/
2021-07-16T03:48:53.023705Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.026415Z	11767 Query	BEGIN
2021-07-16T03:48:53.026691Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003489', master_crc = '1ad58fe2', master_cnt = '41' WHERE db = 'niuniuh5_db' AND tbl = 'enterprise' AND chunk = '1'
2021-07-16T03:48:53.026734Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.027244Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:53.030127Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:53.031365Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:53.033235Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:53.034313Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:53.036240Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2115205, 60 )
2021-07-16T03:48:53.037156Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='enterprise' AND master_crc IS NOT NULL
2021-07-16T03:48:53.038253Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='enterprise')
2021-07-16T03:48:53.041950Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'enterpriselog'
2021-07-16T03:48:53.044203Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:53.045029Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.045837Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`enterpriselog`
2021-07-16T03:48:53.046973Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:53.048117Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`enterpriselog` WHERE 1=1
2021-07-16T03:48:53.052945Z	11767 Query	BEGIN
2021-07-16T03:48:53.053223Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'enterpriselog'
2021-07-16T03:48:53.053257Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.060125Z	11767 Query	BEGIN
2021-07-16T03:48:53.064294Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'enterpriselog', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `operatetype`, `operateplayerid`, `targetplayerid`, convert(`remark` using utf8mb4), UNIX_TIMESTAMP(`createtime`), CONCAT(ISNULL(`nclubid`), ISNULL(`operatetype`), ISNULL(`operateplayerid`), ISNULL(`targetplayerid`), ISNULL(`remark`), ISNULL(`createtime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`enterpriselog` /*checksum table*/
2021-07-16T03:48:53.064345Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.064561Z	11767 Query	BEGIN
2021-07-16T03:48:53.064675Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:53.064848Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.006456', master_crc = '96357984', master_cnt = '1851' WHERE db = 'niuniuh5_db' AND tbl = 'enterpriselog' AND chunk = '1'
2021-07-16T03:48:53.064891Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.067556Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:53.068794Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:53.070652Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:53.071678Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:53.073625Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2116988, 60 )
2021-07-16T03:48:53.074562Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='enterpriselog' AND master_crc IS NOT NULL
2021-07-16T03:48:53.075779Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='enterpriselog')
2021-07-16T03:48:53.079867Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'operationslog'
2021-07-16T03:48:53.082089Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:53.082969Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.083806Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`operationslog`
2021-07-16T03:48:53.084905Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:53.086111Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`operationslog` WHERE 1=1
2021-07-16T03:48:53.090622Z	11767 Query	BEGIN
2021-07-16T03:48:53.090897Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'operationslog'
2021-07-16T03:48:53.090931Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.096582Z	11767 Query	BEGIN
2021-07-16T03:48:53.098928Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'operationslog', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `operateid`, `adminid`, `otype`, CRC32(`omsg`), UNIX_TIMESTAMP(`createtime`), convert(`adminname` using utf8mb4), convert(`pkid` using utf8mb4), convert(`formobject` using utf8mb4), `availflag`, `operationstype`, convert(`enterpriseid` using utf8mb4), `gametype`, CONCAT(ISNULL(`omsg`), ISNULL(`pkid`), ISNULL(`formobject`), ISNULL(`enterpriseid`), ISNULL(`gametype`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`operationslog` /*checksum table*/
2021-07-16T03:48:53.098980Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.100060Z	11767 Query	BEGIN
2021-07-16T03:48:53.100316Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.005080', master_crc = 'd039254f', master_cnt = '689' WHERE db = 'niuniuh5_db' AND tbl = 'operationslog' AND chunk = '1'
2021-07-16T03:48:53.100353Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.100747Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:53.103558Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:53.104776Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:53.106573Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:53.107606Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:53.109577Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2118865, 60 )
2021-07-16T03:48:53.110540Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='operationslog' AND master_crc IS NOT NULL
2021-07-16T03:48:53.111639Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='operationslog')
2021-07-16T03:48:53.115862Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'rechargedetail'
2021-07-16T03:48:53.118005Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:53.118807Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.119604Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`rechargedetail`
2021-07-16T03:48:53.120824Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:53.122356Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`rechargedetail` WHERE 1=1
2021-07-16T03:48:53.127004Z	11767 Query	BEGIN
2021-07-16T03:48:53.127292Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'rechargedetail'
2021-07-16T03:48:53.127346Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.131350Z	11767 Query	BEGIN
2021-07-16T03:48:53.131915Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'rechargedetail', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `type`, convert(`batchid` using utf8mb4), convert(`batchname` using utf8mb4), `price`, `msgcount`, `amount`, `opaccountid`, convert(`opaccountname` using utf8mb4), convert(`openterpriseid` using utf8mb4), convert(`openterprisetreecode` using utf8mb4), convert(`enterpriseid` using utf8mb4), convert(`enterprisetreecode` using utf8mb4), `currentbalance`, UNIX_TIMESTAMP(`createtime`), convert(`remark` using utf8mb4), convert(`usercode` using utf8mb4), `consumemoney`, convert(`orderid` using utf8mb4), `deducemoney`, `gametype`, CONCAT(ISNULL(`batchid`), ISNULL(`batchname`), ISNULL(`price`), ISNULL(`msgcount`), ISNULL(`opaccountid`), ISNULL(`opaccountname`), ISNULL(`openterpriseid`), ISNULL(`openterprisetreecode`), ISNULL(`remark`), ISNULL(`usercode`), ISNULL(`consumemoney`), ISNULL(`orderid`), ISNULL(`deducemoney`), ISNULL(`gametype`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`rechargedetail` /*checksum table*/
2021-07-16T03:48:53.131973Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.134936Z	11767 Query	BEGIN
2021-07-16T03:48:53.135164Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003345', master_crc = 'e6d04b53', master_cnt = '30' WHERE db = 'niuniuh5_db' AND tbl = 'rechargedetail' AND chunk = '1'
2021-07-16T03:48:53.135207Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.135838Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:53.138682Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:53.139864Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:53.141680Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:53.142734Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:53.144604Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2121225, 60 )
2021-07-16T03:48:53.145662Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='rechargedetail' AND master_crc IS NOT NULL
2021-07-16T03:48:53.146751Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='rechargedetail')
2021-07-16T03:48:53.150545Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'roleinfo'
2021-07-16T03:48:53.152728Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:53.153545Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.154375Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`roleinfo`
2021-07-16T03:48:53.155535Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:53.156657Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`roleinfo` WHERE 1=1
2021-07-16T03:48:53.161008Z	11767 Query	BEGIN
2021-07-16T03:48:53.161256Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'roleinfo'
2021-07-16T03:48:53.161290Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.165337Z	11767 Query	BEGIN
2021-07-16T03:48:53.165738Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'roleinfo', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `roleid`, convert(`enterpriseid` using utf8mb4), convert(`treecode` using utf8mb4), convert(`rolename` using utf8mb4), convert(`describe` using utf8mb4), `status`, UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`updatetime`), CONCAT(ISNULL(`describe`), ISNULL(`updatetime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`roleinfo` /*checksum table*/
2021-07-16T03:48:53.165792Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.169294Z	11767 Query	BEGIN
2021-07-16T03:48:53.169585Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003321', master_crc = '3211ff2', master_cnt = '2' WHERE db = 'niuniuh5_db' AND tbl = 'roleinfo' AND chunk = '1'
2021-07-16T03:48:53.169624Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.170090Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:53.172867Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:53.174059Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:53.175803Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:53.176857Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:53.178781Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2122983, 60 )
2021-07-16T03:48:53.179722Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='roleinfo' AND master_crc IS NOT NULL
2021-07-16T03:48:53.180854Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='roleinfo')
2021-07-16T03:48:53.184623Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'ruleinfo'
2021-07-16T03:48:53.186785Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:53.187606Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.188406Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`ruleinfo`
2021-07-16T03:48:53.189570Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:53.190843Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`ruleinfo` WHERE 1=1
2021-07-16T03:48:53.195479Z	11767 Query	BEGIN
2021-07-16T03:48:53.195724Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'ruleinfo'
2021-07-16T03:48:53.195764Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.200263Z	11767 Query	BEGIN
2021-07-16T03:48:53.201053Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'ruleinfo', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `ruleid`, `pid`, convert(`rulename` using utf8mb4), `ruletype`, convert(`describe` using utf8mb4), convert(`pagepath` using utf8mb4), convert(`btnclientclick` using utf8mb4), convert(`btnserverclick` using utf8mb4), convert(`btnicon` using utf8mb4), `datascope`, `sequeueno`, `status`, UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`updatetime`), convert(`handlepath` using utf8mb4), CONCAT(ISNULL(`describe`), ISNULL(`pagepath`), ISNULL(`btnclientclick`), ISNULL(`btnserverclick`), ISNULL(`btnicon`), ISNULL(`datascope`), ISNULL(`updatetime`), ISNULL(`handlepath`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`ruleinfo` /*checksum table*/
2021-07-16T03:48:53.201096Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.203769Z	11767 Query	BEGIN
2021-07-16T03:48:53.204035Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003819', master_crc = '1deab261', master_cnt = '115' WHERE db = 'niuniuh5_db' AND tbl = 'ruleinfo' AND chunk = '1'
2021-07-16T03:48:53.204071Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.204538Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:53.207284Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:53.208489Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:53.210303Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:53.211367Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:53.213276Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2125037, 60 )
2021-07-16T03:48:53.214236Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='ruleinfo' AND master_crc IS NOT NULL
2021-07-16T03:48:53.215368Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='ruleinfo')
2021-07-16T03:48:53.218763Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'script\_status'
2021-07-16T03:48:53.221028Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:53.221837Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.222632Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`script_status`
2021-07-16T03:48:53.223710Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:53.224784Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`script_status` WHERE 1=1
2021-07-16T03:48:53.228926Z	11767 Query	BEGIN
2021-07-16T03:48:53.229183Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'script_status'
2021-07-16T03:48:53.229217Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.233437Z	11767 Query	BEGIN
2021-07-16T03:48:53.233865Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'script_status', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, convert(`script_name` using utf8mb4), `end_point`, `status`, `end_date`, UNIX_TIMESTAMP(`start_date`), CONCAT(ISNULL(`end_date`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`script_status` /*checksum table*/
2021-07-16T03:48:53.233931Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.237076Z	11767 Query	BEGIN
2021-07-16T03:48:53.237326Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003614', master_crc = '2fc4a0f9', master_cnt = '1' WHERE db = 'niuniuh5_db' AND tbl = 'script_status' AND chunk = '1'
2021-07-16T03:48:53.237366Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.237983Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:53.240862Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:53.242144Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:53.243956Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:53.244974Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:53.246876Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2126679, 60 )
2021-07-16T03:48:53.247783Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='script_status' AND master_crc IS NOT NULL
2021-07-16T03:48:53.248953Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='script_status')
2021-07-16T03:48:53.252426Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'sys\_code'
2021-07-16T03:48:53.254585Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:53.255402Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.256236Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`sys_code`
2021-07-16T03:48:53.257362Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:53.258489Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`sys_code` WHERE 1=1
2021-07-16T03:48:53.263083Z	11767 Query	BEGIN
2021-07-16T03:48:53.263368Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'sys_code'
2021-07-16T03:48:53.263407Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.267496Z	11767 Query	BEGIN
2021-07-16T03:48:53.268487Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'sys_code', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `code`, convert(`codename` using utf8mb4), `type`, convert(`typename` using utf8mb4), `sortid`, `valid`, CONCAT(ISNULL(`codename`), ISNULL(`typename`), ISNULL(`sortid`), ISNULL(`valid`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`sys_code` /*checksum table*/
2021-07-16T03:48:53.268545Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.271221Z	11767 Query	BEGIN
2021-07-16T03:48:53.271462Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003676', master_crc = '7d95d3e1', master_cnt = '396' WHERE db = 'niuniuh5_db' AND tbl = 'sys_code' AND chunk = '1'
2021-07-16T03:48:53.271498Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.272012Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:53.274850Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:53.276031Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:53.277866Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:53.278908Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:53.280943Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2128344, 60 )
2021-07-16T03:48:53.281904Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='sys_code' AND master_crc IS NOT NULL
2021-07-16T03:48:53.283026Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='sys_code')
2021-07-16T03:48:53.286696Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'systemlog'
2021-07-16T03:48:53.288817Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:53.289639Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.290474Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`systemlog`
2021-07-16T03:48:53.291639Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:53.292802Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`systemlog` WHERE 1=1
2021-07-16T03:48:53.296958Z	11767 Query	BEGIN
2021-07-16T03:48:53.297200Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'systemlog'
2021-07-16T03:48:53.297235Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.300842Z	11767 Query	BEGIN
2021-07-16T03:48:53.301270Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'systemlog', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `logid`, convert(`loglevel` using utf8mb4), convert(`msg` using utf8mb4), convert(`logthread` using utf8mb4), CRC32(`exception`), convert(`logger` using utf8mb4), UNIX_TIMESTAMP(`createtime`), `gametype`, CONCAT(ISNULL(`msg`), ISNULL(`logthread`), ISNULL(`exception`), ISNULL(`logger`), ISNULL(`gametype`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`systemlog` /*checksum table*/
2021-07-16T03:48:53.301319Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.304150Z	11767 Query	BEGIN
2021-07-16T03:48:53.304409Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003043', master_crc = '84f72e84', master_cnt = '11' WHERE db = 'niuniuh5_db' AND tbl = 'systemlog' AND chunk = '1'
2021-07-16T03:48:53.304458Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.304879Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:53.307497Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:53.308687Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:53.310586Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:53.311607Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:53.313545Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2130142, 60 )
2021-07-16T03:48:53.314475Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='systemlog' AND master_crc IS NOT NULL
2021-07-16T03:48:53.315589Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='systemlog')
2021-07-16T03:48:53.319349Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'table\_agent\_apply'
2021-07-16T03:48:53.321629Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:53.322471Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.323316Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_agent_apply`
2021-07-16T03:48:53.324550Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:53.325760Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_agent_apply` WHERE 1=1
2021-07-16T03:48:53.330172Z	11767 Query	BEGIN
2021-07-16T03:48:53.330436Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_agent_apply'
2021-07-16T03:48:53.330478Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.333923Z	11767 Query	BEGIN
2021-07-16T03:48:53.334327Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_agent_apply', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `namount`, `beforepaybalance`, `afterpaybalance`, UNIX_TIMESTAMP(`applytime`), UNIX_TIMESTAMP(`approvaltime`), `nstatus`, convert(`backinfo` using utf8mb4), convert(`remarks` using utf8mb4), convert(`sztoken` using utf8mb4), CONCAT(ISNULL(`approvaltime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_agent_apply` /*checksum table*/
2021-07-16T03:48:53.334379Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.337033Z	11767 Query	BEGIN
2021-07-16T03:48:53.337304Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003039', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_agent_apply' AND chunk = '1'
2021-07-16T03:48:53.337348Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.337785Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:53.340531Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:53.341754Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:53.343575Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:53.344631Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:53.346553Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2131916, 60 )
2021-07-16T03:48:53.347498Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='table_agent_apply' AND master_crc IS NOT NULL
2021-07-16T03:48:53.348552Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='table_agent_apply')
2021-07-16T03:48:53.352110Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'table\_agent\_commission'
2021-07-16T03:48:53.354453Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:53.355301Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.356152Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_agent_commission`
2021-07-16T03:48:53.357356Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:53.358566Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_agent_commission` WHERE 1=1
2021-07-16T03:48:53.362879Z	11767 Query	BEGIN
2021-07-16T03:48:53.363128Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_agent_commission'
2021-07-16T03:48:53.363177Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.366488Z	11767 Query	BEGIN
2021-07-16T03:48:53.366805Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_agent_commission', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `nsubagentid`, `nsourceid`, `ntype`, `ratio`, `namount`, `nrecharge`, UNIX_TIMESTAMP(`createtime`))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_agent_commission` /*checksum table*/
2021-07-16T03:48:53.366860Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.370004Z	11767 Query	BEGIN
2021-07-16T03:48:53.370256Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.002902', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_agent_commission' AND chunk = '1'
2021-07-16T03:48:53.370291Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.370988Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:53.373754Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:53.375084Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:53.376853Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:53.377945Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:53.379889Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2133553, 60 )
2021-07-16T03:48:53.380794Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='table_agent_commission' AND master_crc IS NOT NULL
2021-07-16T03:48:53.381922Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='table_agent_commission')
2021-07-16T03:48:53.385489Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'table\_agent\_info'
2021-07-16T03:48:53.387754Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:53.388568Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.389425Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_agent_info`
2021-07-16T03:48:53.390569Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:53.391721Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_agent_info` WHERE 1=1
2021-07-16T03:48:53.396468Z	11767 Query	BEGIN
2021-07-16T03:48:53.396748Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_agent_info'
2021-07-16T03:48:53.396811Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.400454Z	11767 Query	BEGIN
2021-07-16T03:48:53.400817Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_agent_info', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `upagentid`, `nlevel`, `namount`, `ratio`, convert(`aliaccount` using utf8mb4), convert(`aliname` using utf8mb4), UNIX_TIMESTAMP(`createtime`))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_agent_info` /*checksum table*/
2021-07-16T03:48:53.400867Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.404048Z	11767 Query	BEGIN
2021-07-16T03:48:53.404326Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003288', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_agent_info' AND chunk = '1'
2021-07-16T03:48:53.404368Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.404945Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:53.407689Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:53.408923Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:53.410730Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:53.411738Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:53.413598Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2135210, 60 )
2021-07-16T03:48:53.414561Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='table_agent_info' AND master_crc IS NOT NULL
2021-07-16T03:48:53.415716Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='table_agent_info')
2021-07-16T03:48:53.419073Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'table\_agent\_tree'
2021-07-16T03:48:53.421392Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:53.422201Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.423069Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_agent_tree`
2021-07-16T03:48:53.424210Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:53.425298Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_agent_tree` WHERE 1=1
2021-07-16T03:48:53.429814Z	11767 Query	BEGIN
2021-07-16T03:48:53.430053Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_agent_tree'
2021-07-16T03:48:53.430089Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.433960Z	11767 Query	BEGIN
2021-07-16T03:48:53.434252Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_agent_tree', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `nnextplayerid`, UNIX_TIMESTAMP(`createtime`))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_agent_tree` /*checksum table*/
2021-07-16T03:48:53.434297Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.437413Z	11767 Query	BEGIN
2021-07-16T03:48:53.437664Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003321', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_agent_tree' AND chunk = '1'
2021-07-16T03:48:53.437706Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.438166Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:53.440916Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:53.442048Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:53.443945Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:53.445086Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:53.447055Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2136770, 60 )
2021-07-16T03:48:53.448026Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='table_agent_tree' AND master_crc IS NOT NULL
2021-07-16T03:48:53.449142Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='table_agent_tree')
2021-07-16T03:48:53.452865Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'table\_agentgameresult'
2021-07-16T03:48:53.455071Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:53.455873Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.456661Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_agentgameresult`
2021-07-16T03:48:53.457816Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:53.459049Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_agentgameresult` WHERE 1=1
2021-07-16T03:48:53.463495Z	11767 Query	BEGIN
2021-07-16T03:48:53.463748Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_agentgameresult'
2021-07-16T03:48:53.463783Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.467347Z	11767 Query	BEGIN
2021-07-16T03:48:53.467758Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_agentgameresult', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `extendcode`, convert(`sznickname` using utf8mb4), `ntableid`, `ngameid`, `cost`, `playercount`, `round`, `gameround`, UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`modifytime`), `checkstatus`, CONCAT(ISNULL(`modifytime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_agentgameresult` /*checksum table*/
2021-07-16T03:48:53.467801Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.470750Z	11767 Query	BEGIN
2021-07-16T03:48:53.471008Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.002989', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_agentgameresult' AND chunk = '1'
2021-07-16T03:48:53.471044Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.471525Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:53.474306Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:53.475546Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:53.477299Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:53.478331Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:53.480271Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2138527, 60 )
2021-07-16T03:48:53.481227Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='table_agentgameresult' AND master_crc IS NOT NULL
2021-07-16T03:48:53.482365Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='table_agentgameresult')
2021-07-16T03:48:53.486120Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'table\_agentrec'
2021-07-16T03:48:53.488430Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:53.489318Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.490174Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_agentrec`
2021-07-16T03:48:53.491286Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:53.492610Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_agentrec` WHERE 1=1
2021-07-16T03:48:53.497328Z	11767 Query	BEGIN
2021-07-16T03:48:53.497633Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_agentrec'
2021-07-16T03:48:53.497682Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.501138Z	11767 Query	BEGIN
2021-07-16T03:48:53.501498Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_agentrec', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `extendcode`, convert(`sznickname` using utf8mb4), `ntableid`, `ngameid`, `nmode`, `cost`, `playercount`, `round`, convert(`roominfo` using utf8mb4), `nstatus`, UNIX_TIMESTAMP(`createtime`), `endtime`, CONCAT(ISNULL(`endtime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_agentrec` /*checksum table*/
2021-07-16T03:48:53.501570Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.504879Z	11767 Query	BEGIN
2021-07-16T03:48:53.505142Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003007', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_agentrec' AND chunk = '1'
2021-07-16T03:48:53.505177Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.505784Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:53.508529Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:53.509653Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:53.511658Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:53.512688Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:53.514660Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2140261, 60 )
2021-07-16T03:48:53.515574Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='table_agentrec' AND master_crc IS NOT NULL
2021-07-16T03:48:53.516688Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='table_agentrec')
2021-07-16T03:48:53.520774Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'table\_bet\_inout'
2021-07-16T03:48:53.523041Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:53.523879Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:53.524685Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_bet_inout`
2021-07-16T03:48:53.525782Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:53.531237Z	11767 Query	BEGIN
2021-07-16T03:48:53.531642Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_bet_inout'
2021-07-16T03:48:53.531684Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.637728Z	11767 Query	BEGIN
2021-07-16T03:48:53.642555Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:53.728736Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_bet_inout', '1', 'PRIMARY', '1', '51646', COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `tableid`, `ninouttype`, `namount`, `nfreeamount`, `nplayerscore`, `nplayerfreescore`, `ntablescore`, `ntablefreescore`, UNIX_TIMESTAMP(`createtime`))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_bet_inout` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '1')) AND ((`id` <= '51646')) /*checksum chunk*/
2021-07-16T03:48:53.728821Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:53.729012Z	11767 Query	BEGIN
2021-07-16T03:48:53.729289Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.092035', master_crc = '30058458', master_cnt = '51646' WHERE db = 'niuniuh5_db' AND tbl = 'table_bet_inout' AND chunk = '1'
2021-07-16T03:48:53.729335Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.088628Z	11767 Query	BEGIN
2021-07-16T03:48:54.093444Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:54.104228Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:54.115201Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:54.117873Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:54.119119Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:54.121471Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:54.122606Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:54.124607Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2145584, 60 )
2021-07-16T03:48:54.489683Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_bet_inout', '2', 'PRIMARY', '51647', '278785', COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `tableid`, `ninouttype`, `namount`, `nfreeamount`, `nplayerscore`, `nplayerfreescore`, `ntablescore`, `ntablefreescore`, UNIX_TIMESTAMP(`createtime`))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_bet_inout` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '51647')) AND ((`id` <= '278785')) /*checksum chunk*/
2021-07-16T03:48:54.489781Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.490144Z	11767 Query	BEGIN
2021-07-16T03:48:54.490505Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.390014', master_crc = 'ccb13324', master_cnt = '227139' WHERE db = 'niuniuh5_db' AND tbl = 'table_bet_inout' AND chunk = '2'
2021-07-16T03:48:54.490555Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.490684Z	11767 Query	BEGIN
2021-07-16T03:48:54.491084Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_bet_inout', '3', 'PRIMARY', NULL, '1', COUNT(*), '0' FROM `niuniuh5_db`.`table_bet_inout` FORCE INDEX(`PRIMARY`) WHERE ((`id` < '1')) ORDER BY `id` /*past lower chunk*/
2021-07-16T03:48:54.491128Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.491252Z	11767 Query	BEGIN
2021-07-16T03:48:54.491477Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003132', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_bet_inout' AND chunk = '3'
2021-07-16T03:48:54.491526Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.491676Z	11767 Query	BEGIN
2021-07-16T03:48:54.491950Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_bet_inout', '4', 'PRIMARY', '278785', NULL, COUNT(*), '0' FROM `niuniuh5_db`.`table_bet_inout` FORCE INDEX(`PRIMARY`) WHERE ((`id` > '278785')) ORDER BY `id` /*past upper chunk*/
2021-07-16T03:48:54.491995Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.492167Z	11767 Query	BEGIN
2021-07-16T03:48:54.492398Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003305', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_bet_inout' AND chunk = '4'
2021-07-16T03:48:54.492438Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.493800Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='table_bet_inout' AND master_crc IS NOT NULL
2021-07-16T03:48:54.495065Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='table_bet_inout')
2021-07-16T03:48:54.499196Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'table\_club\_arrears'
2021-07-16T03:48:54.501610Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:54.502471Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.503333Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_arrears`
2021-07-16T03:48:54.504597Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:54.505737Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_arrears` WHERE 1=1
2021-07-16T03:48:54.511020Z	11767 Query	BEGIN
2021-07-16T03:48:54.511272Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_arrears'
2021-07-16T03:48:54.511325Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.514739Z	11767 Query	BEGIN
2021-07-16T03:48:54.515040Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_arrears', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `nclubid`, `namount`, `nstatus`, UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`donetime`), CONCAT(ISNULL(`donetime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_arrears` /*checksum table*/
2021-07-16T03:48:54.515128Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.518694Z	11767 Query	BEGIN
2021-07-16T03:48:54.518898Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003039', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_arrears' AND chunk = '1'
2021-07-16T03:48:54.518934Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.519477Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:54.522322Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:54.523523Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:54.525823Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:54.526841Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:54.528785Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2147224, 60 )
2021-07-16T03:48:54.529723Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='table_club_arrears' AND master_crc IS NOT NULL
2021-07-16T03:48:54.530773Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='table_club_arrears')
2021-07-16T03:48:54.534468Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'table\_club\_cc'
2021-07-16T03:48:54.536803Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:54.537646Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.538472Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_cc`
2021-07-16T03:48:54.539650Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:54.540885Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_cc` WHERE 1=1
2021-07-16T03:48:54.545825Z	11767 Query	BEGIN
2021-07-16T03:48:54.546081Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_cc'
2021-07-16T03:48:54.546117Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.550635Z	11767 Query	BEGIN
2021-07-16T03:48:54.552204Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_cc', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ngameid`, `ncode`, `ntaxrate`, convert(`szdesc` using utf8mb4), `nstatus`, CONCAT(ISNULL(`nstatus`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_cc` /*checksum table*/
2021-07-16T03:48:54.552251Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.554180Z	11767 Query	BEGIN
2021-07-16T03:48:54.554392Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.004059', master_crc = '1280975d', master_cnt = '1018' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_cc' AND chunk = '1'
2021-07-16T03:48:54.554439Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.554943Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:54.557720Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:54.558973Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:54.560925Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:54.562101Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:54.564134Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2148836, 60 )
2021-07-16T03:48:54.564998Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='table_club_cc' AND master_crc IS NOT NULL
2021-07-16T03:48:54.566102Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='table_club_cc')
2021-07-16T03:48:54.569982Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'table\_club\_cc\_code'
2021-07-16T03:48:54.572257Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:54.573038Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.573822Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_cc_code`
2021-07-16T03:48:54.574933Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:54.576004Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_cc_code` WHERE 1=1
2021-07-16T03:48:54.580675Z	11767 Query	BEGIN
2021-07-16T03:48:54.580918Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_cc_code'
2021-07-16T03:48:54.580975Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.584660Z	11767 Query	BEGIN
2021-07-16T03:48:54.585027Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_cc_code', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `ncode`, convert(`szdesc` using utf8mb4))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_cc_code` /*checksum table*/
2021-07-16T03:48:54.585076Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.588391Z	11767 Query	BEGIN
2021-07-16T03:48:54.588670Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003248', master_crc = '5c569dab', master_cnt = '19' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_cc_code' AND chunk = '1'
2021-07-16T03:48:54.588708Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.589146Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:54.591878Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:54.593059Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:54.594881Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:54.595931Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:54.597863Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2150388, 60 )
2021-07-16T03:48:54.598767Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='table_club_cc_code' AND master_crc IS NOT NULL
2021-07-16T03:48:54.599838Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='table_club_cc_code')
2021-07-16T03:48:54.603345Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'table\_club\_cc\_low'
2021-07-16T03:48:54.605645Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:54.606476Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.607289Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_cc_low`
2021-07-16T03:48:54.608405Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:54.609602Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_cc_low` WHERE 1=1
2021-07-16T03:48:54.614346Z	11767 Query	BEGIN
2021-07-16T03:48:54.614659Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_cc_low'
2021-07-16T03:48:54.614707Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.619147Z	11767 Query	BEGIN
2021-07-16T03:48:54.620096Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_cc_low', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ngameid`, `ncode`, `ntaxrate`, convert(`szdesc` using utf8mb4), `nstatus`, CONCAT(ISNULL(`nstatus`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_cc_low` /*checksum table*/
2021-07-16T03:48:54.620141Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.622903Z	11767 Query	BEGIN
2021-07-16T03:48:54.623117Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.004032', master_crc = '46688422', master_cnt = '439' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_cc_low' AND chunk = '1'
2021-07-16T03:48:54.623161Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.623708Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:54.626600Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:54.628061Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:54.629992Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:54.631045Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:54.632978Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2152015, 60 )
2021-07-16T03:48:54.633903Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='table_club_cc_low' AND master_crc IS NOT NULL
2021-07-16T03:48:54.634993Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='table_club_cc_low')
2021-07-16T03:48:54.638499Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'table\_club\_custom\_msg'
2021-07-16T03:48:54.640715Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:54.641547Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.642403Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_custom_msg`
2021-07-16T03:48:54.643556Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:54.644667Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_custom_msg` WHERE 1=1
2021-07-16T03:48:54.649570Z	11767 Query	BEGIN
2021-07-16T03:48:54.649790Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_custom_msg'
2021-07-16T03:48:54.649827Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.653755Z	11767 Query	BEGIN
2021-07-16T03:48:54.654349Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_custom_msg', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `nclubid`, convert(`szmsg` using utf8mb4), UNIX_TIMESTAMP(`createtime`))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_custom_msg` /*checksum table*/
2021-07-16T03:48:54.654402Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.657417Z	11767 Query	BEGIN
2021-07-16T03:48:54.657640Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003544', master_crc = 'a569ddd9', master_cnt = '123' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_custom_msg' AND chunk = '1'
2021-07-16T03:48:54.657686Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.658241Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:54.661000Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:54.662202Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:54.664080Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:54.665203Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:54.667143Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2153646, 60 )
2021-07-16T03:48:54.668085Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='table_club_custom_msg' AND master_crc IS NOT NULL
2021-07-16T03:48:54.669194Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='table_club_custom_msg')
2021-07-16T03:48:54.672755Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'table\_club\_exswitch\_config'
2021-07-16T03:48:54.675113Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:54.675961Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.676780Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_exswitch_config`
2021-07-16T03:48:54.677903Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:54.678988Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_exswitch_config` WHERE 1=1
2021-07-16T03:48:54.683478Z	11767 Query	BEGIN
2021-07-16T03:48:54.683747Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_exswitch_config'
2021-07-16T03:48:54.683782Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.688397Z	11767 Query	BEGIN
2021-07-16T03:48:54.689916Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_exswitch_config', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntype`, `nstatus`)) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_exswitch_config` /*checksum table*/
2021-07-16T03:48:54.689961Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.692012Z	11767 Query	BEGIN
2021-07-16T03:48:54.692240Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.004236', master_crc = 'f2454464', master_cnt = '1386' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_exswitch_config' AND chunk = '1'
2021-07-16T03:48:54.692277Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.692733Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:54.695523Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:54.696705Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:54.698525Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:54.699634Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:54.701629Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2155227, 60 )
2021-07-16T03:48:54.702578Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='table_club_exswitch_config' AND master_crc IS NOT NULL
2021-07-16T03:48:54.703754Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='table_club_exswitch_config')
2021-07-16T03:48:54.707074Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'table\_club\_exten\_config'
2021-07-16T03:48:54.709410Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:54.710265Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.711114Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_exten_config`
2021-07-16T03:48:54.712210Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:54.713316Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_exten_config` WHERE 1=1
2021-07-16T03:48:54.718355Z	11767 Query	BEGIN
2021-07-16T03:48:54.718604Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_exten_config'
2021-07-16T03:48:54.718640Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.722578Z	11767 Query	BEGIN
2021-07-16T03:48:54.722904Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_exten_config', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `namountlow`, `namounthigh`, `nextenrate`)) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_exten_config` /*checksum table*/
2021-07-16T03:48:54.722947Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.726039Z	11767 Query	BEGIN
2021-07-16T03:48:54.726238Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003526', master_crc = 'e71144c8', master_cnt = '8' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_exten_config' AND chunk = '1'
2021-07-16T03:48:54.726275Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.726788Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:54.729469Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:54.730720Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:54.732544Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:54.733609Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:54.735592Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2156816, 60 )
2021-07-16T03:48:54.736491Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='table_club_exten_config' AND master_crc IS NOT NULL
2021-07-16T03:48:54.737604Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='table_club_exten_config')
2021-07-16T03:48:54.741050Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'table\_club\_flow\_data'
2021-07-16T03:48:54.743509Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:54.744337Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.745183Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_flow_data`
2021-07-16T03:48:54.746439Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:54.747590Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_flow_data` WHERE 1=1
2021-07-16T03:48:54.752218Z	11767 Query	BEGIN
2021-07-16T03:48:54.752417Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_flow_data'
2021-07-16T03:48:54.752459Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.756082Z	11767 Query	BEGIN
2021-07-16T03:48:54.756384Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_flow_data', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `nplayerid`, UNIX_TIMESTAMP(`createtime`), `nstatus`, CONCAT(ISNULL(`createtime`), ISNULL(`nstatus`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_flow_data` /*checksum table*/
2021-07-16T03:48:54.756422Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.759710Z	11767 Query	BEGIN
2021-07-16T03:48:54.759925Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003195', master_crc = '9d0ae896', master_cnt = '8' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_flow_data' AND chunk = '1'
2021-07-16T03:48:54.759956Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.760365Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:54.763070Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:54.764352Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:54.766101Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:54.767147Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:54.768988Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2158469, 60 )
2021-07-16T03:48:54.769874Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='table_club_flow_data' AND master_crc IS NOT NULL
2021-07-16T03:48:54.771025Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='table_club_flow_data')
2021-07-16T03:48:54.774496Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'table\_club\_game\_cfg'
2021-07-16T03:48:54.776765Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:54.777594Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.778380Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_game_cfg`
2021-07-16T03:48:54.779476Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:54.780607Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_game_cfg` WHERE 1=1
2021-07-16T03:48:54.784886Z	11767 Query	BEGIN
2021-07-16T03:48:54.785177Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_game_cfg'
2021-07-16T03:48:54.785211Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.790023Z	11767 Query	BEGIN
2021-07-16T03:48:54.792245Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_game_cfg', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ngametype`, `nstatus`, `ndudiamondmode`, `nextstatus`, CONCAT(ISNULL(`nstatus`), ISNULL(`ndudiamondmode`), ISNULL(`nextstatus`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_game_cfg` /*checksum table*/
2021-07-16T03:48:54.792294Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.793450Z	11767 Query	BEGIN
2021-07-16T03:48:54.793731Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.004491', master_crc = '6c173ca5', master_cnt = '1659' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_game_cfg' AND chunk = '1'
2021-07-16T03:48:54.793773Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.794143Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:54.796759Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:54.797970Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:54.799720Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:54.800777Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:54.802778Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2160133, 60 )
2021-07-16T03:48:54.803684Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='table_club_game_cfg' AND master_crc IS NOT NULL
2021-07-16T03:48:54.804827Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='table_club_game_cfg')
2021-07-16T03:48:54.808232Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'table\_club\_game\_dudiamond\_rate'
2021-07-16T03:48:54.810594Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:54.811428Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.812250Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_game_dudiamond_rate`
2021-07-16T03:48:54.813374Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:54.814460Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_game_dudiamond_rate` WHERE 1=1
2021-07-16T03:48:54.818598Z	11767 Query	BEGIN
2021-07-16T03:48:54.818836Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_game_dudiamond_rate'
2021-07-16T03:48:54.818872Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.822764Z	11767 Query	BEGIN
2021-07-16T03:48:54.823166Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_game_dudiamond_rate', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ngametype`, `nscore`, `ndudiamondmode`, `ndudiamondrate`, CONCAT(ISNULL(`ndudiamondmode`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_game_dudiamond_rate` /*checksum table*/
2021-07-16T03:48:54.823219Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.825982Z	11767 Query	BEGIN
2021-07-16T03:48:54.826206Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003416', master_crc = '2cee148a', master_cnt = '30' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_game_dudiamond_rate' AND chunk = '1'
2021-07-16T03:48:54.826242Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.826840Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:54.829680Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:54.830847Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:54.832717Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:54.833798Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:54.835794Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2161801, 60 )
2021-07-16T03:48:54.836670Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='table_club_game_dudiamond_rate' AND master_crc IS NOT NULL
2021-07-16T03:48:54.837748Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='table_club_game_dudiamond_rate')
2021-07-16T03:48:54.841282Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'table\_club\_hundred\_cc'
2021-07-16T03:48:54.843618Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:54.844434Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.845245Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_hundred_cc`
2021-07-16T03:48:54.846442Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:54.847632Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_hundred_cc` WHERE 1=1
2021-07-16T03:48:54.852207Z	11767 Query	BEGIN
2021-07-16T03:48:54.852460Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_cc'
2021-07-16T03:48:54.852494Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.856167Z	11767 Query	BEGIN
2021-07-16T03:48:54.856502Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_hundred_cc', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ngameid`, `nhundredtype`, `ncode`, `ntaxrate`, convert(`szdesc` using utf8mb4), `nstatus`, CONCAT(ISNULL(`nclubid`), ISNULL(`ngameid`), ISNULL(`nhundredtype`), ISNULL(`ncode`), ISNULL(`ntaxrate`), ISNULL(`szdesc`), ISNULL(`nstatus`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_hundred_cc` /*checksum table*/
2021-07-16T03:48:54.856570Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.859671Z	11767 Query	BEGIN
2021-07-16T03:48:54.859908Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.002962', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_cc' AND chunk = '1'
2021-07-16T03:48:54.859949Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.860457Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:54.863319Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:54.864508Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:54.866309Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:54.867343Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:54.869323Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2163568, 60 )
2021-07-16T03:48:54.870292Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='table_club_hundred_cc' AND master_crc IS NOT NULL
2021-07-16T03:48:54.871387Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='table_club_hundred_cc')
2021-07-16T03:48:54.875198Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'table\_club\_hundred\_cfg'
2021-07-16T03:48:54.877529Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:54.878313Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.879189Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_hundred_cfg`
2021-07-16T03:48:54.880298Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:54.881482Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_hundred_cfg` WHERE 1=1
2021-07-16T03:48:54.885863Z	11767 Query	BEGIN
2021-07-16T03:48:54.886100Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_cfg'
2021-07-16T03:48:54.886135Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.889775Z	11767 Query	BEGIN
2021-07-16T03:48:54.890113Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_hundred_cfg', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ngametype`, `nhundredtype`, `nopen`, `nallowplaybank`, `nemptysysbank`, `nmaxunionbanknum`, `nunbankvalsyswin`, `nunbankvalsyslose`, CONCAT(ISNULL(`nclubid`), ISNULL(`ngametype`), ISNULL(`nhundredtype`), ISNULL(`nopen`), ISNULL(`nallowplaybank`), ISNULL(`nemptysysbank`), ISNULL(`nmaxunionbanknum`), ISNULL(`nunbankvalsyswin`), ISNULL(`nunbankvalsyslose`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_hundred_cfg` /*checksum table*/
2021-07-16T03:48:54.890171Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.893558Z	11767 Query	BEGIN
2021-07-16T03:48:54.893861Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003184', master_crc = '1b0e47af', master_cnt = '3' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_cfg' AND chunk = '1'
2021-07-16T03:48:54.893914Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.894304Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:54.897248Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:54.898458Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:54.900291Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:54.901360Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:54.903404Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2165469, 60 )
2021-07-16T03:48:54.904346Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='table_club_hundred_cfg' AND master_crc IS NOT NULL
2021-07-16T03:48:54.905441Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='table_club_hundred_cfg')
2021-07-16T03:48:54.909009Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'table\_club\_hundred\_dudiamond\_cfg'
2021-07-16T03:48:54.911315Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:54.912171Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.913010Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_hundred_dudiamond_cfg`
2021-07-16T03:48:54.914179Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:54.915301Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_hundred_dudiamond_cfg` WHERE 1=1
2021-07-16T03:48:54.920185Z	11767 Query	BEGIN
2021-07-16T03:48:54.920419Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_dudiamond_cfg'
2021-07-16T03:48:54.920463Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.924116Z	11767 Query	BEGIN
2021-07-16T03:48:54.924464Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_hundred_dudiamond_cfg', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ngametype`, `nhundredtype`, `namount`)) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_hundred_dudiamond_cfg` /*checksum table*/
2021-07-16T03:48:54.924531Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.927563Z	11767 Query	BEGIN
2021-07-16T03:48:54.927814Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003128', master_crc = '7f8aafb9', master_cnt = '3' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_dudiamond_cfg' AND chunk = '1'
2021-07-16T03:48:54.927855Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.928372Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:54.931111Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:54.932355Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:54.934263Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:54.935344Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:54.937327Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2167091, 60 )
2021-07-16T03:48:54.938302Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='table_club_hundred_dudiamond_cfg' AND master_crc IS NOT NULL
2021-07-16T03:48:54.939435Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='table_club_hundred_dudiamond_cfg')
2021-07-16T03:48:54.943107Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'table\_club\_hundred\_free\_charge'
2021-07-16T03:48:54.945433Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:54.946234Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.947064Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_hundred_free_charge`
2021-07-16T03:48:54.948218Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:54.949377Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_hundred_free_charge` WHERE 1=1
2021-07-16T03:48:54.954045Z	11767 Query	BEGIN
2021-07-16T03:48:54.954273Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_free_charge'
2021-07-16T03:48:54.954318Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.958073Z	11767 Query	BEGIN
2021-07-16T03:48:54.958402Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_hundred_free_charge', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ngameid`, `nhundredtype`, `nplayerid`, `nstatus`)) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_hundred_free_charge` /*checksum table*/
2021-07-16T03:48:54.958460Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.961505Z	11767 Query	BEGIN
2021-07-16T03:48:54.961728Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003339', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_free_charge' AND chunk = '1'
2021-07-16T03:48:54.961769Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.962326Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:54.965087Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:54.966270Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:54.968339Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:54.969475Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:54.971451Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2168709, 60 )
2021-07-16T03:48:54.972361Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='table_club_hundred_free_charge' AND master_crc IS NOT NULL
2021-07-16T03:48:54.973531Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='table_club_hundred_free_charge')
2021-07-16T03:48:54.977919Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'table\_club\_hundred\_game\_score'
2021-07-16T03:48:54.980313Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:54.981139Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:54.981996Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_hundred_game_score`
2021-07-16T03:48:54.983263Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:54.984881Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_hundred_game_score` WHERE 1=1
2021-07-16T03:48:54.989606Z	11767 Query	BEGIN
2021-07-16T03:48:54.989823Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_game_score'
2021-07-16T03:48:54.989861Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.993911Z	11767 Query	BEGIN
2021-07-16T03:48:54.994521Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_hundred_game_score', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ngameid`, `ngametype`, `nhundredtype`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `ntableid`, `nround`, `nsystembank`, `ndiamond_playcount`, `ndiamond_betscore`, `ndiamond_betfreescore`, convert(`ndiamond_carddata` using utf8mb4), convert(`ndiamond_cardtype` using utf8mb4), `nclub_playcount`, `nclub_betscore`, `nclub_betfreescore`, convert(`nclub_carddata` using utf8mb4), convert(`nclub_cardtype` using utf8mb4), `nheart_playcount`, `nheart_betscore`, `nheart_betfreescore`, convert(`nheart_carddata` using utf8mb4), convert(`nheart_cardtype` using utf8mb4), `nspade_playcount`, `nspade_betscore`, `nspade_betfreescore`, convert(`nspade_carddata` using utf8mb4), convert(`nspade_cardtype` using utf8mb4), convert(`szbankcarddata` using utf8mb4), convert(`szbankcardtype` using utf8mb4), `nbanktotalscore`, `nbankresult`, `ntotalplayercount`, `ntotalbet`, CONCAT(ISNULL(`ndiamond_playcount`), ISNULL(`ndiamond_betscore`), ISNULL(`ndiamond_betfreescore`), ISNULL(`ndiamond_carddata`), ISNULL(`ndiamond_cardtype`), ISNULL(`nclub_playcount`), ISNULL(`nclub_betscore`), ISNULL(`nclub_betfreescore`), ISNULL(`nclub_carddata`), ISNULL(`nclub_cardtype`), ISNULL(`nheart_playcount`), ISNULL(`nheart_betscore`), ISNULL(`nheart_betfreescore`), ISNULL(`nheart_carddata`), ISNULL(`nheart_cardtype`), ISNULL(`nspade_playcount`), ISNULL(`nspade_betscore`), ISNULL(`nspade_betfreescore`), ISNULL(`nspade_carddata`), ISNULL(`nspade_cardtype`), ISNULL(`szbankcarddata`), ISNULL(`szbankcardtype`), ISNULL(`nbanktotalscore`), ISNULL(`nbankresult`), ISNULL(`ntotalplayercount`), ISNULL(`ntotalbet`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_hundred_game_score` /*checksum table*/
2021-07-16T03:48:54.994653Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.997417Z	11767 Query	BEGIN
2021-07-16T03:48:54.997707Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003228', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_game_score' AND chunk = '1'
2021-07-16T03:48:54.997752Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:54.998116Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:55.000814Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:55.002073Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:55.004054Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:55.005165Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:55.007206Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2171871, 60 )
2021-07-16T03:48:55.008147Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='table_club_hundred_game_score' AND master_crc IS NOT NULL
2021-07-16T03:48:55.009302Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='table_club_hundred_game_score')
2021-07-16T03:48:55.013307Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'table\_club\_hundred\_game\_score\_banker'
2021-07-16T03:48:55.015706Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.016597Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.017526Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_hundred_game_score_banker`
2021-07-16T03:48:55.018704Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.019981Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_hundred_game_score_banker` WHERE 1=1
2021-07-16T03:48:55.024826Z	11767 Query	BEGIN
2021-07-16T03:48:55.025058Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_game_score_banker'
2021-07-16T03:48:55.025102Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:55.028934Z	11767 Query	BEGIN
2021-07-16T03:48:55.029330Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_hundred_game_score_banker', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `tid`, `nbankid`, `nshares`, `nfreeshares`, `nbankresult`, `nbankfreeresult`, `nbankscore`, `nbankfreescore`, `nfrozenscore`, `nfrozenfreescore`, `ntax`, CONCAT(ISNULL(`nshares`), ISNULL(`nfreeshares`), ISNULL(`nbankresult`), ISNULL(`nbankfreeresult`), ISNULL(`nbankscore`), ISNULL(`nbankfreescore`), ISNULL(`nfrozenscore`), ISNULL(`nfrozenfreescore`), ISNULL(`ntax`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_hundred_game_score_banker` /*checksum table*/
2021-07-16T03:48:55.029379Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:55.032479Z	11767 Query	BEGIN
2021-07-16T03:48:55.032743Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003302', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_game_score_banker' AND chunk = '1'
2021-07-16T03:48:55.032794Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:55.033168Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:55.035988Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:55.037225Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:55.039063Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:55.040121Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:55.042055Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2173821, 60 )
2021-07-16T03:48:55.043011Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='table_club_hundred_game_score_banker' AND master_crc IS NOT NULL
2021-07-16T03:48:55.044134Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='table_club_hundred_game_score_banker')
2021-07-16T03:48:55.048621Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'table\_club\_hundred\_game\_score\_detail'
2021-07-16T03:48:55.051023Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.051810Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.052625Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_hundred_game_score_detail`
2021-07-16T03:48:55.053896Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.055583Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_hundred_game_score_detail` WHERE 1=1
2021-07-16T03:48:55.060482Z	11767 Query	BEGIN
2021-07-16T03:48:55.060722Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_game_score_detail'
2021-07-16T03:48:55.060770Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:55.065506Z	11767 Query	BEGIN
2021-07-16T03:48:55.066032Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_hundred_game_score_detail', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `tid`, `nplayerid`, `nclubid`, `ngameid`, `ngametype`, `nhundredtype`, `ntableid`, `nround`, UNIX_TIMESTAMP(`tstarttime`), UNIX_TIMESTAMP(`tendtime`), `ndiamondbet`, `ndiamondbetfree`, `ndiamondresult`, `ndiamondfreeresult`, `nclubbet`, `nclubbetfree`, `nclubresult`, `nclubfreeresult`, `nheartbet`, `nheartbetfree`, `nheartresult`, `nheartfreeresult`, `nspadebet`, `nspadebetfree`, `nspaderesult`, `nspadefreeresult`, `nwinscore`, `nwinfreescore`, `nplayerscore`, `nplayerfreescore`, `ntax`, CONCAT(ISNULL(`tid`), ISNULL(`nplayerid`), ISNULL(`nclubid`), ISNULL(`ngameid`), ISNULL(`ngametype`), ISNULL(`nhundredtype`), ISNULL(`ntableid`), ISNULL(`nround`), ISNULL(`tstarttime`), ISNULL(`tendtime`), ISNULL(`ndiamondbet`), ISNULL(`ndiamondbetfree`), ISNULL(`ndiamondresult`), ISNULL(`ndiamondfreeresult`), ISNULL(`nclubbet`), ISNULL(`nclubbetfree`), ISNULL(`nclubresult`), ISNULL(`nclubfreeresult`), ISNULL(`nheartbet`), ISNULL(`nheartbetfree`), ISNULL(`nheartresult`), ISNULL(`nheartfreeresult`), ISNULL(`nspadebet`), ISNULL(`nspadebetfree`), ISNULL(`nspaderesult`), ISNULL(`nspadefreeresult`), ISNULL(`nwinscore`), ISNULL(`nwinfreescore`), ISNULL(`nplayerscore`), ISNULL(`nplayerfreescore`), ISNULL(`ntax`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_hundred_game_score_detail` /*checksum table*/
2021-07-16T03:48:55.066080Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:55.069265Z	11767 Query	BEGIN
2021-07-16T03:48:55.069551Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003831', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_game_score_detail' AND chunk = '1'
2021-07-16T03:48:55.069589Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:55.070150Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:55.073021Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:55.074238Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:55.076100Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:55.077083Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:55.079045Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2176611, 60 )
2021-07-16T03:48:55.080048Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='table_club_hundred_game_score_detail' AND master_crc IS NOT NULL
2021-07-16T03:48:55.081141Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='table_club_hundred_game_score_detail')
2021-07-16T03:48:55.084914Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'table\_club\_hundred\_roominfo'
2021-07-16T03:48:55.087260Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.088090Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.088926Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_hundred_roominfo`
2021-07-16T03:48:55.090111Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.091353Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_hundred_roominfo` WHERE 1=1
2021-07-16T03:48:55.095911Z	11767 Query	BEGIN
2021-07-16T03:48:55.096133Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_roominfo'
2021-07-16T03:48:55.096171Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:55.100060Z	11767 Query	BEGIN
2021-07-16T03:48:55.100688Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_hundred_roominfo', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, convert(`szclubname` using utf8mb4), `ntableid`, `ngameid`, `ngametype`, `nhundredtype`, `nbasescore`, `nenterminscore`, `nbankminscore`, UNIX_TIMESTAMP(`tstarttime`), CONCAT(ISNULL(`nclubid`), ISNULL(`szclubname`), ISNULL(`ntableid`), ISNULL(`ngameid`), ISNULL(`ngametype`), ISNULL(`nhundredtype`), ISNULL(`nbasescore`), ISNULL(`nenterminscore`), ISNULL(`nbankminscore`), ISNULL(`tstarttime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_hundred_roominfo` /*checksum table*/
2021-07-16T03:48:55.100737Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:55.103727Z	11767 Query	BEGIN
2021-07-16T03:48:55.103981Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003275', master_crc = '337c9464', master_cnt = '95' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_roominfo' AND chunk = '1'
2021-07-16T03:48:55.104022Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:55.104486Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:55.107233Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:55.108437Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:55.110306Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:55.111356Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:55.113360Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2178586, 60 )
2021-07-16T03:48:55.114331Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='table_club_hundred_roominfo' AND master_crc IS NOT NULL
2021-07-16T03:48:55.115486Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='table_club_hundred_roominfo')
2021-07-16T03:48:55.119223Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'table\_club\_hundred\_user\_enter\_info'
2021-07-16T03:48:55.121562Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.122433Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.123243Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_hundred_user_enter_info`
2021-07-16T03:48:55.124450Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.125652Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_hundred_user_enter_info` WHERE 1=1
2021-07-16T03:48:55.130632Z	11767 Query	BEGIN
2021-07-16T03:48:55.130865Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_user_enter_info'
2021-07-16T03:48:55.130907Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:55.134561Z	11767 Query	BEGIN
2021-07-16T03:48:55.134870Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_hundred_user_enter_info', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ntableid`, `ngameid`, `nplayerid`, `ngametype`, `nhundredtype`, UNIX_TIMESTAMP(`tentertime`), UNIX_TIMESTAMP(`tquittime`), CONCAT(ISNULL(`tquittime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_hundred_user_enter_info` /*checksum table*/
2021-07-16T03:48:55.134919Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:55.137870Z	11767 Query	BEGIN
2021-07-16T03:48:55.138080Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003051', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_hundred_user_enter_info' AND chunk = '1'
2021-07-16T03:48:55.138121Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:55.138610Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:55.141300Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:55.142534Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:55.144335Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:55.145426Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:55.147317Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2180322, 60 )
2021-07-16T03:48:55.148289Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='table_club_hundred_user_enter_info' AND master_crc IS NOT NULL
2021-07-16T03:48:55.149446Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='table_club_hundred_user_enter_info')
2021-07-16T03:48:55.152962Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'table\_club\_info\_notauthority'
2021-07-16T03:48:55.155305Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.156211Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.157075Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_info_notauthority`
2021-07-16T03:48:55.158204Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.159316Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_info_notauthority` WHERE 1=1
2021-07-16T03:48:55.164196Z	11767 Query	BEGIN
2021-07-16T03:48:55.164415Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_info_notauthority'
2021-07-16T03:48:55.164466Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:55.168115Z	11767 Query	BEGIN
2021-07-16T03:48:55.168465Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_info_notauthority', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `nlevel`, `nstatus`, `createtime`, `tmodifytime`)) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_info_notauthority` /*checksum table*/
2021-07-16T03:48:55.168508Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:55.171990Z	11767 Query	BEGIN
2021-07-16T03:48:55.172205Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003160', master_crc = '28466fbc', master_cnt = '25' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_info_notauthority' AND chunk = '1'
2021-07-16T03:48:55.172245Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:55.172799Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:55.175543Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:55.176787Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:55.178682Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:55.179735Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:55.181672Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2181939, 60 )
2021-07-16T03:48:55.182669Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='table_club_info_notauthority' AND master_crc IS NOT NULL
2021-07-16T03:48:55.183749Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='table_club_info_notauthority')
2021-07-16T03:48:55.187058Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'table\_club\_match\_game\_cfg'
2021-07-16T03:48:55.189401Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.190266Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.191085Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_match_game_cfg`
2021-07-16T03:48:55.192211Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.193311Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_match_game_cfg` WHERE 1=1
2021-07-16T03:48:55.197693Z	11767 Query	BEGIN
2021-07-16T03:48:55.197950Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_match_game_cfg'
2021-07-16T03:48:55.197986Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:55.201368Z	11767 Query	BEGIN
2021-07-16T03:48:55.201686Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_match_game_cfg', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `ngametype`, `nmatchtype`, `nserverid`, `nstatus`)) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_match_game_cfg` /*checksum table*/
2021-07-16T03:48:55.201733Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:55.204811Z	11767 Query	BEGIN
2021-07-16T03:48:55.205051Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.002943', master_crc = '0', master_cnt = '0' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_match_game_cfg' AND chunk = '1'
2021-07-16T03:48:55.205091Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:55.205564Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:55.208218Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:55.209452Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:55.211486Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:55.212561Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:55.214411Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2183537, 60 )
2021-07-16T03:48:55.215422Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='table_club_match_game_cfg' AND master_crc IS NOT NULL
2021-07-16T03:48:55.216541Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='table_club_match_game_cfg')
2021-07-16T03:48:55.220086Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'table\_club\_member\_authority'
2021-07-16T03:48:55.222488Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.223321Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.224234Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_member_authority`
2021-07-16T03:48:55.225450Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.226612Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_member_authority` WHERE 1=1
2021-07-16T03:48:55.231182Z	11767 Query	BEGIN
2021-07-16T03:48:55.231402Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_member_authority'
2021-07-16T03:48:55.231450Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:55.235088Z	11767 Query	BEGIN
2021-07-16T03:48:55.235775Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_member_authority', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `nplayerid`, `nlevel`, `nstatus`, UNIX_TIMESTAMP(`tcreatetime`), `tmodifytime`, CONCAT(ISNULL(`nlevel`), ISNULL(`nstatus`), ISNULL(`tcreatetime`), ISNULL(`tmodifytime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_member_authority` /*checksum table*/
2021-07-16T03:48:55.235820Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:55.238651Z	11767 Query	BEGIN
2021-07-16T03:48:55.238881Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003129', master_crc = 'ac1cf08e', master_cnt = '189' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_member_authority' AND chunk = '1'
2021-07-16T03:48:55.238927Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:55.239391Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:55.242252Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:55.243462Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:55.245412Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:55.246454Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:55.248432Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2185288, 60 )
2021-07-16T03:48:55.249433Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='table_club_member_authority' AND master_crc IS NOT NULL
2021-07-16T03:48:55.250627Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='table_club_member_authority')
2021-07-16T03:48:55.254316Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'table\_club\_member\_exswitch\_config'
2021-07-16T03:48:55.256607Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.257424Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.258236Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_member_exswitch_config`
2021-07-16T03:48:55.259396Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.260500Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_member_exswitch_config` WHERE 1=1
2021-07-16T03:48:55.265284Z	11767 Query	BEGIN
2021-07-16T03:48:55.265568Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_member_exswitch_config'
2021-07-16T03:48:55.265604Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:55.269555Z	11767 Query	BEGIN
2021-07-16T03:48:55.269867Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_member_exswitch_config', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, `nplayerid`, `ntype`, `nstatus`)) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_member_exswitch_config` /*checksum table*/
2021-07-16T03:48:55.269949Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:55.273320Z	11767 Query	BEGIN
2021-07-16T03:48:55.273625Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003489', master_crc = '9165edcb', master_cnt = '11' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_member_exswitch_config' AND chunk = '1'
2021-07-16T03:48:55.273666Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:55.274144Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:55.277023Z	61678 Query	SHOW SLAVE STATUS
2021-07-16T03:48:55.278222Z	61678 Query	SHOW VARIABLES LIKE 'version%'
2021-07-16T03:48:55.280077Z	61678 Query	SHOW ENGINES
2021-07-16T03:48:55.281083Z	61678 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-16T03:48:55.283086Z	61678 Query	SELECT MASTER_POS_WAIT('mysql-bin.000277', 2186908, 60 )
2021-07-16T03:48:55.284095Z	61678 Query	SELECT MAX(chunk) FROM `consistency_db`.`checksums` WHERE db='niuniuh5_db' AND tbl='table_club_member_exswitch_config' AND master_crc IS NOT NULL
2021-07-16T03:48:55.285235Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM `consistency_db`.`checksums` WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='table_club_member_exswitch_config')
2021-07-16T03:48:55.288716Z	61678 Query	SHOW TABLES FROM `niuniuh5_db` LIKE 'table\_club\_task\_clubdata'
2021-07-16T03:48:55.291071Z	61678 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-16T03:48:55.291890Z	61678 Query	USE `niuniuh5_db`
2021-07-16T03:48:55.292748Z	61678 Query	SHOW CREATE TABLE `niuniuh5_db`.`table_club_task_clubdata`
2021-07-16T03:48:55.293839Z	61678 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-16T03:48:55.294990Z	61678 Query	EXPLAIN SELECT * FROM `niuniuh5_db`.`table_club_task_clubdata` WHERE 1=1
2021-07-16T03:48:55.299454Z	11767 Query	BEGIN
2021-07-16T03:48:55.299731Z	11767 Query	DELETE FROM `consistency_db`.`checksums` WHERE db = 'niuniuh5_db' AND tbl = 'table_club_task_clubdata'
2021-07-16T03:48:55.299768Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:55.303262Z	11767 Query	BEGIN
2021-07-16T03:48:55.303763Z	11767 Query	REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) SELECT 'niuniuh5_db', 'table_club_task_clubdata', '1', NULL, NULL, NULL, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nclubid`, convert(`sztaskname` using utf8mb4), `ntaskid`, `nstatus`, convert(`szdesc` using utf8mb4), UNIX_TIMESTAMP(`createtime`), UNIX_TIMESTAMP(`modifytime`), CONCAT(ISNULL(`szdesc`), ISNULL(`modifytime`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `niuniuh5_db`.`table_club_task_clubdata` /*checksum table*/
2021-07-16T03:48:55.303843Z	11767 Query	COMMIT /* implicit, from Xid_log_event */
2021-07-16T03:48:55.306764Z	11767 Query	BEGIN
2021-07-16T03:48:55.307013Z	11767 Query	UPDATE `consistency_db`.`checksums` SET chunk_time = '0.003054', master_crc = '4f491b40', master_cnt = '30' WHERE db = 'niuniuh5_db' AND tbl = 'table_club_task_clubdata' AND chunk = '1'
2021-07-16T03:48:55.307055Z	11767 Query	COMMIT /* implicit, from Xid_log_event */