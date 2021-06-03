

192.168.0.202 


mkdir -p /home/mongodb/router/{conf,log}

chown -R mongodb:mongodb  /home/mongodb/router/*

mongos 需要配置高可用不




mongos  --config  /home/mongodb/router/conf/router.conf


mongo -port 20000



本来只有1个 mongos，现在搭建的是第2个

[root@localhost conf]# mongo -port 20000
MongoDB shell version v4.2.7
connecting to: mongodb://127.0.0.1:20000/?compressors=disabled&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("71a9bd92-dd27-48b3-91f3-6908ad70aad8") }
MongoDB server version: 4.2.7
Server has startup warnings: 
2021-06-02T03:08:09.160+0800 I  CONTROL  [main] 
2021-06-02T03:08:09.160+0800 I  CONTROL  [main] ** WARNING: Access control is not enabled for the database.
2021-06-02T03:08:09.160+0800 I  CONTROL  [main] **          Read and write access to data and configuration is unrestricted.
2021-06-02T03:08:09.160+0800 I  CONTROL  [main] ** WARNING: You are running this process as the root user, which is not recommended.
2021-06-02T03:08:09.160+0800 I  CONTROL  [main] 
mongos> show dbs
01_db   0.008GB
02_db   0.004GB
03_db   0.015GB
04_db   0.017GB
05_db   0.008GB
admin   0.000GB
config  0.004GB





mongos 的高可用感觉是需要虚拟IP来构建。















