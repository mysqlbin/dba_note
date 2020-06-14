
1. 原理
2. Sequence 获取步骤
3. 配置方式
4. 测试
5. 小结

1. 原理
	在数据库中建立一张表，存放 sequence 名称(name)， sequence 当前值(current_value)，步长(increment int 类型每次读取多少个 sequence，假设为 K)等信息；

2. Sequence 获取步骤
	1. 当初次使用该 sequence 时，根据传入的 sequence 名称，从数据库这张表中读取 current_value，和 increment 到 MyCat 中，并将数据库中的 current_value 设置为原 current_value 值+increment 值。
	2. MyCat 将读取到 current_value+increment 作为本次要使用的 sequence 值，下次使用时，自动加 1，当使用 increment 次后，执行步骤 1)相同的操作。
	3. MyCat 负责维护这张表，用到哪些 sequence，只需要在这张表中插入一条记录即可。 若某次读取的sequence 没有用完，系统就停掉了，则这次读取的 sequence 剩余值不会再使用
	
	
3. 配置方式

	1. server.xml 配置：
		<system><property name="sequnceHandlerType">1</property></system>
		注： sequnceHandlerType 需要配置为 1，表示使用数据库方式生成 sequence。

			
	2. 数据库配置：
	
		1) 创建 mycat_sequence 表
		– 创建存放 sequence 的表
		DROP TABLE IF EXISTS mycat_sequence;
		
		CREATE TABLE mycat_sequence (
			name VARCHAR(50) NOT NULL comment 'name sequence 名称',
			current_value INT NOT NULL comment 'current_value 当前 value',
			increment INT NOT NULL DEFAULT 100 comment '增长步长! 可理解为 mycat 在数据库中一次读取多少个 sequence. 当这些用完后, 下次再从数据库中读取。',
			PRIMARY KEY(name)
		) ENGINE=InnoDB;
			
		– 插入一条 sequence
			INSERT INTO mycat_sequence(`name`,current_value,increment) VALUES ('GLOBALS', 1000000, 100);

			
		创建相关 function 
			
			1. 返回当前的sequence的值
			
				DROP FUNCTION IF EXISTS mycat_seq_currval;
				DELIMITER $$
				CREATE FUNCTION mycat_seq_currval(seq_name VARCHAR(50))RETURNS VARCHAR(64) CHARSET 'utf8'
				BEGIN
				DECLARE retval VARCHAR(64);
				SET retval='-999999999,NULL';
				SELECT CONCAT(CAST(current_value AS CHAR),',',CAST(increment AS CHAR)) INTO retval FROM
				mycat_sequence WHERE NAME = seq_name;
				RETURN retval;
				END$$
				DELIMITER ;
				
			2. 设置sequence的值
				DROP FUNCTION IF EXISTS mycat_seq_setval;
				DELIMITER $$
				CREATE FUNCTION mycat_seq_setval(seq_name VARCHAR(50),VALUE INTEGER) RETURNS VARCHAR(64) CHARSET 'utf8'
				BEGIN
				   UPDATE mycat_sequence SET current_value = VALUE    WHERE NAME = seq_name;
				RETURN mycat_seq_currval(seq_name);
				END$$
				DELIMITER ;
			
			3. 获取下一个sequence的值
				DROP FUNCTION IF EXISTS mycat_seq_nextval;
				DELIMITER $$
				CREATE FUNCTION mycat_seq_nextval(seq_name VARCHAR(50)) RETURNS VARCHAR(64) CHARSET 'utf8'
				BEGIN
				UPDATE mycat_sequence SET current_value = current_value + increment 
				WHERE NAME = seq_name;
				RETURN mycat_seq_currval(seq_name);
				END$$
				DELIMITER ;
				
	3. sequence_db_conf.properties 相关配置,指定 sequence 相关配置在哪个节点上：
	
		例如：
			GLOBALS=dn1
			GLOBALS 为全局序列的名称，dn1 表示分片节点
			
			注意： mycat_sequence 表和以上的 3 个 function， 需要放在同一个节点上。 
			function 请直接在具体节点的数据库上执行，如果执行的时候报： you might want to use the less safe log_bin_trust_function_creators variable
			需要对数据库做如下设置：
				windows 下 my.ini[mysqld]加上 log_bin_trust_function_creators=1
				linux 下/etc/my.cnf 下 my.ini[mysqld]加上 log_bin_trust_function_creators=1
			修改完后，即可在 mysql 数据库中执行上面的函数。
			使用示例：
				insert into table1(id,name) values(next value for MYCATSEQ_GLOBAL,‘test’)；
	
