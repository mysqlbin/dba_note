
https://docs.mongodb.com/manual/reference/replica-set-protocol-versions/


cfg = rs.conf();
cfg.protocolVersion=1;
rs.reconfig(cfg);


https://www.cnblogs.com/bien94/p/12354815.html  MongoDB3.4版本新增特性

　（一）复制集（Replica Set）

　　MongoDB3.4版本在复制集中新增了以下特性：

　　1、Ddfault Journaling Behavior of majority Write Concern

	　在MongoDB3.4版本配置复制集时，增加writeConcernMajorityJournalDefault选项，默认为true，即当指定WriteConcern为majority时，数据写到大多数节点并且journal成功刷盘后，才向客户端确认成功；
	如果为false，则数据写到大多数节点的内存时就向客户端确认。

	　　writeConcernMajorityJournalDefault的默认值跟protocolVersion相关，当protocolVersion为1时，它的默认值为true；当protocolVersion为0时，它的默认值为false。
		而protocolVersion从3.2版本开始就默认为1了，注意了protocolVersion为0的复制集成员不能加入protocolVersion为1的副本集。

	
protocol Version(协议版本)

