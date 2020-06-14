

1. 插入的数据和删除的数据在不了同一个事务的, 因为这个是要跨数据库服务器的. 

2. 如果使用 utf8mb4 字符集, 那么会不支持 bulk-insert.

3. 一个bug: pt-archiver Bug不会迁移max(id)那条数据

	解决办法:
	  $first_sql .= " AND ($col < " . $q->quote_val($val) . ")";
	  改为
	  $first_sql .= " AND ($col <= " . $q->quote_val($val) . ")";
	  
4. 归档条件要带入日期范围和对应的id最大值和最小值范围
	参考笔记 《2019-09-24-pt-archiver做数据归档要用主键做为条件的原因.sql》
		
