

TTL索引在保存日志或监控数据等场景下大有用武之地，通过创建TTL索引，实现自动删除过期记录的功能
（在使用MongoDB TTL索引需要注意，数据的过期时间无法精确控制，无法做到过期即删除，在大数据量的情况下会有一定的性能开销和删除延迟）。

https://docs.mongodb.com/manual/core/index-ttl/


for (i=0; i<1000; i++) {db.t11.insert({"i" : i, "username" : "user"+i, "age" : Math.floor(Math.random()*120), "CreateTime" : new Date()})}


for (i=0; i<1000; i++) {db.t3.insert({"i" : i, "username" : "user"+i, "age" : Math.floor(Math.random()*120), "created" : '2020-06-05 00:00:00'})}

db.t3.find().forEach(function(data) {
    data.created= new ISODate(data.created);
    db.t3.save(data);
});



db.t3.createIndex( { "created": 1 }, { expireAfterSeconds: 3600 } )


repl_set:PRIMARY> db.t3.find()
{ "_id" : ObjectId("5ef808033c623fe303300ff5"), "i" : 0, "username" : "user0", "age" : 96, "created" : ISODate("2020-06-05T00:00:00Z") }
........................................................................................................................................
........................................................................................................................................
{ "_id" : ObjectId("5ef808033c623fe303301008"), "i" : 19, "username" : "user19", "age" : 70, "created" : ISODate("2020-06-05T00:00:00Z") }
Type "it" for more
repl_set:PRIMARY> db.t3.find()


 db.t3.getIndexes()
 repl_set:PRIMARY>  db.t3.getIndexes()
[
	{
		"v" : 2,
		"key" : {
			"_id" : 1
		},
		"name" : "_id_",
		"ns" : "abc_db.t3"
	},
	{
		"v" : 2,
		"key" : {
			"created" : 1
		},
		"name" : "created_1",
		"ns" : "abc_db.t3",
		"expireAfterSeconds" : 3600
	}
]

 
--------------------------------------------------------------------------------------------------------------------------------------------------------------


for (i=0; i<1000; i++) {db.t5.insert({"i" : i, "username" : "user"+i, "age" : Math.floor(Math.random()*120), "created" : '2020-06-05 00:00:00.000'})}

db.t5.find().forEach(function(data) {
    data.createds= new ISODate(data.created);
    db.t5.save(data);
});


db.t5.find()

--------------------------------------------------------------------------------------------------------------------------------------------------------------

db.t20.find().forEach(function(data) {
    data.createdAt= new ISODate(data.tEndTime);
    db.t20.save(data);
});

db.t20.find()


db.t20.createIndex( { "createdAt": 1 }, { expireAfterSeconds: 2419200 },{backgroup: true} )


------------------------------------------------------------------------------------------------

time /usr/local/mongodb/bin/mongoimport --host "119.23.148.24:27017"  -u "admin" -p "admin" --authenticationDatabase "admin" -d test -c t0626 -f  szToken,tStartTime,tEndTime,nGameType,nServerID,LogData,CardData --type csv  --file 20200628.csv

t0626集合的总大小：
	test        2.722GB


