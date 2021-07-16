


--recursion-method="processlist"  
	表示以什么方式发现从库。有hosts与processlist两种，默认processlist,可以在主库的 processlist 中找到从库复制进程，从而识别出有哪些从库，但如果使用是非标准3306端口，会导致找不到从库信息。此时就会自动采用host方式，但需要提前在从库 my.cnf 
	里面配置report_host、report_port信息。

--nocheck-replication-filters ：
	不检查复制过滤器，建议启用。后面可以用--databases来指定需要检查的数据库。
	
--no-check-binlog-format: 
	不检查复制的binlog模式，要是binlog模式是ROW，则会报错。
	
--replicate-check-only :
	只显示不同步的信息。
--replicate=   ：
	把checksum的信息写入到指定表中，建议直接写到被检查的数据库当中。  
	
--databases=：
	指定需要被检查的数据库，多个则用逗号隔开。
	
--tables= ：
	指定需要被检查的表，多个用逗号隔开   

h=127.0.0.1    ：Master的地址
u=root         ：用户名
p=123456       ：密码
P=3306         ：端口





