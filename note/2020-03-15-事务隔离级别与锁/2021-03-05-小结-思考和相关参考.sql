

1. 模拟死锁需要的信息（作为分析流程） 	
2. 总结
3. 根据理论/实验的总结
4. MySQL 5.7版本死锁日志分成三部分
5. MySQL 8.0版本死锁日志分成三部分
6. 锁的优化
7. 思考
8. 案例和相关参考 
9. 分析死锁的基本能力

1. 模拟死锁需要的信息（作为分析流程） 
	-- 重点分析对象： 死锁信息都是有据可依的。
	
    1. 当前的事务隔离级别：
        RC读已提交隔离级别就排除了gap lock造成的死锁。
    
    2. 通过事务ID可以看到事务执行的先后顺序：
        并不是看死锁日志里面的 (1) TRANSACTION 或者 (2) TRANSACTION 判断事务执行的先后顺序。

    3. 搞懂 持有什么锁，需要申请什么锁对应的SQL：
        WAITING FOR THIS LOCK TO BE GRANTED 对应的SQL
        HOLDS THE LOCK(S)对应的SQL

    4. 锁的是什么索引、索引信息对应的SQL
        index PRIMARY of table `test_db`.`t`

    5. 同一个事务的 HOLDS THE LOCK(S) 和 WAITING FOR THIS LOCK TO BE GRANTED 并不是同一条SQL。
    
    6. 要知道相关表的DDL表结构
    
    7. 死锁日志记录的两个SQL是处于锁等待状态的。  --自己的总结
		由于死锁日志仅记录了最后引起死锁的两条SQL，因此并不能通过死锁日志立即定位
	
	
2. 总结

	总结得可以
	
    1. RR隔离级别下，insert 语句需要申请 gap lock.
		这个理解不对。
    2. 
        2.1 必须要了解索引的数据结构， 比如InnoDB的主键索引和普通（二级）索引，这样才能分析主键索引跟普通索引之间的加锁规则。
        2.2 InnoDB通过遍历索引记录来加锁：
            主键索引加锁跟主键索引对应的二级索引没有关系。
            二级索引加锁跟二级索引对应的主键索引也会加锁，声明：如果通过二级索引查询能用到覆盖索引，加锁模式是共享锁，这样二级索引对应的主键索引就不会加锁。

    3. 同一个事务的 HOLDS THE LOCK(S) 和 WAITING FOR THIS LOCK TO BE GRANTED 并不是同一条SQL。
        WAITING FOR THIS LOCK TO BE GRANTED 对应的SQL语句就是 死锁日志中的SQL语句。

    4. 死锁日志的关键信息:
         计算死锁的两个事务ID的差值
         row lock(s)
		 
    5. 对于锁的学习， 不是靠背和记，要理解。 积累到达一定阶段了就能分析出来了。 加油。
	
    6. 死锁, 对于 MySQL 来说, 是一件 习以为常的事情， 有很多原因导致了MySQL的死锁率很高, 包括隔离级别, GAP锁, 事务内SQL语句的顺序, 业务逻辑等。
	
    7. 通过事务ID可以看到事务执行的先后顺序，根据事务ID模拟事务死锁的先后顺序。 
	
    8. HOLDS THE LOCK(S) 是已经执行通过的，但是事务没有提交，所以已经持有了锁。

	9. next-key lock = gap lock + record lock （前开后闭）
	
	10. 
		lock_mode X waiting                 表示next-key lock；
		lock_mode X locks rec but not gap   是只有行锁；
		locks gap before rec                就是只有间隙锁；
	
	
3. 根据理论/实验的总结

	1. 访问到记录都会加锁
	2. RC隔离级别下不需要的锁就会释放掉
	3. RR隔离级别下的锁升级、RC隔离级别下的锁退化。
	4. 务实基础。
	5. 业务的更新语句少用范围更新。
	6. 有时候重复看自己做的实验和分析，会有不一样的理解。


4. MySQL 5.7版本死锁日志分成三部分
	
	1. (1) TRANSACTION，是第一个事务的信息；
		显示了在等待的锁
	2. (2) TRANSACTION，是第二个事务的信息；
		显示了持有的锁；
		在等待的锁；
	3.  WE ROLL BACK TRANSACTION (2)，是最终的处理结果，表示回滚了第二个事务。

    4. 5.7 版本分析死锁日志的核心点：
         第1个事务只记录了在等待的锁
         第2个事务记录了持有的锁和在等待的锁
         根据第2个事务在等待的锁就可以推导出第1个事务持有的锁。
	
	
5. MySQL 8.0版本死锁日志分成三部分
	1. (1) TRANSACTION，是第一个事务的信息；
		持有的锁。
		显示了在等待的锁
	2. (2) TRANSACTION，是第二个事务的信息；
		显示了持有的锁；
		在等待的锁；
	3.  WE ROLL BACK TRANSACTION (2)，是最终的处理结果，表示回滚了第二个事务。	


	
