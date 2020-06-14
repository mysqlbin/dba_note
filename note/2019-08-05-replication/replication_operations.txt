关于 INSERT 的 1062(主键或者唯一索引冲突)：
1. 在从库删除重复的记录


关于 DELETE 的 1032(找不到记录):
1. 跳过错误 *****
2. 从库补全一条记录  这种方法没有必要，毕竟做的删除操作

关于 UPDATE 的 1032(找不到记录):
1. 从库新增一条记录


classify repliation:
一. update 的 1032:
1.
Last_SQL_Errno: 1032
Last_SQL_Error: Could not execute Update_rows event on table niuniu_db.table_user_msg; Can't find record in 'table_user_msg', Error_code: 1032; handler error HA_ERR_KEY_NOT_FOUND; the event's master log mysql-bin.000003, end_log_pos 778557315
Exec_Master_Log_Pos: 778557212

mysqlbinlog -v --base64-output=decode-rows mysql-bin.000003 --start-position=778557212 --stop-position=778557315 > 1032.sql;

找到 end_log_pos = 778557315 对应的SQL语句：
# at 691
#180412 22:37:10 server id 133306  end_log_pos 778557315 CRC32 0x888c8623 	Delete_rows: table id 121 flags: STMT_END_F
### DELETE FROM `procedure`.`table_user_msg`
### WHERE
###   @1=71144
###   @2=354
###   @3=502
###   @4=1
###   @5=1517688946
###   @6=''
###   @7='带你飞'
###   @8=0
# at 778557315

把 时间戳转为日期： select FROM_UNIXTIME(1517688946);  =》 2018-02-03 15:15:46

stop  slave sql_thread for channel 'node13';
set sql_log_bin = 0;
INSERT INTO
FROM
	`procedure`.`table_user_msg` (
		`nMsgId`,
		`nPlayerId`,
		`nMsgType`,
		`nIsRead`,
		`CreateTime`,
		`sMsgTitle`,
		`sMsgBody`,
		`nIsReward`
	)
VALUES
	(
		71144,
		354,
		502,
		1,
		'2018-02-03 15:15:46',
		'',
		'带你飞',
		0
	);
set sql_log_bin = 1;
start slave sql_thread for channel 'node13';




二. delete 的 1032
1. 
Last_SQL_Errno: 1032
Last_SQL_Error: Could not execute Delete_rows event on table procedure.table_user_msg; Can't find record in 'table_user_msg', Error_code: 1032; handler error HA_ERR_KEY_NOT_FOUND; the event's master log mysql-bin.000008, end_log_pos 798
 Replicate_Ignore_Server_Ids: 
             Master_Server_Id: 133306
                  Master_UUID: 6d9f971d-3d67-13e8-8f32-130027fb13f7
             Master_Info_File: mysql.slave_master_info

解决办法：
a. 跳过错误
stop  slave sql_thread for channel 'node13';
set global sql_slave_skip_counter=1;
start slave sql_thread for channel 'node13';


2. 
delete 的 1032
Last_SQL_Errno: 1032
Last_SQL_Error: Could not execute Delete_rows event on table channels_a.tb1; Can't find record in 'tb1', Error_code: 1032; handler error HA_ERR_END_OF_FILE; the event's master log mysql-bin.000008, end_log_pos 2659
Replicate_Ignore_Server_Ids: 
             Master_Server_Id: 123306
                  Master_UUID: 6d9f971d-3d67-11e8-8f32-080027fb13f7
             Master_Info_File: mysql.slave_master_info
跳过错误
stop  slave sql_thread for channel 'node12';
set global sql_slave_skip_counter=1;
start slave sql_thread for channel 'node12';
show slave status\G;


二. gtid repliation


SET @@GLOBAL.GTID_PURGED='6d9e161b-64a6-11e8-9795-080027f9dcec:1-14';


GTID复制模式改为传统复制模式的实现步骤：
1. 
stop slave;
change master to master_auto_position=0,master_log_file='mysql-bin.000016',master_log_pos=194;
start slave;

2.
set @@global.gtid_mode = on_permissive;

3. 
set @@global.gtid_mode = off_permissive;

4. 
set @@global.gtid_mode = off;


思考：
在此期间有数据写入，那么会出现啥问题？




多源复制的  binlog + postion 在线升级 为 GTID：
http://wubx.net/mysql-5-7-class-repl-online-2-gtid-repl/

实现步骤：

