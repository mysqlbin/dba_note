
repl_set:PRIMARY> show dbs
abc_db            0.000GB
admin             0.000GB
benet             0.000GB
config            0.000GB
local             0.016GB
niuniu_h5         0.000GB
niuniuh5_modb     6.726GB
niuniuh5_modb_02  6.284GB

13GB的纯数据大小；
共占用磁盘空间38GB.

同步到副库的时间： 17:54:48 至 18:13:11，即耗时约18分钟。



2020-06-16T17:54:47.110+0800 I  STORAGE  [replexec-0] createCollection: local.system.replset with generated UUID: c41c394e-2957-42a0-9620-7f001cba9c96 and options: {}
2020-06-16T17:54:47.125+0800 I  INDEX    [replexec-0] index build: done building index _id_ on ns local.system.replset
2020-06-16T17:54:47.126+0800 I  REPL     [replexec-0] New replica set config in use: { _id: "repl_set", version: 1, protocolVersion: 1, writeConcernMajorityJournalDefault: true, members: [ { _id: 0, host: "10.31.76.149:27017", arbiterOnly: false, buildIndexes: true, hidden: false, priority: 1.0, tags: {}, slaveDelay: 0, votes: 1 }, { _id: 1, host: "10.31.76.227:27017", arbiterOnly: false, buildIndexes: true, hidden: false, priority: 1.0, tags: {}, slaveDelay: 0, votes: 1 } ], settings: { chainingAllowed: true, heartbeatIntervalMillis: 2000, heartbeatTimeoutSecs: 10, electionTimeoutMillis: 10000, catchUpTimeoutMillis: -1, catchUpTakeoverDelayMillis: 30000, getLastErrorModes: {}, getLastErrorDefaults: { w: 1, wtimeout: 0 }, replicaSetId: ObjectId('5ee896e693645646ec0f3c06') } }
2020-06-16T17:54:47.126+0800 I  REPL     [replexec-0] This node is 10.31.76.227:27017 in the config
2020-06-16T17:54:47.126+0800 I  REPL     [replexec-0] transition to STARTUP2 from STARTUP
2020-06-16T17:54:47.126+0800 I  REPL     [replexec-0] Starting replication storage threads
2020-06-16T17:54:47.127+0800 I  REPL     [replexec-1] Member 10.31.76.149:27017 is now in state SECONDARY
2020-06-16T17:54:47.129+0800 I  STORAGE  [replexec-0] createCollection: local.temp_oplog_buffer with generated UUID: c79593c6-bc24-4be0-b8cc-d80fbc2a3c3f and options: { temp: true }
2020-06-16T17:54:47.143+0800 I  INDEX    [replexec-0] index build: done building index _id_ on ns local.temp_oplog_buffer


2020-06-16T17:54:47.143+0800 I  INITSYNC [replication-0] Starting initial sync (attempt 1 of 10)
2020-06-16T17:54:47.144+0800 I  STORAGE  [replication-0] Finishing collection drop for local.temp_oplog_buffer (c79593c6-bc24-4be0-b8cc-d80fbc2a3c3f).
2020-06-16T17:54:47.145+0800 I  STORAGE  [replication-0] createCollection: local.temp_oplog_buffer with generated UUID: 4c44bbb9-5165-40b6-ad32-544a669a6ab0 and options: { temp: true }
2020-06-16T17:54:47.159+0800 I  INDEX    [replication-0] index build: done building index _id_ on ns local.temp_oplog_buffer
2020-06-16T17:54:47.159+0800 I  REPL     [replication-0] waiting for 1 pings from other members before syncing
2020-06-16T17:54:48.159+0800 I  REPL     [replication-1] sync source candidate: 10.31.76.149:27017


