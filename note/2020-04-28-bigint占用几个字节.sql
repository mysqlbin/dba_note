






CREATE TABLE `table_bigint` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113410344 DEFAULT CHARSET=utf8mb4;


drop procedure if exists proc;
delimiter $$
create procedure proc(i int)
begin
    declare s int default 1;
    
    while s<=i do
        start transaction;
        INSERT INTO table_bigint () values ();
        commit;
        set s=s+1;
    end while;
end$$
delimiter ;


root@mysqldb 18:29:  [sbtest]> select count(*) from table_bigint;
+-----------+
| count(*)  |
+-----------+
| 100000000 |
+-----------+
1 row in set (18.00 sec)


1亿行记录, 物理大小3GB.


root@mysqldb 18:30:  [sbtest]> SELECT  table_schema,table_name,round((data_length/1024/1024/1024), 2) AS data_gb,round((index_length/1024/1024/1024),2) AS index_gb,round((data_length + index_length)/1024/1024/1024, 2) AS all_gb, 
    -> round((data_free/1024/1024/1024),2) AS free_gb, table_rows FROM
    -> information_schema.tables  where table_schema = 'sbtest' and table_name = 'sbtest1';
+--------------+------------+---------+----------+--------+---------+------------+
| table_schema | table_name | data_gb | index_gb | all_gb | free_gb | table_rows |
+--------------+------------+---------+----------+--------+---------+------------+
| sbtest       | sbtest1    |   24.87 |    12.93 |  37.80 |    0.00 |  103035636 |
+--------------+------------+---------+----------+--------+---------+------------+
1 row in set (0.01 sec)


[root@voice sbtest]# ls -lht  table_bigint.ibd 
-rw-r----- 1 mysql mysql 3.1G Apr 29 15:33 table_bigint.ibd


经过测试，当该表达到1亿行记录，物理大小为3GB。