6. 锁的优化
    1. 锁是加在索引上面的，所以要正确使用索引， 减少加锁范围；
    2. 死锁是在锁等待的基础上发生的， 所以事务要尽快提交，减少锁等待的发生；
    3. 大事务要拆分成小事务， 减少加锁范围和减少锁等待的发生。
    4. 由于锁是一个个加的，要避免死锁，对同一组资源，要按照尽量相同的顺序访问；


7. 思考

	1. 死锁的检测条件：
		是发现 wait-for graph（等待图） 就马上抛出死锁吗
		答： 是的。
	2. 这里暂时不理解：
		在读提交隔离级别下还有一个优化，即：语句执行过程中加上的行锁，在语句执行完成后，就要把“不满足条件的行”上的行锁直接释放了，不需要等到事务提交。 
		当扫描到一行记录后发现不匹配就会把锁给释放，当然这个违背了 2PL 原则在事务提交的时候释放。
		-- 理解了。  
	3. 现在看锁的例子，查询条件的值都是基于数字， 如果是查询条件的值是字母或者中文呢？ 加锁规则是怎么样的呢？
		一样的，索引都是有序的。
		
	4. 主键索引是否有间隙锁
		看情况而定， 如果是 主键索引是范围查询那么就有。
		如果主键索引记录不存在，就会加间隙锁。

	5. 一个全表扫描的SQL在执行期间刚好有数据写入，这时候又有一个关于这个表的查询

	6. 同一个表之间的事务可以发生死锁， 不同表之间的事务也可以发生死锁。

	7. MySQL 自增ID 字段指定了具体的值是否还会需要申请自增锁?
		答：需要的。
	
	
	8. RC 隔离级别的加锁单位也是 next-key lock 吗
		行锁。
		
	9. ICP 对应加锁的影响

	10. 原地更新是怎么加锁的？
		加锁规则是跟非原地更新一样。
	
	11. 范围更新的执行计划
		CREATE TABLE `t2` (
		  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
		  `t1` int(10) NOT NULL,
		  `t2` int(10) NOT NULL,
		  `order_no` varchar(64) NOT NULL DEFAULT '' COMMENT 'order no',
		  `status` int(10) NOT NULL COMMENT '状态',
		  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  PRIMARY KEY (`ID`),
		  KEY `idx_order_no` (`order_no`),
		  KEY `idx_status_createtime` (`status`,`createtime`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


		mysql> desc UPDATE t2 SET `status` = 5 WHERE `status` = 0 AND (createtime BETWEEN DATE_SUB(NOW(),INTERVAL 90 MINUTE)  AND DATE_SUB(NOW(),INTERVAL 60 MINUTE));
		+----+-------------+-------+------------+-------+-----------------------+-----------------------+---------+-------------+------+----------+------------------------------+
		| id | select_type | table | partitions | type  | possible_keys         | key                   | key_len | ref         | rows | filtered | Extra                        |
		+----+-------------+-------+------------+-------+-----------------------+-----------------------+---------+-------------+------+----------+------------------------------+
		|  1 | UPDATE      | t2    | NULL       | range | idx_status_createtime | idx_status_createtime | 8       | const,const |    1 |   100.00 | Using where; Using temporary |
		+----+-------------+-------+------------+-------+-----------------------+-----------------------+---------+-------------+------+----------+------------------------------+
		1 row in set (0.01 sec)



		范围更新需要临时表做辅助。
		更新语句：先查询出来，再更新；意味着查询出来的数据会先放在临时表中做辅助更新。


	
8. 案例和相关参考 
	
	https://mp.weixin.qq.com/s/K7wh609YJaYQ64QI-URqLQ    （解决线上数据库死锁，就是这么简单！）  
	https://mp.weixin.qq.com/s/lqGIthMTG95Aq9EFbqBcmA     (从一次诡异的MySQL死锁故障看数据库锁机制真相)
	https://mp.weixin.qq.com/s/rVkzH7bO911OFW2nEpZOuA    (记录一次 Mysql 死锁排查过程)
	https://www.cnblogs.com/LBSer/p/5183300.html                  （MySQL死锁问题分析）
	https://sq.163yun.com/blog/article/192340721236127744   （MySQL innoDB 间隙锁产生的死锁问题 --记一次死锁血案）	
		
		
	https://mp.weixin.qq.com/s/8XXimj2AIsRWj0fF-_iz3g    如何阅读死锁日志)
	https://www.cnblogs.com/CQqfjy/p/12703029.html       手把手教你分析Mysql死锁问题
	http://hedengcheng.com/?p=771#_Toc374698321
	https://www.cnblogs.com/LBSer/p/5183300.html         mysql死锁问题分析
	http://blog.itpub.net/7728585/viewspace-2146183/     Innodb:RR隔离级别下insert...select 对select表加锁模型和死锁案列
		
		分析死锁一般要从死锁日志中获取如下信息

		1、加锁发生在主键还是辅助索引
		2、加锁的模式是什么
		3、是单行还是多行加锁
		4、触发死锁事务最后的语句
		5、死锁信息中事务顺序是怎么样的
		在重现的时候，必须要做到和线上死锁信息完全匹配那么这个死锁场景才叫测试成功了.


9. 分析死锁的基本能力
	1. 索引
	2. 语句的执行计划
	3. RC和RR隔离级别的加锁规则
	