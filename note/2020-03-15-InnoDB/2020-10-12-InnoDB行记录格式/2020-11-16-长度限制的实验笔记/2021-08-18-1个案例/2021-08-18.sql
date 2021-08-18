
SET GLOBAL innodb_file_format=Antelope;


drop table table_20210818 if exists;
CREATE TABLE `table_20210818` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
  `a` blob COMMENT '...',
  `b` blob COMMENT '...',
  `c` blob COMMENT '...',
  `d` blob COMMENT '...',
  `a1` varchar(20) DEFAULT NULL COMMENT '...',
  `szToken` varchar(256) NOT NULL DEFAULT '' COMMENT '...',
  `a3` varchar(20) NOT NULL DEFAULT '' COMMENT '...',
  `a4` varchar(20) NOT NULL DEFAULT '' COMMENT '...',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;


select ROW_FORMAT from information_schema.tables where TABLE_SCHEMA='niuniuh5_db' and  TABLE_NAME='table_20210818';
 
mysql> select ROW_FORMAT from information_schema.tables where TABLE_SCHEMA='niuniuh5_db' and  TABLE_NAME='table_20210818';
+------------+
| ROW_FORMAT |
+------------+
| Compact    |
+------------+
1 row in set (0.00 sec)
 
------------------------------------------------------------------------------------------------------------------------------------

drop table table_01 if exists;
CREATE TABLE `table_01` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
  `a` blob COMMENT '...',
  `b` blob COMMENT '...',
  `c` blob COMMENT '...',
  `d` blob COMMENT '...',
  `a1` varchar(20) DEFAULT NULL COMMENT '...',
  `szToken` varchar(256) NOT NULL DEFAULT '' COMMENT '...',
  `a3` varchar(20) NOT NULL DEFAULT '' COMMENT '...',
  `a4` varchar(20) NOT NULL DEFAULT '' COMMENT '...',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

