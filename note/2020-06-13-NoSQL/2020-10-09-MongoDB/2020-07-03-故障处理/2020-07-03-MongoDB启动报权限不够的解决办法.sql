1. 问题1 
2. 问题2
3. 755 和 777 区别



1. 问题1 
	2020-07-03T17:01:34.332+0800 I  CONTROL  [main] ***** SERVER RESTARTED *****
	2020-07-03T17:01:34.333+0800 I  CONTROL  [main] Automatically disabling TLS 1.0, to force-enable TLS 1.0 specify --sslDisabledProtocols 'none'
	2020-07-03T17:01:34.339+0800 W  ASIO     [main] No TransportLayer configured during NetworkInterface startup
	2020-07-03T17:01:34.340+0800 I  NETWORK  [main]  --maxConns too high, can only handle 819
	2020-07-03T17:01:34.384+0800 I  CONTROL  [initandlisten] MongoDB starting : pid=8448 port=27017 dbpath=/home/mongodb/data 64-bit host=localhost.localdomain
	2020-07-03T17:01:34.384+0800 I  CONTROL  [initandlisten] db version v4.2.7
	2020-07-03T17:01:34.384+0800 I  CONTROL  [initandlisten] git version: 51d9fe12b5d19720e72dcd7db0f2f17dd9a19212
	2020-07-03T17:01:34.384+0800 I  CONTROL  [initandlisten] OpenSSL version: OpenSSL 1.0.1e-fips 11 Feb 2013
	2020-07-03T17:01:34.384+0800 I  CONTROL  [initandlisten] allocator: tcmalloc
	2020-07-03T17:01:34.384+0800 I  CONTROL  [initandlisten] modules: none
	2020-07-03T17:01:34.385+0800 I  CONTROL  [initandlisten] build environment:
	2020-07-03T17:01:34.385+0800 I  CONTROL  [initandlisten]     distmod: rhel70
	2020-07-03T17:01:34.385+0800 I  CONTROL  [initandlisten]     distarch: x86_64
	2020-07-03T17:01:34.385+0800 I  CONTROL  [initandlisten]     target_arch: x86_64
	2020-07-03T17:01:34.385+0800 I  CONTROL  [initandlisten] options: { config: "/etc/mongodb.conf", net: { bindIp: "0.0.0.0", maxIncomingConnections: 20000, unixDomainSocket: { pathPrefix: "/home/mongodb/data" } }, processManagement: { fork: true }, replication: { replSet: "repl_set" }, security: { authorization: "enabled", keyFile: "/home/mongodb/keyfile/mongo.key" }, storage: { dbPath: "/home/mongodb/data" }, systemLog: { destination: "file", logAppend: true, path: "/home/mongodb/log/mongod.log" } }
	2020-07-03T17:01:34.385+0800 I  NETWORK  [initandlisten]  --maxConns too high, can only handle 819
	2020-07-03T17:01:34.386+0800 I  STORAGE  [initandlisten] Detected data files in /home/mongodb/data created by the 'wiredTiger' storage engine, so setting the active storage engine to 'wiredTiger'.
	2020-07-03T17:01:34.386+0800 I  STORAGE  [initandlisten] wiredtiger_open config: create,cache_size=7390M,cache_overflow=(file_max=0M),session_max=33000,eviction=(threads_min=4,threads_max=4),config_base=false,statistics=(fast),log=(enabled=true,archive=true,path=journal,compressor=snappy),file_manager=(close_idle_time=100000,close_scan_interval=10,close_handle_minimum=250),statistics_log=(wait=0),verbose=[recovery_progress,checkpoint_progress],
	2020-07-03T17:01:34.876+0800 E  STORAGE  [initandlisten] WiredTiger error (13) [1593766894:876849][8448:0x7fddc5803c40], wiredtiger_open: __posix_open_file, 667: /home/mongodb/data/WiredTiger.turtle: handle-open: open: Permission denied Raw: [1593766894:876849][8448:0x7fddc5803c40], wiredtiger_open: __posix_open_file, 667: /home/mongodb/data/WiredTiger.turtle: handle-open: open: Permission denied
	2020-07-03T17:01:34.876+0800 E  STORAGE  [initandlisten] WiredTiger error (13) [1593766894:876983][8448:0x7fddc5803c40], wiredtiger_open: __posix_open_file, 667: /home/mongodb/data/WiredTiger.turtle: handle-open: open: Permission denied Raw: [1593766894:876983][8448:0x7fddc5803c40], wiredtiger_open: __posix_open_file, 667: /home/mongodb/data/WiredTiger.turtle: handle-open: open: Permission denied
	2020-07-03T17:01:34.877+0800 E  STORAGE  [initandlisten] WiredTiger error (13) [1593766894:877095][8448:0x7fddc5803c40], wiredtiger_open: __posix_open_file, 667: /home/mongodb/data/WiredTiger.turtle: handle-open: open: Permission denied Raw: [1593766894:877095][8448:0x7fddc5803c40], wiredtiger_open: __posix_open_file, 667: /home/mongodb/data/WiredTiger.turtle: handle-open: open: Permission denied
	2020-07-03T17:01:34.877+0800 E  STORAGE  [initandlisten] WiredTiger error (13) [1593766894:877205][8448:0x7fddc5803c40], wiredtiger_open: __posix_open_file, 667: /home/mongodb/data/WiredTiger.turtle: handle-open: open: Permission denied Raw: [1593766894:877205][8448:0x7fddc5803c40], wiredtiger_open: __posix_open_file, 667: /home/mongodb/data/WiredTiger.turtle: handle-open: open: Permission denied
	2020-07-03T17:01:34.877+0800 E  STORAGE  [initandlisten] WiredTiger error (13) [1593766894:877314][8448:0x7fddc5803c40], wiredtiger_open: __posix_open_file, 667: /home/mongodb/data/WiredTiger.turtle: handle-open: open: Permission denied Raw: [1593766894:877314][8448:0x7fddc5803c40], wiredtiger_open: __posix_open_file, 667: /home/mongodb/data/WiredTiger.turtle: handle-open: open: Permission denied
	2020-07-03T17:01:34.877+0800 W  STORAGE  [initandlisten] Failed to start up WiredTiger under any compatibility version.
	2020-07-03T17:01:34.877+0800 F  STORAGE  [initandlisten] Reason: 13: Permission denied
	2020-07-03T17:01:34.877+0800 F  -        [initandlisten] Fatal Assertion 28595 at src/mongo/db/storage/wiredtiger/wiredtiger_kv_engine.cpp 915
	2020-07-03T17:01:34.877+0800 F  -        [initandlisten] 

	***aborting after fassert() failure



	[root@localhost data]# ll
	总用量 512
	-rw-------. 1 mongodb mongodb  4096 6月  18 18:21 collection-0-1643968492072062358.wt
	-rw-------. 1 mongodb mongodb 20480 7月   3 17:01 collection-0--6827962028669935839.wt
	-rw-------. 1 mongodb mongodb 20480 7月   3 17:01 collection-2-1643968492072062358.wt
	-rw-------. 1 mongodb mongodb 36864 7月   3 17:01 collection-2--6827962028669935839.wt
	-rw-------. 1 mongodb mongodb 36864 7月   3 17:01 collection-4-1643968492072062358.wt
	-rw-------. 1 mongodb mongodb  4096 6月  18 18:01 collection-4--6827962028669935839.wt
	-rw-------. 1 mongodb mongodb 20480 7月   3 17:01 collection-6-1643968492072062358.wt
	-rw-------. 1 mongodb mongodb 36864 7月   3 17:01 collection-8-1643968492072062358.wt
	drwx------. 2 mongodb mongodb  4096 7月   3 17:01 diagnostic.data
	-rw-------. 1 mongodb mongodb  4096 7月   3 17:01 index-1-1643968492072062358.wt
	-rw-------. 1 mongodb mongodb 20480 7月   3 17:01 index-1--6827962028669935839.wt
	-rw-------. 1 mongodb mongodb 20480 6月  18 18:21 index-3-1643968492072062358.wt
	-rw-------. 1 mongodb mongodb 36864 7月   3 17:01 index-3--6827962028669935839.wt
	-rw-------. 1 mongodb mongodb 20480 6月  18 18:21 index-5-1643968492072062358.wt
	-rw-------. 1 mongodb mongodb  4096 6月  18 18:01 index-5--6827962028669935839.wt
	-rw-------. 1 mongodb mongodb 12288 6月  18 18:05 index-6--6827962028669935839.wt
	-rw-------. 1 mongodb mongodb 20480 7月   3 17:01 index-7-1643968492072062358.wt
	-rw-------. 1 mongodb mongodb 20480 6月  18 18:21 index-9-1643968492072062358.wt
	drwx------. 2 mongodb mongodb   110 7月   3 16:54 journal
	-rw-------. 1 mongodb mongodb 36864 7月   3 17:01 _mdb_catalog.wt
	srwx------. 1 mongodb mongodb     0 7月   3 17:01 mongodb-27017.sock
	-rw-------. 1 mongodb mongodb     0 7月   3 17:01 mongod.lock
	-rw-------. 1 mongodb mongodb 36864 7月   3 17:01 sizeStorer.wt
	-rw-------. 1 mongodb mongodb   114 6月  18 18:00 storage.bson
	-rw-------. 1 mongodb mongodb    46 6月  18 18:00 WiredTiger
	-rw-------. 1 root    root     4096 7月   3 17:01 WiredTigerLAS.wt
	-rw-------. 1 mongodb mongodb    21 6月  18 18:00 WiredTiger.lock
	-rw-------. 1 root    root     1260 7月   3 17:01 WiredTiger.turtle
	-rw-------. 1 mongodb mongodb 86016 7月   3 17:01 WiredTiger.wt

	解决办法
		chown -R mongodb:mongodb *

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


