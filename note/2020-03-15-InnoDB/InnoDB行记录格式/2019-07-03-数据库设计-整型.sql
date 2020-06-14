
1. int(1) 和 int(10)的区别
	1.1 int(1)
	1.2 int(10)
	1.3 小结
	
2. int(20) 中20的涵义
	2.1 含义
	2.2 zerofill属性实践	
		2.2.1 int(4).zerofill
		2.2.2 int(20).zerofill	
		
1. int(1) 和 int(10)的区别
	
	1.1 int(1)
		DROP TABLE IF EXISTS `table_data_type_int_01`;
		CREATE TABLE `table_data_type_int_01` (
		  `id` int(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
		  `amount` int(1)  DEFAULT NULL,
		  PRIMARY KEY (`id`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

		INSERT INTO `table_data_type_int_01` VALUES ('1', '1000');
		INSERT INTO `table_data_type_int_01` VALUES ('2', '800000');


		mysql> select amount from table_data_type_int_01 where id=1;
		+--------+
		| amount |
		+--------+
		|   1000 |
		+--------+
		1 row in set (0.00 sec)


		mysql> select length(amount) from table_data_type_int_01 where id=1;
		+----------------+
		| length(amount) |
		+----------------+
		|              4 |
		+----------------+
		1 row in set (0.00 sec)

		mysql> select length(amount) from table_data_type_int_01 where id=2;
		+----------------+
		| length(amount) |
		+----------------+
		|              6 |
		+----------------+
		1 row in set (0.00 sec)

		#一个数字占用一个字节


	1.2. int(20)
		DROP TABLE IF EXISTS `table_data_type_int_20`;
		CREATE TABLE `table_data_type_int_20` (
		  `id` int(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
		  `amount` int(1)  DEFAULT NULL,
		  PRIMARY KEY (`id`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

		INSERT INTO `table_data_type_int_20` VALUES ('1', '1000');
		INSERT INTO `table_data_type_int_20` VALUES ('2', '800000');


		mysql> select amount from table_data_type_int_20 where id=1;
		+--------+
		| amount |
		+--------+
		|   1000 |
		+--------+
		1 row in set (0.00 sec)


		mysql> select length(amount) from table_data_type_int_20 where id=1;
		+----------------+
		| length(amount) |
		+----------------+
		|              4 |
		+----------------+
		1 row in set (0.00 sec)


		mysql> select length(amount) from table_data_type_int_20 where id=2;
		+----------------+
		| length(amount) |
		+----------------+
		|              6 |
		+----------------+
		1 row in set (0.00 sec)

		#一个数字占用一个字节

	1.3 小结: int(1)和int(20)存储和计算均一样.
	
	

2. int(20) 中20的含义:

	2.1 含义
		是指显示字符的长度; 
		在有带zerofill属性的int下才有意义;
		不影响内部存储;
		影响带 zerofill属性 定义的 int 时，如果int列的值小于 int(N)中的N, 值前面补多少个 0，易于报表展示;
			如果 int(20) 定义了 zerofill属性, 插入的值为 1, 那么, 1前面会有19个0;
			
	2.2 zerofill属性实践	
		
		2.2.1 int(4).zerofill
			DROP TABLE IF EXISTS `table_data_type_int`;
			CREATE TABLE `table_data_type_int` (
			  `id` int(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
			  `amount` int(4) zerofill DEFAULT NULL,
			  PRIMARY KEY (`id`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

			INSERT INTO `table_data_type_int` VALUES ('1', '1');


			mysql> select * from table_data_type_int;
			+----+--------+
			| id | amount |
			+----+--------+
			|  1 |   0001 |
			+----+--------+
			1 row in set (0.00 sec)


			mysql> select hex(amount) from table_data_type_int;
			+-------------+
			| hex(amount) |
			+-------------+
			| 1           |
			+-------------+
			1 row in set (0.00 sec)


			mysql> select length(amount) from table_data_type_int;
			+----------------+
			| length(amount) |
			+----------------+
			|              4 |
			+----------------+
			1 row in set (0.00 sec)


		2.2.2 int(20).zerofill
			DROP TABLE IF EXISTS `table_data_type_int_zerofill_20`;
			CREATE TABLE `table_data_type_int_zerofill_20` (
			  `id` int(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
			  `amount` int(20) zerofill DEFAULT NULL,
			  PRIMARY KEY (`id`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
				
			INSERT INTO `table_data_type_int_zerofill_20` VALUES ('1', '1');

			mysql> select * from table_data_type_int_zerofill_20;
			+----+----------------------+
			| id | amount               |
			+----+----------------------+
			|  1 | 00000000000000000001 |
			+----+----------------------+
			1 row in set (0.00 sec)

			mysql> select hex(amount) from table_data_type_int_zerofill_20;
			+-------------+
			| hex(amount) |
			+-------------+
			| 1           |
			+-------------+
			1 row in set (0.00 sec)

