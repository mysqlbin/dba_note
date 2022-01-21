

> show dbs;
admin       0.000GB
config      0.000GB
local       1.017GB
niuniu_h5  12.606GB
test        0.050GB
> 

> db.table_club_fangka_cfg.drop();
true

> show dbs;
admin       0.000GB
config      0.000GB
local       1.017GB
niuniu_h5  12.606GB
test        0.050GB
> db.table_clubgamelog.remove({})
WriteResult({ "nRemoved" : 858592 })
> show dbs;
admin       0.000GB
config      0.000GB
local       1.017GB
niuniu_h5  12.606GB
test        0.050GB

> db.table_clubgamelog.count()
0


remove() 清空文档中的所有集合，不会回收磁盘空间。