


binlog 是Server层的， Redo log是InnoDB存储引擎层的， 是两个互不想干的逻辑，为了让它们保持逻辑上的一致，因此需要两阶段提交，把Redo log的写入操作拆分成 redo log prepare 和 commit 这2个阶段。
先写redo log 后写 binlog，或者先写 binlog 后写 redo log，都会存在问题。




	


