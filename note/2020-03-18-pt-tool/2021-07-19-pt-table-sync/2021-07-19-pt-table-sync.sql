
https://www.cnblogs.com/gomysql/p/3662264.html 

grant all privileges on *.* to 'pt_tool'@'192.168.1.%' identified by '123456abc';
GRANT SELECT, PROCESS, SUPER, REPLICATION SLAVE ON *.* TO 'pt_tool'@'192.168.1.%' IDENTIFIED BY '123456abc';

在从库执行, 参数 h 要写主库的IP
pt-table-checksum --nocheck-binlog-format --recursion-method=processlist -h 192.168.1.26 -P 3306 -u pt_tool -p 123456abc --replicate=db1.checksums --replicate-check-only 

在主库执行， 参数 h 要写从库的IP:												
pt-table-sync --print --execute --sync-to-master h='192.168.1.63',u='pt_tool',p='123456abc' --databases=zst --tables=reply_test20171018 


Cant determine master of h=192.168.1.26,p=...,u=pt_tool at /usr/bin/pt-table-sync line 9870.





alter user 'pt_user'@'%' identified by '%123456Abc';


DROP TABLE IF EXISTS `t_order_by`;
CREATE TABLE `t_order_by` (
  `id` int(11) NOT NULL,
  `city` varchar(16) NOT NULL,
  `name` varchar(16) NOT NULL,
  `age` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_city_name` (`city`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `t_order_by` VALUES ('1', '杭州', '卢aa', '26');

CREATE TABLE `t0` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `r0` int DEFAULT NULL,
  `r1` int DEFAULT NULL,
  `r2` int DEFAULT NULL,
  `r3` int DEFAULT NULL,
  `r4` int DEFAULT NULL,
  `r5` int DEFAULT NULL,
  `r6` int DEFAULT NULL,
  `r7` int DEFAULT NULL,
  `r8` int DEFAULT NULL,
  `r9` int DEFAULT NULL,
  `r10` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DELIMITER $$


DROP PROCEDURE IF EXISTS `sp_batch_write`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_batch_write`(
	IN f_write ENUM('insert','update','delete'),
	IN f_table_name VARCHAR(64),
	IN f_num INT UNSIGNED
	)
BEGIN
  DECLARE i INT UNSIGNED DEFAULT 0;
  
  IF f_write = 'insert' THEN
	SET @stmt = CONCAT('insert into ',f_table_name,'(r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10)  
						values (ceil(rand()*10000),ceil(rand()*10000),ceil(rand()*10000),
						ceil(rand()*10000),ceil(rand()*10000),ceil(rand()*10000),ceil(rand()*10000),
						ceil(rand()*10000),ceil(rand()*10000),ceil(rand()*10000),ceil(rand()*10000))');
   
	SET @@autocommit=0;
	WHILE i < f_num
	DO
	  PREPARE s1 FROM @stmt;
	  EXECUTE s1;
	  IF MOD(i,50) = 0 THEN
		COMMIT;
	  END IF;
	  SET i = i + 1;
	END WHILE;  
	DROP PREPARE s1;
	COMMIT;
	SET @@autocommit=1;

  ELSEIF f_write = 'update' THEN
	SET @stmt = CONCAT('update ',f_table_name,' set r0=ceil(rand()*10000),r1 = ceil(rand()*10000),
	r2 = ceil(rand()*10000),r3 = ceil(rand()*10000),r4 = ceil(rand()*10000),
	r5 = ceil(rand()*10000),r6 = ceil(rand()*10000),r7 = ceil(rand()*10000),
	r8 = ceil(rand()*10000),r9 = ceil(rand()*10000),r10 = ceil(rand()*10000)');
	PREPARE s1 FROM @stmt;
	EXECUTE s1;
	DROP PREPARE s1;
  ELSEIF f_write = 'delete' THEN
	SET @stmt = CONCAT('delete from ',f_table_name);
	PREPARE s1 FROM @stmt;
	EXECUTE s1;
	DROP PREPARE s1;
  END IF;

END$$

DELIMITER ;



call sp_batch_write('insert','t0',100000);

select * from t0 where id=1;

mysql> select * from t0 where id=1;
+----+------+------+------+------+------+------+------+------+------+------+------+
| id | r0   | r1   | r2   | r3   | r4   | r5   | r6   | r7   | r8   | r9   | r10  |
+----+------+------+------+------+------+------+------+------+------+------+------+
|  1 | 6919 | 5853 | 8509 | 4982 | 9385 | 1979 | 1737 | 2748 | 8527 | 4392 | 6380 |
+----+------+------+------+------+------+------+------+------+------+------+------+
1 row in set (0.00 sec)


mysql> select * from t0 where id=1;
+----+------+------+------+------+------+------+------+------+------+------+------+
| id | r0   | r1   | r2   | r3   | r4   | r5   | r6   | r7   | r8   | r9   | r10  |
+----+------+------+------+------+------+------+------+------+------+------+------+
|  1 | 1234 | 5853 | 8509 | 4982 | 9385 | 1979 | 1737 | 2748 | 8527 | 4392 | 6380 |
+----+------+------+------+------+------+------+------+------+------+------+------+
1 row in set (0.01 sec)


sudo  pt-table-checksum --nocheck-replication-filters --no-check-binlog-format  --replicate=consistency_db.checksums h=192.168.1.10,u=pt_user,p='%123456Abc',P=3306 --databases=sbtest
[coding001@db-a ~]$ sudo  pt-table-checksum --nocheck-replication-filters --no-check-binlog-format  --replicate=consistency_db.checksums h=192.168.1.10,u=pt_user,p='%123456Abc',P=3306 --databases=sbtest
Checking if all tables can be checksummed ...
Starting checksum ...
            TS ERRORS  DIFFS     ROWS  DIFF_ROWS  CHUNKS SKIPPED    TIME TABLE
07-19T17:28:00      0      1   100000          0       4       0   0.446 sbtest.t0
07-19T17:28:00      0      0        1          0       1       0   0.022 sbtest.t_order_by


[coding001@db-a ~]$ sudo pt-table-sync --replicate=consistency_db.checksums h=192.168.1.10,u=pt_user,p='%123456Abc',P=3306 --databases=sbtest --print 
REPLACE INTO `sbtest`.`t0`(`id`, `r0`, `r1`, `r2`, `r3`, `r4`, `r5`, `r6`, `r7`, `r8`, `r9`, `r10`) VALUES ('1', '6919', '5853', '8509', '4982', '9385', '1979', '1737', '2748', '8527', '4392', '6380') /*percona-toolkit src_db:sbtest src_tbl:t0 src_dsn:P=3306,h=192.168.1.10,p=...,u=pt_user dst_db:sbtest dst_tbl:t0 dst_dsn:P=3306,h=192.168.1.11,p=...,u=pt_user lock:1 transaction:1 changing_src:consistency_db.checksums replicate:consistency_db.checksums bidirectional:0 pid:775 user:root host:db-a*/;


general_log=1


master
2021-07-19T09:28:30.334638Z	339178 Connect	pt_user@192.168.1.10 on  using TCP/IP
2021-07-19T09:28:30.334912Z	339178 Query	set autocommit=0
2021-07-19T09:28:30.335199Z	339178 Query	SHOW VARIABLES LIKE 'wait\_timeout'
2021-07-19T09:28:30.342492Z	339178 Query	SET SESSION wait_timeout=10000
2021-07-19T09:28:30.342683Z	339178 Query	SELECT @@SQL_MODE
2021-07-19T09:28:30.342871Z	339178 Query	SET @@SQL_QUOTE_SHOW_CREATE = 1/*!40101, @@SQL_MODE='NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION'*/
2021-07-19T09:28:30.343037Z	339178 Query	/*!40101 SET @@SQL_MODE := CONCAT(@@SQL_MODE, ',NO_AUTO_VALUE_ON_ZERO')*/
2021-07-19T09:28:30.343319Z	339178 Query	SHOW VARIABLES LIKE 'version%'
2021-07-19T09:28:30.344758Z	339178 Query	SHOW ENGINES
2021-07-19T09:28:30.345182Z	339178 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-19T09:28:30.346566Z	339178 Query	SELECT @@binlog_format
2021-07-19T09:28:30.346740Z	339178 Query	/*!50108 SET @@binlog_format := 'STATEMENT'*/
2021-07-19T09:28:30.346889Z	339178 Query	SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ
2021-07-19T09:28:30.347095Z	339178 Query	SELECT CONCAT(@@hostname, @@port)
2021-07-19T09:28:30.347386Z	339178 Quit	
2021-07-19T09:28:30.348087Z	339179 Connect	pt_user@192.168.1.10 on  using TCP/IP
2021-07-19T09:28:30.348270Z	339179 Query	set autocommit=0
2021-07-19T09:28:30.348477Z	339179 Query	SHOW VARIABLES LIKE 'wait\_timeout'
2021-07-19T09:28:30.353704Z	339179 Query	SET SESSION wait_timeout=10000
2021-07-19T09:28:30.353878Z	339179 Query	SELECT @@SQL_MODE
2021-07-19T09:28:30.354015Z	339179 Query	SET @@SQL_QUOTE_SHOW_CREATE = 1/*!40101, @@SQL_MODE='NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION'*/
2021-07-19T09:28:30.354151Z	339179 Query	/*!40101 SET @@SQL_MODE := CONCAT(@@SQL_MODE, ',NO_AUTO_VALUE_ON_ZERO')*/
2021-07-19T09:28:30.354359Z	339179 Query	SHOW VARIABLES LIKE 'version%'
2021-07-19T09:28:30.355617Z	339179 Query	SHOW ENGINES
2021-07-19T09:28:30.356002Z	339179 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-19T09:28:30.357231Z	339179 Query	SELECT @@binlog_format
2021-07-19T09:28:30.357382Z	339179 Query	/*!50108 SET @@binlog_format := 'STATEMENT'*/
2021-07-19T09:28:30.357494Z	339179 Query	SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ
2021-07-19T09:28:30.358191Z	339180 Connect	pt_user@192.168.1.10 on  using TCP/IP
2021-07-19T09:28:30.358362Z	339180 Query	set autocommit=0
2021-07-19T09:28:30.358573Z	339180 Query	SHOW VARIABLES LIKE 'wait\_timeout'
2021-07-19T09:28:30.364440Z	339180 Query	SET SESSION wait_timeout=10000
2021-07-19T09:28:30.364604Z	339180 Query	SELECT @@SQL_MODE
2021-07-19T09:28:30.364747Z	339180 Query	SET @@SQL_QUOTE_SHOW_CREATE = 1/*!40101, @@SQL_MODE='NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION'*/
2021-07-19T09:28:30.364887Z	339180 Query	/*!40101 SET @@SQL_MODE := CONCAT(@@SQL_MODE, ',NO_AUTO_VALUE_ON_ZERO')*/
2021-07-19T09:28:30.365085Z	339180 Query	SHOW VARIABLES LIKE 'version%'
2021-07-19T09:28:30.366378Z	339180 Query	SHOW ENGINES
2021-07-19T09:28:30.366761Z	339180 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-19T09:28:30.367988Z	339180 Query	SELECT @@binlog_format
2021-07-19T09:28:30.368162Z	339180 Query	/*!50108 SET @@binlog_format := 'STATEMENT'*/
2021-07-19T09:28:30.368303Z	339180 Query	SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ
2021-07-19T09:28:30.368595Z	339179 Query	SELECT @@SERVER_ID
2021-07-19T09:28:30.368877Z	339179 Query	SELECT db, tbl, CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM consistency_db.checksums WHERE master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc)
2021-07-19T09:28:30.370581Z	339179 Query	SHOW GRANTS FOR CURRENT_USER()
2021-07-19T09:28:30.370756Z	339179 Query	SHOW FULL PROCESSLIST
2021-07-19T09:28:30.404944Z	339179 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-19T09:28:30.405133Z	339179 Query	USE `sbtest`
2021-07-19T09:28:30.405318Z	339179 Query	SHOW CREATE TABLE `sbtest`.`t0`
2021-07-19T09:28:30.405618Z	339179 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-19T09:28:30.415380Z	339179 Query	SET NAMES 'utf8mb4'
2021-07-19T09:28:30.415542Z	339180 Query	SET NAMES 'utf8mb4'
2021-07-19T09:28:30.418464Z	339179 Query	SELECT MIN(`id`), MAX(`id`) FROM `sbtest`.`t0` FORCE INDEX (`PRIMARY`) WHERE (((`id` >= '1')) AND ((`id` <= '1000')))
2021-07-19T09:28:30.418724Z	339179 Query	EXPLAIN SELECT * FROM `sbtest`.`t0` FORCE INDEX (`PRIMARY`) WHERE ((`id` >= '1')) AND ((`id` <= '1000'))
2021-07-19T09:28:30.419460Z	339179 Query	SELECT CRC32('test-string')
2021-07-19T09:28:30.420864Z	339179 Query	SELECT CRC32('a')
2021-07-19T09:28:30.421065Z	339179 Query	SELECT CRC32('a')
2021-07-19T09:28:30.421474Z	339179 Query	USE `sbtest`
2021-07-19T09:28:30.425280Z	339179 Query	SET @crc := '', @cnt := 0
2021-07-19T09:28:30.426446Z	339179 Query	commit
2021-07-19T09:28:30.427397Z	339179 Query	START TRANSACTION /*!40108 WITH CONSISTENT SNAPSHOT */
2021-07-19T09:28:30.427605Z	339179 Query	SELECT /*sbtest.t0:1/2*/ 0 AS chunk_num, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `r0`, `r1`, `r2`, `r3`, `r4`, `r5`, `r6`, `r7`, `r8`, `r9`, `r10`, CONCAT(ISNULL(`r0`), ISNULL(`r1`), ISNULL(`r2`), ISNULL(`r3`), ISNULL(`r4`), ISNULL(`r5`), ISNULL(`r6`), ISNULL(`r7`), ISNULL(`r8`), ISNULL(`r9`), ISNULL(`r10`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `sbtest`.`t0` FORCE INDEX (`PRIMARY`) WHERE (`id` = 0) AND ((((`id` >= '1')) AND ((`id` <= '1000')))) FOR UPDATE
2021-07-19T09:28:30.427993Z	339180 Query	SHOW MASTER STATUS
2021-07-19T09:28:30.437434Z	339179 Query	SET @crc := '', @cnt := 0
2021-07-19T09:28:30.438495Z	339179 Query	commit
2021-07-19T09:28:30.439504Z	339179 Query	START TRANSACTION /*!40108 WITH CONSISTENT SNAPSHOT */
2021-07-19T09:28:30.439750Z	339179 Query	SELECT /*sbtest.t0:2/2*/ 1 AS chunk_num, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `r0`, `r1`, `r2`, `r3`, `r4`, `r5`, `r6`, `r7`, `r8`, `r9`, `r10`, CONCAT(ISNULL(`r0`), ISNULL(`r1`), ISNULL(`r2`), ISNULL(`r3`), ISNULL(`r4`), ISNULL(`r5`), ISNULL(`r6`), ISNULL(`r7`), ISNULL(`r8`), ISNULL(`r9`), ISNULL(`r10`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `sbtest`.`t0` FORCE INDEX (`PRIMARY`) WHERE (`id` >= '1') AND ((((`id` >= '1')) AND ((`id` <= '1000')))) FOR UPDATE
2021-07-19T09:28:30.442179Z	339180 Query	SHOW MASTER STATUS
2021-07-19T09:28:30.453317Z	339179 Query	SET @crc := '', @cnt := 0
2021-07-19T09:28:30.454543Z	339179 Query	SELECT /*rows in chunk*/ `id`, `r0`, `r1`, `r2`, `r3`, `r4`, `r5`, `r6`, `r7`, `r8`, `r9`, `r10`, CRC32(CONCAT_WS('#', `id`, `r0`, `r1`, `r2`, `r3`, `r4`, `r5`, `r6`, `r7`, `r8`, `r9`, `r10`, CONCAT(ISNULL(`r0`), ISNULL(`r1`), ISNULL(`r2`), ISNULL(`r3`), ISNULL(`r4`), ISNULL(`r5`), ISNULL(`r6`), ISNULL(`r7`), ISNULL(`r8`), ISNULL(`r9`), ISNULL(`r10`)))) AS __crc FROM `sbtest`.`t0` FORCE INDEX (`PRIMARY`) WHERE (`id` >= '1') AND (((`id` >= '1')) AND ((`id` <= '1000'))) ORDER BY `id` FOR UPDATE
2021-07-19T09:28:30.480124Z	339179 Query	SELECT `id`, `r0`, `r1`, `r2`, `r3`, `r4`, `r5`, `r6`, `r7`, `r8`, `r9`, `r10` FROM `sbtest`.`t0` WHERE `id`='1' LIMIT 1
2021-07-19T09:28:30.480711Z	339179 Query	commit
2021-07-19T09:28:30.484753Z	339179 Query	commit
2021-07-19T09:28:30.484889Z	339179 Quit	
2021-07-19T09:28:30.485048Z	339180 Query	commit
2021-07-19T09:28:30.485138Z	339180 Quit	



slave

2021-07-19T09:28:30.376386Z	62287 Connect	pt_user@192.168.1.10 on  using TCP/IP
2021-07-19T09:28:30.377374Z	62287 Query	SHOW VARIABLES LIKE 'wait\_timeout'
2021-07-19T09:28:30.381826Z	62287 Query	SET SESSION wait_timeout=10000
2021-07-19T09:28:30.382639Z	62287 Query	SELECT @@SQL_MODE
2021-07-19T09:28:30.383462Z	62287 Query	SET @@SQL_QUOTE_SHOW_CREATE = 1/*!40101, @@SQL_MODE='NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION'*/
2021-07-19T09:28:30.384323Z	62287 Query	SELECT @@SERVER_ID
2021-07-19T09:28:30.385396Z	62287 Query	SELECT db, tbl, CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc FROM consistency_db.checksums WHERE master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc)
2021-07-19T09:28:30.390396Z	62288 Connect	pt_user@192.168.1.10 on  using TCP/IP
2021-07-19T09:28:30.391277Z	62288 Query	set autocommit=0
2021-07-19T09:28:30.392225Z	62288 Query	SHOW VARIABLES LIKE 'wait\_timeout'
2021-07-19T09:28:30.394632Z	62288 Query	SET SESSION wait_timeout=10000
2021-07-19T09:28:30.395412Z	62288 Query	SELECT @@SQL_MODE
2021-07-19T09:28:30.396192Z	62288 Query	SET @@SQL_QUOTE_SHOW_CREATE = 1/*!40101, @@SQL_MODE='NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION'*/
2021-07-19T09:28:30.396998Z	62288 Query	/*!40101 SET @@SQL_MODE := CONCAT(@@SQL_MODE, ',NO_AUTO_VALUE_ON_ZERO')*/
2021-07-19T09:28:30.397841Z	62288 Query	SHOW VARIABLES LIKE 'version%'
2021-07-19T09:28:30.399801Z	62288 Query	SHOW ENGINES
2021-07-19T09:28:30.400828Z	62288 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-19T09:28:30.402786Z	62288 Query	SELECT @@binlog_format
2021-07-19T09:28:30.403571Z	62288 Query	/*!50108 SET @@binlog_format := 'STATEMENT'*/
2021-07-19T09:28:30.404340Z	62288 Query	SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ
2021-07-19T09:28:30.406466Z	62287 Query	SHOW TABLES FROM `sbtest` LIKE 't0'
2021-07-19T09:28:30.407494Z	62287 Query	SHOW VARIABLES LIKE 'version%'
2021-07-19T09:28:30.409455Z	62287 Query	SHOW ENGINES
2021-07-19T09:28:30.410499Z	62287 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-19T09:28:30.412453Z	62287 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := REPLACE(REPLACE(@@SQL_MODE, 'ANSI_QUOTES', ''), ',,', ','), @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
2021-07-19T09:28:30.413352Z	62287 Query	SHOW TRIGGERS FROM `sbtest`
2021-07-19T09:28:30.414685Z	62287 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
2021-07-19T09:28:30.416014Z	62287 Query	SET NAMES 'utf8mb4'
2021-07-19T09:28:30.416791Z	62288 Query	SET NAMES 'utf8mb4'
2021-07-19T09:28:30.417561Z	62287 Query	set autocommit=0
2021-07-19T09:28:30.420060Z	62287 Query	SELECT CRC32('test-string')
2021-07-19T09:28:30.421991Z	62287 Query	USE `sbtest`
2021-07-19T09:28:30.425805Z	62287 Query	SET @crc := '', @cnt := 0
2021-07-19T09:28:30.426923Z	62287 Query	commit
2021-07-19T09:28:30.428620Z	62287 Query	SHOW SLAVE STATUS
2021-07-19T09:28:30.430008Z	62287 Query	SHOW VARIABLES LIKE 'version%'
2021-07-19T09:28:30.432165Z	62287 Query	SHOW ENGINES
2021-07-19T09:28:30.433228Z	62287 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-19T09:28:30.435368Z	62287 Query	SELECT MASTER_POS_WAIT('mysql-bin.000294', 46999540, 60 )
2021-07-19T09:28:30.436456Z	62287 Query	SELECT /*sbtest.t0:1/2*/ 0 AS chunk_num, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `r0`, `r1`, `r2`, `r3`, `r4`, `r5`, `r6`, `r7`, `r8`, `r9`, `r10`, CONCAT(ISNULL(`r0`), ISNULL(`r1`), ISNULL(`r2`), ISNULL(`r3`), ISNULL(`r4`), ISNULL(`r5`), ISNULL(`r6`), ISNULL(`r7`), ISNULL(`r8`), ISNULL(`r9`), ISNULL(`r10`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `sbtest`.`t0` FORCE INDEX (`PRIMARY`) WHERE (`id` = 0) AND ((((`id` >= '1')) AND ((`id` <= '1000')))) LOCK IN SHARE MODE
2021-07-19T09:28:30.437943Z	62287 Query	SET @crc := '', @cnt := 0
2021-07-19T09:28:30.439008Z	62287 Query	commit
2021-07-19T09:28:30.442813Z	62287 Query	SHOW SLAVE STATUS
2021-07-19T09:28:30.444036Z	62287 Query	SHOW VARIABLES LIKE 'version%'
2021-07-19T09:28:30.445906Z	62287 Query	SHOW ENGINES
2021-07-19T09:28:30.446982Z	62287 Query	SHOW VARIABLES LIKE 'innodb_version'
2021-07-19T09:28:30.449012Z	62287 Query	SELECT MASTER_POS_WAIT('mysql-bin.000294', 46999540, 60 )
2021-07-19T09:28:30.450002Z	62287 Query	SELECT /*sbtest.t0:2/2*/ 1 AS chunk_num, COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `r0`, `r1`, `r2`, `r3`, `r4`, `r5`, `r6`, `r7`, `r8`, `r9`, `r10`, CONCAT(ISNULL(`r0`), ISNULL(`r1`), ISNULL(`r2`), ISNULL(`r3`), ISNULL(`r4`), ISNULL(`r5`), ISNULL(`r6`), ISNULL(`r7`), ISNULL(`r8`), ISNULL(`r9`), ISNULL(`r10`)))) AS UNSIGNED)), 10, 16)), 0) AS crc FROM `sbtest`.`t0` FORCE INDEX (`PRIMARY`) WHERE (`id` >= '1') AND ((((`id` >= '1')) AND ((`id` <= '1000')))) LOCK IN SHARE MODE
2021-07-19T09:28:30.453900Z	62287 Query	SET @crc := '', @cnt := 0
2021-07-19T09:28:30.455973Z	62287 Query	SELECT /*rows in chunk*/ `id`, `r0`, `r1`, `r2`, `r3`, `r4`, `r5`, `r6`, `r7`, `r8`, `r9`, `r10`, CRC32(CONCAT_WS('#', `id`, `r0`, `r1`, `r2`, `r3`, `r4`, `r5`, `r6`, `r7`, `r8`, `r9`, `r10`, CONCAT(ISNULL(`r0`), ISNULL(`r1`), ISNULL(`r2`), ISNULL(`r3`), ISNULL(`r4`), ISNULL(`r5`), ISNULL(`r6`), ISNULL(`r7`), ISNULL(`r8`), ISNULL(`r9`), ISNULL(`r10`)))) AS __crc FROM `sbtest`.`t0` FORCE INDEX (`PRIMARY`) WHERE (`id` >= '1') AND (((`id` >= '1')) AND ((`id` <= '1000'))) ORDER BY `id` LOCK IN SHARE MODE
2021-07-19T09:28:30.481248Z	62287 Query	commit
2021-07-19T09:28:30.482273Z	62287 Query	commit
2021-07-19T09:28:30.483073Z	62287 Quit	
2021-07-19T09:28:30.484002Z	62288 Query	commit
2021-07-19T09:28:30.484762Z	62288 Quit	

