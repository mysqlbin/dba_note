
		CREATE TABLE `table_clublogscore_partition` (
		  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '游戏ID',
		  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '桌号ID',
		  `nAmount` bigint(20) NOT NULL COMMENT '改变数量',
		  `szOrder` varchar(128) DEFAULT NULL COMMENT '现金网上下分时的订单号',
		  `operateID` int(11) DEFAULT NULL COMMENT '后台上下分时，对应操作者ID',
		  `nScore` bigint(20) NOT NULL COMMENT '剩余数量',
		  `nType` int(11) NOT NULL COMMENT '类型：1-系统赠送，2-系统扣除，3-俱乐部赠送，4-捐赠，5-游戏获得，6-游戏消耗，7-扣税，8-道具消耗，9-开房消耗，10-百人场消耗，11-百人场获得，12-百人场扣税',
		  `nSubType` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '后台上分子类型 1注册送金、2首充送金、3首登送金、4连续登陆送金，5投注送金、6银行卡充值返利、7天天投注送豪礼、8邀请好友送彩金、 9代理彩金奖上奖、10新人见面礼、11红包大闯关、0其他',
		  `nTaxRate` int(11) NOT NULL DEFAULT '0' COMMENT '税率整数，需除以1000（对应扣费时的税率）',
		  `szDesc` varchar(256) NOT NULL COMMENT '备注',
		  `clubid` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
		  PRIMARY KEY (`ID`,`CreateTime`),
		  KEY `idx_nPlayerID_clubid_CreateTime` (`nPlayerID`,`clubid`,`CreateTime`),
		  KEY `idx_clubid_nType_CreateTime` (`clubid`,`nType`,`CreateTime`),
		  KEY `idx_nType_CreateTime` (`nType`,`CreateTime`),
		  KEY `idx_CreateTime` (`CreateTime`)
		) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='玩家俱乐部积分变更Log分区表'
		PARTITION BY RANGE (unix_timestamp(createTime))
		(  
			PARTITION p20200409 VALUES LESS THAN (unix_timestamp('2020-04-09')) ENGINE = InnoDB,
			PARTITION p20200410 VALUES LESS THAN (unix_timestamp('2020-04-10')) ENGINE = InnoDB,
			PARTITION p20200411 VALUES LESS THAN (unix_timestamp('2020-04-11')) ENGINE = InnoDB,
			PARTITION p20200412 VALUES LESS THAN (unix_timestamp('2020-04-12')) ENGINE = InnoDB,
			PARTITION p20200413 VALUES LESS THAN (unix_timestamp('2020-04-13')) ENGINE = InnoDB,
			PARTITION p20200414 VALUES LESS THAN (unix_timestamp('2020-04-14')) ENGINE = InnoDB,
			PARTITION p20200415 VALUES LESS THAN (unix_timestamp('2020-04-15')) ENGINE = InnoDB,
			PARTITION p20200416 VALUES LESS THAN (unix_timestamp('2020-04-16')) ENGINE = InnoDB,
			PARTITION p20200417 VALUES LESS THAN (unix_timestamp('2020-04-17')) ENGINE = InnoDB,
			PARTITION p20200418 VALUES LESS THAN (unix_timestamp('2020-04-18')) ENGINE = InnoDB,
			PARTITION p20200419 VALUES LESS THAN (unix_timestamp('2020-04-19')) ENGINE = InnoDB,
			PARTITION p20200420 VALUES LESS THAN (unix_timestamp('2020-04-20')) ENGINE = InnoDB,
			PARTITION p20200421 VALUES LESS THAN (unix_timestamp('2020-04-21')) ENGINE = InnoDB,
			PARTITION p20200422 VALUES LESS THAN (unix_timestamp('2020-04-22')) ENGINE = InnoDB,
			PARTITION p20200423 VALUES LESS THAN (unix_timestamp('2020-04-23')) ENGINE = InnoDB
		);
		
		
		
[root@VM-0-110-centos ~]# ping 101.37.253.14
PING 101.37.253.14 (101.37.253.14) 56(84) bytes of data.
64 bytes from 101.37.253.14: icmp_seq=1 ttl=48 time=34.2 ms
^C
--- 101.37.253.14 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 34.286/34.286/34.286/0.000 ms
[root@VM-0-110-centos ~]# pt-online-schema-change --chunk-size-limit=20000 --no-check-replication-filters  --charset=utf8mb4 --execute --alter "add column filed_02 int(10) not null default 0 comment 'filed_02'" --user=code_viewer --password='@123456Abc.' --host=101.37.253.14 D=sbtest,t=table_clublogscore_partition
No slaves found.  See --recursion-method if host iZbp1co0b2dkojjkbk7r8cZ has slaves.
Not checking slave lag because no slaves were found and --check-slave-lag was not specified.
*******************************************************************
 Using the default of SSL_verify_mode of SSL_VERIFY_NONE for client
 is deprecated! Please set SSL_verify_mode to SSL_VERIFY_PEER
 possibly with SSL_ca_file|SSL_ca_path for verification.
 If you really don't want to verify the certificate and keep the
 connection open to Man-In-The-Middle attacks please set
 SSL_verify_mode explicitly to SSL_VERIFY_NONE in your application.
*******************************************************************
  at /bin/pt-online-schema-change line 7077.
*******************************************************************
 Using the default of SSL_verify_mode of SSL_VERIFY_NONE for client
 is deprecated! Please set SSL_verify_mode to SSL_VERIFY_PEER
 possibly with SSL_ca_file|SSL_ca_path for verification.
 If you really don't want to verify the certificate and keep the
 connection open to Man-In-The-Middle attacks please set
 SSL_verify_mode explicitly to SSL_VERIFY_NONE in your application.
