

create table t1(id int primary key, a int, b int, index(a));
create table t2 like t1;
drop procedure idata;
delimiter ;;
create procedure idata()
begin
  declare i int;
  set i=1;
  while(i<=1000)do
    insert into t1 values(i, 1001-i, i);
    set i=i+1;
  end while;
  
  set i=1;
  while(i<=1000000)do
    insert into t2 values(i, i, i);
    set i=i+1;
  end while;

end;;
delimiter ;
call idata();




CREATE TABLE `t1` (
 `id` int(11) NOT NULL,
 `a` int(11) DEFAULT NULL,
 `b` int(11) DEFAULT NULL,
 `c` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

create table t2 like t1;
create table t3 like t2;
insert into ... // 初始化三张表的数据

SQL语句: select * from t1 join t2 on(t1.a=t2.a) join t3 on (t2.b=t3.b) where t1.c>=X and t2.c>=Y and t3.c>=Z;
正常情况是这样建立索引的:
	t1
	   idx_c
	t2
	   idx_a
	t3
	   idx_b

	t1、t2、t3都可以用到索引：
	  t1.c>=X
	  t2.a被驱动列用到了索引
	  t3.b被驱动列用到了索引


如果把SQL语句改写成 straight_join，要怎么指定连接顺序，以及怎么给三个表创建索引。
 
第一原则是要尽量使用 BKA 算法。
	需要注意的是，使用 BKA 算法的时候，并不是“先计算两个表 join 的结果，再跟第三个表 join”，而是直接嵌套查询的。
	具体实现是：在 t1.c>=X、t2.c>=Y、t3.c>=Z 这三个条件里，选择一个经过过滤以后，数据最少的那个表，作为第一个驱动表。此时，可能会出现如下两种情况。

	第一种情况，如果选出来是表 t1 或者 t3，那剩下的部分就固定了。
		如果驱动表是 t1，则连接顺序是 t1->t2->t3，要在被驱动表字段创建上索引，也就是 t2.a 和 t3.b 上创建索引；
		如果驱动表是 t3，则连接顺序是 t3->t2->t1，需要在 t2.b 和 t1.a 上创建索引。
		同时，我们还需要在第一个驱动表的字段 c 上创建索引。
	

	第二种情况是，如果选出来的第一个驱动表是表 t2 的话，则需要评估另外两个条件的过滤效果。
	
	总之，整体的思路就是，尽量让每一次参与 join 的驱动表的数据集，越小越好，因为这样我们的驱动表就会越小。
	
	为什么选择驱动表越小越好
		因为驱动表越小，跟被驱动表关联的次数就越少, SQL语句执行速度也就更快.
		

MySQL5.6新特性之Batched Key Access		
	
1. 原理
	对于多表join语句，当MySQL使用索引访问第二个join表的时候，使用一个join buffer来收集第一个操作对象生成的相关列值。
	BKA构建好key后，批量传给引擎层做索引查找。key是通过MRR接口提交给引擎的. 这样，MRR使得查询更有效率。 
	大致的过程如下:
		1. BKA使用join buffer保存由join的第一个操作产生的符合条件的数据。
		2. 然后BKA算法构建key来访问被连接的表，并批量使用MRR接口提交keys到数据库存储引擎去查找查找。
		3. 提交keys之后，MRR使用最佳的方式来获取行并反馈给BKA .	
		# 体现了 BKA优化依赖于MRR优化.
		BKA将有序主建投递到存储引擎是通过 MRR 的接口的调用来实现的（DsMrr_impl::dsmrr_next），所以BKA 依赖 MRR，如果要使用BKA, MRR 是需要打开的，另外 batched_key_access 是默认关闭的，如果要使用，需要打开此选项。
		
	BKA使用join buffer size来确定buffer的大小，buffer越大，访问被join的表/内部表就越顺序即访问被join表的次数越少。
	MRR接口有2个应用场景：
		场景1：应用于传统的基于磁盘的存储引擎(innodb,myisam)，对于这些引擎join buffer中keys是一次性提交到MRR，MRR通过key找到rowid，通过rowid来获取数据
		场景2：应用于远程存储引擎(NDB)，来自join buffer上的部分key，从SQL NODE发送到DATA NODE，然后SQL NODE会收到通过相关关系匹配的行组合。
			然后使用这些行组合匹配出新行。然后在发送新key，直到发完为止。

2. BNL和BKA,MRR的关系
	BNL和BKA都是批量的提交一部分结果集给下一个被join的表(标记为T)，从而减少访问表T的次数，那么它们有什么区别呢？
		NBL和BKA的思想是类似的,详情见:《nest-loop-join官方手册》
		1. NBL比BKA出现的早，BKA直到5.6才出现，而NBL至少在5.1里面就存在。
		2. NBL主要用于当被join的表上无索引:
		Join buffering can be used when the join is of type ALL or index (in other words, when no possible keys can be used, and a full scan is done, of either the data or index rows, respectively)
		3. BKA主要是指在被join表上有索引可以利用，那么就在行提交给被join的表之前，对这些行按照索引字段进行排序，因此减少了随机IO，排序这才是两者最大的区别，但是如果被join的表没用	索引呢？那就使用NBL了。	

	上面原理环境提到讲了在BKA实现的过程中就是通过传递keys给MRR接口，本质上还是在MRR里面实现，下面这幅图则展示了它们之间的关系:

	
3. 如何使用
	要使用BKA，必须调整系统参数optimizer_switch的值，batched_key_access设置为on，因为BKA使用了MRR，因此也要打开MRR,但是基于成本优化MRR算法不是特别准确官方文档推荐关闭 
	mrr_cost_based，将其设置为off。
	set optimizer_switch='mrr=on,mrr_cost_based=off,batched_key_access=on'
	另外多表join语句 ，被join的表/非驱动表必须索引可用。
	
4.相关参考		
	http://blog.itpub.net/22664653/viewspace-1715511/   【MySQL】MySQL5.6新特性之Batched Key Access
	https://dev.mysql.com/doc/refman/5.6/en/bnl-bka-optimization.html  
	http://mysql.taobao.org/monthly/2016/01/04/       MySQL · 特性分析 · 优化器 MRR & BKA
	https://www.jianshu.com/p/abf354977d49            随笔：MySQL 普通3表join顺序

5. 未完成
	5.1 开启BKA和关闭BKA的 SQL语句的性能对比
	
  