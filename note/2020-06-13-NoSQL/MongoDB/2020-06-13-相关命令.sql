

db.table_clubgamescorerobotdetail.stats(); 
db.table_clubgamelog.stats();

db.t1.aggregate([{$group : {_id : "$by_user", num_tutorial : {$sum : 1}}}])
{ "_id" : null, "num_tutorial" : 500003 }





db.t1.stats(); 
db.t2.stats();
