

DROP TABLE IF EXISTS `table_game_config`;
CREATE TABLE `table_game_config` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `GameName` VARCHAR(50) NOT NULL COMMENT '用户ID',
  `IconUrl` VARCHAR(256) NOT NULL COMMENT '图标URL',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 comment = '';

show create table table_game_config\G;
CREATE TABLE `table_game_config` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `GameName` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '用户ID',
  `IconUrl` varchar(256) CHARACTER SET utf8 NOT NULL COMMENT '图标URL',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='';

