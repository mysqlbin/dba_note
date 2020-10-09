

环境：
	4核CPU
	4G物理内存
	200GB的SSD盘
	
	随机读写大概分约为1000
	
	顺序读为 7000
	
原数据大小	
	repl_set:PRIMARY> show dbs
	abc_db     0.000GB
	admin      0.000GB
	config     0.000GB
	local      3.532GB
	app_db     8.639GB


备份文件的大小
	shell> ls -lht
	total 2.3G
	
	
time mongorestore --host "10.10.10.10:27017"  -u "admin" -p "123456" --authenticationDatabase "admin" -d app_db --gzip --dir='/home/dba2/app_db20200909/app_db'

real	20m12.285s
user	5m36.485s
sys	0m12.723s

恢复后的数据信息
	repl_set:PRIMARY> show dbs
	abc_db     0.001GB
	admin      0.000GB
	benet      0.000GB
	config     0.000GB
	local      2.491GB
	app_db     5.587GB
	test       0.049GB

