



[SQL]truncate table abc_db.table_abc20200628;
[Err] 1030 - Got error 168 from storage engine

[root@database ~]# df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/vda1        59G   17G   40G  30% /
devtmpfs        7.8G     0  7.8G   0% /dev
tmpfs           7.8G     0  7.8G   0% /dev/shm
tmpfs           7.8G  908K  7.8G   1% /run
tmpfs           7.8G     0  7.8G   0% /sys/fs/cgroup
/dev/vdb         99G   94G     0 100% /mydata
tmpfs           1.6G     0  1.6G   0% /run/user/0


释放部分磁盘空间

[root@database souce]# ll
total 0
[root@database souce]# df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/vda1        59G   17G   40G  30% /
devtmpfs        7.8G     0  7.8G   0% /dev
tmpfs           7.8G     0  7.8G   0% /dev/shm
tmpfs           7.8G  908K  7.8G   1% /run
tmpfs           7.8G     0  7.8G   0% /sys/fs/cgroup
/dev/vdb         99G   93G  841M 100% /mydata
tmpfs           1.6G     0  1.6G   0% /run/user/0


之后再执行删除操作。

truncate table abc_db.table_abc20200628;
truncate table abc_db.table_abc20200627;
truncate table abc_db.table_abc20200626;
truncate table abc_db.table_abc20200625;
truncate table abc_db.table_abc20200624;
truncate table abc_db.table_abc20200623;
truncate table abc_db.table_abc20200622;
truncate table abc_db.table_abc20200621;
truncate table abc_db.table_abc20200620;



