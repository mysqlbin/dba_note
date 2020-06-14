


DROP TABLE IF EXISTS `t_order_by`;
CREATE TABLE `t_order_by` (
  `id` int(11) NOT NULL,
  `city` varchar(16) NOT NULL,
  `name` varchar(16) NOT NULL,
  `age` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_city_name` (`city`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of t_order_by
-- ----------------------------
INSERT INTO `t_order_by` VALUES ('1', '杭州', '卢aa', '26');
INSERT INTO `t_order_by` VALUES ('2', '苏州', '张六', '28');
INSERT INTO `t_order_by` VALUES ('3', '杭州', 'awb', '26');
INSERT INTO `t_order_by` VALUES ('4', '苏州', 'baj', '26');



select * from (

select * from t_order_by where city = '杭州' 
union all
select * from t_order_by where city = '苏州'
 
) as a order by a.name limit 2



root@mysqldb 01:38:  [admin_Db]> desc select * from (
    -> 
    -> select * from t_order_by where city = '杭州' 
    -> union all
    -> select * from t_order_by where city = '苏州'
    ->  
    -> ) as a order by a.name limit 2
    -> ;
+----+-------------+------------+------------+------+---------------+---------------+---------+-------+------+----------+----------------+
| id | select_type | table      | partitions | type | possible_keys | key           | key_len | ref   | rows | filtered | Extra          |
+----+-------------+------------+------------+------+---------------+---------------+---------+-------+------+----------+----------------+
|  1 | PRIMARY     | <derived2> | NULL       | ALL  | NULL          | NULL          | NULL    | NULL  |    4 |   100.00 | Using filesort |
|  2 | DERIVED     | t_order_by | NULL       | ref  | idx_city_name | idx_city_name | 66      | const |    2 |   100.00 | NULL           |
|  3 | UNION       | t_order_by | NULL       | ref  | idx_city_name | idx_city_name | 66      | const |    2 |   100.00 | NULL           |
+----+-------------+------------+------------+------+---------------+---------------+---------+-------+------+----------+----------------+
3 rows in set, 1 warning (0.00 sec)



