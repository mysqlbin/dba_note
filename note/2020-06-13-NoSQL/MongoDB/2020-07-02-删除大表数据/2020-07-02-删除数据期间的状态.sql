
1. 先把数据导入进来
2. 添加索引和把MySQL类型的时间转换MongoDB类型的时间
3. 查看数据
4. 删除 17W个文档产生的影响
4.1 查看复制延迟
4.2 耗时
4.3 消耗的IO资源
4.4 消耗的CPU资源
5. 有索引和没有索引的耗时对比

1. 先把数据导入进来
	time /usr/local/mongodb/bin/mongoimport --host ":27017"  -u "admin" -p "" --authenticationDatabase "admin" -d niuniu_h5 -c t1 -f szToken,tStartTime,tEndTime,nGameType,nServerID,LogData,CardData  --type csv  --file 20200628.csv



2. 添加索引和把MySQL类型的时间转换MongoDB类型的时间
	添加索引
		
		db.t1.ensureIndex({"szToken" : 1})
		db.t1.ensureIndex({"CreateTime" : 1})
		

	查看索引

		repl_set:PRIMARY> db.t1.getIndexes()
		[
			{
				"v" : 2,
				"key" : {
					"_id" : 1
				},
				"name" : "_id_",
				"ns" : "niuniu_h5.t1"
			},
			{
				"v" : 2,
				"key" : {
					"szToken" : 1
				},
				"name" : "szToken_1",
				"ns" : "niuniu_h5.t1"
			},
			{
				"v" : 2,
				"key" : {
					"CreateTime" : 1
				},
				"name" : "CreateTime_1",
				"ns" : "niuniu_h5.t1"
			}
		]


	db.t1.find().forEach(function(data) {
		data.CreateTime= new ISODate(data.tEndTime);
		db.t1.save(data);
	});


	mongostat -h 10.31.76.149 -u admin -p admin123456 --authenticationDatabase=admin
	[root@database-03 dba2]# mongostat -h 10.31.76.149 -u admin -p admin123456 --authenticationDatabase=admin
	insert query update delete getmore command dirty  used flushes vsize   res qrw arw net_in net_out conn      set repl                time
		*0    *0   1192     *0     298   331|0  2.5% 77.8%       0 3.29G 1.19G 0|0 1|0  2.44m   2.53m   11 repl_set  PRI Jul  2 11:42:44.275
		*0    *0   1237     *0     248   275|0  2.9% 78.0%       0 3.29G 1.19G 0|0 1|0  2.49m   2.59m   11 repl_set  PRI Jul  2 11:42:45.278
		*0    *0   1221     *0     297   330|0  3.3% 78.3%       0 3.29G 1.18G 0|1 1|0  2.63m   2.73m   11 repl_set  PRI Jul  2 11:42:46.273
		*0    *0   1208     *0     351   390|0  3.8% 78.6%       0 3.29G 1.18G 0|1 1|0  2.72m   2.79m   11 repl_set  PRI Jul  2 11:42:47.273
		*0    *0   1217     *0     355   398|0  4.2% 78.8%       0 3.29G 1.18G 0|1 1|0  2.47m   2.53m   11 repl_set  PRI Jul  2 11:42:48.274
		*0    *0   1214     *0     333   375|0  4.7% 79.1%       0 3.29G 1.18G 0|0 1|0  2.70m   2.78m   11 repl_set  PRI Jul  2 11:42:49.273
		*0    *0   1224     *0     320   361|0  5.1% 79.3%       0 3.29G 1.18G 0|0 1|0  2.50m   2.58m   11 repl_set  PRI Jul  2 11:42:50.273
		*0    *0   1213     *0     269   303|0  4.0% 79.5%       0 3.29G 1.18G 0|1 1|0  2.50m   2.59m   11 repl_set  PRI Jul  2 11:42:51.275
		*0    *0   1221     *0     321   353|0  4.4% 79.8%       0 3.29G 1.18G 0|1 1|0  2.54m   2.63m   11 repl_set  PRI Jul  2 11:42:52.273
		*0    *0   1153     *0     332   364|0  3.8% 79.7%       0 3.29G 1.18G 0|1 1|0  2.47m   19.3m   11 repl_set  PRI Jul  2 11:42:53.274
	insert query update delete getmore command dirty  used flushes vsize   res qrw arw net_in net_out conn      set repl                time
		*0    *0   1195     *0     380   429|0  4.1% 79.9%       0 3.29G 1.18G 0|0 1|0  2.68m   2.75m   11 repl_set  PRI Jul  2 11:42:54.276
		*0    *0   1218     *0     357   389|0  4.6% 80.2%       0 3.29G 1.17G 0|0 1|0  2.73m   2.77m   11 repl_set  PRI Jul  2 11:42:55.273
		*0    *0   1201     *0     365   404|0  4.4% 78.7%       0 3.29G 1.17G 0|0 1|0  2.78m   2.81m   11 repl_set  PRI Jul  2 11:42:56.273
		*0    *0   1193     *0     389   426|0  4.9% 78.9%       0 3.29G 1.17G 0|0 1|0  2.81m   2.93m   11 repl_set  PRI Jul  2 11:42:57.274
		*0    *0   1205     *0     392   430|0  5.3% 79.2%       0 3.29G 1.17G 0|0 1|0  2.63m   2.69m   11 repl_set  PRI Jul  2 11:42:58.273
	^C2020-07-02T11:42:59.085+0800	signal 'interrupt' received; forcefully terminating


