



8.0.18	
	
---
LOG
---
Log sequence number          2413947254
Log buffer assigned up to    2413947254
Log buffer completed up to   2413947254
Log written up to            2413947254
Log flushed up to            2413947254
Added dirty pages up to      2413947254
Pages flushed up to          2413947254
Last checkpoint at           2413947254


	
show global variables like '%innodb_flush_log%';
show global variables like '%sync_binlog%';


DROP table IF EXISTS `t`;
CREATE TABLE `t` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `c` int(11) DEFAULT NULL,
  `d` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `c` (`c`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;
insert into t(c,d) values(1,1); 
select * from t;


---
LOG
---
Log sequence number          2413976812
Log buffer assigned up to    2413976812
Log buffer completed up to   2413976812
Log written up to            2413976812
Log flushed up to            2413976812
Added dirty pages up to      2413976812
Pages flushed up to          2413976812
Last checkpoint at           2413976812


begin;
insert into t(c,d) values(2,2); 

LOG
---
Log sequence number          2413979721
Log buffer assigned up to    2413979721
Log buffer completed up to   2413979721
Log written up to            2413979721
Log flushed up to            2413979721
Added dirty pages up to      2413979721
Pages flushed up to          2413979721
Last checkpoint at           2413979721
72 log i/o's done, 0.00 log i/o's/second


begin;
insert into t(c,d) values(2,2); 
commit;

---
LOG
---
Log sequence number          2413980438
Log buffer assigdned up to    2413980438
Log buffer completed up to   2413980438
Log written up to            2413980438        redo 日志写入的LSN
Log flushed up to            2413980438		   redo 日志已经刷盘的LSN
Added dirty pages up to      2413980438        脏页已经写入到内存的LSN
Pages flushed up to          2413980438		   脏页已经刷盘的LSN
Last checkpoint at           2413980438

-- 这个就比5.7版本的好理解了。

