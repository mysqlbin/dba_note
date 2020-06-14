/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
DELIMITER /*!*/;
# at 4
#200307 20:29:20 server id 330640  end_log_pos 123 CRC32 0xcec0068f 	Start: binlog v 4, server v 5.7.22-log created 200307 20:29:20
# at 123
#200307 20:29:20 server id 330640  end_log_pos 194 CRC32 0xbd7c8459 	Previous-GTIDs
# 7af746a1-5c2d-11ea-bc75-00163e08b460:1-5768


# at 194
#200307 20:29:37 server id 330640  end_log_pos 259 CRC32 0x727a01ea 	GTID	last_committed=0	sequence_number=1	rbr_only=no    # GTID event 
SET @@SESSION.GTID_NEXT= '7af746a1-5c2d-11ea-bc75-00163e08b460:5769'/*!*/;
# at 259
#200307 20:29:37 server id 330640  end_log_pos 402 CRC32 0x45095cdf 	Query	thread_id=463	exec_time=1	error_code=0               # query event 
use `niuniuh5_db`/*!*/;
SET TIMESTAMP=1583584177/*!*/;
SET @@session.pseudo_thread_id=463/*!*/;
SET @@session.foreign_key_checks=1, @@session.sql_auto_is_null=0, @@session.unique_checks=1, @@session.autocommit=1/*!*/;
SET @@session.sql_mode=1075838976/*!*/;
SET @@session.auto_increment_increment=1, @@session.auto_increment_offset=1/*!*/;
/*!\C utf8 *//*!*/;
SET @@session.character_set_client=33,@@session.collation_connection=33,@@session.collation_server=45/*!*/;
SET @@session.lc_time_names=0/*!*/;
SET @@session.collation_database=DEFAULT/*!*/;
alter table t add column b int(11) default null after a
/*!*/;
# at 402
#200307 20:29:43 server id 330640  end_log_pos 449 CRC32 0xa7a5d35d 	Rotate to mysql-bin.000011  pos: 4          
SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
DELIMITER ;
# End of log file
/*!50003 SET COMPLETION_TYPE=@OLD_COMPLETION_TYPE*/;
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=0*/;

DDL:
	Query event : 
		执行时间是实际语句的执行时间 即 语句的开始执行时间为 200307 20:29:37

	语句的结束时间为 200307 20:29:43	
	
	本次DDL耗时6S = 200307 20:29:43 - 200307 20:29:37 