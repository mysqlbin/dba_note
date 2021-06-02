

mongos 的配置
	
	-rw-r--r--. 1 root root 409 5月  31 08:54 router.conf
	[root@localhost conf]# cat router.conf 


	systemLog:
	  destination: file
	  logAppend: true
	  path: /home/mongodb/router/log/mongos.log
	# network interfaces

	net:
	  port: 20000
	  # 允许所有连接
	  bindIp: 0.0.0.0
	# how the process runs
	processManagement:
	  fork: true

	#监听的配置服务器,只能有1个或者3个 config 为配置服务器的副本集名字
	sharding:
	  configDB: configserver/192.168.0.201:21000
	  
	
config server的配置
		
	IP			   	 		   		

	192.168.0.201			config: 21000主节点  	     
	192.168.0.202 			config: 21000副节点
	192.168.0.203			config: 21000副节点	