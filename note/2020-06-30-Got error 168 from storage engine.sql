



[SQL]truncate table niuniu_db.table_clublogscore20200628;
[Err] 1030 - Got error 168 from storage engine

[root@database-04 ~]# df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/vda1        59G   17G   40G  30% /
devtmpfs        7.8G     0  7.8G   0% /dev
tmpfs           7.8G     0  7.8G   0% /dev/shm
tmpfs           7.8G  908K  7.8G   1% /run
tmpfs           7.8G     0  7.8G   0% /sys/fs/cgroup
/dev/vdb         99G   94G     0 100% /mydata
tmpfs           1.6G     0  1.6G   0% /run/user/0


释放部分磁盘空间

[root@database-04 souce]# ll
total 0
[root@database-04 souce]# df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/vda1        59G   17G   40G  30% /
devtmpfs        7.8G     0  7.8G   0% /dev
tmpfs           7.8G     0  7.8G   0% /dev/shm
tmpfs           7.8G  908K  7.8G   1% /run
tmpfs           7.8G     0  7.8G   0% /sys/fs/cgroup
/dev/vdb         99G   93G  841M 100% /mydata
tmpfs           1.6G     0  1.6G   0% /run/user/0


之后再执行删除操作。

truncate table niuniu_db.table_clublogscore20200628;
truncate table niuniu_db.table_clublogscore20200627;
truncate table niuniu_db.table_clublogscore20200626;
truncate table niuniu_db.table_clublogscore20200625;
truncate table niuniu_db.table_clublogscore20200624;
truncate table niuniu_db.table_clublogscore20200623;
truncate table niuniu_db.table_clublogscore20200622;
truncate table niuniu_db.table_clublogscore20200621;
truncate table niuniu_db.table_clublogscore20200620;




ALTER TABLE table_clubgamescoredetail20200630 MODIFY ID bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引';
ALTER TABLE table_clublogscore20200630 MODIFY ID bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引';


