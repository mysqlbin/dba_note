
drop table if exists t1;
drop table if exists t2;
CREATE TABLE `t1` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `t1` int(10) NOT NULL,
  `t2` int(10) NOT NULL,
  `order_no` varchar(64) NOT NULL DEFAULT '' COMMENT 'order no',
  `status` int(10) NOT NULL,
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
  PRIMARY KEY (`ID`),
  KEY `idx_order_no` (`order_no`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;


INSERT INTO `t1` (`ID`, `t1`, `t2`, `order_no`, `status`, `createtime`) VALUES ('1', '1', '1', '123456', '0', '2020-04-23 17:28:45');


CREATE TABLE `t2` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `t1` int(10) NOT NULL,
  `t2` int(10) NOT NULL,
  `order_no` varchar(64) NOT NULL DEFAULT '' COMMENT 'order no',
  `status` int(10) NOT NULL,
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
  PRIMARY KEY (`ID`),
  KEY `idx_order_no` (`order_no`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

INSERT INTO `t2` (`ID`, `t1`, `t2`, `order_no`, `status`, `createtime`) VALUES ('1', '1', '1', '123456', '0', '2020-04-23 17:28:45');
INSERT INTO `t2` (`ID`, `t1`, `t2`, `order_no`, `status`, `createtime`) VALUES ('2', '1', '1', '123456', '0', '2020-04-23 17:28:45');


mysql> select version();
+------------+
| version()  |
+------------+
| 5.7.22-log |
+------------+
1 row in set (0.00 sec)


mysql> select @@global.tx_isolation;
+-----------------------+
| @@global.tx_isolation |
+-----------------------+
| REPEATABLE-READ       |
+-----------------------+
1 row in set, 1 warning (0.00 sec)



session A                  session B
begin;
select * from t1 where id in (select id from t2 where id=1);
							
							begin;
							delete from t2 where id=1;
							(Query OK)
							
-------------------------------------------------------------	
session A                  session B

begin;
delete from t2 where id=1;
							begin;
							select * from t1 where id in (select id from t2 where id=1);
							(Query OK)	

-------------------------------------------------------------							
session A                  session B

begin;
select * from t1 where id in (select id from t1 where id=1);
							
							begin;
							delete from t1 where id=1;
							(Query OK)	

							

select * from information_schema.innodb_trx\G;
select * from information_schema.innodb_locks\G;
select * from information_schema.innodb_lock_waits\G;
SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;

-------------------------------------------------------------------------------------------------------

	
CREATE TABLE `t10` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

DROP PROCEDURE IF EXISTS `idata`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `idata`()
begin
  declare i int;
  set i=1;
	start transaction;
  while(i<=1000000) do
	INSERT INTO t10 (c,d) values (i,i);
	set i=i+1;
  end while;
	commit;
end
;;
DELIMITER ;
call idata();

session A        session B
begin;
select * from t10 where id in (select max(id) from t10 group by d);

				begin;
				delete from t10 where id=1;	
				
				
	
join 语句的加锁


