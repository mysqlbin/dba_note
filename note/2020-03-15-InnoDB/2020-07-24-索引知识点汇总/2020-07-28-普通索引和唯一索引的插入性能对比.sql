
1. 环境
2. 第一次测试	
3. 第二次测试
4. 小结


1. 环境
	mysql> set global sync_binlog=1;
	Query OK, 0 rows affected (0.00 sec)

	mysql> set global innodb_flush_log_at_trx_commit=1;
	Query OK, 0 rows affected (0.00 sec)


	mysql> show global variables like '%sync_binlog%';
	+---------------+-------+
	| Variable_name | Value |
	+---------------+-------+
	| sync_binlog   | 1     |
	+---------------+-------+
	1 row in set (0.00 sec)

	mysql> show global variables like '%innodb_flush_log_at_trx_commit%';
	+--------------------------------+-------+
	| Variable_name                  | Value |
	+--------------------------------+-------+
	| innodb_flush_log_at_trx_commit | 1     |
	+--------------------------------+-------+
	1 row in set (0.00 sec)

	2核CPU
	物理内存4GB
	BP缓冲池大小为2GB
	磁盘类型为 SSD云盘， 200GB
	
2. 第一次测试	

	drop procedure idata;
	delimiter ;;
	create procedure idata()
	begin
	  declare i int;
	  set i=1;
	  while(i<=100000)do
		insert into t_20200728(name, age, ismale) values(substring(md5(rand()),1,10), i, FLOOR(1 + (RAND() * 100)));
		set i=i+1;
	  end while;

	end;;
	delimiter ;


	   
	普通索引
		CREATE TABLE `t_20200728` (
		  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',  
		  `name` varchar(32) not NULL default '',
		  `age` int(11) not NULL default 0,
		  `ismale` tinyint(1) not null default 0,
		  `createTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  PRIMARY KEY (`id`),
		  KEY `idx_name` (`name`),
		  KEY `idx_age` (`age`),
		  KEY `idx_createTime` (`createTime`)
		) ENGINE=InnoDB;
		
		call idata();

		mysql> call idata();
		Query OK, 1 row affected (7 min 19.12 sec)

		mysql> select count(*) from t_20200728;
		+----------+
		| count(*) |
		+----------+
		|   100000 |
		+----------+
		1 row in set (0.02 sec)


	唯一索引
		drop table t_20200728;
		CREATE TABLE `t_20200728` (
		  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
		  `name` varchar(32) NOT NULL DEFAULT '',
		  `age` int(11) NOT NULL DEFAULT '0',
		  `ismale` tinyint(1) NOT NULL DEFAULT '0',
		  `createTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  PRIMARY KEY (`id`),
		  UNIQUE KEY `idx_age` (`age`),
		  KEY `idx_name` (`name`),
		  KEY `idx_createTime` (`createTime`)
		) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;
		
		mysql> call idata();
		Query OK, 1 row affected (7 min 22.05 sec)

		mysql>  select count(*) from t_20200728;
		+----------+
		| count(*) |
		+----------+
		|   100000 |
		+----------+
		1 row in set (0.01 sec)


--------------------------------------------------------------------------------------------------------------------------------------

3. 第二次测试
	drop procedure idata;
	delimiter ;;
	create procedure idata()
	begin
	  declare i int;
	  set i=1;
	  while(i<=100000)do
		insert into t_20200728(name, age, ismale, id_card, test1, test2) values(substring(md5(rand()),1,10), i, FLOOR(1 + (RAND() * 100)), substring(md5(rand()),1,30), concat(substring(md5(rand()),1,100), substring(md5(rand()),1,100), '这里是做普通索引和唯一索引的插入性能对比测试'), concat(substring(md5(rand()),1,100), substring(md5(rand()),1,100), '这里是做普通索引和唯一索引的插入性能对比测试'));
		set i=i+1;
	  end while;

	end;;
	delimiter ;

	普通索引
	drop table t_20200728;
	CREATE TABLE `t_20200728` (
	  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',  
	  `name` varchar(32) not NULL default '',
	  `age` int(11) not NULL default 0,
	  `ismale` tinyint(1) not null default 0,
	  `id_card` varchar(32) not NULL default '',
	  `test1` text COMMENT '',
	  `test2` text COMMENT '',
	  `createTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
	  PRIMARY KEY (`id`),
	  KEY `idx_age` (`age`),
	  KEY `idx_name` (`name`),
	  KEY `idx_card` (`id_card`),
	  KEY `idx_createTime` (`createTime`)
	) ENGINE=InnoDB;


	mysql> call idata();
	Query OK, 1 row affected (7 min 20.12 sec)


	唯一索引
	drop table t_20200728;
	CREATE TABLE `t_20200728` (
	  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',  
	  `name` varchar(32) not NULL default '',
	  `age` int(11) not NULL default 0,
	  `ismale` tinyint(1) not null default 0,
	  `id_card` varchar(32) not NULL default '',
	  `test1` text COMMENT '',
	  `test2` text COMMENT '',
	  `createTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
	  PRIMARY KEY (`id`),
	  UNIQUE KEY `idx_age` (`age`),
	  KEY `idx_name` (`name`),
	  KEY `idx_card` (`id_card`),
	  KEY `idx_createTime` (`createTime`)
	) ENGINE=InnoDB;


	mysql> call idata();
	Query OK, 1 row affected (7 min 21.36 sec)

		
4. 小结
	
	普通索引和唯一索引在插入速度上几乎没区别。
	
	

-------------------
root@mysqldb 16:49:  [(none)]> select concat(substring(md5(rand()),1,100), substring(md5(rand()),1,100), '这里是做普通索引和唯一索引的插入性能对比测试');
+------------------------------------------------------------------------------------------------------------------------------------------+
| concat(substring(md5(rand()),1,100), substring(md5(rand()),1,100), '这里是做普通索引和唯一索引的插入性能对比测试') |
+------------------------------------------------------------------------------------------------------------------------------------------+
| 0262f399a384c545da3d73ba640a500cc6a092adfc0c0359f63c12c03a50dc55这里是做普通索引和唯一索引的插入性能对比测试       |
+------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.01 sec)
