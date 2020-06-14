
0. 原理
1. 环境
2. 安装Consul
3. Consul配置和启动
4. 查看Consul集群状态		
5. 主节点和从节点检查脚本
6. Consul client端服务发现的json脚本  #这个步骤开始进行服务注册 Consul客户端都要有
7. Consul client端执行consul reload命令重新加载配置
8. 使用dns来解析
9. ping 域名
10. 故障测试
11. dns的问题
12. 相关参考
13. 思考 
	12.1 consul是否可以做读写分离
	12.2 consul 配置文件的含义
14. 小结
	
0. 原理
	基于Consul的DNS接入
	利用mgr+consul实现高可用及故障自动切换。
	Consul的作用之一用来做服务发现的 
	举例: 
		利用mgr+consul实现高可用及故障自动切换。	
		当MGR发生主库故障, 从库升级为新主库的过程, Consul是可以发现这个MGR故障转换的服务, 体现了 服务发现的概念
		从而实现应用端通过动态 DNS(域名) 访问MGR集群，实现数据库高可用，故障自动切换的方案
		mgr+consul也可以做为读写分离的方案, 从挂掉一个或者多个也不会影响服务。
		服务发现 Consul的客户端可用提供一个服务,
		比如 api 或者mysql ,另外一些客户端可用使用Consul去发现一个指定服务的提供者.通过DNS或者HTTP应用程序可用很容易的找到他所依赖的服务.
		
	读写分离的工具:
		proxysql mycat consul
		
1. 环境
	consul server：
	ip              hostname
	192.168.0.54    mgr09

	consul client：
	ip                hostname
	192.168.0.55      mgr01
	192.168.0.56	  mgr02 	
	192.168.0.58      mgr03
		
2. 安装Consul
	
	需要服务发现的机器都需要安装consul客户端，也就是3台服务器都需要安装
	文件下载以后解压放到/usr/local/bin。就可以使用了。不依赖任何东西。上面的4台服务器都安装。
	4台机器都创建目录，分别是放配置文件，以及存放数据的。以及存放redis，mysql的健康检查脚本
	mkdir /etc/consul.d/ -p && mkdir /data/consul/ -p
	mkdir /data/consul/shell -p