INSERT INTO `table_01` 
(`a`, `b`, `c`, `d`, `a1`, `szToken`, `a3`, `a4`) 
VALUES (
'{\"LogCount\":25,\"jsonlog\":[{\"1\":\"看三张新手房,底分 1\"},{\"2\":\"玩家账户:73821 座位号:1\"},{\"3\":\"玩家账户:62818 座位号:2\"},{\"4\":\"玩家账户:62371 座位号:3\"},{\"5\":\"1 号位,携带金额 1099999000.0\"},{\"6\":\"2 号位,携带金额 9634712008\"},{\"7\":\"3 号位,携带金额 326666190\"},{\"8\":\"发3张牌\"},{\"9\":\"抢庄\"},{\"10\":\"1 号位,开局第3秒,抢2倍\"},{\"11\":\"3 号位,开局第5秒,抢0倍\"},{\"12\":\"2 号位,开局第5秒,抢3倍\"},{\"13\":\"2 号位,开局第5秒,抢庄成功\"},{\"14\":\"下注\"},{\"15\":\"1 号位,开局第7秒,下11倍\"},{\"16\":\"3 号位,开局第8秒,下1倍\"},{\"17\":\"补牌\"},{\"18\":\"开牌\"},{\"19\":\"1 号位,开局第10秒,开牌\"},{\"20\":\"2 号位,开局第11秒,开牌\"},{\"21\":\"3 号位,开局第12秒,开牌\"},{\"22\":\"结算\"},{\"23\":\"1 号位,闲,本局输赢分数-66000,牌值♥1♠J♣J♥9♣5,牛五*1\"},{\"24\":\"2 号位,庄,本局输赢分数68400,牌值♠7♦6♥8♣7♦K,牛八*2\"},{\"25\":\"3 号位,闲,本局输赢分数-6000,牌值♣6♦1♣10♣2♠5,无牛*1\"}],\"jsondata\":[\"playerid=73821 chairid=1\",\"playerid=62818 chairid=2\",\"playerid=62371 chairid=3\",\" chairid=1 money=1099999000.0\",\" chairid=2 money=9634712008\",\" chairid=3 money=326666190\",\" chairid=1 time=3,BeiShu=2\",\" chairid=3 time=5,BeiShu=0\",\" chairid=2 time=5,BeiShu=3\",\" chairid=2 time=5,qiangzhang success\",\" chairid=1 time=7,PushBet=11\",\" chairid=3 time=8,PushBet=1\",\" chairid=1 time=10,OpenCard\",\" chairid=2 time=11,OpenCard\",\" chairid=3 time=12,OpenCard\",\" chairid=1 bankerUser=2,roundScore-66000,chCardData=[49,75,43,57,37],NNum=5\",\" chairid=2 bankerUser=2,roundScore68400,chCardData=[71,22,56,39,29],NNum=8\",\" chairid=3 bankerUser=2,roundScore-6000,chCardData=[38,17,42,34,69],NNum=0\"]}',
'{\"LogCount\":25,\"jsonlog\":[{\"1\":\"看三张新手房,底分 1\"},{\"2\":\"玩家账户:73821 座位号:1\"},{\"3\":\"玩家账户:62818 座位号:2\"},{\"4\":\"玩家账户:62371 座位号:3\"},{\"5\":\"1 号位,携带金额 1099999000.0\"},{\"6\":\"2 号位,携带金额 9634712008\"},{\"7\":\"3 号位,携带金额 326666190\"},{\"8\":\"发3张牌\"},{\"9\":\"抢庄\"},{\"10\":\"1 号位,开局第3秒,抢2倍\"},{\"11\":\"3 号位,开局第5秒,抢0倍\"},{\"12\":\"2 号位,开局第5秒,抢3倍\"},{\"13\":\"2 号位,开局第5秒,抢庄成功\"},{\"14\":\"下注\"},{\"15\":\"1 号位,开局第7秒,下11倍\"},{\"16\":\"3 号位,开局第8秒,下1倍\"},{\"17\":\"补牌\"},{\"18\":\"开牌\"},{\"19\":\"1 号位,开局第10秒,开牌\"},{\"20\":\"2 号位,开局第11秒,开牌\"},{\"21\":\"3 号位,开局第12秒,开牌\"},{\"22\":\"结算\"},{\"23\":\"1 号位,闲,本局输赢分数-66000,牌值♥1♠J♣J♥9♣5,牛五*1\"},{\"24\":\"2 号位,庄,本局输赢分数68400,牌值♠7♦6♥8♣7♦K,牛八*2\"},{\"25\":\"3 号位,闲,本局输赢分数-6000,牌值♣6♦1♣10♣2♠5,无牛*1\"}],\"jsondata\":[\"playerid=73821 chairid=1\",\"playerid=62818 chairid=2\",\"playerid=62371 chairid=3\",\" chairid=1 money=1099999000.0\",\" chairid=2 money=9634712008\",\" chairid=3 money=326666190\",\" chairid=1 time=3,BeiShu=2\",\" chairid=3 time=5,BeiShu=0\",\" chairid=2 time=5,BeiShu=3\",\" chairid=2 time=5,qiangzhang success\",\" chairid=1 time=7,PushBet=11\",\" chairid=3 time=8,PushBet=1\",\" chairid=1 time=10,OpenCard\",\" chairid=2 time=11,OpenCard\",\" chairid=3 time=12,OpenCard\",\" chairid=1 bankerUser=2,roundScore-66000,chCardData=[49,75,43,57,37],NNum=5\",\" chairid=2 bankerUser=2,roundScore68400,chCardData=[71,22,56,39,29],NNum=8\",\" chairid=3 bankerUser=2,roundScore-6000,chCardData=[38,17,42,34,69],NNum=0\"]}',
'{\"LogCount\":25,\"jsonlog\":[{\"1\":\"看三张新手房,底分 1\"},{\"2\":\"玩家账户:73821 座位号:1\"},{\"3\":\"玩家账户:62818 座位号:2\"},{\"4\":\"玩家账户:62371 座位号:3\"},{\"5\":\"1 号位,携带金额 1099999000.0\"},{\"6\":\"2 号位,携带金额 9634712008\"},{\"7\":\"3 号位,携带金额 326666190\"},{\"8\":\"发3张牌\"},{\"9\":\"抢庄\"},{\"10\":\"1 号位,开局第3秒,抢2倍\"},{\"11\":\"3 号位,开局第5秒,抢0倍\"},{\"12\":\"2 号位,开局第5秒,抢3倍\"},{\"13\":\"2 号位,开局第5秒,抢庄成功\"},{\"14\":\"下注\"},{\"15\":\"1 号位,开局第7秒,下11倍\"},{\"16\":\"3 号位,开局第8秒,下1倍\"},{\"17\":\"补牌\"},{\"18\":\"开牌\"},{\"19\":\"1 号位,开局第10秒,开牌\"},{\"20\":\"2 号位,开局第11秒,开牌\"},{\"21\":\"3 号位,开局第12秒,开牌\"},{\"22\":\"结算\"},{\"23\":\"1 号位,闲,本局输赢分数-66000,牌值♥1♠J♣J♥9♣5,牛五*1\"},{\"24\":\"2 号位,庄,本局输赢分数68400,牌值♠7♦6♥8♣7♦K,牛八*2\"},{\"25\":\"3 号位,闲,本局输赢分数-6000,牌值♣6♦1♣10♣2♠5,无牛*1\"}],\"jsondata\":[\"playerid=73821 chairid=1\",\"playerid=62818 chairid=2\",\"playerid=62371 chairid=3\",\" chairid=1 money=1099999000.0\",\" chairid=2 money=9634712008\",\" chairid=3 money=326666190\",\" chairid=1 time=3,BeiShu=2\",\" chairid=3 time=5,BeiShu=0\",\" chairid=2 time=5,BeiShu=3\",\" chairid=2 time=5,qiangzhang success\",\" chairid=1 time=7,PushBet=11\",\" chairid=3 time=8,PushBet=1\",\" chairid=1 time=10,OpenCard\",\" chairid=2 time=11,OpenCard\",\" chairid=3 time=12,OpenCard\",\" chairid=1 bankerUser=2,roundScore-66000,chCardData=[49,75,43,57,37],NNum=5\",\" chairid=2 bankerUser=2,roundScore68400,chCardData=[71,22,56,39,29],NNum=8\",\" chairid=3 bankerUser=2,roundScore-6000,chCardData=[38,17,42,34,69],NNum=0\"]}',
'{\"LogCount\":25,\"jsonlog\":[{\"1\":\"看三张新手房,底分 1\"},{\"2\":\"玩家账户:73821 座位号:1\"},{\"3\":\"玩家账户:62818 座位号:2\"},{\"4\":\"玩家账户:62371 座位号:3\"},{\"5\":\"1 号位,携带金额 1099999000.0\"},{\"6\":\"2 号位,携带金额 9634712008\"},{\"7\":\"3 号位,携带金额 326666190\"},{\"8\":\"发3张牌\"},{\"9\":\"抢庄\"},{\"10\":\"1 号位,开局第3秒,抢2倍\"},{\"11\":\"3 号位,开局第5秒,抢0倍\"},{\"12\":\"2 号位,开局第5秒,抢3倍\"},{\"13\":\"2 号位,开局第5秒,抢庄成功\"},{\"14\":\"下注\"},{\"15\":\"1 号位,开局第7秒,下11倍\"},{\"16\":\"3 号位,开局第8秒,下1倍\"},{\"17\":\"补牌\"},{\"18\":\"开牌\"},{\"19\":\"1 号位,开局第10秒,开牌\"},{\"20\":\"2 号位,开局第11秒,开牌\"},{\"21\":\"3 号位,开局第12秒,开牌\"},{\"22\":\"结算\"},{\"23\":\"1 号位,闲,本局输赢分数-66000,牌值♥1♠J♣J♥9♣5,牛五*1\"},{\"24\":\"2 号位,庄,本局输赢分数68400,牌值♠7♦6♥8♣7♦K,牛八*2\"},{\"25\":\"3 号位,闲,本局输赢分数-6000,牌值♣6♦1♣10♣2♠5,无牛*1\"}],\"jsondata\":[\"playerid=73821 chairid=1\",\"playerid=62818 chairid=2\",\"playerid=62371 chairid=3\",\" chairid=1 money=1099999000.0\",\" chairid=2 money=9634712008\",\" chairid=3 money=326666190\",\" chairid=1 time=3,BeiShu=2\",\" chairid=3 time=5,BeiShu=0\",\" chairid=2 time=5,BeiShu=3\",\" chairid=2 time=5,qiangzhang success\",\" chairid=1 time=7,PushBet=11\",\" chairid=3 time=8,PushBet=1\",\" chairid=1 time=10,OpenCard\",\" chairid=2 time=11,OpenCard\",\" chairid=3 time=12,OpenCard\",\" chairid=1 bankerUser=2,roundScore-66000,chCardData=[49,75,43,57,37],NNum=5\",\" chairid=2 bankerUser=2,roundScore68400,chCardData=[71,22,56,39,29],NNum=8\",\" chairid=3 bankerUser=2,roundScore-6000,chCardData=[38,17,42,34,69],NNum=0\"]}',
'a1',
'10001-748723-1553653368-1',
'a3',
'a4'
);
[root@localhost ~]# python innodb_page_info/py_innodb_page_info.py -v /home/mysql/mysql3306/data/niuniuh5_db/table_01.ibd 
page offset 00000000, page type <File Space Header>
page offset 00000001, page type <Insert Buffer Bitmap>
page offset 00000002, page type <File Segment inode>
page offset 00000003, page type <B-tree Node>, page level <0000>
page offset 00000000, page type <Freshly Allocated Page>
page offset 00000000, page type <Freshly Allocated Page>
Total number of page: 6:
Freshly Allocated Page: 2
Insert Buffer Bitmap: 1
File Space Header: 1
B-tree Node: 1
File Segment inode: 1

	
mysql> select length(a) from table_01;
+-----------+
| length(a) |
+-----------+
|      1710 |
+-----------+
1 row in set (0.00 sec)


