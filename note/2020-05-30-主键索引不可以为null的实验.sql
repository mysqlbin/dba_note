


drop table if exists t3;
CREATE TABLE `t3` (
  `id` bigint(11),
  `c` int(11) DEFAULT NULL,
  `d` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `c` (`c`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;



[SQL]drop table if exists t3;
受影响的行: 0
时间: 0.122s


主键索引为bigint类型, 主键索引不可以为null
	CREATE TABLE `t3` (
	  `id` bigint(11) DEFAULT NULL,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;
	[Err] 1171 - All parts of a PRIMARY KEY must be NOT NULL; if you need NULL in a key, use UNIQUE instead


主键索引为varchar类型, 主键索引不可以为null
	CREATE TABLE `t3` (
	  `id` varchar(20) DEFAULT NULL,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;
	[Err] 1171 - All parts of a PRIMARY KEY must be NOT NULL; if you need NULL in a key, use UNIQUE instead





