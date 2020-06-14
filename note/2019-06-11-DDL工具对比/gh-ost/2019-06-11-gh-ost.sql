
简介：
	2016年8月份,shlomi-noach在GitHub Engineering发文宣布gh-ost开源。gh-ost是什么？一个不依赖触发器实现的在线表结构变


gh-ost介绍
	触发器的作用是源表和幽灵表之间的增量数据同步，gh-ost 放弃了触发器，使用 binlog 来做增量数据同步。(理解了)
	gh-ost 作为一个伪装的备库，可以从主库/备库上拉取 binlog，过滤之后重新应用到主库上去，相当于主库上的增量操作通过 binlog 又应用回主库本身，不过是应用在幽灵表上。
		
		是不是意味着新插入的数据直到 cut-over 之后才可以查询到？
		新插入的数据还会写入原始表吗?
		可以验证下.
		答: 验证了, 新插入的数据会写入到原始表, 因此不是在cut-over 之后才可以查询到数据.
		
		
其大致的工作过程

	1. gh-ost 首先连接到主库上，根据 alter 语句创建幽灵表，

	2. 然后作为一个备库(类似伪装的备库)连接到其中一个真正的备库或者主库上(根据具体的参数来定)，一边在主库上拷贝已有的数据到幽灵表，一边从备库上拉取增量数据的 binlog，然后不断的把 binlog 应用回主库。
	
	3. 等待全部数据同步完成，进行cut-over 幽灵表和原表切换。
		图中 cut-over 是最后一步，锁住主库的源表，等待 binlog 应用完毕，然后替换 gh-ost 表为源表。
		gh-ost 在执行中，会在原本的 binlog event 里面增加以下 hint 和心跳包，用来控制整个流程的进度，检测状态等。
		
	理解了.
	
思考: 
	1. gh-ost 的 binlog 保存在哪里
		感觉不需要独立保存
		
	2. 是否会有死锁
		gh-ost是否不会导致死锁.
	3. 增量数据的处理
		通过binlog应用回主库.	
	
部署 gt-ost	
	1. go环境配置
		
		[root@kp04 local]# pwd
		/usr/local
		[root@kp04 local]# ll
		total 2220752
		drwxr-xr-x. 10 root    root          272 Apr  9 03:15 go
		-rw-r--r--.  1 root    root    123658438 May  6 11:31 go1.14.2.linux-amd64.tar.gz

		生效：source /etc/profile
		
		
		[root@kp04 local]# go version
		go version go1.14.2 linux/amd64
		
		 

	2. gh-ost部署
		[root@kp04 ghost]# pwd
		/root/ghost
		[root@kp04 ghost]# ll
		total 14756
		-rwxr-xr-x. 1 root root 10128416 Feb  9 19:08 gh-ost
		-rw-r--r--. 1 root root  4978314 May  6 11:29 gh-ost-binary-linux-20200209110835.tar.gz

		[root@kp04 ghost]# ./gh-ost -version
		1.0.49


终止、暂停、限速：
	终止：
		标示文件终止运行：--panic-flag-file
		--panic-flag-file=/tmp/gh-ost.panic.t1.flag
		创建文件终止运行，例子中创建/tmp/gh-ost.panic.t1.flag文件, 终止正在运行的gh-ost, 临时文件清理需要手动进行。
		
	暂停和恢复：
		使用socket监听请求，操作者可以在命令运行后更改相应的参数。
			--serve-socket-file string：socket文件
			--serve-socket-file=/tmp/ghost.sock
			当执行操作的过程中发现负载、延迟上升了，不得不终止操作，重新配置参数，如 chunk-size，然后重新执行操作命令； 
			#暂停
			echo throttle | socat - /tmp/ghost.sock
			#恢复
			echo no-throttle | socat - /tmp/ghost.sock
		
动态调整性能参数：
	echo chunk-size=100 | socat - /tmp/ghost.sock
	echo max-lag-millis=200 | socat - /tmp/ghost.sock
	echo max-load=Thread_running=3 | socat - /tmp/ghost.sock	
	
	
连接到主库的大致的操作过程如下：
1.校验阶段
	权限验证
		show /* gh-ost */ grants for current_user()
	获取 binlog 相关信息:包括 是否开启binlog、row格式、位图格式
		select @@global.log_bin, @@global.binlog_format
		select @@global.binlog_row_image	
	检查有没有外键、检查有没有触发器 检查表的主键信息
	预估行数
		explain select /* gh-ost */ * from `sbtest`.`t1_2500` where 1=1
	检查连接到主库还是从库，是否开启log_slave_updates
	
2.初始化阶段
	模拟slave，创建 binlog streamer 连接, 监听binlog并获取当前的位点信息
	show /* gh-ost readCurrentBinlogCoordinates */ master status
	Connect	app_user@192.168.0.91 on  using TCP/IP
	Binlog Dump	Log: 'mysql-bin.000003'  Pos: 69535147	
	
