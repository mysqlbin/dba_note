

对于 Infimum 记录是不加锁的，对于 Supremum 记录加next-key锁（在隔离级别不小于REPEATABLE READ并且也没有开启innodb_locks_unsafe_for_binlog系统变量的情况下
	其实由于 Supremum 记录本身是一条伪记录，别的事务并不会更新或删除它，所以给它添加next-key锁起到的效果和给它添加gap锁是一样的。

InnoDB每当读取一条记录时，都会调用一次 row_search_mvcc，之后继续向InnoDB要下一条记录，也就是需要继续执行一遍row_search_mvcc函数了。


先加gap lock，再加记录锁。
	参考源码
	4.2.5 非唯一索引上等值查询-Gap lock死锁
	