3. Consul server 和 agent 的配置和启动


	然后把相关配置参数写入配置文件，其实也可以不用写，直接跟在命令后面就行，那样不方便管理。
	consul server（192.168.0.54）配置文件（具体参数的意思请查询官网或者文章给的参考链接）：

	1. server 配置
		[root@mgr9 consul.d]# pwd
		/etc/consul.d
		[root@mgr9 consul.d]# ll
		total 4
		-rw-r--r-- 1 root root 207 Nov  8  2019 server.json


	2. agent 配置
		[root@mha03 consul.d]# pwd
		/etc/consul.d

		[root@mha03 consul.d]# ll
		total 4
		-rw-r--r--. 1 root root 231 Nov  8 14:37 client.json


	3. 下面我们先启动consul server

		nohup consul agent -config-dir=/etc/consul.d > /data/consul/consul.log &
		
		查看日志：	

			[root@mgr9 bin]# cat /data/consul/consul.log 
			BootstrapExpect is set to 1; this is the same as Bootstrap mode.
			bootstrap = true: do not enable unless necessary
			==> Starting Consul agent...
					   Version: 'v1.6.1'
					   Node ID: '03b4f212-e2bf-0be9-d460-1e48192b1f3e'
					 Node name: 'mgr9'
					Datacenter: 'dc1' (Segment: '<all>')
						Server: true (Bootstrap: true)
				   Client Addr: [192.168.0.54] (HTTP: 8500, HTTPS: -1, gRPC: -1, DNS: 8600)
				  Cluster Addr: 192.168.0.54 (LAN: 8301, WAN: 8302)
					   Encrypt: Gossip: false, TLS-Outgoing: false, TLS-Incoming: false, Auto-Encrypt-TLS: false

			==> Log data will now stream in as it occurs:

				2019/10/30 02:37:17 [INFO]  raft: Initial configuration (index=1): [{Suffrage:Voter ID:03b4f212-e2bf-0be9-d460-1e48192b1f3e Address:192.168.0.54:8300}]
				2019/10/30 02:37:17 [INFO] serf: EventMemberJoin: mgr9.dc1 192.168.0.54
				2019/10/30 02:37:17 [INFO] serf: EventMemberJoin: mgr9 192.168.0.54
				2019/10/30 02:37:17 [INFO] agent: Started DNS server 192.168.0.54:8600 (udp)
				2019/10/30 02:37:17 [INFO]  raft: Node at 192.168.0.54:8300 [Follower] entering Follower state (Leader: "")
				2019/10/30 02:37:17 [INFO] consul: Adding LAN server mgr9 (Addr: tcp/192.168.0.54:8300) (DC: dc1)
				2019/10/30 02:37:17 [INFO] consul: Handled member-join event for server "mgr9.dc1" in area "wan"
				2019/10/30 02:37:17 [INFO] agent: Started DNS server 192.168.0.54:8600 (tcp)
				2019/10/30 02:37:17 [INFO] agent: Started HTTP server on 192.168.0.54:8500 (tcp)
				2019/10/30 02:37:17 [INFO] agent: started state syncer
			==> Consul agent running!
				2019/10/30 02:37:25 [ERR] agent: failed to sync remote state: No cluster leader
				2019/10/30 02:37:27 [WARN]  raft: Heartbeat timeout from "" reached, starting election
				2019/10/30 02:37:27 [INFO]  raft: Node at 192.168.0.54:8300 [Candidate] entering Candidate state in term 2
				2019/10/30 02:37:27 [INFO]  raft: Election won. Tally: 1
				2019/10/30 02:37:27 [INFO]  raft: Node at 192.168.0.54:8300 [Leader] entering Leader state
				2019/10/30 02:37:27 [INFO] consul: cluster leadership acquired
				2019/10/30 02:37:27 [INFO] consul: New leader elected: mgr9
				2019/10/30 02:37:27 [INFO] consul: member 'mgr9' joined, marking health alive
				2019/10/30 02:37:29 [INFO] agent: Synced node info

			可以从日志中看到(HTTP: 8500, HTTPS: -1, DNS: 8600)，http端口默认8500，在reload以及web ui会用到，dns端口是8600，在使用dns解析的时候会用到。
			还可以看到这台机器就是leader，consul: New leader elected: mgr9。因为只有一台机器。所以生产环境一定要3个或者5个server做集群.
			
			
		 
	4 启动3台client
		下面启动3台client，3台client启动命令是一样的。然后查看其中一台client的日志：

			nohup consul agent -config-dir=/etc/consul.d > /data/consul/consul.log &
		
		然后查看其中一台client的日志：
			[root@mgr01 undolog]# tail -f /data/consul/consul.log

			tail: /data/consul/consul.log: file truncated
			==> Starting Consul agent...
					   Version: 'v1.6.1'
					   Node ID: 'b594a62b-bead-c7bc-5cea-cffa579ab536'
					 Node name: 'mgr01'
					Datacenter: 'dc1' (Segment: '')
						Server: false (Bootstrap: false)
				   Client Addr: [127.0.0.1] (HTTP: 8500, HTTPS: -1, gRPC: -1, DNS: 8600)
				  Cluster Addr: 192.168.0.55 (LAN: 8301, WAN: 8302)
					   Encrypt: Gossip: false, TLS-Outgoing: false, TLS-Incoming: false, Auto-Encrypt-TLS: false

			==> Log data will now stream in as it occurs:

				2019/10/29 13:16:14 [INFO] serf: Ignoring previous leave in snapshot
				2019/10/29 13:16:14 [INFO] serf: Ignoring previous leave in snapshot
				2019/10/29 13:16:14 [INFO] serf: Ignoring previous leave in snapshot
				2019/10/29 13:16:14 [INFO] serf: EventMemberJoin: mgr01 192.168.0.55
				2019/10/29 13:16:14 [INFO] agent: Started DNS server 127.0.0.1:8600 (udp)
				2019/10/29 13:16:14 [INFO] serf: Attempting re-join to previously known node: mgr9: 192.168.0.54:8301
				2019/10/29 13:16:14 [INFO] agent: Started DNS server 127.0.0.1:8600 (tcp)
				2019/10/29 13:16:14 [INFO] agent: Started HTTP server on 127.0.0.1:8500 (tcp)
			==> Joining cluster...
				2019/10/29 13:16:14 [INFO] agent: (LAN) joining: [192.168.0.54]
				2019/10/29 13:16:14 [INFO] agent: Retry join LAN is supported for: aliyun aws azure digitalocean gce k8s mdns os packet scaleway softlayer triton vsphere
				2019/10/29 13:16:14 [INFO] agent: Joining LAN cluster...
				2019/10/29 13:16:14 [INFO] agent: (LAN) joining: [192.168.0.54]
				2019/10/29 13:16:14 [INFO] serf: EventMemberJoin: mgr9 192.168.0.54
				2019/10/29 13:16:14 [INFO] agent: (LAN) joined: 1
				Join completed. Synced with 1 initial agents
				2019/10/29 13:16:14 [INFO] agent: started state syncer
			==> Consul agent running!
				2019/10/29 13:16:14 [INFO] consul: adding server mgr9 (Addr: tcp/192.168.0.54:8300) (DC: dc1)
				2019/10/29 13:16:14 [INFO] serf: Re-joined to previously known node: mgr9: 192.168.0.54:8301
				2019/10/29 13:16:14 [INFO] agent: (LAN) joined: 1
				2019/10/29 13:16:14 [INFO] agent: Join LAN completed. Synced with 1 initial agents
				2019/10/29 13:16:14 [INFO] agent: Synced service "mgr-3306-write"
				2019/10/29 13:16:14 [INFO] agent: Synced service "mgr-3306-read"
				2019/10/29 13:16:15 [INFO] agent: Synced check "service:mgr-3306-write"
				2019/10/29 13:16:26 [WARN] agent: Check "service:mgr-3306-read" is now critical
				
				可以看到提示 agent: Join completed. Synced with 1 initial agents，以及 Server: false (bootstrap: false)。这也是client和server的区别。
				
		5. 查看3个client是否自动注册到了consul上了
				[root@mgr03 consul]# cat /data/consul/consul.log
				==> Starting Consul agent...
						   Version: 'v1.6.1'
						   Node ID: '501ddc9f-024f-2d9e-0ebd-26d3118b4fe2'
						 Node name: 'mgr03'
						Datacenter: 'dc1' (Segment: '')
							Server: false (Bootstrap: false)
					   Client Addr: [127.0.0.1] (HTTP: 8500, HTTPS: -1, gRPC: -1, DNS: 8600)
					  Cluster Addr: 192.168.0.58 (LAN: 8301, WAN: 8302)
						   Encrypt: Gossip: false, TLS-Outgoing: false, TLS-Incoming: false, Auto-Encrypt-TLS: false

				==> Log data will now stream in as it occurs:

					2019/11/16 15:58:50 [INFO] serf: Ignoring previous leave in snapshot
					2019/11/16 15:58:50 [INFO] serf: EventMemberJoin: mgr03 192.168.0.58
					2019/11/16 15:58:50 [INFO] agent: Started DNS server 127.0.0.1:8600 (udp)
					2019/11/16 15:58:50 [INFO] serf: Attempting re-join to previously known node: mgr9: 192.168.0.54:8301
					2019/11/16 15:58:50 [INFO] agent: Started DNS server 127.0.0.1:8600 (tcp)
					2019/11/16 15:58:50 [INFO] agent: Started HTTP server on 127.0.0.1:8500 (tcp)
				==> Joining cluster...
					2019/11/16 15:58:50 [INFO] agent: (LAN) joining: [192.168.0.54]
					2019/11/16 15:58:50 [INFO] agent: Retry join LAN is supported for: aliyun aws azure digitalocean gce k8s mdns os packet scaleway softlayer triton vsphere
					2019/11/16 15:58:50 [INFO] agent: Joining LAN cluster...
					2019/11/16 15:58:50 [INFO] agent: (LAN) joining: [192.168.0.54]
					2019/11/16 15:58:50 [INFO] serf: EventMemberJoin: mgr02 192.168.0.56
					2019/11/16 15:58:50 [INFO] serf: EventMemberJoin: mgr9 192.168.0.54
					2019/11/16 15:58:50 [INFO] serf: EventMemberJoin: mgr01 192.168.0.55
					2019/11/16 15:58:50 [INFO] agent: (LAN) joined: 1
					Join completed. Synced with 1 initial agents
					2019/11/16 15:58:50 [INFO] agent: started state syncer
				==> Consul agent running!
					2019/11/16 15:58:50 [INFO] consul: adding server mgr9 (Addr: tcp/192.168.0.54:8300) (DC: dc1)
					2019/11/16 15:58:50 [INFO] serf: Re-joined to previously known node: mgr9: 192.168.0.54:8301
					2019/11/16 15:58:50 [INFO] agent: (LAN) joined: 1
					2019/11/16 15:58:50 [INFO] agent: Join LAN completed. Synced with 1 initial agents
					2019/11/16 15:58:50 [INFO] agent: Synced service "mgr-3306-write"
					2019/11/16 15:58:50 [INFO] agent: Synced service "mgr-3306-read"
					2019/11/16 15:58:58 [INFO] agent: Synced check "service:mgr-3306-read"
					2019/11/16 15:59:00 [WARN] agent: Check "service:mgr-3306-write" is now critical
				==> Newer Consul version available: 1.7.2 (currently running: 1.6.1)
					2019/11/16 15:59:15 [WARN] agent: Check "service:mgr-3306-write" is now critical
					2019/11/16 15:59:30 [WARN] agent: Check "service:mgr-3306-write" is now critical
					2019/11/16 15:59:45 [WARN] agent: Check "service:mgr-3306-write" is now critical
					2019/11/16 16:00:00 [WARN] agent: Check "service:mgr-3306-write" is now critical

					
				192.168.0.54  192.168.0.56  192.168.0.58 这3个client自动注册到了consul上了
		