3. 迁移阶段
	
	删除_xxx_ghc表(如果之前存在)，重建这个ghc表，用于记录gh-ost的操作changelog
		drop /* gh-ost */ table if exists `sbtest`.`_t1_2500_ghc`
		create /* gh-ost */ table `sbtest`.`_t1_2500_ghc` (
			
	创建_xxx_gho表(最终表)，对gho表进行ALTER操作，然后复制原表数据到gho表。
	（这ALTER期间，gh-ost模拟成slave，将操作期间的DML产生的binlog event获取到，并应用到gho表上）
		create /* gh-ost */ table `sbtest`.`_t1_2500_gho` like `sbtest`.`t1_2500`
		alter /* gh-ost */ table `sbtest`.`_t1_2500_gho` engine=innodb
	
	获取当前的最大主键和最小主键
		select /* gh-ost `sbtest`.`t1_2500` */ `id` from `sbtest`.`t1_2500` order by `id` asc limit 1
		select /* gh-ost `sbtest`.`t1_2500` */ `id` from `sbtest`.`t1_2500` order by `id` desc limit 1
		
	获取第一个 chunk
		select  /* gh-ost `sbtest`.`t1_2500` iteration:0 */ `id` from `sbtest`.`t1_2500`
		where ((`id` > _binary'1') or ((`id` = _binary'1'))) and ((`id` < _binary'2500') or ((`id` = _binary'2500')))
		order by `id` asc limit 1 offset 999
	
	开启事务，循环插入到目标表: 按照主键id把源表数据写入到gho结尾的表上，再提交，以及应用binlog
		START TRANSACTION
		insert /* gh-ost `sbtest`.`t1_2500` */ ignore into `sbtest`.`_t1_2500_gho` (`id`)
		  (select `id` from `sbtest`.`t1_2500` force index (`PRIMARY`) where (((`id` > _binary'1') or ((`id` = _binary'1'))) and ((`id` < _binary'1000') or ((`id` = _binary'1000')))) lock in share mode)		
		
		COMMIT
		
4. 增量应用binlog迁移数据

5. cut-over新旧表切换阶段
	copy完数据之后进行原始表和影子表(幽灵表)cut-over 切换
	
	创建 _t1_2500_del 表
		create /* gh-ost */ table `sbtest`.`_t1_2500_del` (
				id int auto_increment primary key
			) engine=InnoDB comment='ghost-cut-over-sentry'
			
	lock源表
		lock /* gh-ost */ tables `sbtest`.`t1_2500` write, `sbtest`.`_t1_2500_del` write
		
	rename表：rename源表 to 源_del表，_gho表 to 源表。
			rename /* gh-ost */ table `sbtest`.`t1_2500` to `sbtest`.`_t1_2500_del`, `sbtest`.`_t1_2500_gho` to `sbtest`.`t1_2500`
	解锁
		unlock tables
		
6. copy完数据之后进行原始表和影子表cut-over 切换


gh-ost的切换是原子性切换，基本是通过两个会话的操作来完成 

原理是基于MySQL 内部机制: 被lock table 阻塞之后，执行rename的优先级高于dml，也即先执行rename table ，然后执行dml 。假设gh-ost操作的会话是c10 和c20 ，其他业务的dml请求的会话是c1-c9,c11-c19,c21-c29。


具体切换流程如下：

	START

	会话A

	CREATE table tbl_old

	防止rename过早执行

	LOCK TABLES tbl WRITE, tbl_old WRITE

	通过lock_wait_timeout设置为2s控制超时,超时失败会重试次数为配置default-retries,默认60次

	新的请求进来，关于原表的请求被blocked    # 这里会锁住DML请求, 普通查询请求不会被锁住.

	RENAME TABLE tbl TO tbl_old, ghost TO tbl , 同样被blocked

	新的请求进来，关于原表的请求被blocked

	检查是否有blocked 的RENAME请求，通过show processlist

	会话A: DROP TABLE tbl_old          # 如果是大表, 这里会耗时很久吧?   理解错误了, 此时 tbl_old 还是空表.

	会话A: UNLOCK TABLES

	RENAME SUCCESS


	
连接到主库上
	shell > time /root/ghost/gh-ost --user="app_user" --password="123456abc" --host=192.168.0.91  --database="sbtest" --table="sbtest1" --alter="add column filed_04 int(10) not null default 0 comment 'filed_04'" --allow-on-master --execute

		
连接到从库上
	shell > time /root/ghost/gh-ost --user="app_user" --password="123456abc" --host=192.168.0.92  --database="sbtest1" --table="t1_1w" --alter="add column c2 int(10) not null default 0 comment 'c2'" --execute 
	shell > time /root/ghost/gh-ost --user="app_user" --password="123456abc" --host=192.168.0.92  --database="sbtest" --table="t1_1w" --alter="engine=InnoDB" --execute

	
	
