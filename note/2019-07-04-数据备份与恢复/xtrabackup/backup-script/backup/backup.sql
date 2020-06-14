CREATE TABLE `backup_done_list` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `host_id` int(10) unsigned NOT NULL,
  `dbname` varchar(20) DEFAULT NULL,
  `target_dir` varchar(512) DEFAULT NULL,
  `src_dir` varchar(512) DEFAULT NULL,
  `backup_size` int(11) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `is_ok` enum('Y','N') DEFAULT 'Y',
  PRIMARY KEY (`id`),
  UNIQUE KEY `udx_dbname_host_id` (`dbname`,`host_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE `backup_task_list` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `host_id` int(10) unsigned NOT NULL,
  `dbname` varchar(20) DEFAULT NULL,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL,
  `port` int(11) DEFAULT '3306',
  `defaults_file` varchar(512) DEFAULT NULL,
  `datadir` varchar(512) DEFAULT NULL,
  `backup_path` varchar(512) DEFAULT NULL,
  `level` tinyint(4) DEFAULT '0',
  `flag` enum('Y','N') DEFAULT 'Y',
  `add_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_dbname` (`dbname`,`host_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;