3. 查看数据
	repl_set:PRIMARY> db.t1.findOne()
	{
		"_id" : ObjectId("5efd530e6850905fc96f915e"),
		"szToken" : "10128-258504-1588089589-1-2",
		"tStartTime" : "2020-04-28 23:59:49",
		"tEndTime" : "2020-04-29 00:00:00",
		"nGameType" : 15,
		"nServerID" : 1501,
		"LogData" : "{\"LogCount\":26,\"jsonlog\":[{\"1\":\"玩家账户:202483 座位号:2\"},{\"2\":\"抢庄牛牛新手房,底分 1\"},{\"3\":\"1 号位,携带金额 341.324\"},{\"4\":\"2 号位,携带金额 283.5\"},{\"5\":\"3 号位,携带金额 170.822\"},{\"6\":\"4 号位,携带金额 293.783\"},{\"7\":\"抢庄\"},{\"8\":\"4 号位,4号位,开局第1秒,不抢\"},{\"9\":\"1 号位,1号位,开局第1秒,抢庄成功X1倍\"},{\"10\":\"2 号位,2号位,开局第3秒,不抢\"},{\"11\":\"3 号位,3号位,开局第3秒,抢庄成功X1倍\"},{\"12\":\"3 号位,开局第3秒,抢庄成功\"},{\"13\":\"下注\"},{\"14\":\"4 号位,开局第4秒,下1倍\"},{\"15\":\"2 号位,开局第5秒,下8倍\"},{\"16\":\"1 号位,开局第6秒,下1倍\"},{\"17\":\"开牌\"},{\"18\":\"1 号位,开局第9秒,开牌\"},{\"19\":\"2 号位,开局第9秒,开牌\"},{\"20\":\"3 号位,开局第10秒,开牌\"},{\"21\":\"4 号位,开局第11秒,开牌\"},{\"22\":\"结算\"},{\"23\":\"1 号位,闲,本局输赢分数-2.0,牌值?9?8?7?5?2,牛一*1,下注分数=2.0\"},{\"24\":\"2 号位,闲,本局输赢分数-16.0,牌值?Q?4?3?3?A,牛一*1,下注分数=16.0\"},{\"25\":\"3 号位,庄,本局输赢分数15.2,牌值?K?Q?J?6?2,牛八*2,下注分数=20.0\"},{\"26\":\"4 号位,闲,本局输赢分数1.9,牌值?8?7?6?5?3,牛九*2,下注分数=2.0\"}],\"jsondata\":\"\"}",
		"CardData" : "",
		"CreateTime" : ISODate("2020-04-29T00:00:00Z")
	}


	mongodump  --host "10.31.76.149:27017"  -u "admin" -p "admin123456" --authenticationDatabase "admin"  -d niuniu_h5 --gzip  --out /home/dba2/`date +%Y%m%d` 


	repl_set:PRIMARY> db.t1.find({'$and': [ {'CreateTime': {'$lt': ISODate('2020-04-30 00:00:00')}},  {'tEndTime': {'$lt': '2020-04-30 00:00:00'}} ] }).count()
	161880

	select count(*) from table_clubgamelog where tEndTime < '2020-04-30 00:00:00'
	161880

	数据占用磁盘空间的大小：  7.60 GB
	导入后数据量总大小：      2.95 GB
	导入后数据的大小：        2.70 GB	
	导入后索引的大小：        0.25GB

  
	
	
