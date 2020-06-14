
0. 表结构和数据的初始化
1. 唯一索引范围非等值查询(不等号条件里的等值查询)--order by desc
	起点降级, 尾点延伸
2. 唯一索引范围非等值查询(不等号条件里的等值查询)--没有order by desc
	起点降级, 尾点正常	
3. 非唯一索引范围非等值查询(不等号条件里的等值查询)--order by desc
	起点降级, 尾点延伸
4. 非唯一索引范围非等值查询(不等号条件里的等值查询)--没有order by desc
	起点不降级, 尾点正常
5. 小结
	
	
0. 表结构和数据的初始化
	drop table t;
	CREATE TABLE `t` (
	  `id` int(11) NOT NULL,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB;
	insert into t values(0,0,0),(5,5,5),(10,10,10),(15,15,15),(20,20,20),(25,25,25);
	
	mysql> select * from t;
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
	
1. 唯一索引范围非等值查询(不等号条件里的等值查询)--order by desc
	起点降级, 尾点延伸
	
	select * from t where id>9 and id<12 order by id desc for update;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	| 10 |   10 |   10 |
	+----+------+------+
	1 row in set (0.00 sec)
	
	加锁范围: primary: gap lock: (10,15) + primary: next-key lock: (5,10] + primary: next-key lock: (0,5]
	
2. 唯一索引范围非等值查询(不等号条件里的等值查询)--没有order by desc
	起点降级, 尾点正常
	
	select * from t where id>9 and id<12 for update;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	| 10 |   10 |   10 |
	+----+------+------+
	1 row in set (0.00 sec)
	
	加锁范围: primary: next-key lock: (5,10] + primary: gap lock: (10,15)
	
	为什么这里不需要对 id=15 的记录加锁
		难道 id<12 使用的是等值查询吗
		
	1. 加锁基本单位是 next-key lock, id>9的加锁范围是: primary: next-key lock: (5,10]
	2. 范围查询,需要向右查找, 找到 id=15 的记录才会停止下来, id<12持有的锁: primary: next-key lock: (10,15]
	3. 主键/辅助索引非等值范围查询, 向右遍历, 最后一个值不满足条件的时候, next-key lock 会退化为间隙锁; 不再需要访问到不满足条件的第一个值为止, id<12持有的锁: primary: next-key lock: (10,15)

	
3. 非唯一索引范围非等值查询(不等号条件里的等值查询)--order by desc
	起点降级, 尾点延伸

	session A                           
	mysql> select * from t where c>9 and c<12 order by c desc for update;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	| 10 |   10 |   10 |
	+----+------+------+
	1 row in set (0.00 sec)
	
	加锁范围: c: gap lock: (10,15) + c: next-key lock: (5,10] + c: next-key lock: (0,5]
	
	
4. 非唯一索引范围非等值查询(不等号条件里的等值查询)--没有order by desc
	起点不降级, 尾点正常
	
	select * from t where c>9 and c<12 for update;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	| 10 |   10 |   10 |
	+----+------+------+
	1 row in set (0.00 sec)
	
	加锁范围: 加锁范围: c: next-key lock: (5,10] + c: next-key lock: (10, 15] + primary: record lock: [10]

5. 小结
	加锁规则一致: '1. 唯一索引范围非等值查询(不等号条件里的等值查询)--order by desc' 和 '3. 非唯一索引范围非等值查询(不等号条件里的等值查询)--order by desc'
	加锁规则不一致: '2. 唯一索引范围非等值查询(不等号条件里的等值查询)--没有order by desc' 和 '4. 非唯一索引范围非等值查询(不等号条件里的等值查询)--没有order by desc'
	
	主键索引和辅助索引有 order by desc, 加锁规则一致
	主键索引和辅助索引在没有 order by desc, 加锁规则不一致
	

'


	