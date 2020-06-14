

1. 简介
	介绍ZooKeeper部署管理Mycat，ZK管理mycat的server.xml、schema.xml、rule.xml等一系列配置，ZK修改配置，同一个集群中mycat节点配置自动更新
	Mycat 支持zookeeper协调主从切换、zk序列、配置zk化（1.6）
	
	1. ZK管理Mycat配置(server.xml、schema.xml、rule.xml.....)
	2. ZK修改配置, 集群内的Mycat节点自动更新
		修改一个节点的配置, 其它节点也会更新吗
		是的.
		
	3. 可在线切换库
	4. 通过监控ZK节点情况可以知道Mycat集群内每个节点的存活
	
	各个版本的下载: http://archive.apache.org/dist/zookeeper/

	
2. zookeeper的3个端口：
	2181（对client提供服务）
	2888（集群内机器通讯使用，leader监听此端口）
	3888（选举leader使用）
	
	
3. 环境

	主机        IP 地址               myid  
	mgr9        192.168.0.54           1                  
  
	mycat01     192.168.0.201          2               	
	
	mycat05     192.168.0.205	 	   3


	为了测试方便，这里关闭系统防火墙和禁用selinux，生产环境防火墙则需要开放zookeeper相关端口，2181、2888、3888。

	# 关闭防火墙
	systemctl stop firewalld.service
	systemctl disable firewalld.service

	# 关闭SELINUX
	sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
	setenforce 0
	
