

1. 如何跳过一个事务
2. mysqldump导出行为的改变
3. 5.7中搭建基于Gtid的主从
4. 5.7中Gtid的主从的切换
5. gtid_mode 参数的含义
6. 5.7中在线改变Gtid模式
7. 5.7 offline开启GTID 
8. 开启GTID的注意事项 
9. ongoing_anonymous_transaction_count 统计值的变更时机
	9.1 主库增加和减少
	9.1 从库增加和减少
	9.3 这个值取值可能
	
	
1. 如何跳过一个事务

	和传统基于位置的主从不同，如果从库报错我们需要获得从库执行的最后一个事务，方法有如下：

		show slave status \G 中的 Executed_Gtid_Set。
		show global variables like '%gtid%'; 中的 gtid_executed 。
		show master status;中的 Executed_Gtid_Set。
		
		然后构建一个空事务如下：

			stop slave ;
			set gtid_next='4a6f2a67-5d87-11e6-a6bd-000c29a879a3:34';
			begin;commit;
			set gtid_next='automatic';
			start slave ;
			
		如果是多个如下：

			stop slave ;
			set gtid_next='89dfa8a4-cb13-11e6-b504-000c29a879a3:3';
			begin;commit;
			set gtid_next='89dfa8a4-cb13-11e6-b504-000c29a879a3:4';
			begin;commit;
			set gtid_next='automatic';
			start slave ;

	实践参考：
		笔记 《27: 基于位点和GTID的主从切换-GTID的介绍》中的 2.4 GTID模式下的主键冲突和解决办法
		笔记 《GTID模式1062和1032的维护.sql》

		
2. mysqldump导出行为的改变

	使用mysqldump导出数据的时候受到选项set-gtid-purged=AUTO的影响和非GTID下导出略有不同
	在 GTID 开启情况下使用如下语句导出数据：
		mysqldump  -uroot -p123456abc --single-transaction  --master-data=2  -R -E --triggers  --all-databases > 2020-03-14.sql
	
	在 GTID  开启的情况下会多如下设置：
	
		SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
		SET @@SESSION.SQL_LOG_BIN= 0;

		--
		-- GTID state at the beginning of the backup 
		--

		SET @@GLOBAL.GTID_PURGED='7664fad8-49fd-11e8-a546-4201c0a8010a:1-766741,
		90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-20227';

	这样设置的原因：
	
		如果我们使用这个备份做主从，是否生成 binary log evnet 就意味着在导入数据的时候是否基于本地数据库生成新的GTID
			如果生成了本地GTID 显示是不对的，所以将 SQL_LOG_BIN= 0 设置为0是必须的。
			--理解了，参考实验笔记：
				--《2020-10-14-GTID模式下set-gtid-purged的行为.sql》
				--《2020-10-15-在线搭建主从复制同时观察执行GTID_PURGED会修改的信息和备份文件中记录SQL_LOG_BIN为0是否生成本地数据库的GTID.sql》
			
		接着GTID_PURGED被设置为备份时刻已经执行过的Gtid事务，设置GTID_PURGED会设置三个地方的Gtid如下:   
			mysql.gtid_executed表
			gtid_purge变量
			gtid_executed变量
			
			# 参考 《02-GTID相关信息的变更时机.sql》  中的 2.3 通用更改时机

		当然也可以使用 '--set-gtid-purged=OFF' 选项来告诉 mysqldump 不需要设置 SQL_LOG_BIN= 0 和 GTID_PURGED 变量，但是初始化搭建主从的时候一定不要设置为 OFF。
	
		
	
