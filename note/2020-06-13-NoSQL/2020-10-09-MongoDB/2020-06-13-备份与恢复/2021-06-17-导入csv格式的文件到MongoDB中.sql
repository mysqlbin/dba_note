


time /usr/local/mongodb/bin/mongoimport --host "127.0.0.1:27017"  -u "admin" -p "admina123456abc" --authenticationDatabase "admin" -d abc_h5_db -c table_league_user_pic_large -f  nPlayerId,d  --type csv  --file aa.csv
time /usr/local/mongodb/bin/mongoimport --host "127.0.0.1:27017"  -u "admin" -p "admina123456abc" --authenticationDatabase "admin" -d abc_h5_db -c table_league_user_pic_small -f  nPlayerId,d  --type csv  --file aa.csv



db.table_league_user_pic_large.createIndex({"nPlayerID" : 1})
db.table_league_user_pic_mid.createIndex({"nPlayerID" : 1})
db.table_league_user_pic_small.createIndex({"nPlayerID" : 1})



time /usr/local/mongodb/bin/mongoimport --host "127.0.0.1:27017"  -u "admin" -p "admina123456abc" --authenticationDatabase "admin" -d abc_h5_db -c table_league_user_pic_large -f  nPlayerId,picdata,createTime  --type csv  --file table_league_user_pic_large.csv
time /usr/local/mongodb/bin/mongoimport --host "127.0.0.1:27017"  -u "admin" -p "admina123456abc" --authenticationDatabase "admin" -d abc_h5_db -c table_league_user_pic_small -f  nPlayerId,picdata,createTime  --type csv  --file table_league_user_pic_small.csv



db.table_league_user_pic_large.find().limit(1)


"nPlayerId" : "nPlayerId"
db.table_league_user_pic_large.remove({'nPlayerId':'nPlayerId'})
db.table_league_user_pic_small.remove({'nPlayerId':'nPlayerId'})