4. 查看Consul集群状态 	
	
	4.1 继续执行命令看一下集群：
	
		[root@mgr9 consul.d]# consul members
		Error retrieving members: Get http://127.0.0.1:8500/v1/agent/members?segment=_all: dial tcp 127.0.0.1:8500: connect: connection refused

		[root@mgr9 consul]# consul members --http-addr 192.168.0.54:8500
		Node   Address            Status  Type    Build  Protocol  DC   Segment
		mgr9   192.168.0.54:8301  alive   server  1.6.1  2         dc1  <all>
		mgr01  192.168.0.55:8301  alive   client  1.6.1  2         dc1  <default>
		mgr02  192.168.0.56:8301  alive   client  1.6.1  2         dc1  <default>
		mgr03  192.168.0.58:8301  alive   client  1.6.1  2         dc1  <default>

		[root@mgr9 consul]# consul members
		Error retrieving members: Get http://127.0.0.1:8500/v1/agent/members?segment=_all: dial tcp 127.0.0.1:8500: connect: connection refused
	
		[root@mgr01 consul.d]# consul members
		Node   Address            Status  Type    Build  Protocol  DC   Segment
		mgr9   192.168.0.54:8301  alive   server  1.6.1  2         dc1  <all>
		mgr01  192.168.0.55:8301  alive   client  1.6.1  2         dc1  <default>
		mgr02  192.168.0.56:8301  alive   client  1.6.1  2         dc1  <default>
		mgr03  192.168.0.58:8301  alive   client  1.6.1  2         dc1  <default>

			
		[root@mgr01 consul.d]# consul operator raft list-peers
		Node  ID                                    Address            State   Voter  RaftProtocol
		mgr9  03b4f212-e2bf-0be9-d460-1e48192b1f3e  192.168.0.54:8300  leader  true   3

	
	4.2 查看 WEB UI:
		我们看看web ui，consul自带的ui，非常轻便。
		访问：http://192.168.0.54:8500/ui/


	
	到这来consul集群就搭建完成了，是不是很简单。对就是这么简单，但是从上面可以看到，client节点并没有注册服务，显示0 services。这也就是接下来需要讲解的。



	
