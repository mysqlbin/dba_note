
1. 优点和缺点和优化点
2. 关于一致性备份
3. 注意事项
4. 思考
5. 逻辑备份的3个关键字

1. 优点和缺点和优化点
    优点
        1. 支持远程备份;
        2. 热备份, 几乎不阻塞写
        3. 数据恢复后可以清除表碎片
        4. 支持压缩备份，并且压缩比较高，节省备份的磁盘空间
        
    缺点:
        备份非事务引擎表, 数据可能会不一致;

    优化点:
	
        恢复备份的数据属于批量加载数据, 一般瓶颈点在 IO;
        那么我们可以通过MySQL对IO的优化加快数据的恢复速度, 
            1. sync_binlog
                设置为 1W 或者 更高
            2. innodb_flush_log_at_trx_commit
                设置为2
            3. 减少binlog的刷盘次数, 基于组提交, 可以大幅度降低磁盘IOPS的消耗
                binlog_group_commit_sync_delay=60000000
                    (6千W微秒=1分钟)
                    延迟多少微秒后把binlog fsync持久化到磁盘
               binlog_group_commit_sync_no_delay_count=10W
                    累积多少次之后才一起把 binlog fsync持久化到磁盘
            4. 也可以关闭 binlog 再导入。
			5. MySQL 8.0.21 版本，可以关闭redo, 这样可以加快数据的恢复速度。
			

2. 关于一致性备份
    1. InnoDB 表：
		mysqldump --single-transaction：
              当 mysqldump 使用参数–single-transaction 的时候，导数据之前就会启动一个事务，来确保拿到一致性视图。而由于 MVCC 的支持，这个过程中数据是可以正常更新的。
    2. MyISAM 表：
		在创建一致性视图之后，备份MyISAM表之前对MyISAM进行写操作，会造成备份不一致；
		备份数据不一致的原因：
			在于备份到的数据是写操作执行成功之后的， 并且写操作会记录binlog, 而此时记录的binlog position是大于备份期间获取到的binlog position；
			如果通过备份的数据做从库，那么从库会应用写操作执行成功后记录的 binlog；
    
        如何解决MyISAM表备份数据不一致？
			只能通过锁表来保证数据一致性， 分三种情况： 
				导出全库、导出单个库、导出单个表， 都需要加 --lock-all-tables
				导出全库：    
					mysqldump -h192.168.0.54 -uroot -p123456abc --master-data=2 > archer_0705.sql    
				导出单个库：  
					mysqldump -h192.168.0.54 -uroot -p123456abc --master-data=2 -B archery > archer_0705.sql   
				导出单个表：
					mysqldump -h192.168.0.54 -uroot -p123456abc --master-data=2 -B archery > archer_0705.sql   
					
			最好的解决办法就是改为 InnoDB 表。
			

3. 注意事项
   1. InnoDB表和MyISAM表分开备份，但是获取不到共同的复制位点信息。
   
   2. 备份期间不要执行DDL语句；
        确认的说， 是在备份期间， 该表在备份的时候执行到 rollback to savepoint sp 之前，不要执行DDL语句。
		 
   3. lock-all-tables 和 lock-tables 
        lock-all-tables： 
            备份期间整个实例全程锁表， 不可以写，只可以读；
        lock-tables：
            备份期间只对执行select语句导出表数据的时候加MDL读锁；
          
        不指定 --single-transaction选项， 只指定 --master-data 选项自动关闭 --lock-tables选项， 同时还会打开--lock-all-tables， 备份过程中整个实例全程锁表。
        指定 --single-transaction、--master-data选项，  会自动开启 --lock-tables 参数。
		  
   4. 备份之前，确认有没有未提交的事务，因为备份需要执行 flush table with read lock; 命令，关闭实例下所有的表；
   
       同一个表不能在同一个时间段做打开表和关闭表操作。 
		
		session A						  session B                               
		mysql>select sleep(1) from t1;
										   mysql>flush tables with read lock;
											(Blocked)
											
		session C
		mysql>show processlist;
		+----+------+--------------------+------+------------------+-------+---------------------------------------------------------------+-----------------------------+
		| Id | User | Host               | db   | Command          | Time  | State                                                         | Info                        |
		+----+------+--------------------+------+------------------+-------+---------------------------------------------------------------+-----------------------------+
		| 52 | repl | 192.168.1.29:45726 | NULL | Binlog Dump GTID | 47978 | Master has sent all binlog to slave; waiting for more updates | NULL                        |
		| 63 | root | localhost          | zst  | Query            |     6 | User sleep                                                    | select sleep(1) from t1     |
		| 64 | root | localhost          | NULL | Query            |     3 | Waiting for table flush                                       | flush tables with read lock |
		| 65 | root | localhost          | NULL | Query            |     0 | starting                                                      | show processlist            |
		+----+------+--------------------+------+------------------+-------+---------------------------------------------------------------+-----------------------------+
		4 rows in set (0.00 sec)

