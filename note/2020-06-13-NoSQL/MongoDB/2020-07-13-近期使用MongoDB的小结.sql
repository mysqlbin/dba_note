


1. 当前实例的Mongodb集合已经有数据，是否可以通过别的实例备份同一个集合的数据，然后导入备份的数据到当前实例已有集合中，而不影响已经有的数据？
	不影响。
	没有 schema 的设计，还是挺灵活的。


2. 集合写入的数据跟导入的数据key的位置/先后顺序不一样，是否有问题？

	不会有问题。
	
	导入的数据：
		repl_set:PRIMARY> db.table_clubgamescorerobotdetail.findOne({"szToken": "10001-649413-1575254160-1"})
		{
			"_id" : ObjectId("5f07c26053b953b6b8bd5a7b"),
			"nClubID" : 10001,
			"nTableID" : 649413,
			"nChairID" : 2,
			"szToken" : "10001-649413-1575254160-1",
			"nRound" : 1,
			"nBaseScore" : 2000,
			"nPlayCount" : 2,
			"tStartTime" : "2019-12-02 10:36:00",
			"tEndTime" : "2019-12-02 10:38:30",
			"nPlayerID" : 93480,
			"bRobot" : 1,
			"szCardData" : "",
			"nEnterScore" : 87061,
			"nBetScore" : 2080,
			"nValidBet" : 2080,
			"nResultMoney" : 1976,
			"nPlayerScore" : 89037,
			"nTax" : 104,
			"nGameType" : 24,
			"nServerID" : 2401,
			"nCardData" : "羸",
			"nBankID" : 0,
			"szExtChar" : ""
		}

	应用程序写入的数据
		repl_set:PRIMARY> db.table_clubgamescorerobotdetail.findOne({"szToken": "10001-532706-1594634034-1"})
		{
			"_id" : ObjectId("5f0c2fb23f2609480e7a3bc4"),
			"nBetScore" : 4000,
			"bRobot" : 1,
			"nResultMoney" : 3800,
			"nCardData" : "01261111370929362809012425",
			"nChairID" : 3,
			"nTableID" : 532706,
			"nTax" : 200,
			"CardData" : "01261111370929362809012425,06211712230213330805241113,07272223323231130507022504,08181719052716351501152823,2",
			"szToken" : "10001-532706-1594634034-1",
			"szCardData" : "",
			"nRound" : 1,
			"tEndTime" : "2020-07-13 17:56:02",
			"nPlayCount" : 4,
			"nEnterScore" : 94905,
			"nClubID" : 10001,
			"nBaseScore" : 1000,
			"nBankID" : 0,
			"nGameType" : 25,
			"nPlayerScore" : 98705,
			"tStartTime" : "2020-07-13 17:53:54",
			"CreateTime" : ISODate("2020-07-13T09:56:02Z"),
			"nValidBet" : 4000,
			"nPlayerID" : 75182,
			"szExtChar" : "",
			"nServerID" : 2501
		}


	
3. 

	