5. 主节点和从节点检查脚本   # Consul客户端都要有
	
	[root@mgr03 shell]# pwd
	/data/consul/shell
	[root@mgr03 shell]# ll
	total 8
	-rw-r--r-- 1 root root 1011 Nov  9  2019 check_mysql_mgr_master.sh
	-rw-r--r-- 1 root root 1313 Nov  9  2019 check_mysql_mgr_slave.sh
	[root@mgr03 shell]# chmod +x *
	[root@mgr01 shell]# dos2unix *
	dos2unix: converting file check_mysql_mgr_master.sh to Unix format ...
	dos2unix: converting file check_mysql_mgr_slave.sh to Unix format ...
	

6. Consul client端服务发现的json脚本  # Consul客户端都要有
	
	检测master
		cat /etc/consul.d/master.json
		[root@mgr01 ~]# cat /etc/consul.d/master.json
		{
		  "services": [
			{
			  "name": "mgr-3306-write",
			  "tags": [
				"mgr-master-write"
			  ],
			  "address": "192.168.0.55",
			  "port": 3306,
			  "checks": [
				{
				  "Args": ["/data/consul/shell/check_mysql_mgr_master.sh"],
				  "Shell": "/bin/bash",
				  "interval": "15s"
				}
			  ]
			}
		  ]
		}

	检测slave
		cat /etc/consul.d/slave.json
		[root@mgr01 ~]# cat /etc/consul.d/slave.json
		{
		  "services": [
			{
			  "name": "mgr-3306-read",
			  "tags": [
				"mgr-slave-read"
			  ],
			  "address": "192.168.0.55",
			  "port": 3306,
			  "checks": [
				{
				  "Args": ["/data/consul/shell/check_mysql_mgr_slave.sh"],
				  "Shell": "/bin/bash",
				  "interval": "15s"
				}
			  ]
			}
		  ]
		}	 
	

7. Consul client端执行consul reload命令重新加载配置
	
	[root@mgr01 shell]# consul reload
	Configuration reload triggered


	错误1: 
		2019/11/01 07:35:30 [INFO] agent: Caught signal:  terminated
		2019/11/01 07:35:30 [INFO] agent: Gracefully shutting down agent...
		2019/11/01 07:35:30 [INFO] consul: client starting leave
		2019/11/01 07:35:30 [INFO] serf: EventMemberLeave: mgr02 192.168.0.56
		2019/11/01 07:35:33 [INFO] agent: Graceful exit completed
		2019/11/01 07:35:33 [INFO] agent: Requesting shutdown
		2019/11/01 07:35:33 [INFO] consul: shutting down client
		2019/11/01 07:35:33 [INFO] manager: shutting down
		2019/11/01 07:35:33 [INFO] agent: consul client down
		2019/11/01 07:35:33 [INFO] agent: shutdown complete
		2019/11/01 07:35:33 [INFO] agent: Stopping DNS server 127.0.0.1:8600 (tcp)
		2019/11/01 07:35:33 [INFO] agent: Stopping DNS server 127.0.0.1:8600 (udp)
		2019/11/01 07:35:33 [INFO] agent: Stopping HTTP server 127.0.0.1:8500 (tcp)
		2019/11/01 07:35:33 [INFO] agent: Waiting for endpoints to shut down
		2019/11/01 07:35:33 [INFO] agent: Endpoints down
		2019/11/01 07:35:33 [INFO] agent: Exit code: 0
		tail: /data/consul/consul.log: file truncated
		==> Error parsing /etc/consul.d/master.json: 1 error occurred:
		* invalid config key services[0].checks[0].script

		
		"checks": [
		{
		"Args": ["/data/consul/shell/check_redis_master.sh"],
		"Shell":"/bin/bash"
		"interval": "15s"
		}
		]
		}
		]
		}
		checks那段要改，然后不能传参了，只能在脚本强制写了，agent启动的时候还要加上 -enable-script-checks 选项支持脚本检查
	
		nohup consul agent -enable-script-checks -config-dir=/etc/consul.d > /data/consul/consul.log &
	
	
	
	错误2: 
		tail: /data/consul/consul.log: file truncated
		==> Error parsing /etc/consul.d/master.json: invalid character '"' after object key:value pair
		
		"Shell":"/bin/bash" 后面没有 , 号

		
	查看启动日志(mgr01):
		mgr01
			2019/10/29 13:40:58 [INFO] agent: Caught signal:  hangup
			2019/10/29 13:40:58 [INFO] agent: Reloading configuration...
			2019/10/29 13:40:58 [INFO] agent: Synced service "mgr-3306-write"
			2019/10/29 13:40:58 [INFO] agent: Synced service "mgr-3306-read"
			2019/10/29 13:41:01 [INFO] agent: Synced check "service:mgr-3306-write"
			2019/10/29 13:41:11 [WARN] agent: Check "service:mgr-3306-read" is now critical
			2019/10/29 13:41:26 [WARN] agent: Check "service:mgr-3306-read" is now critical
			2019/10/29 13:41:41 [WARN] agent: Check "service:mgr-3306-read" is now critical
			2019/10/29 13:41:56 [WARN] agent: Check "service:mgr-3306-read" is now critical

			
		mgr02
			2019/11/08 07:33:55 [INFO] agent: Caught signal:  hangup
			2019/11/08 07:33:55 [INFO] agent: Reloading configuration...
			2019/11/08 07:33:55 [INFO] agent: Synced service "mgr-3306-write"
			2019/11/08 07:33:55 [INFO] agent: Synced service "mgr-3306-read"
			2019/11/08 07:33:55 [WARN] agent: Check "service:mgr-3306-write" is now critical
			2019/11/08 07:33:57 [INFO] agent: Synced check "service:mgr-3306-read"
			2019/11/08 07:34:10 [WARN] agent: Check "service:mgr-3306-write" is now critical
			2019/11/08 07:34:25 [WARN] agent: Check "service:mgr-3306-write" is now critical

		
		可以看到 mgr-3306-write ，mgr-3306-read 服务都已经注册，但是只有 mgr-3306-write 注册成功，也就是写的，
		因为服务器mgr01上面的MySQL是master，slave的服务当然无法注册成功。我们通过 web ui 看看。
	


