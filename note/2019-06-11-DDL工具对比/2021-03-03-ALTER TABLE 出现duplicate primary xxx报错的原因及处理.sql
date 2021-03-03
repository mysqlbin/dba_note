
ALTER TABLE 出现duplicate primary xxx报错的原因及处理？

好多同学都曾经问过这个问题，还有同学说这是bug，实际上这并不是bug



原因分析

	1、Online DDL操作时MySQL会将DML操作缓存起来存入到变更日志

	2、等到DDL执行完成后再应用变更日志中的DML操作

	3、在Oline DDL执行期间，并行的DML可能会没先检查唯一性直接插入一条相同主键的数据，这时并不会导致DDL报错，而是在DDL执行完成再次应用变更日志时才报错，最终导致DDL报错执行失败


	先插入增量DML日志再进行唯一性约束检查，虽然err被置为DB_SUCCESS，但index被标记为corrupted，所以会导致索引的操作出错）


	从官方文档中的描述所说 online ddl 期间，其他会话执行的dml操作造成唯一键冲突的sql会记录到 online log 中，在commit阶段等变更结束之后再应用这些sql会导致报错唯一键冲突。


相关参考：
	https://zhuanlan.zhihu.com/p/115285170  MySQL Online DDL增量DML记录和回放的源码实现
	https://mp.weixin.qq.com/s/tzShTHrunhgFxeLxLzi5fA  MySQL add/drop字段时报主键冲突

	
Online DDL的原理

	1. 构建临时文件、扫描原表数据、并把原表数据写入到临时文件；
	2. 增量数据写入到日志文件中；
	3. 原表的数据拷贝完成到临时文件后，将日志文件的增量数据写入到临时文件中；
		表上有唯一索引，执行这一步，可能会报唯一键值冲突的错误。
	4. 用临时文件替换表A的数据文件。
		新旧表的切换，需要加MDL写锁，会造成秒级的写阻塞，不会造成死锁。
		
		
insert /* gh-ost `sbtest`.`t1_2500` */ ignore into `sbtest`.`_t1_2500_gho` 