


ibtmp1 临时表空间


MySQL 5.7起，开始采用独立的临时表空间（和独立的undo表空间不是一回事哟），命名 ibtmp1 文件，初始化12M，且默认无上限。
	为所有非压缩的 innodb 临时表提供一个独立的表空间， 默认的临时表空间文件为 ibtmp1, 位置数据目录 。
		   
	选项 innodb_temp_data_file_path 可配置临时表空间相关参数, 默认是存储在数据目录下。
	
	存储临时表文件的地方。 -- 
	
	innodb_temp_data_file_path = ibtmp1:12M:autoextend 表示 
		指定innodb临时表空间文件的路径、文件名和大小，存放临时表和undo日志的表空间; 
		在支持大文件的系统这个文件大小是可以无限增长的
	
使用建议:

	1. 设置 innodb_temp_data_file_path 选项，设定文件最大上限，超过上限时，需要生成临时表的SQL无法被执行（一般这种SQL效率也比较低，可借此机会进行优化）。
	
		如 innodb_temp_data_file_path = ibtmp1:64M:autoextend:max:5G
	
    2. 检查 INFORMATION_SCHEMA.INNODB_TEMP_TABLE_INFO，找到最大的临时表对应的线程，kill之即可释放，但 ibtmp1 文件则不能释放（除非重启）。
		
		select * from INFORMATION_SCHEMA.INNODB_TEMP_TABLE_INFO;
	
    3. 择机重启实例，释放 ibtmp1 文件，和 ibdata1 不同，ibtmp1 重启时会被重新初始化而 ibdata1 则不可以。
		-- 因为重启实例，已经创建的临时表都会被删除。
		-- 删除临时表，是否会释放 ibtmp1 空间？
		
    4. 定期检查运行时长超过N秒（比如N=300）的SQL，考虑干掉，避免垃圾SQL长时间运行影响业务。


相关参考:
	https://mp.weixin.qq.com/s/AVNWOBZiwc46FE6clCLzxQ  MySQL 5.7临时表空间怎么玩才能不掉坑里
	https://mp.weixin.qq.com/s/r1-PuEGDdlLA6zE5pzjb2w  [MySQL FAQ]系列 — 什么情况下会用到临时表
	
	
案例：
	https://blog.51cto.com/chenql/1946992               mysql5.7 ibtmp1文件过大
	https://blog.51cto.com/11784929/2165352?source=dra  ibtmp1文件过大
	http://www.bubuko.com/infodetail-1893042.html       5.7 ibtmp1问题诊断
	注意：为了避免以后再出现类似的情况，一定要在限制临时表空间的最大值，如innodb_temp_data_file_path = ibtmp1:64M:autoextend:max:5G
	
	
------------------------------------------------------------------------------------------------------------------------------------------------

msyql> show global variables like '%innodb_temp_data_file_path%';
+----------------------------+-----------------------+
| Variable_name              | Value                 |
+----------------------------+-----------------------+
| innodb_temp_data_file_path | ibtmp1:12M:autoextend |
+----------------------------+-----------------------+
1 row in set (0.01 sec)


[root@soft data]# ls -lht ibtmp1 
-rw-r----- 1 mysql mysql 76M Apr  9 15:45 ibtmp1



5.6版本不存在该参数
	mysql> select version();
	+------------+
	| version()  |
	+------------+
	| 5.6.36-log |
	+------------+
	1 row in set (0.00 sec)

	mysql> show global variables like '%innodb_temp_data_file_path%';
	Empty set (0.00 sec)


------------------------------------------------------------------------------------------------------------------------------------------------


[root@localhost data]# ls -lht ibtmp1 
-rw-r----- 1 mysql mysql 12M 4月   9 17:31 ibtmp1


use yldbs;
DROP TEMPORARY TABLE IF EXISTS temp_20210409;
CREATE TEMPORARY TABLE temp_20210409(  
        Id INT UNSIGNED  NOT NULL  AUTO_INCREMENT PRIMARY KEY,
        nClubId INT DEFAULT 0,
        nPlayerId INT DEFAULT 0
);

mysql> show create table temp_20210409\G;
*************************** 1. row ***************************
       Table: temp_20210409
