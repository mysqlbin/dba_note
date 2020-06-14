

1. 本地克隆
	1.1 安装克隆插件
	1.2 检查插件有没有启用
	1.3 克隆需要的权限
	1.4 执行本地克隆	
	1.5 本地克隆的步骤
	1.6 观察克隆进度
	1.7 查看备份目录
	1.8 测试，起一个克隆的实例
2. 远程克隆
3. 在远程克隆的基础上建立主从复制
4. 监控克隆操作
5. 在远程克隆的基础上-MGR组复制加入新成员
6. 小结

1. 本地克隆

	1.1 安装克隆插件
		启动前
			[mysqld]
			plugin-load-add=mysql_clone.so
		或运行中
			INSTALL PLUGIN clone SONAME 'mysql_clone.so';
			
	1.2 检查插件有没有启用

		mysql> SELECT PLUGIN_NAME, PLUGIN_STATUS FROM INFORMATION_SCHEMA.PLUGINS WHERE PLUGIN_NAME LIKE 'clone';

		+-------------+---------------+
		| PLUGIN_NAME | PLUGIN_STATUS |
		+-------------+---------------+
		| clone       | ACTIVE        |
		+-------------+---------------+
		1 row in set (0.00 sec)
	
	1.3 克隆需要的权限
		需要有备份锁的权限。备份锁是 MySQL 8.0 的新特性之一，比5.7版本的flush table with read lock要轻量。
		
		mysql> CREATE USER clone_user@'%' IDENTIFIED by '123456abc';
		mysql> GRANT BACKUP_ADMIN ON *.* TO 'clone_user';              # BACKUP_ADMIN 是 MySQL8.0 才有的备份锁的权限
		
		
	1.4 执行本地克隆	
		mysql -uclone_user -ppassword -S /tmp/mysql3008.sock
		mysql> CLONE LOCAL DATA DIRECTORY = '/data/clone_dir';
		# 例子中需要 MySQL 的运行用户拥有 data 目录的rwx权限，要求 clone_dir 目录不存在

		
		ERROR 1006 (HY000): Can t create database '/data/clone_dir/' (errno: 13 - Permission denied)
	
		mysql> CLONE LOCAL DATA DIRECTORY = '/data/backup/clone_dir';

		
	1.5 本地克隆的步骤

		DROP DATA

		FILE COPY

		PAGE COPY

		REDO COPY

		FILE SYNC

	1.6 观察克隆进度
	
		mysql> SELECT STAGE, STATE, END_TIME FROM performance_schema.clone_progress;


		mysql> SELECT STAGE, STATE, END_TIME FROM performance_schema.clone_progress;
		+-----------+-------------+----------------------------+
		| STAGE     | STATE       | END_TIME                   |
		+-----------+-------------+----------------------------+
		| DROP DATA | Completed   | 2019-11-14 16:07:44.171752 |
		| FILE COPY | In Progress | NULL                       |
		| PAGE COPY | Not Started | NULL                       |
		| REDO COPY | Not Started | NULL                       |
		| FILE SYNC | Not Started | NULL                       |
		| RESTART   | Not Started | NULL                       |
		| RECOVERY  | Not Started | NULL                       |
		+-----------+-------------+----------------------------+
		7 rows in set (0.00 sec)

		mysql> SELECT STAGE, STATE, END_TIME FROM performance_schema.clone_progress;
		+-----------+-------------+----------------------------+
		| STAGE     | STATE       | END_TIME                   |
		+-----------+-------------+----------------------------+
		| DROP DATA | Completed   | 2019-11-14 16:07:44.171752 |
		| FILE COPY | Completed   | 2019-11-14 16:08:14.283980 |
		| PAGE COPY | Completed   | 2019-11-14 16:08:14.596795 |
		| REDO COPY | Completed   | 2019-11-14 16:08:14.799798 |
		| FILE SYNC | In Progress | NULL                       |
		| RESTART   | Not Started | NULL                       |
		| RECOVERY  | Not Started | NULL                       |
		+-----------+-------------+----------------------------+
		7 rows in set (0.00 sec)

		mysql> SELECT STAGE, STATE, END_TIME FROM performance_schema.clone_progress;
		+-----------+-------------+----------------------------+
		| STAGE     | STATE       | END_TIME                   |
		+-----------+-------------+----------------------------+
		| DROP DATA | Completed   | 2019-11-14 16:07:44.171752 |
		| FILE COPY | Completed   | 2019-11-14 16:08:14.283980 |
		| PAGE COPY | Completed   | 2019-11-14 16:08:14.596795 |
		| REDO COPY | Completed   | 2019-11-14 16:08:14.799798 |
		| FILE SYNC | Completed   | 2019-11-14 16:09:39.195509 |
		| RESTART   | Not Started | NULL                       |
		| RECOVERY  | Not Started | NULL                       |
		+-----------+-------------+----------------------------+
		7 rows in set (0.00 sec)

		
	1.7 查看备份目录
		[root@kp04 clone_dir]# pwd
		/data/backup/clone_dir
		[root@kp04 clone_dir]# ll
		total 5289992
		drwxr-x---. 2 mysql mysql         89 Nov 14 16:09 #clone
		-rw-r-----. 1 mysql mysql       3833 Nov 14 16:07 ib_buffer_pool
		-rw-r-----. 1 mysql mysql 1073741824 Nov 14 16:08 ibdata1
		-rw-r-----. 1 mysql mysql 2147483648 Nov 14 16:09 ib_logfile0
		-rw-r-----. 1 mysql mysql 2147483648 Nov 14 16:09 ib_logfile1
		drwxr-x---. 2 mysql mysql          6 Nov 14 16:07 mysql
		-rw-r-----. 1 mysql mysql   25165824 Nov 14 16:08 mysql.ibd
		drwxr-x---. 2 mysql mysql         28 Nov 14 16:07 sys
		drwxr-x---. 2 mysql mysql         20 Nov 14 16:07 test_20191101
		-rw-r-----. 1 mysql mysql   11534336 Nov 14 16:08 undo_001
		-rw-r-----. 1 mysql mysql   11534336 Nov 14 16:08 undo_002

	
	1.8 测试，起一个克隆的实例
		/usr/local/mysql/bin/mysqld --datadir=/data/backup/clone_dir --port=3333 --socket=/tmp/mysql3333.sock --user=mysql --lower-case-table-names=1 --mysqlx=OFF
		 
		#解释，因为我没有使用my.cnf，所以加了比较多参数
		#--datadir 指定启动的数据目录
		#--port 指定启动的MySQL监听端口
		#--socket 指定socket路径
		#--user `捐赠者`的目录权限是mysql:mysql,用户也是mysql3008user，我没有修改
		#--lower-case-table-names=1 同`捐赠者`
		#--mysqlx=OFF 不关闭的话，默认mysqlx端口会合`捐赠者`的33060重复冲突
		 
		#登录检查
		mysql -uroot -p123456abc -S /tmp/mysql3333.sock
		mysql> show master status\G # 可见GTID是`捐赠者`的子集，所以说明`接受者`直接和`捐赠者`建主从复制是很简单的


