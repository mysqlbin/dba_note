

在*NIX中，可以[ kill -STOP pid ]将指定pid的进程临时挂起，此后便可使用pcntl_wifstopped()检测其是否可以挂起停止，与之相反，便可用[ kill -CONT pid ]使之复活。

pstack $(pgrep -xn mysqld) > 2.log

kill -STOP $(pgrep -xn mysqld)
kill -cont $(pgrep -xn mysqld)

CREATE TABLE `test1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

truncate table test1;

MySQL                                                                                                      
																												Linux
select now();
																												date
																												kill -STOP $(pgrep -xn mysqld)
select 							
INSERT INTO `db1`.`test1` (`name`, `CreateTime`) VALUES ('8', now());
																												kill -cont $(pgrep -xn mysqld)

select * from test1;



[root@mgr9 shell]# time pstack $(pgrep -xn mysqld) > 2.sql

real	0m3.086s
user	0m2.960s
sys	0m0.116s

数据库正常状态的 pstack
	time pstack $(pgrep -xn mysqld) > 3.sql
	
	
perf top -p $(pgrep -xn mysqld)