3. 5.7中搭建基于Gtid的主从
	
	1. 注意主备库必须开启Gtid和设置好server_id
		enforce_gtid_consistency = ON
		gtid_mode = ON
		server_id = 9910  --主库跟从库的 server_id 值不能一样。
		binlog_format = row	
		
		同时主备库都开启binlog如果不设置级联从库，从库不要设置log_slave_updates参数。这是最合理的设置。
	
	2. 建立复制用户
		CREATE USER 'repl'@'%' IDENTIFIED BY  'test123';
		GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%' ;
	
	3. 主库导出数据
	
		mysqldump  --single-transaction  --master-data=2  -R -E --triggers  --all-databases > test.sql
	
	4. 从库导入数据
	
	5. 从库执行reset master语句
		
		用于清空gtid信息
		这一步主要防止gtid_executed被更改过。
		这个问题在在percona 5.7.14 5.7.17存在但是在percona 5.7.15 5.7.19又不存在。所以为了安全还是执行下面的两步。

			reset master；

		提取GTID_PURGED，并且执行
		使用head -n 40 命令可以快速的得到比如我这里的：
		
			
			--
			-- GTID state at the beginning of the backup 
			--

			SET @@GLOBAL.GTID_PURGED='ec9bdd78-a593-11e7-9315-5254008138e4:1-21';

		执行

			SET @@GLOBAL.GTID_PURGED='ec9bdd78-a593-11e7-9315-5254008138e4:1-21';
			
			完成本部分mysql.gtid_executed表会重构。
	
	6. 使用MASTER_AUTO_POSITION建立同步
			change master to 
			master_host='192.168.99.41',
			master_user='repl',
			master_password='test123',
			master_port=3310,
			MASTER_AUTO_POSITION = 1;
			
	7. 启动slave
		start slave;
		show slave status\G;
		
		
	参考笔记：
		《在线搭建主从复制同时观察执行GTID_PURGED会修改的信息和备份文件中记录SQL_LOG_BIN为0是否生成本地数据库的GTID-2020-03-14.sql》
		《基于GTID在线建从库.sql》
		
		
4. 5.7中Gtid的主从的切换
	
	注意事项：
		1. 切换必须保证主从没有延迟，可以通过对照主备库的 gtid_executed变量 进行确认
		2. 切换必须要确认从库（新主库）没有做过本地 GTID 操作， 如果从库（新主库）做过本地 GTID 操作， 那么切换后新从库（原主库）需要摘取这一部分的 GTID event, 如果
			部分 event 已经不存在了， 那么会报错。
			
	正常的切换步骤：
		从库(新主库)：
			stop slave;
			reset slave all;  
	
		主库(新从库)：
			change master to 
			master_host='192.168.99.40',
			master_user='repl',
			master_password='test123',
			master_port=3310,
			MASTER_AUTO_POSITION = 1;
			start slave;			
	
		
	实际就这么简单，从库(新主库)会生成自己的Gtid事务，新主库接受到后执行即可。此时会出现如下有两个 server_uuid 对应的Gtid，如下的gtid_executed

		mysql> show global variables like '%gtid%';
		+----------------------------------+-------------------------------------------------------------------------------------+
		| Variable_name                    | Value                                                                               |
		+----------------------------------+-------------------------------------------------------------------------------------+
		| binlog_gtid_simple_recovery      | ON                                                                                  |
		| enforce_gtid_consistency         | ON                                                                                  |
		| gtid_executed                    | 31704d8a-da74-11e7-b6bf-525400a7d243:1-9,
		ec9bdd78-a593-11e7-9315-5254008138e4:1-25 |
		| gtid_executed_compression_period | 1000                                                                                |
		| gtid_mode                        | ON                                                                                  |
		| gtid_owned                       |                                                                                     |
		| gtid_purged                      | ec9bdd78-a593-11e7-9315-5254008138e4:1-25                                           |
		| session_track_gtids              | OFF                                                                                 |
		+----------------------------------+-------------------------------------------------------------------------------------+

	总的说来如果要作为的切换的从库，不要在从库本地做任何事务。如果确实要做比如加索引等不影响数据的操作可以是使用如下：
		
		mysql> set sql_log_bin=0;
		Query OK, 0 rows affected (0.00 sec)

		mysql> create index test_jjj on jjj(id);
		Query OK, 0 rows affected (0.42 sec)
		Records: 0  Duplicates: 0  Warnings: 0	
		
	这样也是不会增加本地Gtid的。

