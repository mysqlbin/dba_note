


方式一
	不需要密码
		通过 navicat工具执行查询命令并导出保存为 csv 格式
			SELECT szToken,tStartTime,tEndTime,nGameType,nServerID,LogData,CardData FROM t1;

		再通过 mongoimport 命令导入
			time /usr/local/mongodb/bin/mongoimport -d sbtest_db -c t1 -f szToken,tStartTime,tEndTime,nGameType,nServerID,LogData,CardData  --type csv --file t1-01.csv

			shell> time /usr/local/mongodb/bin/mongoimport -d sbtest_db -c t1 -f szToken,tStartTime,tEndTime,nGameType,nServerID,LogData,CardData  --type csv --file t1-01.csv
			2020-06-12T09:39:18.962+0800	connected to: mongodb://localhost/
			2020-06-12T09:39:21.963+0800	[##......................] sbtest_db.t1	72.9MB/739MB (9.9%)
			2020-06-12T09:39:24.963+0800	[####....................] sbtest_db.t1	145MB/739MB (19.6%)
			2020-06-12T09:39:27.963+0800	[#######.................] sbtest_db.t1	217MB/739MB (29.3%)
			2020-06-12T09:39:30.963+0800	[#########...............] sbtest_db.t1	289MB/739MB (39.1%)
			2020-06-12T09:39:33.963+0800	[###########.............] sbtest_db.t1	360MB/739MB (48.8%)
			2020-06-12T09:39:36.963+0800	[##############..........] sbtest_db.t1	432MB/739MB (58.4%)
			2020-06-12T09:39:39.963+0800	[################........] sbtest_db.t1	501MB/739MB (67.8%)
			2020-06-12T09:39:42.963+0800	[##################......] sbtest_db.t1	568MB/739MB (76.9%)
			2020-06-12T09:39:45.963+0800	[####################....] sbtest_db.t1	638MB/739MB (86.4%)
			2020-06-12T09:39:48.963+0800	[#######################.] sbtest_db.t1	710MB/739MB (96.1%)
			2020-06-12T09:39:50.232+0800	[########################] sbtest_db.t1	739MB/739MB (100.0%)
			2020-06-12T09:39:50.232+0800	500001 document(s) imported successfully. 0 document(s) failed to import.

			real	0m31.284s
			user	0m51.589s
			sys	0m3.286s
			
			use sbtest_db
			
			db.t1.aggregate([{$group : {_id : "$by_user", num_tutorial : {$sum : 1}}}])
			{ "_id" : null, "num_tutorial" : 500003 }

	需要密码
		time /usr/local/mongodb/bin/mongoimport -host 192.168.1.31  -u admin -p admin -d sbtest_db -c t1 -f id,c,d  --type csv  --file aa.csv
			2020-06-13T11:47:03.970+0800	error validating settings: incompatible options: --file and positional argument(s)
		/*	
		time /usr/local/mongodb/bin/mongoimport  -d sbtest_db -c t1 -f id,c,d  --type csv  --file aa.csv
			2020-06-13T11:48:43.923+0800	connected to: mongodb://localhost/
			2020-06-13T11:48:44.039+0800	2 document(s) imported successfully. 0 document(s) failed to import.
		*/
		
		time /usr/local/mongodb/bin/mongoimport --host "192.168.1.31:27017"  -u "admin" -p "admin" --authenticationDatabase "admin" -d sbtest_db -c t1 -f  id,c,d  --type csv  --file aa.csv
		# 这里才是正确姿势。
		
方式二
	[root@mongodb ~]# yum -y install mysql mysql-server
	[root@mongodb ~]# /etc/init.d/mysqld start
	[root@mongodb ~]# mysql
	mysql> create database benet;
	Query OK, 1 row affected (0.00 sec)

	mysql> use benet;
	Database changed

	mysql> create table t1(id int,name varchar(20));
	Query OK, 0 rows affected (0.05 sec)

	mysql> insert into t1 values(1,"Jack");
	Query OK, 1 row affected (0.00 sec)

	mysql> insert into t1 values(2,"Rose");
	Query OK, 1 row affected (0.00 sec)

	mysql> select * from t1;
	+------+------+
	| id | name |
	+------+------+
	| 1 | Jack |
	| 2 | Rose |
	+------+------+
	2 rows in set (0.00 sec)

	mysql> select * from t1 into outfile 't1_mysql.csv' fields terminated by ","; #导出 t1  表里的内容到/tmp/t1_mysql.csv 


	[root@localhost niuniuh5_db]# find / -name t1_mysql.csv
	/home/mysql/mysql3306/data/niuniuh5_db/t1_mysql.csv

	[root@localhost niuniuh5_db]# cat t1_mysql.csv 
	1,Jack
	2,Rose



	将csv  格式的表导入 mongodb # 将/tmp/t1_mysql.csv  文件 导入到 mongodb 的 的 benet  数据库下的 tt1  表，字段名称为 id  和 name ，文件类型为csv
	[root@mongodb ~]# /usr/local/mongodb/bin/mongoimport -d benet -c tt1 -f id,name --file /home/mysql/mysql3306/data/niuniuh5_db/t1_mysql.csv
	2020-06-11T16:06:22.958+0800	error validating settings: can not use --fields when input type is JSON


	[root@localhost niuniuh5_db]# /usr/local/mongodb/bin/mongoimport admin -u admin  -p admin -d benet -c tt1 -f id,name --type csv --file /home/mysql/mysql3306/data/niuniuh5_db/t1_mysql.csv
	2020-06-11T16:18:59.149+0800	error validating settings: incompatible options: --file and positional argument(s)
	# 验证设置时出错：不兼容的选项：-文件和位置参数
	在导入数据时 --collection 对应的集合名称必须与 --file路径下的集合名称相一致，否则会出现如下错误，这是个容易被忽略的坑

	[root@localhost niuniuh5_db]# /usr/local/mongodb/bin/mongoimport -h IP地址 -u admin  -p admin -d benet -c t1_mysql -f id,name --type csv --file t1_mysql.csv
	
	db.t1_mysql.insert({"id" : 1, "name" : "bin"})

	> db.t1_mysql.count()
	1
	> db.t1_mysql.find()
	{ "_id" : ObjectId("5ee1eeb0f38560c5ba69f5b4"), 



相关参考
	http://wangqw.cn/?p=268  将 MySQL 数据库内容导入 mongodb
	https://www.jianshu.com/p/5c8307e2b1ce  MongoDB数据库备份与恢复/导出与导入(十)
	https://www.cnblogs.com/mengyu/p/7718311.html   Mongo导出mongoexport和导入mongoimport介绍
	https://www.cnblogs.com/zpdbkshangshanluoshuo/p/10065311.html  mysql数据导入mongodb中

	https://www.xttblog.com/?p=4203   MySQL迁移到MongoDB的简单教程

	
	






