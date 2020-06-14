让从库停止在 SQL线程 的某个位置：


开始构建3600秒的延迟复制：

	stop slave; \
	change master to master_delay=3600; \
	start slave;


延迟复制的应用案例：


样例1：


先在从库开启延迟复制: 
stop slave sql_thread; \
change master to master_delay=3600; \
start slave sql_thread; \
show slave status\G; 


CREATE TABLE `product` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `name` varchar(20) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

	
INSERT INTO `sbtest`.`product`(`id`, `name`, `amount`) VALUES (1, '1', 2); 

INSERT INTO `sbtest`.`product`(`id`, `name`, `amount`) VALUES (2, '1', 2); 

INSERT INTO `sbtest`.`product`(`id`, `name`, `amount`) VALUES (3, '1', 2); 
#让复制停止到这里。
DELETE FROM `sbtest`.`product` WHERE `id`=3 AND `name`='1' AND `amount`=2 LIMIT 1;



获取 在主库删除一条记录 的 master_log_pos;

mysqlbinlog --no-defaults -vv --base64-output=decode-rows --start-datetime='2019-08-22 10:02:41' --stop-datetime='2019-08-22 10:06:00' mysql-bin.000272 > 272.sql

DELIMITER /*!*/;
# at 4
#190822 10:04:08 server id 17  end_log_pos 123 CRC32 0xf38a08e1 	Start: binlog v 4, server v 5.7.24-log created 190822 10:04:08
# at 123
#190822 10:04:08 server id 17  end_log_pos 194 CRC32 0xd43f47e3 	Previous-GTIDs
# 64f06970-098a-11e9-aee6-00163e020f37:1-1716
# at 194
#190822 10:04:25 server id 17  end_log_pos 259 CRC32 0x533d1fc8 	Anonymous_GTID	last_committed=0	sequence_number=1	rbr_only=no
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 259
#190822 10:04:25 server id 17  end_log_pos 595 CRC32 0xdddc80c5 	Query	thread_id=14	exec_time=0	error_code=0
use `sbtest`/*!*/;
SET TIMESTAMP=1566439465/*!*/;
SET @@session.pseudo_thread_id=14/*!*/;
SET @@session.foreign_key_checks=1, @@session.sql_auto_is_null=0, @@session.unique_checks=1, @@session.autocommit=1/*!*/;
SET @@session.sql_mode=1075838976/*!*/;
SET @@session.auto_increment_increment=1, @@session.auto_increment_offset=1/*!*/;
/*!\C utf8 *//*!*/;
SET @@session.character_set_client=33,@@session.collation_connection=33,@@session.collation_server=45/*!*/;
SET @@session.lc_time_names=0/*!*/;
SET @@session.collation_database=DEFAULT/*!*/;
CREATE TABLE `product` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `name` varchar(20) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4
/*!*/;
# at 595
#190822 10:04:25 server id 17  end_log_pos 660 CRC32 0x6d85513f 	Anonymous_GTID	last_committed=1	sequence_number=2	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 660
#190822 10:04:25 server id 17  end_log_pos 734 CRC32 0x38517fba 	Query	thread_id=14	exec_time=0	error_code=0
SET TIMESTAMP=1566439465/*!*/;
BEGIN
/*!*/;
# at 734
#190822 10:04:25 server id 17  end_log_pos 790 CRC32 0x2c79dd3c 	Table_map: `sbtest`.`product` mapped to number 121
# at 790
#190822 10:04:25 server id 17  end_log_pos 840 CRC32 0xf0a0d5f0 	Write_rows: table id 121 flags: STMT_END_F
### INSERT INTO `sbtest`.`product`
### SET
###   @1=1 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2='1' /* VARSTRING(80) meta=80 nullable=1 is_null=0 */
###   @3=2 /* INT meta=0 nullable=1 is_null=0 */
# at 840
#190822 10:04:25 server id 17  end_log_pos 871 CRC32 0x39144137 	Xid = 58
COMMIT/*!*/;
# at 871
#190822 10:04:25 server id 17  end_log_pos 936 CRC32 0x97a27e21 	Anonymous_GTID	last_committed=2	sequence_number=3	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 936
#190822 10:04:25 server id 17  end_log_pos 1010 CRC32 0x2181f6df 	Query	thread_id=14	exec_time=0	error_code=0
SET TIMESTAMP=1566439465/*!*/;
BEGIN
/*!*/;
# at 1010
#190822 10:04:25 server id 17  end_log_pos 1066 CRC32 0x9674ae44 	Table_map: `sbtest`.`product` mapped to number 121
# at 1066
#190822 10:04:25 server id 17  end_log_pos 1116 CRC32 0x3655a2c0 	Write_rows: table id 121 flags: STMT_END_F
### INSERT INTO `sbtest`.`product`
### SET
###   @1=2 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2='1' /* VARSTRING(80) meta=80 nullable=1 is_null=0 */
###   @3=2 /* INT meta=0 nullable=1 is_null=0 */
# at 1116
#190822 10:04:25 server id 17  end_log_pos 1147 CRC32 0xc48aeab0 	Xid = 59
COMMIT/*!*/;
# at 1147
#190822 10:04:25 server id 17  end_log_pos 1212 CRC32 0x6d2aa2e1 	Anonymous_GTID	last_committed=3	sequence_number=4	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 1212
#190822 10:04:25 server id 17  end_log_pos 1286 CRC32 0x83433b30 	Query	thread_id=14	exec_time=0	error_code=0
SET TIMESTAMP=1566439465/*!*/;
BEGIN
/*!*/;
# at 1286
#190822 10:04:25 server id 17  end_log_pos 1342 CRC32 0xc91fd455 	Table_map: `sbtest`.`product` mapped to number 121
# at 1342
#190822 10:04:25 server id 17  end_log_pos 1392 CRC32 0x8548852c 	Write_rows: table id 121 flags: STMT_END_F
### INSERT INTO `sbtest`.`product`
### SET
###   @1=3 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2='1' /* VARSTRING(80) meta=80 nullable=1 is_null=0 */
###   @3=2 /* INT meta=0 nullable=1 is_null=0 */
# at 1392
#190822 10:04:25 server id 17  end_log_pos 1423 CRC32 0x6369e990 	Xid = 60
COMMIT/*!*/;
# at 1423
#190822 10:04:25 server id 17  end_log_pos 1488 CRC32 0x42420373 	Anonymous_GTID	last_committed=4	sequence_number=5	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 1488
#190822 10:04:25 server id 17  end_log_pos 1562 CRC32 0x53ddf5f8 	Query	thread_id=14	exec_time=0	error_code=0
SET TIMESTAMP=1566439465/*!*/;
BEGIN
/*!*/;
# at 1562
#190822 10:04:25 server id 17  end_log_pos 1618 CRC32 0xd5ce4928 	Table_map: `sbtest`.`product` mapped to number 121
# at 1618
#190822 10:04:25 server id 17  end_log_pos 1668 CRC32 0xc32455b4 	Delete_rows: table id 121 flags: STMT_END_F
### DELETE FROM `sbtest`.`product`
### WHERE
###   @1=3 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2='1' /* VARSTRING(80) meta=80 nullable=1 is_null=0 */
###   @3=2 /* INT meta=0 nullable=1 is_null=0 */
# at 1668
#190822 10:04:25 server id 17  end_log_pos 1699 CRC32 0xf5986c35 	Xid = 61
COMMIT/*!*/;
# at 1699
#190822 10:04:30 server id 17  end_log_pos 1746 CRC32 0x1982640e 	Rotate to mysql-bin.000268  pos: 4
SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
DELIMITER ;
# End of log file