2020-06-16T17:54:48.159+0800 I  INITSYNC [replication-1] Initial syncer oplog truncation finished in: 0ms
2020-06-16T17:54:48.159+0800 I  REPL     [replication-1] ******
2020-06-16T17:54:48.159+0800 I  REPL     [replication-1] creating replication oplog of size: 1578MB...
2020-06-16T17:54:48.159+0800 I  STORAGE  [replication-1] createCollection: local.oplog.rs with generated UUID: 4377cc8f-8951-478d-8cf1-f1fd8ad7adc0 and options: { capped: true, size: 1655473766.0, autoIndexId: false }
2020-06-16T17:54:48.199+0800 I  STORAGE  [replication-1] Starting OplogTruncaterThread local.oplog.rs
2020-06-16T17:54:48.199+0800 I  STORAGE  [replication-1] The size storer reports that the oplog contains 0 records totaling to 0 bytes
2020-06-16T17:54:48.199+0800 I  STORAGE  [replication-1] Scanning the oplog to determine where to place markers for truncation
2020-06-16T17:54:48.199+0800 I  STORAGE  [replication-1] WiredTiger record store oplog processing took 0ms
2020-06-16T17:54:48.228+0800 I  REPL     [replication-1] ******
2020-06-16T17:54:48.228+0800 I  REPL     [replication-1] dropReplicatedDatabases - dropping 5 databases
2020-06-16T17:54:48.587+0800 I  REPL     [replication-1] dropReplicatedDatabases - dropped 5 databases
2020-06-16T17:54:48.587+0800 I  CONNPOOL [RS] Connecting to 10.31.76.149:27017
2020-06-16T17:54:48.592+0800 I  SHARDING [replication-1] Marking collection local.temp_oplog_buffer as collection version: <unsharded>
2020-06-16T17:54:48.592+0800 I  INITSYNC [replication-0] CollectionCloner::start called, on ns:admin.system.users
2020-06-16T17:54:48.593+0800 I  STORAGE  [repl-writer-worker-0] createCollection: admin.system.users with provided UUID: 79552327-27a1-4946-97ec-5fd26feb932d and options: { uuid: UUID("79552327-27a1-4946-97ec-5fd26feb932d") }
2020-06-16T17:54:48.610+0800 I  INDEX    [repl-writer-worker-0] index build: starting on admin.system.users properties: { v: 2, unique: true, key: { user: 1, db: 1 }, name: "user_1_db_1", ns: "admin.system.users" } using method: Foreground
2020-06-16T17:54:48.610+0800 I  INDEX    [repl-writer-worker-0] build may temporarily use up to 200 megabytes of RAM
2020-06-16T17:54:48.617+0800 I  INDEX    [repl-writer-worker-0] index build: starting on admin.system.users properties: { v: 2, key: { _id: 1 }, name: "_id_", ns: "admin.system.users" } using method: Foreground
2020-06-16T17:54:48.617+0800 I  INDEX    [repl-writer-worker-0] build may temporarily use up to 200 megabytes of RAM
2020-06-16T17:54:48.619+0800 I  SHARDING [repl-writer-worker-15] Marking collection admin.system.users as collection version: <unsharded>
2020-06-16T17:54:48.619+0800 I  INITSYNC [replication-1] CollectionCloner ns:admin.system.users finished cloning with status: OK
2020-06-16T17:54:48.620+0800 I  INDEX    [replication-1] index build: inserted 1 keys from external sorter into index in 0 seconds
2020-06-16T17:54:48.623+0800 I  INDEX    [replication-1] index build: done building index user_1_db_1 on ns admin.system.users
2020-06-16T17:54:48.624+0800 I  INDEX    [replication-1] index build: inserted 1 keys from external sorter into index in 0 seconds
2020-06-16T17:54:48.626+0800 I  INDEX    [replication-1] index build: done building index _id_ on ns admin.system.users
2020-06-16T17:54:48.626+0800 I  INITSYNC [replication-1] CollectionCloner::start called, on ns:admin.system.version
2020-06-16T17:54:48.628+0800 I  STORAGE  [repl-writer-worker-1] createCollection: admin.system.version with provided UUID: fcb8cf73-9c2c-4256-b598-980c45eb62c3 and options: { uuid: UUID("fcb8cf73-9c2c-4256-b598-980c45eb62c3") }
2020-06-16T17:54:48.642+0800 I  INDEX    [repl-writer-worker-1] index build: starting on admin.system.version properties: { v: 2, key: { _id: 1 }, name: "_id_", ns: "admin.system.version" } using method: Foreground
2020-06-16T17:54:48.642+0800 I  INDEX    [repl-writer-worker-1] build may temporarily use up to 200 megabytes of RAM
2020-06-16T17:54:48.644+0800 I  COMMAND  [repl-writer-worker-2] setting featureCompatibilityVersion to 4.2
2020-06-16T17:54:48.644+0800 I  NETWORK  [repl-writer-worker-2] Skip closing connection for connection # 2
2020-06-16T17:54:48.644+0800 I  INITSYNC [replication-0] CollectionCloner ns:admin.system.version finished cloning with status: OK
2020-06-16T17:54:48.645+0800 I  INDEX    [replication-0] index build: inserted 2 keys from external sorter into index in 0 seconds
2020-06-16T17:54:48.647+0800 I  INDEX    [replication-0] index build: done building index _id_ on ns admin.system.version
2020-06-16T17:54:48.649+0800 I  INITSYNC [replication-1] CollectionCloner::start called, on ns:benet.t2
2020-06-16T17:54:48.650+0800 I  STORAGE  [repl-writer-worker-3] createCollection: benet.t2 with provided UUID: 5f2a6519-8504-4d6d-9865-8d71a4bff48f and options: { uuid: UUID("5f2a6519-8504-4d6d-9865-8d71a4bff48f") }
2020-06-16T17:54:48.684+0800 I  INDEX    [repl-writer-worker-3] index build: starting on benet.t2 properties: { v: 2, key: { _id: 1 }, name: "_id_", ns: "benet.t2" } using method: Hybrid
2020-06-16T17:54:48.684+0800 I  INDEX    [repl-writer-worker-3] build may temporarily use up to 200 megabytes of RAM
2020-06-16T17:54:48.688+0800 I  SHARDING [repl-writer-worker-4] Marking collection benet.t2 as collection version: <unsharded>
2020-06-16T17:54:48.689+0800 I  INITSYNC [replication-0] CollectionCloner ns:benet.t2 finished cloning with status: OK
2020-06-16T17:54:48.690+0800 I  INDEX    [replication-0] index build: inserted 1 keys from external sorter into index in 0 seconds
2020-06-16T17:54:48.692+0800 I  INDEX    [replication-0] index build: done building index _id_ on ns benet.t2
2020-06-16T17:54:48.694+0800 I  INITSYNC [replication-0] CollectionCloner::start called, on ns:benet.t1
2020-06-16T17:54:48.695+0800 I  STORAGE  [repl-writer-worker-5] createCollection: benet.t1 with provided UUID: 6f58986a-47bc-4b1e-8c08-627ffbb138bc and options: { uuid: UUID("6f58986a-47bc-4b1e-8c08-627ffbb138bc") }
2020-06-16T17:54:48.724+0800 I  INDEX    [repl-writer-worker-5] index build: starting on benet.t1 properties: { v: 2, key: { _id: 1 }, name: "_id_", ns: "benet.t1" } using method: Hybrid
2020-06-16T17:54:48.724+0800 I  INDEX    [repl-writer-worker-5] build may temporarily use up to 200 megabytes of RAM
2020-06-16T17:54:48.729+0800 I  SHARDING [repl-writer-worker-6] Marking collection benet.t1 as collection version: <unsharded>
2020-06-16T17:54:48.729+0800 I  INITSYNC [replication-1] CollectionCloner ns:benet.t1 finished cloning with status: OK
2020-06-16T17:54:48.730+0800 I  INDEX    [replication-1] index build: inserted 3 keys from external sorter into index in 0 seconds
2020-06-16T17:54:48.733+0800 I  INDEX    [replication-1] index build: done building index _id_ on ns benet.t1
2020-06-16T17:54:48.734+0800 I  INITSYNC [replication-1] CollectionCloner::start called, on ns:benet.table_clubgamelog04
2020-06-16T17:54:48.735+0800 I  STORAGE  [repl-writer-worker-7] createCollection: benet.table_clubgamelog04 with provided UUID: 9208662c-32be-400b-b1a4-c40b5c709854 and options: { uuid: UUID("9208662c-32be-400b-b1a4-c40b5c709854") }
2020-06-16T17:54:48.763+0800 I  INDEX    [repl-writer-worker-7] index build: starting on benet.table_clubgamelog04 properties: { v: 2, key: { _id: 1 }, name: "_id_", ns: "benet.table_clubgamelog04" } using method: Hybrid
2020-06-16T17:54:48.763+0800 I  INDEX    [repl-writer-worker-7] build may temporarily use up to 200 megabytes of RAM
2020-06-16T17:54:48.767+0800 I  SHARDING [repl-writer-worker-8] Marking collection benet.table_clubgamelog04 as collection version: <unsharded>
2020-06-16T17:54:48.767+0800 I  INITSYNC [replication-0] CollectionCloner ns:benet.table_clubgamelog04 finished cloning with status: OK
2020-06-16T17:54:48.768+0800 I  INDEX    [replication-0] index build: inserted 2 keys from external sorter into index in 0 seconds
2020-06-16T17:54:48.771+0800 I  INDEX    [replication-0] index build: done building index _id_ on ns benet.table_clubgamelog04
2020-06-16T17:54:48.772+0800 I  INITSYNC [replication-0] CollectionCloner::start called, on ns:benet.table_clubgamelog
2020-06-16T17:54:48.773+0800 I  STORAGE  [repl-writer-worker-9] createCollection: benet.table_clubgamelog with provided UUID: 9ce17356-c5d9-49b5-b255-e6ab1ced4524 and options: { uuid: UUID("9ce17356-c5d9-49b5-b255-e6ab1ced4524") }
2020-06-16T17:54:48.801+0800 I  INDEX    [repl-writer-worker-9] index build: starting on benet.table_clubgamelog properties: { v: 2, key: { _id: 1 }, name: "_id_", ns: "benet.table_clubgamelog" } using method: Hybrid
2020-06-16T17:54:48.801+0800 I  INDEX    [repl-writer-worker-9] build may temporarily use up to 200 megabytes of RAM
2020-06-16T17:54:48.805+0800 I  SHARDING [repl-writer-worker-10] Marking collection benet.table_clubgamelog as collection version: <unsharded>
2020-06-16T17:54:48.805+0800 I  INITSYNC [replication-1] CollectionCloner ns:benet.table_clubgamelog finished cloning with status: OK
2020-06-16T17:54:48.806+0800 I  INDEX    [replication-1] index build: inserted 2 keys from external sorter into index in 0 seconds
2020-06-16T17:54:48.808+0800 I  INDEX    [replication-1] index build: done building index _id_ on ns benet.table_clubgamelog
2020-06-16T17:54:48.811+0800 I  INITSYNC [replication-1] CollectionCloner::start called, on ns:benet.t1_mysql
2020-06-16T17:54:48.812+0800 I  STORAGE  [repl-writer-worker-11] createCollection: benet.t1_mysql with provided UUID: c96386f0-ab2c-41f8-9cec-25cc52457cbe and options: { uuid: UUID("c96386f0-ab2c-41f8-9cec-25cc52457cbe") }
2020-06-16T17:54:48.843+0800 I  INDEX    [repl-writer-worker-11] index build: starting on benet.t1_mysql properties: { v: 2, key: { _id: 1 }, name: "_id_", ns: "benet.t1_mysql" } using method: Hybrid
2020-06-16T17:54:48.844+0800 I  INDEX    [repl-writer-worker-11] build may temporarily use up to 200 megabytes of RAM
2020-06-16T17:54:48.848+0800 I  SHARDING [repl-writer-worker-12] Marking collection benet.t1_mysql as collection version: <unsharded>
2020-06-16T17:54:48.848+0800 I  INITSYNC [replication-0] CollectionCloner ns:benet.t1_mysql finished cloning with status: OK
2020-06-16T17:54:48.849+0800 I  INDEX    [replication-0] index build: inserted 1 keys from external sorter into index in 0 seconds
2020-06-16T17:54:48.852+0800 I  INDEX    [replication-0] index build: done building index _id_ on ns benet.t1_mysql
2020-06-16T17:54:48.855+0800 I  INITSYNC [replication-0] CollectionCloner::start called, on ns:benet.table_clubgamelogs
2020-06-16T17:54:48.856+0800 I  STORAGE  [repl-writer-worker-13] createCollection: benet.table_clubgamelogs with provided UUID: d254f5c8-9510-4fdf-9824-703e10a81d9c and options: { uuid: UUID("d254f5c8-9510-4fdf-9824-703e10a81d9c") }
2020-06-16T17:54:48.883+0800 I  INDEX    [repl-writer-worker-13] index build: starting on benet.table_clubgamelogs properties: { v: 2, key: { _id: 1 }, name: "_id_", ns: "benet.table_clubgamelogs" } using method: Hybrid
2020-06-16T17:54:48.883+0800 I  INDEX    [repl-writer-worker-13] build may temporarily use up to 200 megabytes of RAM
2020-06-16T17:54:48.887+0800 I  SHARDING [repl-writer-worker-14] Marking collection benet.table_clubgamelogs as collection version: <unsharded>
2020-06-16T17:54:48.887+0800 I  INITSYNC [replication-1] CollectionCloner ns:benet.table_clubgamelogs finished cloning with status: OK
2020-06-16T17:54:48.888+0800 I  INDEX    [replication-1] index build: inserted 2 keys from external sorter into index in 0 seconds
2020-06-16T17:54:48.890+0800 I  INDEX    [replication-1] index build: done building index _id_ on ns benet.table_clubgamelogs
2020-06-16T17:54:48.895+0800 I  INITSYNC [replication-0] CollectionCloner::start called, on ns:config.system.sessions
2020-06-16T17:54:48.896+0800 I  STORAGE  [repl-writer-worker-0] createCollection: config.system.sessions with provided UUID: 2fabfde4-11d6-469e-ae9b-eeff861f3a57 and options: { uuid: UUID("2fabfde4-11d6-469e-ae9b-eeff861f3a57") }
2020-06-16T17:54:48.918+0800 I  INDEX    [repl-writer-worker-0] index build: starting on config.system.sessions properties: { v: 2, key: { lastUse: 1 }, name: "lsidTTLIndex", ns: "config.system.sessions", expireAfterSeconds: 1800 } using method: Hybrid
2020-06-16T17:54:48.918+0800 I  INDEX    [repl-writer-worker-0] build may temporarily use up to 200 megabytes of RAM
2020-06-16T17:54:48.940+0800 I  INDEX    [repl-writer-worker-0] index build: starting on config.system.sessions properties: { v: 2, key: { _id: 1 }, name: "_id_", ns: "config.system.sessions" } using method: Hybrid
2020-06-16T17:54:48.940+0800 I  INDEX    [repl-writer-worker-0] build may temporarily use up to 200 megabytes of RAM
2020-06-16T17:54:48.943+0800 I  INITSYNC [replication-1] CollectionCloner ns:config.system.sessions finished cloning with status: OK
2020-06-16T17:54:48.944+0800 I  INDEX    [replication-1] index build: inserted 0 keys from external sorter into index in 0 seconds
2020-06-16T17:54:48.946+0800 I  INDEX    [replication-1] index build: done building index lsidTTLIndex on ns config.system.sessions
2020-06-16T17:54:48.947+0800 I  INDEX    [replication-1] index build: inserted 0 keys from external sorter into index in 0 seconds
2020-06-16T17:54:48.949+0800 I  INDEX    [replication-1] index build: done building index _id_ on ns config.system.sessions
2020-06-16T17:54:48.956+0800 I  INITSYNC [replication-0] CollectionCloner::start called, on ns:niuniuh5_modb.table_clubgamescorerobotdetail
2020-06-16T17:54:48.957+0800 I  STORAGE  [repl-writer-worker-15] createCollection: niuniuh5_modb.table_clubgamescorerobotdetail with provided UUID: a1f5b89e-ec56-4ed0-8c30-11c1c12d272c and options: { uuid: UUID("a1f5b89e-ec56-4ed0-8c30-11c1c12d272c") }
2020-06-16T17:54:48.977+0800 I  INDEX    [repl-writer-worker-15] index build: starting on niuniuh5_modb.table_clubgamescorerobotdetail properties: { v: 2, key: { szToken: 1.0 }, name: "szToken_1", ns: "niuniuh5_modb.table_clubgamescorerobotdetail" } using method: Hybrid
2020-06-16T17:54:48.977+0800 I  INDEX    [repl-writer-worker-15] build may temporarily use up to 100 megabytes of RAM
2020-06-16T17:54:48.991+0800 I  INDEX    [repl-writer-worker-15] index build: starting on niuniuh5_modb.table_clubgamescorerobotdetail properties: { v: 2, key: { tEndTime: 1.0 }, name: "tEndTime_1", ns: "niuniuh5_modb.table_clubgamescorerobotdetail" } using method: Hybrid
2020-06-16T17:54:48.991+0800 I  INDEX    [repl-writer-worker-15] build may temporarily use up to 100 megabytes of RAM
2020-06-16T17:54:49.011+0800 I  INDEX    [repl-writer-worker-15] index build: starting on niuniuh5_modb.table_clubgamescorerobotdetail properties: { v: 2, key: { _id: 1 }, name: "_id_", ns: "niuniuh5_modb.table_clubgamescorerobotdetail" } using method: Hybrid
2020-06-16T17:54:49.011+0800 I  INDEX    [repl-writer-worker-15] build may temporarily use up to 200 megabytes of RAM
2020-06-16T17:54:49.020+0800 I  SHARDING [repl-writer-worker-1] Marking collection niuniuh5_modb.table_clubgamescorerobotdetail as collection version: <unsharded>
2020-06-16T17:54:57.121+0800 I  ELECTION [conn2] Received vote request: { replSetRequestVotes: 1, setName: "repl_set", dryRun: true, term: 0, candidateIndex: 0, configVersion: 1, lastCommittedOp: { ts: Timestamp(1592301286, 1), t: -1 } }
2020-06-16T17:54:57.121+0800 I  ELECTION [conn2] Sending vote response: { term: 0, voteGranted: true, reason: "" }
2020-06-16T17:54:57.123+0800 I  ELECTION [conn2] Received vote request: { replSetRequestVotes: 1, setName: "repl_set", dryRun: false, term: 1, candidateIndex: 0, configVersion: 1, lastCommittedOp: { ts: Timestamp(1592301286, 1), t: -1 } }
2020-06-16T17:54:57.123+0800 I  ELECTION [conn2] Sending vote response: { term: 1, voteGranted: true, reason: "" }
2020-06-16T17:54:58.628+0800 I  REPL     [replexec-1] Member 10.31.76.149:27017 is now in state PRIMARY
2020-06-16T17:55:29.692+0800 I  NETWORK  [listener] connection accepted from 127.0.0.1:51578 #17 (2 connections now open)
2020-06-16T17:55:29.693+0800 I  NETWORK  [conn17] received client metadata from 127.0.0.1:51578 conn17: { application: { name: "MongoDB Shell" }, driver: { name: "MongoDB Internal Client", version: "4.2.7" }, os: { type: "Linux", name: "CentOS Linux release 7.3.1611 (Core) ", architecture: "x86_64", version: "Kernel 3.10.0-514.26.2.el7.x86_64" } }
2020-06-16T17:55:29.815+0800 I  COMMAND  [conn17] command admin.$cmd appName: "MongoDB Shell" command: replSetGetStatus { replSetGetStatus: 1.0, forShell: 1.0, $clusterTime: { clusterTime: Timestamp(1592301327, 1), signature: { hash: BinData(0, 0000000000000000000000000000000000000000), keyId: 0 } }, $db: "admin" } numYields:0 reslen:4283 locks:{} protocol:op_msg 113ms
2020-06-16T17:55:34.085+0800 I  COMMAND  [conn17] command admin.$cmd appName: "MongoDB Shell" command: replSetGetStatus { replSetGetStatus: 1.0, lsid: { id: UUID("6d70b577-fe1a-4b85-9425-cd0e3dd1a24a") }, $clusterTime: { clusterTime: Timestamp(1592301327, 1), signature: { hash: BinData(0, 0000000000000000000000000000000000000000), keyId: 0 } }, $db: "admin" } numYields:0 reslen:4283 locks:{} protocol:op_msg 1681ms
2020-06-16T17:55:34.371+0800 I  COMMAND  [conn17] command admin.$cmd appName: "MongoDB Shell" command: replSetGetStatus { replSetGetStatus: 1.0, forShell: 1.0, $clusterTime: { clusterTime: Timestamp(1592301327, 1), signature: { hash: BinData(0, 0000000000000000000000000000000000000000), keyId: 0 } }, $db: "admin" } numYields:0 reslen:4283 locks:{} protocol:op_msg 279ms
2020-06-16T17:55:48.957+0800 I  CONNPOOL [RS] Ending idle connection to host 10.31.76.149:27017 because the pool meets constraints; 1 connections to that host remain open
2020-06-16T17:55:53.516+0800 I  COMMAND  [conn17] command admin.$cmd appName: "MongoDB Shell" command: replSetGetStatus { replSetGetStatus: 1.0, forShell: 1.0, $clusterTime: { clusterTime: Timestamp(1592301327, 1), signature: { hash: BinData(0, 0000000000000000000000000000000000000000), keyId: 0 } }, $db: "admin" } numYields:0 reslen:4283 locks:{} protocol:op_msg 3326ms
2020-06-16T17:55:53.794+0800 I  COMMAND  [conn17] command admin.$cmd appName: "MongoDB Shell" command: replSetGetStatus { replSetGetStatus: 1.0, forShell: 1.0, $clusterTime: { clusterTime: Timestamp(1592301347, 1), signature: { hash: BinData(0, 0000000000000000000000000000000000000000), keyId: 0 } }, $db: "admin" } numYields:0 reslen:4283 locks:{} protocol:op_msg 276ms
2020-06-16T17:55:54.120+0800 I  COMMAND  [conn17] command admin.$cmd appName: "MongoDB Shell" command: replSetGetStatus { replSetGetStatus: 1.0, forShell: 1.0, $clusterTime: { clusterTime: Timestamp(1592301347, 1), signature: { hash: BinData(0, 0000000000000000000000000000000000000000), keyId: 0 } }, $db: "admin" } numYields:0 reslen:4283 locks:{} protocol:op_msg 324ms
2020-06-16T17:55:54.404+0800 I  COMMAND  [conn17] command admin.$cmd appName: "MongoDB Shell" command: replSetGetStatus { replSetGetStatus: 1.0, forShell: 1.0, $clusterTime: { clusterTime: Timestamp(1592301347, 1), signature: { hash: BinData(0, 0000000000000000000000000000000000000000), keyId: 0 } }, $db: "admin" } numYields:0 reslen:4283 locks:{} protocol:op_msg 280ms
2020-06-16T17:55:54.682+0800 I  COMMAND  [conn17] command admin.$cmd appName: "MongoDB Shell" command: replSetGetStatus { replSetGetStatus: 1.0, forShell: 1.0, $clusterTime: { clusterTime: Timestamp(1592301347, 1), signature: { hash: BinData(0, 0000000000000000000000000000000000000000), keyId: 0 } }, $db: "admin" } numYields:0 reslen:4283 locks:{} protocol:op_msg 276ms
2020-06-16T17:56:02.291+0800 I  COMMAND  [conn17] command admin.$cmd appName: "MongoDB Shell" command: replSetGetStatus { replSetGetStatus: 1.0, forShell: 1.0, $clusterTime: { clusterTime: Timestamp(1592301347, 1), signature: { hash: BinData(0, 0000000000000000000000000000000000000000), keyId: 0 } }, $db: "admin" } numYields:0 reslen:4283 locks:{} protocol:op_msg 166ms
2020-06-16T17:56:02.644+0800 I  COMMAND  [conn17] command admin.$cmd appName: "MongoDB Shell" command: replSetGetStatus { replSetGetStatus: 1.0, forShell: 1.0, $clusterTime: { clusterTime: Timestamp(1592301357, 2), signature: { hash: BinData(0, 0000000000000000000000000000000000000000), keyId: 0 } }, $db: "admin" } numYields:0 reslen:4283 locks:{} protocol:op_msg 349ms
2020-06-16T17:56:02.958+0800 I  COMMAND  [conn17] command admin.$cmd appName: "MongoDB Shell" command: replSetGetStatus { replSetGetStatus: 1.0, forShell: 1.0, $clusterTime: { clusterTime: Timestamp(1592301357, 2), signature: { hash: BinData(0, 0000000000000000000000000000000000000000), keyId: 0 } }, $db: "admin" } numYields:0 reslen:4283 locks:{} protocol:op_msg 309ms
2020-06-16T17:56:43.760+0800 I  -        [repl-writer-worker-15]   niuniuh5_modb.table_clubgamescorerobotdetail collection clone progress: 9652725/27497094 35% (documents copied)
2020-06-16T17:56:57.033+0800 I  COMMAND  [conn17] command admin.$cmd appName: "MongoDB Shell" command: replSetGetStatus { replSetGetStatus: 1.0, forShell: 1.0, $clusterTime: { clusterTime: Timestamp(1592301357, 2), signature: { hash: BinData(0, 0000000000000000000000000000000000000000), keyId: 0 } }, $db: "admin" } numYields:0 reslen:4283 locks:{} protocol:op_msg 196ms
2020-06-16T17:56:57.354+0800 I  COMMAND  [conn17] command admin.$cmd appName: "MongoDB Shell" command: replSetGetStatus { replSetGetStatus: 1.0, forShell: 1.0, $clusterTime: { clusterTime: Timestamp(1592301407, 1), signature: { hash: BinData(0, 0000000000000000000000000000000000000000), keyId: 0 } }, $db: "admin" } numYields:0 reslen:4283 locks:{} protocol:op_msg 319ms
2020-06-16T17:57:03.559+0800 I  COMMAND  [conn17] command admin.$cmd appName: "MongoDB Shell" command: replSetGetStatus { replSetGetStatus: 1.0, forShell: 1.0, $clusterTime: { clusterTime: Timestamp(1592301417, 2), signature: { hash: BinData(0, 0000000000000000000000000000000000000000), keyId: 0 } }, $db: "admin" } numYields:0 reslen:4283 locks:{} protocol:op_msg 3366ms
2020-06-16T17:57:51.779+0800 I  -        [repl-writer-worker-15]   niuniuh5_modb.table_clubgamescorerobotdetail collection clone progress: 14489167/27497094 52% (documents copied)
2020-06-16T17:58:56.993+0800 I  -        [repl-writer-worker-15]   niuniuh5_modb.table_clubgamescorerobotdetail collection clone progress: 19337184/27497094 70% (documents copied)
2020-06-16T17:59:20.391+0800 I  NETWORK  [LogicalSessionCacheRefresh] Starting new replica set monitor for repl_set/10.31.76.149:27017,10.31.76.227:27017
2020-06-16T17:59:20.391+0800 I  CONNPOOL [ReplicaSetMonitor-TaskExecutor] Connecting to 10.31.76.149:27017
2020-06-16T17:59:20.392+0800 I  CONNPOOL [ReplicaSetMonitor-TaskExecutor] Connecting to 10.31.76.227:27017
2020-06-16T17:59:20.392+0800 I  NETWORK  [listener] connection accepted from 10.31.76.227:10628 #19 (3 connections now open)
2020-06-16T17:59:20.393+0800 I  NETWORK  [conn19] received client metadata from 10.31.76.227:10628 conn19: { driver: { name: "NetworkInterfaceTL", version: "4.2.7" }, os: { type: "Linux", name: "CentOS Linux release 7.3.1611 (Core) ", architecture: "x86_64", version: "Kernel 3.10.0-514.26.2.el7.x86_64" } }
2020-06-16T17:59:20.394+0800 I  NETWORK  [ReplicaSetMonitor-TaskExecutor] Confirmed replica set for repl_set is repl_set/10.31.76.149:27017,10.31.76.227:27017
2020-06-16T17:59:20.395+0800 I  NETWORK  [LogicalSessionCacheReap] Successfully connected to 10.31.76.149:27017 (1 connections now open to 10.31.76.149:27017 with a 0 second timeout)
2020-06-16T17:59:20.395+0800 I  NETWORK  [LogicalSessionCacheRefresh] Successfully connected to 10.31.76.149:27017 (2 connections now open to 10.31.76.149:27017 with a 0 second timeout)
2020-06-16T17:59:20.395+0800 I  NETWORK  [LogicalSessionCacheRefresh] Starting new replica set monitor for repl_set/10.31.76.149:27017,10.31.76.227:27017
2020-06-16T17:59:20.395+0800 I  NETWORK  [ReplicaSetMonitor-TaskExecutor] Confirmed replica set for repl_set is repl_set/10.31.76.149:27017,10.31.76.227:27017
2020-06-16T17:59:35.428+0800 I  CONTROL  [LogicalSessionCacheRefresh] Failed to refresh session cache: WriteConcernFailed: waiting for replication timed out; Error details: { wtimeout: true }
2020-06-16T18:00:07.733+0800 I  -        [repl-writer-worker-15]   niuniuh5_modb.table_clubgamescorerobotdetail collection clone progress: 24175548/27497094 87% (documents copied)
2020-06-16T18:00:53.117+0800 I  INITSYNC [replication-1] CollectionCloner ns:niuniuh5_modb.table_clubgamescorerobotdetail finished cloning with status: OK
2020-06-16T18:01:01.001+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 4242500/27497094 15%
2020-06-16T18:01:04.001+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 9010300/27497094 32%
2020-06-16T18:01:07.001+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 13542400/27497094 49%
2020-06-16T18:01:10.001+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 17797700/27497094 64%
2020-06-16T18:01:13.001+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 22039800/27497094 80%
2020-06-16T18:01:16.001+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 26275000/27497094 95%
2020-06-16T18:01:16.870+0800 I  INDEX    [replication-1] index build: inserted 27497094 keys from external sorter into index in 23 seconds
2020-06-16T18:01:21.001+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 4143900/27497094 15%
2020-06-16T18:01:24.000+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 9455000/27497094 34%
2020-06-16T18:01:27.000+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 14743700/27497094 53%
2020-06-16T18:01:30.000+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 20052200/27497094 72%
2020-06-16T18:01:33.000+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 25360400/27497094 92%
2020-06-16T18:01:34.188+0800 I  INDEX    [replication-1] index build: inserted 27497094 keys from external sorter into index in 15 seconds
2020-06-16T18:01:35.153+0800 I  INDEX    [replication-1] index build: done building index szToken_1 on ns niuniuh5_modb.table_clubgamescorerobotdetail
2020-06-16T18:01:35.161+0800 I  INDEX    [replication-1] index build: done building index tEndTime_1 on ns niuniuh5_modb.table_clubgamescorerobotdetail
2020-06-16T18:01:41.000+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 2787000/27497094 10%
2020-06-16T18:01:44.000+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 6796600/27497094 24%
2020-06-16T18:01:47.000+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 10808800/27497094 39%
2020-06-16T18:01:50.000+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 14820100/27497094 53%
2020-06-16T18:01:53.000+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 18831000/27497094 68%
2020-06-16T18:01:56.000+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 22843500/27497094 83%
2020-06-16T18:01:59.000+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 26991000/27497094 98%
2020-06-16T18:01:59.358+0800 I  INDEX    [replication-1] index build: inserted 27497094 keys from external sorter into index in 24 seconds
2020-06-16T18:02:00.973+0800 I  INDEX    [replication-1] index build: done building index _id_ on ns niuniuh5_modb.table_clubgamescorerobotdetail
2020-06-16T18:02:00.979+0800 I  INITSYNC [replication-1] CollectionCloner::start called, on ns:niuniuh5_modb.table_clubgamelog
2020-06-16T18:02:00.979+0800 I  CONNPOOL [RS] Connecting to 10.31.76.149:27017
2020-06-16T18:02:00.981+0800 I  STORAGE  [repl-writer-worker-9] createCollection: niuniuh5_modb.table_clubgamelog with provided UUID: fc27c575-0be5-4519-aa96-1d1a92c57191 and options: { uuid: UUID("fc27c575-0be5-4519-aa96-1d1a92c57191") }
2020-06-16T18:02:01.004+0800 I  INDEX    [repl-writer-worker-9] index build: starting on niuniuh5_modb.table_clubgamelog properties: { v: 2, key: { szToken: 1.0 }, name: "szToken_1", ns: "niuniuh5_modb.table_clubgamelog" } using method: Hybrid
2020-06-16T18:02:01.004+0800 I  INDEX    [repl-writer-worker-9] build may temporarily use up to 100 megabytes of RAM
2020-06-16T18:02:01.018+0800 I  INDEX    [repl-writer-worker-9] index build: starting on niuniuh5_modb.table_clubgamelog properties: { v: 2, key: { tEndTime: 1.0 }, name: "tEndTime_1", ns: "niuniuh5_modb.table_clubgamelog" } using method: Hybrid
2020-06-16T18:02:01.018+0800 I  INDEX    [repl-writer-worker-9] build may temporarily use up to 100 megabytes of RAM
2020-06-16T18:02:01.052+0800 I  INDEX    [repl-writer-worker-9] index build: starting on niuniuh5_modb.table_clubgamelog properties: { v: 2, key: { _id: 1 }, name: "_id_", ns: "niuniuh5_modb.table_clubgamelog" } using method: Hybrid
2020-06-16T18:02:01.052+0800 I  INDEX    [repl-writer-worker-9] build may temporarily use up to 200 megabytes of RAM
2020-06-16T18:02:01.066+0800 I  SHARDING [repl-writer-worker-10] Marking collection niuniuh5_modb.table_clubgamelog as collection version: <unsharded>
2020-06-16T18:02:20.428+0800 I  -        [repl-writer-worker-9]   niuniuh5_modb.table_clubgamelog collection clone progress: 1364474/5126153 26% (documents copied)
2020-06-16T18:03:00.981+0800 I  CONNPOOL [RS] Ending idle connection to host 10.31.76.149:27017 because the pool meets constraints; 1 connections to that host remain open
2020-06-16T18:03:37.547+0800 I  INITSYNC [replication-0] CollectionCloner ns:niuniuh5_modb.table_clubgamelog finished cloning with status: OK
2020-06-16T18:03:41.001+0800 I  -        [replication-0]   Index Build: inserting keys from external sorter into index: 3657000/5126153 71%
2020-06-16T18:03:42.039+0800 I  INDEX    [replication-0] index build: inserted 5126153 keys from external sorter into index in 4 seconds
2020-06-16T18:03:47.001+0800 I  -        [replication-0]   Index Build: inserting keys from external sorter into index: 4285100/5126153 83%
2020-06-16T18:03:47.484+0800 I  INDEX    [replication-0] index build: inserted 5126153 keys from external sorter into index in 4 seconds
2020-06-16T18:03:47.794+0800 I  INDEX    [replication-0] index build: done building index szToken_1 on ns niuniuh5_modb.table_clubgamelog
2020-06-16T18:03:47.794+0800 I  INDEX    [replication-0] index build: done building index tEndTime_1 on ns niuniuh5_modb.table_clubgamelog
2020-06-16T18:03:50.001+0800 I  -        [replication-0]   Index Build: inserting keys from external sorter into index: 2701700/5126153 52%
2020-06-16T18:03:51.844+0800 I  INDEX    [replication-0] index build: inserted 5126153 keys from external sorter into index in 4 seconds
2020-06-16T18:03:52.284+0800 I  INDEX    [replication-0] index build: done building index _id_ on ns niuniuh5_modb.table_clubgamelog
2020-06-16T18:03:52.289+0800 I  CONNPOOL [RS] Connecting to 10.31.76.149:27017
2020-06-16T18:03:52.291+0800 I  INITSYNC [replication-1] CollectionCloner::start called, on ns:niuniuh5_modb_02.table_clubgamelog
2020-06-16T18:03:52.292+0800 I  STORAGE  [repl-writer-worker-3] createCollection: niuniuh5_modb_02.table_clubgamelog with provided UUID: 2ae8f147-6e5b-4043-871b-245e132f4d4b and options: { uuid: UUID("2ae8f147-6e5b-4043-871b-245e132f4d4b") }
2020-06-16T18:03:52.315+0800 I  INDEX    [repl-writer-worker-3] index build: starting on niuniuh5_modb_02.table_clubgamelog properties: { v: 2, key: { szToken: 1.0 }, name: "szToken_1", ns: "niuniuh5_modb_02.table_clubgamelog" } using method: Hybrid
2020-06-16T18:03:52.315+0800 I  INDEX    [repl-writer-worker-3] build may temporarily use up to 100 megabytes of RAM
2020-06-16T18:03:52.330+0800 I  INDEX    [repl-writer-worker-3] index build: starting on niuniuh5_modb_02.table_clubgamelog properties: { v: 2, key: { tEndTime: 1.0 }, name: "tEndTime_1", ns: "niuniuh5_modb_02.table_clubgamelog" } using method: Hybrid
2020-06-16T18:03:52.330+0800 I  INDEX    [repl-writer-worker-3] build may temporarily use up to 100 megabytes of RAM
2020-06-16T18:03:52.355+0800 I  INDEX    [repl-writer-worker-3] index build: starting on niuniuh5_modb_02.table_clubgamelog properties: { v: 2, key: { _id: 1 }, name: "_id_", ns: "niuniuh5_modb_02.table_clubgamelog" } using method: Hybrid
2020-06-16T18:03:52.355+0800 I  INDEX    [repl-writer-worker-3] build may temporarily use up to 200 megabytes of RAM
2020-06-16T18:03:52.365+0800 I  SHARDING [repl-writer-worker-4] Marking collection niuniuh5_modb_02.table_clubgamelog as collection version: <unsharded>
2020-06-16T18:04:12.003+0800 I  COMMAND  [conn17] command admin.$cmd appName: "MongoDB Shell" command: replSetGetStatus { replSetGetStatus: 1.0, forShell: 1.0, $clusterTime: { clusterTime: Timestamp(1592301847, 1), signature: { hash: BinData(0, 0000000000000000000000000000000000000000), keyId: 0 } }, $db: "admin" } numYields:0 reslen:4711 locks:{} protocol:op_msg 122ms
2020-06-16T18:04:20.391+0800 I  NETWORK  [LogicalSessionCacheRefresh] Starting new replica set monitor for repl_set/10.31.76.149:27017,10.31.76.227:27017
2020-06-16T18:04:20.391+0800 I  NETWORK  [ReplicaSetMonitor-TaskExecutor] Confirmed replica set for repl_set is repl_set/10.31.76.149:27017,10.31.76.227:27017
2020-06-16T18:04:20.392+0800 I  NETWORK  [LogicalSessionCacheRefresh] Starting new replica set monitor for repl_set/10.31.76.149:27017,10.31.76.227:27017
2020-06-16T18:04:20.392+0800 I  NETWORK  [ReplicaSetMonitor-TaskExecutor] Confirmed replica set for repl_set is repl_set/10.31.76.149:27017,10.31.76.227:27017
2020-06-16T18:04:35.434+0800 I  CONTROL  [LogicalSessionCacheRefresh] Failed to refresh session cache: WriteConcernFailed: waiting for replication timed out; Error details: { wtimeout: true }
2020-06-16T18:04:49.604+0800 I  COMMAND  [conn17] command admin.$cmd appName: "MongoDB Shell" command: replSetGetStatus { replSetGetStatus: 1.0, forShell: 1.0, $clusterTime: { clusterTime: Timestamp(1592301860, 1), signature: { hash: BinData(0, 0000000000000000000000000000000000000000), keyId: 0 } }, $readPreference: { mode: "secondaryPreferred" }, $db: "admin" } numYields:0 reslen:4711 locks:{} protocol:op_msg 4624ms
2020-06-16T18:04:52.292+0800 I  CONNPOOL [RS] Ending idle connection to host 10.31.76.149:27017 because the pool meets constraints; 1 connections to that host remain open
2020-06-16T18:05:03.823+0800 I  -        [repl-writer-worker-3]   niuniuh5_modb_02.table_clubgamelog collection clone progress: 4028446/5126153 78% (documents copied)
2020-06-16T18:05:28.967+0800 I  INITSYNC [replication-0] CollectionCloner ns:niuniuh5_modb_02.table_clubgamelog finished cloning with status: OK
2020-06-16T18:05:32.001+0800 I  -        [replication-0]   Index Build: inserting keys from external sorter into index: 3287900/5126153 64%
2020-06-16T18:05:33.300+0800 I  INDEX    [replication-0] index build: inserted 5126153 keys from external sorter into index in 4 seconds
2020-06-16T18:05:38.001+0800 I  -        [replication-0]   Index Build: inserting keys from external sorter into index: 3817800/5126153 74%
2020-06-16T18:05:38.759+0800 I  INDEX    [replication-0] index build: inserted 5126153 keys from external sorter into index in 4 seconds
2020-06-16T18:05:39.125+0800 I  INDEX    [replication-0] index build: done building index szToken_1 on ns niuniuh5_modb_02.table_clubgamelog
2020-06-16T18:05:39.125+0800 I  INDEX    [replication-0] index build: done building index tEndTime_1 on ns niuniuh5_modb_02.table_clubgamelog
2020-06-16T18:05:42.001+0800 I  -        [replication-0]   Index Build: inserting keys from external sorter into index: 3556700/5126153 69%
2020-06-16T18:05:43.205+0800 I  INDEX    [replication-0] index build: inserted 5126153 keys from external sorter into index in 4 seconds
2020-06-16T18:05:43.839+0800 I  INDEX    [replication-0] index build: done building index _id_ on ns niuniuh5_modb_02.table_clubgamelog
2020-06-16T18:05:43.847+0800 I  INITSYNC [replication-0] CollectionCloner::start called, on ns:niuniuh5_modb_02.table_clubgamescorerobotdetail
2020-06-16T18:05:43.847+0800 I  CONNPOOL [RS] Connecting to 10.31.76.149:27017
2020-06-16T18:05:43.847+0800 I  COMMAND  [conn17] command admin.$cmd appName: "MongoDB Shell" command: listDatabases { listDatabases: 1.0, nameOnly: false, lsid: { id: UUID("6d70b577-fe1a-4b85-9425-cd0e3dd1a24a") }, $clusterTime: { clusterTime: Timestamp(1592301887, 1), signature: { hash: BinData(0, 0000000000000000000000000000000000000000), keyId: 0 } }, $readPreference: { mode: "secondaryPreferred" }, $db: "admin" } numYields:0 reslen:530 locks:{ ParallelBatchWriterMode: { acquireCount: { r: 7 } }, ReplicationStateTransition: { acquireCount: { w: 7 } }, Global: { acquireCount: { r: 7 } }, Database: { acquireCount: { r: 6 }, acquireWaitCount: { r: 1 }, timeAcquiringMicros: { r: 49762283 } }, Collection: { acquireCount: { r: 19 } }, Mutex: { acquireCount: { r: 6 } }, oplog: { acquireCount: { r: 1 } } } storage:{ data: { bytesRead: 12206, timeReadingMicros: 30 } } protocol:op_msg 49947ms
2020-06-16T18:05:43.849+0800 I  STORAGE  [repl-writer-worker-14] createCollection: niuniuh5_modb_02.table_clubgamescorerobotdetail with provided UUID: 53bc7e9c-79e9-4fcc-bb3e-8ff1f34ccea6 and options: { uuid: UUID("53bc7e9c-79e9-4fcc-bb3e-8ff1f34ccea6") }
2020-06-16T18:05:43.870+0800 I  INDEX    [repl-writer-worker-14] index build: starting on niuniuh5_modb_02.table_clubgamescorerobotdetail properties: { v: 2, key: { szToken: 1.0 }, name: "szToken_1", ns: "niuniuh5_modb_02.table_clubgamescorerobotdetail" } using method: Hybrid
2020-06-16T18:05:43.870+0800 I  INDEX    [repl-writer-worker-14] build may temporarily use up to 100 megabytes of RAM
2020-06-16T18:05:43.883+0800 I  INDEX    [repl-writer-worker-14] index build: starting on niuniuh5_modb_02.table_clubgamescorerobotdetail properties: { v: 2, key: { tEndTime: 1.0 }, name: "tEndTime_1", ns: "niuniuh5_modb_02.table_clubgamescorerobotdetail" } using method: Hybrid
2020-06-16T18:05:43.883+0800 I  INDEX    [repl-writer-worker-14] build may temporarily use up to 100 megabytes of RAM
2020-06-16T18:05:43.903+0800 I  INDEX    [repl-writer-worker-14] index build: starting on niuniuh5_modb_02.table_clubgamescorerobotdetail properties: { v: 2, key: { _id: 1 }, name: "_id_", ns: "niuniuh5_modb_02.table_clubgamescorerobotdetail" } using method: Hybrid
2020-06-16T18:05:43.904+0800 I  INDEX    [repl-writer-worker-14] build may temporarily use up to 200 megabytes of RAM
2020-06-16T18:05:43.920+0800 I  SHARDING [repl-writer-worker-0] Marking collection niuniuh5_modb_02.table_clubgamescorerobotdetail as collection version: <unsharded>
2020-06-16T18:06:37.694+0800 I  -        [repl-writer-worker-14]   niuniuh5_modb_02.table_clubgamescorerobotdetail collection clone progress: 4809762/27497094 17% (documents copied)
2020-06-16T18:06:43.849+0800 I  CONNPOOL [RS] Ending idle connection to host 10.31.76.149:27017 because the pool meets constraints; 1 connections to that host remain open
2020-06-16T18:07:46.479+0800 I  -        [repl-writer-worker-14]   niuniuh5_modb_02.table_clubgamescorerobotdetail collection clone progress: 9652725/27497094 35% (documents copied)
2020-06-16T18:08:56.377+0800 I  -        [repl-writer-worker-14]   niuniuh5_modb_02.table_clubgamescorerobotdetail collection clone progress: 14489167/27497094 52% (documents copied)
2020-06-16T18:09:20.391+0800 I  NETWORK  [LogicalSessionCacheRefresh] Starting new replica set monitor for repl_set/10.31.76.149:27017,10.31.76.227:27017
2020-06-16T18:09:20.391+0800 I  NETWORK  [ReplicaSetMonitor-TaskExecutor] Confirmed replica set for repl_set is repl_set/10.31.76.149:27017,10.31.76.227:27017
2020-06-16T18:09:20.393+0800 I  NETWORK  [LogicalSessionCacheReap] Successfully connected to 10.31.76.149:27017 (1 connections now open to 10.31.76.149:27017 with a 0 second timeout)
2020-06-16T18:09:20.393+0800 I  NETWORK  [LogicalSessionCacheRefresh] Successfully connected to 10.31.76.149:27017 (2 connections now open to 10.31.76.149:27017 with a 0 second timeout)
2020-06-16T18:09:20.393+0800 I  NETWORK  [LogicalSessionCacheRefresh] Starting new replica set monitor for repl_set/10.31.76.149:27017,10.31.76.227:27017
2020-06-16T18:09:20.393+0800 I  NETWORK  [ReplicaSetMonitor-TaskExecutor] Confirmed replica set for repl_set is repl_set/10.31.76.149:27017,10.31.76.227:27017
2020-06-16T18:09:35.419+0800 I  CONTROL  [LogicalSessionCacheRefresh] Failed to refresh session cache: WriteConcernFailed: waiting for replication timed out; Error details: { wtimeout: true }
2020-06-16T18:10:03.170+0800 I  -        [repl-writer-worker-14]   niuniuh5_modb_02.table_clubgamescorerobotdetail collection clone progress: 19337184/27497094 70% (documents copied)
2020-06-16T18:11:15.149+0800 I  -        [repl-writer-worker-14]   niuniuh5_modb_02.table_clubgamescorerobotdetail collection clone progress: 24175548/27497094 87% (documents copied)
2020-06-16T18:12:00.698+0800 I  INITSYNC [replication-1] CollectionCloner ns:niuniuh5_modb_02.table_clubgamescorerobotdetail finished cloning with status: OK
2020-06-16T18:12:09.000+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 4008300/27497094 14%
2020-06-16T18:12:12.000+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 8838600/27497094 32%
2020-06-16T18:12:15.000+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 13346800/27497094 48%
2020-06-16T18:12:18.000+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 17558800/27497094 63%
2020-06-16T18:12:21.000+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 21759400/27497094 79%
2020-06-16T18:12:24.000+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 25942600/27497094 94%
2020-06-16T18:12:25.115+0800 I  INDEX    [replication-1] index build: inserted 27497094 keys from external sorter into index in 24 seconds
2020-06-16T18:12:29.001+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 3606500/27497094 13%
2020-06-16T18:12:32.001+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 8964300/27497094 32%
2020-06-16T18:12:35.001+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 14267200/27497094 51%
2020-06-16T18:12:38.001+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 19593200/27497094 71%
2020-06-16T18:12:41.001+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 24909100/27497094 90%
2020-06-16T18:12:42.452+0800 I  INDEX    [replication-1] index build: inserted 27497094 keys from external sorter into index in 15 seconds
2020-06-16T18:12:43.397+0800 I  INDEX    [replication-1] index build: done building index szToken_1 on ns niuniuh5_modb_02.table_clubgamescorerobotdetail
2020-06-16T18:12:43.397+0800 I  INDEX    [replication-1] index build: done building index tEndTime_1 on ns niuniuh5_modb_02.table_clubgamescorerobotdetail
2020-06-16T18:12:50.001+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 2924100/27497094 10%
2020-06-16T18:12:53.001+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 6883800/27497094 25%
2020-06-16T18:12:56.001+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 10850300/27497094 39%
2020-06-16T18:12:59.001+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 14833600/27497094 53%
2020-06-16T18:13:02.001+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 18805100/27497094 68%
2020-06-16T18:13:05.001+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 22681100/27497094 82%
2020-06-16T18:13:08.001+0800 I  -        [replication-1]   Index Build: inserting keys from external sorter into index: 26812600/27497094 97%
2020-06-16T18:13:08.485+0800 I  INDEX    [replication-1] index build: inserted 27497094 keys from external sorter into index in 25 seconds
2020-06-16T18:13:10.151+0800 I  INDEX    [replication-1] index build: done building index _id_ on ns niuniuh5_modb_02.table_clubgamescorerobotdetail
2020-06-16T18:13:10.157+0800 I  INITSYNC [replication-1] Finished cloning data: OK. Beginning oplog replay.


