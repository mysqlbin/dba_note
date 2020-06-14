

#查看binlog格式:
	mysql> show global variables like '%binlog_format%';
	+---------------+-------+
	| Variable_name | Value |
	+---------------+-------+
	| binlog_format | ROW   |
	+---------------+-------+
	1 row in set (0.00 sec)

mysql> delete from sbtest2 where id=2;
mysql> show binlog events in 'mysql-bin.000244';
+------------------+-----+----------------+-----------+-------------+---------------------------------------+
| Log_name         | Pos | Event_type     | Server_id | End_log_pos | Info                                  |
+------------------+-----+----------------+-----------+-------------+---------------------------------------+
| mysql-bin.000244 |   4 | Format_desc    |        17 |         123 | Server ver: 5.7.24-log, Binlog ver: 4 |
| mysql-bin.000244 | 123 | Previous_gtids |        17 |         154 |                                       |
| mysql-bin.000244 | 154 | Anonymous_Gtid |        17 |         219 | SET @@SESSION.GTID_NEXT= 'ANONYMOUS'  |
| mysql-bin.000244 | 219 | Query          |        17 |         293 | BEGIN                                 |
| mysql-bin.000244 | 293 | Table_map      |        17 |         352 | table_id: 432 (sbtest.sbtest2)        |
| mysql-bin.000244 | 352 | Delete_rows    |        17 |         577 | table_id: 432 flags: STMT_END_F       |
| mysql-bin.000244 | 577 | Xid            |        17 |         608 | COMMIT /* xid=1373129 */              |
+------------------+-----+----------------+-----------+-------------+---------------------------------------+
7 rows in set (0.00 sec)


BEGIN
/*!*/;
# at 293
#190801 14:16:43 server id 17  end_log_pos 352 CRC32 0x3f1403b8         Table_map: `sbtest`.`sbtest2` mapped to number 432
# at 352
#190801 14:16:43 server id 17  end_log_pos 577 CRC32 0xc7ca69ce         Delete_rows: table id 432 flags: STMT_END_F
### DELETE FROM `sbtest`.`sbtest2`
### WHERE
###   @1=2 /* INT meta=0 nullable=0 is_null=0 */
###   @2=502049 /* INT meta=0 nullable=0 is_null=0 */
###   @3='99357217743-27579710696-29634161678-68490301784-71286199462-01615674543-02927167839-64721672329-91298439062-10531459749' /* STRING(480) meta=61152 nullable=0 is_null=0 */
###   @4='55069244140-88599530935-98759831323-95072900918-41378360656' /* STRING(240) meta=65264 nullable=0 is_null=0 */
# at 577
#190801 14:16:43 server id 17  end_log_pos 608 CRC32 0x9c71de9b         Xid = 1373129
COMMIT/*!*/;
# at 608
#190801 14:17:18 server id 17  end_log_pos 655 CRC32 0xc0e67f90         Rotate to mysql-bin.000245  pos: 4
SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;



