
参考:
	https://mp.weixin.qq.com/s/f6QbdkMiYbskvcG6rhcSuA
	https://dev.mysql.com/doc/refman/8.0/en/clone-plugin.html
	https://www.sqlpy.com/blogs/books/1/chapters/12/articles/64
	https://blog.csdn.net/actiontech/article/details/98054877  
	http://mysql.taobao.org/monthly/2019/09/02/
	http://mysql.taobao.org/monthly/2019/08/05/
	
	https://www.jianshu.com/p/09bb26c52835 mysql8 clone plugin调研

	
8.0.17是即5.7版本之后，真正可以走上生产的版本

8.0.17 的新特性: Clone Plugin
	是个免费版物理备份工具;
	Clone Plugin可以将备份文件保存在本地，亦可直接将数据（目前仅支持InnoDB）复制到远程实例，其中复制源实例称为 Donor ，接受实例称为 Recipient
	
	
	虽然是Clone Plugin的第一个版本，还是考虑得非常完整，提供了一系列参数用以控制备份的并发度、压缩、安全、网络限速等各方面。
	同时performance_schema库下的表clone_status可以查看当前Clone的进度（sys库应该快速跟进这个查询视图）：
	
		SELECT STAGE, STATE, CAST(BEGIN_TIME AS TIME) as "START TIME",    CASE WHEN END_TIME IS NULL THEN    LPAD(sys.format_time(POWER(10,12) * (UNIX_TIMESTAMP(now()) - UNIX_TIMESTAMP(BEGIN_TIME))), 10, ' ')    ELSE    LPAD(sys.format_time(POWER(10,12) * (UNIX_TIMESTAMP(END_TIME) - UNIX_TIMESTAMP(BEGIN_TIME))), 10, ' ')    END as DURATION,    LPAD(CONCAT(FORMAT(ROUND(ESTIMATE/1024/1024,0), 0), " MB"), 16, ' ') as "Estimate",    CASE WHEN BEGIN_TIME IS NULL THEN LPAD('0%', 7, ' ')    WHEN ESTIMATE > 0 THEN    LPAD(CONCAT(CAST(ROUND(DATA*100/ESTIMATE, 0) AS BINARY), "%"), 7, ' ')    WHEN END_TIME IS NULL THEN LPAD('0%', 7, ' ')    ELSE LPAD('100%', 7, ' ') END as "Done(%)"FROM performance_schema.clone_progress;
	
		+-----------+-------------+------------+------------+-----------+---------+| STAGE     | STATE       | START TIME | DURATION   | Estimate  | Done(%) |+-----------+-------------+------------+------------+-----------+---------+| DROP DATA | Completed   |   11:50:01 |  500.88 ms |      0 MB |    100% || FILE COPY | In Progress |   11:50:02 |    1.92 m  | 54,729 MB |     63% || PAGE COPY | Not Started |       NULL |       NULL |      0 MB |      0% || REDO COPY | Not Started |       NULL |       NULL |      0 MB |      0% || FILE SYNC | Not Started |       NULL |       NULL |      0 MB |      0% || RESTART   | Not Started |       NULL |       NULL |      0 MB |      0% || RECOVERY  | Not Started |       NULL |       NULL |      0 MB |      0% |+-----------+-------------+------------+------------+-----------+---------+
		
		
	Clone Plugin的实现基于InnoDB物理文件的备份，机制大致与Xtrabackup相同。
	物理备份过程中存在一种可能性：
		即当备份大容量实例过程中，由于业务不断发生变化，重做日志还未备份就被覆盖了，从而导致备份文件无法恢复的情况。	
		
	MySQL 8.0.17版本“再次”恢复了InnoDB重做日志文件归档的功能，最早的MySQL 3.23版本，InnoDB重做日志文件归档功能就是默认开启的。
	但8.0.17版本设计更好地是，可以手动控制是否开启重做日志文件归档的功能，比如在Clone过程中开启归档即可。
	
	SELECT innodb_redo_log_archive_start('label', 'subdir');
	SELECT innodb_redo_log_archive_stop();
	
	
其他注意事项
	1. 克隆操作期间不允许DDL（包括TRUNCATE TABLE）。
	2. 一次只能克隆一个MySQL实例。不支持在单个克隆操作中克隆多个MySQL实例。
	3. 远程克隆操作（在CLONE INSTANCE语句中指定Donor的MySQL服务器实例的端口号时）不支持mysqlx_port指定的X协议端口。
	4. clone插件不支持MySQL配置参数的克隆。
	5. clone插件不支持二进制日志的克隆。
	6. 克隆插件仅克隆存储在InnoDB中的数据。其他存储引擎数据未克隆。存储在任何数据库（包括sys模式）中的MyISAM和CSV表都被克隆为空表。
		
		
思考: clone-plugin 物理备份是否会加锁?
	加的是 backup lock。
	