4. 安装zookeeper
	
	4.1 下载解压
		cd /usr/local/
		
		上传到 /usr/local/ 目录下
		
		tar -zxvf zookeeper-3.4.10.tar.gz
		mv zookeeper-3.4.10 zookeeper
		
		cd zookeeper
		
		mkdir data log
		cd conf/
		cp zoo_sample.cfg zoo.cfg
	
	4.2 修改配置文件
	
		vim zoo.cfg
		
	4.3 添加myid文件
		vim /usr/local/zookeeper/data/myid 写入 1
		
	4.4 同步zookeeper目录到其它2个节点，修改myid
	
		scp -r /usr/local/zookeeper/ root@192.168.0.201:/usr/local/zookeeper/
		scp -r /usr/local/zookeeper/ root@192.168.0.205:/usr/local/zookeeper/

		并在2个节点分别修改对应的myid
		
	4.5 启动zookeeper
		192.168.0.54 
			sh /usr/local/zookeeper/bin/zkServer.sh start
			
			ZooKeeper JMX enabled by default
			Using config: /usr/local/zookeeper/bin/../conf/zoo.cfg
			Starting zookeeper ... already running as process 1398.

			
			[root@mgr9 ~]# sh /usr/local/zookeeper/bin/zkServer.sh restart
			ZooKeeper JMX enabled by default
			Using config: /usr/local/zookeeper/bin/../conf/zoo.cfg
			ZooKeeper JMX enabled by default
			Using config: /usr/local/zookeeper/bin/../conf/zoo.cfg
			Stopping zookeeper ... STOPPED
			ZooKeeper JMX enabled by default
			Using config: /usr/local/zookeeper/bin/../conf/zoo.cfg
			Starting zookeeper ... STARTED
		
			查看 zookeeper 状态
				[root@mgr9 log]# /usr/local/zookeeper/bin/zkServer.sh status
				ZooKeeper JMX enabled by default
				Using config: /usr/local/zookeeper/bin/../conf/zoo.cfg
				Mode: standalone
		
				[root@mgr9 log]# /usr/local/zookeeper/bin/zkServer.sh status
				ZooKeeper JMX enabled by default
				Using config: /usr/local/zookeeper/bin/../conf/zoo.cfg
				Mode: follower

		192.168.0.205
			[root@mycat05 conf]# sh /usr/local/zookeeper/bin/zkServer.sh start
			ZooKeeper JMX enabled by default
			Using config: /usr/local/zookeeper/bin/../conf/zoo.cfg
			Starting zookeeper ... STARTED
			
			[root@mycat05 conf]#  /usr/local/zookeeper/bin/zkServer.sh status
			ZooKeeper JMX enabled by default
			Using config: /usr/local/zookeeper/bin/../conf/zoo.cfg
			Error contacting service. It is probably not running.
	
			[root@mycat05 bin]# cat zookeeper.out 
			nohup: failed to run command ‘java’: No such file or directory

			# 没有安装 java, 要安装 java 和 jre
			
			sh /usr/local/zookeeper/bin/zkServer.sh restart
			
			[root@mycat05 bin]#  /usr/local/zookeeper/bin/zkServer.sh status
			ZooKeeper JMX enabled by default
			Using config: /usr/local/zookeeper/bin/../conf/zoo.cfg
			Error contacting service. It is probably not running.

			[root@mycat05 local]# ps aux|grep zookeeper
			"root     11753  2.5  4.0 2260420 41180 pts/1   Sl   02:07   0:00 /usr/local/java/bin/java -Dzookeeper.log.dir=. -Dzookeeper.root.logger=INFO,CONSOLE -cp /usr/local/zookeeper/bin/../build/classes:/usr/local/zookeeper/bin/../build/lib/ .jar:/usr/local/zookeeper/bin/../lib/slf4j-log4j12-1.6.1.jar:/usr/local/zookeeper/bin/../lib/slf4j-api-1.6.1.jar:/usr/local/zookeeper/bin/../lib/netty-3.10.5.Final.jar:/usr/local/zookeeper/bin/../lib/log4j-1.2.16.jar:/usr/local/zookeeper/bin/../lib/jline-0.9.94.jar:/usr/local/zookeeper/bin/../zookeeper-3.4.10.jar:/usr/local/zookeeper/bin/../src/java/lib/*.jar:/usr/local/zookeeper/bin/../conf: -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.local.only=false org.apache.zookeeper.server.quorum.QuorumPeerMain /usr/local/zookeeper/bin/../conf/zoo.cfg"
			
			
			[root@mycat05 ~]# /usr/local/zookeeper/bin/zkServer.sh status
			ZooKeeper JMX enabled by default
			Using config: /usr/local/zookeeper/bin/../conf/zoo.cfg
			Mode: leader
			
			
		192.168.0.201 
			[root@mycat01 local]# sh /usr/local/zookeeper/bin/zkServer.sh start
			ZooKeeper JMX enabled by default
			Using config: /usr/local/zookeeper/bin/../conf/zoo.cfg
			Starting zookeeper ... STARTED
			
			[root@mycat01 local]# /usr/local/zookeeper/bin/zkServer.sh status
			ZooKeeper JMX enabled by default
			Using config: /usr/local/zookeeper/bin/../conf/zoo.cfg
			Mode: follower

			
			
	4.6 查看 zookeeper 状态
		[root@mgr9 log]# /usr/local/zookeeper/bin/zkServer.sh status
		ZooKeeper JMX enabled by default
		Using config: /usr/local/zookeeper/bin/../conf/zoo.cfg
		Mode: standalone

		standalone为单机模式，只有配置了多个server时，才会是集群模式
		
		
		
	4.7 安装Mycat
	
		同样，3个节点都需要安装mycat。
		
		# 这个步骤要重新做, 并且看看 执行mycat初始化数据 会发生什么.
		
		
	4.8 执行mycat初始化数据
	
		3个节点Mycat都执行如下脚本

		sh /usr/local/mycat/bin/init_zk_data.sh

			
		192.168.0.54 
		
			[root@mgr9 log]# sh /usr/local/mycat/bin/init_zk_data.sh
			o2020-03-29 21:38:01 INFO JAVA_CMD=/usr/local/java/bin/java
			o2020-03-29 21:38:01 INFO Start to initialize /mycat of ZooKeeper
			Exception in thread "main" java.lang.ExceptionInInitializerError
				at io.mycat.config.loader.zkprocess.xmltozk.XmltoZkMain.buildConnection(XmltoZkMain.java:86)
				at io.mycat.config.loader.zkprocess.xmltozk.XmltoZkMain.main(XmltoZkMain.java:39)
			Caused by: java.lang.RuntimeException: failed to connect to zookeeper service : 192.168.0.54:2181, 192.168.0.201:2181, 192.168.0.205:2181
				at io.mycat.util.ZKUtils.createConnection(ZKUtils.java:75)
				at io.mycat.util.ZKUtils.<clinit>(ZKUtils.java:35)
				... 2 more
			o2020-03-29 21:38:25 ERROR Something wrong happened, please refer logs above
		
			查看 zookeeper 状态
				[root@mgr9 log]# /usr/local/zookeeper/bin/zkServer.sh status
				ZooKeeper JMX enabled by default
				Using config: /usr/local/zookeeper/bin/../conf/zoo.cfg
				Mode: follower


		192.168.0.201
		
			[root@mycat01 local]# sh /usr/local/mycat/bin/init_zk_data.sh
			o2020-03-29 19:59:53 INFO JAVA_CMD=/usr/local/java/bin/java
			o2020-03-29 19:59:53 INFO Start to initialize /mycat of ZooKeeper
			2020-03-29 19:59:56,044 Thread-1 ERROR Unable to register shutdown hook because JVM is shutting down. java.lang.IllegalStateException: Cannot add new shutdown hook as this is not started. Current state: STOPPED
				at org.apache.logging.log4j.core.util.DefaultShutdownCallbackRegistry.addShutdownCallback(DefaultShutdownCallbackRegistry.java:113)
				at org.apache.logging.log4j.core.impl.Log4jContextFactory.addShutdownCallback(Log4jContextFactory.java:273)
				at org.apache.logging.log4j.core.LoggerContext.setUpShutdownHook(LoggerContext.java:256)
				at org.apache.logging.log4j.core.LoggerContext.start(LoggerContext.java:216)
				at org.apache.logging.log4j.core.impl.Log4jContextFactory.getContext(Log4jContextFactory.java:145)
				at org.apache.logging.log4j.core.impl.Log4jContextFactory.getContext(Log4jContextFactory.java:41)
				at org.apache.logging.log4j.LogManager.getContext(LogManager.java:182)
				at org.apache.logging.log4j.spi.AbstractLoggerAdapter.getContext(AbstractLoggerAdapter.java:103)
				at org.apache.logging.slf4j.Log4jLoggerFactory.getContext(Log4jLoggerFactory.java:43)
				at org.apache.logging.log4j.spi.AbstractLoggerAdapter.getLogger(AbstractLoggerAdapter.java:42)
				at org.apache.logging.slf4j.Log4jLoggerFactory.getLogger(Log4jLoggerFactory.java:29)
				at org.slf4j.LoggerFactory.getLogger(LoggerFactory.java:242)
				at org.slf4j.LoggerFactory.getLogger(LoggerFactory.java:254)
				at org.apache.curator.utils.CloseableUtils.<clinit>(CloseableUtils.java:33)
				at org.apache.curator.ConnectionState.close(ConnectionState.java:111)
				at org.apache.curator.CuratorZookeeperClient.close(CuratorZookeeperClient.java:203)
				at org.apache.curator.framework.imps.CuratorFrameworkImpl.close(CuratorFrameworkImpl.java:321)
				at io.mycat.util.ZKUtils$1.run(ZKUtils.java:40)
				at java.lang.Thread.run(Thread.java:748)

			o2020-03-29 19:59:56 INFO Done
				
				
			查看 zookeeper 状态

				[root@mycat01 zkconf]# /usr/local/zookeeper/bin/zkServer.sh status
				ZooKeeper JMX enabled by default
				Using config: /usr/local/zookeeper/bin/../conf/zoo.cfg
				Mode: follower
					
		192.168.0.205
		
			[root@mycat05 ~]# sh /usr/local/mycat/bin/init_zk_data.sh
			o2020-03-30 02:45:52 INFO JAVA_CMD=/usr/local/java/bin/java
			o2020-03-30 02:45:52 INFO Start to initialize /mycat of ZooKeeper
			2020-03-30 02:45:56,672 Thread-1 ERROR Unable to register shutdown hook because JVM is shutting down. java.lang.IllegalStateException: Cannot add new shutdown hook as this is not started. Current state: STOPPED
				at org.apache.logging.log4j.core.util.DefaultShutdownCallbackRegistry.addShutdownCallback(DefaultShutdownCallbackRegistry.java:113)
				at org.apache.logging.log4j.core.impl.Log4jContextFactory.addShutdownCallback(Log4jContextFactory.java:273)
				at org.apache.logging.log4j.core.LoggerContext.setUpShutdownHook(LoggerContext.java:256)
				at org.apache.logging.log4j.core.LoggerContext.start(LoggerContext.java:216)
				at org.apache.logging.log4j.core.impl.Log4jContextFactory.getContext(Log4jContextFactory.java:145)
				at org.apache.logging.log4j.core.impl.Log4jContextFactory.getContext(Log4jContextFactory.java:41)
				at org.apache.logging.log4j.LogManager.getContext(LogManager.java:182)
				at org.apache.logging.log4j.spi.AbstractLoggerAdapter.getContext(AbstractLoggerAdapter.java:103)
				at org.apache.logging.slf4j.Log4jLoggerFactory.getContext(Log4jLoggerFactory.java:43)
				at org.apache.logging.log4j.spi.AbstractLoggerAdapter.getLogger(AbstractLoggerAdapter.java:42)
				at org.apache.logging.slf4j.Log4jLoggerFactory.getLogger(Log4jLoggerFactory.java:29)
				at org.slf4j.LoggerFactory.getLogger(LoggerFactory.java:242)
				at org.slf4j.LoggerFactory.getLogger(LoggerFactory.java:254)
				at org.apache.curator.utils.CloseableUtils.<clinit>(CloseableUtils.java:33)
				at org.apache.curator.ConnectionState.close(ConnectionState.java:111)
				at org.apache.curator.CuratorZookeeperClient.close(CuratorZookeeperClient.java:203)
				at org.apache.curator.framework.imps.CuratorFrameworkImpl.close(CuratorFrameworkImpl.java:321)
				at io.mycat.util.ZKUtils$1.run(ZKUtils.java:40)
				at java.lang.Thread.run(Thread.java:748)

			o2020-03-30 02:45:58 INFO Done

			
			[root@mycat05 logs]# sh /usr/local/mycat/bin/init_zk_data.sh
			o2020-03-30 05:56:32 INFO JAVA_CMD=/usr/local/java/bin/java
			o2020-03-30 05:56:32 INFO Start to initialize /mycat of ZooKeeper
			Exception in thread "main" java.lang.ExceptionInInitializerError
				at io.mycat.config.loader.zkprocess.xmltozk.XmltoZkMain.buildConnection(XmltoZkMain.java:86)
				at io.mycat.config.loader.zkprocess.xmltozk.XmltoZkMain.main(XmltoZkMain.java:39)
			Caused by: java.lang.RuntimeException: failed to connect to zookeeper service : 192.168.0.54:2181, 192.168.0.201:2181, 192.168.0.205:2181
				at io.mycat.util.ZKUtils.createConnection(ZKUtils.java:75)
				at io.mycat.util.ZKUtils.<clinit>(ZKUtils.java:35)
				... 2 more
			o2020-03-30 05:56:47 ERROR Something wrong happened, please refer logs above


			查看 zookeeper 状态
				[root@mycat05 logs]#  /usr/local/zookeeper/bin/zkServer.sh status
				ZooKeeper JMX enabled by default
				Using config: /usr/local/zookeeper/bin/../conf/zoo.cfg
				Mode: leader

		

	4.9 配置mycat支持zookeeper
	
		vim /usr/local/mycat/conf/myid.properties


		192.168.0.54
			loadZk=true
			zkURL=192.168.0.54:2181,192.168.0.201:2181,192.168.0.205:2181
			clusterId=mycat-cluster-1
			myid=mycat_fz_01
			clusterSize=3
			clusterNodes=mycat_fz_01,mycat_fz_02,mycat_fz_03
			#server  booster  ;   booster install on db same server,will reset all minCon to 2
			type=server
			boosterDataHosts=dataHost1

		192.168.0.201	
			[root@mycat01 conf]# vim myid.properties 

			loadZk=true
			zkURL=192.168.0.54:2181, 192.168.0.201:2181,192.168.0.205:2181
			clusterId=mycat-cluster-1
			myid=mycat_fz_02
			clusterSize=3
			clusterNodes=mycat_fz_01,mycat_fz_02,mycat_fz_03
			#server  booster  ;   booster install on db same server,will reset all minCon to 2
			type=server
			boosterDataHosts=dataHost1
			
		192.168.0.205

			[root@mycat05 conf]# vim myid.properties 

			loadZk=true
			zkURL=192.168.0.54:2181, 192.168.0.201:2181,192.168.0.205:2181
			clusterId=mycat-cluster-1
			myid=mycat_fz_03
			clusterSize=3
			clusterNodes=mycat_fz_01,mycat_fz_02,mycat_fz_03
			#server  booster  ;   booster install on db same server,will reset all minCon to 2
			type=server
			boosterDataHosts=dataHost1
			
	 	注意事项：
			* loadZk 必须改为true才生效 ；
			* zkURL 的地址是多个中间用“,”隔开 ；
			* clusterId：同一个zk内的集群ID必须唯一 ；
			* myid：本实例的id在当前的mycat集群内ID唯一 ；
			* clusterNodes=mycat_fz_01,mycat_fz_02,mycat_fz_03： 所有myid名称的集合；
			* 配置完zk并启动mycat后，会更新本地conf下的相关配置文件；
		
			zkURL=192.168.0.54:2181, 192.168.0.201:2181, 192.168.0.205:2181
			逗号后面不能有空格. 
			
			
	4.10 启动mycat

		mycat start
		
		
	4.10 用zookeeper配置mycat
		C:\Program Files\Java\jdk1.8.0_241\
		https://www.cnblogs.com/sleipnir-0430/p/8455195.html
		
	
		通过 ZooInspector工具  使用 Connect String 192.168.0.205:2181 连接 
			[{"name":"root","property":[{"value":"digdeep","name":"password"},{"value":"mycat_db","name":"schemas"}]},{"name":"user","property":[{"value":"user","name":"password"},{"value":"TESTDB","name":"schemas"},{"value":"true","name":"readOnly"}]}]
				
			这里修改了  <property name="schemas">mycat_db</property>

			
		查看 server.xml 	
			[root@mycat05 ~]# cat /usr/local/mycat/conf/server.xml 
			<!DOCTYPE mycat:server SYSTEM "server.dtd">
			<mycat:server xmlns:mycat="http://io.mycat/">
				<system>
					<property name="useSqlStat">1</property>
					<property name="useGlobleTableCheck">0</property>
					<property name="defaultSqlParser">druidparser</property>
					<property name="sequnceHandlerType">2</property>
					<property name="processorBufferPoolType">0</property>
					<property name="handleDistributedTransactions">0</property>
					<property name="useOffHeapForMerge">1</property>
					<property name="memoryPageSize">1m</property>
					<property name="spillsFileBufferSize">1k</property>
					<property name="useStreamOutput">0</property>
					<property name="systemReserveMemorySize">384m</property>
				</system>
				<user name="root">
					<property name="password">digdeep</property>
					<property name="schemas">mycat_db</property>
				</user>
				<user name="user">
					<property name="password">user</property>
					<property name="schemas">TESTDB</property>
					<property name="readOnly">true</property>
				</user>
			</mycat:server>
		
		
			[root@mycat01 version-2]#  cat /usr/local/mycat/conf/server.xml 
			<!DOCTYPE mycat:server SYSTEM "server.dtd">
			<mycat:server xmlns:mycat="http://io.mycat/">
				<system>
					<property name="useSqlStat">1</property>
					<property name="useGlobleTableCheck">0</property>
					<property name="defaultSqlParser">druidparser</property>
					<property name="sequnceHandlerType">2</property>
					<property name="processorBufferPoolType">0</property>
					<property name="handleDistributedTransactions">0</property>
					<property name="useOffHeapForMerge">1</property>
					<property name="memoryPageSize">1m</property>
					<property name="spillsFileBufferSize">1k</property>
					<property name="useStreamOutput">0</property>
					<property name="systemReserveMemorySize">384m</property>
				</system>
				<user name="root">
					<property name="password">digdeep</property>
					<property name="schemas">mycat_db</property>
				</user>
				<user name="user">
					<property name="password">user</property>
					<property name="schemas">TESTDB</property>
					<property name="readOnly">true</property>
				</user>
			</mycat:server>
					
					
			[root@mgr9 conf]# cat /usr/local/mycat/conf/server.xml 
			<!DOCTYPE mycat:server SYSTEM "server.dtd">
			<mycat:server xmlns:mycat="http://io.mycat/">
				<system>
					<property name="useSqlStat">1</property>
					<property name="useGlobleTableCheck">0</property>
					<property name="defaultSqlParser">druidparser</property>
					<property name="sequnceHandlerType">2</property>
					<property name="processorBufferPoolType">0</property>
					<property name="handleDistributedTransactions">0</property>
					<property name="useOffHeapForMerge">1</property>
					<property name="memoryPageSize">1m</property>
					<property name="spillsFileBufferSize">1k</property>
					<property name="useStreamOutput">0</property>
					<property name="systemReserveMemorySize">389m</property>
				</system>
				<user name="root">
					<property name="password">digdeep</property>
					<property name="schemas">mycat_db</property>
				</user>
				<user name="user">
					<property name="password">user</property>
					<property name="schemas">TESTDB</property>
					<property name="readOnly">true</property>
				</user>
			</mycat:server>