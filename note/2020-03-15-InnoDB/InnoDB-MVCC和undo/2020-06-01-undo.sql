


undo log -> updo page -> 回滚段 -> ibdata或单独的undo tablespace

undo log是最小的粒度，所在的数据页称为undo page
undo日志保存在回滚段中，回滚段在ibdata或单独的undo tablespace中


回滚段: 
	可以理解为数据页的修改链表，链表最前面的是最老的一次修改，最后面的最新的一次修改，从链表尾部逆向操作可以恢复到数据最老的版本。
	用于撤销的单独段, MySQL在一个单独的区域中保存同一记录的多个版本。

	
undo 的作用：
	1. 保证事务的原子性
	2. 用于实现MVCC
	3. 用于数据的回滚操作
	
undo的回滚跟 binlog2sql 一样:
	delete -> insert
	insert -> delete
	update -> udpate
	Update = Delete Mark + Insert；


相关参考:
	https://www.colabug.com/1439181.html      InnoDB—UNDO日志与回滚
	https://blog.csdn.net/fly2nn/article/details/61924836   InnoDB---UNDO日志与回滚
	https://blog.csdn.net/yanzongshuai/article/details/71339336  innodb 回滚段内存结构
	https://mp.weixin.qq.com/s/R3yuitWpHHGWxsUcE0qIRQ         InnoDB并发如此高，原因竟然在这？
	https://mp.weixin.qq.com/s/7eTloNFM5AUZEfJlIpbWaA         一文快速搞懂MySQL InnoDB事务ACID实现原理
	https://www.cnblogs.com/xinysu/p/6555082.html#_lab2_0_0  （说说MySQL中的Redo log Undo log都在干啥）
    http://hedengcheng.com/?p=191 （InnoDB Rollback Segment & Undo Page Deallocation实现源码分析）
    http://mysql.taobao.org/monthly/2015/04/01/ （MySQL · 引擎特性 · InnoDB undo log 漫游）
    http://mysql.taobao.org/monthly/2016/07/01/            （undo空间管理，重点介绍truncate功能）
    https://www.jianshu.com/p/173eeebbabf0?utm_campaign=hugo&utm_medium=reader_share&utm_content=note&utm_source=weixin-friends  （Innodb undo之 undo物理结构的初始化）
	https://mp.weixin.qq.com/s/5ka2czU1dhwAWwH6Nm0bmg      MySQL 5.7新特性之在线收缩undo表空间
	https://yq.aliyun.com/articles/341036      MySQL8.0 · 引擎特性 · 关于undo表空间的一些新变化
	https://yq.aliyun.com/articles/689955?spm=a2c4e.11153940.0.0.50245440euT998       MySQL8.0 - 新特性 - 通过SQL管理UNDO TABLESPACE
	
	
