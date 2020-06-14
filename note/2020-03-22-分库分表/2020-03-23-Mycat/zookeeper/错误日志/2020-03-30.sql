

192.168.0.201 

mycat restart


[root@mycat01 logs]# tail -18 wrapper.log 
INFO   | jvm 1    | 2020/03/29 22:52:42 | 
INFO   | jvm 1    | 2020/03/29 22:52:42 | WrapperSimpleApp: Encountered an error running main: java.lang.ExceptionInInitializerError
INFO   | jvm 1    | 2020/03/29 22:52:42 | java.lang.ExceptionInInitializerError
INFO   | jvm 1    | 2020/03/29 22:52:42 | 	at io.mycat.config.loader.zkprocess.zktoxml.ZktoXmlMain.buildConnection(ZktoXmlMain.java:204)
INFO   | jvm 1    | 2020/03/29 22:52:42 | 	at io.mycat.config.loader.zkprocess.zktoxml.ZktoXmlMain.loadZktoFile(ZktoXmlMain.java:72)
INFO   | jvm 1    | 2020/03/29 22:52:42 | 	at io.mycat.config.loader.zkprocess.comm.ZkConfig.initZk(ZkConfig.java:64)
INFO   | jvm 1    | 2020/03/29 22:52:42 | 	at io.mycat.MycatStartup.main(MycatStartup.java:45)
INFO   | jvm 1    | 2020/03/29 22:52:42 | 	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
INFO   | jvm 1    | 2020/03/29 22:52:42 | 	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
INFO   | jvm 1    | 2020/03/29 22:52:42 | 	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
INFO   | jvm 1    | 2020/03/29 22:52:42 | 	at java.lang.reflect.Method.invoke(Method.java:498)
INFO   | jvm 1    | 2020/03/29 22:52:42 | 	at org.tanukisoftware.wrapper.WrapperSimpleApp.run(WrapperSimpleApp.java:240)
INFO   | jvm 1    | 2020/03/29 22:52:42 | 	at java.lang.Thread.run(Thread.java:748)
INFO   | jvm 1    | 2020/03/29 22:52:42 | Caused by: java.lang.RuntimeException: failed to connect to zookeeper service : 192.168.0.54:2181, 192.168.0.201:2181, 192.168.0.205:2181
INFO   | jvm 1    | 2020/03/29 22:52:42 | 	at io.mycat.util.ZKUtils.createConnection(ZKUtils.java:75)
INFO   | jvm 1    | 2020/03/29 22:52:42 | 	at io.mycat.util.ZKUtils.<clinit>(ZKUtils.java:35)
INFO   | jvm 1    | 2020/03/29 22:52:42 | 	... 10 more
STATUS | wrapper  | 2020/03/29 22:52:44 | <-- Wrapper Stopped




