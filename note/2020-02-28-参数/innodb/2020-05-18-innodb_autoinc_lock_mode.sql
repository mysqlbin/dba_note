对所有的insert-like 自增长值的产生使用互斥量机制完成，性能最高，并发插入可能导致自增值不连续，可能会导致Statement 的 Replication 出现不一致，使用该模式，需要用 Row Replication的模式。

缺点：只能保证唯一，不能保证递增和连续。持有、读取和修改、释放、执行SQL

建议修改成2，对于批量的insert可以提升性能
