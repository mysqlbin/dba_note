

CREATE TABLE `t_auto` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='自增表';


drop procedure idata;
delimiter ;;
create procedure idata()
begin
  declare i int;
  set i=1;
  while(i<=100)do
    insert into t_auto values();
    set i=i+1;
  end while;
  
 
end;;
delimiter ;
call idata();
