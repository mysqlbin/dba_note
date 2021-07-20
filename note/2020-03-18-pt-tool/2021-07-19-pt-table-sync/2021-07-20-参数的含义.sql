



replicate	：指定通过pt-table-checksum得到的表，这2个工具差不多都会一直用。
databases	: 指定执行同步的数据库，多个用逗号隔开。
tables		：指定执行同步的表，多个用逗号隔开。
sync-to-master ：指定一个DSN，即从的IP，他会通过show processlist或show slave status 去自动的找主。
print       ：打印，但不执行命令。
execute     ：执行命令。
h=127.0.0.1   ：服务器地址，命令里有2个ip，第一次出现的是Master的地址，第2次是Slave的地址。
u=root        ：帐号。
p=123456      ：密码。


示例
	-- 在主库执行
	shell> sudo pt-table-sync --replicate=consistency_db.checksums h=192.168.1.10,u=pt_user,p='%123456Abc',P=3306 --databases=sbtest --print 
	REPLACE INTO `sbtest`.`t0`(`id`, `r0`, `r1`, `r2`, `r3`, `r4`, `r5`, `r6`, `r7`, `r8`, `r9`, `r10`) VALUES ('1', '6919', '5853', '8509', '4982', '9385', '1979', '1737', '2748', '8527', '4392', '6380') 
	/*percona-toolkit src_db:sbtest src_tbl:t0 src_dsn:P=3306,h=192.168.1.10,p=...,u=pt_user dst_db:sbtest dst_tbl:t0 dst_dsn:P=3306,h=192.168.1.11,p=...,u=pt_user lock:1 transaction:1 changing_src:consistency_db.checksums replicate:consistency_db.checksums bidirectional:0 pid:775 user:root host:db-a*/;
