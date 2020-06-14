


REPEATABLE READ隔离级别下，不加锁，只在第一次执行普通的SELECT语句时生成一个ReadView，这样把脏读、不可重复读和幻读问题都解决了。
	
	只在第一次执行普通的SELECT语句时生成一个ReadView，这个是可以解决 脏读和不可重复读, 但是不可以解决幻读吧?
	
	
	
	
	
	
https://yq.aliyun.com/articles/422739  

	一个事务最多可以有两个undo slot
		一个是insert undo slot, 用来存储这个事务的insert undo，里面主要记录了主键的信息，方便在回滚的时候快速找到这一行。
		另外一个是update undo slot，用来存储这个事务delete/update产生的undo，里面详细记录了被修改之前每一列的信息，便于在读请求需要的时候构造。1024个undo slot构成了一个undo segment。

https://mp.weixin.qq.com/s/UxawgHGembMKK2lA33ZQDA  InnoDB MVCC 详解


	undo记录的主要类型如下，其中TRX_UNDO_INSERT_REC为insert的undo，其他为update和delete的undo。
	
	#define TRX_UNDO_INSERT_REC 11 /* fresh insert into clustered index */
	#define TRX_UNDO_UPD_EXIST_REC        \
	  12 /* update of a non-delete-marked \
		 record */
	#define TRX_UNDO_UPD_DEL_REC                \
	  13 /* update of a delete marked record to \
		 a not delete marked record; also the   \
		 fields of the record can change */
	#define TRX_UNDO_DEL_MARK_REC              \
	  14 /* delete marking of a record; fields \
		 do not change */
		 
	对于insert和delete，undo中会记录键值，delete操作只是标记删除(delete mark)记录。对于update，如果是原地更新，undo中会记录键值和老值。

	update如果是通过delete+insert方式进行的，则undo中记录键值，不需记录老值。其中delete也是标记删除记录。二级索引的更新总是delete+insert方式进行。具体日志格式参考trx_undo_report_row_operation。	 
	 

#define TRX_UNDO_UPD_DEL_REC                \
  13 /* update of a delete marked record to \
     a not delete marked record; also the   \
     fields of the record can change */

	update of a delete marked record to a not delete marked record; 
	also the  fields of the record can change

	将删除标记的记录更新为未删除标记的记录；
	记录的字段也可以更改