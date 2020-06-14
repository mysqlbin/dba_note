
1. 分库分表需求
2. 环境介绍
3. 安装和配置Mycat 
4. 创建数据库和表
5. 测试功能 	


1. 分库分表需求
	测试按天分片
		
2. 环境介绍
  
	3台物理机linux操作系统
	其中两台安装Mysql 5.7
	另一台安装Mycat

	主机        IP 地址           用途                分库分表模式                            分库分表规则
	mgr9        192.168.0.55      部署 Mycat           mycat: test1                           test1: 按天分片
 
	mycat01     192.168.0.201     分库分表             db1: test1, db2: test1	

	mycat02     192.168.0.202	  分库分表	           db1: test1
	
	mycat03     192.168.0.203	  分库分表	           db1: test1

		
3. 安装和配置Mycat 
	下载Mycat	
		http://dl.mycat.io/
		
		把 Mycat-server-1.6.7.4-release-20200105164103-linux.tar.gz 上传到 /usr/local/ 目录下
		
		tar zxvf Mycat-server-1.6.7.4-release-20200105164103-linux.tar.gz
		
	下载 JDK 并解压 到 /usr/local/ 目录下
		[root@mgr01 local]# pwd
		/usr/local
		[root@mgr01 local]# ll
		total 842384
		drwxr-xr-x.  2 root    root          215 Oct 21 03:45 bin
		drwxr-xr-x.  2 root    root            6 Nov  5  2016 etc
		drwxr-xr-x.  2 root    root            6 Nov  5  2016 games
		drwxr-xr-x.  2 root    root         4096 Nov 16  2018 include
		drwxr-xr-x.  7      10     143       245 Oct  5 18:13 java
		-rw-r--r--.  1 root    root    194151339 Dec 20  2019 jdk-8u231-linux-x64.tar.gz
		drwxr-xr-x. 12 root    root          274 Nov 16  2018 lib
		drwxr-xr-x.  2 root    root            6 Nov  5  2016 lib64
		drwxr-xr-x.  2 root    root            6 Nov  5  2016 libexec
		drwxr-xr-x.  5 root    root           42 Nov 16  2018 man
		drwxr-xr-x.  3 mongodb mongodb        91 Oct 11  2018 mongodb
		drwxr-xr-x.  7 root    root           85 Oct 27 23:08 mycat
		-rw-r--r--.  1 root    root     21760812 Mar 23  2020 Mycat-server-1.6.7.4-release-20200105164103-linux.tar.gz
		drwxr-xr-x. 11 mysql   mysql         194 Oct 14 11:55 mysql
		-rw-r--r--.  1 root    root    644930593 Nov 20  2018 mysql-5.7.24-linux-glibc2.12-x86_64.tar.gz-back
		drwxr-xr-x.  6 root    root           56 Dec  4  2018 python3
		drwxrwxr-x.  6 root    root         4096 Mar 27  2018 redis-4.0.9
		-rw-r--r--.  1 root    root      1737022 Nov 27  2018 redis-4.0.9.tar.gz
		drwxr-xr-x.  2 root    root            6 Nov  5  2016 sbin
		drwxr-xr-x.  5 root    root           49 Aug 15  2018 share
		drwxr-xr-x.  2 root    root            6 Nov  5  2016 src
		drwxr-xr-x. 13   15399   19249      4096 Sep 20  2013 tcl8.6.1

		
	cat /etc/profile
		export JAVA_HOME=/usr/local/java
		export JRE_HOME=/usr/local/java/jre
		export MYCAT_HOME=/usr/local/mycat
		export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin:/usr/local/mysql/bin:/usr/local/mongodb/bin:$JAVA_HOME/bin:$JRE_HOME/bin:$MYCAT_HOME/bin

	source /etc/profile	
		
	内存配置
		启动前，一般需要修改JVM配置参数，打开conf/wrapper.conf文件，如下行的内容为1G和512MB，可根据本机配置情况修改为512M或其它值。	
		
		wrapper.java.additional.9=-Xmx1G
		wrapper.java.additional.10=-Xms64m

	log4j.xml 日志模式为 debug
		<asyncRoot level="debug" includeLocation="true">

			<!--<AppenderRef ref="Console" />-->
			<AppenderRef ref="RollingFile"/>

		</asyncRoot>

		

	mycat 启动	
		shell> mycat start
		Starting Mycat-server...

		[root@mgr01 logs]# ps aux|grep mycat
		root     15896  0.0  0.0  17860   752 ?        Sl   23:41   0:00 /usr/local/mycat/bin/./wrapper-linux-x86-64 /usr/local/mycat/conf/wrapper.conf wrapper.syslog.ident=mycat wrapper.pidfile=/usr/local/mycat/logs/mycat.pid wrapper.daemonize=TRUE wrapper.lockfile=/var/lock/subsys/mycat
		root     15898  5.6  3.4 3125720 135612 ?      Sl   23:41   0:01 java -DMYCAT_HOME=. -server -XX:+AggressiveOpts -XX:MaxDirectMemorySize=2G -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=1984 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Xmx1G -Xms64m -Djava.library.path=lib -classpath lib/wrapper.jar:conf:lib/annotations-13.0.jar:lib/asm-4.0.jar:lib/commons-collections-3.2.1.jar:lib/commons-lang-2.6.jar:lib/curator-client-2.11.0.jar:lib/curator-framework-2.11.0.jar:lib/curator-recipes-2.11.0.jar:lib/disruptor-3.3.4.jar:lib/dom4j-1.6.1.jar:lib/druid-1.0.26.jar:lib/ehcache-core-2.6.11.jar:lib/fastjson-1.2.58.jar:lib/guava-19.0.jar:lib/hamcrest-core-1.3.jar:lib/hamcrest-library-1.3.jar:lib/jline-0.9.94.jar:lib/joda-time-2.9.3.jar:lib/jsr305-2.0.3.jar:lib/kotlin-stdlib-1.3.50.jar:lib/kotlin-stdlib-common-1.3.50.jar:lib/kryo-2.10.jar:lib/leveldb-0.7.jar:lib/leveldb-api-0.7.jar:lib/libwrapper-linux-ppc-64.so:lib/libwrapper-linux-x86-32.so:lib/libwrapper-linux-x86-64.so:lib/log4j-1.2-api-2.5.jar:lib/log4j-1.2.17.jar:lib/log4j-api-2.5.jar:lib/log4j-core-2.5.jar:lib/log4j-slf4j-impl-2.5.jar:lib/mapdb-1.0.7.jar:lib/minlog-1.2.jar:lib/mongo-java-driver-3.11.0.jar:lib/Mycat-server-1.6.7.4-release.jar:lib/mysql-binlog-connector-java-0.16.1.jar:lib/mysql-connector-java-5.1.35.jar:lib/netty-3.7.0.Final.jar:lib/netty-buffer-4.1.9.Final.jar:lib/netty-common-4.1.9.Final.jar:lib/objenesis-1.2.jar:lib/okhttp-4.2.2.jar:lib/okio-2.2.2.jar:lib/reflectasm-1.03.jar:lib/sequoiadb-driver-1.12.jar:lib/slf4j-api-1.6.1.jar:lib/univocity-parsers-2.2.1.jar:lib/velocity-1.7.jar:lib/wrapper.jar:lib/zookeeper-3.4.6.jar -Dwrapper.key=yXivjdLc03De7qZf -Dwrapper.port=32000 -Dwrapper.jvm.port.min=31000 -Dwrapper.jvm.port.max=31999 -Dwrapper.pid=15896 -Dwrapper.version=3.2.3 -Dwrapper.native_library=wrapper -Dwrapper.service=TRUE -Dwrapper.cpu.timeout=10 -Dwrapper.jvmid=1 org.tanukisoftware.wrapper.WrapperSimpleApp io.mycat.MycatStartup start
		root     15962  0.0  0.0 112704   976 pts/1    R+   23:41   0:00 grep --color=auto mycat

		
	授权			
		create user 'mycat_user'@'192.168.0.%' identified by '123456abc';
		grant all privileges on *.* to 'mycat_user'@'192.168.0.%' with grant option;
		
		create user 'root'@'192.168.0.%' identified by '123456abc';
		grant all privileges on *.* to 'root'@'192.168.0.%' with grant option;
		
		
	修改配置文件, 设置分库分表规则
		schema.xml
		
		server.xml
		
		rule.xml
	
