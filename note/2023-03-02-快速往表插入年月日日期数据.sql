DELIMITER $$
DROP PROCEDURE IF EXISTS create_calendar $$
CREATE PROCEDURE create_calendar (s_date DATE, e_date DATE)
BEGIN
    WHILE s_date <= e_date DO
        INSERT IGNORE INTO t_date_ymd(`date_ymd`) VALUES (DATE(s_date)) ;
        SET s_date = s_date + INTERVAL 1 DAY ;
    END WHILE ; 
END$$
DELIMITER ;

drop table if exists t_date_ymd; 
CREATE TABLE `t_date_ymd` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID', 
  `date_ymd` date NOT NULL COMMENT '日期',
  PRIMARY KEY (`ID`)
)  DEFAULT CHARSET=utf8mb4;


CALL create_calendar ('2022-01-01', '2028-04-30');


	





SELECT DATE_FORMAT(DATE_SUB(NOW(), INTERVAL xc DAY), '%Y-%m-%d') as date
FROM ( 
                        SELECT @xi:=@xi+1 as xc from 
                        (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) xc1, 
                        (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) xc2, 
                  (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) xc3,  
			(SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) xc4,
			
                        (SELECT @xi:=0) xc0 
) xcxc


t_date_ymd	CREATE TABLE `t_date_ymd` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `date_ymd` date NOT NULL COMMENT '日期',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8mb4;


truncate table t_date_ymd;

SELECT concat ("insert into t_date_ymd(`date_ymd`) values('", DATE_FORMAT(DATE_SUB(NOW(), INTERVAL xc DAY), '%Y-%m-%d'),"');")
FROM ( 
                        SELECT @xi:=@xi+1 as xc from 
                        (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) xc1, 
                        (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) xc2, 
                  (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) xc3,  
			(SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) xc4,
			
                        (SELECT @xi:=0) xc0 
) xcxc;



