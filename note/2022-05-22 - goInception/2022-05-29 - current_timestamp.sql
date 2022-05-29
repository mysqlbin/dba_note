CREATE TABLE `t_2022052903` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT "id",
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT  '0000-00-00 00:00:00'  ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) COMMENT="test"

	-- OK


CREATE TABLE `t_2022052903` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) COMMENT="test"


	Column 'id' in table 't_2022052903' have no comments.
	Incorrect table definition; there can be only one TIMESTAMP column with CURRENT_TIMESTAMP in DEFAULT or ON UPDATE clause
	

CREATE TABLE `t_2022052905` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT "id",
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) COMMENT="test"
	
	
	Incorrect table definition; there can be only one TIMESTAMP column with CURRENT_TIMESTAMP in DEFAULT or ON UPDATE clause


	



CREATE TABLE `t_2022052906` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT "id",
  `create_time` timestamp NOT NULL DEFAULT  '0000-00-00 00:00:00'  ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_time`timestamp NOT NULL DEFAULT  CURRENT_TIMESTAMP  ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) COMMENT="test"
	
	
	Incorrect table definition; there can be only one TIMESTAMP column with CURRENT_TIMESTAMP in DEFAULT or ON UPDATE clause
	
	
多个 timestamp 时间类型字段：
	如果某个字段指定了 DEFAULT CURRENT_TIMESTAMP，另1字段不能再指定 DEFAULT CURRENT_TIMESTAMP 。
	如果某个字段指定了 ON UPDATE CURRENT_TIMESTAMP，另1字段不能再指定 ON UPDATE CURRENT_TIMESTAMP 。
