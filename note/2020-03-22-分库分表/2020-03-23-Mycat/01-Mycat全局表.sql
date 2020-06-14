
Mycat 全依赖配置.



1. 配置schema.xml分片表，指定全局表type="global"
2. 创建表和插入数据
3. 分析查询
4. 全局表总结


1. 配置schema.xml分片表，指定全局表type="global"
	<table name="goods_class" primaryKey="ID" autoIncrement="true"  dataNode="dn$1-12" splitTableNames ="true"/>

	<dataNode name="dn1" dataHost="datahost_201" database="db1" />
	<dataNode name="dn2" dataHost="datahost_201" database="db2" />
	<dataNode name="dn3" dataHost="datahost_201" database="db3" />
	<dataNode name="dn4" dataHost="datahost_201" database="db4" />
	
	<dataNode name="dn5" dataHost="datahost_202" database="db1" />
	<dataNode name="dn6" dataHost="datahost_202" database="db2" />
	<dataNode name="dn7" dataHost="datahost_202" database="db3" />
	<dataNode name="dn8" dataHost="datahost_202" database="db4" />
	
	<dataNode name="dn9"  dataHost="datahost_203" database="db1" />
	<dataNode name="dn10" dataHost="datahost_203" database="db2" />
	<dataNode name="dn11" dataHost="datahost_203" database="db3" />
	<dataNode name="dn12" dataHost="datahost_203" database="db4" />
	
	

