

mysql> show global variables LIKE '%only%';
+-------------------------------+-------+
| Variable_name                 | Value |
+-------------------------------+-------+
| innodb_optimize_fulltext_only | OFF   |
| innodb_read_only              | OFF   |
| read_only                     | ON    |
| super_read_only               | OFF   |
| transaction_read_only         | OFF   |
| tx_read_only                  | OFF   |
+-------------------------------+-------+
6 rows in set (0.01 sec)




 create temporary table temp(id int, data char(20));
 insert into temp values(1, "Some");
 select * from temp;
  DROP TABLE temp;
  
mysql>  create temporary table temp(id int, data char(20));
Query OK, 0 rows affected (0.00 sec)

mysql>  insert into temp values(1, "Some");
Query OK, 1 row affected (0.00 sec)

mysql>  select * from temp;
+------+------+
| id   | data |
+------+------+
|    1 | Some |
+------+------+
1 row in set (0.00 sec)


mysql> delete from table_clublogscore20200701 where id=15004289;
ERROR 1290 (HY000): The MySQL server is running with the --read-only option so it cannot execute this statement