4. 删除 17W个文档产生的影响

repl_set:PRIMARY> db.t1.remove({'$and': [ {'CreateTime': {'$lt': ISODate('2020-04-30 00:00:00')}},  {'tEndTime': {'$lt': '2020-04-30 00:00:00'}} ] })
WriteResult({ "nRemoved" : 161880 })

4.1 查看复制延迟
	repl_set:PRIMARY> db.printSlaveReplicationInfo()
	source: 10.31.76.227:27017
		syncedTo: Thu Jul 02 2020 14:40:32 GMT+0800 (CST)
		0 secs (0 hrs) behind the primary 
	repl_set:PRIMARY> db.printSlaveReplicationInfo()
	source: 10.31.76.227:27017
		syncedTo: Thu Jul 02 2020 14:40:42 GMT+0800 (CST)
		1 secs (0 hrs) behind the primary 
	repl_set:PRIMARY> db.printSlaveReplicationInfo()
	source: 10.31.76.227:27017
		syncedTo: Thu Jul 02 2020 14:40:42 GMT+0800 (CST)
		2 secs (0 hrs) behind the primary 
	repl_set:PRIMARY> db.printSlaveReplicationInfo()
	source: 10.31.76.227:27017
		syncedTo: Thu Jul 02 2020 14:40:44 GMT+0800 (CST)
		0 secs (0 hrs) behind the primary 
	repl_set:PRIMARY> db.printSlaveReplicationInfo()
	source: 10.31.76.227:27017
		syncedTo: Thu Jul 02 2020 14:40:44 GMT+0800 (CST)
		1 secs (0 hrs) behind the primary 
	repl_set:PRIMARY> db.printSlaveReplicationInfo()
	source: 10.31.76.227:27017
		syncedTo: Thu Jul 02 2020 14:40:46 GMT+0800 (CST)
		1 secs (0 hrs) behind the primary 
	repl_set:PRIMARY> db.printSlaveReplicationInfo()
	source: 10.31.76.227:27017
		syncedTo: Thu Jul 02 2020 14:40:48 GMT+0800 (CST)
		0 secs (0 hrs) behind the primary 
	repl_set:PRIMARY> db.printSlaveReplicationInfo()
	source: 10.31.76.227:27017
		syncedTo: Thu Jul 02 2020 14:40:48 GMT+0800 (CST)
		1 secs (0 hrs) behind the primary 
	repl_set:PRIMARY> db.printSlaveReplicationInfo()
	source: 10.31.76.227:27017
		syncedTo: Thu Jul 02 2020 14:40:48 GMT+0800 (CST)
		2 secs (0 hrs) behind the primary 
	repl_set:PRIMARY> db.printSlaveReplicationInfo()
	source: 10.31.76.227:27017
		syncedTo: Thu Jul 02 2020 14:40:50 GMT+0800 (CST)
		0 secs (0 hrs) behind the primary 

4.2 耗时
	耗时约10秒