2. 创建表和插入数据
	CREATE TABLE `goods_class` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`img` VARCHAR(250) NOT NULL DEFAULT '' COMMENT '图片',
	`name` VARCHAR(250) NOT NULL DEFAULT '' COMMENT '分类名称',
	`is_recommend` CHAR(1) NOT NULL DEFAULT '0' COMMENT '0:不推荐 1:推荐(推荐时修改utime时间)',
	`sort` INT(11) NOT NULL DEFAULT '1' COMMENT '排序字段',
	PRIMARY KEY (`id`)
	) ENGINE=INNODB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='商品分类表';

	
	INSERT INTO goods_class (id, img,NAME,is_recommend,sort)VALUES('next value for MYCATSEQ_GLOBALS', '1.jpg','衣服','1',10);
	INSERT INTO goods_class (id, img,NAME,is_recommend,sort)VALUES('next value for MYCATSEQ_GLOBALS', '2.jpg','化妆品','1',20);
	INSERT INTO goods_class (id, img,NAME,is_recommend,sort)VALUES('next value for MYCATSEQ_GLOBALS', '3.jpg','手机','1',30);
	INSERT INTO goods_class (id, img,NAME,is_recommend,sort)VALUES('next value for MYCATSEQ_GLOBALS', '4.jpg','电脑','1',40);
	INSERT INTO goods_class (id, img,NAME,is_recommend,sort)VALUES('next value for MYCATSEQ_GLOBALS', '5.jpg','玩具','1',50);


	select * from db1.goods_class;
	select * from db2.goods_class;
	select * from db3.goods_class;
	select * from db4.goods_class;

	root@mysqldb 02:41:  [(none)]> select * from db1.goods_class;
	+-----+-------+-----------+--------------+------+
	| ID  | IMG   | NAME      | IS_RECOMMEND | SORT |
	+-----+-------+-----------+--------------+------+
	| 601 | 1.jpg | 衣服      | 1            |   10 |
	| 602 | 2.jpg | 化妆品    | 1            |   20 |
	| 603 | 3.jpg | 手机      | 1            |   30 |
	| 604 | 4.jpg | 电脑      | 1            |   40 |
	| 605 | 5.jpg | 玩具      | 1            |   50 |
	+-----+-------+-----------+--------------+------+
	5 rows in set (0.00 sec)

	root@mysqldb 02:41:  [(none)]> select * from db2.goods_class;
	+-----+-------+-----------+--------------+------+
	| ID  | IMG   | NAME      | IS_RECOMMEND | SORT |
	+-----+-------+-----------+--------------+------+
	| 601 | 1.jpg | 衣服      | 1            |   10 |
	| 602 | 2.jpg | 化妆品    | 1            |   20 |
	| 603 | 3.jpg | 手机      | 1            |   30 |
	| 604 | 4.jpg | 电脑      | 1            |   40 |
	| 605 | 5.jpg | 玩具      | 1            |   50 |
	+-----+-------+-----------+--------------+------+
	5 rows in set (0.00 sec)

	root@mysqldb 02:41:  [(none)]> select * from db3.goods_class;
	+-----+-------+-----------+--------------+------+
	| ID  | IMG   | NAME      | IS_RECOMMEND | SORT |
	+-----+-------+-----------+--------------+------+
	| 601 | 1.jpg | 衣服      | 1            |   10 |
	| 602 | 2.jpg | 化妆品    | 1            |   20 |
	| 603 | 3.jpg | 手机      | 1            |   30 |
	| 604 | 4.jpg | 电脑      | 1            |   40 |
	| 605 | 5.jpg | 玩具      | 1            |   50 |
	+-----+-------+-----------+--------------+------+
	5 rows in set (0.00 sec)

	root@mysqldb 02:41:  [(none)]> select * from db4.goods_class;
	+-----+-------+-----------+--------------+------+
	| ID  | IMG   | NAME      | IS_RECOMMEND | SORT |
	+-----+-------+-----------+--------------+------+
	| 601 | 1.jpg | 衣服      | 1            |   10 |
	| 602 | 2.jpg | 化妆品    | 1            |   20 |
	| 603 | 3.jpg | 手机      | 1            |   30 |
	| 604 | 4.jpg | 电脑      | 1            |   40 |
	| 605 | 5.jpg | 玩具      | 1            |   50 |
	+-----+-------+-----------+--------------+------+
	5 rows in set (0.00 sec)


	mycat_user@mysqldb 03:10:  [mycat_db]> select * from goods_class;
	+-----+-------+-----------+--------------+------+
	| ID  | IMG   | NAME      | IS_RECOMMEND | SORT |
	+-----+-------+-----------+--------------+------+
	| 601 | 1.jpg | 衣服      | 1            |   10 |
	| 602 | 2.jpg | 化妆品    | 1            |   20 |
	| 603 | 3.jpg | 手机      | 1            |   30 |
	| 604 | 4.jpg | 电脑      | 1            |   40 |
	| 605 | 5.jpg | 玩具      | 1            |   50 |
	| 601 | 1.jpg | 衣服      | 1            |   10 |
	| 602 | 2.jpg | 化妆品    | 1            |   20 |
	| 603 | 3.jpg | 手机      | 1            |   30 |
	| 604 | 4.jpg | 电脑      | 1            |   40 |
	| 605 | 5.jpg | 玩具      | 1            |   50 |
	| 601 | 1.jpg | 衣服      | 1            |   10 |
	| 602 | 2.jpg | 化妆品    | 1            |   20 |
	| 603 | 3.jpg | 手机      | 1            |   30 |
	| 604 | 4.jpg | 电脑      | 1            |   40 |
	| 605 | 5.jpg | 玩具      | 1            |   50 |
	| 601 | 1.jpg | 衣服      | 1            |   10 |
	| 602 | 2.jpg | 化妆品    | 1            |   20 |
	| 603 | 3.jpg | 手机      | 1            |   30 |
	| 604 | 4.jpg | 电脑      | 1            |   40 |
	| 605 | 5.jpg | 玩具      | 1            |   50 |
	| 601 | 1.jpg | 衣服      | 1            |   10 |
	| 602 | 2.jpg | 化妆品    | 1            |   20 |
	| 603 | 3.jpg | 手机      | 1            |   30 |
	| 604 | 4.jpg | 电脑      | 1            |   40 |
	| 605 | 5.jpg | 玩具      | 1            |   50 |
	| 601 | 1.jpg | 衣服      | 1            |   10 |
	| 602 | 2.jpg | 化妆品    | 1            |   20 |
	| 603 | 3.jpg | 手机      | 1            |   30 |
	| 604 | 4.jpg | 电脑      | 1            |   40 |
	| 605 | 5.jpg | 玩具      | 1            |   50 |
	| 601 | 1.jpg | 衣服      | 1            |   10 |
	| 602 | 2.jpg | 化妆品    | 1            |   20 |
	| 603 | 3.jpg | 手机      | 1            |   30 |
	| 604 | 4.jpg | 电脑      | 1            |   40 |
	| 605 | 5.jpg | 玩具      | 1            |   50 |
	| 601 | 1.jpg | 衣服      | 1            |   10 |
	| 602 | 2.jpg | 化妆品    | 1            |   20 |
	| 603 | 3.jpg | 手机      | 1            |   30 |
	| 604 | 4.jpg | 电脑      | 1            |   40 |
	| 605 | 5.jpg | 玩具      | 1            |   50 |
	| 601 | 1.jpg | 衣服      | 1            |   10 |
	| 602 | 2.jpg | 化妆品    | 1            |   20 |
	| 603 | 3.jpg | 手机      | 1            |   30 |
	| 604 | 4.jpg | 电脑      | 1            |   40 |
	| 605 | 5.jpg | 玩具      | 1            |   50 |
	| 601 | 1.jpg | 衣服      | 1            |   10 |
	| 602 | 2.jpg | 化妆品    | 1            |   20 |
	| 603 | 3.jpg | 手机      | 1            |   30 |
	| 604 | 4.jpg | 电脑      | 1            |   40 |
	| 605 | 5.jpg | 玩具      | 1            |   50 |
	| 601 | 1.jpg | 衣服      | 1            |   10 |
	| 602 | 2.jpg | 化妆品    | 1            |   20 |
	| 603 | 3.jpg | 手机      | 1            |   30 |
	| 604 | 4.jpg | 电脑      | 1            |   40 |
	| 605 | 5.jpg | 玩具      | 1            |   50 |
	| 601 | 1.jpg | 衣服      | 1            |   10 |
	| 602 | 2.jpg | 化妆品    | 1            |   20 |
	| 603 | 3.jpg | 手机      | 1            |   30 |
	| 604 | 4.jpg | 电脑      | 1            |   40 |
	| 605 | 5.jpg | 玩具      | 1            |   50 |
	+-----+-------+-----------+--------------+------+
	60 rows in set (0.01 sec)

	为什么会显示出各个分片节点的数据, 原因: 没有 type="global"
	<table name="goods_class" primaryKey="ID" autoIncrement="true" type="global" dataNode="dn$1-12" splitTableNames ="true"/>

	
	mycat_user@mysqldb 19:18:  [mycat_db]> select * from goods_class;
	+-----+-------+-----------+--------------+------+
	| ID  | IMG   | NAME      | IS_RECOMMEND | SORT |
	+-----+-------+-----------+--------------+------+
	| 601 | 1.jpg | 衣服      | 1            |   10 |
	| 602 | 2.jpg | 化妆品    | 1            |   20 |
	| 603 | 3.jpg | 手机      | 1            |   30 |
	| 604 | 4.jpg | 电脑      | 1            |   40 |
	| 605 | 5.jpg | 玩具      | 1            |   50 |
	+-----+-------+-----------+--------------+------+
	5 rows in set (0.12 sec)
	