4. 创建数据库和表

	192.168.0.201	
		create  database db1 DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;
		create  database db2 DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;
	
		use db1;
		CREATE TABLE test1 (  
			id INT NOT NULL AUTO_INCREMENT,  
			name varchar(50) NOT NULL default '', 
			`CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
			PRIMARY KEY (id)  
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;  
		
		use db2;
		CREATE TABLE test1 (  
			id INT NOT NULL AUTO_INCREMENT,  
			name varchar(50) NOT NULL default '',  
			`CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
			PRIMARY KEY (id)  
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
		

	192.168.0.202
		create  database db1 DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;
		use db1;
		CREATE TABLE test1 (  
			id INT NOT NULL AUTO_INCREMENT,  
			name varchar(50) NOT NULL default '', 
			`CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',		
			PRIMARY KEY (id)  
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;  
		
		
	192.168.0.203
		create  database db1 DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;
		use db1;
		CREATE TABLE test1 (  
			id INT NOT NULL AUTO_INCREMENT,  
			name varchar(50) NOT NULL default '', 
			`CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',		
			PRIMARY KEY (id)  
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;  
	
	
5. 测试功能 	
	5.1 开启mycat：	
	
		shell> mycat start	
		
		wrapper.log
		
		STATUS | wrapper  | 2019/10/28 16:52:51 | --> Wrapper Started as Daemon
		STATUS | wrapper  | 2019/10/28 16:52:51 | Launching a JVM...
		INFO   | jvm 1    | 2019/10/28 16:52:52 | Wrapper (Version 3.2.3) http://wrapper.tanukisoftware.org
		INFO   | jvm 1    | 2019/10/28 16:52:52 |   Copyright 1999-2006 Tanuki Software, Inc.  All Rights Reserved.
		INFO   | jvm 1    | 2019/10/28 16:52:52 | 
		INFO   | jvm 1    | 2019/10/28 16:52:53 | MyCAT Server startup successfully. see logs in logs/mycat.log

	5.2 在mycat所在主机登录mysql
	
		[root@mgr9 logs]# mysql -h127.0.01 -umycat_user -p123456abc -P8066
		mysql: [Warning] Using a password on the command line interface can be insecure.
		Welcome to the MySQL monitor.  Commands end with ; or \g.
		Your MySQL connection id is 1
		Server version: 5.6.29-mycat-1.6.7.4-release-20200105164103 MyCat Server (OpenCloudDB)

		Copyright (c) 2000, 2018, Oracle and/or its affiliates. All rights reserved.

		Oracle is a registered trademark of Oracle Corporation and/or its
		affiliates. Other names may be trademarks of their respective
		owners.

		Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

		mycat_user@mysqldb 09:17:  [(none)]> show databases;
		+----------+
		| DATABASE |
		+----------+
		| mycat_db |
		+----------+
		1 row in set (0.01 sec)

		mycat_user@mysqldb 09:17:  [(none)]> use mycat_db;
		Database changed
		mycat_user@mysqldb 09:17:  [mycat_db]> show tables;
		+--------------------+
		| Tables in mycat_db |
		+--------------------+
		| test1              |
		| test2              |
		+--------------------+
		2 rows in set (0.00 sec)

	
	5.3 写入数据
		INSERT INTO `test1` (`name`, `CreateTime`) VALUES ('lujb', '2020-03-01');
		INSERT INTO `test1` (`name`, `CreateTime`) VALUES ('lujb', '2020-03-11');
		INSERT INTO `test1` (`name`, `CreateTime`) VALUES ('lujb', '2020-03-22');
		
		INSERT INTO `test1` (`name`, `CreateTime`) VALUES ('lujb', '2020-04-01');
		INSERT INTO `test1` (`name`, `CreateTime`) VALUES ('lujb', '2020-04-11');
		INSERT INTO `test1` (`name`, `CreateTime`) VALUES ('lujb', '2020-04-22');

		INSERT INTO `test1` (`name`, `CreateTime`) VALUES ('lujb', '2020-05-01');
		INSERT INTO `test1` (`name`, `CreateTime`) VALUES ('lujb', '2020-05-11');
		INSERT INTO `test1` (`name`, `CreateTime`) VALUES ('lujb', '2020-05-22');
		
		INSERT INTO `test1` (`name`, `CreateTime`) VALUES ('lujb', '2020-06-01');
		INSERT INTO `test1` (`name`, `CreateTime`) VALUES ('lujb', '2020-06-11');
		INSERT INTO `test1` (`name`, `CreateTime`) VALUES ('lujb', '2020-06-22');
		
		
		INSERT INTO `test1` (`name`, `CreateTime`) VALUES ('lujb', '2020-06-23');
		
		
		INSERT INTO `test1` (`name`, `CreateTime`) VALUES ('lujb', '2020-06-24');
		INSERT INTO `test1` (`name`, `CreateTime`) VALUES ('lujb', '2020-06-25');
		INSERT INTO `test1` (`name`, `CreateTime`) VALUES ('lujb', '2020-06-26');
		
		INSERT INTO `test1` (`name`, `CreateTime`) VALUES ('lujb', '2020-05-23');
		
		INSERT INTO `test1` (`name`, `CreateTime`) VALUES ('lujb', '2020-07-01');
		
		mycat_user@mysqldb 04:29:  [mycat_db]> select count(*) from test1;
		+--------+
		| COUNT0 |
		+--------+
		|     18 |
		+--------+
		1 row in set (0.02 sec)

	5.4 登录分片节点查看数据

		192.168.0.201 
			select * from db1.test1;
			select * from db2.test1;
			
			root@mysqldb 12:27:  [(none)]> select * from db1.test1;
			+---------------------+------+---------------------+
			| ID                  | name | CreateTime          |
			+---------------------+------+---------------------+
			| 1242906948886728704 | lujb | 2020-03-01 00:00:00 |
			| 1242906949230661632 | lujb | 2020-04-11 00:00:00 |
			| 1242906949562011649 | lujb | 2020-05-22 00:00:00 |
			| 1242911408245575680 | lujb | 2020-05-23 00:00:00 |
			| 1242911967149166593 | lujb | 2020-07-01 00:00:00 |
			+---------------------+------+---------------------+
			5 rows in set (0.00 sec)

			root@mysqldb 12:10:  [(none)]> select * from db2.test1;
			+---------------------+------+---------------------+
			| ID                  | name | CreateTime          |
			+---------------------+------+---------------------+
			| 1242906948958031873 | lujb | 2020-03-11 00:00:00 |
			| 1242906949297770496 | lujb | 2020-04-22 00:00:00 |
			| 1242906949616537600 | lujb | 2020-06-01 00:00:00 |
			+---------------------+------+---------------------+
			3 rows in set (0.00 sec)
					 
			
		192.168.0.202 
			root@mysqldb 11:22:  [(none)]> select * from db1.test1;
			+---------------------+------+---------------------+
			| ID                  | name | CreateTime          |
			+---------------------+------+---------------------+
			| 1242906949008363521 | lujb | 2020-03-22 00:00:00 |
			| 1242906949356490752 | lujb | 2020-05-01 00:00:00 |
			| 1242906949658480640 | lujb | 2020-06-11 00:00:00 |
			+---------------------+------+---------------------+
			3 rows in set (0.00 sec)
			
		192.168.0.203	
			root@mysqldb 15:03:  [(none)]> select * from db1.test1;
			+---------------------+------+---------------------+
			| ID                  | name | CreateTime          |
			+---------------------+------+---------------------+
			| 1242906949067083777 | lujb | 2020-04-01 00:00:00 |
			| 1242906949415211008 | lujb | 2020-05-11 00:00:00 |
			| 1242906951847907328 | lujb | 2020-06-22 00:00:00 |
			| 1242911052308549632 | lujb | 2020-06-23 00:00:00 |
			| 1242911255765848064 | lujb | 2020-06-24 00:00:00 |
			| 1242911255916843008 | lujb | 2020-06-25 00:00:00 |
			| 1242911256508239873 | lujb | 2020-06-26 00:00:00 |
			+---------------------+------+---------------------+
			7 rows in set (0.00 sec)


	