db.t0626.find().forEach(function(data) {
    data.createdAt= new ISODate(data.tEndTime);
    db.t0626.save(data);
});


	[dba2@iZoi1yuqcvndysZ ~]$ mongostat -h 119.23.148.24 -u admin -p admin --authenticationDatabase=admin
	insert query update delete getmore command dirty  used flushes vsize   res qrw arw net_in net_out conn                time
		*0    *0   1284     *0       0     1|0  5.1% 79.1%       0 3.71G 2.17G 0|0 1|0  2.33m    116k  132 Jun 28 16:24:46.673
		*0    *0   1464     *0       0     1|0  0.2% 79.2%       1 3.71G 2.17G 0|0 1|0  2.68m    134k  132 Jun 28 16:24:47.588
		*0    *0   1384     *0       0     1|0  0.4% 79.3%       0 3.71G 2.17G 0|1 1|0  2.61m    126k  132 Jun 28 16:24:48.585
		*0    *0   1340     *0       0     1|0  0.7% 79.4%       0 3.71G 2.17G 0|0 1|0  2.53m    123k  132 Jun 28 16:24:49.585
		*0    *0   1359     *0       0     0|0  0.9% 79.6%       0 3.71G 2.17G 0|0 1|1  2.44m    124k  132 Jun 28 16:24:50.585
		*0    *0   1317     *0       1     1|0  1.1% 80.5%       0 3.71G 2.17G 0|0 2|0  2.46m    121k  132 Jun 28 16:24:51.585
		*0    *0   1319     *0       0     1|0  1.4% 79.7%       0 3.71G 2.17G 0|0 1|0  2.39m   16.9m  132 Jun 28 16:24:52.584
		*0    *0   1330     *0       0     2|0  1.6% 79.8%       0 3.71G 2.17G 0|0 1|0  2.32m    123k  132 Jun 28 16:24:53.586
		*0    *0   1308     *0       0     1|0  1.8% 79.9%       0 3.71G 2.17G 0|0 1|0  2.21m    121k  132 Jun 28 16:24:54.584
		*0    *0   1354     *0       0     2|0  2.0% 79.6%       0 3.71G 2.17G 0|0 1|0  2.33m    124k  132 Jun 28 16:24:55.584
	insert query update delete getmore command dirty  used flushes vsize   res qrw arw net_in net_out conn                time
		*0    *0   1363     *0       0     0|0  2.2% 79.7%       0 3.71G 2.17G 0|1 1|0  2.53m    124k  132 Jun 28 16:24:56.585
		*0    *0   1357     *0       0     0|0  2.5% 79.9%       0 3.71G 2.17G 0|1 1|0  2.53m    124k  132 Jun 28 16:24:57.587
		*0    *0   1264     *0       0     1|0  2.7% 80.0%       0 3.71G 2.17G 0|0 1|0  2.26m    118k  132 Jun 28 16:24:58.585
		 4    *0   1277     *0       0     0|0  2.9% 80.7%       0 3.71G 2.17G 0|0 1|0  2.21m   16.9m  132 Jun 28 16:24:59.585
		*0    *0   1273     *0       0     1|0  3.1% 79.5%       0 3.71G 2.17G 0|1 1|0  2.31m    118k  132 Jun 28 16:25:00.584
		*0    *0   1220     *0       0     0|0  3.3% 79.6%       0 3.71G 2.17G 0|1 1|0  2.28m    115k  132 Jun 28 16:25:01.585
		*0    *0   1304     *0       0     0|0  3.5% 79.7%       0 3.71G 2.17G 0|1 1|0  2.26m    120k  132 Jun 28 16:25:02.586
		*0    *0   1309     *0       0     3|0  3.8% 79.8%       0 3.71G 2.17G 0|0 1|0  2.38m    122k  132 Jun 28 16:25:03.585
		*0    *0   1325     *0       0     1|0  4.0% 79.9%       0 3.71G 2.17G 0|0 1|1  2.31m    122k  132 Jun 28 16:25:04.584
		*0    *0   1439     *0       0     1|0  4.2% 79.6%       0 3.71G 2.17G 0|0 1|1  2.60m    129k  132 Jun 28 16:25:05.586


	select 1400*60*60 = 5040000;  估计要耗时 1个小时。   -- 实际耗时也是1个小时左右。
	
	
	
> db.t0626.count()
5126151


> db.t0626.aggregate([{$group : {_id : "$by_user", num_tutorial : {$sum : 1}}}])
{ "_id" : null, "num_tutorial" : 5126151 }

db.t0626.ensureIndex({"szToken" : 1})

> db.t0626.getIndexes()
[
	{
		"v" : 2,
		"key" : {
			"_id" : 1
		},
		"name" : "_id_",
		"ns" : "test.t0626"
	},
	{
		"v" : 2,
		"key" : {
			"szToken" : 1
		},
		"name" : "szToken_1",
		"ns" : "test.t0626"
	}
]




SELECT TimeStampDiff(SECOND, '2020-05-31', '2020-06-28');
2419200

> db.t0626.createIndex({"createdAt":1},{expireAfterSeconds:2419200},{background:true});
{
	"ok" : 0,
	"errmsg" : "Invalid field specified for createIndexes command: commitQuorum",
	"code" : 2,
	"codeName" : "BadValue"
}

db.t0626.createIndex({"createdAt":1},{expireAfterSeconds:2419200});

> db.t0626.createIndex({"createdAt":1},{expireAfterSeconds:2419200});
{
	"createdCollectionAutomatically" : false,
	"numIndexesBefore" : 2,
	"numIndexesAfter" : 3,
	"ok" : 1
}


 db.t0626.getIndexes()

>  db.t0626.getIndexes()
[
	{
		"v" : 2,
		"key" : {
			"_id" : 1
		},
		"name" : "_id_",
		"ns" : "test.t0626"
	},
	{
		"v" : 2,
		"key" : {
			"szToken" : 1
		},
		"name" : "szToken_1",
		"ns" : "test.t0626"
	},
	{
		"v" : 2,
		"key" : {
			"createdAt" : 1
		},
		"name" : "createdAt_1",
		"ns" : "test.t0626",
		"expireAfterSeconds" : 2419200
	}
]


