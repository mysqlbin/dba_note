

https://www.cnblogs.com/dongml/p/10953846.html	 mysql limit和offset用法


CREATE TABLE `trade_detail` (
  `id` int(11) NOT NULL,
  `tradeid` varchar(32) NOT NULL,
  `trade_step` tinyint(4) NOT NULL,
  `step_info` varchar(32) NOT NULL,
  `step_data` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `idx_tradeid_step_info_trade_step` (`tradeid`,`step_info`,`trade_step`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `test_db`.`trade_detail` (`id`, `tradeid`, `trade_step`, `step_info`, `step_data`) VALUES ('1', 'aaaaaaaa', '1', 'add', '');
INSERT INTO `test_db`.`trade_detail` (`id`, `tradeid`, `trade_step`, `step_info`, `step_data`) VALUES ('2', 'aaaaaaaa', '2', 'update', '');
INSERT INTO `test_db`.`trade_detail` (`id`, `tradeid`, `trade_step`, `step_info`, `step_data`) VALUES ('3', 'aaaaaaaa', '3', 'commit', '');
INSERT INTO `test_db`.`trade_detail` (`id`, `tradeid`, `trade_step`, `step_info`, `step_data`) VALUES ('4', 'aaaaaaab', '6', 'add', '');
INSERT INTO `test_db`.`trade_detail` (`id`, `tradeid`, `trade_step`, `step_info`, `step_data`) VALUES ('5', 'aaaaaaab', '7', 'update', '');
INSERT INTO `test_db`.`trade_detail` (`id`, `tradeid`, `trade_step`, `step_info`, `step_data`) VALUES ('6', 'aaaaaaab', '8', 'update again', '');
INSERT INTO `test_db`.`trade_detail` (`id`, `tradeid`, `trade_step`, `step_info`, `step_data`) VALUES ('7', 'aaaaaaab', '9', 'commit', '');
INSERT INTO `test_db`.`trade_detail` (`id`, `tradeid`, `trade_step`, `step_info`, `step_data`) VALUES ('8', 'aaaaaaac', '10', 'add', '');
INSERT INTO `test_db`.`trade_detail` (`id`, `tradeid`, `trade_step`, `step_info`, `step_data`) VALUES ('9', 'aaaaaaac', '11', 'update', '');
INSERT INTO `test_db`.`trade_detail` (`id`, `tradeid`, `trade_step`, `step_info`, `step_data`) VALUES ('10', 'aaaaaaac', '3', 'update again', '');
INSERT INTO `test_db`.`trade_detail` (`id`, `tradeid`, `trade_step`, `step_info`, `step_data`) VALUES ('11', 'aaaaaaad', '4', 'commit', '');


mysql> select id from trade_detail order by id asc limit 5 offset 2;
+----+
| id |
+----+
|  3 |
|  4 |
|  5 |
|  6 |
|  7 |
+----+
5 rows in set (0.00 sec)


limit 5 offset 2;	
	取5条，从第3条开始取。
	