2020-06-16T18:13:10.157+0800 I  CONNPOOL [RS] Connecting to 10.31.76.149:27017
2020-06-16T18:13:10.157+0800 I  COMMAND  [conn17] command admin.$cmd appName: "MongoDB Shell" command: listDatabases { listDatabases: 1.0, nameOnly: false, lsid: { id: UUID("6d70b577-fe1a-4b85-9425-cd0e3dd1a24a") }, $clusterTime: { clusterTime: Timestamp(1592301937, 1), signature: { hash: BinData(0, 0000000000000000000000000000000000000000), keyId: 0 } }, $readPreference: { mode: "secondaryPreferred" }, $db: "admin" } numYields:0 reslen:530 locks:{ ParallelBatchWriterMode: { acquireCount: { r: 7 } }, ReplicationStateTransition: { acquireCount: { w: 7 } }, Global: { acquireCount: { r: 7 } }, Database: { acquireCount: { r: 6 }, acquireWaitCount: { r: 1 }, timeAcquiringMicros: { r: 381895782 } }, Collection: { acquireCount: { r: 20 } }, Mutex: { acquireCount: { r: 6 } }, oplog: { acquireCount: { r: 1 } } } storage:{ data: { bytesRead: 13420, timeReadingMicros: 26 } } protocol:op_msg 381897ms
2020-06-16T18:13:10.159+0800 I  INITSYNC [replication-0] Writing to the oplog and applying operations until { : Timestamp(1592302387, 1) } before initial sync can complete. (started fetching at { : Timestamp(1592301286, 1) } and applying at { : Timestamp(1592301286, 1) })
2020-06-16T18:13:10.984+0800 I  COMMAND  [conn17] command admin.$cmd appName: "MongoDB Shell" command: replSetGetStatus { replSetGetStatus: 1.0, forShell: 1.0, $clusterTime: { clusterTime: Timestamp(1592302387, 1), signature: { hash: BinData(0, 0000000000000000000000000000000000000000), keyId: 0 } }, $readPreference: { mode: "secondaryPreferred" }, $db: "admin" } numYields:0 reslen:4851 locks:{} protocol:op_msg 824ms
2020-06-16T18:13:11.113+0800 I  SHARDING [replication-0] Marking collection local.replset.oplogTruncateAfterPoint as collection version: <unsharded>
2020-06-16T18:13:11.229+0800 I  STORAGE  [repl-writer-worker-9] createCollection: config.transactions with provided UUID: 8359123c-4f72-40d5-b16c-5a3ec9913e47 and options: { uuid: UUID("8359123c-4f72-40d5-b16c-5a3ec9913e47") }
2020-06-16T18:13:11.244+0800 I  INDEX    [repl-writer-worker-9] index build: done building index _id_ on ns config.transactions
2020-06-16T18:13:11.246+0800 I  STORAGE  [repl-writer-worker-13] createCollection: admin.system.keys with provided UUID: 2549a071-60a7-4e25-9265-bdb642fea02d and options: { uuid: UUID("2549a071-60a7-4e25-9265-bdb642fea02d") }
2020-06-16T18:13:11.261+0800 I  INDEX    [repl-writer-worker-13] index build: done building index _id_ on ns admin.system.keys
2020-06-16T18:13:11.263+0800 I  SHARDING [repl-writer-worker-2] Marking collection admin.system.keys as collection version: <unsharded>
2020-06-16T18:13:11.339+0800 I  SHARDING [replication-1] Marking collection local.system.rollback.id as collection version: <unsharded>
2020-06-16T18:13:11.339+0800 I  INITSYNC [replication-1] Finished fetching oplog during initial sync: CallbackCanceled: error in fetcher batch callback: oplog fetcher is shutting down. Last fetched optime: { ts: Timestamp(1592302387, 1), t: 1 }
2020-06-16T18:13:11.339+0800 I  INITSYNC [replication-1] Initial sync attempt finishing up.
2020-06-16T18:13:11.339+0800 I  INITSYNC [replication-1] Initial Sync Attempt Statistics: { failedInitialSyncAttempts: 0, maxFailedInitialSyncAttempts: 10, initialSyncStart: new Date(1592301287143), initialSyncAttempts: [], fetchedMissingDocs: 0, appliedOps: 113, initialSyncOplogStart: Timestamp(1592301286, 1), initialSyncOplogEnd: Timestamp(1592302387, 1), databases: { databasesCloned: 5, admin: { collections: 2, clonedCollections: 2, start: new Date(1592301288591), end: new Date(1592301288649), elapsedMillis: 58, admin.system.users: { documentsToCopy: 1, documentsCopied: 1, indexes: 2, fetchedBatches: 1, start: new Date(1592301288592), end: new Date(1592301288626), elapsedMillis: 34, receivedBatches: 1 }, admin.system.version: { documentsToCopy: 2, documentsCopied: 2, indexes: 1, fetchedBatches: 1, start: new Date(1592301288626), end: new Date(1592301288649), elapsedMillis: 23, receivedBatches: 1 } }, benet: { collections: 6, clonedCollections: 6, start: new Date(1592301288648), end: new Date(1592301288895), elapsedMillis: 247, benet.t2: { documentsToCopy: 1, documentsCopied: 1, indexes: 1, fetchedBatches: 1, start: new Date(1592301288649), end: new Date(1592301288694), elapsedMillis: 45, receivedBatches: 1 }, benet.t1: { documentsToCopy: 3, documentsCopied: 3, indexes: 1, fetchedBatches: 1, start: new Date(1592301288694), end: new Date(1592301288734), elapsedMillis: 40, receivedBatches: 1 }, benet.table_clubgamelog04: { documentsToCopy: 2, documentsCopied: 2, indexes: 1, fetchedBatches: 1, start: new Date(1592301288734), end: new Date(1592301288772), elapsedMillis: 38, receivedBatches: 1 }, benet.table_clubgamelog: { documentsToCopy: 2, documentsCopied: 2, indexes: 1, fetchedBatches: 1, start: new Date(1592301288772), end: new Date(1592301288812), elapsedMillis: 40, receivedBatches: 1 }, benet.t1_mysql: { documentsToCopy: 1, documentsCopied: 1, indexes: 1, fetchedBatches: 1, start: new Date(1592301288812), end: new Date(1592301288855), elapsedMillis: 43, receivedBatches: 1 }, benet.table_clubgamelogs: { documentsToCopy: 2, documentsCopied: 2, indexes: 1, fetchedBatches: 1, start: new Date(1592301288855), end: new Date(1592301288895), elapsedMillis: 40, receivedBatches: 1 } }, config: { collections: 1, clonedCollections: 1, start: new Date(1592301288895), end: new Date(1592301288956), elapsedMillis: 61, config.system.sessions: { documentsToCopy: 0, documentsCopied: 0, indexes: 2, fetchedBatches: 0, start: new Date(1592301288895), end: new Date(1592301288956), elapsedMillis: 61, receivedBatches: 0 } }, niuniuh5_modb: { collections: 2, clonedCollections: 2, start: new Date(1592301288956), end: new Date(1592301832289), elapsedMillis: 543333, niuniuh5_modb.table_clubgamescorerobotdetail: { documentsToCopy: 27497094, documentsCopied: 27497094, indexes: 3, fetchedBatches: 728, start: new Date(1592301288956), end: new Date(1592301720979), elapsedMillis: 432023, receivedBatches: 728 }, niuniuh5_modb.table_clubgamelog: { documentsToCopy: 5126153, documentsCopied: 5126153, indexes: 3, fetchedBatches: 490, start: new Date(1592301720979), end: new Date(1592301832289), elapsedMillis: 111310, receivedBatches: 490 } }, niuniuh5_modb_02: { collections: 2, clonedCollections: 2, start: new Date(1592301832288), end: new Date(1592302390157), elapsedMillis: 557869, niuniuh5_modb_02.table_clubgamelog: { documentsToCopy: 5126153, documentsCopied: 5126153, indexes: 3, fetchedBatches: 490, start: new Date(1592301832291), end: new Date(1592301943847), elapsedMillis: 111556, receivedBatches: 490 }, niuniuh5_modb_02.table_clubgamescorerobotdetail: { documentsToCopy: 27497094, documentsCopied: 27497094, indexes: 3, fetchedBatches: 728, start: new Date(1592301943847), end: new Date(1592302390157), elapsedMillis: 446310, receivedBatches: 728 } } } }
2020-06-16T18:13:11.340+0800 I  STORAGE  [replication-1] Finishing collection drop for local.temp_oplog_buffer (4c44bbb9-5165-40b6-ad32-544a669a6ab0).
2020-06-16T18:13:11.347+0800 I  SHARDING [replication-1] Marking collection config.transactions as collection version: <unsharded>

