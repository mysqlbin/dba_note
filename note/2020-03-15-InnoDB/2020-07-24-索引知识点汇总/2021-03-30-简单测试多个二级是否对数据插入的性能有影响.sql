

1. 环境
	
	DROP PROCEDURE IF EXISTS `idata`;
	DELIMITER ;;
	create procedure idata()
	begin
	  declare i int;
	  set i=1;
	  while(i<=10000)do
		insert into t_20210330(name, age, ismale) values(substring(md5(rand()),1,10), i, FLOOR(1 + (RAND() * 100)));
		set i=i+1;
	  end while;
	end;;
	delimiter ;


	show global variables like '%sync_binlog%';
	show global variables like '%innodb_flush_log_at_trx_commit%';


	mysql> show global variables like '%sync_binlog%';
	+---------------+-------+
	| Variable_name | Value |
	+---------------+-------+
	| sync_binlog   | 1     |
	+---------------+-------+
	1 row in set (0.00 sec)

	mysql> show global variables like '%innodb_flush_log_at_trx_commit%';
	+--------------------------------+-------+
	| Variable_name                  | Value |
	+--------------------------------+-------+
	| innodb_flush_log_at_trx_commit | 1     |
	+--------------------------------+-------+
	1 row in set (0.01 sec)

	随机读写的磁盘IOPS 为 50的机械盘。
	
	
2. 3个二级索引
	
	DROP TABLE IF EXISTS `t_20210330`;
	CREATE TABLE `t_20210330` (
	  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',  
	  `name` varchar(32) not NULL default '',
	  `age` int(11) not NULL default 0,
	  `ismale` tinyint(1) not null default 0,
	  `createTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
	  PRIMARY KEY (`id`),
	  KEY `idx_name` (`name`),
	  KEY `idx_age` (`age`),
	  KEY `idx_createTime` (`createTime`)
	) ENGINE=InnoDB;


	mysql> call idata();
	Query OK, 1 row affected (11 min 44.08 sec)


	[root@localhost ~]# iostat -dmx 1
	Linux 3.10.0-514.el7.x86_64 (localhost.localdomain) 	2021年03月30日 	_x86_64_	(4 CPU)

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.01     0.17    0.11    0.96     0.01     0.02    51.46     0.02   23.17    3.03   25.54   6.68   0.71
	dm-0              0.00     0.00    0.04    0.27     0.01     0.01    82.57     0.01   47.08    3.83   53.94   7.10   0.22
	dm-1              0.00     0.00    0.00    0.01     0.00     0.00     8.01     0.00   44.12   14.18   44.54   0.28   0.00
	dm-2              0.00     0.00    0.08    0.71     0.00     0.01    36.73     0.01   17.57    3.90   19.06   6.35   0.50

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00     0.00    0.00   84.00     0.00     0.23     5.71     0.98   11.88    0.00   11.88  11.69  98.20
	dm-0              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	dm-1              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	dm-2              0.00     0.00    0.00   56.00     0.00     0.23     8.57     0.98   17.84    0.00   17.84  17.55  98.30

	.........................................................................................................................

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00     0.00    0.00   90.00     0.00     0.25     5.69     0.98   10.99    0.00   10.99  10.89  98.00
	dm-0              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	dm-1              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	dm-2              0.00     0.00    0.00   60.00     0.00     0.25     8.53     0.98   16.48    0.00   16.48  16.33  98.00

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00     0.00    0.00   84.00     0.00     0.23     5.62     0.99   11.74    0.00   11.74  11.74  98.60
	dm-0              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	dm-1              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	dm-2              0.00     0.00    0.00   56.00     0.00     0.23     8.43     0.99   17.61    0.00   17.61  17.61  98.60

	
3. 0个二级索引 

	DROP TABLE IF EXISTS `t_20210330`;
	CREATE TABLE `t_20210330` (
	  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',  
	  `name` varchar(32) not NULL default '',
	  `age` int(11) not NULL default 0,
	  `ismale` tinyint(1) not null default 0,
	  `createTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB;
	
	root@mysqldb 11:45:  [test_db]> call idata();
	Query OK, 1 row affected (11 min 39.36 sec)
	
	
	[root@localhost ~]# iostat -dmx 1
	Linux 3.10.0-514.el7.x86_64 (localhost.localdomain) 	2021年03月30日 	_x86_64_	(4 CPU)

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.01     0.17    0.11    0.96     0.01     0.02    51.36     0.02   23.14    3.03   25.51   6.69   0.72
	dm-0              0.00     0.00    0.04    0.27     0.01     0.01    82.57     0.01   47.08    3.83   53.93   7.10   0.22
	dm-1              0.00     0.00    0.00    0.01     0.00     0.00     8.01     0.00   44.12   14.18   44.54   0.28   0.00
	dm-2              0.00     0.00    0.08    0.72     0.00     0.01    36.67     0.01   17.57    3.90   19.06   6.37   0.51

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00     0.00    0.00   90.00     0.00     0.25     5.60     0.98   10.94    0.00   10.94  10.94  98.50
	dm-0              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	dm-1              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	dm-2              0.00     0.00    0.00   60.00     0.00     0.25     8.40     0.98   16.42    0.00   16.42  16.42  98.50

	.........................................................................................................................

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00     0.00    0.00   91.00     0.00     0.25     5.54     0.98   10.84    0.00   10.84  10.82  98.50
	dm-0              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	dm-1              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	dm-2              0.00     0.00    0.00   60.00     0.00     0.24     8.27     0.98   16.43    0.00   16.43  16.42  98.50


4. 1个二级索引


	DROP TABLE IF EXISTS `t_20210330`;
	CREATE TABLE `t_20210330` (
	  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',  
	  `name` varchar(32) not NULL default '',
	  `age` int(11) not NULL default 0,
	  `ismale` tinyint(1) not null default 0,
	  `createTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
	  PRIMARY KEY (`id`),
	  KEY `idx_createTime` (`createTime`)
	) ENGINE=InnoDB;




5. 耗时对比
	3个二级索引
		mysql> call idata();
		Query OK, 1 row affected (11 min 44.08 sec)
		704 秒
		
	0个二级索引
		mysql> call idata();
		Query OK, 1 row affected (11 min 39.36 sec)
		699 秒
		
	1个二级索引	
		mysql> call idata();
		Query OK, 1 row affected (11 min 42.04 sec)


	关闭change buffer

		3个二级索引
			-- 第一次测试
			mysql> call idata();
			Query OK, 1 row affected (11 min 49.22 sec)
			
			-- 第二次测试
			mysql> call idata();
			Query OK, 1 row affected (11 min 45.77 sec)
			
			
	

6. 小结
	目前的测试没看到有什么性能影响。
	
	
	