start slave sql_thread until 直到指定的binlog位置停下
stop slave sql_thread; \
change master to master_delay=0; \
start slave sql_thread until master_log_file='mysql-bin.000272',master_log_pos=1423; \
show slave status\G;



样例2:


先在从库开启延迟复制: 
stop slave sql_thread; \
change master to master_delay=3600; \
start slave sql_thread; \
show slave status\G; 


use db1;

CREATE TABLE `product` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `name` varchar(20) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

	
INSERT INTO `db1`.`product`(`id`, `name`, `amount`) VALUES (1, '1', 2); 

INSERT INTO `db1`.`product`(`id`, `name`, `amount`) VALUES (2, '1', 2); 

INSERT INTO `db1`.`product`(`id`, `name`, `amount`) VALUES (3, '1', 2); 


#让复制停止到这里。

drop database db1;

mysqlbinlog --no-defaults -vv --base64-output=decode-rows  mysql-bin.000274 > 274.sql


###   @3=2 /* INT meta=0 nullable=1 is_null=0 */
# at 822
#190822 10:35:09 server id 17  end_log_pos 853 CRC32 0x6bb3d541         Xid = 247
COMMIT/*!*/;
# at 853
#190822 10:35:09 server id 17  end_log_pos 918 CRC32 0x0e80de13         Anonymous_GTID  last_committed=2        sequence_number=3       rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 918
#190822 10:35:09 server id 17  end_log_pos 989 CRC32 0xf0f84bea         Query   thread_id=12    exec_time=0     error_code=0
SET TIMESTAMP=1566441309/*!*/;
BEGIN
/*!*/;
# at 989
#190822 10:35:09 server id 17  end_log_pos 1042 CRC32 0x49274c19        Table_map: `db1`.`product` mapped to number 131
# at 1042
#190822 10:35:09 server id 17  end_log_pos 1092 CRC32 0xfacc1747        Write_rows: table id 131 flags: STMT_END_F
### INSERT INTO `db1`.`product`
### SET
###   @1=2 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2='1' /* VARSTRING(80) meta=80 nullable=1 is_null=0 */
###   @3=2 /* INT meta=0 nullable=1 is_null=0 */
# at 1092
#190822 10:35:09 server id 17  end_log_pos 1123 CRC32 0x9cf4ceb7        Xid = 248
COMMIT/*!*/;
# at 1123
#190822 10:35:09 server id 17  end_log_pos 1188 CRC32 0xa255ea9f        Anonymous_GTID  last_committed=3        sequence_number=4       rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 1188
#190822 10:35:09 server id 17  end_log_pos 1259 CRC32 0x78b00478        Query   thread_id=12    exec_time=0     error_code=0
SET TIMESTAMP=1566441309/*!*/;
BEGIN
/*!*/;
# at 1259
#190822 10:35:09 server id 17  end_log_pos 1312 CRC32 0x8f9b541f        Table_map: `db1`.`product` mapped to number 131
# at 1312
#190822 10:35:09 server id 17  end_log_pos 1362 CRC32 0xf9fd9203        Write_rows: table id 131 flags: STMT_END_F
### INSERT INTO `db1`.`product`
### SET
###   @1=3 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2='1' /* VARSTRING(80) meta=80 nullable=1 is_null=0 */
###   @3=2 /* INT meta=0 nullable=1 is_null=0 */
# at 1362
#190822 10:35:09 server id 17  end_log_pos 1393 CRC32 0x0a14ef6d        Xid = 249
COMMIT/*!*/;
# at 1393
#190822 10:35:24 server id 17  end_log_pos 1440 CRC32 0xb08bab24        Rotate to mysql-bin.000275  pos: 4
SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
DELIMITER ;
# End of log file



start slave sql_thread until 直到指定的binlog位置停下
stop slave sql_thread; \
change master to master_delay=0; \
start slave sql_thread until master_log_file='mysql-bin.000274',master_log_pos=1393; \
show slave status\G;



小结： 
1. start slave sql_thread until master_log_file='mysql-bin.000008',master_log_pos=;
   master_log_pos 是取做误操作那个语句的start_pos; 
   比如
	INSERT INTO `sbtest`.`product`(`id`, `name`, `amount`) VALUES (3, '1', 2); #start 1286 end 1423 
	#让复制停止DELETE语句操作之前。
	DELETE FROM `sbtest`.`product` WHERE `id`=3 AND `name`='1' AND `amount`=2 LIMIT 1; #start 1562 end 1699 
	那么  master_log_pos 就是  1423
	
	
	