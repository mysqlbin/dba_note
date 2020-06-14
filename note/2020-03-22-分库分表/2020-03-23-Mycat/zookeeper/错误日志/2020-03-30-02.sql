

[root@mycat05 ~]# sh /usr/local/mycat/bin/init_zk_data.sh
o2020-03-30 06:29:47 INFO JAVA_CMD=/usr/local/java/bin/java
o2020-03-30 06:29:47 INFO Start to initialize /mycat of ZooKeeper
2020-03-30 06:29:50,698 Thread-1 ERROR Unable to register shutdown hook because JVM is shutting down. java.lang.IllegalStateException: Cannot add new shutdown hook as this is not started. Current state: STOPPED
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

o2020-03-30 06:29:50 INFO Done


