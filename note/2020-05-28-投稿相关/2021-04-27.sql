CREATE TABLE `t1` (
	`ID` INT (10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增ID',
	`t1` INT (10) NOT NULL COMMENT '',
	`t2` INT (10) NOT NULL COMMENT '',
	`order_no` VARCHAR (64) NOT NULL DEFAULT '' COMMENT 'order no',
	`status` INT (10) NOT NULL COMMENT '状态',
	`createtime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
	PRIMARY KEY (`ID`),
	KEY `idx_order_no` (`order_no`),
	KEY `idx_status_createtime` (`status`, `createtime`)
) ENGINE = INNODB DEFAULT CHARSET = utf8mb4 COMMENT = '';


INSERT INTO `t1` (
	`ID`,
	`t1`,
	`t2`,
	`order_no`,
	`status`,
	`createtime`
)
VALUES
	(
		'1',
		'1',
		'1',
		'123456',
		'0',
		'2020-04-24 12:10:00'
	);


SELECT
	ID,
	order_no,
	STATUS,
	createtime
FROM
	t1
WHERE
	order_no = '123456';
	
	
	
	
session A        session B 	
begin; 
select status from t1 where order_no='123456' for update; 

				UPDATE t1 SET status = 5 WHERE status = 0 AND (createtime BETWEEN DATE_SUB(NOW(),INTERVAL 90 MINUTE)  AND DATE_SUB(NOW(),INTERVAL 60 MINUTE));
				
update t1 set status=1 where order_no='123456';

			
			
优化方案：
	
	session B 先执行一次查询，如果记录存在就更新，记录不存在，就不必执行更新语句。
	同时更新语句也不要用范围更新，先查询，获取到主键，通过遍历，主键做为条件，一行行地更新。	
		select count(*) from t1 WHERE status = 0 AND (createtime BETWEEN DATE_SUB(NOW(),INTERVAL 90 MINUTE)  AND DATE_SUB(NOW(),INTERVAL 60 MINUTE));
		
		
		
		
		
	范围查询就会往后查找，找到不满足条件的下一行记录之后，再加锁。
	等值更新，就不会存在这个问题。
	
	
	


	
			