4. 思考
	1. RR隔离级别下， 通过start transaction with consistent snashot；开始一个事务，也是就是作为事务的起点，期间有数据写操作， 执行 show master status能否得到一致性的 复制点信息？
		可以做实验解惑。
		答： 已经实验， 验证了 执行 "SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;START TRANSACTION /*!40100 WITH CONSISTENT SNAPSHOT */;" 之后, 如果期间有事务做写操作, 是获取不到一致性的binlog position位点信息。
        具体的实验可以查看附件： “RR隔离级别-开启事务获取不到一致复制位点的实验.sql”

	2. innobackupex 在备份 MyISAM表时候， 会不会产生备份数据不一致的情况？
	
	3. 备份的最小用户权限
	4. innobackupex 是否支持远程备份		
	5. mysqldump 做如何到了一致性备份、热备份
		FTWRL 
		把事务隔离级别改为RR
		开启事务并且创建一致性快照
		
	6. 先备份非innodb表数据(*.frm,*.myi,*.myd等) 再 非innodb表备份完毕后，释放FTWRL锁？
		理解Mysqldump工作原理，一定要将事务表(innodb)和非事务表(比如myisam)区别对待，因为备份的流程与此息息相关
		别人的文章或者说别人说的不一定是对的，反正就是实验出真知
		
		
	7. 执行 FLUSH TABLES WITH READ LOCK 后是否一定需要  SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ、START TRANSACTION /*!40100 WITH CONSISTENT SNAPSHOT */;
		答: 需要;
			FLUSH TABLES WITH READ LOCK 是指锁住整个备份的实例, 让实例不可以写, 可读;
			因为 mysqldump 是逻辑备份, 先查询出来再写入SQL文件; 
		如果不需要 修改隔离级别为RR, 并且创建一致性视图, 那么这个全局读锁会一直锁到 整个备份完成, 导致期间整个实例都不可以写.
	

	8. 跟问题7相反过来呢? 
		执行 SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ、START TRANSACTION /*!40100 WITH CONSISTENT SNAPSHOT */; 在这之前
		是否需要 先执行 FLUSH TABLES WITH READ LOCK;
		
		答： 需要。
			参考笔记《RR隔离级别-创建一致性快照获取不到一致性复制位点的实验.sql》 和  《RR隔离级别-开启事务获取不到一致复制位点的实验.sql》
			
	
	9. /*!40100 WITH CONSISTENT SNAPSHOT */ 表示的是什么:
	
		答: /*!40100 ...*/ 这部分注释会被MySQL执行，表示服务端版本号大于4.1.00时会被执行
	
	10. 从库备份，但是从库没有 binlog ，咋办？

	11. mysqldump  result-file 之后查看 result-file 的内容
 
	12. 如何备份存储过程
		
				
 5. 逻辑备份的3个关键字
 	加锁、一致性备份、保存点
 
 