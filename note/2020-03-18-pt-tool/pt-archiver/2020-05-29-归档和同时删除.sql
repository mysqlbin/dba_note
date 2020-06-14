
1. 表结构和数据的初始化
2. 命令执行
3. general log
4. 小结


1. 表结构和数据的初始化
	drop table if exists t;
	CREATE TABLE `t` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c1` int(11) DEFAULT NULL,
	  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '开始时间',
	  PRIMARY KEY (`id`),
	  KEY `idx_createTime` (`createTime`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

	INSERT INTO `t` (`id`, `c1`, `createTime`) VALUES ('1', '1', '2020-05-28 15:57:38');
	INSERT INTO `t` (`id`, `c1`, `createTime`) VALUES ('2', '2', '2020-05-27 15:57:48');
	INSERT INTO `t` (`id`, `c1`, `createTime`) VALUES ('3', '3', '2020-05-28 15:57:58');
	INSERT INTO `t` (`id`, `c1`, `createTime`) VALUES ('4', '4', '2020-05-29 15:57:58');

	drop table if exists t20200528;
	CREATE TABLE `t20200528` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c1` int(11) DEFAULT NULL,
	  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '开始时间',
	  PRIMARY KEY (`id`),
	  KEY `idx_createTime` (`createTime`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

2. 命令执行

	pt-archiver --source h=192.168.0.252,u=root,p=123456abc,P=3306,D=audit_db,t=t,A=utf8mb4 --dest h=192.168.0.252,u=root,p=123456abc,P=3306,D=audit_db,t=t20200528 --charset=utf8mb4 --progress 10000 --where 'id <= 3 and id >= 1 and createTime >= "2020-05-28 00:00:00.000" and createTime < "2020-05-29 00:00:00.000"' --statistics --limit=20000 --txn-size 1000 --sleep 1 

	TIME                ELAPSED   COUNT
	2020-05-29T16:28:49       0       0
	2020-05-29T16:28:49       0       2
	Started at 2020-05-29T16:28:49, ended at 2020-05-29T16:28:50
	Source: A=utf8mb4,D=audit_db,P=3306,h=192.168.0.252,p=...,t=t,u=root
	Dest:   A=utf8mb4,D=audit_db,P=3306,h=192.168.0.252,p=...,t=t20200528,u=root
	SELECT 2
	INSERT 2
	DELETE 2
	Action         Count       Time        Pct
	sleep              1     1.0002      99.27
	select             2     0.0016       0.15
	inserting          2     0.0008       0.08
	deleting           2     0.0007       0.07
	commit             2     0.0005       0.05
	other              0     0.0038       0.38

3. general log
	2020-05-29T08:28:50.398111Z	 7757 Connect	root@192.168.0.242 on audit_db using TCP/IP
	2020-05-29T08:28:50.398388Z	 7757 Query	set autocommit=0
	2020-05-29T08:28:50.398746Z	 7757 Query	/*!40101 SET NAMES "utf8mb4"*/
	2020-05-29T08:28:50.399060Z	 7757 Query	SHOW VARIABLES LIKE 'wait\_timeout'
	2020-05-29T08:28:50.401141Z	 7757 Query	SET SESSION wait_timeout=10000
	2020-05-29T08:28:50.401364Z	 7757 Query	SELECT @@SQL_MODE
	2020-05-29T08:28:50.401884Z	 7757 Query	SET @@SQL_QUOTE_SHOW_CREATE = 1/*!40101, @@SQL_MODE='NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION'*/
	2020-05-29T08:28:50.402107Z	 7757 Query	SELECT version()
	2020-05-29T08:28:50.402492Z	 7757 Query	SHOW VARIABLES LIKE 'version%'
	2020-05-29T08:28:50.404685Z	 7757 Query	SHOW ENGINES
	2020-05-29T08:28:50.405490Z	 7757 Query	SHOW VARIABLES LIKE 'innodb_version'
	2020-05-29T08:28:50.407788Z	 7757 Query	show variables like 'innodb_rollback_on_timeout'
	2020-05-29T08:28:50.410008Z	 7757 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
	2020-05-29T08:28:50.410297Z	 7757 Query	USE `audit_db`
	2020-05-29T08:28:50.410552Z	 7757 Query	SHOW CREATE TABLE `audit_db`.`t`
	2020-05-29T08:28:50.411236Z	 7757 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
	2020-05-29T08:28:50.420781Z	 7757 Query	SELECT CONCAT(/*!40100 @@session.character_set_connection, */ "")
	2020-05-29T08:28:50.422038Z	 7758 Connect	root@192.168.0.242 on audit_db using TCP/IP
	2020-05-29T08:28:50.422283Z	 7758 Query	set autocommit=0
	2020-05-29T08:28:50.422566Z	 7758 Query	/*!40101 SET NAMES "utf8mb4"*/
	2020-05-29T08:28:50.422867Z	 7758 Query	SHOW VARIABLES LIKE 'wait\_timeout'
	2020-05-29T08:28:50.424455Z	 7758 Query	SET SESSION wait_timeout=10000
	2020-05-29T08:28:50.424750Z	 7758 Query	SELECT @@SQL_MODE
	2020-05-29T08:28:50.425127Z	 7758 Query	SET @@SQL_QUOTE_SHOW_CREATE = 1/*!40101, @@SQL_MODE='NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION'*/
	2020-05-29T08:28:50.425318Z	 7758 Query	SELECT version()
	2020-05-29T08:28:50.425733Z	 7758 Query	SHOW VARIABLES LIKE 'version%'
	2020-05-29T08:28:50.427276Z	 7758 Query	SHOW ENGINES
	2020-05-29T08:28:50.428001Z	 7758 Query	SHOW VARIABLES LIKE 'innodb_version'
	2020-05-29T08:28:50.429554Z	 7758 Query	show variables like 'innodb_rollback_on_timeout'
	2020-05-29T08:28:50.431037Z	 7758 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
	2020-05-29T08:28:50.431275Z	 7758 Query	USE `audit_db`
	2020-05-29T08:28:50.431536Z	 7758 Query	SHOW CREATE TABLE `audit_db`.`t20200528`
	2020-05-29T08:28:50.432101Z	 7758 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
	2020-05-29T08:28:50.432690Z	 7758 Query	SELECT CONCAT(/*!40100 @@session.character_set_connection, */ "")
	2020-05-29T08:28:50.433083Z	 7757 Query	SHOW VARIABLES LIKE 'wsrep_on'
	2020-05-29T08:28:50.434997Z	 7757 Query	SHOW VARIABLES LIKE 'wsrep_on'
	2020-05-29T08:28:50.437111Z	 7757 Query	SHOW VARIABLES LIKE 'version%'
	2020-05-29T08:28:50.439070Z	 7757 Query	SHOW ENGINES
	2020-05-29T08:28:50.439976Z	 7757 Query	SHOW VARIABLES LIKE 'innodb_version'
	2020-05-29T08:28:50.442060Z	 7757 Query	SELECT MAX(`id`) FROM `audit_db`.`t`
	2020-05-29T08:28:50.442806Z	 7757 Query	SELECT CONCAT(@@hostname, @@port)
	2020-05-29T08:28:50.443194Z	 7758 Query	SELECT CONCAT(@@hostname, @@port)
	2020-05-29T08:28:50.444081Z	 7757 Query	SELECT /*!40001 SQL_NO_CACHE */ `id`,`c1`,`createtime` FROM `audit_db`.`t` FORCE INDEX(`PRIMARY`) WHERE (id <= 3 and id >= 1 and createTime >= "2020-05-28 00:00:00.000" and createTime < "2020-05-29 00:00:00.000") AND (`id` <= '4') ORDER BY `id` LIMIT 20000

	2020-05-29T08:28:50.447852Z	 7758 Query	INSERT INTO `audit_db`.`t20200528`(`id`,`c1`,`createtime`) VALUES ('1','1','2020-05-28 15:57:38')
	2020-05-29T08:28:50.448238Z	 7757 Query	DELETE FROM `audit_db`.`t` WHERE (`id` = '1')

	2020-05-29T08:28:50.448616Z	 7757 Query	SELECT 'pt-archiver keepalive'
	2020-05-29T08:28:50.449065Z	 7758 Query	INSERT INTO `audit_db`.`t20200528`(`id`,`c1`,`createtime`) VALUES ('3','3','2020-05-28 15:57:58')
	2020-05-29T08:28:50.449293Z	 7757 Query	DELETE FROM `audit_db`.`t` WHERE (`id` = '3')
	2020-05-29T08:28:51.450143Z	 7757 Query	SELECT /*!40001 SQL_NO_CACHE */ `id`,`c1`,`createtime` FROM `audit_db`.`t` FORCE INDEX(`PRIMARY`) WHERE (id <= 3 and id >= 1 and createTime >= "2020-05-28 00:00:00.000" and createTime < "2020-05-29 00:00:00.000") AND (`id` <= '4') AND ((`id` >= '3')) ORDER BY `id` LIMIT 20000
	2020-05-29T08:28:51.450848Z	 7758 Query	commit
	2020-05-29T08:28:51.451111Z	 7757 Query	commit
	2020-05-29T08:28:51.451711Z	 7758 Quit	


4. 小结
	插入的数据和删除的数据在不了同一个事务的, 因为归档语句可能是要跨数据库服务器的. 