------------------------------------------------------------------------------------------------------------------------

drop table table_02 if exists;
CREATE TABLE `table_02` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
  `a` blob COMMENT '...',
  `b` blob COMMENT '...',
  `c` blob COMMENT '...',
  `d` blob COMMENT '...',
  `a1` varchar(20) DEFAULT NULL COMMENT '...',
  `szToken` varchar(256) NOT NULL DEFAULT '' COMMENT '...',
  `a3` varchar(20) NOT NULL DEFAULT '' COMMENT '...',
  `a4` varchar(20) NOT NULL DEFAULT '' COMMENT '...',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

truncate table table_02;
INSERT INTO `table_02` 
(`a`, `b`, `c`, `d`, `a1`, `szToken`, `a3`, `a4`) 
VALUES (
REPEAT('a',7000),
null,
null,
null,
'a1',
'10001-748723-1553653368-1',
'a3',
'a4'
);

[root@localhost ~]# python innodb_page_info/py_innodb_page_info.py -v /home/mysql/mysql3306/data/niuniuh5_db/table_02.ibd 
page offset 00000000, page type <File Space Header>
page offset 00000001, page type <Insert Buffer Bitmap>
page offset 00000002, page type <File Segment inode>
page offset 00000003, page type <B-tree Node>, page level <0000>
page offset 00000000, page type <Freshly Allocated Page>
page offset 00000000, page type <Freshly Allocated Page>
Total number of page: 6:
Freshly Allocated Page: 2
Insert Buffer Bitmap: 1
File Space Header: 1
B-tree Node: 1
File Segment inode: 1



