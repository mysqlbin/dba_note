

CREATE TABLE `t1` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `age` int(10) DEFAULT NULL,
  `tEndTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `idx_age` (`age`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;



修改字段名称和默认值

	[root@localhost yldbs]# date
	2021年 03月 30日 星期二 17:30:42 CST
	[root@localhost yldbs]# ll

	-rw-r----- 1 mysql mysql     8630 3月  30 17:28 t1.frm
	-rw-r----- 1 mysql mysql   114688 3月  30 17:28 t1.ibd



	alter table t1 change  age ages int(11) not null default 1 comment 'ages';

	[root@localhost yldbs]# ll
	总用量 10632
	-rw-r----- 1 mysql mysql     8636 3月  30 17:32 t1.frm
	-rw-r----- 1 mysql mysql   114688 3月  30 17:32 t1.ibd
	
	-- 会重建表
	
	
修改字段名称不指定默认值	


	[root@localhost yldbs]# date
	2021年 03月 30日 星期二 17:34:24 CST
	
	
	alter table t1 change ages age int(11);
	
	CREATE TABLE `t1` (
	  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
	  `age` int(11) DEFAULT NULL,
	  `tEndTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  PRIMARY KEY (`ID`),
	  KEY `idx_age` (`age`)
	) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

	[root@localhost yldbs]# ll
	总用量 10632
	-rw-r----- 1 mysql mysql     8630 3月  30 17:34 t1.frm
	-rw-r----- 1 mysql mysql   114688 3月  30 17:34 t1.ibd

	-- 会重建表，因为默认值被修改了， not null default 1 被改为了 DEFAULT NULL

修改字段名称	
	
	alter table t1 change age ages int(11);
	
	CREATE TABLE `t1` (
	  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
	  `age` int(11) DEFAULT NULL,
	  `tEndTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  PRIMARY KEY (`ID`),
	  KEY `idx_age` (`age`)
	) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;



	[root@localhost yldbs]# date
	2021年 03月 30日 星期二 17:36:06 CST
	[root@localhost yldbs]# ll
	总用量 10632
	-rw-r----- 1 mysql mysql       67 10月 28 18:31 db.opt
	-rw-r----- 1 mysql mysql     8888 3月  23 09:47 rechargestatistics.frm
	-rw-r----- 1 mysql mysql    98304 3月  23 09:47 rechargestatistics.ibd
	-rw-r----- 1 mysql mysql     8632 3月  30 17:36 t1.frm
	-rw-r----- 1 mysql mysql   114688 3月  30 17:34 t1.ibd
	
	
	CREATE TABLE `t1` (
	  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
	  `ages` int(11) DEFAULT NULL,
	  `tEndTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  PRIMARY KEY (`ID`),
	  KEY `idx_age` (`ages`)
	) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

	-- 只修改字段名称，不修改字段默认值，不会重建表。
	
	
	
	
