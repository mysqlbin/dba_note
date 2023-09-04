

drop table  if exists t;
CREATE TABLE `t` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `c` int(11) DEFAULT NULL,
  `d` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `c` (`c`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

insert into t(c,d) values(1,1);
insert into t(c,d) values(2,2);
insert into t(c,d) values(3,3);
insert into t(c,d) values(4,4);
insert into t(c,d) values(5,5);
insert into t(c,d) values(6,6);
insert into t(c,d) values(7,7);
insert into t(c,d) values(8,8);
insert into t(c,d) values(9,9);
insert into t(c,d) values(10,10);
insert into t(c,d) values(11,11);
insert into t(c,d) values(12,12);
insert into t(c,d) values(13,13);
insert into t(c,d) values(14,14);
insert into t(c,d) values(15,15);

mysql> SELECT * FROM t;
+----+------+------+
| id | c    | d    |
+----+------+------+
|  1 |    1 |    1 |
|  2 |    2 |    2 |
|  3 |    3 |    3 |
|  4 |    4 |    4 |
|  5 |    5 |    5 |
|  6 |    6 |    6 |
|  7 |    7 |    7 |
|  8 |    8 |    8 |
|  9 |    9 |    9 |
| 10 |   10 |   10 |
| 11 |   11 |   11 |
| 12 |   12 |   12 |
| 13 |   13 |   13 |
| 14 |   14 |   14 |
| 15 |   15 |   15 |
+----+------+------+
15 rows in set (0.01 sec)




						

--------------------------------------------------------------------------------------------------

The current lock types are:

TL_READ	 		# Low priority read
TL_READ_WITH_SHARED_LOCKS
TL_READ_HIGH_PRIORITY	# High priority read
TL_READ_NO_INSERT	# Read without concurrent inserts
TL_WRITE_ALLOW_WRITE	# Write lock that allows other writers
TL_WRITE_CONCURRENT_INSERT
			# Insert that can be mixed when selects
			# Allows lower locks to take over
TL_WRITE_LOW_PRIORITY	# Low priority write
TL_WRITE		# High priority write
TL_WRITE_ONLY		# High priority write
			# Abort all new lock request with an error
			
			
---------------------------------------------------------------------------------------------------------------------------------------------------			
	
/*
	将表的统计信息返回给MySQL解释器，在handle对象的各个领域
*/
/*********************************************************************//**
Returns statistics information of the table to the MySQL interpreter,
in various fields of the handle object.
@return HA_ERR_* error code or 0 */

int
ha_innobase::info_low(
/*==================*/
	uint	flag,	/*!< in: what information is requested */
	bool	is_analyze)
{