8. 查看dns域名解析的节点

	我们注册两个服务: 
		mgr-3306-write，mgr-3306-read，那么就是就产生了2个域名，分别是 mgr-3306-write.service.consul 和 mgr-3306-read.service.consul。

	我们使用dig来看看：

		
		dig 测试一：
			dig @192.168.0.55 -p 8600 mgr-3306-write.service.consul
			
			[root@mgr01 shell]# dig @192.168.0.55 -p 8600 mgr-3306-write.service.consul

			; <<>> DiG 9.11.4-P2-RedHat-9.11.4-9.P2.el7 <<>> @192.168.0.55 -p 8600 mgr-3306-write.service.consul
			; (1 server found)
			;; global options: +cmd
			;; connection timed out; no servers could be reached
			
			
			#### 报错了。原因： IP地址必须是server端的。

		

		dig 测试二：IP地址是 server端的，dig 读取写域名
			
			[root@mgr01 ~]#  dig @192.168.0.54 -p 8600 mgr-3306-write.service.consul

			; <<>> DiG 9.11.4-P2-RedHat-9.11.4-9.P2.el7 <<>> @192.168.0.54 -p 8600 mgr-3306-write.service.consul
			; (1 server found)
			;; global options: +cmd
			;; Got answer:
			;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 65155
			;; flags: qr aa rd; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 2
			;; WARNING: recursion requested but not available

			;; OPT PSEUDOSECTION:
			; EDNS: version: 0, flags:; udp: 4096
			;; QUESTION SECTION:
			;mgr-3306-write.service.consul.	IN	A

			;; ANSWER SECTION:
			mgr-3306-write.service.consul. 0 IN	A	192.168.0.55

			;; ADDITIONAL SECTION:
			mgr-3306-write.service.consul. 0 IN	TXT	"consul-network-segment="

			;; Query time: 1 msec
			;; SERVER: 192.168.0.54#8600(192.168.0.54)
			;; WHEN: Tue Oct 29 13:44:47 CST 2019
			;; MSG SIZE  rcvd: 110


			
			########　我们可以看到写的域名 mgr-3306-write.service.consul 解析到了192.168.0.55（mgr01）这台服务器上。
			
		dig 测试三：IP地址是 server端的

			[root@mgr01 ~]# dig @192.168.0.54 -p 8600 mgr-3306-read.service.consul

			; <<>> DiG 9.11.4-P2-RedHat-9.11.4-9.P2.el7 <<>> @192.168.0.54 -p 8600 mgr-3306-read.service.consul
			; (1 server found)
			;; global options: +cmd
			;; Got answer:
			;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 950
			;; flags: qr aa rd; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 3
			;; WARNING: recursion requested but not available

			;; OPT PSEUDOSECTION:
			; EDNS: version: 0, flags:; udp: 4096
			;; QUESTION SECTION:
			;mgr-3306-read.service.consul.	IN	A

			;; ANSWER SECTION:
			mgr-3306-read.service.consul. 0	IN	A	192.168.0.56
			mgr-3306-read.service.consul. 0	IN	A	192.168.0.58

			;; ADDITIONAL SECTION:
			mgr-3306-read.service.consul. 0	IN	TXT	"consul-network-segment="
			mgr-3306-read.service.consul. 0	IN	TXT	"consul-network-segment="

			;; Query time: 1 msec
			;; SERVER: 192.168.0.54#8600(192.168.0.54)
			;; WHEN: Tue Oct 29 13:45:30 CST 2019
			;; MSG SIZE  rcvd: 161


	域名 mgr-3306-write.service.consul 解析到了 192.168.0.55(mgr01) 这个节点上。
	域名 mgr-3306-read.service.consul  解析到了 192.168.0.56(mgr02) 和 192.168.0.58(mgr03) 这2个节点上。
	
		
	
