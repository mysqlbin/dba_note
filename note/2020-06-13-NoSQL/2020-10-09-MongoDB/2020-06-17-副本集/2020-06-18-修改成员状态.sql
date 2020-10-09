


https://docs.mongodb.com/manual/reference/method/rs.stepDown/

   
当前副本集架构：
	主库：192.168.0.1
	副库：192.168.0.2
	
1. 把主节点变为备份节点 --rs.stepDown
	
	在Mongodb复制集主从切换的时候，使用rs.stepDown(seconds)，将当前主库实例“降级”，则seconds时间内，这个实例不会把自己选为primary角色。
	
	
	192.168.0.1			
		repl_set:PRIMARY> rs.stepDown(5)
		{
			"operationTime" : Timestamp(1592465695, 2),
			"ok" : 0,
			"errmsg" : "stepdown period must be longer than secondaryCatchUpPeriodSecs",
			"code" : 2,
			"codeName" : "BadValue",
			"$clusterTime" : {
				"clusterTime" : Timestamp(1592465695, 2),
				"signature" : {
					"hash" : BinData(0,"6jsjT/TOHNYblw4YnwDuI2rkwco="),
					"keyId" : NumberLong("6838881995993382915")
				}
			}
		}


	下台时间必须长于 secondaryCatchUpPeriodSecs
	192.168.0.1
		repl_set:PRIMARY> 
		repl_set:PRIMARY> rs.stepDown(10)
		{
			"ok" : 1,
			"$clusterTime" : {
				"clusterTime" : Timestamp(1592470471, 1),
				"signature" : {
					"hash" : BinData(0,"hgEu2YzAhuPtnrcCjFrK74P7OcI="),
					"keyId" : NumberLong("6838881995993382915")
				}
			},
			"operationTime" : Timestamp(1592470471, 1)
		}
		repl_set:SECONDARY> 
	
		repl_set:SECONDARY> db.test.findOne()
		{
			"_id" : ObjectId("5eeb1e0bdb2e83b27687dfa8"),
			"luo" : 100,
			"test_key" : 10
		}

	192.168.0.2
		shell> mongo -host 192.168.0.2 -u admin -p admin123456


		repl_set:PRIMARY> 
		
		
2. replSetStepDown

https://docs.mongodb.com/manual/reference/command/replSetStepDown/
db.adminCommand( { replSetStepDown: 120 } )