4.3 消耗的IO资源
	iostat -dmx 1
	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	vda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	vdb               0.00    44.00    0.00  136.00     0.00     1.59    23.94     0.10    0.76    0.00    0.76   0.76  10.40

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	vda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	vdb               0.00   176.00    3.00  342.00     1.34     5.17    38.66     0.45    1.31   10.00    1.23   1.23  42.60

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	vda               0.00     8.00    0.00    2.00     0.00     0.04    40.00     0.00    0.50    0.00    0.50   0.50   0.10
	vdb               0.00   146.00   58.00  390.00     7.54     5.84    61.14     0.60    1.19    3.57    0.83   0.83  37.10

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	vda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	vdb               0.00   163.00   67.00  354.00    15.25     5.38   100.35     0.70    1.83    6.93    0.86   0.78  33.00

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	vda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	vdb               0.00   135.00   19.00  242.00     8.00     5.10   102.80     0.42    1.63    8.89    1.06   1.03  27.00

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	vda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	vdb               3.00   131.00   46.00  370.00    11.93     5.66    86.58     0.56    1.35    4.02    1.02   1.03  43.00

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	vda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	vdb               0.00   131.00    0.00  314.00     0.00     5.04    32.84     0.25    0.81    0.00    0.81   0.79  24.80

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	vda               0.00     0.00    0.00  100.00     0.00     0.44     9.04     0.57    5.68    0.00    5.68   0.06   0.60
	vdb               0.00   176.00   85.00  377.00     3.69     5.50    40.73     0.41    0.88    1.11    0.83   0.79  36.30

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	vda               0.00     0.00  105.00    0.00     4.08     0.00    79.62     3.34   31.84   31.84    0.00   0.62   6.50
	vdb               0.00   120.00  100.00  715.00    10.14    97.77   271.18    64.17   78.75    3.54   89.26   0.90  73.00

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	vda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	vdb               0.00    92.00   28.00  204.00     8.34     4.62   114.38     0.38    1.64    5.11    1.17   1.10  25.50

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	vda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	vdb               0.00   123.76   95.05  359.41    12.95     5.67    83.92     0.60    1.33    2.74    0.96   0.87  39.60

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	vda               0.00     9.00    0.00    2.00     0.00     0.04    44.00     0.00    0.50    0.00    0.50   0.50   0.10
	vdb               0.00   113.00   14.00  261.00     5.73     4.84    78.75     0.31    1.12    5.71    0.87   0.89  24.40

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	vda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	vdb               0.00    50.00    9.00  147.00     4.00     1.92    77.69     0.19    1.21    8.00    0.80   0.78  12.20

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	vda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	vdb               0.00     0.00    0.00    1.00     0.00     0.04    72.00     0.00    1.00    0.00    1.00   1.00   0.10

4.4 消耗的CPU资源	
	top
	top - 18:17:03 up 899 days,  1:53, 13 users,  load average: 1.06, 0.34, 0.26
	Tasks: 144 total,   2 running, 142 sleeping,   0 stopped,   0 zombie
	%Cpu0  : 43.9 us,  7.1 sy,  0.0 ni, 39.5 id,  8.8 wa,  0.0 hi,  0.7 si,  0.0 st
	%Cpu1  : 41.2 us,  8.4 sy,  0.0 ni, 40.5 id,  9.5 wa,  0.0 hi,  0.3 si,  0.0 st
	%Cpu2  : 42.9 us,  6.8 sy,  0.0 ni, 43.6 id,  6.8 wa,  0.0 hi,  0.0 si,  0.0 st
	%Cpu3  : 42.4 us,  7.8 sy,  0.0 ni, 44.1 id,  5.4 wa,  0.0 hi,  0.3 si,  0.0 st
	KiB Mem : 16267956 total,   285324 free, 12230664 used,  3751968 buff/cache
	KiB Swap:        0 total,        0 free,        0 used.  3660960 avail Mem 

	  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                     
	23061 mongodb   20   0 3451308 1.088g   7912 S 173.4  7.0 110:05.88 mongod                                                                                                                                                                      
	23214 root      10 -10  160444  42868   3660 S   6.0  0.3   1006:38 AliYunDun                                                                                                                                                                   
	15970 mysql     20   0 11.523g 0.010t   3672 S   2.3 65.9   3243:34 mysqld       


5. 有索引和没有索引的耗时对比

	--没有索引
		[root@database-03 dba2]# time python 2020-06-16.py

		real	0m19.157s
		user	0m0.103s
		sys	0m0.040s

		[root@database-03 dba2]# time python 2020-06-16.py

		real	0m19.681s
		user	0m0.121s
		sys	0m0.025s


	--有索引
		[root@database-03 dba2]# time python 2020-06-16.py

		real	0m10.643s
		user	0m0.121s
		sys	0m0.031s


		[root@database-03 dba2]# time python mongodb_old_data_delete_many.py -soD=niuniu_h5 -soT=t1 -beforeDay=-42
		2020-05-21 00:00:00
		Done.sent email success

		real	0m12.494s
		user	0m0.122s
		sys	0m0.035s


		[root@database-03 dba2]# time python 2020-06-16.py

		real	0m10.137s
		user	0m0.103s
		sys	0m0.034s