2020-06-16T18:13:11.347+0800 I  INITSYNC [replication-1] initial sync done; took 1104s.  --同步完成 

2020-06-16T18:13:11.348+0800 I  REPL     [replication-1] transition to RECOVERING from STARTUP2
2020-06-16T18:13:11.348+0800 I  REPL     [replication-1] Starting replication fetcher thread
2020-06-16T18:13:11.348+0800 I  REPL     [replication-1] Starting replication applier thread
2020-06-16T18:13:11.348+0800 I  REPL     [replication-1] Starting replication reporter thread
2020-06-16T18:13:11.348+0800 I  REPL     [rsSync-0] Starting oplog application
2020-06-16T18:13:11.348+0800 I  REPL     [rsBackgroundSync] could not find member to sync from
2020-06-16T18:13:11.349+0800 I  REPL     [rsSync-0] transition to SECONDARY from RECOVERING
2020-06-16T18:13:11.349+0800 I  REPL     [rsSync-0] Resetting sync source to empty, which was :27017
2020-06-16T18:13:11.564+0800 I  CONNPOOL [RS] Ending connection to host 10.31.76.149:27017 due to bad connection status: CallbackCanceled: Callback was canceled; 1 connections to that host remain open
2020-06-16T18:13:13.349+0800 I  STORAGE  [replexec-15] Triggering the first stable checkpoint. Initial Data: Timestamp(1592302387, 1) PrevStable: Timestamp(0, 0) CurrStable: Timestamp(1592302387, 1)
2020-06-16T18:13:14.350+0800 I  REPL     [rsBackgroundSync] sync source candidate: 10.31.76.149:27017
2020-06-16T18:13:14.351+0800 I  REPL     [rsBackgroundSync] Changed sync source from empty to 10.31.76.149:27017
2020-06-16T18:13:14.351+0800 I  CONNPOOL [RS] Connecting to 10.31.76.149:27017
2020-06-16T18:14:20.391+0800 I  NETWORK  [LogicalSessionCacheRefresh] Starting new replica set monitor for repl_set/10.31.76.149:27017,10.31.76.227:27017
2020-06-16T18:14:20.391+0800 I  NETWORK  [ReplicaSetMonitor-TaskExecutor] Confirmed replica set for repl_set is repl_set/10.31.76.149:27017,10.31.76.227:27017
2020-06-16T18:14:20.392+0800 I  NETWORK  [LogicalSessionCacheReap] Successfully connected to 10.31.76.149:27017 (2 connections now open to 10.31.76.149:27017 with a 0 second timeout)
2020-06-16T18:14:20.396+0800 I  NETWORK  [LogicalSessionCacheRefresh] Starting new replica set monitor for repl_set/10.31.76.149:27017,10.31.76.227:27017
2020-06-16T18:14:20.397+0800 I  NETWORK  [ReplicaSetMonitor-TaskExecutor] Confirmed replica set for repl_set is repl_set/10.31.76.149:27017,10.31.76.227:27017
2020-06-16T18:14:20.397+0800 I  NETWORK  [LogicalSessionCacheRefresh] Starting new replica set monitor for repl_set/10.31.76.149:27017,10.31.76.227:27017
2020-06-16T18:14:20.397+0800 I  NETWORK  [ReplicaSetMonitor-TaskExecutor] Confirmed replica set for repl_set is repl_set/10.31.76.149:27017,10.31.76.227:27017
2020-06-16T18:14:42.632+0800 I  STORAGE  [repl-writer-worker-6] createCollection: test.foo with provided UUID: 03a76e7d-4c5c-4a03-960b-f931acd23a1c and options: { uuid: UUID("03a76e7d-4c5c-4a03-960b-f931acd23a1c") }
2020-06-16T18:14:42.656+0800 I  INDEX    [repl-writer-worker-6] index build: done building index _id_ on ns test.foo
2020-06-16T18:14:42.657+0800 I  SHARDING [repl-writer-worker-8] Marking collection test.foo as collection version: <unsharded>
2020-06-16T18:15:14.111+0800 I  STORAGE  [repl-writer-worker-14] createCollection: abc_db.foo with provided UUID: 7c7a72ed-a7e3-4c21-969c-8706bf7b8abc and options: { uuid: UUID("7c7a72ed-a7e3-4c21-969c-8706bf7b8abc") }
2020-06-16T18:15:14.126+0800 I  INDEX    [repl-writer-worker-14] index build: done building index _id_ on ns abc_db.foo
2020-06-16T18:15:14.127+0800 I  SHARDING [repl-writer-worker-2] Marking collection abc_db.foo as collection version: <unsharded>




