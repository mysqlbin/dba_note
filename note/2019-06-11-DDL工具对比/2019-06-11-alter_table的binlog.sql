

/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
DELIMITER /*!*/;
# at 4
#190611 17:52:19 server id 17  end_log_pos 123 CRC32 0x7edfbc6d         Start: binlog v 4, server v 5.7.24-log created 190611 17:52:19
# at 123
#190611 17:52:19 server id 17  end_log_pos 154 CRC32 0xa54f4054         Previous-GTIDs
# [empty]
# at 154
#190611 17:59:42 server id 17  end_log_pos 219 CRC32 0x0627169d         Anonymous_GTID  last_committed=0        sequence_number=1       rbr_only=no
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 219
#190611 17:59:42 server id 17  end_log_pos 365 CRC32 0xcfed6e03         Query   thread_id=788   exec_time=88    error_code=0
use `nn_recovery_db`/*!*/;
SET TIMESTAMP=1560247182/*!*/;
SET @@session.pseudo_thread_id=788/*!*/;
SET @@session.foreign_key_checks=1, @@session.sql_auto_is_null=0, @@session.unique_checks=1, @@session.autocommit=1/*!*/;
SET @@session.sql_mode=1075838976/*!*/;
SET @@session.auto_increment_increment=1, @@session.auto_increment_offset=1/*!*/;
/*!\C utf8mb4 *//*!*/;
SET @@session.character_set_client=45,@@session.collation_connection=45,@@session.collation_server=45/*!*/;
SET @@session.lc_time_names=0/*!*/;
SET @@session.collation_database=DEFAULT/*!*/;
alter table table_test drop column aa
/*!*/;
# at 365
#190611 18:13:31 server id 17  end_log_pos 430 CRC32 0xf16e7209         Anonymous_GTID  last_committed=1        sequence_number=2       rbr_only=no
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 430
#190611 18:13:31 server id 17  end_log_pos 614 CRC32 0xd5e94070         Query   thread_id=788   exec_time=87    error_code=0
SET TIMESTAMP=1560248011/*!*/;
alter table table_test add column aa int(10) not null default 0 comment 'a'
/*!*/;
# at 614
#190611 18:26:02 server id 17  end_log_pos 661 CRC32 0xbee87849         Rotate to mysql-bin.000078  pos: 4
SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
DELIMITER ;
# End of log file
/*!50003 SET COMPLETION_TYPE=@OLD_COMPLETION_TYPE*/;
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=0*/;
~                                                                                               