1. 所有的Server执行
set @@global.enforce_gtid_consistency = warn;


特别注意： 这一步是关建的一步使用不能出现警告。

2. 所有的server上执行：
set @@global.enforce_gtid_consistency = on;


3.所有的Server上执行（不关心最先最后，但要执行完）：

set @@global.gtid_mode = off_permissive;

 
4. 执行：
set @@global.gtid_mode=on_permissive;

确认传统的binlog复制完毕,该值为0
show status like 'ongoing_anonymous_transaction_count';


5. 需要所有的节点都确认为0.
show status like 'ongoing_anonymous_transaction_count';
需要所有的节点都确认为0. 所有的节点也可以执行一下: flush logs; 用于切换一下日志。

6. 所有的节点启用gtid_mode
set @@global.gtid_mode=on;


7. 把 gtid_mode = on 相关配置写入配置文件(从库要写吗？)

gtid_mode=on
enforce_gtid_consistency=on

show status like '%gtid_mode%';
show global status like '%enforce_gtid_consistency%';

8. 启用Gtid的自动查找节点复制：

stop slave;


change master  to master_host='192.168.0.12',master_port=3306,master_user='repl_channel',master_password='123456abc',master_auto_position=1 for channel 'node12';

change master  to master_host='192.168.0.13',master_port=3306,master_user='repl_channel',master_password='123456abc',master_auto_position=1 for channel 'node13';

#change master to master_auto_position=1 for channel 'node12';

#change master to master_auto_position=1 for channel 'node13';

start slave;



跳过一个GTID:
stop slave sql_thread;
set gtid_next='ea740b55-8a30-11e8-8afe-080027eb50c1:2913';
begin;commit;
set gtid_next='automatic';
start slave sql_thread;


Exec_Master_Log_Pos: 644(start-position)
Last_SQL_Errno: 1032
Last_SQL_Error: Could not execute Delete_rows event on table test.sbtest1; 
Can't find record in 'sbtest1', Error_code: 1032;
 handler error HA_ERR_KEY_NOT_FOUND;
 the event's master log mysql-bin.000022, end_log_pos 1063

[root@node15 logs]# mysqlbinlog -v --base64-output=decode-rows --start-position='644' --stop-position='1063' mysql-bin.000022
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
DELIMITER /*!*/;
# at 644
#180608 14:24:06 server id 153306  end_log_pos 709 CRC32 0x0c69ba37 	GTID	last_committed=1	sequence_number=2	rbr_only=yes
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
SET @@SESSION.GTID_NEXT= '6d9e161b-64a6-11e8-9795-080027f9dcec:33872'/*!*/;
# at 709
#180608 14:24:06 server id 153306  end_log_pos 781 CRC32 0x0128d615 	Query	thread_id=2798	exec_time=0	error_code=0
SET TIMESTAMP=1528439046/*!*/;
SET @@session.pseudo_thread_id=2798/*!*/;
SET @@session.foreign_key_checks=1, @@session.sql_auto_is_null=0, @@session.unique_checks=1, @@session.autocommit=1/*!*/;
SET @@session.sql_mode=1436549152/*!*/;
SET @@session.auto_increment_increment=1, @@session.auto_increment_offset=1/*!*/;
/*!\C utf8 *//*!*/;
SET @@session.character_set_client=33,@@session.collation_connection=33,@@session.collation_server=33/*!*/;
SET @@session.lc_time_names=0/*!*/;
SET @@session.collation_database=DEFAULT/*!*/;
BEGIN
/*!*/;
# at 781
#180608 14:24:06 server id 153306  end_log_pos 838 CRC32 0xfc7d7f0e 	Table_map: `test`.`sbtest1` mapped to number 230
# at 838
#180608 14:24:06 server id 153306  end_log_pos 1063 CRC32 0xc4b73f82 	Delete_rows: table id 230 flags: STMT_END_F
### DELETE FROM `test`.`sbtest1`
### WHERE
###   @1=11
###   @2=504839
###   @3='41189576069-45553989496-19463022727-28789271530-61175755423-36502565636-61804003878-85903592313-68207739135-17129930980'
###   @4='84180662980-69524389384-04452441590-18229443618-70842001272'
ROLLBACK /* added by mysqlbinlog */ /*!*/;
SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
DELIMITER ;
# End of log file
/*!50003 SET COMPLETION_TYPE=@OLD_COMPLETION_TYPE*/;
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=0*/;