4. 测试
	
	
	root@mysqldb 02:57:  [(none)]> select * from db1.mycat_sequence;
	+---------+---------------+-----------+
	| name    | current_value | increment |
	+---------+---------------+-----------+
	| GLOBALS |             1 |       100 |
	+---------+---------------+-----------+
	1 row in set (0.00 sec)

	登录Mycat做数据插入
		按天分片
			INSERT INTO `test1` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2020-03-01');
			INSERT INTO `test1` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2020-03-11');
			INSERT INTO `test1` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2020-03-22');
		
		
			mycat_user@mysqldb 19:35:  [mycat_db]> INSERT INTO `test1` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2020-03-01');
			(`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2020-03-22');Query OK, 1 row affected (0.02 sec)

			mycat_user@mysqldb 19:36:  [mycat_db]> INSERT INTO `test1` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2020-03-11');
			Query OK, 1 row affected (0.01 sec)

			mycat_user@mysqldb 19:36:  [mycat_db]> INSERT INTO `test1` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2020-03-22');
			Query OK, 1 row affected (0.02 sec)

			
			root@mysqldb 03:33:  [(none)]> select * from db1.mycat_sequence;
			+---------+---------------+-----------+
			| name    | current_value | increment |
			+---------+---------------+-----------+
			| GLOBALS |             1 |       100 |
			+---------+---------------+-----------+
			1 row in set (0.00 sec)
		
		按月份分片
			INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-01-02');
			INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-02-02');
			INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-03-02');
			INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-04-02');
			INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-05-02');
			INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-06-02');
			INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-07-02');
			INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-08-02');
		
	登录分片节点查看数据
		按天分片
			192.168.0.201 
			
				select * from db1.test1;
				select * from db2.test1;
				
				root@mysqldb 03:37:  [(none)]> select * from db1.test1;
				+-----+------+---------------------+
				| ID  | name | CreateTime          |
				+-----+------+---------------------+
				| 101 | lujb | 2020-03-01 00:00:00 |
				+-----+------+---------------------+
				1 row in set (0.00 sec)

				root@mysqldb 03:38:  [(none)]> select * from db2.test1;
				+-----+------+---------------------+
				| ID  | name | CreateTime          |
				+-----+------+---------------------+
				| 102 | lujb | 2020-03-11 00:00:00 |
				+-----+------+---------------------+
				1 row in set (0.00 sec)


			192.168.0.202
			
				root@mysqldb 03:00:  [(none)]>  select * from db1.test1;
				+-----+------+---------------------+
				| ID  | name | CreateTime          |
				+-----+------+---------------------+
				| 103 | lujb | 2020-03-22 00:00:00 |
				+-----+------+---------------------+
				1 row in set (0.00 sec)
				
				
				
		按月份分片
		
			select * from db1.test4;
			select * from db2.test4;
			select * from db3.test4;
			select * from db4.test4;
		
			192.168.0.201 
				root@mysqldb 03:38:  [(none)]> select * from db1.test4;
				+-----+------+---------------------+
				| id  | name | CreateTime          |
				+-----+------+---------------------+
				| 104 | lujb | 2019-01-02 00:00:00 |
				+-----+------+---------------------+
				1 row in set (0.00 sec)

				root@mysqldb 03:51:  [(none)]> select * from db2.test4;
				+-----+------+---------------------+
				| ID  | name | CreateTime          |
				+-----+------+---------------------+
				| 105 | lujb | 2019-02-02 00:00:00 |
				+-----+------+---------------------+
				1 row in set (0.00 sec)

				root@mysqldb 03:51:  [(none)]> select * from db3.test4;
				+-----+------+---------------------+
				| id  | name | CreateTime          |
				+-----+------+---------------------+
				| 106 | lujb | 2019-03-02 00:00:00 |
				+-----+------+---------------------+
				1 row in set (0.00 sec)

				root@mysqldb 03:51:  [(none)]> select * from db4.test4;
				+-----+------+---------------------+
				| id  | name | CreateTime          |
				+-----+------+---------------------+
				| 107 | lujb | 2019-04-02 00:00:00 |
				+-----+------+---------------------+
				1 row in set (0.01 sec)
			
			192.168.0.202
				root@mysqldb 03:42:  [(none)]> select * from db1.test4;
				+-----+------+---------------------+
				| id  | name | CreateTime          |
				+-----+------+---------------------+
				| 108 | lujb | 2019-05-02 00:00:00 |
				+-----+------+---------------------+
				1 row in set (0.00 sec)

				root@mysqldb 03:55:  [(none)]> select * from db2.test4;
				+-----+------+---------------------+
				| id  | name | CreateTime          |
				+-----+------+---------------------+
				| 109 | lujb | 2019-06-02 00:00:00 |
				+-----+------+---------------------+
				1 row in set (0.00 sec)

				root@mysqldb 03:55:  [(none)]> select * from db3.test4;
				+-----+------+---------------------+
				| id  | name | CreateTime          |
				+-----+------+---------------------+
				| 110 | lujb | 2019-07-02 00:00:00 |
				+-----+------+---------------------+
				1 row in set (0.00 sec)

				root@mysqldb 03:55:  [(none)]> select * from db4.test4;
				+-----+------+---------------------+
				| ID  | name | CreateTime          |
				+-----+------+---------------------+
				| 111 | lujb | 2019-08-02 00:00:00 |
				+-----+------+---------------------+
				1 row in set (0.00 sec)

5. 小结
	基于数据库方式生成全局序列的方式， 需要写完整列名，这个对业务改造挺大。
	基于主从模式, 如果存取sequence的数据库挂了，不会遇到单点故障
	如下：
		INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-08-02');
	id 列的值都要加上 'next value for MYCATSEQ_GLOBALS'。

	但是这里的 https://segmentfault.com/a/1190000015862596	没有说要 加 next value for MYCATSEQ_GLOBALS 啊.
	
	insert 不需要写完整列名
		mycat_user@mysqldb 02:32:  [mycat_db]> INSERT INTO `test4` (`id`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', '2019-08-02');
		Query OK, 1 row affected (0.02 sec)

