
InnoDB引擎下 事务频繁申请锁资源 或者持续占有锁资源，很耗费CPU。

*************************** 1. row ***************************
     Id: 2
   User: root
   Host: localhost
     db: 4006787252
Command: Sleep
   Time: 235
  State: 
   Info: NULL
*************************** 2. row ***************************
     Id: 25
   User: root
   Host: localhost
     db: 4006787252
Command: Query
   Time: 112
  State: Locked
   Info: UPDATE espcms_document SET click=click+1 WHERE isclass=1 AND did=6814
*************************** 3. row ***************************
     Id: 30
   User: root
   Host: localhost
     db: 4006787252
Command: Query
   Time: 107
  State: Locked
   Info: SELECT c.*,b.*,a.* FROM espcms_document AS a
			   LEFT JOIN espcms_document_content AS b ON a.did =
*************************** 4. row ***************************
     Id: 31
   User: root
   Host: localhost
     db: 4006787252
Command: Query
   Time: 105
  State: Locked
   Info: UPDATE espcms_document SET click=click+1 WHERE isclass=1 AND did=3251
*************************** 5. row ***************************
     Id: 35
   User: root
   Host: localhost
     db: 4006787252
Command: Sleep
   Time: 149
  State: 
   Info: NULL
*************************** 6. row ***************************
     Id: 36
   User: root
   Host: localhost
     db: 4006787252
Command: Query
   Time: 3
  State: Locked
   Info: SELECT tid,COUNT(did) AS num FROM espcms_document WHERE lng='cn' AND mid=3 GROUP BY tid
*************************** 7. row ***************************
     Id: 37
   User: root
   Host: localhost
     db: 4006787252
Command: Query
   Time: 142
  State: Sending data
   Info: SELECT COUNT(*) AS num FROM espcms_document AS a LEFT JOIN espcms_document_attr AS b ON a.did=b.did 
*************************** 8. row ***************************
     Id: 38
   User: root
   Host: localhost
     db: 4006787252
Command: Query
   Time: 90
  State: Locked
   Info: SELECT COUNT(*) AS num FROM espcms_document WHERE isclass=1 AND mid=3 AND sid=66
*************************** 9. row ***************************
     Id: 40
   User: root
   
   

CREATE TABLE `espcms_document` (
  `did` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `lng` varchar(50) NOT NULL DEFAULT 'cn',
  `pid` smallint(6) unsigned NOT NULL DEFAULT '50',
  `mid` smallint(6) unsigned NOT NULL DEFAULT '0',
  `aid` smallint(6) unsigned NOT NULL DEFAULT '0',
  `tid` int(11) unsigned NOT NULL DEFAULT '0',
  `extid` varchar(200) NOT NULL,
  `sid` int(11) unsigned NOT NULL DEFAULT '0',
  `fgid` int(8) unsigned NOT NULL DEFAULT '0',
  `linkdid` varchar(100) NOT NULL,
  `isclass` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `islink` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ishtml` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `ismess` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `isorder` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ktid` int(6) unsigned NOT NULL DEFAULT '0',
  `purview` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `istemplates` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isbase` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `recommend` varchar(100) NOT NULL,
  `tsn` varchar(50) NOT NULL DEFAULT '',
  `title` varchar(200) NOT NULL,
  `longtitle` varchar(200) NOT NULL,
  `color` varchar(8) NOT NULL,
  `author` char(20) NOT NULL,
  `source` char(30) NOT NULL,
  `pic` varchar(200) NOT NULL,
  `tags` varchar(250) NOT NULL,
  `headtitle` varchar(200) NOT NULL,
  `keywords` varchar(220) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `summary` text NOT NULL,
  `link` varchar(250) NOT NULL,
  `oprice` decimal(10,2) NOT NULL DEFAULT '0.00',
  `bprice` decimal(10,2) NOT NULL DEFAULT '0.00',
  `click` smallint(6) unsigned NOT NULL DEFAULT '0',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0',
  `uptime` int(11) unsigned NOT NULL DEFAULT '0',
  `template` varchar(100) NOT NULL,
  `filename` varchar(100) NOT NULL DEFAULT '',
  `filepath` varchar(200) NOT NULL,
  `filepage` smallint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`did`)
) ENGINE=MyISAM AUTO_INCREMENT=16131 DEFAULT CHARSET=utf8;


alter table espcms_document add index idx_mid_sid_isclass(`mid`,`sid`,`isclass`);
alter table espcms_document add index idx_mid_lng(`mid`,`lng`(2)); 


重点在这条SQL: 其它SQL都被Locked住了， 只有下面这条SQL是正在执行的（State: Sending data）
*************************** 7. row ***************************
     Id: 37
   User: root
   Host: localhost
     db: 4006787252
Command: Query
   Time: 142
  State: Sending data
   Info: SELECT COUNT(*) AS num FROM espcms_document AS a LEFT JOIN espcms_document_attr AS b ON a.did=b.did 

kill 掉这个 线程就行。

kill 37。