5. gtid_mode 参数的含义

	OFF(0): Both new and replicated transactions must be anonymous.
			表示生成的是匿名事务, 从库也只能应用匿名事务
			
	OFF_PERMISSIVE(1): New transactions are anonymous. Replicated transactions can be either anonymous or GTID transactions.
			表示生成的是匿名事务, 从库可以应用匿名和GTID事务从库可以应用匿名和GTID事务
			
	ON_PERMISSIVE(2): New transactions are GTID transactions. Replicated transactions can be either anonymous or GTID transactions.
			生成的是GTID事务, 从库可以应用匿名和GTID事务
			
	ON(3): Both new and replicated transactions must be GTID transactions.		
			生成的是GTID事务, 从库也只能应用GTID事务
			
	有了这些设置我们就可以在线平滑的开启GTID,  每次修改值必须导致一次 binary log 的切换.
	
	
6. 5.7中在线改变Gtid模式
	参考笔记 <基于位点的主从复制在线升级为GTID复制.sql>
	# 已经有在生产环境上基于位点的复制在线升级为GTID的复制经验.
	
7. 5.7 offline开启GTID 
	离线开启GTID非常简单, 步骤如下:
		保证主从没有延迟, 这一点及其重要, 如果有延迟可能导致从库数据丢失.
		主库和从修改参数文件加入下列参数:
			--skip-slave-start
			server-id=3306100
			binlog_format=row
			gtid-mode=on
			enforce-gtid-consistency=1
		从库执行操作:
			change master to master_auto_position=1;
			start slave;
			show slave status\G;
			
8. 开启GTID的注意事项 
	开启 GTID 一定要注意不能有数据丢失, 判定方法如下:
		online 开启一定要注意主库和从库 ongoing_anonymous_transaction_count 参数值不能为非 0, 否则意味着从库数据的丢失.
		
		offline开启一定要注意, 主从不能有延迟, 如果有延迟意味着从库数据的丢失.
		
9. ongoing_anonymous_transaction_count 统计值的变更时机
	9.1 主库增加和减少
		主库增加:
			这个值在主库事务进行提交的时候会在 order commit 的 flush 阶段分配 GTID 的时候, 如果是匿名事务则会增加
			
		主库减少:
			这个值在主库事务进行提交的时候会在 order commit 的 commit 阶段 InnoDB 层提交完成后减少
			
	9.1 从库增加和减少
		从库增加:
			这个由SQL线程或者 MTS 工作线程应用 GTID event 的时候如果发现是匿名事务的 GTID event 则会增加
		
		从库减少:
			这个由SQL线程或者 MTS 工作线程应用 XID event 进行 InnoDB 层提交完成过后减少.
			
			
	我们可以看到这个值实际上是没有提交完成的匿名事务的数量
	这个值在主库和从库更改的时机是不一样的:
		主库在 commit 阶段才进行更改, 不包含语句的执行时间
		从库则包含语句的执行时间, 因此从库更容易观察到这个统计值
		
	9.3 这个值取值可能
		
	类型				取值可能				
	主库				由于存在多个用户线程提交的情况, 这个值可能大于1
	
	单SQL线程			由于只有一个SQL应用线程, 因此这个值最大为1, 并且可能在 0 和 1之间波动
	
	MTS					由于存在多个工作线程, 因此这个值可能大于1
	
	
	
10. 小结

	GTID带来最方便的作用就是搭建和维护一主多从复制，主从切换会非常便捷。

	开启 GTID 的参数:
		MySQL实例开启GTID模式：
		gtid-mode = on ： 开启 GTID 
		
		enforce-gtid-consistency=1： 执行GTID一致性（使用GTID模式复制时，需要开启此参数，用来保证GTID一致性）。
		
		
		
			
		



























			