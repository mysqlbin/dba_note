
community server 社会服务(社区版)

1.安装支持软件包
	yum -y install openssl-devel libcurl
	

2. 上传安装包并解压文件
	cd /usr/local/
	
	tar xvf mongodb-linux-x86_64-rhel70-4.2.7.tgz
	
	mv mongodb-linux-x86_64-rhel70-4.2.7 mongodb

3. 创建目录（数据目录、日志目录、PID文件目录）
	
	mkdir -p /home/mongodb/{data,log,run}

	
4. 创建 mongodb 用户

	groupadd mongodb
	useradd -g mongodb mongodb
	chown -R mongodb:mongodb /usr/local/mongodb
	chown -R mongodb:mongodb  /home/mongodb
	#chown -R mongodb:mongodb  /etc/mongodb.conf
		
5. 添加环境变量
	

	vim /etc/profile
	export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin:/usr/local/mysql/bin:/usr/local/mongodb/bin


6. 启动mongod（命令行选项模式）
	
	需要切换 mongodb 用户账号启动mongodb,先修改/etc/passwd文件允许mongodb可登录
	
	vim /etc/passwd            #
	
	mongodb:x:1018:1018::/usr/local/mongodb:/bin/bash   #修改mongodb可登录系统,把/sbin/nologin改成/bin/bash即可登录
	
	su - mongodb										#切换mongodb用户
		
	mongod -f /etc/mongodb.conf 
	
	
	about to fork child process, waiting until server is ready for connections.
	forked process: 1270
	child process started successfully, parent exiting



7. 查看mongod进程 ：
	[root@mgr9 local]# netstat -antpl | grep mongo
	tcp        0      0 127.0.0.1:27017         0.0.0.0:*               LISTEN      3391/mongod 

	[root@mgr9 local]# ps aux|grep mongo
	

8. 连接mongodb

	shell> mongo -host IP 地址 

9.配置mongodb.service启动服务
注：如用命令启动，则先用命令停止，否则用service服务启动不了
	
把 mongodb.service 文件上传到 /lib/systemd/system 目录下
	vim  /lib/systemd/system/mongodb.service
	chmod 754 mongodb.service
	
	service mongodb stop
	service mongodb status
	service mongodb start
	service mongodb restart
	

10. 配置密码
	
	use admin
	db.createUser(
	  {
		user: "admin",
		pwd: "admin",
		roles: [ { role: "root", db: "admin" } ]
	  }
	)
		
	修改配置文件，添加一行： auth = true

	登录
		service mongodb restart
		mongo admin -u admin  -p admin
		mongo -host 192.168.0.201 -u admin -p admin
		mongo -host 192.168.0.202 -u admin -p admin
		mongo -host 192.168.0.203 -u admin -p admin

-----------------------------------------------------------------------------


		