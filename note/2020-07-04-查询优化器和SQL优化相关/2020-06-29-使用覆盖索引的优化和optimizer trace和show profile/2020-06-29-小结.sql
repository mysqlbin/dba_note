


explain/desc    ：查看SQL语句的执行计划
show warnings   ：查看优化器处理后的语句, 比如 in子句改写 semi join。如果与原始语句有出入，仔细对比研究能够发现实际问题。 
				  帮助我们理解MySQL将如何执行查询语句的一个参考依据
show profiles   ：查看SQL语句的性能消耗分布情况
optimizer trace ：追踪优化器，查看优化器生成执行计划的整个过程
				  同时可以看到是否有使用MRR优化等
				  



optimizer trace 的中文含义为 优化器跟踪

作用： 通过 optimizer trace可以让我们方便的查看优化器生成执行计划的整个过程

	比较各个索引的代价和使用代价最小的索引