2. 远程克隆
	假设前提条件都满足，步骤如下

	和本地克隆一样，远程克隆需要插件安装和用户授权。捐赠者、接受者的授权略有不同。
	
	捐赠者的数据:
		root@mysqldb 19:43:  [test_20191101]> select * from test_20191101.t1;
		+------+
		| a    |
		+------+
		|    1 |
		|    2 |
		|    3 |
		|    4 |
		|    5 |
		|    6 |
		+------+
		6 rows in set (0.00 sec)
		
	接受者的数据:	
		root@mysqldb 14:34:  [test_20191101]> select * from test_20191101.t1;
		+------+
		| a    |
		+------+
		|    1 |
		|    2 |
		|    3 |
		|    4 |
		|    5 |
		+------+
		5 rows in set (0.00 sec)



	1. 确保捐赠者和接受者都安装了克隆插件

		INSTALL PLUGIN clone SONAME 'mysql_clone.so';


	2. 用户账号授权

		捐赠者授权
		
	
			mysql> CREATE USER clone_user_01@'192.168.0.%' IDENTIFIED by '123456abc';
			mysql> GRANT BACKUP_ADMIN ON *.* TO 'clone_user_01'@'192.168.0.%';         # BACKUP_ADMIN是MySQL8.0 才有的备份锁的权限
			
				
		接受者授权

			mysql> CREATE USER clone_user_01@'192.168.0.%' IDENTIFIED by '123456abc';
			mysql> GRANT CLONE_ADMIN ON *.* TO 'clone_user_01'@'192.168.0.%';
			
		CLONE_ADMIN权限 = BACKUP_ADMIN权限 + SHUTDOWN权限。SHUTDOWN仅限允许用户shutdown和restart mysqld。授权不同是因为，接受者需要restart mysqld。		
		
	3. 接受者设置捐赠者列表清单

		mysql> SET GLOBAL clone_valid_donor_list = '192.168.0.91:3306';
	
		接受者开始拉取克隆捐赠者数据

		CLONE INSTANCE FROM 'clone_user_01'@'192.168.0.91':3306 IDENTIFIED BY '123456abc';
	
	4. 监控远程克隆

		mysql> SELECT STAGE, STATE, END_TIME FROM performance_schema.clone_progress;
	
		root@mysqldb 14:40:  [test_20191101]> SELECT STAGE, STATE, END_TIME FROM performance_schema.clone_progress;
		+-----------+-------------+----------------------------+
		| STAGE     | STATE       | END_TIME                   |
		+-----------+-------------+----------------------------+
		| DROP DATA | Completed   | 2019-11-15 14:39:53.320177 |
		| FILE COPY | In Progress | NULL                       |
		| PAGE COPY | Not Started | NULL                       |
		| REDO COPY | Not Started | NULL                       |
		| FILE SYNC | Not Started | NULL                       |
		| RESTART   | Not Started | NULL                       |
		| RECOVERY  | Not Started | NULL                       |
		+-----------+-------------+----------------------------+
		7 rows in set (0.00 sec)
		
		# 远程克隆, 会先把数据库的数据删除.
		root@mysqldb 14:40:  [test_20191101]> select * from test_20191101.t1;
		ERROR 1049 (42000): Unknown database 'test_20191101'

		
		查看数据是否有同步到从库:
			root@mysqldb 16:00:  [(none)]> select * from test_20191101.t1;
			+------+
			| a    |
			+------+
			|    1 |
			|    2 |
			|    3 |
			|    4 |
			|    5 |
			|    6 |
			+------+
			6 rows in set (0.00 sec)

		