------------------------------------------------------------------------------------------------------------------------
drop table table_03 if exists;
CREATE TABLE `table_03` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
  `a` blob COMMENT '...',
  `b` blob COMMENT '...',
  `c` blob COMMENT '...',
  `d` blob COMMENT '...',
  `a1` varchar(20) DEFAULT NULL COMMENT '...',
  `szToken` varchar(256) NOT NULL DEFAULT '' COMMENT '...',
  `a3` varchar(20) NOT NULL DEFAULT '' COMMENT '...',
  `a4` varchar(20) NOT NULL DEFAULT '' COMMENT '...',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

truncate table table_03;
INSERT INTO `table_03` 
(`a`, `b`, `c`, `d`, `a1`, `szToken`, `a3`, `a4`) 
VALUES (
REPEAT('a',7000),
REPEAT('a',7000),
null,
null,
'a1',
'10001-748723-1553653368-1',
'a3',
'a4'
);

[root@localhost ~]# python innodb_page_info/py_innodb_page_info.py -v /home/mysql/mysql3306/data/niuniuh5_db/table_03.ibd 
page offset 00000000, page type <File Space Header>
page offset 00000001, page type <Insert Buffer Bitmap>
page offset 00000002, page type <File Segment inode>
page offset 00000003, page type <B-tree Node>, page level <0000>
page offset 00000004, page type <Uncompressed BLOB Page>
page offset 00000000, page type <Freshly Allocated Page>
Total number of page: 6:
Insert Buffer Bitmap: 1
Freshly Allocated Page: 1
File Segment inode: 1
B-tree Node: 1
File Space Header: 1
Uncompressed BLOB Page: 1


------------------------------------------------------------------------------------------------------------------------

