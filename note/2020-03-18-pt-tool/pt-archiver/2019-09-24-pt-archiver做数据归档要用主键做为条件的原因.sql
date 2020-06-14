
1. 表结构和数据的初始化
2. 命令执行
3. general log
4. 对比分析
5. 小结

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
	INSERT INTO `t` (`id`, `c1`, `createTime`) VALUES ('5', '5', '2020-05-29 15:57:58');
	INSERT INTO `t` (`id`, `c1`, `createTime`) VALUES ('6', '6', '2020-05-29 15:57:58');

	drop table if exists t20200528;
	CREATE TABLE `t20200528` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c1` int(11) DEFAULT NULL,
	  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '开始时间',
	  PRIMARY KEY (`id`),
	  KEY `idx_createTime` (`createTime`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
	INSERT INTO `t` (`id`, `c1`, `createTime`) VALUES ('5', '5', '2020-05-29 15:57:58');
	INSERT INTO `t` (`id`, `c1`, `createTime`) VALUES ('6', '6', '2020-05-29 15:57:58');
	INSERT INTO `t` (`id`, `c1`, `createTime`) VALUES ('7', '7', '2020-05-29 15:57:58');
	INSERT INTO `t` (`id`, `c1`, `createTime`) VALUES ('8', '8', '2020-05-29 15:57:58');
	INSERT INTO `t` (`id`, `c1`, `createTime`) VALUES ('9', '9', '2020-05-29 15:57:58');
	INSERT INTO `t` (`id`, `c1`, `createTime`) VALUES ('10', '10', '2020-05-29 15:57:58');

	drop table if exists t20200528;
	CREATE TABLE `t20200528` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c1` int(11) DEFAULT NULL,
	  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '开始时间',
	  PRIMARY KEY (`id`),
	  KEY `idx_createTime` (`createTime`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

	
	
2. 不带主键
	命令执行
		pt-archiver --source h=192.168.0.252,u=root,p=,P=3306,D=audit_db,t=t,A=utf8mb4 --dest h=192.168.0.252,u=root,p=,P=3306,D=audit_db,t=t20200528 --charset=utf8mb4 --progress 10000 --where 'createTime >= "2020-05-28 00:00:00.000" and createTime < "2020-05-29 00:00:00.000"'  --statistics --limit=20000 --txn-size 1000 --sleep 1 --no-delete

		TIME                ELAPSED   COUNT
		2020-05-29T17:12:10       0       0
		2020-05-29T17:12:10       0       2
		Started at 2020-05-29T17:12:10, ended at 2020-05-29T17:12:11
		Source: A=utf8mb4,D=audit_db,P=3306,h=192.168.0.252,p=...,t=t,u=root
		Dest:   A=utf8mb4,D=audit_db,P=3306,h=192.168.0.252,p=...,t=t20200528,u=root
		SELECT 2
		INSERT 2
		DELETE 0
		Action         Count       Time        Pct
		sleep              1     1.0002      99.32
		select             2     0.0016       0.16
		inserting          2     0.0009       0.09
		commit             2     0.0007       0.07
		other              0     0.0037       0.36

	general log

		2020-05-29T09:12:11.325913Z	 8182 Connect	root@192.168.0.242 on audit_db using TCP/IP
		2020-05-29T09:12:11.326164Z	 8182 Query	set autocommit=0
		2020-05-29T09:12:11.326375Z	 8182 Query	/*!40101 SET NAMES "utf8mb4"*/
		2020-05-29T09:12:11.326646Z	 8182 Query	SHOW VARIABLES LIKE 'wait\_timeout'
		2020-05-29T09:12:11.328091Z	 8182 Query	SET SESSION wait_timeout=10000
		2020-05-29T09:12:11.328351Z	 8182 Query	SELECT @@SQL_MODE
		2020-05-29T09:12:11.328764Z	 8182 Query	SET @@SQL_QUOTE_SHOW_CREATE = 1/*!40101, @@SQL_MODE='NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION'*/
		2020-05-29T09:12:11.328978Z	 8182 Query	SELECT version()
		2020-05-29T09:12:11.329413Z	 8182 Query	SHOW VARIABLES LIKE 'version%'
		2020-05-29T09:12:11.330804Z	 8182 Query	SHOW ENGINES
		2020-05-29T09:12:11.331493Z	 8182 Query	SHOW VARIABLES LIKE 'innodb_version'
		2020-05-29T09:12:11.333010Z	 8182 Query	show variables like 'innodb_rollback_on_timeout'
		2020-05-29T09:12:11.334541Z	 8182 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
		2020-05-29T09:12:11.334805Z	 8182 Query	USE `audit_db`
		2020-05-29T09:12:11.335048Z	 8182 Query	SHOW CREATE TABLE `audit_db`.`t`
		2020-05-29T09:12:11.335739Z	 8182 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
		2020-05-29T09:12:11.345210Z	 8182 Query	SELECT CONCAT(/*!40100 @@session.character_set_connection, */ "")
		2020-05-29T09:12:11.346331Z	 8183 Connect	root@192.168.0.242 on audit_db using TCP/IP
		2020-05-29T09:12:11.346526Z	 8183 Query	set autocommit=0
		2020-05-29T09:12:11.346725Z	 8183 Query	/*!40101 SET NAMES "utf8mb4"*/
		2020-05-29T09:12:11.346922Z	 8183 Query	SHOW VARIABLES LIKE 'wait\_timeout'
		2020-05-29T09:12:11.348863Z	 8183 Query	SET SESSION wait_timeout=10000
		2020-05-29T09:12:11.349049Z	 8183 Query	SELECT @@SQL_MODE
		2020-05-29T09:12:11.349439Z	 8183 Query	SET @@SQL_QUOTE_SHOW_CREATE = 1/*!40101, @@SQL_MODE='NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION'*/
		2020-05-29T09:12:11.349618Z	 8183 Query	SELECT version()
		2020-05-29T09:12:11.349941Z	 8183 Query	SHOW VARIABLES LIKE 'version%'
		2020-05-29T09:12:11.351933Z	 8183 Query	SHOW ENGINES
		2020-05-29T09:12:11.352825Z	 8183 Query	SHOW VARIABLES LIKE 'innodb_version'
		2020-05-29T09:12:11.354944Z	 8183 Query	show variables like 'innodb_rollback_on_timeout'
		2020-05-29T09:12:11.357040Z	 8183 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
		2020-05-29T09:12:11.357357Z	 8183 Query	USE `audit_db`
		2020-05-29T09:12:11.357665Z	 8183 Query	SHOW CREATE TABLE `audit_db`.`t20200528`
		2020-05-29T09:12:11.358543Z	 8183 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
		2020-05-29T09:12:11.359065Z	 8183 Query	SELECT CONCAT(/*!40100 @@session.character_set_connection, */ "")
		2020-05-29T09:12:11.359480Z	 8182 Query	SHOW VARIABLES LIKE 'wsrep_on'
		2020-05-29T09:12:11.360866Z	 8182 Query	SHOW VARIABLES LIKE 'wsrep_on'
		2020-05-29T09:12:11.362517Z	 8182 Query	SHOW VARIABLES LIKE 'version%'
		2020-05-29T09:12:11.363917Z	 8182 Query	SHOW ENGINES
		2020-05-29T09:12:11.364735Z	 8182 Query	SHOW VARIABLES LIKE 'innodb_version'
		2020-05-29T09:12:11.366181Z	 8182 Query	SELECT MAX(`id`) FROM `audit_db`.`t`
		2020-05-29T09:12:11.366729Z	 8182 Query	SELECT CONCAT(@@hostname, @@port)
		2020-05-29T09:12:11.367052Z	 8183 Query	SELECT CONCAT(@@hostname, @@port)
		2020-05-29T09:12:11.367706Z	 8182 Query	SELECT /*!40001 SQL_NO_CACHE */ `id`,`c1`,`createtime` FROM `audit_db`.`t` FORCE INDEX(`PRIMARY`) WHERE (createTime >= "2020-05-28 00:00:00.000" and createTime < "2020-05-29 00:00:00.000") AND (`id` <= '10') ORDER BY `id` LIMIT 20000
		
			SELECT
			/*!40001 SQL_NO_CACHE */
			`id`,
			`c1`,
			`createtime`
			FROM
				`audit_db`.`t` FORCE INDEX (`PRIMARY`)
			WHERE
				(
					createTime >= "2020-05-28 00:00:00.000"
					AND createTime < "2020-05-29 00:00:00.000"
				)
			AND (`id` <= '10')
			ORDER BY
				`id`
			LIMIT 20000;

		2020-05-29T09:12:11.371428Z	 8183 Query	INSERT INTO `audit_db`.`t20200528`(`id`,`c1`,`createtime`) VALUES ('1','1','2020-05-28 15:57:38')
		2020-05-29T09:12:11.371873Z	 8182 Query	SELECT 'pt-archiver keepalive'
		2020-05-29T09:12:11.372329Z	 8183 Query	INSERT INTO `audit_db`.`t20200528`(`id`,`c1`,`createtime`) VALUES ('3','3','2020-05-28 15:57:58')
		2020-05-29T09:12:12.373092Z	 8182 Query	SELECT /*!40001 SQL_NO_CACHE */ `id`,`c1`,`createtime` FROM `audit_db`.`t` FORCE INDEX(`PRIMARY`) WHERE (createTime >= "2020-05-28 00:00:00.000" and createTime < "2020-05-29 00:00:00.000") AND (`id` <= '10') AND ((`id` > '3')) ORDER BY `id` LIMIT 20000
		2020-05-29T09:12:12.373784Z	 8183 Query	commit
		2020-05-29T09:12:12.374183Z	 8182 Query	commit
		2020-05-29T09:12:12.374809Z	 8182 Quit	

	
3. 带主键
	命令执行
		pt-archiver --source h=192.168.0.252,u=root,p=root@481845%,P=3306,D=audit_db,t=t,A=utf8mb4 --dest h=192.168.0.252,u=root,p=root@481845%,P=3306,D=audit_db,t=t20200528 --charset=utf8mb4 --progress 10000 --where 'id <= 3 and id >= 1 and createTime >= "2020-05-28 00:00:00.000" and createTime < "2020-05-29 00:00:00.000"'  --statistics --limit=20000 --txn-size 1000 --sleep 1 --no-delete
		TIME                ELAPSED   COUNT
		2020-05-29T17:16:27       0       0
		2020-05-29T17:16:27       0       2
		Started at 2020-05-29T17:16:27, ended at 2020-05-29T17:16:28
		Source: A=utf8mb4,D=audit_db,P=3306,h=192.168.0.252,p=...,t=t,u=root
		Dest:   A=utf8mb4,D=audit_db,P=3306,h=192.168.0.252,p=...,t=t20200528,u=root
		SELECT 2
		INSERT 2
		DELETE 0
		Action         Count       Time        Pct
		sleep              1     1.0002      99.35
		select             2     0.0015       0.15
		inserting          2     0.0007       0.07
		commit             2     0.0007       0.07
		other              0     0.0036       0.36
	
	general log
		2020-05-29T09:16:28.064581Z	 8189 Connect	root@192.168.0.242 on audit_db using TCP/IP
		2020-05-29T09:16:28.064823Z	 8189 Query	set autocommit=0
		2020-05-29T09:16:28.065030Z	 8189 Query	/*!40101 SET NAMES "utf8mb4"*/
		2020-05-29T09:16:28.065351Z	 8189 Query	SHOW VARIABLES LIKE 'wait\_timeout'
		2020-05-29T09:16:28.066737Z	 8189 Query	SET SESSION wait_timeout=10000
		2020-05-29T09:16:28.066927Z	 8189 Query	SELECT @@SQL_MODE
		2020-05-29T09:16:28.067422Z	 8189 Query	SET @@SQL_QUOTE_SHOW_CREATE = 1/*!40101, @@SQL_MODE='NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION'*/
		2020-05-29T09:16:28.067658Z	 8189 Query	SELECT version()
		2020-05-29T09:16:28.067987Z	 8189 Query	SHOW VARIABLES LIKE 'version%'
		2020-05-29T09:16:28.069406Z	 8189 Query	SHOW ENGINES
		2020-05-29T09:16:28.070175Z	 8189 Query	SHOW VARIABLES LIKE 'innodb_version'
		2020-05-29T09:16:28.071756Z	 8189 Query	show variables like 'innodb_rollback_on_timeout'
		2020-05-29T09:16:28.073192Z	 8189 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
		2020-05-29T09:16:28.073410Z	 8189 Query	USE `audit_db`
		2020-05-29T09:16:28.073599Z	 8189 Query	SHOW CREATE TABLE `audit_db`.`t`
		2020-05-29T09:16:28.074063Z	 8189 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
		2020-05-29T09:16:28.083404Z	 8189 Query	SELECT CONCAT(/*!40100 @@session.character_set_connection, */ "")
		2020-05-29T09:16:28.084430Z	 8190 Connect	root@192.168.0.242 on audit_db using TCP/IP
		2020-05-29T09:16:28.084683Z	 8190 Query	set autocommit=0
		2020-05-29T09:16:28.084863Z	 8190 Query	/*!40101 SET NAMES "utf8mb4"*/
		2020-05-29T09:16:28.085060Z	 8190 Query	SHOW VARIABLES LIKE 'wait\_timeout'
		2020-05-29T09:16:28.086995Z	 8190 Query	SET SESSION wait_timeout=10000
		2020-05-29T09:16:28.087159Z	 8190 Query	SELECT @@SQL_MODE
		2020-05-29T09:16:28.087558Z	 8190 Query	SET @@SQL_QUOTE_SHOW_CREATE = 1/*!40101, @@SQL_MODE='NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION'*/
		2020-05-29T09:16:28.087743Z	 8190 Query	SELECT version()
		2020-05-29T09:16:28.088043Z	 8190 Query	SHOW VARIABLES LIKE 'version%'
		2020-05-29T09:16:28.089994Z	 8190 Query	SHOW ENGINES
		2020-05-29T09:16:28.090663Z	 8190 Query	SHOW VARIABLES LIKE 'innodb_version'
		2020-05-29T09:16:28.092923Z	 8190 Query	show variables like 'innodb_rollback_on_timeout'
		2020-05-29T09:16:28.095165Z	 8190 Query	/*!40101 SET @OLD_SQL_MODE := @@SQL_MODE, @@SQL_MODE := '', @OLD_QUOTE := @@SQL_QUOTE_SHOW_CREATE, @@SQL_QUOTE_SHOW_CREATE := 1 */
		2020-05-29T09:16:28.095485Z	 8190 Query	USE `audit_db`
		2020-05-29T09:16:28.095765Z	 8190 Query	SHOW CREATE TABLE `audit_db`.`t20200528`
		2020-05-29T09:16:28.096633Z	 8190 Query	/*!40101 SET @@SQL_MODE := @OLD_SQL_MODE, @@SQL_QUOTE_SHOW_CREATE := @OLD_QUOTE */
		2020-05-29T09:16:28.097322Z	 8190 Query	SELECT CONCAT(/*!40100 @@session.character_set_connection, */ "")
		2020-05-29T09:16:28.097870Z	 8189 Query	SHOW VARIABLES LIKE 'wsrep_on'
		2020-05-29T09:16:28.099305Z	 8189 Query	SHOW VARIABLES LIKE 'wsrep_on'
		2020-05-29T09:16:28.100947Z	 8189 Query	SHOW VARIABLES LIKE 'version%'
		2020-05-29T09:16:28.102423Z	 8189 Query	SHOW ENGINES
		2020-05-29T09:16:28.103247Z	 8189 Query	SHOW VARIABLES LIKE 'innodb_version'
		2020-05-29T09:16:28.104725Z	 8189 Query	SELECT MAX(`id`) FROM `audit_db`.`t`
		2020-05-29T09:16:28.105510Z	 8189 Query	SELECT CONCAT(@@hostname, @@port)
		2020-05-29T09:16:28.106041Z	 8190 Query	SELECT CONCAT(@@hostname, @@port)
		2020-05-29T09:16:28.106849Z	 8189 Query	SELECT /*!40001 SQL_NO_CACHE */ `id`,`c1`,`createtime` FROM `audit_db`.`t` FORCE INDEX(`PRIMARY`) WHERE (id <= 3 and id >= 1 and createTime >= "2020-05-28 00:00:00.000" and createTime < "2020-05-29 00:00:00.000") AND (`id` <= '10') ORDER BY `id` LIMIT 20000
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
			AND (`id` <= '10')
			ORDER BY
				`id`
			LIMIT 20000;
			
		2020-05-29T09:16:28.110568Z	 8190 Query	INSERT INTO `audit_db`.`t20200528`(`id`,`c1`,`createtime`) VALUES ('1','1','2020-05-28 15:57:38')
		2020-05-29T09:16:28.110908Z	 8189 Query	SELECT 'pt-archiver keepalive'
		2020-05-29T09:16:28.111270Z	 8190 Query	INSERT INTO `audit_db`.`t20200528`(`id`,`c1`,`createtime`) VALUES ('3','3','2020-05-28 15:57:58')
		2020-05-29T09:16:29.112050Z	 8189 Query	SELECT /*!40001 SQL_NO_CACHE */ `id`,`c1`,`createtime` FROM `audit_db`.`t` FORCE INDEX(`PRIMARY`) WHERE (id <= 3 and id >= 1 and createTime >= "2020-05-28 00:00:00.000" and createTime < "2020-05-29 00:00:00.000") AND (`id` <= '10') AND ((`id` > '3')) ORDER BY `id` LIMIT 20000
		2020-05-29T09:16:29.112630Z	 8190 Query	commit
		2020-05-29T09:16:29.113052Z	 8189 Query	commit
		2020-05-29T09:16:29.113721Z	 8190 Quit	
					
			
4. 对比分析

	不带主键
		mysql> desc SELECT
			-> /*!40001 SQL_NO_CACHE */
			-> `id`,
			-> `c1`,
			-> `createtime`
			-> FROM
			-> `audit_db`.`t` FORCE INDEX (`PRIMARY`)
			-> WHERE
			-> (
			-> createTime >= "2020-05-28 00:00:00.000"
			-> AND createTime < "2020-05-29 00:00:00.000"
			-> )
			-> AND (`id` <= '10')
			-> ORDER BY
			-> `id`
			-> LIMIT 20000;
		+----+-------------+-------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
		| id | select_type | table | partitions | type  | possible_keys | key     | key_len | ref  | rows | filtered | Extra       |
		+----+-------------+-------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
		|  1 | SIMPLE      | t     | NULL       | range | PRIMARY       | PRIMARY | 8       | NULL |   10 |    11.11 | Using where |
		+----+-------------+-------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
		1 row in set, 2 warnings (0.00 sec)

		执行了10行记录	
		
	带主键

		mysql> desc SELECT
			-> /*!40001 SQL_NO_CACHE */
			-> `id`,
			-> `c1`,
			-> `createtime`
			-> FROM
			-> `audit_db`.`t` FORCE INDEX (`PRIMARY`)
			-> WHERE
			-> (
			-> id <= 3
			-> AND id >= 1
			-> AND createTime >= "2020-05-28 00:00:00.000"
			-> AND createTime < "2020-05-29 00:00:00.000"
			-> )
			-> AND (`id` <= '10')
			-> ORDER BY
			-> `id`
			-> LIMIT 20000;
		+----+-------------+-------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
		| id | select_type | table | partitions | type  | possible_keys | key     | key_len | ref  | rows | filtered | Extra       |
		+----+-------------+-------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
		|  1 | SIMPLE      | t     | NULL       | range | PRIMARY       | PRIMARY | 8       | NULL |    3 |    11.11 | Using where |
		+----+-------------+-------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
		1 row in set, 2 warnings (0.00 sec)

		执行了3行记录

	迁移的数据:
		mysql> select * from audit_db.t20200528;
		+----+------+---------------------+
		| id | c1   | createTime          |
		+----+------+---------------------+
		|  1 |    1 | 2020-05-28 15:57:38 |
		|  3 |    3 | 2020-05-28 15:57:58 |
		+----+------+---------------------+
		2 rows in set (0.00 sec)

5. 小结		
	因为归档语句是强制走主键索引, 如果归档语句不带入根据日期范围获取对应主键的最大值和小值, 那么查询条件会走基于主键索引的全表扫描, 如果是大表的话, 不仅归档操作会慢, 同时也会占用大量的IO资源, 影响数据的写入和脏页的刷盘.
	
	数据库错误日志会有如下警告
		2020-05-27T14:24:25.119855Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 18102ms. The settings might not be optimal. (flushed=4002 and evicted=0, during the time.)
		2020-05-27T14:24:41.831830Z 0 [Note] InnoDB: page_cleaner: 1000ms intended loop took 15909ms. The settings might not be optimal. (flushed=3376 and evicted=0, during the time.)
	
	归档的条件要加时间范围与id最大值、最小值范围, 如果只带时间范围对应的id最大值和最小值, 当时间不是有序的, 数据会对应不上, 如下所示
		
		全表数据
			mysql>  select ID,CreateTime  from audit_db.t1;
			+---------+---------------------+
			| ID      | CreateTime          |
			+---------+---------------------+
			| 7431913 | 2020-05-23 17:45:24 |
			| 7431912 | 2020-05-24 17:43:16 |
			| 7431911 | 2020-05-25 17:37:24 |
			| 7431910 | 2020-05-26 17:14:16 |
			| 7431909 | 2020-05-27 16:46:16 |
			| 7431915 | 2020-05-27 17:45:24 |
			| 7431908 | 2020-05-28 16:35:12 |
			+---------+---------------------+
			7 rows in set (0.00 sec)


		实际要归档的数据
			mysql> select  min(ID) as min_id , max(ID) as max_id,count(*) from audit_db.t1 where CreateTime >= "2020-05-27 00:00:00.000" and CreateTime < "2020-05-28 00:00:00.000";
			+---------+---------+----------+
			| min_id  | max_id  | count(*) |
			+---------+---------+----------+
			| 7431909 | 7431915 |        2 |
			+---------+---------+----------+
			1 row in set (0.00 sec)
		
		pt-archiver
			FROM
			`audit_db`.`t1` FORCE INDEX (`PRIMARY`)
				WHERE
					(
						id <= 7431915
						AND id >= 7431909
					)
				ORDER BY
					`id`
				LIMIT 20000
		
			mysql> select  min(ID) as min_id , max(ID) as max_id,count(*) from audit_db.t1 where id <= 7431915 AND id >= 7431909;
			+---------+---------+----------+
			| min_id  | max_id  | count(*) |
			+---------+---------+----------+
			| 7431909 | 7431915 |        6 |
			+---------+---------+----------+
			1 row in set (0.00 sec)

		本来符合归档条件的只有2条记录, 如果只带id的最大值和最小值做范围查询条件, 那么归档的数据会不正确.
		
		
		

	