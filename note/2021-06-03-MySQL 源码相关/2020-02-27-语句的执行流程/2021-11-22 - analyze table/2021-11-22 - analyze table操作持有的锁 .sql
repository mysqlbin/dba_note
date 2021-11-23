




MDL读锁

在analyze table的过程中会持有InnoDB 表的 read only 锁， 因此会存在短暂的阻塞用户写入更新删除（DML）的操作。 

除此之外analyze table 要把table 从 table definition cache 刷出来， 因此还会需要一个 flush lock(flush 关闭表)， 此时如果有长事务使用了这张表， 那么必须等待长事务结束。



