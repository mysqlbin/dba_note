
1. 支持 不可见索引
2. 支持 倒序索引

3. 自增主键的持久化
	将自增值的变更记录在了 redo log 中，重启的时候依靠 redo log 恢复重启之前的值。	
	
4. InnoDB锁新增NOWAIT、SKIP LOCKED选项
	在没有线程池加持的情况下，SKIP LOCKED对于秒杀场景能比较大的帮助（赞）；
	
5. DDL 原子性保证
	DDL操作复制原子性保证，再也不用担心DDL复制中断问题；
	InnoDB表的DDL支持事务完整性，要么成功要么回滚，将DDL操作回滚日志写入到data dictionary 数据字典表 mysql.innodb_ddl_log 中用于回滚操作，该表是隐藏的表，通过show tables无法看到。通过设置参数，可将ddl操作日志打印输出到mysql错误日志中。
	mysql> set global log_error_verbosity=3;
	mysql> set global innodb_print_ddl_logs=1;
	mysql> create table t1(c int) engine=innodb;
	
	来看另外一个例子，库里只有一个t1表，drop table t1,t2;
	试图删除t1,t2两张表,在5.7中，执行报错，但是t1表被删除，在8.0中执行报错，但是t1表没有被删除，证明了8.0 DDL操作的原子性，要么全部成功，要么回滚。
		
		
6. 多源复制下支持对每个channle进行过滤，非常实用的一个功能；

7. 新增参数 binlog_expire_logs_seconds ，二进制日志过期时间可以根据秒粒度进行设置；

8. 灵活的Undo表空间管理 :
	1. 8.0版本让用户可以全权管理Undo表空间，比如表空间的数量，存放位置，每个undo表空间有多少回滚段。 
	2. Undo日志不在存放于系统表空间中：
		在版本升级的过程中，Undo日志被从系统表空间中分离出来，并放到Undo表空间中。这为现存的非独立Undo表空间的升级留了后路。
	3. Undo表空间可以单独管理：比如放到更快的磁盘存储上。
	4. 在线Undo表空间回收：
		为了Undo表空间清理的需要，生成了两个小的Undo表空间，这样可以让InnoDB在一个活跃一个清理的情况下在线收缩Undo表空间。
		默认开启 innodb_undo_log_truncate 参数。
	5. 增多回滚段，减少争用：
		现在用户可以选择使用最多127个Undo表空间，每个undo表空间都有最多可达128个回滚段。
		更多的回滚段可以让并行的事务更可能地为其undo日志使用独立的回滚段，这样可以减少对同个资源的争用。
		
	mysql> SET GLOBAL INNODB_UNDO_TABLESPACES=100;
	Query OK, 0 rows affected (0.00 sec)
	mysql> show global variables like '%undo%';
	+--------------------------+------------+
	| Variable_name            | Value      |
	+--------------------------+------------+
	| innodb_max_undo_log_size | 4294967296 |
	| innodb_undo_directory    | undolog    |
	| innodb_undo_log_encrypt  | OFF        |
	| innodb_undo_log_truncate | ON         |
	| innodb_undo_tablespaces  | 2          |
	+--------------------------+------------+
	5 rows in set (0.01 sec)
	# 没生效, 因为不是这样用的。
				
9. 8.0.1版本集成了Group Replication插件，GR成为默认插件已毫无悬念；
10. 新版本GR支持SAVE POINT功能，事务内可部分回滚；
11. 支持CTE（Common Table Expression），很不错的一个功能，但是大伙更期待Hash Join什么时候能来呢？
12. 支持用户角色管理
13. 支持设置 持久的全局变量
	MySQL8.0可以使用 SET PERSIST 动态修改参数并保存在配置文件中（mysqld-auto.cnf，保存的格式为JSON串），这个是DBA同学的福音，不必担心设置之后忘记保存在配置文件中，重启之后会被还原的问题了。

14. 直方图
15. Redo优化

	Redo的写入一直是 InnoDB 高并发情况下的瓶颈，8.0 开始:

		用户线程可以并发的copy redo 日志到 log buffer中
		用户线程可以以更松散的方式把 dirty block 加入到脏块链表中
		独立的写线程完成 redo 的持久化	


相关参考:
	https://yq.aliyun.com/articles/684418?spm=a2c4e.11153940.0.0.7ff16c58KJKpkU   深入解读MySQL8.0 新特性 ：Crash Safe DDL
	https://mp.weixin.qq.com/s/MnMnfriH7qSKXEghtYc_BA        MySQL 8.0新特性之原子DDL 

	https://blog.csdn.net/ActionTech/article/details/95969033  新特性解读 | MySQL 8.0 Temptable 引擎介绍
	https://segmentfault.com/a/1190000019338866  MySQL 8.0 技术详解

	