9. ping 域名

	ping其中一个域名，比如：mgr-3306-write.service.consul，那么返回的是主节点的ip，因为这个域名是写的。

	如果ping mgr-3306-read.service.consul，那么返回的是另外两个从节点的ip。

	[root@mgr9 consul.d]# ping mgr-3306-write.service.consul
	ping: mgr-3306-write.service.consul: Name or service not known

	[root@mgr01 shell]# ping mgr-3306-write.service.consul
	ping: mgr-3306-write.service.consul: Name or service not known

	[root@mgr01 shell]# ping mgr-3306-read.service.consul
	ping: mgr-3306-read.service.consul: Name or service not known	
	
	问题： 域名ping不通
	
	# 不影响MGR主节点切换之后 读写域名的正常漂移
 
10. 故障测试


	10.1 进行在线切换, 查看读和写的域名分别会解析到哪里

		当前成员状态
			root@mysqldb 13:50:  [test_db]> select * from performance_schema.replication_group_members;
			+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
			| CHANNEL_NAME              | MEMBER_ID                            | MEMBER_HOST | MEMBER_PORT | MEMBER_STATE | MEMBER_ROLE | MEMBER_VERSION |
			+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
			| group_replication_applier | 5497bb23-a3c5-11e8-8f8f-080027d80ec1 | mgr02       |        3306 | ONLINE       | SECONDARY   | 8.0.18         |
			| group_replication_applier | a6b6670d-07c0-11ea-a385-080027c52883 | mgr03       |        3306 | ONLINE       | SECONDARY   | 8.0.18         |
			| group_replication_applier | e136faa2-eeab-11e9-9494-080027cb3816 | mgr01       |        3306 | ONLINE       | PRIMARY     | 8.0.18         |
			+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
			3 rows in set (0.00 sec)
		
		
		把主节点停掉:
			/etc/init.d/mysql stop 

		在线切换
			把 mgr03 切换为 PRIMARY: 
				SELECT group_replication_set_as_primary('a6b6670d-07c0-11ea-a385-080027c528833');
				root@mysqldb 13:51:  [test_db]> SELECT group_replication_set_as_primary('a6b6670d-07c0-11ea-a385-080027c52883');
				+--------------------------------------------------------------------------+
				| group_replication_set_as_primary('a6b6670d-07c0-11ea-a385-080027c52883') |
				+--------------------------------------------------------------------------+
				| Primary server switched to: a6b6670d-07c0-11ea-a385-080027c52883         |
				+--------------------------------------------------------------------------+
				1 row in set (0.68 sec)
			
			查看切换后的成员状态
			
				root@mysqldb 13:52:  [test_db]> select * from performance_schema.replication_group_members;
				+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
				| CHANNEL_NAME              | MEMBER_ID                            | MEMBER_HOST | MEMBER_PORT | MEMBER_STATE | MEMBER_ROLE | MEMBER_VERSION |
				+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
				| group_replication_applier | 5497bb23-a3c5-11e8-8f8f-080027d80ec1 | mgr02       |        3306 | ONLINE       | SECONDARY   | 8.0.18         |
				| group_replication_applier | a6b6670d-07c0-11ea-a385-080027c52883 | mgr03       |        3306 | ONLINE       | PRIMARY     | 8.0.18         |
				| group_replication_applier | e136faa2-eeab-11e9-9494-080027cb3816 | mgr01       |        3306 | ONLINE       | SECONDARY   | 8.0.18         |
				+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
				3 rows in set (0.00 sec)

			

		看看写域名 mgr-3306-write.service.consul 解析到哪里
	 
			[root@mgr01 ~]# dig @192.168.0.54 -p 8600 mgr-3306-write.service.consul

			; <<>> DiG 9.11.4-P2-RedHat-9.11.4-9.P2.el7 <<>> @192.168.0.54 -p 8600 mgr-3306-write.service.consul
			; (1 server found)
			;; global options: +cmd
			;; Got answer:
			;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 45085
			;; flags: qr aa rd; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 2
			;; WARNING: recursion requested but not available

			;; OPT PSEUDOSECTION:
			; EDNS: version: 0, flags:; udp: 4096
			;; QUESTION SECTION:
			;mgr-3306-write.service.consul.	IN	A

			;; ANSWER SECTION:
			mgr-3306-write.service.consul. 0 IN	A	192.168.0.58

			;; ADDITIONAL SECTION:
			mgr-3306-write.service.consul. 0 IN	TXT	"consul-network-segment="

			;; Query time: 1 msec
			;; SERVER: 192.168.0.54#8600(192.168.0.54)
			;; WHEN: Tue Oct 29 13:53:19 CST 2019
			;; MSG SIZE  rcvd: 110

			
			可以看到没有问题，正常: 域名 mgr-3306-write.service.consul 已经解析到了  192.168.0.58 (mgr03) 节点上.
			
		查看读域名 mgr-3306-read.service.consul 解析到哪里
		
		
			[root@mgr01 ~]# dig @192.168.0.54 -p 8600 mgr-3306-read.service.consul

			; <<>> DiG 9.11.4-P2-RedHat-9.11.4-9.P2.el7 <<>> @192.168.0.54 -p 8600 mgr-3306-read.service.consul
			; (1 server found)
			;; global options: +cmd
			;; Got answer:
			;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 62622
			;; flags: qr aa rd; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 3
			;; WARNING: recursion requested but not available

			;; OPT PSEUDOSECTION:
			; EDNS: version: 0, flags:; udp: 4096
			;; QUESTION SECTION:
			;mgr-3306-read.service.consul.	IN	A

			;; ANSWER SECTION:
			mgr-3306-read.service.consul. 0	IN	A	192.168.0.55
			mgr-3306-read.service.consul. 0	IN	A	192.168.0.56

			;; ADDITIONAL SECTION:
			mgr-3306-read.service.consul. 0	IN	TXT	"consul-network-segment="
			mgr-3306-read.service.consul. 0	IN	TXT	"consul-network-segment="

			;; Query time: 1 msec
			;; SERVER: 192.168.0.54#8600(192.168.0.54)
			;; WHEN: Tue Oct 29 13:54:01 CST 2019
			;; MSG SIZE  rcvd: 161

			可以看到没有问题，正常: 读域名 mgr-3306-read.service.consul 已经解析到了  192.168.0.55 (mgr01) 和 192.168.0.56 (mgr02) 节点上.
			
		可以看到一切正常。后续检查脚本可以判断是否延时，如果延时就不注册服务。
		
