
mkdir -p /home/mongodb/router/{conf,log}

chown -R mongodb:mongodb  /home/mongodb/router/*

mongos 需要配置高可用不




mongos  --config  /home/mongodb/router/conf/router.conf


mongo -port 20000


-------------------------------------------------
sharding:
  configDB: configserver/192.168.0.201:21000
  
[root@localhost conf]# mongos  --config  /home/mongodb/router/conf/router.conf
2021-05-31T08:54:47.969+0800 W  SHARDING [main] Running a sharded cluster with fewer than 3 config servers should only be done for testing purposes and is not recommended for production.
about to fork child process, waiting until server is ready for connections.
forked process: 15367
child process started successfully, parent exiting
