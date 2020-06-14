


CREATE TABLE `t` (
  `id` int(11) NOT NULL,
  `c` int(11) DEFAULT NULL,
  `d` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `c` (`c`)
) ENGINE=InnoDB;

insert into t values(0,0,0),(5,5,5),
(10,10,10),(15,15,15),(20,20,20),(25,25,25);

NOWAIT：
	表示无法获取到锁时直接返回错误，不用等待 innodb_lock_wait_timeout 的时间，再返回报错。
	这个特性是指在应用程序查询过程中，发现有锁等待会立即返回信息。
	可以参考下前面的示例，如果应用程序的要求是不等待锁定被释放或超时，则使用NOWAIT是完美的解决方案。 
	（在会话中设置innodb_lock_wait_timeout = 1也具有类似的效果）
	
SKIP LOCKED: 
		表示忽略那些已经被其他session占有行锁的记录。
		SKIP LOCKED要求MySQL跳过锁定的行并根据where子句处理剩余的行。

NOWAIT 实践:
	session 1 
													session 2

	begin;
	select * from t where c=5 for update;
													begin;
													select * from t where c=5 for update nowait;
													ERROR 3572 (HY000): Statement aborted because lock(s) could not be acquired immediately and NOWAIT is set.

	commit;


SKIP LOCKED 实践:
	session 1 
													session 2

	begin;
	select * from t where c=5 for update;
	
													begin;
													select * from t for update SKIP LOCKED;
													+----+------+------+
													| id | c    | d    |
													+----+------+------+
													|  0 |    0 |    0 |
													| 10 |   10 |   10 |
													| 15 |   15 |   15 |
													| 20 |   20 |   20 |
													| 25 |   25 |   25 |
													+----+------+------+
													5 rows in set (0.00 sec)

	commit;

													select * from t for update SKIP LOCKED;
													+----+------+------+
													| id | c    | d    |
													+----+------+------+
													|  0 |    0 |    0 |
													|  5 |    5 |    5 |
													| 10 |   10 |   10 |
													| 15 |   15 |   15 |
													| 20 |   20 |   20 |
													| 25 |   25 |   25 |
													+----+------+------+
													6 rows in set (0.00 sec)

	

相关参考:
	https://mp.weixin.qq.com/s/Z-i_wT8vJzA3fQj5VQDnfQ     MySQL8.0 NOWAIT和SKIP LOCKED新特性 
	https://yq.aliyun.com/articles/159602/                MySQL8.0新特性随笔： NOWAIT以及SKIP LOCKED
