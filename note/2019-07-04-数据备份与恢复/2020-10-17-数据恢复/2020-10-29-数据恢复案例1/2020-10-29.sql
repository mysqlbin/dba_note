

0. 环境
	上线差不多1年的游戏，用户量约50w, 日新增用户约 select 500000/365 = 1400。
	
1. 事情发生经过
	
	CREATE TABLE `table_user` (
	  `nPlayerId` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '玩家用户Id',
	  .........................................................................
	  `extendCode` int(11) DEFAULT '0' COMMENT '推广码',
	  `preLoginTime` timestamp NULL DEFAULT NULL,
	  `preLoginIp` varchar(64) DEFAULT NULL,
	.........................................................................
	  PRIMARY KEY (`nPlayerId`),
	  KEY `idx_extendCode` (`extendCode`),,
	  KEY `idx_szCreateTime` (`szCreateTime`)
	) ENGINE=InnoDB AUTO_INCREMENT=584221 DEFAULT CHARSET=utf8mb4;


	mysql> update table_user_bak set extendCode=0 where 149435;
	Query OK, 53524 rows affected (2.84 sec)
	Rows matched: 584221  Changed: 53524  Warnings: 0

	这个会把所有玩家ID的推广码改为0.
	
	
	
3. 制定数据恢复的策略
	0. 执行flush logs命令
	1. 跟业务方确定了可以不需要停服
	2. 上午11点左右发生的误操作，在6点有对单库的全备
	3. 从单库的全备中快速恢复单表，流程在对应的笔记：《2020-10-28-从mysqldump全备中恢复单表数据的方式.sql》
	4. 恢复的单表进行改名，然后导入生产环境中，把误操作的表跟恢复出来的单表进行 update join关联更新，每次更新5000行记录	
		参考笔记：《2020-10-29-验证update join关联更新语句的加锁规则.sql》
		
	5. 接着对6点到11点的用户数据进行增量恢复，使用的工具是 binlog2sql，基本流程如下：
		1. 明确6点之后新注册的玩家数据才需要恢复
		2. 把误操作的表数据 小于增量数据的 插入到恢复出来的单表数据中
		3. 接下来真正用binlog2sql进行操作，提取更新语句，应用到恢复出来的单表数据中
		4. 接着再进行对误操作表的增量数据进行一次update join关联更新
		5. 数据恢复完成
		
	6. 整个过程耗时约30分钟
		
	
	
4. binlog2sql恢复增量数据的大概流程

	create user 'binlog2sql'@'%' identified by '123456';
	GRANT SELECT, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'binlog2sql'@'%' with grant option;
		
		
	根据时间点找posistion位置点

		python /root/binlog2sql/binlog2sql/binlog2sql.py -h192.168.0.242 -P3306 -ubinlog2sql -p'123456' -dyldbs -ttable_user_bak --start-file='mysql-bin.000048' --start-datetime='2020-10-29 17:22:00' --stop-datetime='2020-10-29 17:25:00' > 648.sql

	在时间范围中确定 开始位置和结束位置，同时生成回滚语句，在
		
		python /root/binlog2sql/binlog2sql/binlog2sql.py -h192.168.0.242 -P3306 -ubinlog2sql -p'123456' -dyldbs -ttable_user_bak --start-file='mysql-bin.000048' --start-position=259 --stop-position=29288697 -B > rollback.sql | cat
		
		用回滚语句增量的数据进行恢复。
	


	有时候命令行工具不能执行回滚语句，放到 navicat工具中就可以执行
	有时候navicat工具不能执行回滚语句，放到 命令行工具中就可以执行
