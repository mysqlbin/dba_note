


recursion-method="processlist"  
	表示以什么方式发现从库。
	有hosts与processlist两种，默认processlist,可以在主库的 processlist 中找到从库复制进程，从而识别出有哪些从库，但如果使用是非标准3306端口，会导致找不到从库信息。
	此时就会自动采用host方式，但需要提前在从库 my.cnf 里面配置report_host、report_port信息。

no-check-replication-filters
	不检查复制过滤器，建议启用。后面可以用--databases来指定需要检查的数据库。
	
no-check-binlog-format:
	不检查复制的binlog模式，要是binlog模式是ROW，则会报错。
	

	shell> sudo pt-table-checksum --nocheck-replication-filters  --replicate=consistency_db.checksums h=192.168.1.10,u=pt_user,p='123456',P=3306 --databases=niuniuh5_db
	Checking if all tables can be checksummed ...
	Starting checksum ...
	Replica db-b has binlog_format ROW which could cause pt-table-checksum to break replication.  Please read "Replicas using row-based replication" in the LIMITATIONS section of the tool s documentation.  If you understand the risks, specify --no-check-binlog-format to disable this check.

	mysql> show global variables like '%binlog_format%';
	+---------------+-------+
	| Variable_name | Value |
	+---------------+-------+
	| binlog_format | ROW   |
	+---------------+-------+
	1 row in set (0.00 sec)

	shell> sudo pt-table-checksum --nocheck-replication-filters --no-check-binlog-format  --replicate=consistency_db.checksums h=192.168.1.10,u=pt_user,p='123456',P=3306 --databases=niuniuh5_db


replicate-check-only
	只显示不同步的信息。
	
replicate
	把checksum的信息写入到指定表中，建议直接写到被检查的数据库当中。  
	

chunk-size=z
	默认：1000
	每一个数据分块的行数。


check-interval
	当发现从库的延迟时间超过--max-lag定义的时间后，需要休眠等待的时间，默认是等待1秒。
	Sleep time between checks for --max-lag (
     default 1).  Optional suffix s=seconds, m=
     minutes, h=hours, d=days; if no suffix, s is  used.


max-lag=m                      
	Pause checksumming until all replicas lag
    is less than this value (default 1s).
    Optional suffix s=seconds, m=minutes, h=
    hours, d=days; if no suffix, s is used.
	
max-load

	默认当数据库有25个以上的活跃线程数时，pt-table-checksum会暂停。
	
	
								   
databases
	指定需要被检查的数据库，多个则用逗号隔开。
	
	
tables
	指定需要被检查的表，多个用逗号隔开   

h=127.0.0.1    ：Master的地址
u=root         ：用户名
p=123456       ：密码
P=3306         ：端口