2.问题2
	2020-07-03T18:05:17.538+0800 I  CONTROL  [main] ***** SERVER RESTARTED *****
	2020-07-03T18:05:17.542+0800 I  CONTROL  [main] Automatically disabling TLS 1.0, to force-enable TLS 1.0 specify --sslDisabledProtocols 'none'
	2020-07-03T18:05:17.546+0800 W  ASIO     [main] No TransportLayer configured during NetworkInterface startup
	2020-07-03T18:05:17.547+0800 I  NETWORK  [main]  --maxConns too high, can only handle 819
	2020-07-03T18:05:17.593+0800 I  CONTROL  [initandlisten] MongoDB starting : pid=10487 port=27017 dbpath=/home/mongodb/data 64-bit host=localhost.localdomain
	2020-07-03T18:05:17.593+0800 I  CONTROL  [initandlisten] db version v4.2.7
	2020-07-03T18:05:17.593+0800 I  CONTROL  [initandlisten] git version: 51d9fe12b5d19720e72dcd7db0f2f17dd9a19212
	2020-07-03T18:05:17.593+0800 I  CONTROL  [initandlisten] OpenSSL version: OpenSSL 1.0.1e-fips 11 Feb 2013
	2020-07-03T18:05:17.593+0800 I  CONTROL  [initandlisten] allocator: tcmalloc
	2020-07-03T18:05:17.593+0800 I  CONTROL  [initandlisten] modules: none
	2020-07-03T18:05:17.593+0800 I  CONTROL  [initandlisten] build environment:
	2020-07-03T18:05:17.593+0800 I  CONTROL  [initandlisten]     distmod: rhel70
	2020-07-03T18:05:17.593+0800 I  CONTROL  [initandlisten]     distarch: x86_64
	2020-07-03T18:05:17.593+0800 I  CONTROL  [initandlisten]     target_arch: x86_64
	2020-07-03T18:05:17.593+0800 I  CONTROL  [initandlisten] options: { config: "/etc/mongodb.conf", net: { bindIp: "0.0.0.0", maxIncomingConnections: 20000, unixDomainSocket: { pathPrefix: "/home/mongodb/data" } }, processManagement: { fork: true }, replication: { replSet: "repl_set" }, security: { authorization: "enabled", keyFile: "/home/mongodb/keyfile/mongo.key" }, storage: { dbPath: "/home/mongodb/data" }, systemLog: { destination: "file", logAppend: true, path: "/home/mongodb/log/mongod.log" } }
	2020-07-03T18:05:17.593+0800 I  NETWORK  [initandlisten]  --maxConns too high, can only handle 819
	2020-07-03T18:05:17.593+0800 I  STORAGE  [initandlisten] Detected data files in /home/mongodb/data created by the 'wiredTiger' storage engine, so setting the active storage engine to 'wiredTiger'.
	2020-07-03T18:05:17.593+0800 I  STORAGE  [initandlisten] wiredtiger_open config: create,cache_size=7390M,cache_overflow=(file_max=0M),session_max=33000,eviction=(threads_min=4,threads_max=4),config_base=false,statistics=(fast),log=(enabled=true,archive=true,path=journal,compressor=snappy),file_manager=(close_idle_time=100000,close_scan_interval=10,close_handle_minimum=250),statistics_log=(wait=0),verbose=[recovery_progress,checkpoint_progress],
	2020-07-03T18:05:18.094+0800 E  STORAGE  [initandlisten] WiredTiger error (13) [1593770718:94064][10487:0x7fedb1ed9c40], connection: __posix_fs_remove, 206: /home/mongodb/data/journal/WiredTigerPreplog.0000000001: file-remove: unlink: Permission denied Raw: [1593770718:94064][10487:0x7fedb1ed9c40], connection: __posix_fs_remove, 206: /home/mongodb/data/journal/WiredTigerPreplog.0000000001: file-remove: unlink: Permission denied
	2020-07-03T18:05:18.101+0800 E  STORAGE  [initandlisten] WiredTiger error (13) [1593770718:101047][10487:0x7fedb1ed9c40], connection: __posix_fs_remove, 206: /home/mongodb/data/journal/WiredTigerPreplog.0000000001: file-remove: unlink: Permission denied Raw: [1593770718:101047][10487:0x7fedb1ed9c40], connection: __posix_fs_remove, 206: /home/mongodb/data/journal/WiredTigerPreplog.0000000001: file-remove: unlink: Permission denied
	2020-07-03T18:05:18.108+0800 E  STORAGE  [initandlisten] WiredTiger error (13) [1593770718:107995][10487:0x7fedb1ed9c40], connection: __posix_fs_remove, 206: /home/mongodb/data/journal/WiredTigerPreplog.0000000001: file-remove: unlink: Permission denied Raw: [1593770718:107995][10487:0x7fedb1ed9c40], connection: __posix_fs_remove, 206: /home/mongodb/data/journal/WiredTigerPreplog.0000000001: file-remove: unlink: Permission denied
	2020-07-03T18:05:18.114+0800 E  STORAGE  [initandlisten] WiredTiger error (13) [1593770718:114909][10487:0x7fedb1ed9c40], connection: __posix_fs_remove, 206: /home/mongodb/data/journal/WiredTigerPreplog.0000000001: file-remove: unlink: Permission denied Raw: [1593770718:114909][10487:0x7fedb1ed9c40], connection: __posix_fs_remove, 206: /home/mongodb/data/journal/WiredTigerPreplog.0000000001: file-remove: unlink: Permission denied
	2020-07-03T18:05:18.116+0800 W  STORAGE  [initandlisten] Failed to start up WiredTiger under any compatibility version.
	2020-07-03T18:05:18.116+0800 F  STORAGE  [initandlisten] Reason: 13: Permission denied
	2020-07-03T18:05:18.116+0800 F  -        [initandlisten] Fatal Assertion 28595 at src/mongo/db/storage/wiredtiger/wiredtiger_kv_engine.cpp 915
	2020-07-03T18:05:18.116+0800 F  -        [initandlisten] 

	***aborting after fassert() failure


	[root@localhost data]# ll
	总用量 512
	-rw-------. 1 mongodb mongodb  4096 6月  18 18:21 collection-0-1643968492072062358.wt
	-rw-------. 1 mongodb mongodb 20480 7月   3 17:49 collection-0--6827962028669935839.wt
	-rw-------. 1 mongodb mongodb 20480 7月   3 17:49 collection-2-1643968492072062358.wt
	-rw-------. 1 mongodb mongodb 36864 7月   3 17:49 collection-2--6827962028669935839.wt
	-rw-------. 1 mongodb mongodb 36864 7月   3 17:49 collection-4-1643968492072062358.wt
	-rw-------. 1 mongodb mongodb  4096 6月  18 18:01 collection-4--6827962028669935839.wt
	-rw-------. 1 mongodb mongodb 20480 7月   3 17:49 collection-6-1643968492072062358.wt
	-rw-------. 1 mongodb mongodb 36864 7月   3 17:49 collection-8-1643968492072062358.wt
	drw-------. 2 mongodb mongodb  4096 7月   3 17:49 diagnostic.data
	-rw-------. 1 mongodb mongodb  4096 7月   3 17:49 index-1-1643968492072062358.wt
	-rw-------. 1 mongodb mongodb 20480 7月   3 17:49 index-1--6827962028669935839.wt
	-rw-------. 1 mongodb mongodb 20480 6月  18 18:21 index-3-1643968492072062358.wt
	-rw-------. 1 mongodb mongodb 36864 7月   3 17:49 index-3--6827962028669935839.wt
	-rw-------. 1 mongodb mongodb 20480 6月  18 18:21 index-5-1643968492072062358.wt
	-rw-------. 1 mongodb mongodb  4096 6月  18 18:01 index-5--6827962028669935839.wt
	-rw-------. 1 mongodb mongodb 12288 6月  18 18:05 index-6--6827962028669935839.wt
	-rw-------. 1 mongodb mongodb 20480 7月   3 17:49 index-7-1643968492072062358.wt
	-rw-------. 1 mongodb mongodb 20480 6月  18 18:21 index-9-1643968492072062358.wt
	drw-------. 2 mongodb mongodb   110 7月   3 17:11 journal
	-rw-------. 1 mongodb mongodb 36864 7月   3 17:49 _mdb_catalog.wt
	srwx------. 1 mongodb mongodb     0 7月   3 18:05 mongodb-27017.sock
	-rw-------. 1 mongodb mongodb     0 7月   3 17:49 mongod.lock
	-rw-------. 1 mongodb mongodb 36864 7月   3 17:49 sizeStorer.wt
	-rw-------. 1 mongodb mongodb   114 6月  18 18:00 storage.bson
	-rw-------. 1 mongodb mongodb    46 6月  18 18:00 WiredTiger
	-rw-------. 1 mongodb mongodb  4096 7月   3 17:49 WiredTigerLAS.wt
	-rw-------. 1 mongodb mongodb    21 6月  18 18:00 WiredTiger.lock
	-rw-------. 1 mongodb mongodb  1260 7月   3 17:49 WiredTiger.turtle
	-rw-------. 1 mongodb mongodb 86016 7月   3 18:05 WiredTiger.wt
	[root@localhost data]# 
	[root@localhost data]# cd journal/
	[root@localhost journal]# ll
	总用量 307200
	-rw-------. 1 mongodb mongodb 104857600 7月   3 17:49 WiredTigerLog.0000000007
	-rw-------. 1 mongodb mongodb 104857600 7月   3 17:10 WiredTigerPreplog.0000000001
	-rw-------. 1 mongodb mongodb 104857600 7月   3 17:10 WiredTigerPreplog.0000000002


	[root@localhost data]# ll
	total 24
	drwxr-xr-x 4 mongodb mongodb 12288 2020-07-03 18:28 data
	drwxr-xr-x 2 mongodb mongodb  4096 2020-06-17 16:22 keyfile
	drwxr-xr-x 2 mongodb mongodb  4096 2020-06-19 15:01 log
	drwxr-xr-x 2 mongodb mongodb  4096 2020-06-15 10:24 run

	解决办法：
		[root@localhost mongodb]# chmod -R 777 data
		[root@localhost mongodb]# ll
		总用量 4
		drwxrwxrwx. 4 mongodb mongodb 4096 7月   3 18:20 data
		drwxr-xr-x. 2 mongodb mongodb   23 6月  18 18:16 keyfile
		drwxr-xr-x. 2 mongodb mongodb   24 6月  18 18:00 log
		drwxr-xr-x. 2 mongodb mongodb    6 6月  18 17:58 run
		[root@localhost mongodb]# service mongodb start
		Redirecting to /bin/systemctl start  mongodb.service
		
		https://blog.csdn.net/qq_21959759/article/details/90034284  MongoDB：WiredTiger error (13) 问题解决.


3. 755 和 777 区别

