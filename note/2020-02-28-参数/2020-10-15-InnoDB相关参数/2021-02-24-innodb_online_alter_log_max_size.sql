


https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_online_alter_log_max_size 

https://zhuanlan.zhihu.com/p/115277009  MySQL 8.0 Online DDL和pt-osc、gh-ost深度对比分析
https://zhuanlan.zhihu.com/p/115285170  MySQL Online DDL增量DML记录和回放的源码实现


与pt-osc/gh-ost不同，Online DDL的执行阶段又可以分为前后2个步骤，首先是拷贝全量数据，然后才回放增量DML日志。
	在全量拷贝期间，增量DML日志被保存在日志文件中，由innodb_online_alter_log_max_size 参数确定文件最大阈值，若积累的DML日志超过该阈值，则DDL操作返回失败。
	增量DML日志的大小超过参数由innodb_online_alter_log_max_size的大小，则DDL操作返回失败。