insert into t_date_ymd(`date_ymd`) values('2023-03-01');
insert into t_date_ymd(`date_ymd`) values('2023-02-28');
insert into t_date_ymd(`date_ymd`) values('2023-02-27');
insert into t_date_ymd(`date_ymd`) values('2023-02-26');
insert into t_date_ymd(`date_ymd`) values('2023-02-25');
insert into t_date_ymd(`date_ymd`) values('2023-02-24');
insert into t_date_ymd(`date_ymd`) values('2023-02-23');
insert into t_date_ymd(`date_ymd`) values('2023-02-22');
insert into t_date_ymd(`date_ymd`) values('2023-02-21');
insert into t_date_ymd(`date_ymd`) values('2023-02-20');
insert into t_date_ymd(`date_ymd`) values('2023-02-19');
insert into t_date_ymd(`date_ymd`) values('2023-02-18');
insert into t_date_ymd(`date_ymd`) values('2023-02-17');
insert into t_date_ymd(`date_ymd`) values('2023-02-16');
insert into t_date_ymd(`date_ymd`) values('2023-02-15');
insert into t_date_ymd(`date_ymd`) values('2023-02-14');
insert into t_date_ymd(`date_ymd`) values('2023-02-13');
insert into t_date_ymd(`date_ymd`) values('2023-02-12');
insert into t_date_ymd(`date_ymd`) values('2023-02-11');
insert into t_date_ymd(`date_ymd`) values('2023-02-10');
insert into t_date_ymd(`date_ymd`) values('2023-02-09');
insert into t_date_ymd(`date_ymd`) values('2023-02-08');
insert into t_date_ymd(`date_ymd`) values('2023-02-07');
insert into t_date_ymd(`date_ymd`) values('2023-02-06');
insert into t_date_ymd(`date_ymd`) values('2023-02-05');
insert into t_date_ymd(`date_ymd`) values('2023-02-04');
insert into t_date_ymd(`date_ymd`) values('2023-02-03');
insert into t_date_ymd(`date_ymd`) values('2023-02-02');
insert into t_date_ymd(`date_ymd`) values('2023-02-01');
insert into t_date_ymd(`date_ymd`) values('2023-01-31');
insert into t_date_ymd(`date_ymd`) values('2023-01-30');
insert into t_date_ymd(`date_ymd`) values('2023-01-29');
insert into t_date_ymd(`date_ymd`) values('2023-01-28');
insert into t_date_ymd(`date_ymd`) values('2023-01-27');
insert into t_date_ymd(`date_ymd`) values('2023-01-26');
insert into t_date_ymd(`date_ymd`) values('2023-01-25');
insert into t_date_ymd(`date_ymd`) values('2023-01-24');
insert into t_date_ymd(`date_ymd`) values('2023-01-23');
insert into t_date_ymd(`date_ymd`) values('2023-01-22');
insert into t_date_ymd(`date_ymd`) values('2023-01-21');
insert into t_date_ymd(`date_ymd`) values('2023-01-20');
insert into t_date_ymd(`date_ymd`) values('2023-01-19');
insert into t_date_ymd(`date_ymd`) values('2023-01-18');
insert into t_date_ymd(`date_ymd`) values('2023-01-17');
insert into t_date_ymd(`date_ymd`) values('2023-01-16');
insert into t_date_ymd(`date_ymd`) values('2023-01-15');
insert into t_date_ymd(`date_ymd`) values('2023-01-14');
insert into t_date_ymd(`date_ymd`) values('2023-01-13');
insert into t_date_ymd(`date_ymd`) values('2023-01-12');
insert into t_date_ymd(`date_ymd`) values('2023-01-11');
insert into t_date_ymd(`date_ymd`) values('2023-01-10');
insert into t_date_ymd(`date_ymd`) values('2023-01-09');
insert into t_date_ymd(`date_ymd`) values('2023-01-08');
insert into t_date_ymd(`date_ymd`) values('2023-01-07');
insert into t_date_ymd(`date_ymd`) values('2023-01-06');
insert into t_date_ymd(`date_ymd`) values('2023-01-05');
insert into t_date_ymd(`date_ymd`) values('2023-01-04');
insert into t_date_ymd(`date_ymd`) values('2023-01-03');
insert into t_date_ymd(`date_ymd`) values('2023-01-02');
insert into t_date_ymd(`date_ymd`) values('2023-01-01');
insert into t_date_ymd(`date_ymd`) values('2022-12-31');
insert into t_date_ymd(`date_ymd`) values('2022-12-30');
insert into t_date_ymd(`date_ymd`) values('2022-12-29');
insert into t_date_ymd(`date_ymd`) values('2022-12-28');
insert into t_date_ymd(`date_ymd`) values('2022-12-27');
insert into t_date_ymd(`date_ymd`) values('2022-12-26');
insert into t_date_ymd(`date_ymd`) values('2022-12-25');
insert into t_date_ymd(`date_ymd`) values('2022-12-24');
insert into t_date_ymd(`date_ymd`) values('2022-12-23');
insert into t_date_ymd(`date_ymd`) values('2022-12-22');
insert into t_date_ymd(`date_ymd`) values('2022-12-21');
insert into t_date_ymd(`date_ymd`) values('2022-12-20');
insert into t_date_ymd(`date_ymd`) values('2022-12-19');
insert into t_date_ymd(`date_ymd`) values('2022-12-18');
insert into t_date_ymd(`date_ymd`) values('2022-12-17');
insert into t_date_ymd(`date_ymd`) values('2022-12-16');
insert into t_date_ymd(`date_ymd`) values('2022-12-15');
insert into t_date_ymd(`date_ymd`) values('2022-12-14');
insert into t_date_ymd(`date_ymd`) values('2022-12-13');
insert into t_date_ymd(`date_ymd`) values('2022-12-12');
insert into t_date_ymd(`date_ymd`) values('2022-12-11');
insert into t_date_ymd(`date_ymd`) values('2022-12-10');
insert into t_date_ymd(`date_ymd`) values('2022-12-09');
insert into t_date_ymd(`date_ymd`) values('2022-12-08');
insert into t_date_ymd(`date_ymd`) values('2022-12-07');
insert into t_date_ymd(`date_ymd`) values('2022-12-06');
insert into t_date_ymd(`date_ymd`) values('2022-12-05');
insert into t_date_ymd(`date_ymd`) values('2022-12-04');
insert into t_date_ymd(`date_ymd`) values('2022-12-03');
insert into t_date_ymd(`date_ymd`) values('2022-12-02');
insert into t_date_ymd(`date_ymd`) values('2022-12-01');
insert into t_date_ymd(`date_ymd`) values('2022-11-30');
insert into t_date_ymd(`date_ymd`) values('2022-11-29');
insert into t_date_ymd(`date_ymd`) values('2022-11-28');
insert into t_date_ymd(`date_ymd`) values('2022-11-27');
insert into t_date_ymd(`date_ymd`) values('2022-11-26');
insert into t_date_ymd(`date_ymd`) values('2022-11-25');
insert into t_date_ymd(`date_ymd`) values('2022-11-24');
insert into t_date_ymd(`date_ymd`) values('2022-11-23');
insert into t_date_ymd(`date_ymd`) values('2022-11-22');
insert into t_date_ymd(`date_ymd`) values('2022-11-21');
insert into t_date_ymd(`date_ymd`) values('2022-11-20');
insert into t_date_ymd(`date_ymd`) values('2022-11-19');
insert into t_date_ymd(`date_ymd`) values('2022-11-18');
insert into t_date_ymd(`date_ymd`) values('2022-11-17');
insert into t_date_ymd(`date_ymd`) values('2022-11-16');
insert into t_date_ymd(`date_ymd`) values('2022-11-15');
insert into t_date_ymd(`date_ymd`) values('2022-11-14');
insert into t_date_ymd(`date_ymd`) values('2022-11-13');
insert into t_date_ymd(`date_ymd`) values('2022-11-12');
insert into t_date_ymd(`date_ymd`) values('2022-11-11');
insert into t_date_ymd(`date_ymd`) values('2022-11-10');
insert into t_date_ymd(`date_ymd`) values('2022-11-09');
insert into t_date_ymd(`date_ymd`) values('2022-11-08');
insert into t_date_ymd(`date_ymd`) values('2022-11-07');
insert into t_date_ymd(`date_ymd`) values('2022-11-06');
insert into t_date_ymd(`date_ymd`) values('2022-11-05');
insert into t_date_ymd(`date_ymd`) values('2022-11-04');
insert into t_date_ymd(`date_ymd`) values('2022-11-03');
insert into t_date_ymd(`date_ymd`) values('2022-11-02');
insert into t_date_ymd(`date_ymd`) values('2022-11-01');
insert into t_date_ymd(`date_ymd`) values('2022-10-31');
insert into t_date_ymd(`date_ymd`) values('2022-10-30');
insert into t_date_ymd(`date_ymd`) values('2022-10-29');
insert into t_date_ymd(`date_ymd`) values('2022-10-28');
insert into t_date_ymd(`date_ymd`) values('2022-10-27');
insert into t_date_ymd(`date_ymd`) values('2022-10-26');
insert into t_date_ymd(`date_ymd`) values('2022-10-25');
insert into t_date_ymd(`date_ymd`) values('2022-10-24');
insert into t_date_ymd(`date_ymd`) values('2022-10-23');
insert into t_date_ymd(`date_ymd`) values('2022-10-22');
insert into t_date_ymd(`date_ymd`) values('2022-10-21');
insert into t_date_ymd(`date_ymd`) values('2022-10-20');
insert into t_date_ymd(`date_ymd`) values('2022-10-19');
insert into t_date_ymd(`date_ymd`) values('2022-10-18');
insert into t_date_ymd(`date_ymd`) values('2022-10-17');
insert into t_date_ymd(`date_ymd`) values('2022-10-16');
insert into t_date_ymd(`date_ymd`) values('2022-10-15');
insert into t_date_ymd(`date_ymd`) values('2022-10-14');
insert into t_date_ymd(`date_ymd`) values('2022-10-13');
insert into t_date_ymd(`date_ymd`) values('2022-10-12');
insert into t_date_ymd(`date_ymd`) values('2022-10-11');
insert into t_date_ymd(`date_ymd`) values('2022-10-10');
insert into t_date_ymd(`date_ymd`) values('2022-10-09');
insert into t_date_ymd(`date_ymd`) values('2022-10-08');
insert into t_date_ymd(`date_ymd`) values('2022-10-07');
insert into t_date_ymd(`date_ymd`) values('2022-10-06');
insert into t_date_ymd(`date_ymd`) values('2022-10-05');
insert into t_date_ymd(`date_ymd`) values('2022-10-04');
insert into t_date_ymd(`date_ymd`) values('2022-10-03');
insert into t_date_ymd(`date_ymd`) values('2022-10-02');
insert into t_date_ymd(`date_ymd`) values('2022-10-01');
insert into t_date_ymd(`date_ymd`) values('2022-09-30');
insert into t_date_ymd(`date_ymd`) values('2022-09-29');
insert into t_date_ymd(`date_ymd`) values('2022-09-28');
insert into t_date_ymd(`date_ymd`) values('2022-09-27');
insert into t_date_ymd(`date_ymd`) values('2022-09-26');
insert into t_date_ymd(`date_ymd`) values('2022-09-25');
insert into t_date_ymd(`date_ymd`) values('2022-09-24');
insert into t_date_ymd(`date_ymd`) values('2022-09-23');
insert into t_date_ymd(`date_ymd`) values('2022-09-22');
insert into t_date_ymd(`date_ymd`) values('2022-09-21');
insert into t_date_ymd(`date_ymd`) values('2022-09-20');
insert into t_date_ymd(`date_ymd`) values('2022-09-19');
insert into t_date_ymd(`date_ymd`) values('2022-09-18');
insert into t_date_ymd(`date_ymd`) values('2022-09-17');
insert into t_date_ymd(`date_ymd`) values('2022-09-16');
insert into t_date_ymd(`date_ymd`) values('2022-09-15');
insert into t_date_ymd(`date_ymd`) values('2022-09-14');
insert into t_date_ymd(`date_ymd`) values('2022-09-13');
insert into t_date_ymd(`date_ymd`) values('2022-09-12');
insert into t_date_ymd(`date_ymd`) values('2022-09-11');
insert into t_date_ymd(`date_ymd`) values('2022-09-10');
insert into t_date_ymd(`date_ymd`) values('2022-09-09');
insert into t_date_ymd(`date_ymd`) values('2022-09-08');
insert into t_date_ymd(`date_ymd`) values('2022-09-07');
insert into t_date_ymd(`date_ymd`) values('2022-09-06');
insert into t_date_ymd(`date_ymd`) values('2022-09-05');
insert into t_date_ymd(`date_ymd`) values('2022-09-04');
insert into t_date_ymd(`date_ymd`) values('2022-09-03');
insert into t_date_ymd(`date_ymd`) values('2022-09-02');
insert into t_date_ymd(`date_ymd`) values('2022-09-01');
insert into t_date_ymd(`date_ymd`) values('2022-08-31');
insert into t_date_ymd(`date_ymd`) values('2022-08-30');
insert into t_date_ymd(`date_ymd`) values('2022-08-29');
insert into t_date_ymd(`date_ymd`) values('2022-08-28');
insert into t_date_ymd(`date_ymd`) values('2022-08-27');
insert into t_date_ymd(`date_ymd`) values('2022-08-26');
insert into t_date_ymd(`date_ymd`) values('2022-08-25');
insert into t_date_ymd(`date_ymd`) values('2022-08-24');
insert into t_date_ymd(`date_ymd`) values('2022-08-23');
insert into t_date_ymd(`date_ymd`) values('2022-08-22');
insert into t_date_ymd(`date_ymd`) values('2022-08-21');
insert into t_date_ymd(`date_ymd`) values('2022-08-20');
insert into t_date_ymd(`date_ymd`) values('2022-08-19');
insert into t_date_ymd(`date_ymd`) values('2022-08-18');
insert into t_date_ymd(`date_ymd`) values('2022-08-17');
insert into t_date_ymd(`date_ymd`) values('2022-08-16');
insert into t_date_ymd(`date_ymd`) values('2022-08-15');
insert into t_date_ymd(`date_ymd`) values('2022-08-14');
insert into t_date_ymd(`date_ymd`) values('2022-08-13');
insert into t_date_ymd(`date_ymd`) values('2022-08-12');
insert into t_date_ymd(`date_ymd`) values('2022-08-11');
insert into t_date_ymd(`date_ymd`) values('2022-08-10');
insert into t_date_ymd(`date_ymd`) values('2022-08-09');
insert into t_date_ymd(`date_ymd`) values('2022-08-08');
insert into t_date_ymd(`date_ymd`) values('2022-08-07');
insert into t_date_ymd(`date_ymd`) values('2022-08-06');
insert into t_date_ymd(`date_ymd`) values('2022-08-05');
insert into t_date_ymd(`date_ymd`) values('2022-08-04');
insert into t_date_ymd(`date_ymd`) values('2022-08-03');
insert into t_date_ymd(`date_ymd`) values('2022-08-02');
insert into t_date_ymd(`date_ymd`) values('2022-08-01');
insert into t_date_ymd(`date_ymd`) values('2022-07-31');
insert into t_date_ymd(`date_ymd`) values('2022-07-30');
insert into t_date_ymd(`date_ymd`) values('2022-07-29');
insert into t_date_ymd(`date_ymd`) values('2022-07-28');
insert into t_date_ymd(`date_ymd`) values('2022-07-27');
insert into t_date_ymd(`date_ymd`) values('2022-07-26');
insert into t_date_ymd(`date_ymd`) values('2022-07-25');
insert into t_date_ymd(`date_ymd`) values('2022-07-24');
insert into t_date_ymd(`date_ymd`) values('2022-07-23');
insert into t_date_ymd(`date_ymd`) values('2022-07-22');
insert into t_date_ymd(`date_ymd`) values('2022-07-21');
insert into t_date_ymd(`date_ymd`) values('2022-07-20');
insert into t_date_ymd(`date_ymd`) values('2022-07-19');
insert into t_date_ymd(`date_ymd`) values('2022-07-18');
insert into t_date_ymd(`date_ymd`) values('2022-07-17');
insert into t_date_ymd(`date_ymd`) values('2022-07-16');
insert into t_date_ymd(`date_ymd`) values('2022-07-15');
insert into t_date_ymd(`date_ymd`) values('2022-07-14');
insert into t_date_ymd(`date_ymd`) values('2022-07-13');
insert into t_date_ymd(`date_ymd`) values('2022-07-12');
insert into t_date_ymd(`date_ymd`) values('2022-07-11');
insert into t_date_ymd(`date_ymd`) values('2022-07-10');
insert into t_date_ymd(`date_ymd`) values('2022-07-09');
insert into t_date_ymd(`date_ymd`) values('2022-07-08');
insert into t_date_ymd(`date_ymd`) values('2022-07-07');
insert into t_date_ymd(`date_ymd`) values('2022-07-06');
insert into t_date_ymd(`date_ymd`) values('2022-07-05');
insert into t_date_ymd(`date_ymd`) values('2022-07-04');
insert into t_date_ymd(`date_ymd`) values('2022-07-03');
insert into t_date_ymd(`date_ymd`) values('2022-07-02');
insert into t_date_ymd(`date_ymd`) values('2022-07-01');
insert into t_date_ymd(`date_ymd`) values('2022-06-30');
insert into t_date_ymd(`date_ymd`) values('2022-06-29');
insert into t_date_ymd(`date_ymd`) values('2022-06-28');
insert into t_date_ymd(`date_ymd`) values('2022-06-27');
insert into t_date_ymd(`date_ymd`) values('2022-06-26');
insert into t_date_ymd(`date_ymd`) values('2022-06-25');
insert into t_date_ymd(`date_ymd`) values('2022-06-24');
insert into t_date_ymd(`date_ymd`) values('2022-06-23');
insert into t_date_ymd(`date_ymd`) values('2022-06-22');
insert into t_date_ymd(`date_ymd`) values('2022-06-21');
insert into t_date_ymd(`date_ymd`) values('2022-06-20');
insert into t_date_ymd(`date_ymd`) values('2022-06-19');
insert into t_date_ymd(`date_ymd`) values('2022-06-18');
insert into t_date_ymd(`date_ymd`) values('2022-06-17');
insert into t_date_ymd(`date_ymd`) values('2022-06-16');
insert into t_date_ymd(`date_ymd`) values('2022-06-15');
insert into t_date_ymd(`date_ymd`) values('2022-06-14');
insert into t_date_ymd(`date_ymd`) values('2022-06-13');
insert into t_date_ymd(`date_ymd`) values('2022-06-12');
insert into t_date_ymd(`date_ymd`) values('2022-06-11');
insert into t_date_ymd(`date_ymd`) values('2022-06-10');
insert into t_date_ymd(`date_ymd`) values('2022-06-09');
insert into t_date_ymd(`date_ymd`) values('2022-06-08');
insert into t_date_ymd(`date_ymd`) values('2022-06-07');
insert into t_date_ymd(`date_ymd`) values('2022-06-06');
insert into t_date_ymd(`date_ymd`) values('2022-06-05');
insert into t_date_ymd(`date_ymd`) values('2022-06-04');
insert into t_date_ymd(`date_ymd`) values('2022-06-03');
insert into t_date_ymd(`date_ymd`) values('2022-06-02');
insert into t_date_ymd(`date_ymd`) values('2022-06-01');
insert into t_date_ymd(`date_ymd`) values('2022-05-31');
insert into t_date_ymd(`date_ymd`) values('2022-05-30');
insert into t_date_ymd(`date_ymd`) values('2022-05-29');
insert into t_date_ymd(`date_ymd`) values('2022-05-28');
insert into t_date_ymd(`date_ymd`) values('2022-05-27');
insert into t_date_ymd(`date_ymd`) values('2022-05-26');
insert into t_date_ymd(`date_ymd`) values('2022-05-25');
insert into t_date_ymd(`date_ymd`) values('2022-05-24');
insert into t_date_ymd(`date_ymd`) values('2022-05-23');
insert into t_date_ymd(`date_ymd`) values('2022-05-22');
insert into t_date_ymd(`date_ymd`) values('2022-05-21');
insert into t_date_ymd(`date_ymd`) values('2022-05-20');
insert into t_date_ymd(`date_ymd`) values('2022-05-19');
insert into t_date_ymd(`date_ymd`) values('2022-05-18');
insert into t_date_ymd(`date_ymd`) values('2022-05-17');
insert into t_date_ymd(`date_ymd`) values('2022-05-16');
insert into t_date_ymd(`date_ymd`) values('2022-05-15');
insert into t_date_ymd(`date_ymd`) values('2022-05-14');
insert into t_date_ymd(`date_ymd`) values('2022-05-13');
insert into t_date_ymd(`date_ymd`) values('2022-05-12');
insert into t_date_ymd(`date_ymd`) values('2022-05-11');
insert into t_date_ymd(`date_ymd`) values('2022-05-10');
insert into t_date_ymd(`date_ymd`) values('2022-05-09');
insert into t_date_ymd(`date_ymd`) values('2022-05-08');
insert into t_date_ymd(`date_ymd`) values('2022-05-07');
insert into t_date_ymd(`date_ymd`) values('2022-05-06');
insert into t_date_ymd(`date_ymd`) values('2022-05-05');
insert into t_date_ymd(`date_ymd`) values('2022-05-04');
insert into t_date_ymd(`date_ymd`) values('2022-05-03');
insert into t_date_ymd(`date_ymd`) values('2022-05-02');
insert into t_date_ymd(`date_ymd`) values('2022-05-01');
insert into t_date_ymd(`date_ymd`) values('2022-04-30');
insert into t_date_ymd(`date_ymd`) values('2022-04-29');
insert into t_date_ymd(`date_ymd`) values('2022-04-28');
insert into t_date_ymd(`date_ymd`) values('2022-04-27');
insert into t_date_ymd(`date_ymd`) values('2022-04-26');
insert into t_date_ymd(`date_ymd`) values('2022-04-25');
insert into t_date_ymd(`date_ymd`) values('2022-04-24');
insert into t_date_ymd(`date_ymd`) values('2022-04-23');
insert into t_date_ymd(`date_ymd`) values('2022-04-22');
insert into t_date_ymd(`date_ymd`) values('2022-04-21');
insert into t_date_ymd(`date_ymd`) values('2022-04-20');
insert into t_date_ymd(`date_ymd`) values('2022-04-19');
insert into t_date_ymd(`date_ymd`) values('2022-04-18');
insert into t_date_ymd(`date_ymd`) values('2022-04-17');
insert into t_date_ymd(`date_ymd`) values('2022-04-16');
insert into t_date_ymd(`date_ymd`) values('2022-04-15');
insert into t_date_ymd(`date_ymd`) values('2022-04-14');
insert into t_date_ymd(`date_ymd`) values('2022-04-13');
insert into t_date_ymd(`date_ymd`) values('2022-04-12');
insert into t_date_ymd(`date_ymd`) values('2022-04-11');
insert into t_date_ymd(`date_ymd`) values('2022-04-10');
insert into t_date_ymd(`date_ymd`) values('2022-04-09');
insert into t_date_ymd(`date_ymd`) values('2022-04-08');
insert into t_date_ymd(`date_ymd`) values('2022-04-07');
insert into t_date_ymd(`date_ymd`) values('2022-04-06');
insert into t_date_ymd(`date_ymd`) values('2022-04-05');
insert into t_date_ymd(`date_ymd`) values('2022-04-04');
insert into t_date_ymd(`date_ymd`) values('2022-04-03');
insert into t_date_ymd(`date_ymd`) values('2022-04-02');
insert into t_date_ymd(`date_ymd`) values('2022-04-01');
insert into t_date_ymd(`date_ymd`) values('2022-03-31');
insert into t_date_ymd(`date_ymd`) values('2022-03-30');
insert into t_date_ymd(`date_ymd`) values('2022-03-29');
insert into t_date_ymd(`date_ymd`) values('2022-03-28');
insert into t_date_ymd(`date_ymd`) values('2022-03-27');
insert into t_date_ymd(`date_ymd`) values('2022-03-26');
insert into t_date_ymd(`date_ymd`) values('2022-03-25');
insert into t_date_ymd(`date_ymd`) values('2022-03-24');
insert into t_date_ymd(`date_ymd`) values('2022-03-23');
insert into t_date_ymd(`date_ymd`) values('2022-03-22');
insert into t_date_ymd(`date_ymd`) values('2022-03-21');
insert into t_date_ymd(`date_ymd`) values('2022-03-20');
insert into t_date_ymd(`date_ymd`) values('2022-03-19');
insert into t_date_ymd(`date_ymd`) values('2022-03-18');
insert into t_date_ymd(`date_ymd`) values('2022-03-17');
insert into t_date_ymd(`date_ymd`) values('2022-03-16');
insert into t_date_ymd(`date_ymd`) values('2022-03-15');
insert into t_date_ymd(`date_ymd`) values('2022-03-14');
insert into t_date_ymd(`date_ymd`) values('2022-03-13');
insert into t_date_ymd(`date_ymd`) values('2022-03-12');
insert into t_date_ymd(`date_ymd`) values('2022-03-11');
insert into t_date_ymd(`date_ymd`) values('2022-03-10');
insert into t_date_ymd(`date_ymd`) values('2022-03-09');
insert into t_date_ymd(`date_ymd`) values('2022-03-08');
insert into t_date_ymd(`date_ymd`) values('2022-03-07');
insert into t_date_ymd(`date_ymd`) values('2022-03-06');
insert into t_date_ymd(`date_ymd`) values('2022-03-05');
insert into t_date_ymd(`date_ymd`) values('2022-03-04');
insert into t_date_ymd(`date_ymd`) values('2022-03-03');
insert into t_date_ymd(`date_ymd`) values('2022-03-02');
insert into t_date_ymd(`date_ymd`) values('2022-03-01');