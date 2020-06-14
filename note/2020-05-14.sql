

time pt-online-schema-change  --no-check-replication-filters --charset=utf8mb4 --execute --alter "engine=InnoDB" --user=root --password=123456abc --host=192.168.0.91 D=db3,t=t


time pt-online-schema-change  --no-check-replication-filters --charset=utf8mb4 --execute --alter "engine=InnoDB" --user=root --password= --host D=sbtest,t=table_bigint


show global variables like '%isolation%';

show global variables like '%innodb_autoinc_lock_mode%';

show global variables like '%sync_binlog%';
show global variables like '%innodb_flush%';



DROP PROCEDURE IF EXISTS `idata2`;
DELIMITER ;;
CREATE DEFINER=`liaodaiguo`@`%` PROCEDURE `idata`()
begin
  declare i int;
  set i=1;
	
  while(i<=500000) do
    INSERT INTO t (c,d) values (i,i);
    set i=i+1;
  end while;
	
end
;;
DELIMITER ;


500001