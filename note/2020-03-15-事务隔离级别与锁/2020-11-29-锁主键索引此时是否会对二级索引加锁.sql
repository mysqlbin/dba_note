


drop table if exists t1 ;
CREATE TABLE `t1` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `t1` int(10) NOT NULL COMMENT '',
  `t2` int(10) NOT NULL COMMENT '',
  `order_no` varchar(64) NOT NULL DEFAULT '' COMMENT 'order no',
  `status` int(10) NOT NULL COMMENT '',
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
  PRIMARY KEY (`ID`),
  KEY `idx_order_no` (`order_no`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='';

	
INSERT INTO `t1` (`ID`, `t1`, `t2`, `order_no`, `status`, `createtime`) VALUES ('1', '1', '1', '123456', '0', '2020-04-23 17:28:45');


session A          session B

begin;		
update t1 set t2=3 where id=1;
-- 看看这里是否会锁住 idx_status 的记录
					begin;
					select * from t1 where order_no='123456' for update;
					(Blocked)
					主键索引被锁住
					