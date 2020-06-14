Transactions deadlock detected, dumping detailed information.
2019-03-19T21:44:23.516263+08:00 5877341 [Note] InnoDB: 

*** (1) TRANSACTION:
TRANSACTION 173268495, ACTIVE 0 sec fetching rows
mysql tables in use 1, locked 1
LOCK WAIT 304 lock struct(s), heap size 41168, 6 row lock(s), undo log entries 1
MySQL thread id 5877358, OS thread handle 47356539049728, query id 557970181 11.183.244.150 fin_instant_app updating

update `fund_transfer_stream` set `gmt_modified` = NOW(), `state` = 'PROCESSING' where ((`state` = 'NEW') AND (`seller_id` = '38921111') AND (`fund_transfer_order_no` = '99010015000805619031958363857'))
2019-03-19T21:44:23.516321+08:00 5877341 [Note] InnoDB: 

*** (1) HOLDS THE LOCK(S):
RECORD LOCKS space id 173 page no 13726 n bits 248 index idx_seller_transNo of table `xxx`.`fund_transfer_stream` trx id 173268495 lock_mode X locks rec but not gap
Record lock, heap no 168 PHYSICAL RECORD: n_fields 3; compact format; info bits 0

2019-03-19T21:44:23.516565+08:00 5877341 [Note] InnoDB: 

*** (1) WAITING FOR THIS LOCK TO BE GRANTED:
RECORD LOCKS space id 173 page no 12416 n bits 128 index PRIMARY of table `xxx`.`fund_transfer_stream` trx id 173268495 lock_mode X locks rec but not gap waiting
Record lock, heap no 56 PHYSICAL RECORD: n_fields 17; compact format; info bits 0
2019-03-19T21:44:23.517793+08:00 5877341 [Note] InnoDB: 

*** (2) TRANSACTION:
TRANSACTION 173268500, ACTIVE 0 sec fetching rows, thread declared inside InnoDB 81
mysql tables in use 1, locked 1
302 lock struct(s), heap size 41168, 2 row lock(s), undo log entries 1
MySQL thread id 5877341, OS thread handle 47362313119488, query id 557970189 11.131.81.107 fin_instant_app updating

update `fund_transfer_stream` set `gmt_modified` = NOW(), `state` = 'PROCESSING' where ((`state` = 'NEW') AND (`seller_id` = '38921111') AND (`fund_transfer_order_no` = '99010015000805619031957477256'))
2019-03-19T21:44:23.517855+08:00 5877341 [Note] InnoDB: 

*** (2) HOLDS THE LOCK(S):
RECORD LOCKS space id 173 page no 12416 n bits 128 index PRIMARY of table `fin_instant_0003`.`fund_transfer_stream` trx id 173268500 lock_mode X locks rec but not gap
Record lock, heap no 56 PHYSICAL RECORD: n_fields 17; compact format; info bits 0

2019-03-19T21:44:23.519053+08:00 5877341 [Note] InnoDB: 

*** (2) WAITING FOR THIS LOCK TO BE GRANTED:
RECORD LOCKS space id 173 page no 13726 n bits 248 index idx_seller_transNo of table `fin_instant_0003`.`fund_transfer_stream` trx id 173268500 lock_mode X locks rec but not gap waiting
Record lock, heap no 168 PHYSICAL RECORD: n_fields 3; compact format; info bits 0

2019-03-19T21:44:23.519297+08:00 5877341 [Note] InnoDB: *** WE ROLL BACK TRANSACTION (2)


②事务 1，持有索引 idx_seller_transNo 的锁，在等待获取 PRIMARY 的锁。

③事务 2，持有 PRIMARY 的锁，在等待获取 idx_seller_transNo 的锁。

④因事务 1 和事务 2 之间发生循环等待，故发生死锁。


这个结果分成三部分：
	(1) TRANSACTION，是第一个事务的信息；
	(2) TRANSACTION，是第二个事务的信息；
	WE ROLL BACK TRANSACTION (2)，是最终的处理结果，表示回滚了第二个事务。
	
	
第一个事务的信息中：
	WAITING FOR THIS LOCK TO BE GRANTED，表示的是这个事务在等待的锁信息；
	index c of table `test`.`t`，说明在等的是表 t 的索引 c 上面的锁；
	lock mode S waiting 表示这个语句要自己加一个读锁，当前的状态是等待中；
	Record lock 说明这是一个记录锁；
	n_fields 2 表示这个记录是两列，也就是字段 c 和主键字段 id；
	0: len 4; hex 0000000a; asc ;; 是第一个字段，也就是 c。值是十六进制 a，也就是 10；
	1: len 4; hex 0000000a; asc ;; 是第二个字段，也就是主键 id，值也是 10；
	这两行里面的 asc 表示的是，接下来要打印出值里面的“可打印字符”，但 10 不是可打印字符，因此就显示空格。
	第一个事务信息就只显示出了等锁的状态，在等待 (c=10,id=10) 这一行的锁。
	当然你是知道的，既然出现死锁了，就表示这个事务也占有别的锁，但是没有显示出来。别着急，我们从第二个事务的信息中推导出来。
	
第二个事务显示的信息要多一些：
	“HOLDS THE LOCK(S)”用来显示这个事务持有哪些锁；
	index c of table `test`.`t` 表示锁是在表 t 的索引 c 上；
	hex 0000000a 和 hex 00000014 表示这个事务持有 c=10 和 c=20 这两个记录锁；
	WAITING FOR THIS LOCK TO BE GRANTED，表示在等 (c=5,id=5) 这个记录锁。
	
	
从上面这些信息中，我们就知道：
	“lock in share mode”的这条语句，持有 c=5 的记录锁，在等 c=10 的锁；
    “for update”这个语句，持有 c=20 和 c=10 的记录锁，在等 c=5 的记录锁。

因此导致了死锁。这里，我们可以得到两个结论：	
	由于锁是一个个加的，要避免死锁，对同一组资源，要按照尽量相同的顺序访问；
	在发生死锁的时刻，for update 这条语句占有的资源更多，回滚成本更大，所以 InnoDB 选择了回滚成本更小的 lock in share mode 语句，来回滚。

	
