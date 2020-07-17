
1. redo log是什么/它记录的日志内容是什么
2. 为什么要有MTR
3. redo log buffer 
4. flushed_to_disk_lsn-Log flushed up to 
5. flush链表中的LSN
6. checkpoint 检查点
7. 小结

1. redo log是什么/它记录的日志内容是什么
	
	比方说某个事务将系统表空间中的第100号页面中偏移量为1000处的那个字节的值1改成2我们只需要记录一下：

		将第0号表空间的100号页面的偏移量为1000处的值更新为2。

	我们只是想让已经提交了的事务对数据库中数据所做的修改永久生效，即使后来系统崩溃，在重启后也能把这种修改恢复出来。

	redo日志中只需要记录一下在某个页面的某个偏移量处修改了几个字节的值，具体被修改的内容是啥就好了

	redo日志格式小结
	虽然上边说了一大堆关于redo日志格式的内容，但是如果你不是为了写一个解析redo日志的工具或者自己开发一套redo日志系统的话，那就没必要把InnoDB中的各种类型的redo日志格式都研究的透透的，没那个必要。
	上边我只是象征性的介绍了几种类型的redo日志格式，目的还是想让大家明白：
		redo日志会把事务在执行过程中对数据库所做的所有修改都记录下来，在之后系统崩溃重启后可以把事务所做的任何修改都恢复出来。
	
	------------------------------------------------------------------------

	redo log 记录的是某个表空间某个数据页的偏移量对应的位置做了什么修改。
	redo日志会把事务在执行过程中对数据库所做的所有修改都记录下来，在之后系统崩溃重启后可以把事务所做的任何修改都恢复出来。
	
	-- 虽然理解了，关键是能描述出来。

------------------------------------------------------------------------------------

