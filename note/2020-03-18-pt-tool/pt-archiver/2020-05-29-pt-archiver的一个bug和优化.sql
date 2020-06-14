

1. 表结构和数据的初始化
2. 命令执行
3. 数据迁移情况
4. general log
5. 解决办法


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


	drop table if exists t20200528;
	CREATE TABLE `t20200528` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c1` int(11) DEFAULT NULL,
	  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '开始时间',
	  PRIMARY KEY (`id`),
	  KEY `idx_createTime` (`createTime`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


2. 命令执行
	[root@localhost ~]# python pt_archiver_by_date_py2.py  -soD=audit_db -soT=t -deD=audit_db -deT='1' -field=createTime -beforeDay=-1
	2020-05-28 00:00:00
	2020-05-29 00:00:00
	select  min(ID) as min_id , max(ID) as max_id from audit_db.t where createTime >= "2020-05-28 00:00:00.000" and createTime < "2020-05-29 00:00:00.000"
	2020-05-28 00:00:00
	20200528
	 pt-archiver     --source h=192.168.0.1,u=root,p=123456abc,P=3306,D=audit_db,t=t,A=utf8mb4     --dest h=192.168.0.1,u=root,p=123456abc,P=3306,D=audit_db,t=t20200528 --charset=utf8mb4 --progress 10000     --where 'id <= 3 and id >= 1 and createTime >= "2020-05-28 00:00:00.000" and createTime < "2020-05-29 00:00:00.000"'     --statistics --limit=20000 --txn-size 1000 --sleep 1 --no-delete
	{'status': 1, 'msg': 'ok', 'data': [{'started_time': 'Started at 2020-05-29T16:02:51', 'ended_time': ' ended at 2020-05-29T16:02:52\n'}, {'insert_row': 'INSERT 1\n'}, {'delete_row': 'DELETE 0\n'}]}

	
3. 数据迁移情况
	总数据
		root@mysqldb 16:04:  [(none)]> select  * from audit_db.t;
		+----+------+---------------------+
		| id | c1   | createTime          |
		+----+------+---------------------+
		|  1 |    1 | 2020-05-28 15:57:38 |
		|  2 |    2 | 2020-05-27 15:57:48 |
		|  3 |    3 | 2020-05-28 15:57:58 |
		+----+------+---------------------+
		3 rows in set (0.00 sec)
		
	实际要迁移的数据
		root@mysqldb 16:04:  [(none)]> select  * from audit_db.t where createTime >= "2020-05-28 00:00:00.000" and createTime < "2020-05-29 00:00:00.000";
		+----+------+---------------------+
		| id | c1   | createTime          |
		+----+------+---------------------+
		|  1 |    1 | 2020-05-28 15:57:38 |
		|  3 |    3 | 2020-05-28 15:57:58 |
		+----+------+---------------------+
		2 rows in set (0.00 sec)
	
	实际迁移完成的数据
		root@mysqldb 16:05:  [(none)]> select * from audit_db.t20200528;
		+----+------+---------------------+
		| id | c1   | createTime          |
		+----+------+---------------------+
		|  1 |    1 | 2020-05-28 15:57:38 |
		+----+------+---------------------+
		1 row in set (0.00 sec)

4. general log

	2020-05-29T08:02:52.126585Z	 7519 Connect	root@192.168.0.242 on  using TCP/IP
	2020-05-29T08:02:52.127862Z	 7519 Query	SET NAMES utf8mb4
	2020-05-29T08:02:52.128139Z	 7519 Query	set autocommit=0
	2020-05-29T08:02:52.128536Z	 7519 Query	select  min(ID) as min_id , max(ID) as max_id from audit_db.t where createTime >= "2020-05-28 00:00:00.000" and createTime < "2020-05-29 00:00:00.000"
	2020-05-29T08:02:52.129061Z	 7519 Quit	
	2020-05-29T08:02:52.223665Z	 7520 Connect	root@192.168.0.242 on audit_db using TCP/IP
	2020-05-29T08:02:52.223884Z	 7520 Query	set autocommit=0
	2020-05-29T08:02:52.224054Z	 7520 Query	/*!40101 SET NAMES "utf8mb4"*/
	2020-05-29T08:02:52.224274Z	 7520 Query	SHOW VARIABLES LIKE 'wait\_timeout'
	2020-05-29T08:02:52.225595Z	 7520 Query	SET SESSION wait_timeout=10000
	2020-05-29T08:02:52.225768Z	 7520 Query	SELECT @@SQL_MODE
	2020-05-29T08:02:52.226158Z	 7520 Query	SET @@SQL_QUOTE_SHOW_CREATE = 1/*!40101, @@SQL_MODE='NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION'*/
	2020-05-29T08:02:52.226395Z	 7520 Query	SELECT version()
	2020-05-29T08:02:52.226709Z	 7520 Query	SHOW VARIABLES LIKE 'version%'
	2020-05-29T08:02:52.228057Z	 7520 Query	SHOW ENGINES
	2020-05-29T08:02:52.228806Z	 7520 Query	SHOW VARIABLES LIKE 'innodb_version'
	2020-05-29T08:02:52.230449Z	 7520 Query	show variables like 'innodb_rollback_on_timeout'
	2020-05-29T08:02:52.232043Z	 7520 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
	2020-05-29T08:02:52.232405Z	 7520 Query	USE `audit_db`
	2020-05-29T08:02:52.232731Z	 7520 Query	SHOW CREATE TABLE `audit_db`.`t`
	2020-05-29T08:02:52.233464Z	 7520 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
	2020-05-29T08:02:52.242938Z	 7520 Query	SELECT CONCAT(/*!40100 @@session.character_set_connection, */ "")
	2020-05-29T08:02:52.244171Z	 7521 Connect	root@192.168.0.242 on audit_db using TCP/IP
	2020-05-29T08:02:52.244384Z	 7521 Query	set autocommit=0
	2020-05-29T08:02:52.244559Z	 7521 Query	/*!40101 SET NAMES "utf8mb4"*/
	2020-05-29T08:02:52.244751Z	 7521 Query	SHOW VARIABLES LIKE 'wait\_timeout'
	2020-05-29T08:02:52.246094Z	 7521 Query	SET SESSION wait_timeout=10000
	2020-05-29T08:02:52.246282Z	 7521 Query	SELECT @@SQL_MODE
	2020-05-29T08:02:52.246673Z	 7521 Query	SET @@SQL_QUOTE_SHOW_CREATE = 1/*!40101, @@SQL_MODE='NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION'*/
	2020-05-29T08:02:52.246843Z	 7521 Query	SELECT version()
	2020-05-29T08:02:52.247172Z	 7521 Query	SHOW VARIABLES LIKE 'version%'
	2020-05-29T08:02:52.248588Z	 7521 Query	SHOW ENGINES
	2020-05-29T08:02:52.249300Z	 7521 Query	SHOW VARIABLES LIKE 'innodb_version'
	2020-05-29T08:02:52.250784Z	 7521 Query	show variables like 'innodb_rollback_on_timeout'
	2020-05-29T08:02:52.252294Z	 7521 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
	2020-05-29T08:02:52.252651Z	 7521 Query	USE `audit_db`
	2020-05-29T08:02:52.252961Z	 7521 Query	SHOW CREATE TABLE `audit_db`.`t20200528`
	2020-05-29T08:02:52.253849Z	 7521 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
	2020-05-29T08:02:52.254535Z	 7521 Query	SELECT CONCAT(/*!40100 @@session.character_set_connection, */ "")
	2020-05-29T08:02:52.255055Z	 7520 Query	SHOW VARIABLES LIKE 'wsrep_on'
	2020-05-29T08:02:52.256540Z	 7520 Query	SHOW VARIABLES LIKE 'wsrep_on'
	2020-05-29T08:02:52.258193Z	 7520 Query	SHOW VARIABLES LIKE 'version%'
	2020-05-29T08:02:52.259624Z	 7520 Query	SHOW ENGINES
	2020-05-29T08:02:52.260541Z	 7520 Query	SHOW VARIABLES LIKE 'innodb_version'
	2020-05-29T08:02:52.262227Z	 7520 Query	SELECT MAX(`id`) FROM `audit_db`.`t`
	2020-05-29T08:02:52.262788Z	 7520 Query	SELECT CONCAT(@@hostname, @@port)
	2020-05-29T08:02:52.263151Z	 7521 Query	SELECT CONCAT(@@hostname, @@port)
	2020-05-29T08:02:52.263840Z	 7520 Query	SELECT /*!40001 SQL_NO_CACHE */ `id`,`c1`,`createtime` FROM `audit_db`.`t` FORCE INDEX(`PRIMARY`) WHERE (id <= 3 and id >= 1 and createTime >= "2020-05-28 00:00:00.000" and createTime < "2020-05-29 00:00:00.000") AND (`id` < '3') ORDER BY `id` LIMIT 20000
		SELECT
		/*!40001 SQL_NO_CACHE */
		`id`,
		`c1`,
		`createtime`
		FROM
			`audit_db`.`t` FORCE INDEX (`PRIMARY`)
		WHERE
			(
				id <= 3
				AND id >= 1
				AND createTime >= "2020-05-28 00:00:00.000"
				AND createTime < "2020-05-29 00:00:00.000"
			)
		AND (`id` < '3')
		ORDER BY
			`id`
		LIMIT 20000
	2020-05-29T08:02:52.267549Z	 7521 Query	INSERT INTO `audit_db`.`t20200528`(`id`,`c1`,`createtime`) VALUES ('1','1','2020-05-28 15:57:38')
	2020-05-29T08:02:53.268506Z	 7520 Query	SELECT /*!40001 SQL_NO_CACHE */ `id`,`c1`,`createtime` FROM `audit_db`.`t` FORCE INDEX(`PRIMARY`) WHERE (id <= 3 and id >= 1 and createTime >= "2020-05-28 00:00:00.000" and createTime < "2020-05-29 00:00:00.000") AND (`id` < '3') AND ((`id` > '1')) ORDER BY `id` LIMIT 20000
	2020-05-29T08:02:53.269381Z	 7521 Query	commit
	2020-05-29T08:02:53.270034Z	 7520 Query	commit
	2020-05-29T08:02:53.271065Z	 7520 Quit	
	
5. 解决办法
		
	$first_sql .= " AND ($col < " . $q->quote_val($val) . ")"; 
	改为
	$first_sql .= " AND ($col <= " . $q->quote_val($val) . ")";
	
	执行命令
		[root@localhost ~]# python pt_archiver_by_date_py2.py  -soD=audit_db -soT=t -deD=audit_db -deT='1' -field=createTime -beforeDay=-1
		2020-05-28 00:00:00
		2020-05-29 00:00:00
		select  min(ID) as min_id , max(ID) as max_id from audit_db.t where createTime >= "2020-05-28 00:00:00.000" and createTime < "2020-05-29 00:00:00.000"
		2020-05-28 00:00:00
		20200528
		 pt-archiver     --source h=192.168.0.252,u=root,p=123456abc,P=3306,D=audit_db,t=t,A=utf8mb4     --dest h=192.168.0.252,u=root,p=123456abc,P=3306,D=audit_db,t=t20200528   --charset=utf8mb4 --progress 10000     --where 'id <= 3 and id >= 1 and createTime >= "2020-05-28 00:00:00.000" and createTime < "2020-05-29 00:00:00.000"'     --statistics --limit=20000 --txn-size 1000 --sleep 1 --no-delete
		{'status': 1, 'msg': 'ok', 'data': [{'started_time': 'Started at 2020-05-29T16:11:19', 'ended_time': ' ended at 2020-05-29T16:11:20\n'}, {'insert_row': 'INSERT 2\n'}, {'delete_row': 'DELETE 0\n'}]}
	
	数据迁移情况
		总数据
			root@mysqldb 16:06:  [(none)]> select  * from audit_db.t;
			+----+------+---------------------+
			| id | c1   | createTime          |
			+----+------+---------------------+
			|  1 |    1 | 2020-05-28 15:57:38 |
			|  2 |    2 | 2020-05-27 15:57:48 |
			|  3 |    3 | 2020-05-28 15:57:58 |
			+----+------+---------------------+
			3 rows in set (0.00 sec)
		
		实际要迁移的数据
			root@mysqldb 16:14:  [(none)]> select  * from audit_db.t where createTime >= "2020-05-28 00:00:00.000" and createTime < "2020-05-29 00:00:00.000";
			+----+------+---------------------+
			| id | c1   | createTime          |
			+----+------+---------------------+
			|  1 |    1 | 2020-05-28 15:57:38 |
			|  3 |    3 | 2020-05-28 15:57:58 |
			+----+------+---------------------+
			2 rows in set (0.00 sec)
		
		实际迁移完成的数据
			root@mysqldb 16:14:  [(none)]> select * from audit_db.t20200528;
			+----+------+---------------------+
			| id | c1   | createTime          |
			+----+------+---------------------+
			|  1 |    1 | 2020-05-28 15:57:38 |
			|  3 |    3 | 2020-05-28 15:57:58 |
			+----+------+---------------------+
			2 rows in set (0.00 sec)

	general log
		2020-05-29T08:11:20.284927Z	 7533 Connect	root@192.168.0.242 on audit_db using TCP/IP
		2020-05-29T08:11:20.285151Z	 7533 Query	set autocommit=0
		2020-05-29T08:11:20.285335Z	 7533 Query	/*!40101 SET NAMES "utf8mb4"*/
		2020-05-29T08:11:20.285551Z	 7533 Query	SHOW VARIABLES LIKE 'wait\_timeout'
		2020-05-29T08:11:20.286894Z	 7533 Query	SET SESSION wait_timeout=10000
		2020-05-29T08:11:20.287086Z	 7533 Query	SELECT @@SQL_MODE
		2020-05-29T08:11:20.287453Z	 7533 Query	SET @@SQL_QUOTE_SHOW_CREATE = 1/*!40101, @@SQL_MODE='NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION'*/
		2020-05-29T08:11:20.287658Z	 7533 Query	SELECT version()
		2020-05-29T08:11:20.288041Z	 7533 Query	SHOW VARIABLES LIKE 'version%'
		2020-05-29T08:11:20.289415Z	 7533 Query	SHOW ENGINES
		2020-05-29T08:11:20.290179Z	 7533 Query	SHOW VARIABLES LIKE 'innodb_version'
		2020-05-29T08:11:20.291886Z	 7533 Query	show variables like 'innodb_rollback_on_timeout'
		2020-05-29T08:11:20.293509Z	 7533 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
		2020-05-29T08:11:20.293832Z	 7533 Query	USE `audit_db`
		2020-05-29T08:11:20.294190Z	 7533 Query	SHOW CREATE TABLE `audit_db`.`t`
		2020-05-29T08:11:20.294851Z	 7533 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
		2020-05-29T08:11:20.304303Z	 7533 Query	SELECT CONCAT(/*!40100 @@session.character_set_connection, */ "")
		2020-05-29T08:11:20.305451Z	 7534 Connect	root@192.168.0.242 on audit_db using TCP/IP
		2020-05-29T08:11:20.305661Z	 7534 Query	set autocommit=0
		2020-05-29T08:11:20.305836Z	 7534 Query	/*!40101 SET NAMES "utf8mb4"*/
		2020-05-29T08:11:20.306043Z	 7534 Query	SHOW VARIABLES LIKE 'wait\_timeout'
		2020-05-29T08:11:20.307375Z	 7534 Query	SET SESSION wait_timeout=10000
		2020-05-29T08:11:20.307547Z	 7534 Query	SELECT @@SQL_MODE
		2020-05-29T08:11:20.307958Z	 7534 Query	SET @@SQL_QUOTE_SHOW_CREATE = 1/*!40101, @@SQL_MODE='NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION'*/
		2020-05-29T08:11:20.308183Z	 7534 Query	SELECT version()
		2020-05-29T08:11:20.308491Z	 7534 Query	SHOW VARIABLES LIKE 'version%'
		2020-05-29T08:11:20.309877Z	 7534 Query	SHOW ENGINES
		2020-05-29T08:11:20.310625Z	 7534 Query	SHOW VARIABLES LIKE 'innodb_version'
		2020-05-29T08:11:20.312219Z	 7534 Query	show variables like 'innodb_rollback_on_timeout'
		2020-05-29T08:11:20.313813Z	 7534 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
		2020-05-29T08:11:20.314051Z	 7534 Query	USE `audit_db`
		2020-05-29T08:11:20.314304Z	 7534 Query	SHOW CREATE TABLE `audit_db`.`t20200528`
		2020-05-29T08:11:20.315075Z	 7534 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
		2020-05-29T08:11:20.315658Z	 7534 Query	SELECT CONCAT(/*!40100 @@session.character_set_connection, */ "")
		2020-05-29T08:11:20.316049Z	 7533 Query	SHOW VARIABLES LIKE 'wsrep_on'
		2020-05-29T08:11:20.317425Z	 7533 Query	SHOW VARIABLES LIKE 'wsrep_on'
		2020-05-29T08:11:20.318936Z	 7533 Query	SHOW VARIABLES LIKE 'version%'
		2020-05-29T08:11:20.320253Z	 7533 Query	SHOW ENGINES
		2020-05-29T08:11:20.321103Z	 7533 Query	SHOW VARIABLES LIKE 'innodb_version'
		2020-05-29T08:11:20.322639Z	 7533 Query	SELECT MAX(`id`) FROM `audit_db`.`t`
		2020-05-29T08:11:20.323217Z	 7533 Query	SELECT CONCAT(@@hostname, @@port)
		2020-05-29T08:11:20.323552Z	 7534 Query	SELECT CONCAT(@@hostname, @@port)
		2020-05-29T08:11:20.324188Z	 7533 Query	SELECT /*!40001 SQL_NO_CACHE */ `id`,`c1`,`createtime` FROM `audit_db`.`t` FORCE INDEX(`PRIMARY`) WHERE (id <= 3 and id >= 1 and createTime >= "2020-05-28 00:00:00.000" and createTime < "2020-05-29 00:00:00.000") AND (`id` <= '3') ORDER BY `id` LIMIT 20000
			SELECT
				/*!40001 SQL_NO_CACHE */
				`id`,
				`c1`,
				`createtime`
			FROM
				`audit_db`.`t` FORCE INDEX (`PRIMARY`)
			WHERE
				(
					id <= 3
					AND id >= 1
					AND createTime >= "2020-05-28 00:00:00.000"
					AND createTime < "2020-05-29 00:00:00.000"
				)
			AND (`id` <= '3')
			ORDER BY
				`id`
			LIMIT 20000
		2020-05-29T08:11:20.327930Z	 7534 Query	INSERT INTO `audit_db`.`t20200528`(`id`,`c1`,`createtime`) VALUES ('1','1','2020-05-28 15:57:38')
		2020-05-29T08:11:20.328332Z	 7533 Query	SELECT 'pt-archiver keepalive'
		2020-05-29T08:11:20.328747Z	 7534 Query	INSERT INTO `audit_db`.`t20200528`(`id`,`c1`,`createtime`) VALUES ('3','3','2020-05-28 15:57:58')
		2020-05-29T08:11:21.329668Z	 7533 Query	SELECT /*!40001 SQL_NO_CACHE */ `id`,`c1`,`createtime` FROM `audit_db`.`t` FORCE INDEX(`PRIMARY`) WHERE (id <= 3 and id >= 1 and createTime >= "2020-05-28 00:00:00.000" and createTime < "2020-05-29 00:00:00.000") AND (`id` <= '3') AND ((`id` > '3')) ORDER BY `id` LIMIT 20000
		2020-05-29T08:11:21.330505Z	 7534 Query	commit
		2020-05-29T08:11:21.331016Z	 7533 Query	commit
		2020-05-29T08:11:21.332070Z	 7534 Quit		  
	