[root@mycat01 logs]# tail -100 mycat.log 
2020-03-29 22:52:29.645  INFO [WrapperSimpleAppMain] (org.apache.curator.framework.imps.CuratorFrameworkImpl.start(CuratorFrameworkImpl.java:235)) - Starting
2020-03-29 22:52:29.649 DEBUG [WrapperSimpleAppMain] (org.apache.curator.CuratorZookeeperClient.start(CuratorZookeeperClient.java:182)) - Starting
2020-03-29 22:52:29.649 DEBUG [WrapperSimpleAppMain] (org.apache.curator.ConnectionState.start(ConnectionState.java:101)) - Starting
2020-03-29 22:52:29.649 DEBUG [WrapperSimpleAppMain] (org.apache.curator.ConnectionState.reset(ConnectionState.java:211)) - reset
2020-03-29 22:52:29.653  INFO [WrapperSimpleAppMain] (org.apache.zookeeper.Environment.logEnv(Environment.java:100)) - Client environment:zookeeper.version=3.4.6-1569965, built on 02/20/2014 09:09 GMT
2020-03-29 22:52:29.654  INFO [WrapperSimpleAppMain] (org.apache.zookeeper.Environment.logEnv(Environment.java:100)) - Client environment:host.name=mycat01
2020-03-29 22:52:29.654  INFO [WrapperSimpleAppMain] (org.apache.zookeeper.Environment.logEnv(Environment.java:100)) - Client environment:java.version=1.8.0_231
2020-03-29 22:52:29.654  INFO [WrapperSimpleAppMain] (org.apache.zookeeper.Environment.logEnv(Environment.java:100)) - Client environment:java.vendor=Oracle Corporation
2020-03-29 22:52:29.654  INFO [WrapperSimpleAppMain] (org.apache.zookeeper.Environment.logEnv(Environment.java:100)) - Client environment:java.home=/usr/local/java/jre
2020-03-29 22:52:29.654  INFO [WrapperSimpleAppMain] (org.apache.zookeeper.Environment.logEnv(Environment.java:100)) - Client environment:java.class.path=lib/wrapper.jar:conf:lib/annotations-13.0.jar:lib/asm-4.0.jar:lib/commons-collections-3.2.1.jar:lib/commons-lang-2.6.jar:lib/curator-client-2.11.0.jar:lib/curator-framework-2.11.0.jar:lib/curator-recipes-2.11.0.jar:lib/disruptor-3.3.4.jar:lib/dom4j-1.6.1.jar:lib/druid-1.0.26.jar:lib/ehcache-core-2.6.11.jar:lib/fastjson-1.2.58.jar:lib/guava-19.0.jar:lib/hamcrest-core-1.3.jar:lib/hamcrest-library-1.3.jar:lib/jline-0.9.94.jar:lib/joda-time-2.9.3.jar:lib/jsr305-2.0.3.jar:lib/kotlin-stdlib-1.3.50.jar:lib/kotlin-stdlib-common-1.3.50.jar:lib/kryo-2.10.jar:lib/leveldb-0.7.jar:lib/leveldb-api-0.7.jar:lib/libwrapper-linux-ppc-64.so:lib/libwrapper-linux-x86-32.so:lib/libwrapper-linux-x86-64.so:lib/log4j-1.2-api-2.5.jar:lib/log4j-1.2.17.jar:lib/log4j-api-2.5.jar:lib/log4j-core-2.5.jar:lib/log4j-slf4j-impl-2.5.jar:lib/mapdb-1.0.7.jar:lib/minlog-1.2.jar:lib/mongo-java-driver-3.11.0.jar:lib/Mycat-server-1.6.7.4-release.jar:lib/mysql-binlog-connector-java-0.16.1.jar:lib/mysql-connector-java-5.1.35.jar:lib/netty-3.7.0.Final.jar:lib/netty-buffer-4.1.9.Final.jar:lib/netty-common-4.1.9.Final.jar:lib/objenesis-1.2.jar:lib/okhttp-4.2.2.jar:lib/okio-2.2.2.jar:lib/reflectasm-1.03.jar:lib/sequoiadb-driver-1.12.jar:lib/slf4j-api-1.6.1.jar:lib/univocity-parsers-2.2.1.jar:lib/velocity-1.7.jar:lib/wrapper.jar:lib/zookeeper-3.4.6.jar
2020-03-29 22:52:29.654  INFO [WrapperSimpleAppMain] (org.apache.zookeeper.Environment.logEnv(Environment.java:100)) - Client environment:java.library.path=lib
2020-03-29 22:52:29.654  INFO [WrapperSimpleAppMain] (org.apache.zookeeper.Environment.logEnv(Environment.java:100)) - Client environment:java.io.tmpdir=/tmp
2020-03-29 22:52:29.654  INFO [WrapperSimpleAppMain] (org.apache.zookeeper.Environment.logEnv(Environment.java:100)) - Client environment:java.compiler=<NA>
2020-03-29 22:52:29.654  INFO [WrapperSimpleAppMain] (org.apache.zookeeper.Environment.logEnv(Environment.java:100)) - Client environment:os.name=Linux
2020-03-29 22:52:29.654  INFO [WrapperSimpleAppMain] (org.apache.zookeeper.Environment.logEnv(Environment.java:100)) - Client environment:os.arch=amd64
2020-03-29 22:52:29.654  INFO [WrapperSimpleAppMain] (org.apache.zookeeper.Environment.logEnv(Environment.java:100)) - Client environment:os.version=3.10.0-693.el7.x86_64
2020-03-29 22:52:29.654  INFO [WrapperSimpleAppMain] (org.apache.zookeeper.Environment.logEnv(Environment.java:100)) - Client environment:user.name=root
2020-03-29 22:52:29.654  INFO [WrapperSimpleAppMain] (org.apache.zookeeper.Environment.logEnv(Environment.java:100)) - Client environment:user.home=/root
2020-03-29 22:52:29.654  INFO [WrapperSimpleAppMain] (org.apache.zookeeper.Environment.logEnv(Environment.java:100)) - Client environment:user.dir=/usr/local/mycat
2020-03-29 22:52:29.655  INFO [WrapperSimpleAppMain] (org.apache.zookeeper.ZooKeeper.<init>(ZooKeeper.java:438)) - Initiating client connection, connectString=192.168.0.54:2181, 192.168.0.201:2181, 192.168.0.205:2181 sessionTimeout=60000 watcher=org.apache.curator.ConnectionState@29d245f5
2020-03-29 22:52:39.688 ERROR [WrapperSimpleAppMain] (org.apache.curator.framework.imps.CuratorFrameworkImpl.logError(CuratorFrameworkImpl.java:566)) - Background exception was not retry-able or retry gave up
java.net.UnknownHostException:  192.168.0.201: Name or service not known
	at java.net.Inet6AddressImpl.lookupAllHostAddr(Native Method) ~[?:1.8.0_231]
	at java.net.InetAddress$2.lookupAllHostAddr(InetAddress.java:929) ~[?:1.8.0_231]
	at java.net.InetAddress.getAddressesFromNameService(InetAddress.java:1324) ~[?:1.8.0_231]
	at java.net.InetAddress.getAllByName0(InetAddress.java:1277) ~[?:1.8.0_231]
	at java.net.InetAddress.getAllByName(InetAddress.java:1193) ~[?:1.8.0_231]
	at java.net.InetAddress.getAllByName(InetAddress.java:1127) ~[?:1.8.0_231]
	at org.apache.zookeeper.client.StaticHostProvider.<init>(StaticHostProvider.java:61) ~[zookeeper-3.4.6.jar:3.4.6-1569965]
	at org.apache.zookeeper.ZooKeeper.<init>(ZooKeeper.java:445) ~[zookeeper-3.4.6.jar:3.4.6-1569965]
	at org.apache.curator.utils.DefaultZookeeperFactory.newZooKeeper(DefaultZookeeperFactory.java:29) ~[curator-client-2.11.0.jar:?]
	at org.apache.curator.framework.imps.CuratorFrameworkImpl$2.newZooKeeper(CuratorFrameworkImpl.java:150) ~[curator-framework-2.11.0.jar:?]
	at org.apache.curator.HandleHolder$1.getZooKeeper(HandleHolder.java:94) ~[curator-client-2.11.0.jar:?]
	at org.apache.curator.HandleHolder.getZooKeeper(HandleHolder.java:55) ~[curator-client-2.11.0.jar:?]
	at org.apache.curator.ConnectionState.reset(ConnectionState.java:218) ~[curator-client-2.11.0.jar:?]
	at org.apache.curator.ConnectionState.start(ConnectionState.java:103) ~[curator-client-2.11.0.jar:?]
	at org.apache.curator.CuratorZookeeperClient.start(CuratorZookeeperClient.java:190) ~[curator-client-2.11.0.jar:?]
	at org.apache.curator.framework.imps.CuratorFrameworkImpl.start(CuratorFrameworkImpl.java:259) ~[curator-framework-2.11.0.jar:?]
	at io.mycat.util.ZKUtils.createConnection(ZKUtils.java:62) ~[Mycat-server-1.6.7.4-release.jar:?]
	at io.mycat.util.ZKUtils.<clinit>(ZKUtils.java:35) ~[Mycat-server-1.6.7.4-release.jar:?]
	at io.mycat.config.loader.zkprocess.zktoxml.ZktoXmlMain.buildConnection(ZktoXmlMain.java:204) ~[Mycat-server-1.6.7.4-release.jar:?]
	at io.mycat.config.loader.zkprocess.zktoxml.ZktoXmlMain.loadZktoFile(ZktoXmlMain.java:72) ~[Mycat-server-1.6.7.4-release.jar:?]
	at io.mycat.config.loader.zkprocess.comm.ZkConfig.initZk(ZkConfig.java:64) ~[Mycat-server-1.6.7.4-release.jar:?]
	at io.mycat.MycatStartup.main(MycatStartup.java:45) ~[Mycat-server-1.6.7.4-release.jar:?]
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method) ~[?:1.8.0_231]
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62) ~[?:1.8.0_231]
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43) ~[?:1.8.0_231]
	at java.lang.reflect.Method.invoke(Method.java:498) ~[?:1.8.0_231]
	at org.tanukisoftware.wrapper.WrapperSimpleApp.run(WrapperSimpleApp.java:240) ~[wrapper.jar:3.2.3]
	at java.lang.Thread.run(Thread.java:748) [?:1.8.0_231]
