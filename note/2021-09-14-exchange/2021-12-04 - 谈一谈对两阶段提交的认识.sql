


将 redo log 的写入拆成了prepare 和 commit 这两个步骤，这就是 两阶段提交：

	写入Redo log处于prepare阶段
	提交事务，redo log 处于 commit 状态。

MySQL采用两阶段提交： redo log 先 prepare -> 写binlog -> redo log commit
	prepare 阶段有做刷盘操作吗？
	答：有的。只是还没有事务提交状态的commit标识。
	
	
