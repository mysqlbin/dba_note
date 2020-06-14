
1. 全局表跨库join
	简介 
		1）全局表的插入、更新操作会实时在所有节点上执行，保持各个分片数据的一致性；
		2）全局表的查询操作只从一个节点上获取；
		3）全局表可以跟任何一个表进行join操作；
		一般那种数据量不大，并且变化比较少的表适合作为全局表存在，这样在每个分片上都有相同的数据，自然每个业务表都可以跟全局表进行join,从某种程度上解决了跨库join。一般字典表等适合做全局表。
		
		如果表数据发生改变, 意味着在全局都需要修改
		
	支持单库内部任意join，支持跨库2表join，甚至基于caltlet的多表join。
	支持通过全局表，ER关系的分片策略，实现了高效的多表join查询。

	创建数据库和表
		use db1;
		create table sex(id int not null,name varchar(20) not null); 
		create table user(id int not null,name varchar(20) not null, sex_id int not null); 
		 
	配置分片规则rule.xml

		<tableRule name="sharding-join-mod-long">   <!-- 表test2 的拆分规则配置-->
			<rule>
				<columns>id</columns>
				<algorithm>mod-long</algorithm>
			</rule>
		</tableRule>


	配置schema.xml分片表，指定全局表type="global"

		<table name="user" dataNode="dn1,dn5" rule="sharding-join-mod-long"></table>
		<table name="sex" dataNode="dn1,dn5" type="global"></table>

		<dataNode name="dn1" dataHost="datahost_201" database="db1" />
		<dataNode name="dn5" dataHost="datahost_202" database="db1" />
		
		<!-- 主数据库201 -->
		<dataHost name="datahost_201" maxCon="1000" minCon="10" balance="3"  
				  writeType="0" dbType="mysql" dbDriver="native" switchType="2"  slaveThreshold="100">   <!-- 底层MySQL登录方式-->
			<heartbeat>show slave status</heartbeat>
			<!-- can have multi write hosts -->
			<writeHost host="mycat01" url="192.168.0.201:3306" user="root" password="123456abc">
				<readHost host="mycat05" url="192.168.0.205:3306" user="root" password="123456abc" />
			</writeHost>
			<!-- <writeHost host="hostM2" url="localhost:3316" user="root" password="123456"/> -->
			
			 <!-- 备用写节点  -->
			<writeHost host="mycat05" url="192.168.0.205:3306" user="root" password="123456abc">
			</writeHost>

		</dataHost>
		
		
		<dataHost name="datahost_202" maxCon="1000" minCon="10" balance="0" 
				  writeType="0" dbType="mysql" dbDriver="native" switchType="1"  slaveThreshold="100">   <!-- 底层MySQL登录方式-->
			<heartbeat>select user()</heartbeat>
			<!-- can have multi write hosts -->
			<writeHost host="mycat02" url="192.168.0.202:3306" user="root" password="123456abc">
			</writeHost>
			<!-- <writeHost host="hostM2" url="localhost:3316" user="root" password="123456"/> -->
		</dataHost>
		
		
	插入数据进行测试
		
		insert into sex(id,name) values(1,'male');
		insert into sex(id,name) values(2,'female');
		insert into user(id,name,sex_id) values(1,'zhangsan',1);
		insert into user(id,name,sex_id) values(2,'lisi',2);


		mycat_user@mysqldb 17:54:  [mycat_db]> insert into user(id,name,sex_id) values(1,'zhangsan',1);
		ERROR 1064 (HY000): bad insert sql (sharding column:USER not provided,INSERT INTO user (id, name, sex_id)
		VALUES (1, 'zhangsan', 1)
		mycat_user@mysqldb 17:54:  [mycat_db]> insert into user(id,name,sex_id) values(2,'lisi',2);
		ERROR 1064 (HY000): bad insert sql (sharding column:USER not provided,INSERT INTO user (id, name, sex_id)
		VALUES (2, 'lisi', 2)

		出现的错误可能问题为：

		1、rule规则里的规则配置有误。columns 字段不是指定的分区字段


	查看数据:	
		192.168.0.201 	
			root@mysqldb 17:33:  [db1]> use db1;
			Database changed
			root@mysqldb 17:33:  [db1]> select * from sex;
			+----+--------+
			| id | name   |
			+----+--------+
			|  1 | male   |
			|  2 | female |
			+----+--------+
			2 rows in set (0.00 sec)

			root@mysqldb 17:33:  [db1]> select * from user;
			+----+------+--------+
			| id | name | sex_id |
			+----+------+--------+
			|  2 | lisi |      2 |
			+----+------+--------+


		192.168.0.202

			root@mysqldb 07:40:  [(none)]> use db1;
			Database changed
			root@mysqldb 07:41:  [db1]>  select * from sex;
			+----+--------+
			| id | name   |
			+----+--------+
			|  1 | male   |
			|  2 | female |
			+----+--------+
			2 rows in set (0.00 sec)

			root@mysqldb 07:41:  [db1]> select * from user;
			+----+----------+--------+
			| id | name     | sex_id |
			+----+----------+--------+
			|  1 | zhangsan |      1 |
			+----+----------+--------+
			1 row in set (0.00 sec)
		
		

	下面进行跨库join测试

		left join左连接
			select * from user a left join sex b on a.sex_id = b.id; 

			mycat_user@mysqldb 18:03:  [mycat_db]> select * from user a left join sex b on a.sex_id = b.id; 
			+----+----------+--------+------+--------+
			| id | name     | sex_id | id   | name   |
			+----+----------+--------+------+--------+
			|  2 | lisi     |      2 |    2 | female |
			|  1 | zhangsan |      1 |    1 | male   |
			+----+----------+--------+------+--------+
			2 rows in set (0.01 sec)
		
		控制返回字段的个数
			select a.name,b.name from user a left join sex b on a.sex_id = b.id; 
			
			mycat_user@mysqldb 18:08:  [mycat_db]> select a.name,b.name from user a left join sex b on a.sex_id = b.id; 
			+----------+--------+
			| name     | name   |
			+----------+--------+
			| lisi     | female |
			| zhangsan | male   |
			+----------+--------+
			2 rows in set (0.01 sec)

		 排序测试：注意排序的字段需要在 select a.id from .xxx order a.id 中显式返回该排序字段a.id。
			
			显式返回该排序字段
				 select a.id, a.name,b.name from user a left join sex b on a.sex_id = b.id order by a.id desc;

				 mycat_user@mysqldb 18:09:  [mycat_db]>  select a.id, a.name,b.name from user a left join sex b on a.sex_id = b.id order by a.id desc;
				+----+----------+--------+
				| id | name     | name   |
				+----+----------+--------+
				|  2 | lisi     | female |
				|  1 | zhangsan | male   |
				+----+----------+--------+
				2 rows in set (0.03 sec)

			不显式返回该排序字段
				mycat_user@mysqldb 22:09:  [mycat_db]> select a.name,b.name from user a left join sex b on a.sex_id = b.id order by a.id desc;
				ERROR 2013 (HY000): Lost connection to MySQL server during query


			
		count() 统计	
			mycat_user@mysqldb 18:12:  [mycat_db]> select count(*) from user a left join sex b on a.sex_id = b.id;
			+--------+
			| COUNT0 |
			+--------+
			|      2 |
			+--------+
			1 row in set (0.01 sec)

		
		
		 