drop table table_04 if exists;
CREATE TABLE `table_04` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
  `a` blob COMMENT '...',
  `b` blob COMMENT '...',
  `c` blob COMMENT '...',
  `d` blob COMMENT '...',
  `a1` varchar(20) DEFAULT NULL COMMENT '...',
  `szToken` varchar(256) NOT NULL DEFAULT '' COMMENT '...',
  `a3` varchar(20) NOT NULL DEFAULT '' COMMENT '...',
  `a4` varchar(20) NOT NULL DEFAULT '' COMMENT '...',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

INSERT INTO `table_04` 
(`a`, `b`, `c`, `d`, `a1`, `szToken`, `a3`, `a4`) 
VALUES (
REPEAT('a',3000),
REPEAT('a',3000),
REPEAT('a',1000),
REPEAT('a',2000),
'a1',
'10001-748723-1553653368-1',
'a3',
'a4'
);

[root@localhost ~]# python innodb_page_info/py_innodb_page_info.py -v /home/mysql/mysql3306/data/niuniuh5_db/table_04.ibd 
page offset 00000000, page type <File Space Header>
page offset 00000001, page type <Insert Buffer Bitmap>
page offset 00000002, page type <File Segment inode>
page offset 00000003, page type <B-tree Node>, page level <0000>
page offset 00000004, page type <Uncompressed BLOB Page>
page offset 00000000, page type <Freshly Allocated Page>
Total number of page: 6:
Insert Buffer Bitmap: 1
Freshly Allocated Page: 1
File Segment inode: 1
B-tree Node: 1
File Space Header: 1
Uncompressed BLOB Page: 1


------------------------------------------------------------------------------------------------------------------------

drop table table_05 if exists;
CREATE TABLE `table_05` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
  `a` blob COMMENT '...',
  `b` blob COMMENT '...',
  `c` blob COMMENT '...',
  `d` blob COMMENT '...',
  `a1` blob COMMENT '...',
  `a2` blob COMMENT '...',
  `a3` blob COMMENT '...',
  `a4` blob COMMENT '...',
  `a5` blob COMMENT '...',
  `a6` blob COMMENT '...',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

INSERT INTO `table_05` 
(`a`, `b`, `c`, `d`, `a1`, `a2`, `a3`, `a4`, `a5`, `a6`) 
VALUES (
REPEAT('a',3000),
REPEAT('a',3000),
REPEAT('a',1000),
REPEAT('a',2000),
REPEAT('a',2000),
REPEAT('a',2000),
REPEAT('a',2000),
REPEAT('a',2000),
REPEAT('a',2000),
REPEAT('a',2000)
);


[root@localhost ~]# python innodb_page_info/py_innodb_page_info.py -v /home/mysql/mysql3306/data/niuniuh5_db/table_05.ibd 
page offset 00000000, page type <File Space Header>
page offset 00000001, page type <Insert Buffer Bitmap>
page offset 00000002, page type <File Segment inode>
page offset 00000003, page type <B-tree Node>, page level <0000>
page offset 00000004, page type <Uncompressed BLOB Page>
page offset 00000005, page type <Uncompressed BLOB Page>
page offset 00000006, page type <Uncompressed BLOB Page>
page offset 00000007, page type <Uncompressed BLOB Page>
page offset 00000008, page type <Uncompressed BLOB Page>
page offset 00000009, page type <Uncompressed BLOB Page>
page offset 0000000a, page type <Uncompressed BLOB Page>
page offset 0000000b, page type <Uncompressed BLOB Page>
page offset 0000000c, page type <Uncompressed BLOB Page>
page offset 0000000d, page type <Uncompressed BLOB Page>
Total number of page: 14:
Insert Buffer Bitmap: 1
Uncompressed BLOB Page: 10
File Space Header: 1
B-tree Node: 1
File Segment inode: 1



------------------------------------------------------------------------------------------------------------------------

drop table table_06 if exists;
CREATE TABLE `table_06` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
  `a` blob COMMENT '...',
  `b` blob COMMENT '...',
  `c` blob COMMENT '...',
  `d` blob COMMENT '...',
  `a1` blob COMMENT '...',
  `a2` blob COMMENT '...',
  `a3` blob COMMENT '...',
  `a4` blob COMMENT '...',
  `a5` blob COMMENT '...',
  `a6` blob COMMENT '...',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

INSERT INTO `table_06` 
(`a`, `b`, `c`, `d`, `a1`, `a2`, `a3`, `a4`, `a5`, `a6`) 
VALUES (
REPEAT('a',3000),
REPEAT('a',3000),
REPEAT('a',3000),
REPEAT('a',3000),
REPEAT('a',3000),
REPEAT('a',3000),
REPEAT('a',3000),
REPEAT('a',3000),
REPEAT('a',3000),
REPEAT('a',3000)
);


