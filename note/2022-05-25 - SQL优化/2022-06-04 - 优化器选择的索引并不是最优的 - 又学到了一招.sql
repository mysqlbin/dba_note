

1. 执行同一条sql语句，有时执行很快，有时执行很慢，是什么原因产生的，有什么排查思路、如何解决

	有时还跟数据分布有关
	
	
MySQL 优化器选择的索引并不是最优的，在我遇到的场景中，大多数是走了 group by 或者 order by 字段的索引

	1. 原因：走where条件的索引并不能消除分组或者排序
	
	2. 等值查询 + order by，通过修改sql语句来解决
		1. 语句1：等值查询+order by 主键ID asc
			解决办法：要让等值查询的所有字段都能走索引
			
		2. 语句2：等值查询+order by 非主键ID asc 并且 order by 字段不在where查询条件中
			解决办法：要让等值查询所有字段+order by 字段 都能走索引
		
		3. 语句3：等值查询+order by 非主键ID desc 并且 order by 字段不在where查询条件中
			
			解决办法：
				1. 要让等值查询所有字段+order by 字段 都能走索引
				2. 同时改写sql语句，where 条件都要使用 order by 进行降序。
		
   
    3. 非等值查询，先执行 analyze table，如果还没有解决，通过 force index 来解决。
		
	
2022-06-04，最近的实践+总结


2. 通过实践，不断更新自己的认识





