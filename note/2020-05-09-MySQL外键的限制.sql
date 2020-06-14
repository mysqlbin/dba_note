
pt-osc 和 gh-ost 都不支持外键
可以看下面的验证


CREATE TABLE `t1_1` (
  `id` int(10) unsigned NOT NULL,
  `c2` int(10) NOT NULL DEFAULT '0' COMMENT 'c2字段来了',
  `c3` int(10) NOT NULL DEFAULT '0' COMMENT 'c3字段来了',
  `c4` int(10) NOT NULL DEFAULT '0' COMMENT 'c4字段来了',
  `c5` int(10) NOT NULL DEFAULT '0' COMMENT 'c5字段来了',
  PRIMARY KEY (`id`),
  KEY `idx_c2` (`c2`),
  KEY `idx_c3` (`c3`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `sbtest`.`t1_1` (`id`, `c2`, `c3`, `c4`, `c5`) VALUES ('1', '0', '0', '0', '0');

CREATE TABLE `t1_1_foreign` (
  `id` int(10) unsigned NOT NULL,
  `c2` int(10) NOT NULL DEFAULT '0' COMMENT 'c2字段来了',
  foreign key(id) references t1_1(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `sbtest`.`t1_1_foreign` (`id`, `c2`) VALUES ('1', '1');


pt-osc
	time pt-online-schema-change --max-lag=1000 --no-check-replication-filters --charset=utf8mb4 --execute --alter "engine=InnoDB" --user=root --password=123456abc --host=192.168.0.91 D=sbtest,t=t1_1
	[root@kp04 tmp]# time pt-online-schema-change --max-lag=1000 --no-check-replication-filters --charset=utf8mb4 --execute --alter "engine=InnoDB" --user=root --password=123456abc --host=192.168.0.91 D=sbtest,t=t1_1
	Found 1 slaves:
	kp05 -> 192.168.0.92:socket
	Will check slave lag on:
	kp05 -> 192.168.0.92:socket
	*******************************************************************
	 Using the default of SSL_verify_mode of SSL_VERIFY_NONE for client
	 is deprecated! Please set SSL_verify_mode to SSL_VERIFY_PEER
	 possibly with SSL_ca_file|SSL_ca_path for verification.
	 If you really don't want to verify the certificate and keep the
	 connection open to Man-In-The-Middle attacks please set
	 SSL_verify_mode explicitly to SSL_VERIFY_NONE in your application.
	*******************************************************************
	  at /usr/bin/pt-online-schema-change line 6949.
	*******************************************************************
	 Using the default of SSL_verify_mode of SSL_VERIFY_NONE for client
	 is deprecated! Please set SSL_verify_mode to SSL_VERIFY_PEER
	 possibly with SSL_ca_file|SSL_ca_path for verification.
	 If you really don't want to verify the certificate and keep the
	 connection open to Man-In-The-Middle attacks please set
	 SSL_verify_mode explicitly to SSL_VERIFY_NONE in your application.
	*******************************************************************
	  at /usr/bin/pt-online-schema-change line 6949.

	# A software update is available:
	Operation, tries, wait:
	  analyze_table, 10, 1
	  copy_rows, 10, 0.25
	  create_triggers, 10, 1
	  drop_triggers, 10, 1
	  swap_tables, 10, 1
	  update_foreign_keys, 10, 1
	Child tables:
	  `sbtest`.`t1_1_foreign` (approx. 1 rows)
	You did not specify --alter-foreign-keys-method, but there are foreign keys that reference the table. Please read the tool's documentation carefully.

	real	0m22.906s
	user	0m0.350s
	sys	0m0.126s


gh-ost

	/root/ghost/gh-ost \
	--max-load=Threads_running=20 \
	--critical-load=Threads_running=50 \
	--critical-load-interval-millis=5000 \
	--chunk-size=1000 \
	--user="root" \
	--password="123456abc" \
	--host='192.168.0.91' \
	--port=3306 \
	--database="sbtest" \
	--table="t1_1" \
	--verbose \
	--alter="engine=innodb" \
	--assume-rbr \
	--cut-over=default \
	--cut-over-lock-timeout-seconds=1 \
	--dml-batch-size=10 \
	--allow-on-master \
	--concurrent-rowcount \
	--default-retries=10 \
	--heartbeat-interval-millis=100 \
	--panic-flag-file=/tmp/ghost.panic.flag \
	--ok-to-drop-table \
	--execute 2>&1 | tee  /tmp/rebuild_t1_1.log


	2020-05-09 15:44:03 ERROR Found 1 parent-side foreign keys on `sbtest`.`t1_1`. Parent-side foreign keys are not supported. Bailing out
	2020-05-09 15:44:03 INFO Tearing down inspector
	2020-05-09 15:44:03 FATAL 2020-05-09 15:44:03 ERROR Found 1 parent-side foreign keys on `sbtest`.`t1_1`. Parent-side foreign keys are not supported. Bailing out

	
	