3. 在远程克隆的基础上建立主从复制

	master 插入数据:		
		root@mysqldb 19:48:  [test_20191101]> insert into test_20191101.t1(a) values(7);
		Query OK, 1 row affected (0.01 sec)

	master 授权
			
		create user keepalived@'192.168.0.%' identified by '123456abc';
		grant replication slave on *.* to keepalived@'192.168.0.%';
		
	slave 建立连接:	
		change master to master_host='192.168.0.91', master_port=3306, master_user='keepalived', master_password='123456abc', master_auto_position=1;
		start slave;
		show slave status\G;
		
	验证增量数据同步:
		在从库查看 insert into test_20191101.t1(a) values(7); 这行记录是否有同步到从库
		root@mysqldb 16:04:  [(none)]> select * from test_20191101.t1;
		+------+
		| a    |
		+------+
		|    1 |
		|    2 |
		|    3 |
		|    4 |
		|    5 |
		|    6 |
		|    7 |
		+------+
		7 rows in set (0.00 sec)
		可以看到增量的数据已经同步到从库了.

4. 监控克隆操作
	1. 查看克隆进度:
		SELECT STAGE, STATE, END_TIME FROM performance_schema.clone_progress;
		
	2. 查看克隆是否出错:
	
		root@mysqldb 16:09:  [test_20191101]> SELECT STATE, ERROR_NO, ERROR_MESSAGE FROM performance_schema.clone_status;
		+-----------+----------+---------------+
		| STATE     | ERROR_NO | ERROR_MESSAGE |
		+-----------+----------+---------------+
		| Completed |        0 |               |
		+-----------+----------+---------------+
		1 row in set (0.00 sec)
		