[dba2@iZoi1yuqcvndysZ ~]$ date
Sun Jun 28 17:27:22 CST 2020

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
vda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
vdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
vdc               0.00    39.00    0.00   29.00     0.00     4.65   328.55     0.06    1.90    0.00    1.90   1.62   4.70
vdd               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
vda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
vdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
vdc               0.00    32.00    1.00   35.00     0.00     5.16   294.00     0.07    1.92    0.00    1.97   1.50   5.40
vdd               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
vda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
vdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
vdc               0.00    20.00    1.00   31.00     0.00     4.64   297.50     0.07    2.19    1.00    2.23   1.66   5.30
vdd               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
vda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
vdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
vdc               0.00    17.00    0.00   34.00     0.00     4.71   283.76     0.10    2.82    0.00    2.82   1.71   5.80
vdd               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
vda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
vdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
vdc               0.00    20.00    1.00   30.00     0.00     4.64   306.58     0.05    1.65    0.00    1.70   1.61   5.00
vdd               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
vda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
vdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
vdc               0.00    14.00    1.00   27.00     0.00     4.14   303.43     0.04    1.61    1.00    1.63   1.61   4.50
vdd               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
vda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
vdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
vdc               0.00    27.00    1.00  776.00     0.00    35.48    93.53    19.57   25.19    0.00   25.22   0.25  19.80
vdd               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
vda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
vdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
vdc               0.00    15.00    0.00   24.00     0.00     3.76   321.00     0.06    2.33    0.00    2.33   2.33   5.60
vdd               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
vda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
vdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
vdc               0.00     0.00    1.00    0.00     0.00     0.00     8.00     0.00    1.00    1.00    0.00   1.00   0.10
vdd               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
vda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
vdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
vdc               0.00     0.00    1.00    0.00     0.00     0.00     8.00     0.00    1.00    1.00    0.00   1.00   0.10
vdd               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00


>  db.t0626.count()
2829406
> db.t0626.count()
2473771
> db.t0626.count()
2451852
> db.t0626.count()
2430671
> db.t0626.count()
2417398
> db.t0626.count()
2401220
> db.t0626.count()
2382003
> db.t0626.count()
1218325
> db.t0626.count()
1196764
> db.t0626.count()
1178612
> db.t0626.count()
1161123
> db.t0626.count()
1143784
> db.t0626.count()
1128623
> db.t0626.count()
135139
> db.t0626.count()
135139
> db.t0626.count()
135139
> db.t0626.count()
135139
> db.t0626.count()
135139
> db.t0626.count()
135139
> db.t0626.count()
134701
> db.t0626.count()
134701
> db.t0626.count()
134701
> db.t0626.count()
134701
> db.t0626.count()
134701
> db.t0626.count()
134582
> db.t0626.count()
134582
> db.t0626.count()
134582
> db.t0626.count()
134582

插入： "createdAt" : new Date()
得到的数据如下： "createdAt" : ISODate("2020-06-28T09:44:17.282Z")


table_clubgamelog、table_clubgamescorerobotdetail
这两个表目前是在 MongoDB中存储，如果按照之前的策略， table_clubgamelog 保存近32天的数据， table_clubgamescorerobotdetail表保存近62天的数据， 


----------------------------------------------------------------------------------------------------------------------------------------------------------

for (i=0; i<1000; i++) {db.t30.insert({"i" : i, "username" : "user"+i, "age" : Math.floor(Math.random()*120), "created" : '2020-06-05 00:00:00'})}

db.t30.find().forEach(function(data) {
    data.createds= new ISODate(data.created);
    db.t30.save(data);
});

