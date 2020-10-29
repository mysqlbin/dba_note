

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



binlog2sql

create user 'binlog2sql'@'%' identified by '123456';
GRANT SELECT, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'binlog2sql'@'%' with grant option;
	
	
根据时间点找posistion位置点

	python /root/binlog2sql/binlog2sql/binlog2sql.py -h192.168.0.242 -P3306 -ubinlog2sql -p'123456' -dyldbs -ttable_user_bak --start-file='mysql-bin.000048' --start-datetime='2020-10-29 17:22:00' --stop-datetime='2020-10-29 17:25:00' > 648.sql




在时间范围中确定 开始位置和结束位置，同时生成回滚语句，在
	
	python /root/binlog2sql/binlog2sql/binlog2sql.py -h192.168.0.242 -P3306 -ubinlog2sql -p'123456' -dyldbs -ttable_user_bak --start-file='mysql-bin.000048' --start-position=259 --stop-position=29288697 -B > rollback.sql | cat



小结：
有时候命令行工具不能执行，放到 navicat工具中就可以执行
有时候navicat工具不能执行，放到 命令行工具中就可以执行