2020-03-29 22:52:42.689 DEBUG [WrapperSimpleAppMain] (org.apache.curator.framework.imps.CuratorFrameworkImpl.close(CuratorFrameworkImpl.java:282)) - Closing
2020-03-29 22:52:42.691 DEBUG [WrapperSimpleAppMain] (org.apache.curator.CuratorZookeeperClient.close(CuratorZookeeperClient.java:198)) - Closing
2020-03-29 22:52:42.691 DEBUG [WrapperSimpleAppMain] (org.apache.curator.ConnectionState.close(ConnectionState.java:109)) - Closing
2020-03-29 22:52:42.693  INFO [WrapperSimpleAppMain] (org.apache.zookeeper.ZooKeeper.<init>(ZooKeeper.java:438)) - Initiating client connection, connectString=192.168.0.54:2181, 192.168.0.201:2181, 192.168.0.205:2181 sessionTimeout=60000 watcher=org.apache.curator.ConnectionState@29d245f5
2020-03-29 22:52:42.694 ERROR [WrapperSimpleAppMain] (org.apache.curator.CuratorZookeeperClient.close(CuratorZookeeperClient.java:208)) - 
java.io.IOException: java.net.UnknownHostException:  192.168.0.201
	at org.apache.curator.ConnectionState.close(ConnectionState.java:119) ~[curator-client-2.11.0.jar:?]
	at org.apache.curator.CuratorZookeeperClient.close(CuratorZookeeperClient.java:203) ~[curator-client-2.11.0.jar:?]
	at org.apache.curator.framework.imps.CuratorFrameworkImpl.close(CuratorFrameworkImpl.java:321) ~[curator-framework-2.11.0.jar:?]
	at io.mycat.util.ZKUtils.createConnection(ZKUtils.java:74) ~[Mycat-server-1.6.7.4-release.jar:?]
	at io.mycat.util.ZKUtils.<clinit>(ZKUtils.java:35) ~[Mycat-server-1.6.7.4-release.jar:?]
	at io.mycat.config.loader.zkprocess.zktoxml.ZktoXmlMain.buildConnection(ZktoXmlMain.java:204) ~[Mycat-server-1.6.7.4-release.jar:?]
	at io.mycat.config.loader.zkprocess.zktoxml.ZktoXmlMain.loadZktoFile(ZktoXmlMain.java:72) ~[Mycat-server-1.6.7.4-release.jar:?]
	at io.mycat.config.loader.zkprocess.comm.ZkConfig.initZk(ZkConfig.java:64) ~[Mycat-server-1.6.7.4-release.jar:?]
	at io.mycat.MycatStartup.main(MycatStartup.java:45) ~[Mycat-server-1.6.7.4-release.jar:?]
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method) ~[?:1.8.0_231]
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62) ~[?:1.8.0_231]
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43) ~[?:1.8.0_231]
	at java.lang.reflect.Method.invoke(Method.java:498) ~[?:1.8.0_231]
	at org.tanukisoftware.wrapper.WrapperSimpleApp.run(WrapperSimpleApp.java:240) ~[wrapper.jar:3.2.3]
	at java.lang.Thread.run(Thread.java:748) [?:1.8.0_231]