> db.t30.find()
{ "_id" : ObjectId("5ef8611538f738aa0313a6ca"), "i" : 0, "username" : "user0", "age" : 60, "created" : "2020-06-05 00:00:00", "createds" : ISODate("2020-06-05T00:00:00Z") }
{ "_id" : ObjectId("5ef8611538f738aa0313a6cb"), "i" : 1, "username" : "user1", "age" : 117, "created" : "2020-06-05 00:00:00", "createds" : ISODate("2020-06-05T00:00:00Z") }
{ "_id" : ObjectId("5ef8611538f738aa0313a6cc"), "i" : 2, "username" : "user2", "age" : 75, "created" : "2020-06-05 00:00:00", "createds" : ISODate("2020-06-05T00:00:00Z") }
{ "_id" : ObjectId("5ef8611538f738aa0313a6cd"), "i" : 3, "username" : "user3", "age" : 15, "created" : "2020-06-05 00:00:00", "createds" : ISODate("2020-06-05T00:00:00Z") }
{ "_id" : ObjectId("5ef8611538f738aa0313a6ce"), "i" : 4, "username" : "user4", "age" : 22, "created" : "2020-06-05 00:00:00", "createds" : ISODate("2020-06-05T00:00:00Z") }
{ "_id" : ObjectId("5ef8611538f738aa0313a6cf"), "i" : 5, "username" : "user5", "age" : 55, "created" : "2020-06-05 00:00:00", "createds" : ISODate("2020-06-05T00:00:00Z") }
{ "_id" : ObjectId("5ef8611538f738aa0313a6d0"), "i" : 6, "username" : "user6", "age" : 51, "created" : "2020-06-05 00:00:00", "createds" : ISODate("2020-06-05T00:00:00Z") }
{ "_id" : ObjectId("5ef8611538f738aa0313a6d1"), "i" : 7, "username" : "user7", "age" : 64, "created" : "2020-06-05 00:00:00", "createds" : ISODate("2020-06-05T00:00:00Z") }
{ "_id" : ObjectId("5ef8611538f738aa0313a6d2"), "i" : 8, "username" : "user8", "age" : 25, "created" : "2020-06-05 00:00:00", "createds" : ISODate("2020-06-05T00:00:00Z") }
{ "_id" : ObjectId("5ef8611538f738aa0313a6d3"), "i" : 9, "username" : "user9", "age" : 85, "created" : "2020-06-05 00:00:00", "createds" : ISODate("2020-06-05T00:00:00Z") }
{ "_id" : ObjectId("5ef8611538f738aa0313a6d4"), "i" : 10, "username" : "user10", "age" : 83, "created" : "2020-06-05 00:00:00", "createds" : ISODate("2020-06-05T00:00:00Z") }
{ "_id" : ObjectId("5ef8611538f738aa0313a6d5"), "i" : 11, "username" : "user11", "age" : 58, "created" : "2020-06-05 00:00:00", "createds" : ISODate("2020-06-05T00:00:00Z") }
{ "_id" : ObjectId("5ef8611538f738aa0313a6d6"), "i" : 12, "username" : "user12", "age" : 62, "created" : "2020-06-05 00:00:00", "createds" : ISODate("2020-06-05T00:00:00Z") }
{ "_id" : ObjectId("5ef8611538f738aa0313a6d7"), "i" : 13, "username" : "user13", "age" : 9, "created" : "2020-06-05 00:00:00", "createds" : ISODate("2020-06-05T00:00:00Z") }
{ "_id" : ObjectId("5ef8611538f738aa0313a6d8"), "i" : 14, "username" : "user14", "age" : 55, "created" : "2020-06-05 00:00:00", "createds" : ISODate("2020-06-05T00:00:00Z") }
{ "_id" : ObjectId("5ef8611538f738aa0313a6d9"), "i" : 15, "username" : "user15", "age" : 4, "created" : "2020-06-05 00:00:00", "createds" : ISODate("2020-06-05T00:00:00Z") }
{ "_id" : ObjectId("5ef8611538f738aa0313a6da"), "i" : 16, "username" : "user16", "age" : 77, "created" : "2020-06-05 00:00:00", "createds" : ISODate("2020-06-05T00:00:00Z") }
{ "_id" : ObjectId("5ef8611538f738aa0313a6db"), "i" : 17, "username" : "user17", "age" : 111, "created" : "2020-06-05 00:00:00", "createds" : ISODate("2020-06-05T00:00:00Z") }
{ "_id" : ObjectId("5ef8611538f738aa0313a6dc"), "i" : 18, "username" : "user18", "age" : 77, "created" : "2020-06-05 00:00:00", "createds" : ISODate("2020-06-05T00:00:00Z") }
{ "_id" : ObjectId("5ef8611538f738aa0313a6dd"), "i" : 19, "username" : "user19", "age" : 45, "created" : "2020-06-05 00:00:00", "createds" : ISODate("2020-06-05T00:00:00Z") }
Type "it" for more


db.t30.createIndex({"createds":1},{expireAfterSeconds:2419200});



ObjectId("5ef8611538f738aa0313a6da").getTimestamp()


> ObjectId("5ef8611538f738aa0313a6da").getTimestamp()
ISODate("2020-06-28T09:21:25Z")



24 8 * * * /usr/bin/python /home/coding001/scripts/pt_archiver_delete_py2.py -soD=niuniuh5_db -soT=table_clubgamescorerobotdetail -field=tEndTime -beforeDay=-62
30 8 * * * /usr/bin/python /home/coding001/scripts/pt_archiver_delete_py2.py -soD=niuniuh5_db -soT=table_clubgamelog -field=tEndTime -beforeDay=-32
35 8 * * * /usr/bin/python /home/coding001/scripts/pt_archiver_delete_py2.py -soD=niuniuh5_db -soT=table_report_log -field=CreateTime -beforeDay=-32


mysqldump   --single-transaction --master-data=2 -B niuniuh5_db --tables table_clubmember >  table_clubmember.sql


如何在指定日期删除？