pt-table-sync 也需要对行记录进行加锁。



mysql> select * from consistency_db.checksums where db='niuniuh5_db' AND tbl='table_bet_inout';
+-------------+-----------------+-------+------------+-------------+----------------+----------------+----------+----------+------------+------------+---------------------+
| db          | tbl             | chunk | chunk_time | chunk_index | lower_boundary | upper_boundary | this_crc | this_cnt | master_crc | master_cnt | ts                  |
+-------------+-----------------+-------+------------+-------------+----------------+----------------+----------+----------+------------+------------+---------------------+
| niuniuh5_db | table_bet_inout |     1 |   0.212655 | PRIMARY     | 1              | 124796         | 92bd0c50 |   124796 | 92bd0c50   |     124796 | 2021-07-16 17:34:47 |
| niuniuh5_db | table_bet_inout |     2 |   0.255034 | PRIMARY     | 124797         | 278785         | 6e09bb2c |   153989 | 6e09bb2c   |     153989 | 2021-07-16 17:34:47 |
| niuniuh5_db | table_bet_inout |     3 |   0.000502 | PRIMARY     | NULL           | 1              | 0        |        0 | 0          |          0 | 2021-07-16 17:34:47 |
| niuniuh5_db | table_bet_inout |     4 |   0.000359 | PRIMARY     | 278785         | NULL           | 0        |        0 | 0          |          0 | 2021-07-16 17:34:47 |
+-------------+-----------------+-------+------------+-------------+----------------+----------------+----------+----------+------------+------------+---------------------+
4 rows in set (0.00 sec)





