


CREATE TABLE `t_20201023` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(32) NOT NULL DEFAULT '',
  `age` int(11) NOT NULL DEFAULT '0',
  `ismale` tinyint(1) NOT NULL DEFAULT '0',
  `id_card` varchar(32) NOT NULL DEFAULT '',
  `test1` text,
  `test2` text,
  `createTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`),
  KEY `idx_createTime` (`createTime`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;



	drop procedure if exists idata ;
	delimiter ;;
	create procedure idata()
	begin
	  declare i int;
	  set i=1;
	  start transaction;
		  while(i<=50000)do
			insert into t_20201023(name, age, ismale, id_card, test1, test2) values(substring(md5(rand()),1,10), i, FLOOR(1 + (RAND() * 100)), substring(md5(rand()),1,30), concat(substring(md5(rand()),1,100), substring(md5(rand()),1,100), '测试'), concat(substring(md5(rand()),1,100), substring(md5(rand()),1,100), '测试'));
			set i=i+1;
		  end while;
	  commit;
	end;;
	delimiter ;
	


CREATE TABLE `t_20201023` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(32) NOT NULL DEFAULT '',
  `age` int(11) NOT NULL DEFAULT '0',
  `ismale` tinyint(1) NOT NULL DEFAULT '0',
  `id_card` varchar(32) NOT NULL DEFAULT '',
  `test1` text,
  `test2` text,
  `createTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`),
  KEY `idx_createTime` (`createTime`)
) ENGINE=InnoDB AUTO_INCREMENT=2400001 DEFAULT CHARSET=utf8mb4;

root@mysqldb 16:05:  [test_db]> select count(*) from t_20201023;
+----------+
| count(*) |
+----------+
|  2400000 |
+----------+
1 row in set (0.33 sec)


事务的执行次序
session A                       session B
alter table t_20201023 add index idx_age(`age`);
								
								mysql> delete from t_20201023 where id=1;
								Query OK, 1 row affected (0.64 sec)
								-- 这里明显被阻塞了一下。
								
Query OK, 0 rows affected (7.32 sec)
Records: 0  Duplicates: 0  Warnings: 0
									
								mysql> delete from t_20201023 where id=2;
								Query OK, 1 row affected (0.00 sec)
								-- 语句没有被阻塞的执行速度。

innodb_space -s ibdata1 -T test_db/t_20201023 -I idx_age index-recurse > not_primary_recurse.log
[root@localhost data]# cat root_3.log 
Record 126: (id=1) → #424
Record 140: (id=38606) → #425
Record 154: (id=115886) → #428
Record 168: (id=193166) → #429
Record 182: (id=270446) → #432
Record 196: (id=347726) → #433
Record 210: (id=425006) → #440
Record 224: (id=502286) → #441
Record 238: (id=579566) → #442
Record 252: (id=656846) → #443
Record 266: (id=734126) → #444
Record 280: (id=811406) → #445
Record 294: (id=888686) → #446
Record 308: (id=965966) → #447
Record 322: (id=1043246) → #129
Record 336: (id=1120526) → #132
Record 350: (id=1197806) → #133
Record 364: (id=1275086) → #134
Record 378: (id=1352366) → #135
Record 392: (id=1429646) → #140
Record 406: (id=1506926) → #141
Record 420: (id=1584206) → #142
Record 434: (id=1661486) → #143
Record 448: (id=1738766) → #145
Record 462: (id=1816046) → #147
Record 476: (id=1893326) → #151
Record 490: (id=1970606) → #154
Record 504: (id=2047886) → #155
Record 518: (id=2125166) → #156
Record 532: (id=2202446) → #157
Record 546: (id=2279726) → #162
Record 560: (id=2357006) → #44416

小结：
	Online DDL建索引期间，如果要删除已经被建立到索引的记录，那么删除语句会被阻塞0.64秒左右。
	
	