#表的DDL和初始化数据:
mysql> CREATE TABLE `t` (
  `id` int(11) NOT NULL,
  `a` int(11) DEFAULT NULL,
  `t_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `a` (`a`),
  KEY `t_modified`(`t_modified`)
) ENGINE=InnoDB;

insert into t values(1,1,'2018-11-13');
insert into t values(2,2,'2018-11-12');
insert into t values(3,3,'2018-11-11');
insert into t values(4,4,'2018-11-10');
insert into t values(5,5,'2018-11-09');


#############statement格式
mysql> set global binlog_format='statement';
Query OK, 0 rows affected (0.00 sec)

mysql> show global variables like '%binlog_format%';
+---------------+-----------+
| Variable_name | Value     |
+---------------+-----------+
| binlog_format | STATEMENT |
+---------------+-----------+
1 row in set (0.00 sec)

mysql> delete from t /*comment*/  where a>=4 and t_modified<='2018-11-10' limit 1;
Query OK, 1 row affected (0.00 sec)

mysql> show binlog events in 'mysql-bin.000246';
+------------------+-----+----------------+-----------+-------------+---------------------------------------+
| Log_name         | Pos | Event_type     | Server_id | End_log_pos | Info                                  |
+------------------+-----+----------------+-----------+-------------+---------------------------------------+
| mysql-bin.000246 |   4 | Format_desc    |        17 |         123 | Server ver: 5.7.24-log, Binlog ver: 4 |
| mysql-bin.000246 | 123 | Previous_gtids |        17 |         154 |                                       |
| mysql-bin.000246 | 154 | Anonymous_Gtid |        17 |         219 | SET @@SESSION.GTID_NEXT= 'ANONYMOUS'  |
| mysql-bin.000246 | 219 | Query          |        17 |         301 | BEGIN                                 |
| mysql-bin.000246 | 301 | Table_map      |        17 |         350 | table_id: 665 (sbtest.t)              |
| mysql-bin.000246 | 350 | Delete_rows    |        17 |         398 | table_id: 665 flags: STMT_END_F       |
| mysql-bin.000246 | 398 | Xid            |        17 |         429 | COMMIT /* xid=1373654 */              |
+------------------+-----+----------------+-----------+-------------+---------------------------------------+
7 rows in set (0.00 sec)

shell> mysqlbinlog --no-defaults -vv --base64-output=decode-rows mysql-bin.000246 > 246.sql
BEGIN
/*!*/;
# at 301
#190801 14:40:56 server id 17  end_log_pos 350 CRC32 0x269d952c         Table_map: `sbtest`.`t` mapped to number 665
# at 350
#190801 14:40:56 server id 17  end_log_pos 398 CRC32 0x9e4cb153         Delete_rows: table id 665 flags: STMT_END_F
### DELETE FROM `sbtest`.`t`
### WHERE
###   @1=4 /* INT meta=0 nullable=0 is_null=0 */
###   @2=4 /* INT meta=0 nullable=1 is_null=0 */
###   @3=1541779200 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
# at 398
#190801 14:40:56 server id 17  end_log_pos 429 CRC32 0x1d9c2a24         Xid = 1373654
COMMIT/*!*/;
# at 429
#190801 14:41:06 server id 17  end_log_pos 476 CRC32 0xef72d129         Rotate to mysql-bin.000247  pos: 4
SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;



#############row格式
mysql> set global binlog_format='row';
Query OK, 0 rows affected (0.00 sec)

mysql> show global variables like '%binlog_format%';
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| binlog_format | ROW   |
+---------------+-------+
1 row in set (0.00 sec)

mysql> delete from t /*comment*/  where a>=4 and t_modified<='2018-11-10' limit 1;
Query OK, 1 row affected (0.00 sec)

mysql> show binlog events in 'mysql-bin.000248';
+------------------+-----+----------------+-----------+-------------+---------------------------------------+
| Log_name         | Pos | Event_type     | Server_id | End_log_pos | Info                                  |
+------------------+-----+----------------+-----------+-------------+---------------------------------------+
| mysql-bin.000248 |   4 | Format_desc    |        17 |         123 | Server ver: 5.7.24-log, Binlog ver: 4 |
| mysql-bin.000248 | 123 | Previous_gtids |        17 |         154 |                                       |
| mysql-bin.000248 | 154 | Anonymous_Gtid |        17 |         219 | SET @@SESSION.GTID_NEXT= 'ANONYMOUS'  |
| mysql-bin.000248 | 219 | Query          |        17 |         301 | BEGIN                                 |
| mysql-bin.000248 | 301 | Table_map      |        17 |         350 | table_id: 665 (sbtest.t)              |
| mysql-bin.000248 | 350 | Delete_rows    |        17 |         398 | table_id: 665 flags: STMT_END_F       |
| mysql-bin.000248 | 398 | Xid            |        17 |         429 | COMMIT /* xid=1373911 */              |
+------------------+-----+----------------+-----------+-------------+---------------------------------------+
7 rows in set (0.00 sec)


shell> mysqlbinlog --no-defaults -vv --base64-output=decode-rows mysql-bin.000248 --start-position=154 > 248.sql

BEGIN
/*!*/;
# at 301
#190801 14:58:58 server id 17  end_log_pos 350 CRC32 0xfca0e2d3         Table_map: `sbtest`.`t` mapped to number 665
# at 350
#190801 14:58:58 server id 17  end_log_pos 398 CRC32 0xc3839e38         Delete_rows: table id 665 flags: STMT_END_F
### DELETE FROM `sbtest`.`t`
### WHERE
###   @1=4 /* INT meta=0 nullable=0 is_null=0 */
###   @2=4 /* INT meta=0 nullable=1 is_null=0 */
###   @3=1541779200 /* TIMESTAMP(0) meta=0 nullable=0 is_null=0 */
# at 398
#190801 14:58:58 server id 17  end_log_pos 429 CRC32 0xe945bd8f         Xid = 1373911
COMMIT/*!*/;
# at 429


statement格式:
		
	好处:
		在binlog中记录的是原始SQL， binlog文件很小;

	缺点：
		存安全隐患, 可能导致主从不一致:
			比如删除记录的语句, 主库和从库可能删除的是不同记录;
			通过做实验就能复现;
			
row格式:

	好处:
		1. 保证了主库DML和从库应用binlog操作的是同一行记录, 复制更加安全;
			binlog 里面记录了真实删除行的主键 id;
			binlog 传到备库去的时候，就肯定会删除 id=4 的行，不会有主备删除不同行的问题。
		2. 恢复数据更加方便;
			insert 语句:
				row 格式下，insert 语句的 binlog 里会记录所有的字段信息，这些信息可以用来精确定位刚刚被插入的那一行。
				直接把 insert 语句转成 delete 语句，删除掉这被误插入的一行数据就可以了。
			delete 语句:
				row 格式的 binlog 也会把被删掉的行的整行信息保存起来。	
				在执行完一条 delete 语句以后，发现删错数据了，可以直接把 binlog 中记录的 delete 语句转成 insert，把被错删的数据插入回去就可以恢复了。		
			update 语句:
				binlog 里面会记录修改前整行的数据和修改后的整行数据; 
				误执行了 update 语句，只需要把这个 event 前后的两行信息对调一下，再去数据库里面执行，就能恢复这个更新操作了。
				
			衍生工具:
				binlog2sql				
			
	缺点:
		1. 一个delete语句删除10W行记录, 会把这10W行记录都写到binlog中:
		2. 占用更大的磁盘空间;
		3. 写binlog也要耗费IO资源, 影响执行速度. 
		
mixed格式:
	是statement和row格式的混合；
	mixed是个折中方案：
		如果SQL 语句可能引起主备不一致，就采用 row 格式；
		否则就用 statement 格式。
	
	

	
参数 log_slave_updates 设置为 on:
	表示备库执行 relay log 后生成 binlog。



mysql> show global variables like '%read_only%';
+-----------------------+-------+
| Variable_name         | Value |
+-----------------------+-------+
| innodb_read_only      | OFF   |
| read_only             | ON    |
| super_read_only       | ON    |
| transaction_read_only | OFF   |
| tx_read_only          | OFF   |
+-----------------------+-------+
5 rows in set (0.01 sec)

	
	