回滚的原理:	

	对于insert操作，undo日志记录新数据的PK(ROW_ID)，回滚时直接删除；
	对于delete/update操作，undo日志记录旧数据row，回滚时直接恢复；
	他们分别存放在不同的buffer里。

	
	源码：
		#define TRX_UNDO_INSERT_REC 11 /* fresh insert into clustered index */
		
		
		#define TRX_UNDO_UPD_EXIST_REC        \
		  12 /* update of a non-delete-marked record */
		  
		#define TRX_UNDO_UPD_DEL_REC                \
		  13 /* update of a delete marked record to \
			 a not delete marked record; also the   \
			 fields of the record can change */
			 
			 将删除标记的记录更新为未删除标记的记录;

			 记录的字段也可以更改
			 
		#define TRX_UNDO_DEL_MARK_REC              \
		  14 /* delete marking of a record; fields \
			 do not change */
			 
			 删除记录的标记;字段不变
	
	undo记录的主要类型如下，其中 TRX_UNDO_INSERT_REC 为insert的undo，其他为update和delete的undo。
	
	总共3种 update undo 类型:
		TRX_UNDO_UPD_EXIST_REC: 
			标记删除操作, 未修改任何列值, 这既可能是普通的删除操作产生, 也可能是使用delete mark + insert 的更新导致(例如修改聚集索引键值)
			原地更新/非原地更新(先删除再插入)
		/*	
		TRX_UNDO_UPD_DEL_REC:    
			更新一个已被标记删除的记录, 列值可被修改;
			在 InnoDB里 这是允许的, 例如某个记录被删除后,再很快插入相同键值的记录, 之前的记录若还未被purge, 就可能重用该记录所在的位置
			先不看
		*/
			
		TRX_UNDO_DEL_MARK_REC:
			更新一个未被标识删除的记录(普通更新)	
			删除
			
	完成Undo log写入后，构建新的回滚段指针并返回（trx_undo_build_roll_ptr），回滚段指针包括undo log所在的回滚段id、日志所在的page no、以及page内的偏移量，需要记录到聚集索引记录中。
	
	对于insert和delete，undo中会记录键值，delete操作只是标记删除(delete mark)记录。
	
	对于update，如果是原地更新，undo中会记录键值和老值。
	
	update如果是通过delete+insert方式进行的，则undo中记录键值，不需记录老值; 其中delete也是标记删除记录。
	
	对于update操作有原地更新和delete+insert两种，那么怎么区分undo记录使用的哪种方式呢？
	 
		原地更新条件：更新没有改变值的长度且也没有更新行外数据，具体可参考 row_upd_changes_field_size_or_external
		
	
	二级索引的更新总是delete+insert方式进行。具体日志格式参考 trx_undo_report_row_operation 。

	undolog 是逻辑日志，也就是他不是记录的将物理的数据页恢复到之前的状态，而是记录的和原 sql 相反的 sql , 例如 insert 对应 delete , delete 对应 insert ，update 对应另外一个 update　。
	事务回滚很好理解，执行相反的操作回滚到之前的状态。
		(https://mp.weixin.qq.com/s/Wc6Gw6S5xMy2DhTCrogxVQ  通过MySQL存储原理来分析排序和锁)
		
	
	 
	事务回滚要做的操作: http://mysql.taobao.org/monthly/2015/04/01/
	
	  
		如果事务因为异常或者被显式的回滚了，那么所有数据变更都要改回去。这里就要借助回滚日志中的数据来进行恢复了。

		入口函数为：row_undo_step --> row_undo

		操作也比较简单，析取老版本记录，做逆向(反向)操作即可：
			对于标记删除的记录清理删除标记；
			对于in-place(原地)更新，将数据回滚到最老版本；
			对于插入操作，直接删除聚集索引和二级索引记录（row_undo_ins）。

		具体的操作中，先回滚二级索引记录（row_undo_mod_del_mark_sec、row_undo_mod_upd_exist_sec、row_undo_mod_upd_del_sec），再回滚聚集索引记录（row_undo_mod_clust）。

			
		
DML操作的回滚段样例	
	
	t(id PK, name);

	数据为：

	1, lujianbin

	2, zhangsan

	3, lisi	
	
	
	最新数据                                   		           回滚段(此时没有事务未提交，故回滚段是空的。)
	t(id PK, name);
	
	1, lujianbin

	2, zhangsan

	3, lisi	
	
	
	update原地更新:
		
		接着启动了一个事务,并且事务处于未提交的状态：	           回滚段			            
																  t(id PK, name);
		start transaction;
			 
		delete from t where id=1;                                 (1)           # 对于delete，undo中会记录键值
		
		update set  name = 'lili' where id=3;                     (3, 'lisi')   # 对于update，如果是原地更新，undo中会记录键值和老值；如果需要回滚，直接回滚到最老版本。
			
		insert into t(name) values('wangwu');                     (4)           # 对于insert，undo中会记录键值
		
		
		最新数据
		
		t(id PK, name);
		
		1, lujianbin

		2, zhangsan

		3, lisi	
		
		
	
	update通过 delete+insert 方式进行:
		
		
		接着启动了一个事务,并且事务处于未提交的状态：	           回滚段			            
																  t(id PK, name);
		start transaction;
			 
		update set  name = 'lilis' where id=3;                    (3)   
																  update如果是通过delete+insert方式进行的，则undo中记录键值，不需记录老值。
																  delete from where id=3; 
																  insert into t(id, name)  values(3,'lilis'); 
																  如果需要回滚，先把 insert into t(id, name)  values(3,'lilis'); 插入的记录直接删除，
																  再对 delete from where id=3; 的记录 清理删除标记，回滚完成。
	
		最新数据
		
		t(id PK, name);

		3, lilis	
		
	画图会更好理解。
	
	
purge:

	undo回收
		undo中保存老记录的历史版本, 当这些历史版本不再需要时，交由purge清理。
		
	删除记录
		事务提交后，仍然可能有标记删除的记录存在。这些记录在purge时真正删除, 释放物理页空间作为碎片/空间可以复用。 (没毛病)
	
	 	
	一条事务执行期间InnoDB对undo的处理:
	
		事务执行过程中: 写undo
		
			对于insert和delete，undo中会记录键值，delete操作只是标记删除(delete mark)记录。
			对于update，如果是(in-place)原地更新，undo中会记录键值和老值。
			update如果是通过delete+insert方式进行的，则undo中记录键值，不需记录老值; 其中delete也是标记删除记录。
			二级索引的更新总是delete+insert方式进行。具体日志格式参考trx_undo_report_row_operation。
			对于update操作有原地更新和delete+insert两种，那么怎么区分undo记录使用的哪种方式呢？
	 
				原地更新条件：更新没有改变值的长度且也没有更新行外数据，具体可参考 row_upd_changes_field_size_or_external

		事务提交过程中:
			会将undo信息加入purge列表(history list)，供purge线程处理。
		
		事务提交后:
			purge线程真正删除，释放物理页空间。
		
		事务提交后，会将undo日志信息(保存在trx_rseg_t中）加入到队列purge_queue中，purge_queue是以trx->id排序的最小堆。
			purge线程从purge_queue中获取符合条件（trx->id < oldest_view->m_low_limit_no)的undo并依次purge回收。
			https://mp.weixin.qq.com/s/UxawgHGembMKK2lA33ZQDA
			
	小结
		undo日志应该及时purge，undo日志的堆积不仅会导致回滚段空间的增长，而且delete mark的记录没有真正删除，也会影响查询的效率。	
	
	注意:
		事务回滚和 MVCC，这就需要 undo。undo 是逻辑日志，只是将数据库逻辑恢复到原来的样子，但是数据结构和页本身在回滚之后可能不同。
		例如：用户执行 insert 10w 条数据的事务，表空间因而增大。用户执行 ROLLBACK 之后，会对插入的数据回滚，但是表空间大小不会因此收缩。
		
		




	
	