Caused by: java.net.UnknownHostException:  192.168.0.201
	at java.net.InetAddress.getAllByName0(InetAddress.java:1281) ~[?:1.8.0_231]
	at java.net.InetAddress.getAllByName(InetAddress.java:1193) ~[?:1.8.0_231]
	at java.net.InetAddress.getAllByName(InetAddress.java:1127) ~[?:1.8.0_231]
	at org.apache.zookeeper.client.StaticHostProvider.<init>(StaticHostProvider.java:61) ~[zookeeper-3.4.6.jar:3.4.6-1569965]
	at org.apache.zookeeper.ZooKeeper.<init>(ZooKeeper.java:445) ~[zookeeper-3.4.6.jar:3.4.6-1569965]
	at org.apache.curator.utils.DefaultZookeeperFactory.newZooKeeper(DefaultZookeeperFactory.java:29) ~[curator-client-2.11.0.jar:?]
	at org.apache.curator.framework.imps.CuratorFrameworkImpl$2.newZooKeeper(CuratorFrameworkImpl.java:150) ~[curator-framework-2.11.0.jar:?]
	at org.apache.curator.HandleHolder$1.getZooKeeper(HandleHolder.java:94) ~[curator-client-2.11.0.jar:?]
	at org.apache.curator.HandleHolder.internalClose(HandleHolder.java:128) ~[curator-client-2.11.0.jar:?]
	at org.apache.curator.HandleHolder.closeAndClear(HandleHolder.java:71) ~[curator-client-2.11.0.jar:?]
	at org.apache.curator.ConnectionState.close(ConnectionState.java:114) ~[curator-client-2.11.0.jar:?]
	... 14 more