2. 为什么要有MTR
	CREATE TABLE `t1` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `key1` varchar(100) DEFAULT NULL,
	  `key2` int(11) DEFAULT NULL,
	  `key3` varchar(100) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `idx_key1` (`key1`),
	  KEY `idx_key3` (`key3`)
	) ENGINE=InnoDB AUTO_INCREMENT=10001 DEFAULT CHARSET=utf8mb4;
	
	首先，redo log 记录的是某个表空间某个数据页的偏移量对应的位置做了什么修改。

	这里的t1表有3个索引，即3棵B+TREE

	INSERT INTO `t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('1', '1', '1', '1');

	当插入一行记录，就需要往3棵B+TREE的某个数据页中写入数据(修改了不同B+TREE的不同page)

	这样一条语句就会生成3个redo log，因为要保证这些操作是原子的。
	
	这3个redo log成为一组，mtr包含了这一组的redo log。

	所以一个所谓的mtr可以包含一组redo日志，在进行崩溃恢复时这一组redo日志作为一个不可分割的整体。
	
------------------------------------------------------------------------------------

3. redo log buffer 
	redo log buffer 本质上是一片连续的内存空间，被划分成了若干个 512 字节大小的 block
	将log buffer中的redo日志刷新到磁盘的本质就是把block的镜像写入日志文件中，所以redo日志文件其实也是由若干个512字节大小的block组成。

------------------------------------------------------------------------------------

4. flushed_to_disk_lsn-Log flushed up to 
	
	刷新到磁盘中的redo日志量的全局变量，称之为flushed_to_disk_lsn（Log flushed up to）。
	用于标记当前log buffer中已经有哪些日志被刷新到磁盘中了

------------------------------------------------------------------------------------

5. flush链表中的LSN

	在 mtr 结束时还有一件非常重要的事情要做，就是把在mtr执行过程中可能修改过的页面加入到Buffer Pool的flush链表。

	flush链表中的脏页是按照页面的第一次修改时间从大到小进行排序的：
		当第一次修改某个缓存在Buffer Pool中的页面时，就会把这个页面对应的控制块插入到flush链表的头部，之后再修改该页面时由于它已经在flush链表中了，就不再次插入了。
		最新修改的在flush链表的头部
	
	在这个过程中会在缓存页对应的控制块中记录两个关于页面何时修改的属性：

		1. oldest_modification：
			
			如果某个页面被加载到BP缓冲池后进行第一次修改，那么就将修改该页面的 MTR 开始时对应的 LSN 值写入这个属性。  --理解了。	
			也就是说 redo log 跟 oldest_modification 是关联着的。

			数据页被加载到BP缓冲池中第一次修改，就把修改该页面的 MTR 开始时 LSN 值写入这个属性。
			
			数据页第一次修改的LSN

		2. newest_modification：
			每修改一次页面，都会将修改该页面的 MTR 结束时对应的lsn值写入这个属性。  --理解了。		
			记录的是数据页最后一次被修改的 LSN 值。
	
	flush链表中的脏页按照第一次修改发生的时间顺序进行排序，也就是按照oldest_modification代表的LSN值进行排序，被多次更新的页面不会重复插入到flush链表中，但是会更新 newest_modification属性 的值。

	LSN也会写到 InnoDB的数据页中， 用来确保数据页不会被多次执行重复的 redo log（这里暂时不理解）。   --先继续往下看。 


	举例说明：
		
		系统第一次启动后，向log buffer中写入了mtr_1、mtr_2、mtr_3这三个mtr产生的redo日志，假设这三个mtr开始和结束时对应的lsn值分别是：

			mtr_1：8716 ～ 8916
			mtr_2：8916 ～ 9948
			mtr_3：9948 ～ 10000
		
		1. 假设 mtr_1 执行过程中修改了 页a ，那么在 mtr_1 执行结束时，就会将 页a 对应的控制块加入到flush链表的头部。
			并且将 mtr_1 开始时对应的lsn，也就是 8716 写入 页a 对应的控制块的 oldest_modification 属性中，把 mtr_1 结束时对应的lsn，也就是8916写入 页a 对应的控制块的 newest_modification 属性中。

		2. 接着假设 mtr_2 执行过程中又修改了 页b 和 页c 两个页面，那么在 mtr_2 执行结束时，就会将 页b 和 页c 对应的控制块都加入到 flush链表 的头部。
			并且将 mtr_2 开始时对应的lsn，也就是 8916 写入 页b 和 页c 对应的控制块的 oldest_modification 属性中，把 mtr_2 结束时对应的 lsn ，也就是 9948 写入 页b 和 页c 对应的控制块的 newest_modification 属性中。
		
		3. 接着假设 mtr_3 执行过程中修改了 页b 和 页d ，不过 页b 之前已经被修改过了，所以它对应的控制块已经被插入到了 flush链表 ，所以在 mtr_3 执行结束时，只需要将 页d 对应的控制块都加入到 flush链表 的头部即可。
			所以需要将mtr_3开始时对应的lsn，也就是 9948 写入 页d 对应的控制块的 oldest_modification 属性 中，把 mtr_3 结束时对应的lsn，也就是 10000 写入 页d 对应的控制块的 newest_modification 属性中。
			另外，由于 页b 在mtr_3执行过程中又发生了一次修改，所以需要更新 页b 对应的控制块中 newest_modification 的值为10000。

		
		-- 这里理解了。
		3. 一个数据页可能会在不同的时刻被修改多次，在数据页上记录了最老(也就是第一次)的一次修改的lsn，即oldest_modification
		4. 不同数据页有不同的oldest_modification，FLU List中的节点按照oldest_modification排序，链表尾是最小的，也就是最早被修改的数据页

------------------------------------------------------------------------------------



说明了先写 redo log 再修改数据页


------------------------------------------------------------------------------------

	
	
6. checkpoint 检查点
	
	
	比方说现在页a被刷新到了磁盘，mtr_1生成的redo日志就可以被覆盖了，所以我们可以进行一个增加checkpoint_lsn的操作，我们把这个过程称之为做一次checkpoint。


	因为redo日志是循环覆盖写，那么怎么判断哪些日志空间是可以覆盖的呢？

		通过checkpoint检查点来做判断。
		
		日志中的checkpoint检查点之前到当前redo log写入的位置区间都是可以被覆盖的。
		
	脏页刷盘，对应的 redo log 就可以不需要了，这部分的redo log就可以被覆盖写。
	脏页刷盘之后，才可以对 redo log 做 checkpoint,


	系统第一次启动后，向log buffer中写入了mtr_1、mtr_2、mtr_3这三个mtr产生的redo日志，假设这三个mtr开始和结束时对应的lsn值分别是：

		mtr_1：8716 ～ 8916
				page a
		mtr_2：8916 ～ 9948
				page b 和 page c
		mtr_3：9948 ～ 10000
				page b 和 page d
		



	搞懂了 checkpoint LSN 是怎么取值的：
		
		计算一下当前系统中可以被覆盖的redo日志对应的lsn值最大是多少。

		redo日志可以被覆盖，意味着它对应的脏页被刷到了磁盘，只要我们计算出当前系统中被最早修改的脏页对应的oldest_modification值，那凡是在系统lsn值小于该节点的oldest_modification值时产生的redo日志都是可以被覆盖掉的，我们就把该脏页的 oldest_modification 赋值给 checkpoint_lsn 。
		
		总的来说就是 把最早修改的脏页对应的 oldest_modification 值 赋值给 checkpoint_lsn 。  ---

		比方说当前系统中页a已经被刷新到磁盘，那么flush链表的尾节点就是页c，该节点就是当前系统中最早修改的脏页了，它的oldest_modification值为8916，我们就把8916赋值给checkpoint_lsn（也就是说在redo日志对应的lsn值小于8916时就可以被覆盖掉）。

	
	搞懂了 Pages flushed up to 是怎么取值的：
		
		代表flush链表中被最早修改的那个页面对应的 oldest_modification 属性值 
		
		也可以理解为  表示缓冲池中脏页已经刷新到磁盘的LSN，数据页小于该 LSN 的表示该LSN值之前的脏页都已经被刷盘。
		
			mtr_1：8716 ～ 8916
					对应 page a

			mtr_2：8916 ～ 9948
					对应 page b

			mtr_3：9948 ～ 10000
					对应 page c
			
			1. 此时的lsn已经增长到了10000，但是由于没有刷新操作，所以 此时的 Pages flushed up to = 8716

			
			2. 假设刷一个脏页(page a)到磁盘，这个脏页的 oldest_modification（MTR开始阶段对应的LSN值） 为 8716， 这个脏页的 newest_modification（MTR结束阶段对应的LSN值） 为 8916， 那么 LSN=8916 之前的 redo log 都可以被覆盖写。
				
				所以 此时的 Pages flushed up to = 8916。
		
				
	因为是先刷脏页，才能推进做redo log的 checkpoint, 所以 Pages flushed up to 的 LSN 值是大于 Last checkpoint at 的 LSN 值的。
	
	
	对于系统来说，以上4个LSN是递减的，即： LSN1>=（大于等于）LSN2>=LSN3>=LSN4。

	---
	LOG
	---
	Log sequence number 92343966234
	Log flushed up to   92343966234
	Pages flushed up to 92343966234
	Last checkpoint at  92343966225

	root@mysqldb 11:06:  [(none)]> show global status like '%Innodb_buffer_pool_pages_dirty%';
	+--------------------------------+-------+
	| Variable_name                  | Value |
	+--------------------------------+-------+
	| Innodb_buffer_pool_pages_dirty | 0     |
	+--------------------------------+-------+
	1 row in set (0.00 sec)



	3个时间：
		2020-07-17
		2020-07-18
		2020-07-19

		2020-07-17 为最早
		2020-07-19 为最晚


	LSN也会写到 InnoDB的数据页中， 用来确保数据页不会被多次执行重复的 redo log（这里暂时不理解）。   --先继续往下看。 
		

7. 小结
	redo日志用来保留数据的持久性/一致性，只要事务执行成功，就可以保证数据不会丢失；
	它在MySQL崩溃恢复的才会用来做数据的恢复。
	
	脏页刷盘，对应的redo日志才能做checkpoint，日志做checkpoint之后才能被覆盖写。
	
8. 问题
	1. 为什么 Pages flushed up to 不能作为崩溃恢复的起点？
		首先要理解 Pages flushed up to 和 Last checkpoint at 的含义

		Pages flushed up to： 
			代表flush链表中被最早修改的那个页面对应的 oldest_modification 属性值 
			表示缓冲池中脏页已经刷新到磁盘的LSN，数据页小于该 LSN 的表示该LSN值之前的脏页都已经被刷盘。

		Last checkpoint at：
			检查点的位置。
			总的来说就是 把最早修改的脏页对应的 oldest_modification 属性值 赋值给 checkpoint_lsn 。
			
			
		因为是先做 Pages flushed up to 再做 Last checkpoint at，所以有一个先后顺序的问题
		
	
你说之前费那么大事查资料讲的还乱  可气。


	





















