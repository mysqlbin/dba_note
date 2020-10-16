
drop table  if exists drop_table_list; 

CREATE TABLE `drop_table_list` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `drop_table_list` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='drop_table_list';



drop procedure  if exists pr_auto_drop_table_shard; 
CREATE PROCEDURE `pr_auto_drop_table_shard`(
	IN $startTime VARCHAR(30),
	IN $endTime VARCHAR(30),
	out $returnVal int
)
returnVal:begin
	
	declare i int;
	set i=1;
	
	SELECT (DATEDIFF($endTime,$startTime)) +1 into @intervals;
	set @startTime=$startTime;
	
	select date_format($startTime,'%Y%m%d') into @beginTime;
	select date_format($endTime,'%Y%m%d') into @stopTime;
	select DATE_FORMAT(DATE_SUB(NOW(),INTERVAL 93 DAY),'%Y%m%d') into @lastTime;

	if (@beginTime > @lastTime)  or (@stopTime > @lastTime) then
		set $returnVal=0;
		leave returnVal;
	end if;

	while(i<=@intervals) do

		SET @dateTable=date_format(@startTime,'%Y%m%d');
		
		set @sqlStrScoreDrop=concat("drop table if exists t1",@dateTable,";");
		-- select @sqlStrScoreDrop;
		
		insert into drop_table_list(`drop_table_list`) values(@sqlStrScoreDrop);
		
		set @sqlStrDetailDrop=concat("drop table if exists t2",@dateTable,";");
		insert into drop_table_list(`drop_table_list`) values(@sqlStrDetailDrop);
		-- select @sqlStrDetailDrop;
	
		set @sqlStrThirdDrop=concat("drop table if exists t3",@dateTable,";");
		insert into drop_table_list(`drop_table_list`) values(@sqlStrThirdDrop);
		-- select @sqlStrThirdDrop;
	
		set i=i+1;
		SET @startTime=DATE_ADD(@startTime,INTERVAL 1 DAY);
		
	end while;
	
	set $returnVal=1;

END
;;
DELIMITER ;


call pr_auto_drop_table_shard('2020-05-01', '2020-05-31', @returnVal);
select @returnVal;


