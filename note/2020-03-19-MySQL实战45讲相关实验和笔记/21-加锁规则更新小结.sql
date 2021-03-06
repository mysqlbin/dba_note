


1. RR隔离级别加锁规则：
    两个“原则”、两个“优化”和一个“bug”（作为分析加锁的步骤）： By 丁奇
    2.1 两个基本原则：
         a). 原则 1：加锁的基本单位是 next-key lock
             next-key lock是分两步/段加锁，先加gap lock，再加record lock。                         
             next-key lock 是前开后闭区间（5, 10]。
           
         b). 原则 2：普通索引查找(唯一索引查找，不需要向右遍历吗)，要向右遍历, 遍历过程中被访问到的对象才会加锁(查找过程中访问到的对象才会加锁。)
                            范围查询， 也需要向右遍历，直到找到不满足条件的第一个值为止
    2.2 索引上等值查询的两个优化(锁的退化)：
         c). 优化 1：索引上的等值查询，给唯一索引加锁的时候，next-key lock退化为行锁。                               
                   id=10 for update,  next-key lock：(5, 10]， 退化为行锁：record lock：id=10 即 [10]
				                             
         d). 优化 2：索引上的等值查询，向右遍历时且如果最后一个值不满足等值条件的时候，next-key lock 会退化为间隙锁。  # 理解了。
                   id=7 for update,  next-key lock：(5, 10]， 退化为间隙锁：gap lock：(5, 10)  
				   c=10 for update,  next-key lock：(5, 10] +  (10, 15] 退化为间隙锁：next-key lock：(5, 10] + gap lock：(10, 15)     
    2.3 一个bug：
         e). 一个 bug：唯一索引上的范围查询，会访问到不满足条件的第一个值为止。
            8.0.18 以上的版已经把该 bug 优化掉了。

    通过实验和自己的理解，自己也可以对加锁规则进行补充。    
		next-key lock：普通辅助索引持有或者唯一索引的范围查询持有 
		record Lock  ：主键索引和唯一辅助索引的等值查询且记录存在的时候持有，原因：因为值是唯一的，所以访问到记录之后就会停止下来。
		gap lock：主键索引和唯一辅助索引的等值查询且记录不存在的时候持有
		
		next-key lock：先加gap lock，再加record lock; 分为两步进行加锁。
		
		当对二级索引的记录加锁，先锁二级索引的记录，再锁主键索引的记录; 如果二级索引的记录被锁住，导致不能回到主键索引进行加锁。
	
2. 8.0.18 的优化: 
    1. 主键索引非等值范围查询, 向右遍历, 最后一个值不满足条件的时候, next-key lock 会退化为间隙锁; 不再需要访问到不满足条件的第一个值为止。
        参考案例: 
        4.1.2 主键索引范围锁                                                                                             
        '4.1.4 唯一索引范围非等值查询(不等号条件里的等值查询)--没有order by desc' 或者 '2. 唯一索引范围非等值查询(不等号条件里的等值查询)--没有order by desc'

    2. 优化了一个 bug：唯一索引上的范围查询，不再需要访问到不满足条件的第一个值为止。
        参考案例: 4.1.3 优化了唯一索引范围 bug

3. order by desc 在 5.7版本 和 MySQL8.0.19之前的版本都存在尾点延伸

4. 辅助索引 c<=20 加锁扩大 

5. 通过实验更新加锁规则.
	做实验, 发现规律
	第一次定位属于等值查询?
	唯一索引/普通索引各自的加锁规则:
        等值
        范围
    order by desc 


6. 
	lock_mode X waiting                 表示next-key lock；
	lock_mode X locks rec but not gap   是只有行锁；
	locks gap before rec                就是只有间隙锁；
	
	
	
7. 

	唯一索引、非唯一索引在等值查询和范围查询中，加锁规则也是不一样的。


	