[root@localhost ~]# python innodb_page_info/py_innodb_page_info.py -v /home/mysql/mysql3306/data/niuniuh5_db/table_06.ibd 
page offset 00000000, page type <File Space Header>
page offset 00000001, page type <Insert Buffer Bitmap>
page offset 00000002, page type <File Segment inode>
page offset 00000003, page type <B-tree Node>, page level <0000>
page offset 00000004, page type <Uncompressed BLOB Page>
page offset 00000005, page type <Uncompressed BLOB Page>
page offset 00000006, page type <Uncompressed BLOB Page>
page offset 00000007, page type <Uncompressed BLOB Page>
page offset 00000008, page type <Uncompressed BLOB Page>
page offset 00000009, page type <Uncompressed BLOB Page>
page offset 0000000a, page type <Uncompressed BLOB Page>
page offset 0000000b, page type <Uncompressed BLOB Page>
page offset 0000000c, page type <Uncompressed BLOB Page>
page offset 0000000d, page type <Uncompressed BLOB Page>
Total number of page: 14:
Insert Buffer Bitmap: 1
Uncompressed BLOB Page: 10
File Space Header: 1
B-tree Node: 1
File Segment inode: 1



------------------------------------------------------------------------------------------------------------------------

drop table table_07 if exists;
CREATE TABLE `table_07` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
  `a` blob COMMENT '...',
  `b` blob COMMENT '...',
  `c` blob COMMENT '...',
  `d` blob COMMENT '...',
  `a1` blob COMMENT '...',
  `a2` blob COMMENT '...',
  `a3` blob COMMENT '...',
  `a4` blob COMMENT '...',
  `a5` blob COMMENT '...',
  `a6` blob COMMENT '...',
  `a7` blob COMMENT '...',
  `a8` blob COMMENT '...',
  `a9` blob COMMENT '...',
  `a10` blob COMMENT '...',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

INSERT INTO `table_07` 
(`a`, `b`, `c`, `d`, `a1`, `a2`, `a3`, `a4`, `a5`, `a6`, `a7`, `a8`, `a9`, `a10`) 
VALUES (
REPEAT('a',3000),
REPEAT('a',3000),
REPEAT('a',3000),
REPEAT('a',3000),
REPEAT('a',3000),
REPEAT('a',3000),
REPEAT('a',3000),
REPEAT('a',3000),
REPEAT('a',3000),
REPEAT('a',3000),
REPEAT('a',3000),
REPEAT('a',3000),
REPEAT('a',3000),
REPEAT('a',3000)
);

ERROR 1118 (42000): Row size too large (> 8126). Changing some columns to TEXT or BLOB or using ROW_FORMAT=DYNAMIC or ROW_FORMAT=COMPRESSED may help. 
	In current row format, BLOB prefix of 768 bytes is stored inline.


------------------------------------------------------------------------------------------------------------------------


drop table table_08 if exists;
CREATE TABLE `table_08` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
  `a` blob COMMENT '...',
  `b` blob COMMENT '...',
  `c` blob COMMENT '...',
  `d` blob COMMENT '...',
  `a1` blob COMMENT '...',
  `a2` blob COMMENT '...',
  `a3` blob COMMENT '...',
  `a4` blob COMMENT '...',
  `a5` blob COMMENT '...',
  `a6` blob COMMENT '...',
  `a7` blob COMMENT '...',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;


INSERT INTO `table_08` 
(`a`, `b`, `c`, `d`, `a1`, `a2`, `a3`, `a4`, `a5`, `a6`, `a7`) 
VALUES (
REPEAT('a',3000),
REPEAT('a',3000),
REPEAT('a',3000),
REPEAT('a',3000),
REPEAT('a',3000),
REPEAT('a',3000),
REPEAT('a',3000),
REPEAT('a',3000),
REPEAT('a',3000),
REPEAT('a',3000),
REPEAT('a',3000)
);

ERROR 1118 (42000): Row size too large (> 8126). Changing some columns to TEXT or BLOB or using ROW_FORMAT=DYNAMIC or ROW_FORMAT=COMPRESSED may help. 
	In current row format, BLOB prefix of 768 bytes is stored inline.


------------------------------------------------------------------------------------------------------------------------