3. 分析查询
	mycat_user@mysqldb 20:47:  [mycat_db]> explain select * from goods_class;
	+-----------+-------------------------------------+
	| DATA_NODE | SQL                                 |
	+-----------+-------------------------------------+
	| dn1       | SELECT * FROM goods_class LIMIT 100 |
	+-----------+-------------------------------------+
	1 row in set (0.00 sec)

	mycat_user@mysqldb 20:47:  [mycat_db]> explain select * from goods_class;
	+-----------+-------------------------------------+
	| DATA_NODE | SQL                                 |
	+-----------+-------------------------------------+
	| dn5       | SELECT * FROM goods_class LIMIT 100 |
	+-----------+-------------------------------------+
	1 row in set (0.01 sec)

	mycat_user@mysqldb 20:47:  [mycat_db]> explain select * from goods_class;
	+-----------+-------------------------------------+
	| DATA_NODE | SQL                                 |
	+-----------+-------------------------------------+
	| dn1       | SELECT * FROM goods_class LIMIT 100 |
	+-----------+-------------------------------------+
	1 row in set (0.00 sec)

	mycat_user@mysqldb 20:47:  [mycat_db]> explain select * from goods_class;
	+-----------+-------------------------------------+
	| DATA_NODE | SQL                                 |
	+-----------+-------------------------------------+
	| dn2       | SELECT * FROM goods_class LIMIT 100 |
	+-----------+-------------------------------------+
	1 row in set (0.01 sec)

	mycat_user@mysqldb 20:47:  [mycat_db]> explain select * from goods_class;
	+-----------+-------------------------------------+
	| DATA_NODE | SQL                                 |
	+-----------+-------------------------------------+
	| dn8       | SELECT * FROM goods_class LIMIT 100 |
	+-----------+-------------------------------------+
	1 row in set (0.00 sec)

	mycat_user@mysqldb 20:47:  [mycat_db]> explain select * from goods_class;
	+-----------+-------------------------------------+
	| DATA_NODE | SQL                                 |
	+-----------+-------------------------------------+
	| dn1       | SELECT * FROM goods_class LIMIT 100 |
	+-----------+-------------------------------------+
	1 row in set (0.00 sec)

	mycat_user@mysqldb 20:47:  [mycat_db]> explain select * from goods_class;
	+-----------+-------------------------------------+
	| DATA_NODE | SQL                                 |
	+-----------+-------------------------------------+
	| dn7       | SELECT * FROM goods_class LIMIT 100 |
	+-----------+-------------------------------------+
	1 row in set (0.00 sec)

	mycat_user@mysqldb 20:47:  [mycat_db]> explain select * from goods_class;
	+-----------+-------------------------------------+
	| DATA_NODE | SQL                                 |
	+-----------+-------------------------------------+
	| dn6       | SELECT * FROM goods_class LIMIT 100 |
	+-----------+-------------------------------------+
	1 row in set (0.00 sec)

		
	可见，针对查询，MyCat会随机选择一个dataNode数据节点进行查询。

4. 全局表总结
	schema.xml：配置分片表的type = "global"，指定为全局表
	全局表查询会随机选择一个分片节点进行查询；
	全局表的插入、更新等操作都会将sql语句发送所有的分片节点上；
