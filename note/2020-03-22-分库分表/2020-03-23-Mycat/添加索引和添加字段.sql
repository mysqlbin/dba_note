
添加索引
	查看表的DDL
		mycat_user@mysqldb 15:40:  [mycat_db]> show create table order_detail\G;
		*************************** 1. row ***************************
			   Table: order_detail
		Create Table: CREATE TABLE `order_detail` (
		  `detail_id` int(20) NOT NULL COMMENT '订单详情ID',
		  `order_id` int(20) DEFAULT NULL COMMENT '订单ID',
		  `unit_price` float DEFAULT NULL COMMENT '单价',
		  PRIMARY KEY (`detail_id`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8
		1 row in set (0.01 sec)


	在逻辑库添加索引

		alter table order_detail add index idx_order_id(`order_id`);

		mycat_user@mysqldb 15:40:  [mycat_db]> alter table order_detail add index idx_order_id(`order_id`);
		Query OK, 0 rows affected (0.09 sec)
		Records: 0  Duplicates: 0  Warnings: 0

		查看表的DDL
			mycat_user@mysqldb 15:40:  [mycat_db]> show create table order_detail\G;
			*************************** 1. row ***************************
				   Table: order_detail
			Create Table: CREATE TABLE `order_detail` (
			  `detail_id` int(20) NOT NULL COMMENT '订单详情ID',
			  `order_id` int(20) DEFAULT NULL COMMENT '订单ID',
			  `unit_price` float DEFAULT NULL COMMENT '单价',
			  PRIMARY KEY (`detail_id`),
			  KEY `IDX_ORDER_ID` (`order_id`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8
			1 row in set (0.01 sec)

	去分片节点看
		192.168.0.201
			root@mysqldb 14:36:  [db1]> show create table order_detail\G;
			*************************** 1. row ***************************
				   Table: order_detail
			Create Table: CREATE TABLE `order_detail` (
			  `detail_id` int(20) NOT NULL COMMENT '订单详情ID',
			  `order_id` int(20) DEFAULT NULL COMMENT '订单ID',
			  `unit_price` float DEFAULT NULL COMMENT '单价',
			  PRIMARY KEY (`detail_id`),
			  KEY `IDX_ORDER_ID` (`order_id`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8
			1 row in set (0.00 sec)

		192.168.0.202
			root@mysqldb 04:38:  [db1]> show create table order_detail\G;
			*************************** 1. row ***************************
				   Table: order_detail
			Create Table: CREATE TABLE `order_detail` (
			  `detail_id` int(20) NOT NULL COMMENT '订单详情ID',
			  `order_id` int(20) DEFAULT NULL COMMENT '订单ID',
			  `unit_price` float DEFAULT NULL COMMENT '单价',
			  PRIMARY KEY (`detail_id`),
			  KEY `IDX_ORDER_ID` (`order_id`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8
			1 row in set (0.00 sec)


添加字段
	查看表的DDL
		mycat_user@mysqldb 15:49:  [mycat_db]> show create table order_detail\G;
		*************************** 1. row ***************************
			   Table: order_detail
		Create Table: CREATE TABLE `order_detail` (
		  `detail_id` int(20) NOT NULL COMMENT '订单详情ID',
		  `order_id` int(20) DEFAULT NULL COMMENT '订单ID',
		  `unit_price` float DEFAULT NULL COMMENT '单价',
		  PRIMARY KEY (`detail_id`),
		  KEY `IDX_ORDER_ID` (`order_id`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8
		1 row in set (0.01 sec)
	
	在逻辑库对表添加字段
		mycat_user@mysqldb 15:55:  [mycat_db]> alter table order_detail add column user_id int(11) comment '用户ID';
		Query OK, 0 rows affected (0.15 sec)
		Records: 0  Duplicates: 0  Warnings: 0
		
		查看表的DDL
			mycat_user@mysqldb 15:55:  [mycat_db]> show create table order_detail\G;
			*************************** 1. row ***************************
				   Table: order_detail
			Create Table: CREATE TABLE `order_detail` (
			  `detail_id` int(20) NOT NULL COMMENT '订单详情ID',
			  `order_id` int(20) DEFAULT NULL COMMENT '订单ID',
			  `unit_price` float DEFAULT NULL COMMENT '单价',
			  `USER_ID` int(11) DEFAULT NULL COMMENT '用户ID',
			  PRIMARY KEY (`detail_id`),
			  KEY `IDX_ORDER_ID` (`order_id`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8
			1 row in set (0.01 sec)


		192.168.0.201
			root@mysqldb 15:10:  [db1]> show create table order_detail\G;
			*************************** 1. row ***************************
				   Table: order_detail
			Create Table: CREATE TABLE `order_detail` (
			  `detail_id` int(20) NOT NULL COMMENT '订单详情ID',
			  `order_id` int(20) DEFAULT NULL COMMENT '订单ID',
			  `unit_price` float DEFAULT NULL COMMENT '单价',
			  `USER_ID` int(11) DEFAULT NULL COMMENT '用户ID',
			  PRIMARY KEY (`detail_id`),
			  KEY `IDX_ORDER_ID` (`order_id`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8
			1 row in set (0.00 sec)
		
		192.168.0.202
		
			root@mysqldb 05:17:  [db1]> show create table order_detail\G;
			*************************** 1. row ***************************
				   Table: order_detail
			Create Table: CREATE TABLE `order_detail` (
			  `detail_id` int(20) NOT NULL COMMENT '订单详情ID',
			  `order_id` int(20) DEFAULT NULL COMMENT '订单ID',
			  `unit_price` float DEFAULT NULL COMMENT '单价',
			  `USER_ID` int(11) DEFAULT NULL COMMENT '用户ID',
			  PRIMARY KEY (`detail_id`),
			  KEY `IDX_ORDER_ID` (`order_id`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8
			1 row in set (0.00 sec)

	
	在分片添加字段
		192.168.0.201
			root@mysqldb 15:27:  [db1]> alter table order_detail add column is_ok int(11) comment '是否支付';
			Query OK, 0 rows affected (0.11 sec)
			Records: 0  Duplicates: 0  Warnings: 0

		去逻辑库查看表的DDL	
			mycat_user@mysqldb 15:55:  [mycat_db]> show create table order_detail\G;
			*************************** 1. row ***************************
				   Table: order_detail
			Create Table: CREATE TABLE `order_detail` (
			  `detail_id` int(20) NOT NULL COMMENT '订单详情ID',
			  `order_id` int(20) DEFAULT NULL COMMENT '订单ID',
			  `unit_price` float DEFAULT NULL COMMENT '单价',
			  `USER_ID` int(11) DEFAULT NULL COMMENT '用户ID',
			  PRIMARY KEY (`detail_id`),
			  KEY `IDX_ORDER_ID` (`order_id`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8
			1 row in set (0.01 sec)
		
		192.168.0.202
			root@mysqldb 05:35:  [db1]> alter table order_detail add column is_ok int(11) comment '是否支付';
			Query OK, 0 rows affected (0.11 sec)
			Records: 0  Duplicates: 0  Warnings: 0
		
		去逻辑库查看表的DDL
			mycat_user@mysqldb 15:40:  [mycat_db]> show create table order_detail\G;
			*************************** 1. row ***************************
				   Table: order_detail
			Create Table: CREATE TABLE `order_detail` (
			  `detail_id` int(20) NOT NULL COMMENT '订单详情ID',
			  `order_id` int(20) DEFAULT NULL COMMENT '订单ID',
			  `unit_price` float DEFAULT NULL COMMENT '单价',
			  `USER_ID` int(11) DEFAULT NULL COMMENT '用户ID',
			  `is_ok` int(11) DEFAULT NULL COMMENT '是否支付',
			  PRIMARY KEY (`detail_id`),
			  KEY `IDX_ORDER_ID` (`order_id`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8
			1 row in set (0.01 sec)

			可以发现, 在所有分片节点都添加字段后, 才可以在逻辑库中查看到添加的字段.
			
			
			