*******************************************************************
  at /bin/pt-online-schema-change line 7077.

# A software update is available:
Operation, tries, wait:
  analyze_table, 10, 1
  copy_rows, 10, 0.25
  create_triggers, 10, 1
  drop_triggers, 10, 1
  swap_tables, 10, 1
  update_foreign_keys, 10, 1
Altering `sbtest`.`table_clublogscore_partition`...
Creating new table...
Created new table sbtest._table_clublogscore_partition_new OK.
Altering new table...
Altered `sbtest`.`_table_clublogscore_partition_new` OK.
2022-06-15T15:03:17 Creating triggers...
2022-06-15T15:03:17 Created triggers OK.
2022-06-15T15:03:17 Copying approximately 1 rows...
2022-06-15T15:03:17 Copied rows OK.
2022-06-15T15:03:17 Analyzing new table...
2022-06-15T15:03:17 Swapping tables...
2022-06-15T15:03:17 Swapped original and new tables OK.
2022-06-15T15:03:17 Dropping old table...
2022-06-15T15:03:17 Dropped old table `sbtest`.`_table_clublogscore_partition_old` OK.
2022-06-15T15:03:17 Dropping triggers...
2022-06-15T15:03:17 Dropped triggers OK.
Successfully altered `sbtest`.`table_clublogscore_partition`.




pt-online-schema-change --chunk-size-limit=20000 --no-check-replication-filters  --charset=utf8mb4 --execute --alter "add column filed_02 int(10) not null default 0 comment 'filed_02'" --user=code_viewer --password='@123456Abc.' --host=101.37.253.14 D=sbtest,t=table_clublogscore_partition



mysql> show create table table_clublogscore_partition\G;
*************************** 1. row ***************************
       Table: table_clublogscore_partition
Create Table: CREATE TABLE `table_clublogscore_partition` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '索引',
  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
  `nGameID` int(11) NOT NULL DEFAULT '0' COMMENT '游戏ID',
  `nTableID` int(11) NOT NULL DEFAULT '0' COMMENT '桌号ID',
  `nAmount` bigint(20) NOT NULL COMMENT '改变数量',
  `szOrder` varchar(128) DEFAULT NULL COMMENT '现金网上下分时的订单号',
  `operateID` int(11) DEFAULT NULL COMMENT '后台上下分时，对应操作者ID',
  `nScore` bigint(20) NOT NULL COMMENT '剩余数量',
  `nType` int(11) NOT NULL COMMENT '类型：1-系统赠送，2-系统扣除，3-俱乐部赠送，4-捐赠，5-游戏获得，6-游戏消耗，7-扣税，8-道具消耗，9-开房消耗，10-百人场消耗，11-百人场获得，12-百人场扣税',
  `nSubType` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '后台上分子类型 1注册送金、2首充送金、3首登送金、4连续登陆送金，5投注送金、6银行卡充值返利、7天天投注送豪礼、8邀请好友送彩金、 9代理彩金奖上奖、10新人见面礼、11红包大闯关、0其他',
  `nTaxRate` int(11) NOT NULL DEFAULT '0' COMMENT '税率整数，需除以1000（对应扣费时的税率）',
  `szDesc` varchar(256) NOT NULL COMMENT '备注',
  `clubid` int(11) DEFAULT '0' COMMENT '捐赠给哪个俱乐部或者其他',
  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
  `filed_02` int(10) NOT NULL DEFAULT '0' COMMENT 'filed_02',
  PRIMARY KEY (`ID`,`CreateTime`),
  KEY `idx_nPlayerID_clubid_CreateTime` (`nPlayerID`,`clubid`,`CreateTime`),
  KEY `idx_clubid_nType_CreateTime` (`clubid`,`nType`,`CreateTime`),
  KEY `idx_nType_CreateTime` (`nType`,`CreateTime`),
  KEY `idx_CreateTime` (`CreateTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='玩家俱乐部积分变更Log分区表'
/*!50100 PARTITION BY RANGE (unix_timestamp(createTime))
(PARTITION p20200409 VALUES LESS THAN (1586361600) ENGINE = InnoDB,
 PARTITION p20200410 VALUES LESS THAN (1586448000) ENGINE = InnoDB,
 PARTITION p20200411 VALUES LESS THAN (1586534400) ENGINE = InnoDB,
 PARTITION p20200412 VALUES LESS THAN (1586620800) ENGINE = InnoDB,
 PARTITION p20200413 VALUES LESS THAN (1586707200) ENGINE = InnoDB,
 PARTITION p20200414 VALUES LESS THAN (1586793600) ENGINE = InnoDB,
 PARTITION p20200415 VALUES LESS THAN (1586880000) ENGINE = InnoDB,
 PARTITION p20200416 VALUES LESS THAN (1586966400) ENGINE = InnoDB,
 PARTITION p20200417 VALUES LESS THAN (1587052800) ENGINE = InnoDB,
 PARTITION p20200418 VALUES LESS THAN (1587139200) ENGINE = InnoDB,
 PARTITION p20200419 VALUES LESS THAN (1587225600) ENGINE = InnoDB,
 PARTITION p20200420 VALUES LESS THAN (1587312000) ENGINE = InnoDB,
 PARTITION p20200421 VALUES LESS THAN (1587398400) ENGINE = InnoDB,
 PARTITION p20200422 VALUES LESS THAN (1587484800) ENGINE = InnoDB,
 PARTITION p20200423 VALUES LESS THAN (1587571200) ENGINE = InnoDB) */
1 row in set (0.00 sec)



