

CREATE TABLE `t` (
  `id` int(11) NOT NULL,
  `c` int(11) DEFAULT NULL,
  `d` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `c` (`c`)
) ENGINE=InnoDB;
    
insert into t values(0,0,0),(5,5,5),
(10,10,10),(15,15,15),(20,20,20),(25,25,25);    



set global transaction isolation level READ UNCOMMITTED;
show global variables like 'tx_isolation';
mysql> show global variables like 'tx_isolation';
+---------------+------------------+
| Variable_name | Value            |
+---------------+------------------+
| tx_isolation  | READ-UNCOMMITTED |
+---------------+------------------+
1 row in set (0.01 sec)



session A                       session B
begin;
								begin;
select * from t where id=5;
+----+------+------+
| id | c    | d    |
+----+------+------+
|  5 |    5 |    5 |
+----+------+------+
1 row in set (0.00 sec)

								update t set c=c+1 where id=5;
select * from t where id=5;
+----+------+------+
| id | c    | d    |
+----+------+------+
|  5 |    6 |    5 |
+----+------+------+
1 row in set (0.00 sec)