5. 在远程克隆的基础上-MGR组复制加入新成员
	
	0. MGR 成员
		hostname    主机          端口号  通信端口号(server-id)    server_uuid                              role
		mgr01		192.168.0.55  3306   330655				      e136faa2-eeab-11e9-9494-080027cb3816       master
		mgr02       192.168.0.56  3306   330656                   5497bb23-a3c5-11e8-8f8f-080027d80ec1       slave
		mgr03       192.168.0.58  3306   330658                   8058ac83-a45d-11e8-a661-0800275004ea       通过 clone plugin 得到的 slave
	
	1. mgr03节点上安装组复制插件
		INSTALL PLUGIN group_replication SONAME 'group_replication.so';
		
	2. MGR主节点上的数据
		root@mysqldb 20:57:  [(none)]> select * from test_db.t;
		+----+------+------+
		| id | c    | d    |
		+----+------+------+
		|  0 |    0 |    0 |
		|  5 |    5 |    5 |
		| 10 |   10 |   10 |
		| 15 |   15 |   15 |
		| 20 |   20 |   20 |
		| 25 |   25 |   25 |
		+----+------+------+
		6 rows in set (0.00 sec)

	
	3. 确保捐赠者和接受者都安装了克隆插件

		INSTALL PLUGIN clone SONAME 'mysql_clone.so';

		root@mysqldb 23:25:  [(none)]> SELECT PLUGIN_NAME, PLUGIN_STATUS FROM INFORMATION_SCHEMA.PLUGINS WHERE PLUGIN_NAME LIKE 'clone';
		+-------------+---------------+
		| PLUGIN_NAME | PLUGIN_STATUS |
		+-------------+---------------+
		| clone       | ACTIVE        |
		+-------------+---------------+
		1 row in set (0.00 sec)



	4. 用户账号授权

		捐赠者授权
		
	
			mysql> CREATE USER clone_user_01@'192.168.0.%' IDENTIFIED by '123456abc';
			mysql> GRANT BACKUP_ADMIN ON *.* TO 'clone_user_01'@'192.168.0.%';         # BACKUP_ADMIN是MySQL8.0 才有的备份锁的权限
			
				
		接受者授权

			mysql> CREATE USER clone_user_01@'192.168.0.%' IDENTIFIED by '123456abc';
			mysql> GRANT CLONE_ADMIN ON *.* TO 'clone_user_01'@'192.168.0.%';
			
		CLONE_ADMIN权限 = BACKUP_ADMIN权限 + SHUTDOWN权限。SHUTDOWN仅限允许用户shutdown和restart mysqld。授权不同是因为，接受者需要restart mysqld。		
		
	5. 接受者设置捐赠者列表清单
		
		mysql> SET GLOBAL clone_valid_donor_list = '192.168.0.55:3306';
		
		接受者开始拉取克隆捐赠者数据

			CLONE INSTANCE FROM 'clone_user_01'@'192.168.0.55':3306 IDENTIFIED BY '123456abc';
			
			root@mysqldb 23:34:  [(none)]> CLONE INSTANCE FROM 'clone_user_01'@'192.168.0.55':3306 IDENTIFIED BY '123456abc';
			Query OK, 0 rows affected (32.98 sec)

	
	6. 监控远程克隆
		root@mysqldb 00:08:  [(none)]> SELECT STAGE, STATE, END_TIME FROM performance_schema.clone_progress;
		+-----------+-----------+----------------------------+
		| STAGE     | STATE     | END_TIME                   |
		+-----------+-----------+----------------------------+
		| DROP DATA | Completed | 2019-11-16 00:01:21.231015 |
		| FILE COPY | Completed | 2019-11-16 00:01:43.891716 |
		| PAGE COPY | Completed | 2019-11-16 00:01:44.193331 |
		| REDO COPY | Completed | 2019-11-16 00:01:44.496438 |
		| FILE SYNC | Completed | 2019-11-16 00:01:56.843876 |
		| RESTART   | Completed | 2019-11-16 00:07:53.698291 |
		| RECOVERY  | Completed | 2019-11-16 00:07:55.453625 |
		+-----------+-----------+----------------------------+
		7 rows in set (0.01 sec)
		
		root@mysqldb 00:11:  [(none)]> SELECT STATE, ERROR_NO, ERROR_MESSAGE FROM performance_schema.clone_status;
		+-----------+----------+---------------+
		| STATE     | ERROR_NO | ERROR_MESSAGE |
		+-----------+----------+---------------+
		| Completed |        0 |               |
		+-----------+----------+---------------+
		1 row in set (0.01 sec)

		

	7. 已有节点修改参数：

		已有节点修改参数： set global group_replication_group_seeds="192.168.0.55:53306,192.168.0.56:63306,192.168.0.58:83306"; 
        并修改配置文件：   group_replication_group_seeds="192.168.0.55:53306,192.168.0.56:63306,192.168.0.58:83306"; 

			
	8. 新节点加入
		root@mysqldb 00:17:  [(none)]> start group_replication;
		Query OK, 0 rows affected (4.70 sec)


		root@mysqldb 00:18:  [(none)]> select * from performance_schema.replication_group_members;
		+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
		| CHANNEL_NAME              | MEMBER_ID                            | MEMBER_HOST | MEMBER_PORT | MEMBER_STATE | MEMBER_ROLE | MEMBER_VERSION |
		+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
		| group_replication_applier | 5497bb23-a3c5-11e8-8f8f-080027d80ec1 | mgr02       |        3306 | ONLINE       | SECONDARY   | 8.0.18         |
		| group_replication_applier | a6b6670d-07c0-11ea-a385-080027c52883 | mgr03       |        3306 | ONLINE       | SECONDARY   | 8.0.18         |
		| group_replication_applier | e136faa2-eeab-11e9-9494-080027cb3816 | mgr01       |        3306 | ONLINE       | PRIMARY     | 8.0.18         |
		+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
		3 rows in set (0.02 sec)


	9. 验证增量数据同步
		mgr01
			root@mysqldb 21:50:  [(none)]> use test_db;
			Database changed
			root@mysqldb 21:50:  [test_db]> INSERT INTO `test_db`.`t` (`id`, `c`, `d`) VALUES ('30', '30', '30');
			Query OK, 1 row affected (0.01 sec)

		mgr03
			root@mysqldb 00:18:  [(none)]>  select * from test_db.t;
			+----+------+------+
			| id | c    | d    |
			+----+------+------+
			|  0 |    0 |    0 |
			|  5 |    5 |    5 |
			| 10 |   10 |   10 |
			| 15 |   15 |   15 |
			| 20 |   20 |   20 |
			| 25 |   25 |   25 |
			| 30 |   30 |   30 |
			+----+------+------+
			7 rows in set (0.00 sec)

			
	10. 注意事项

		10.1 现象1-克隆由于重新启动失败需要自动关闭MySQL服务器
			
				现象	
					root@mysqldb 00:01:  [(none)]> CLONE INSTANCE FROM 'clone_user_01'@'192.168.0.55':3306 IDENTIFIED BY '123456abc';
					ERROR 3707 (HY000): Restart server failed (mysqld is not managed by supervisor process).
					# 克隆由于重新启动失败而关闭MySQL服务器, 需要手工开启MySQL 
					
					root@mysqldb 00:01:  [(none)]> SELECT STAGE, STATE, END_TIME FROM performance_schema.clone_progress;
					ERROR 1053 (08S01): Server shutdown in progress
					root@mysqldb 00:01:  [(none)]> SELECT STAGE, STATE, END_TIME FROM performance_schema.clone_progress;
					ERROR 2006 (HY000): MySQL server has gone away
					No connection. Trying to reconnect...
					ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/tmp/mysql.sock' (2)
					ERROR: 
					Can't connect to the server
					

				错误日志
					2019-11-15T16:00:17.762998Z 10 [Warning] [MY-013460] [InnoDB] Clone removing all user data for provisioning: Started
					2019-11-15T16:00:18.068434Z 10 [Warning] [MY-013460] [InnoDB] Clone removing all user data for provisioning: Finished
					2019-11-15T16:01:12.744222Z 10 [ERROR] [MY-011685] [Repl] Plugin group_replication reported: 'The group name option is mandatory'
					2019-11-15T16:01:12.744274Z 10 [ERROR] [MY-011660] [Repl] Plugin group_replication reported: 'Unable to start Group Replication on boot'
					2019-11-15T16:01:20.871111Z 10 [Warning] [MY-013460] [InnoDB] Clone removing all user data for provisioning: Started
					2019-11-15T16:01:21.089343Z 10 [Warning] [MY-013460] [InnoDB] Clone removing all user data for provisioning: Finished
					 100 200 300 400 500 600 700 800 900 1000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000
					 100 200 300 400 500 600 700 800 900 1000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000
					2019-11-15T16:01:56.845063Z 10 [ERROR] [MY-013462] [Server] Clone shutting down server as RESTART failed. Please start server to complete clone operation.
					2019-11-15T16:01:59.811173Z 0 [Warning] [MY-010909] [Server] /usr/local/mysql/bin/mysqld: Forcing close of thread 10  user: 'root'.
					2019-11-15T16:02:00.473355Z 0 [System] [MY-010910] [Server] /usr/local/mysql/bin/mysqld: Shutdown complete (mysqld 8.0.18)  MySQL Community Server - GPL.
					[root@mgr03 data]# 
					
				[root@mgr03 ~]# ps aux|grep mysqld
				root     19246  0.0  0.0 112704   972 pts/6    R+   00:07   0:00 grep --color=auto mysqld
				
				解决办法:
					开启MySQL
					[root@mgr03 ~]# /etc/init.d/mysql start
					Starting MySQL..... SUCCESS! 

					root@mysqldb 00:08:  [(none)]> SELECT STAGE, STATE, END_TIME FROM performance_schema.clone_progress;
					+-----------+-----------+----------------------------+
					| STAGE     | STATE     | END_TIME                   |
					+-----------+-----------+----------------------------+
					| DROP DATA | Completed | 2019-11-16 00:01:21.231015 |
					| FILE COPY | Completed | 2019-11-16 00:01:43.891716 |
					| PAGE COPY | Completed | 2019-11-16 00:01:44.193331 |
					| REDO COPY | Completed | 2019-11-16 00:01:44.496438 |
					| FILE SYNC | Completed | 2019-11-16 00:01:56.843876 |
					| RESTART   | Completed | 2019-11-16 00:07:53.698291 |
					| RECOVERY  | Completed | 2019-11-16 00:07:55.453625 |
					+-----------+-----------+----------------------------+
					7 rows in set (0.00 sec)
					
		10.2 现象2-使用clone plugin 远程克隆导致MySQL不可用
		
				MySQL不可用的情况如下
					root@mysqldb 23:34:  [(none)]> SELECT STAGE, STATE, END_TIME FROM performance_schema.clone_progress;
					+-----------+-------------+----------------------------+
					| STAGE     | STATE       | END_TIME                   |
					+-----------+-------------+----------------------------+
					| DROP DATA | Completed   | 2019-11-15 23:34:09.920695 |
					| FILE COPY | Completed   | 2019-11-15 23:34:34.923770 |
					| PAGE COPY | Completed   | 2019-11-15 23:34:35.336979 |
					| REDO COPY | In Progress | NULL                       |
					| FILE SYNC | Not Started | NULL                       |
					| RESTART   | Not Started | NULL                       |
					| RECOVERY  | Not Started | NULL                       |
					+-----------+-------------+----------------------------+
					7 rows in set (0.04 sec)

					root@mysqldb 23:34:  [(none)]> SELECT STAGE, STATE, END_TIME FROM performance_schema.clone_progress;
					No connection. Trying to reconnect...
					ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/tmp/mysql.sock' (2)
					ERROR: 
					Can't connect to the server
				
					
					[root@mgr03 data]# ps aux|grep mysqld
					root     15402  0.0  0.0 113304   804 pts/6    S    23:24   0:00 /bin/sh /usr/local/mysql/bin/mysqld_safe --datadir=/data/mysql/mysql3306/data/ --pid-file=/data/mysql/mysql3306/data//mysqldb.pid
					mysql    17123 97.3 78.5 3511908 798016 pts/6  Sl   23:34  12:02 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/data/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=/data/mysql/mysql3306/data/error.log --open-files-limit=65535 --pid-file=/data/mysql/mysql3306/data//mysqldb.pid --socket=/tmp/mysql.sock --port=3306
					root     17234  0.0  0.0 112704   976 pts/4    R+   23:47   0:00 grep --color=auto mysqld


					[root@mgr03 ~]# mysql -uroot -p123456abc
					mysql: [Warning] Using a password on the command line interface can be insecure.
					ERROR 2002 (HY000): Can t connect to local MySQL server through socket '/tmp/mysql.sock' (2)

					
				查看错误日志error.log
					2019-11-15T15:36:08.029954Z 1 [ERROR] [MY-011971] [InnoDB] Tablespace 'innodb_undo_012' Page [page id: space=4294967268, page number=96] log sequence number 1005312298 is in the future! Current system log sequence number 22550628.
					2019-11-15T15:36:08.048211Z 1 [ERROR] [MY-011972] [InnoDB] Your database may be corrupt or you may have copied the InnoDB tablespace but not the InnoDB log files. Please refer to http://dev.mysql.com/doc/refman/8.0/en/forcing-innodb-recovery.html for information about forcing recovery.
					...................................................................................................
					...................................................................................................
					...................................................................................................
					2019-11-15T15:45:54.671853Z 1 [ERROR] [MY-011971] [InnoDB] Tablespace 'innodb_undo_033' Page [page id: space=4294967247, page number=414] log sequence number 1010167922 is in the future! Current system log sequence number 22550628.
					2019-11-15T15:45:54.733151Z 1 [ERROR] [MY-011972] [InnoDB] Your database may be corrupt or you may have copied the InnoDB tablespace but not the InnoDB log files. Please refer to http://dev.mysql.com/doc/refman/8.0/en/forcing-innodb-recovery.html for information about forcing recovery.
					2019-11-15T15:45:54.795283Z 1 [ERROR] [MY-011971] [InnoDB] Tablespace 'innodb_undo_033' Page [page id: space=4294967247, page number=27] log sequence number 1010167981 is in the future! Current system log sequence number 22550628.
					2019-11-15T15:45:54.852104Z 1 [ERROR] [MY-011972] [InnoDB] Your database may be corrupt or you may have copied the InnoDB tablespace but not the InnoDB log files. Please refer to http://dev.mysql.com/doc/refman/8.0/en/forcing-innodb-recovery.html for information about forcing recovery.
					2019-11-15T15:45:54.914596Z 1 [ERROR] [MY-011971] [InnoDB] Tablespace 'innodb_undo_033' Page [page id: space=4294967247, page number=180] log sequence number 1008073911 is in the future! Current system log sequence number 22550628.
					2019-11-15T15:45:54.976609Z 1 [ERROR] [MY-011972] [InnoDB] Your database may be corrupt or you may have copied the InnoDB tablespace but not the InnoDB log files. Please refer to http://dev.mysql.com/doc/refman/8.0/en/forcing-innodb-recovery.html for information about forcing recovery.
					2019-11-15T15:45:55.054296Z 1 [ERROR] [MY-011971] [InnoDB] Tablespace 'innodb_undo_033' Page [page id: space=4294967247, page number=246] log sequence number 1010167981 is in the future! Current system log sequence number 22550628.
					2019-11-15T15:45:55.109169Z 1 [ERROR] [MY-011972] [InnoDB] Your database may be corrupt or you may have copied the InnoDB tablespace but not the InnoDB log files. Please refer to http://dev.mysql.com/doc/refman/8.0/en/forcing-innodb-recovery.html for information about forcing recovery.
					2019-11-15T15:45:55.172399Z 1 [ERROR] [MY-011971] [InnoDB] Tablespace 'innodb_undo_033' Page [page id: space=4294967247, page number=28] log sequence number 1010168040 is in the future! Current system log sequence number 22550628.
					2019-11-15T15:45:55.234561Z 1 [ERROR] [MY-011972] [InnoDB] Your database may be corrupt or you may have copied the InnoDB tablespace but not the InnoDB log files. Please refer to http://dev.mysql.com/doc/refman/8.0/en/forcing-innodb-recovery.html for information about forcing recovery.
					2019-11-15T15:45:55.289924Z 1 [ERROR] [MY-011971] [InnoDB] Tablespace 'innodb_undo_033' Page [page id: space=4294967247, page number=182] log sequence number 1008138342 is in the future! Current system log sequence number 22550628.
					2019-11-15T15:45:55.351467Z 1 [ERROR] [MY-011972] [InnoDB] Your database may be corrupt or you may have copied the InnoDB tablespace but not the InnoDB log files. Please refer to http://dev.mysql.com/doc/refman/8.0/en/forcing-innodb-recovery.html for information about forcing recovery.
					2019-11-15T15:45:55.413398Z 1 [ERROR] [MY-011971] [InnoDB] Tablespace 'innodb_undo_033' Page [page id: space=4294967247, page number=415] log sequence number 1010168040 is in the future! Current system log sequence number 22550628.
					2019-11-15T15:45:55.468659Z 1 [ERROR] [MY-011972] [InnoDB] Your database may be corrupt or you may have copied the InnoDB tablespace but not the InnoDB log files. Please refer to http://dev.mysql.com/doc/refman/8.0/en/forcing-innodb-recovery.html for information about forcing recovery.
					2019-11-15T15:45:55.531647Z 1 [ERROR] [MY-011971] [InnoDB] Tablespace 'innodb_undo_033' Page [page id: space=4294967247, page number=29] log sequence number 1010168099 is in the future! Current system log sequence number 22550628.
					2019-11-15T15:45:55.592706Z 1 [ERROR] [MY-011972] [InnoDB] Your database may be corrupt or you may have copied the InnoDB tablespace but not the InnoDB log files. Please refer to http://dev.mysql.com/doc/refman/8.0/en/forcing-innodb-recovery.html for information about forcing recovery.
					2019-11-15T15:45:55.653015Z 1 [ERROR] [MY-011971] [InnoDB] Tablespace 'innodb_undo_033' Page [page id: space=4294967247, page number=184] log sequence number 1008202395 is in the future! Current system log sequence number 22550628.
					2019-11-15T15:45:55.710916Z 1 [ERROR] [MY-011972] [InnoDB] Your database may be corrupt or you may have copied the InnoDB tablespace but not the InnoDB log files. Please refer to http://dev.mysql.com/doc/refman/8.0/en/forcing-innodb-recovery.html for information about forcing recovery.
					2019-11-15T15:45:55.774333Z 1 [ERROR] [MY-011971] [InnoDB] Tablespace 'innodb_undo_033' Page [page id: space=4294967247, page number=416] log sequence number 1010168099 is in the future! Current system log sequence number 22550628.
					2019-11-15T15:45:55.834023Z 1 [ERROR] [MY-011972] [InnoDB] Your database may be corrupt or you may have copied the InnoDB tablespace but not the InnoDB log files. Please refer to http://dev.mysql.com/doc/refman/8.0/en/forcing-innodb-recovery.html for information about forcing recovery.
					2019-11-15T15:45:55.891658Z 1 [ERROR] [MY-011971] [InnoDB] Tablespace 'innodb_undo_033' Page [page id: space=4294967247, page number=30] log sequence number 1010168158 is in the future! Current system log sequence number 22550628.
					2019-11-15T15:45:55.954002Z 1 [ERROR] [MY-011972] [InnoDB] Your database may be corrupt or you may have copied the InnoDB tablespace but not the InnoDB log files. Please refer to http://dev.mysql.com/doc/refman/8.0/en/forcing-innodb-recovery.html for information about forcing recovery.
					2019-11-15T15:45:56.015139Z 1 [ERROR] [MY-011971] [InnoDB] Tablespace 'innodb_undo_033' Page [page id: space=4294967247, page number=186] log sequence number 1008266838 is in the future! Current system log sequence number 22550628.
					2019-11-15T15:45:56.071773Z 1 [ERROR] [MY-011972] [InnoDB] Your database may be corrupt or you may have copied the InnoDB tablespace but not the InnoDB log files. Please refer to http://dev.mysql.com/doc/refman/8.0/en/forcing-innodb-recovery.html for information about forcing recovery.
					2019-11-15T15:45:56.133970Z 1 [ERROR] [MY-011971] [InnoDB] Tablespace 'innodb_undo_033' Page [page id: space=4294967247, page number=417] log sequence number 1010168158 is in the future! Current system log sequence number 22550628.
					2019-11-15T15:45:56.193926Z 1 [ERROR] [MY-011972] [InnoDB] Your database may be corrupt or you may have copied the InnoDB tablespace but not the InnoDB log files. Please refer to http://dev.mysql.com/doc/refman/8.0/en/forcing-innodb-recovery.html for information about forcing recovery.
					2019-11-15T15:45:56.251342Z 1 [ERROR] [MY-011971] [InnoDB] Tablespace 'innodb_undo_033' Page [page id: space=4294967247, page number=31] log sequence number 1010168217 is in the future! Current system log sequence number 22550628.
					2019-11-15T15:45:56.313995Z 1 [ERROR] [MY-011972] [InnoDB] Your database may be corrupt or you may have copied the InnoDB tablespace but not the InnoDB log files. Please refer to http://dev.mysql.com/doc/refman/8.0/en/forcing-innodb-recovery.html for information about forcing recovery.


				原因: mgr03 跟 mgr01 的undo独立表空间数目不一致
					mgr03 节点在新搭建MySQL的时候配置了95个独立undo表空间(该实例前一段时间有8.0.12升级到8.0.18)
						[root@mgr03 undolog]# ll
						total 1203200
						-rw-r----- 1 mysql mysql 11534336 Nov 15 23:34 undo_001
						-rw-r----- 1 mysql mysql 12582912 Nov 15 23:34 undo_001.#clone_save
						-rw-r----- 1 mysql mysql 11534336 Nov 15 23:34 undo_002
						-rw-r----- 1 mysql mysql 12582912 Nov 15 23:34 undo_002.#clone_save
						-rw-r----- 1 mysql mysql 12582912 Nov 15 23:34 undo_003
						-rw-r----- 1 mysql mysql 12582912 Nov 15 23:23 undo_004
						-rw-r----- 1 mysql mysql 12582912 Nov 15 23:23 undo_005
						.......................................................
						.......................................................
						-rw-r----- 1 mysql mysql 12582912 Nov 15 16:42 undo_093
						-rw-r----- 1 mysql mysql 12582912 Nov 15 16:42 undo_094
						-rw-r----- 1 mysql mysql 12582912 Nov 15 16:42 undo_095
						
					mgr01
						[root@mgr01 undolog]# ll
						total 22528
						-rw-r-----. 1 mysql mysql 11534336 Oct 28 21:50 undo_001
						-rw-r-----. 1 mysql mysql 11534336 Oct 28 21:50 undo_002
				
				解决办法: 我在 mgr03 这一个节点上重建了MySQL.
				
6. 小结
	Clone Plugin 克隆插件确实非常方便, 可以通过命令的形式 本地克隆物理数据, 远程克隆物理数据,  从而很容易就可以实现 主从快速加入新节点, MGR快速加入组成员.

	