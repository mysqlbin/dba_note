

启动关闭
	Sharding的启动顺序是，先启动配置服务器，在启动分片，最后启动mongos.
	mongod -f /data/mongodb/conf/config.conf
	mongod -f /data/mongodb/conf/shard1.conf
	mongod -f /data/mongodb/conf/shard2.conf
	mongod -f /data/mongodb/conf/shard3.conf
	mongos -f /data/mongodb/conf/mongos.conf
	
	