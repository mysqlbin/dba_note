
1. ER表：基于E-R关系进行分片，子表的记录与其关联的父表的记录保存在同一个分片上，这样关联查询就不需要跨库进行查询。

2. 实现步骤
	下面介绍一下如何实现ER表，尽量避免跨库JOIN查询。
	
	

在 schema.xml 配置ER分片表、分片节点等

	<table name="order" dataNode="dn1, db5" rule="sharding-order-mod-long" >
			<childTable name="order_detail" primaryKey="detail_id" joinKey="order_id" parentKey="order_id" />
	</table>
	
	<dataNode name="dn1" dataHost="datahost_201" database="db1" />

	<dataNode name="dn5" dataHost="datahost_202" database="db1" />
	
	<dataHost name="datahost_202" maxCon="1000" minCon="10" balance="0" 
			  writeType="0" dbType="mysql" dbDriver="native" switchType="1"  slaveThreshold="100">   <!-- 底层MySQL登录方式-->
		<heartbeat>select user()</heartbeat>
		<!-- can have multi write hosts -->
		<writeHost host="mycat02" url="192.168.0.202:3306" user="root" password="123456abc">
		</writeHost>
		<!-- <writeHost host="hostM2" url="localhost:3316" user="root" password="123456"/> -->
	</dataHost>
	
	
配置规则rule.xml
	
	<tableRule name="sharding-order-mod-long">
		<rule>
				<columns>order_id</columns>
				<algorithm>mod-long</algorithm>
		</rule>
	</tableRule>

	<function name="mod-long" class="io.mycat.route.function.PartitionByMod">
		<!-- how many data nodes -->
		<property name="count">2</property>
	</function>
	 
	
创建表	
	192.168.0.201 和 192.168.0.202
	use db1;
	CREATE TABLE `order` (
	  `order_id` INT(20) NOT NULL COMMENT '订单ID',
	  `amount` FLOAT DEFAULT NULL COMMENT '金额',
	  PRIMARY KEY (`order_id`)
	) ENGINE=INNODB DEFAULT CHARSET=utf8;
	 
	CREATE TABLE `order_detail` (
	  `detail_id` INT(20) NOT NULL COMMENT '订单详情ID',
	  `order_id` INT(20) DEFAULT NULL COMMENT '订单ID',
	  `unit_price` FLOAT DEFAULT NULL COMMENT '单价',
	  PRIMARY KEY (`detail_id`)
	) ENGINE=INNODB DEFAULT CHARSET=utf8;
	 
	 
测试插入数据，验证子表是否跟随父表记录分片

	INSERT INTO `order`(`order_id`,`amount`)VALUES (1111,111.1);
	INSERT INTO `order`(`order_id`,`amount`)VALUES (2222,222);

	INSERT INTO `order_detail`(`detail_id`, `order_id`,`unit_price`)VALUES (1234,1111, 20);
	INSERT INTO `order_detail`(`detail_id`, `order_id`,`unit_price`)VALUES (5678,2222, 20);



	mycat_user@mysqldb 21:43:  [mycat_db]> select * from order;
	ERROR 1105 (HY000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'order
	LIMIT 100' at line 2
	# 表名不能用关键定

	mycat_user@mysqldb 21:43:  [mycat_db]> select * from `order`;
	+----------+--------+
	| order_id | amount |
	+----------+--------+
	|     2222 |    222 |
	|     1111 |  111.1 |
	+----------+--------+
	2 rows in set (0.00 sec)

	mycat_user@mysqldb 21:43:  [mycat_db]> select * from order_detail;
	+-----------+----------+------------+
	| detail_id | order_id | unit_price |
	+-----------+----------+------------+
	|      5678 |     2222 |         20 |
	|      1234 |     1111 |         20 |
	+-----------+----------+------------+
	2 rows in set (0.01 sec)


192.168.0.201:
	select * from `order`;
	select * from order_detail;
	 
	root@mysqldb 21:14:  [db1]> select * from `order`;
	+----------+--------+
	| order_id | amount |
	+----------+--------+
	|     2222 |    222 |
	+----------+--------+
	1 row in set (0.00 sec)

	root@mysqldb 21:14:  [db1]> select * from order_detail;
	+-----------+----------+------------+
	| detail_id | order_id | unit_price |
	+-----------+----------+------------+
	|      5678 |     2222 |         20 |
	+-----------+----------+------------+
	1 row in set (0.00 sec)


192.168.0.202:

	root@mysqldb 11:21:  [db1]> select * from `order`;
	+----------+--------+
	| order_id | amount |
	+----------+--------+
	|     1111 |  111.1 |
	+----------+--------+
	1 row in set (0.00 sec)

	root@mysqldb 11:21:  [db1]> select * from order_detail;
	+-----------+----------+------------+
	| detail_id | order_id | unit_price |
	+-----------+----------+------------+
	|      1234 |     1111 |         20 |
	+-----------+----------+------------+
	1 row in set (0.00 sec)


可见，当子表与父表的关联字段正好是父表的分片字段时，子表直接根据父表规则进行分片，在数据录入的时候子表直接放在父表的分片上面，在进行关联查询join的时候，走的是父表的路由。
	 