Create Table: CREATE TEMPORARY TABLE `temp_20210409` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nClubId` int(11) DEFAULT '0',
  `nPlayerId` int(11) DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
1 row in set (0.00 sec)

查看临时表元数据信息
	
	root@mysqldb 17:32:  [yldbs]> select * from 
		->  INFORMATION_SCHEMA.INNODB_TEMP_TABLE_INFO\G
	*************************** 1. row ***************************
				TABLE_ID: 98560
					NAME: #sql180c_4_0
				  N_COLS: 6
				   SPACE: 27376
	PER_TABLE_TABLESPACE: FALSE
		   IS_COMPRESSED: FALSE
	1 row in set (0.02 sec)



[root@localhost yldbs]# pwd
/home/mysql/mysql3306/data/yldbs
[root@localhost yldbs]# ll
总用量 10632
-rw-r----- 1 mysql mysql       67 10月 28 18:31 db.opt
-rw-r----- 1 mysql mysql     8888 3月  23 09:47 rechargestatistics.frm
-rw-r----- 1 mysql mysql    98304 3月  23 09:47 rechargestatistics.ibd
-rw-r----- 1 mysql mysql     8632 3月  30 17:36 t1.frm
-rw-r----- 1 mysql mysql   114688 3月  30 17:34 t1.ibd
-rw-r----- 1 mysql mysql    14215 3月  18 11:11 table_user.frm
-rw-r----- 1 mysql mysql   131072 3月  23 10:38 table_user.ibd
-rw-r----- 1 mysql mysql     8586 3月  24 10:17 words.frm
-rw-r----- 1 mysql mysql 10485760 3月  24 10:19 words.ibd

[root@localhost data]# date
2021年 04月 09日 星期五 17:32:48 CST

[root@localhost data]# ls -lht ibtmp1 
-rw-r----- 1 mysql mysql 12M 4月   9 17:32 ibtmp1


------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TEMPORARY TABLE：是存储在内存的吗
	不是，存储在磁盘中。



	CREATE TEMPORARY TABLE `t_20210409` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',  
	`name` varchar(32) not NULL default '',
	`age` int(11) not NULL default 0,
	`ismale` tinyint(1) not null default 0,
	`id_card` varchar(32) not NULL default '',
	`test1` text COMMENT '',
	`test2` text COMMENT '',
	`createTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
	PRIMARY KEY (`id`),
	KEY `idx_age` (`age`),
	KEY `idx_name` (`name`),
	KEY `idx_card` (`id_card`),
	KEY `idx_createTime` (`createTime`)
	) ENGINE=InnoDB;


	drop procedure if exists idata2 ;
	delimiter ;;
	create procedure idata2()
	begin
	  declare i int;
	  set i=1;
	  start transaction;
		  while(i<=100000)do
			insert into t_20210409(name, age, ismale, id_card, test1, test2) values(substring(md5(rand()),1,10), i, FLOOR(1 + (RAND() * 100)), substring(md5(rand()),1,30), concat(substring(md5(rand()),1,100), substring(md5(rand()),1,100), '这里是做普通索引和唯一索引的插入性能对比测试'), concat(substring(md5(rand()),1,100), substring(md5(rand()),1,100), '这里是做普通索引和唯一索引的插入性能对比测试'));
			set i=i+1;
		  end while;
	  commit;
	end;;
	delimiter ;

root@mysqldb 17:55:  [yldbs]> call idata2();
Query OK, 0 rows affected (4.57 sec)

[root@localhost data]# ls -lht ibtmp1 
-rw-r----- 1 mysql mysql 76M 4月   9 17:55 ibtmp

root@mysqldb 17:55:  [yldbs]> call idata2();
Query OK, 0 rows affected (4.64 sec)

[root@localhost data]# ls -lht ibtmp1 
-rw-r----- 1 mysql mysql 140M 4月   9 17:55 ibtmp1


root@mysqldb 17:55:  [yldbs]> call idata2();
Query OK, 0 rows affected (4.71 sec)

[root@localhost data]# ls -lht ibtmp1 
-rw-r----- 1 mysql mysql 204M 4月   9 18:12 ibtmp1
