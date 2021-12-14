

首先，事务日志有2种: undo 和 redo
	Undo：
		含义：记录的是更新前的值
		作用：
			1. 有了undo，就可以把数据回滚到更新前的值。
			2. 借助 read view + undo，就可以实现MVCC.
			
	redo：
		含义：记录的是对数据页做了什么修改
		作用：有了redo, 就可以保证已经提交了的数据不会丢失。
		
事务是如何通过日志来实现的，说得越深入越好
	
	基本流程如下：
		
		先记录undo, 拷贝该记录修改之前的值到Undo Log中，将Undo Log的修改记录写入Redo Log中(undo需要记录redo来持久化)   -- 这步骤有点长
	
		然后记录数据页修改的redo 同时在内存中更新数据页
		
		Redo（里面包括 undo 的修改） 一定要比数据页先持久化到磁盘。 
		
		1. 当事务需要回滚时
			借助 undo 日志，可以把数据回滚到前镜像的状态。
		
		2. 崩溃恢复时，先判断redo日志的完整性 再 判断 binlog的完整性
			1. 先判断 redo 日志的完整性
			  redo 有commit标识，直接提交事务，去更新内存数据页
			  redo 没有commit标识，但是有完整的prepare，需要判断binlog的完整性
			  
			2. binlog的完整性
			  通过binlog_checksum参数验证binlog的完整性，如果binlog是完整的，就提交事务
			  否则，回滚事务。

		-- 不需要背，根据自己的理解口述出来。
		
		完整的redo log prepare：表示redo log 已经写入完成，但是还没有处于commit状态。
		
		
DML操作在undo中的记录

	1. 对于insert和delete，undo中会记录键值(主键索引和二级索引的值)，delete操作只是标记删除(delete mark)记录。

	2. 对于update：
	
		1. 原地更新：undo中会记录键值(主键索引和二级索引的值)和老值(非索引值)。
			-- 回滚的时候，直接把老值更新回去。
		2. 非原地更新：通过delete+insert方式进行，undo中会记录键值(主键索引和二级索引的值)，不需记录老值; 其中delete也是标记删除记录。
			-- 回滚的时候，清除删除标识就行了。
	
		3. 对于update操作有原地更新和delete+insert两种，那么怎么区分undo记录使用的哪种方式呢？
 
			原地更新条件：更新没有改变值的长度且也没有更新行外数据，具体可参考 row_upd_changes_field_size_or_external
			

	3. 二级索引的更新总是delete+insert方式进行。具体日志格式参考 trx_undo_report_row_operation 。


	4. 问题：update undo log里只记录涉及到的变更字段之前的值，还是保存整条数据的前一个版本呢？
		
		1. 原地更新：undo中会记录键值(主键索引和二级索引的值)和老值(非索引值)。
		
		2. 非原地更新：通过delete+insert方式进行，undo中会记录键值(主键索引和二级索引的值)，不需记录老值; 其中delete也是标记删除记录。
			-- 回滚的时候，清除删除标识就行了。
				
	5. 小结
		undo log 不需要记录一条完整的旧版本记录。
		