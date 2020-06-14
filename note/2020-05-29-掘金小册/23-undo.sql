



mysql> SELECT * FROM information_schema.innodb_sys_tables WHERE name = 'xiaohaizi/undo_demo';


INSERT操作对应的undo日志
	undo 类型为 TRX_UNDO_INSERT_REC
	undo中会记录主键值
	
指向记录对应的 undo日志 的一个指针，保存回滚段地址信息（spaceid，pageno，offset），用于回溯上一个版本	
	
https://www.cnblogs.com/exceptioneye/p/5451960.html  MySQL事务提交过程（一）
  
	从上述流程可以看出，提交过程中，主要做了4件事情，

	1、清理undo段信息，对于innodb存储引擎的更新操作来说，undo段需要purge，这里的purge主要职能是，真正删除物理记录。
		在执行delete或update操作时，实际旧记录没有真正删除，只是在记录上打了一个标记，而是在事务提交后，purge线程真正删除，释放物理页空间。因此，提交过程中会将undo信息加入purge列表，供purge线程处理。
		
INSERT操作对应的undo日志
	对于insert和delete，undo中会记录键值，delete操作只是标记删除(delete mark)记录。
	insert的undo日志类型为 TRX_UNDO_INSERT_REC
	
	如果需要回滚:
		取老版本记录，做逆向操作即可, 具体表现为
			直接删除聚集索引和二级索引记录（row_undo_ins）。
		具体的操作中，先回滚二级索引记录（row_undo_mod_del_mark_sec、row_undo_mod_upd_exist_sec、row_undo_mod_upd_del_sec），再回滚聚集索引记录（row_undo_mod_clust）。

delete 操作对应的undo日志
	对于insert和delete，undo中会记录键值，delete操作只是标记删除(delete mark)记录。
	
	样例
		CREATE TABLE `mytest_undo_demo` (
		  `id` int(11) NOT NULL,
		  `name` varchar(100) DEFAULT NULL,
		  `age` int(100) DEFAULT NULL,
		  PRIMARY KEY (`id`),
		  KEY `idx_name` (`name`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

		INSERT INTO `mytest_undo_demo` (`id`, `name`, `age`) VALUES ('1', 'lujianbin', '28');
		INSERT INTO `mytest_undo_demo` (`id`, `name`, `age`) VALUES ('2', 'zhangsan', '25');
		INSERT INTO `mytest_undo_demo` (`id`, `name`, `age`) VALUES ('3', 'lisi', '23');

		数据

		1, lujianbin

		2, zhangsan

		3, lisi	
		
		
		最新数据                                   		           回滚段(此时没有事务未提交，故回滚段是空的。)
		
		1, lujianbin

		2, zhangsan

		3, lisi	
		

		接着启动了一个事务,并且事务处于未提交的状态：	           回滚段			            
																	
			start transaction;
			delete from mytest_undo_demo where id=1;               (1)      # 对于delete，undo中会记录主键值, 所以这里记录的是1
			(delete-mark)
			rollback;
			
		回滚的步骤:
			析取老版本记录，做逆向操作即可: 清理delete-mark删除标识.

	
思考：
	1. 疑问：undo 只保存主键值，怎么供别的事务读取
		InnoDB多版本数据是通过delete mark的行数据和回滚段中的undo信息组成的。
		带着问题学习
		
		
		

学习资料： 
	MySQL 实战45讲
	https://mp.weixin.qq.com/s/UxawgHGembMKK2lA33ZQDA    InnoDB MVCC 详解
	MySQL 是怎样运行的：从根儿上理解 MySQL
	https://mp.weixin.qq.com/s/R3yuitWpHHGWxsUcE0qIRQ  InnoDB并发如此高，原因竟然在这？
    https://mp.weixin.qq.com/s/tNA_-_MoYt1fJT0icyKbMg       MVCC原理探究及MySQL源码实现分析   # 董红禹
	https://mp.weixin.qq.com/s/T6qeXpVoo-M9Iflsh-n1zA  一次大量删除导致 MySQL 慢查的分析  # 要承认别人比自己强
	这次一定要搞懂 MVCC 和 undo 日志（回滚段）
	看懂这些内容，就可以理解MVCC了。
	
	
	