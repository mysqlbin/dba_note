LATEST DETECTED DEADLOCK
------------------------
2021-01-14 06:06:16 0x7f94ab1f7700
*** (1) TRANSACTION:
TRANSACTION 51049366, ACTIVE 1 sec inserting
mysql tables in use 1, locked 1
LOCK WAIT 93 lock struct(s), heap size 24784, 6646 row lock(s), undo log entries 3620
MySQL thread id 31826036, OS thread handle 140282680674048, query id 163814547 10.10.137.140 tangdou update
INSERT INTO `course_watch_time_s`(`course_id`, `sid`, `uid`, `watch_time`) VALUES(201, 3808, 229203, 162),(201, 3808, 730182, 1145),(201, 3808, 16499868, 6239),(201, 3809, 258205, 9610),(201, 3809, 22622101, 7204),(201, 3810, 5661716, 187),(201, 3810, 8082534, 6081),(201, 3810, 10951920, 7061),(201, 3810, 20067284, 3217),(201, 3810, 22819889, 73),(201, 3811, 371252, 6998),(201, 3811, 12443344, 6598),(201, 3811, 22994324, 0),(201, 3812, 3585698, 0),(201, 3812, 10952417, 652),(201, 3813, 10952417, 3967),(201, 3813, 16125535, 0),(201, 3813, 22622101, 5820),(201, 3813, 23381263, 40),(202, 5200, 7440650, 0),(203, 3815, 537441, 0),(203, 3815, 7961496, 1861),(203, 3815, 10683760, 6098),(203, 3815, 23262363, 213),(203, 3816, 4067262, 1596),(203, 3817, 837815, 6137),(203, 3818, 2623576, 4227),(203, 3818, 9539162, 5940),(203, 3818, 22682514, 6199),(203, 3818, 23433009, 6307),(203, 3819, 2426256, 0),(203, 3819, 1
*** (1) WAITING FOR THIS LOCK TO BE GRANTED:
RECORD LOCKS space id 89 page no 249 n bits 704 index sid of table `live_data_report`.`course_watch_time_s` trx id 51049366 lock_mode X locks gap before rec insert intention waiting
Record lock, heap no 538 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001451; asc    Q;;
 1: len 8; hex 800000000000cbc2; asc         ;;
 2: len 8; hex 0000000000013fca; asc       ? ;;

*** (2) TRANSACTION:
TRANSACTION 51049367, ACTIVE 0 sec inserting, thread declared inside InnoDB 4926
mysql tables in use 1, locked 1
206 lock struct(s), heap size 41168, 17608 row lock(s), undo log entries 9775
MySQL thread id 31825989, OS thread handle 140276502853376, query id 163814630 10.10.137.140 tangdou update
INSERT INTO `course_watch_time_s`(`course_id`, `sid`, `uid`, `watch_time`) VALUES(374, 5307, 26183040, 15592),(374, 5307, 26184310, 6484),(374, 5308, 67720, 17806),(374, 5308, 171977, 872),(374, 5308, 186721, 0),(374, 5308, 245289, 9798),(374, 5308, 279907, 0),(374, 5308, 280485, 774),(374, 5308, 314590, 0),(374, 5308, 333029, 364),(374, 5308, 333852, 0),(374, 5308, 338082, 0),(374, 5308, 383339, 0),(374, 5308, 491028, 17850),(374, 5308, 823942, 0),(374, 5308, 881404, 1498),(374, 5308, 1390448, 4950),(374, 5308, 1791062, 10518),(374, 5308, 2065138, 1500),(374, 5308, 2592171, 0),(374, 5308, 2604266, 15284),(374, 5308, 2649824, 1330),(374, 5308, 2697197, 9932),(374, 5308, 2920209, 0),(374, 5308, 3083205, 12238),(374, 5308, 3160607, 0),(374, 5308, 3443550, 18878),(374, 5308, 3918867, 16746),(374, 5308, 4603109, 21846),(374, 5308, 4742337, 0),(374, 5308, 5049293, 6102),(374, 5308, 5060774, 58),(374, 5308, 
*** (2) HOLDS THE LOCK(S):
RECORD LOCKS space id 89 page no 249 n bits 704 index sid of table `live_data_report`.`course_watch_time_s` trx id 51049367 lock_mode X locks gap before rec
Record lock, heap no 16 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 8000000000e9a0de; asc         ;;
 2: len 8; hex 0000000000003df5; asc       = ;;

Record lock, heap no 23 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 80000000013da05e; asc      = ^;;
 2: len 8; hex 0000000000003dfc; asc       = ;;

Record lock, heap no 24 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 800000000141b2a4; asc      A  ;;
 2: len 8; hex 0000000000003dfd; asc       = ;;

Record lock, heap no 26 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 80000000015e767a; asc      ^vz;;
 2: len 8; hex 0000000000003dff; asc       = ;;

Record lock, heap no 30 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001447; asc    G;;
 1: len 8; hex 80000000017172fe; asc      qr ;;
 2: len 8; hex 0000000000003e03; asc       > ;;

Record lock, heap no 39 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 80000000001c7686; asc       v ;;
 2: len 8; hex 0000000000003e0c; asc       > ;;

Record lock, heap no 40 PHYSICAL RECORD: n_fields 3; compact format; info bits 0
 0: len 4; hex 80001448; asc    H;;
 1: len 8; hex 80000000002d94ba; asc      -  ;;
 2: len 8; hex 0000000000003e0d; asc       > ;;

表信息：
CREATE TABLE `course_watch_time_s` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `course_id` int(11) NOT NULL DEFAULT '0' COMMENT '课程id',
  `sid` int(11) NOT NULL DEFAULT '0' COMMENT '小课sid',
  `uid` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户uid',
  `watch_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '累计的观看（观看直播&回放）时长',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sid` (`sid`,`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=96501 DEFAULT CHARSET=utf8mb4 COMMENT='学员观看时长（小课）'   