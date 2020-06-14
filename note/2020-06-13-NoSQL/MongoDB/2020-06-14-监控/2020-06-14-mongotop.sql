
mongotop:
	类似于 top 工具， 通过监控信息可以知道哪个集合最为繁忙
[root@env30 journal]# mongotop -h 192.168.1.31 -u admin -p admin --authenticationDatabase=admin
2020-06-14T02:28:57.273+0800	connected to: mongodb://192.168.1.31/

                    ns    total    read    write    2020-06-14T02:28:58+08:00
  admin.$cmd.aggregate      0ms     0ms      0ms                             
    admin.system.roles      0ms     0ms      0ms                             
    admin.system.users      0ms     0ms      0ms                             
  admin.system.version      0ms     0ms      0ms                             
config.system.sessions      0ms     0ms      0ms                             
   config.transactions      0ms     0ms      0ms                             
        local.oplog.rs      0ms     0ms      0ms                             
  local.system.replset      0ms     0ms      0ms                             
          sbtest_db.t1      0ms     0ms      0ms                             
       sbtest_db_02.t1      0ms     0ms      0ms                             

                    ns    total    read    write    2020-06-14T02:28:59+08:00
  admin.$cmd.aggregate      0ms     0ms      0ms                             
    admin.system.roles      0ms     0ms      0ms                             
    admin.system.users      0ms     0ms      0ms                             
  admin.system.version      0ms     0ms      0ms                             
config.system.sessions      0ms     0ms      0ms                             
   config.transactions      0ms     0ms      0ms                             
        local.oplog.rs      0ms     0ms      0ms                             
  local.system.replset      0ms     0ms      0ms                             
          sbtest_db.t1      0ms     0ms      0ms                             
       sbtest_db_02.t1      0ms     0ms      0ms                             


ns：包含数据库命名空间，后者结合了数据库名称和集合。

db：包含数据库的名称。名为 . 的数据库针对全局锁定，而非特定数据库。

total：mongod在这个命令空间上花费的总时间。

read：在这个命令空间上mongod执行读操作花费的时间。

write：在这个命名空间上mongod进行写操作花费的时间。