11. dns的问题

	App端配置域名服务器IP来解析consul后缀的域名，DNS解析及跳转， 有三个方案：
		1. 原内网dns服务器,做域名转发，consul后缀的，都转到consul server上（目前采用这种）
		2. dns全部跳到consul DNS服务器上，非consul后缀的,使用 recursors 属性跳转到原DNS服务器上
		3. dnsmaq 转： server=/consul/10.16.X.X#8600 解析consul后缀的
		
consul提供服务发现接口，我们使用DNS解析的方式来查看一下
	写域名 
		[root@mgr9 consul.d]# dig @192.168.0.54 -p 8600 mgr-3306-write.service.consul

		; <<>> DiG 9.11.4-P2-RedHat-9.11.4-9.P2.el7 <<>> @192.168.0.54 -p 8600 mgr-3306-write.service.consul
		; (1 server found)
		;; global options: +cmd
		;; Got answer:
		;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 47748
		;; flags: qr aa rd; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 2
		;; WARNING: recursion requested but not available

		;; OPT PSEUDOSECTION:
		; EDNS: version: 0, flags:; udp: 4096
		;; QUESTION SECTION:
		;mgr-3306-write.service.consul.	IN	A

		;; ANSWER SECTION:
		mgr-3306-write.service.consul. 0 IN	A	192.168.0.58

		;; ADDITIONAL SECTION:
		mgr-3306-write.service.consul. 0 IN	TXT	"consul-network-segment="

		;; Query time: 0 msec
		;; SERVER: 192.168.0.54#8600(192.168.0.54)
		;; WHEN: Tue Apr 14 21:20:42 CST 2020
		;; MSG SIZE  rcvd: 110

	读域名
		[root@mgr9 consul.d]# dig @192.168.0.54 -p 8600 mgr-3306-read.service.consul

		; <<>> DiG 9.11.4-P2-RedHat-9.11.4-9.P2.el7 <<>> @192.168.0.54 -p 8600 mgr-3306-read.service.consul
		; (1 server found)
		;; global options: +cmd
		;; Got answer:
		;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 19125
		;; flags: qr aa rd; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 3
		;; WARNING: recursion requested but not available

		;; OPT PSEUDOSECTION:
		; EDNS: version: 0, flags:; udp: 4096
		;; QUESTION SECTION:
		;mgr-3306-read.service.consul.	IN	A

		;; ANSWER SECTION:
		mgr-3306-read.service.consul. 0	IN	A	192.168.0.55
		mgr-3306-read.service.consul. 0	IN	A	192.168.0.56

		;; ADDITIONAL SECTION:
		mgr-3306-read.service.consul. 0	IN	TXT	"consul-network-segment="
		mgr-3306-read.service.consul. 0	IN	TXT	"consul-network-segment="

		;; Query time: 0 msec
		;; SERVER: 192.168.0.54#8600(192.168.0.54)
		;; WHEN: Tue Apr 14 21:38:25 CST 2020
		;; MSG SIZE  rcvd: 161

		
