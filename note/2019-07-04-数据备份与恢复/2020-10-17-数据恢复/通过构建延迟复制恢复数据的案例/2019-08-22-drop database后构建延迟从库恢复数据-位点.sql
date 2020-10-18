

关于drop database后的黑科技恢复
    
	
恢复方法:
	
	1. 假设没有构建延迟从库 
		复制架构: 一主一从, 每天凌晨6点在从库进行单库全备
		
		从库保留7天的binlog
		
	2. 发生drop database后，必须要停止业务
	
	3. 然后通过已经有的全备建立延迟从库，start slave until 直到删除到drop database之前停下来.
	
	注意事项:
		不能在已有的从库做数据恢复操作
		 从库要开启 参数log_slave_updates
		 

Master:
		 
create  database db1 DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;

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

#备份数据:

shell>  mysqldump -h192.168.0.54 -uroot -p123456abc --master-data=2  --single-transaction -B db1 > db1.sql


INSERT INTO `db1`.`product`(`id`, `name`, `amount`) VALUES (3, '1', 2); 

#恢复到这里

drop database db1;  #发起一个误删除数据库操作


#在数据库恢复实例上导入备份

mysql> mysql -h192.168.0.55 -uroot -p123456abc < db1.sql


#建立复制关系:

#复制专用账号只要是在做 change master to 之前创建和授权就行
Master:

create user 'repl'@'%' identified by '123456abc';
grant replication slave on *.* to 'repl'@'%' with grant option;


#在逻辑备份文件获取复制的位点:

Slave:
change master to master_host='192.168.0.54',master_user='repl',master_password='123456abc',master_port=3306,MASTER_LOG_FILE='mysql-bin.000002',MASTER_LOG_POS=1314;

start slave sql_thread until 直到指定的binlog位置停下:

#获取误操作的位点:
mysqlbinlog --no-defaults -vv --base64-output=decode-rows --start-datetime='2019-08-22 16:47:00' --stop-datetime='2019-08-22 16:50:00' mysql-bin.000002 > 2.sql

BEGIN
/*!*/;
# at 1180
#190822 16:48:36 server id 330601  end_log_pos 1233 CRC32 0xae0a1ec6 	Table_map: `db1`.`product` mapped to number 109
# at 1233
#190822 16:48:36 server id 330601  end_log_pos 1283 CRC32 0x80d1368b 	Write_rows: table id 109 flags: STMT_END_F
### INSERT INTO `db1`.`product`
### SET
###   @1=2 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2='1' /* VARSTRING(80) meta=80 nullable=1 is_null=0 */
###   @3=2 /* INT meta=0 nullable=1 is_null=0 */
# at 1283
#190822 16:48:36 server id 330601  end_log_pos 1314 CRC32 0x75048e0d 	Xid = 30
COMMIT/*!*/;
# at 1314
#190822 16:49:49 server id 330601  end_log_pos 1379 CRC32 0xa2cbdda0 	Anonymous_GTID	last_committed=4	sequence_number=5	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 1379
#190822 16:49:49 server id 330601  end_log_pos 1450 CRC32 0x754097f8 	Query	thread_id=15	exec_time=0	error_code=0
SET TIMESTAMP=1566463789/*!*/;
BEGIN
/*!*/;
# at 1450
#190822 16:49:49 server id 330601  end_log_pos 1503 CRC32 0xa28faa44 	Table_map: `db1`.`product` mapped to number 111
# at 1503
#190822 16:49:49 server id 330601  end_log_pos 1553 CRC32 0x50283664 	Write_rows: table id 111 flags: STMT_END_F
### INSERT INTO `db1`.`product`
### SET
###   @1=3 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2='1' /* VARSTRING(80) meta=80 nullable=1 is_null=0 */
###   @3=2 /* INT meta=0 nullable=1 is_null=0 */
# at 1553
#190822 16:49:49 server id 330601  end_log_pos 1584 CRC32 0xc8295a61 	Xid = 81
COMMIT/*!*/;
# at 1584
#190822 16:49:54 server id 330601  end_log_pos 1649 CRC32 0xcd8a801b 	Anonymous_GTID	last_committed=5	sequence_number=6	rbr_only=no
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 1649
#190822 16:49:54 server id 330601  end_log_pos 1738 CRC32 0x616d0f07 	Query	thread_id=15	exec_time=0	error_code=0
SET TIMESTAMP=1566463794/*!*/;
drop database db1
/*!*/;
SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
DELIMITER ;
# End of log file


start slave until master_log_file='mysql-bin.000002',master_log_pos=1584; \
show slave status\G;





