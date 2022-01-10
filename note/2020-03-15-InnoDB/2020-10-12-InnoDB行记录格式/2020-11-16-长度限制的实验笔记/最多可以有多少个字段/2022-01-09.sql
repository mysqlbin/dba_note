

制造相关数据

drop table if exists table_20220109;
CREATE TABLE `table_20220109` (
  `id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP PROCEDURE IF EXISTS insertbatch_20201116;
CREATE PROCEDURE insertbatch_20201116()
BEGIN
DECLARE i INT;
  SET i=1;
	start transaction;
  WHILE(i<=5000) DO
	INSERT INTO table_20220109(id)VALUES(i);
	SET i=i+1; 
  END WHILE;
	commit;
END;


call insertbatch_20201116();


	


https://dev.mysql.com/doc/refman/5.7/en/column-count-limit.html

https://www.modb.pro/db/31532		
