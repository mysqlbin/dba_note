


select curdate(); -- 当前日期
select day(curdate())+1; --当前日期只取天数再加1天

--DATE_ADD() 函数向日期添加指定的时间间隔。


select date_add(curdate(),interval 1 month);  --当前日期加1个月

select curdate(); -- 当前日期
select day(curdate())+1;
select curdate() - day(curdate())+1;  -- 20200501

select date_add(curdate()-day(curdate())+1, interval 1 month);  --获取下个月第1天的日期



select curdate();                       -- 获取当前日期
select last_day(curdate());                    -- 获取当月最后一天。

select last_day(date_add(curdate(),interval 1 month)); --获取下个月最后一天的日期


1.给当前日期减一天
 SELECT DATE_FORMAT(DATE_SUB(NOW(),INTERVAL 1 DAY),'%Y-%m-%d');
2.给当前日期加一天
 SELECT DATE_FORMAT(DATE_ADD(NOW(),INTERVAL 1 DAY),'%Y-%m-%d');

 
SELECT (DATEDIFF('2021-06-23','1970-01-01'));


SELECT (DATEDIFF('2020-08-17','2020-05-26'));  = 83，还没有到90天的数据，所以没有做数据的删除操作。
 
 


DATE_ADD(curdate(),interval -day(curdate())+1 day);  -- 获取本月第一天