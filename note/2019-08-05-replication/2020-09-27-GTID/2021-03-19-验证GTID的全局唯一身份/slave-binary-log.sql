/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
DELIMITER /*!*/;
# at 4
#200110 23:43:42 server id 330692  end_log_pos 124 	Start: binlog v 4, server v 8.0.18 created 200110 23:43:42
# at 124
#200110 23:43:42 server id 330692  end_log_pos 191 	Previous-GTIDs
# 48c3fa1e-06a6-11ea-a25d-0800275219f4:19-100176
# at 191
#200201 11:21:14 server id 330691  end_log_pos 273 	GTID	last_committed=0	sequence_number=1	rbr_only=yes	original_committed_timestamp=1580527274140692	immediate_commit_timestamp=1578671187866017	transaction_length=278
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1580527274140692 (2020-02-01 11:21:14.140692 CST)
# immediate_commit_timestamp=1578671187866017 (2020-01-10 23:46:27.866017 CST)
/*!80001 SET @@session.original_commit_timestamp=1580527274140692*//*!*/;
/*!80014 SET @@session.original_server_version=80018*//*!*/;
/*!80014 SET @@session.immediate_server_version=80018*//*!*/;
SET @@SESSION.GTID_NEXT= '48c3fa1e-06a6-11ea-a25d-0800275219f4:100177'/*!*/;
# at 273
#200201 11:21:14 server id 330691  end_log_pos 348 	Query	thread_id=17519	exec_time=4293111209	error_code=0
SET TIMESTAMP=1580527274/*!*/;
SET @@session.pseudo_thread_id=17519/*!*/;
SET @@session.foreign_key_checks=1, @@session.sql_auto_is_null=0, @@session.unique_checks=1, @@session.autocommit=1/*!*/;
SET @@session.sql_mode=524288/*!*/;
SET @@session.auto_increment_increment=1, @@session.auto_increment_offset=1/*!*/;
/*!\C utf8mb4 *//*!*/;
SET @@session.character_set_client=255,@@session.collation_connection=255,@@session.collation_server=255/*!*/;
SET @@session.lc_time_names=0/*!*/;
SET @@session.collation_database=DEFAULT/*!*/;
/*!80011 SET @@session.default_collation_for_utf8mb4=255*//*!*/;
BEGIN
/*!*/;
# at 348
#200201 11:21:14 server id 330691  end_log_pos 402 	Table_map: `test_20191101`.`t1` mapped to number 102
# at 402
#200201 11:21:14 server id 330691  end_log_pos 442 	Delete_rows: table id 102 flags: STMT_END_F
### DELETE FROM `test_20191101`.`t1`
### WHERE
###   @1=2 /* INT meta=0 nullable=1 is_null=0 */
###   @2=0 /* INT meta=0 nullable=0 is_null=0 */
# at 442
#200201 11:21:14 server id 330691  end_log_pos 469 	Xid = 200552
COMMIT/*!*/;
# at 469
#200110 23:52:06 server id 330692  end_log_pos 512 	Rotate to mysql-bin.000006  pos: 4
SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
DELIMITER ;
# End of log file
/*!50003 SET COMPLETION_TYPE=@OLD_COMPLETION_TYPE*/;
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=0*/;
