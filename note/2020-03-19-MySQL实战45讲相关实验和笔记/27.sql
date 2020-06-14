

我们在实例 X 中创建一个表 t:
CREATE TABLE `t` (
  `id` int(11) NOT NULL,
  `c` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into t values(1,1);


mysql> show binlog events in 'mysql-bin.000258';
+------------------+-----+----------------+-----------+-------------+----------------------------------------------------------------------------------------------------------------------------------------+
| Log_name         | Pos | Event_type     | Server_id | End_log_pos | Info                                                                                                                                   |
+------------------+-----+----------------+-----------+-------------+----------------------------------------------------------------------------------------------------------------------------------------+
| mysql-bin.000258 |   4 | Format_desc    |        17 |         123 | Server ver: 5.7.24-log, Binlog ver: 4                                                                                                  |
| mysql-bin.000258 | 123 | Previous_gtids |        17 |         194 | 64f06970-098a-11e9-aee6-00163e020f37:1-6                                                                                               |
| mysql-bin.000258 | 194 | Gtid           |        17 |         259 | SET @@SESSION.GTID_NEXT= '64f06970-098a-11e9-aee6-00163e020f37:7'                                                                      |
| mysql-bin.000258 | 259 | Query          |        17 |         465 | use `consistency_db`; CREATE TABLE `t` (
  `id` int(11) NOT NULL,
  `c` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB |
| mysql-bin.000258 | 465 | Gtid           |        17 |         530 | SET @@SESSION.GTID_NEXT= '64f06970-098a-11e9-aee6-00163e020f37:8'                                                                      |
| mysql-bin.000258 | 530 | Query          |        17 |         612 | BEGIN                                                                                                                                  |
| mysql-bin.000258 | 612 | Table_map      |        17 |         667 | table_id: 687 (consistency_db.t)                                                                                                       |
| mysql-bin.000258 | 667 | Write_rows     |        17 |         711 | table_id: 687 flags: STMT_END_F                                                                                                        |
| mysql-bin.000258 | 711 | Xid            |        17 |         742 | COMMIT /* xid=6923432 */                                                                                                               |
| mysql-bin.000258 | 742 | Stop           |        17 |         765 |                                                                                                                                        |
+------------------+-----+----------------+-----------+-------------+----------------------------------------------------------------------------------------------------------------------------------------+
10 rows in set (0.00 sec)


事务的 BEGIN 之前有一条 SET @@SESSION.GTID_NEXT 命令。
如果实例 X 有从库，那么会将 CREATE TABLE 和 insert 语句的 binlog 同步过去执行
执行事务之前就会先执行这两个 SET 命令，被加入从库的 GTID 集合的，就是64f06970-098a-11e9-aee6-00163e020f37:7 和 64f06970-098a-11e9-aee6-00163e020f37:8 这两个 GTID。



GTID模式下的主键冲突和解决办法

CREATE TABLE `t` (
  `id` int(11) NOT NULL,
  `c` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;


从库
mysql> insert into t values(1,1);
GTID是 53ebf01e-bbec-11e8-9a62-00163e087d10:1-2

主库
mysql> insert into t values(1,1);
GTID是 64f06970-098a-11e9-aee6-00163e020f37:1-10

mysql>show slave status\G; 
Last_SQL_Errno: 1062
Last_SQL_Error: Coordinator stopped because there were error(s) in the worker(s). The most recent failure being: Worker 1 failed executing transaction '64f06970-098a-11e9-aee6-00163e020f37:10' at master log mysql-bin.000259, end_log_pos 717. See error log and/or performance_schema.replication_applier_status_by_worker table for more details about this failure or others, if any.
Retrieved_Gtid_Set: 64f06970-098a-11e9-aee6-00163e020f37:1-10
Executed_Gtid_Set: 53ebf01e-bbec-11e8-9a62-00163e087d10:1-2,64f06970-098a-11e9-aee6-00163e020f37:1-9


解决办法:

通过 Executed_Gtid_Set, 知道了已经执行到 事务编号为9的事务了, 所以跳过编号为10的事务

set gtid_next='64f06970-098a-11e9-aee6-00163e020f37:10';
begin;
commit;
set gtid_next=automatic;
start slave;

前三条语句的作用:
是通过提交一个空事务，把这个 GTID 加到实例 X 的 GTID 集合中。

set gtid_next=automatic的作用:
	恢复 GTID 的默认分配行为
	如果之后有新的事务再执行，就还是按照原来的分配方式，继续分配 gno=3。

	
执行完这个空事务之后的 show master status 的结果:
mysql> show master status\G;
*************************** 1. row ***************************
             File: mysql-bin.000171
         Position: 3620
     Binlog_Do_DB: 
 Binlog_Ignore_DB: 
Executed_Gtid_Set: 53ebf01e-bbec-11e8-9a62-00163e087d10:1-2,
64f06970-098a-11e9-aee6-00163e020f37:1-10
1 row in set (0.00 sec)


可以看到从库 的 Executed_Gtid_set 里面，已经加入了这个 GTID。

再执行 start slave 命令让同步线程执行起来的时候，虽然从库 上还是会继续执行主库 传过来的事务，
但是由于 64f06970-098a-11e9-aee6-00163e020f37:10 已经存在于从库 的 GTID 集合中了，所以从库 就会直接跳过这个事务，也就不会再出现主键冲突的错误。




GTID和在线DDL
	
	slave:
		stop slave;
		通过 show master status\G;命令 获取到的 Executed_Gtid_Set 为 64f06970-098a-11e9-aee6-00163e020f37:1-10
		
	master:
	
	#这里有2个DML事务已经提交,对应的GTID为
	Executed_Gtid_Set 为 64f06970-098a-11e9-aee6-00163e020f37:1-11 #记为GTID 11
	Executed_Gtid_Set 为 64f06970-098a-11e9-aee6-00163e020f37:1-12 #记为GTID 12
	
	
	#执行完成后，查出这个 DDL 语句对应的 GTID，并记为 server_uuid_of_Y:gno。
	#DDL对应的GTID为 64f06970-098a-11e9-aee6-00163e020f37:13  #记录GTID 13
	alter table  table_robot_lockinfo add index idx_BatchID (`BatchID`);
	
	
	#set GTID_NEXT="server_uuid_of_Y:gno";  --设置需要跳过的某个gtid event
	set GTID_NEXT="64f06970-098a-11e9-aee6-00163e020f37:13";  # DDL对应的GTID为 64f06970-098a-11e9-aee6-00163e020f37:13
	begin;
	commit;
	set gtid_next=automatic;
	start slave;
	
	#当执行 start slave命令后,  GTID 11和记为GTID 12会继续在从库执行,  记录GTID 13不会在从库执行.
	
	
	change master to master_host='39.108.17.15',master_user='repl'_master




	