

https://docs.mongodb.com/manual/core/index-ttl/


-- for (i=0; i<1000; i++) {db.t1.insert({"i" : i, "username" : "user"+i, "age" : Math.floor(Math.random()*120), "created" : new Date()})}


repl_set:PRIMARY> db.table_clubgamescorerobotdetail.findOne()
{
	"_id" : ObjectId("5ef07d5e3dfa4714a679da9e"),
	"nClubID" : 10001,
	"nTableID" : 870733,
	"nChairID" : 2,
	"szToken" : "10001-870733-1574845263-1",
	"nRound" : 1,
	"nBaseScore" : 1000,
	"nPlayCount" : 4,
	"tStartTime" : "2019/11/27 17:01:03",
	"tEndTime" : "2019/11/27 17:01:18",
	"nPlayerID" : 90501,
	"bRobot" : 1,
	"szCardData" : 629343105,
	"nEnterScore" : 3033857,
	"nBetScore" : 75000,
	"nValidBet" : 75000,
	"nResultMoney" : 54150,
	"nPlayerScore" : 3088007,
	"nTax" : 2850,
	"nGameType" : 9,
	"nServerID" : 901,
	"nCardData" : 629343105,
	"nBankID" : 90501,
	"szExtChar" : ""
}


