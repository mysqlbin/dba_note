
CREATE TABLE `t1_1yi` (
  `id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP PROCEDURE IF EXISTS insertbatch_1yi;
CREATE PROCEDURE insertbatch_1yi()
BEGIN
DECLARE i INT;
  SET i=50000001;
	start transaction;
  WHILE(i<=70000000) DO
    INSERT INTO zst.t1_1yi(id)VALUES(i);
    SET i=i+1; 
  END WHILE;
	commit;
END;


CREATE TABLE `t1_10yi` (
  `id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP PROCEDURE IF EXISTS insertbatch_10yi;
CREATE PROCEDURE insertbatch_10yi()
BEGIN
DECLARE i INT;
  SET i=1;
	start transaction;
  WHILE(i<=1000000000) DO
    INSERT INTO zst.t1_10yi(id)VALUES(i);
    SET i=i+1; 
  END WHILE;
	commit;
END;



CREATE TABLE `t1_20yi` (
  `id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP PROCEDURE IF EXISTS insertbatch_20yi;
CREATE PROCEDURE insertbatch_20yi()
BEGIN
DECLARE i INT;
  SET i=1;
	start transaction;
  WHILE(i<=2000000000) DO
    INSERT INTO zst.t1_20yi(id)VALUES(i);
    SET i=i+1; 
  END WHILE;
	commit;
END;


call insertbatch_1yi();
call insertbatch_10yi();


1. 通过 space-indexes查看索引的统计信息：

[root@env data]# innodb_space -s ibdata1 -T zst/t1_1yi space-indexes
id          name                            root        fseg        used        allocated   fill_factor 
155         PRIMARY                         3           internal    125         160         78.12%      
155         PRIMARY                         3           leaf        147930      147936      100.00% 


select 125*16=2000KB=0.002GB; 
select 147930*16=2366880KB=2.26GB; 
select 160*16=2560KB=0.002GB;
select 147936*16=2366976KB=2.26GB;


[root@env zst]# ls -lht t1_1yi.ibd
-rw-r----- 1 mysql mysql 2.4G Jul 27 22:23 t1_1yi.ibd



统计主键索引的page信息:
# level=0的page太多，所以只统计行数：
[root@env data]# innodb_space -s ibdata1 -T zst/t1_1yi -I PRIMARY -l 0  index-level-summary | wc -l
147931