使用bind转发consul DNS服务
		
	[root@mgr9 consul.d]# cat /etc/named.conf 
	
	options {
		listen-on port 53 { 192.168.0.54; };
		listen-on-v6 port 53 { ::1; };
		directory 	"/var/named";
		dump-file 	"/var/named/data/cache_dump.db";
		statistics-file "/var/named/data/named_stats.txt";
		memstatistics-file "/var/named/data/named_mem_stats.txt";
		recursing-file  "/var/named/data/named.recursing";
		secroots-file   "/var/named/data/named.secroots";
		allow-query     { any; };

		recursion yes;

		dnssec-enable no;
		dnssec-validation no;

		/* Path to ISC DLV key */
		bindkeys-file "/etc/named.root.key";

		managed-keys-directory "/var/named/dynamic";

		pid-file "/run/named/named.pid";
		session-keyfile "/run/named/session.key";
	};

	logging {
			channel default_debug {
					file "data/named.run";
					severity dynamic;
			};
	};

	zone "." IN {
		type hint;
		file "named.ca";
	};

	include "/etc/named.rfc1912.zones";
	include "/etc/named.root.key";
	include "/etc/named/consul.conf";
	
	
	[root@mgr9 consul]# cat /etc/named/consul.conf
	zone "consul" IN {
	  type forward;
	  forward only;
	  forwarders { 192.168.0.54 port 8600; };
	};

	
	[root@mgr9 consul.d]# systemctl restart named


	测试一下bind域名转发

		写域名
			dig @192.168.0.54 -p 53 mgr-3306-write.service.consul A

			[root@mgr9 consul.d]# dig @192.168.0.54 -p 53 mgr-3306-write.service.consul A

			; <<>> DiG 9.11.4-P2-RedHat-9.11.4-9.P2.el7 <<>> @192.168.0.54 -p 53 mgr-3306-write.service.consul A
			; (1 server found)
			;; global options: +cmd
			;; Got answer:
			;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 32275
			;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 13, ADDITIONAL: 27

			;; OPT PSEUDOSECTION:
			; EDNS: version: 0, flags:; udp: 4096
			;; QUESTION SECTION:
			;mgr-3306-write.service.consul.	IN	A

			;; ANSWER SECTION:
			mgr-3306-write.service.consul. 0 IN	A	192.168.0.58

			;; AUTHORITY SECTION:
			.			518086	IN	NS	b.root-servers.net.
			.			518086	IN	NS	e.root-servers.net.
			.............................................
			.			518086	IN	NS	g.root-servers.net.

			;; ADDITIONAL SECTION:
			a.root-servers.net.	518086	IN	A	198.41.0.4
			b.root-servers.net.	518086	IN	A	199.9.14.201
			................................................
			m.root-servers.net.	518086	IN	AAAA	2001:dc3::35

			;; Query time: 1 msec
			;; SERVER: 192.168.0.54#53(192.168.0.54)
			;; WHEN: Tue Apr 14 23:27:52 CST 2020
			;; MSG SIZE  rcvd: 857

			
		读域名
			[root@mgr9 consul.d]# dig @192.168.0.54 -p 53 mgr-3306-read.service.consul A

			; <<>> DiG 9.11.4-P2-RedHat-9.11.4-9.P2.el7 <<>> @192.168.0.54 -p 53 mgr-3306-read.service.consul A
			; (1 server found)
			;; global options: +cmd
			;; Got answer:
			;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 49379
			;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 13, ADDITIONAL: 27

			;; OPT PSEUDOSECTION:
			; EDNS: version: 0, flags:; udp: 4096
			;; QUESTION SECTION:
			;mgr-3306-read.service.consul.	IN	A

			;; ANSWER SECTION:
			mgr-3306-read.service.consul. 0	IN	A	192.168.0.56
			mgr-3306-read.service.consul. 0	IN	A	192.168.0.55

			;; AUTHORITY SECTION:
			.			518020	IN	NS	l.root-servers.net.
			.			518020	IN	NS	f.root-servers.net.
			...............................................
			.			518020	IN	NS	m.root-servers.net.

			;; ADDITIONAL SECTION:
			a.root-servers.net.	518020	IN	A	198.41.0.4
			b.root-servers.net.	518020	IN	A	199.9.14.201
			................................................
			m.root-servers.net.	518020	IN	AAAA	2001:dc3::35

			;; Query time: 1 msec
			;; SERVER: 192.168.0.54#53(192.168.0.54)
			;; WHEN: Tue Apr 14 23:28:58 CST 2020
			;; MSG SIZE  rcvd: 872

		
12. 相关参考
	https://www.cnblogs.com/gomysql/p/8010552.html      基于Consul的数据库高可用架构     
	https://www.cnblogs.com/gomysql/p/8985774.html      MySQL高可用新玩法之MGR+Consul
	http://blog.itpub.net/29987453/viewspace-2637608/   MySQL MGR+ Consul之数据库高可用方案最佳实践
	https://cloud.tencent.com/developer/article/1357881 MySQL高可用方案MGR+consul组合测试
	https://blog.51cto.com/xiaoluoge/2134126            consul服务注册与发现应用实战
	https://blog.csdn.net/huchao_lingo/article/details/105137597  使用bind转发consul DNS服务
	https://blog.csdn.net/weixin_30699741/article/details/98223766 
	
	 
13. 思考 
	12.1 consul是否可以做读写分离
		可以, 即使一个从库挂了, 别一个从库还可以提供读业务
		
	12.2 consul 配置文件的含义
	
14. 小结

cp /usr/local/bin/consul /etc/init.d/consul_agent
