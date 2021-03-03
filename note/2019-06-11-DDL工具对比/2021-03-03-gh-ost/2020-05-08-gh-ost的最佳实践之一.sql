
1. 连接到主库执行
1.1 这种方式会一直执行, 估计是加了postpone-cut-over-flag-file参数的原因
1.2 不删除旧表, 没有 postpone-cut-over-flag-file 参数
1.3 删除旧表, 没有postpone-cut-over-flag-file参数

2. 连接到从库执行
2.1 删除旧表, 没有postpone-cut-over-flag-file参数

3. 添加/删除字段/索引和重建表



1. 连接到主库执行
1.1 这种方式会一直执行, 估计是加了postpone-cut-over-flag-file参数的原因

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
	--table="t1_10w" \
	--verbose \
	--alter="engine=innodb" \
	--assume-rbr \
	--cut-over=default \
	--cut-over-lock-timeout-seconds=1 \
	--dml-batch-size=10 \
	--allow-on-master \
	--concurrent-rowcount \
	--default-retries=10 \
	--heartbeat-interval-millis=2000 \
	--panic-flag-file=/tmp/ghost.panic.flag \
	--postpone-cut-over-flag-file=/tmp/ghost.postpone.flag \
	--timestamp-old-table \
	--execute 2>&1 | tee  /tmp/rebuild_t1_10w.log


	--postpone-cut-over-flag-file string
		表示当这个文件存在的时候，gh-ost的cut-over阶段将会被推迟，数据仍然在复制，直到该文件被删除。
		
		执行 rm -rf /tmp/ghost.postpone.flag 之后, 才会进入 cut-over 阶段.
	
	--panic-flag-file=/tmp/ghost.panic.flag
		当这个文件被创建，gh-ost将会立即退出。
		当指定该参数后，如果创建该文件，gh-ost立刻中断退出，不会清理产生的临时表和文件
	
	
	max-load 跟 critical-load 的关系 
	
		--max-load=Threads_running=25 表示如果在执行gh-ost的过程中出现Threads_running=25则暂停gh-ost的执行
		--critical-load=Threads_running=60 表明执行过程中出现Threads_running达到60则终止gh-ost的执行

		--critical-load-interval-millis=5000
		当值为0时, 当达到-critical-load, gh-ost立即退出。
		当值不为0时, 当达到-critical-load, gh-ost会在-critical-load-interval-millis秒数后, 再次进行检查, 再次检查依旧达到-critical-load, gh-ost将会退出。

		设置为0时, 一旦达到临界负载, 迁移将立即失效。 如果为非零值, 则在给定间隔后进行第二次检查, 并且仅在第二次检查仍满足关键负载时迁移才能解决

1.2 不删除旧表, 没有 postpone-cut-over-flag-file 参数
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
	--table="t1_10w" \
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
	--timestamp-old-table \
	--execute 2>&1 | tee  /tmp/rebuild_t1_10w.log

	
1.3 删除旧表, 没有postpone-cut-over-flag-file参数
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
	--table="t1_10w" \
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
	--execute 2>&1 | tee  /tmp/rebuild_t1_10w.log

2. 连接到从库执行
2.1 删除旧表, 没有postpone-cut-over-flag-file参数
	/root/ghost/gh-ost \
	--max-load=Threads_running=20 \
	--critical-load=Threads_running=50 \
	--critical-load-interval-millis=5000 \
	--chunk-size=1000 \
	--user="root" \
	--password="123456abc" \
	--host='192.168.0.92' \
	--port=3306 \
	--database="sbtest" \
	--table="t1_10w" \
	--verbose \
	--alter="engine=innodb" \
	--assume-rbr \
	--cut-over=default \
	--cut-over-lock-timeout-seconds=1 \
	--dml-batch-size=10 \
	--concurrent-rowcount \
	--default-retries=10 \
	--heartbeat-interval-millis=100 \
	--panic-flag-file=/tmp/ghost.panic.flag \
	--ok-to-drop-table \
	--execute 2>&1 | tee  /tmp/rebuild_t1_10w.log

	
3. 添加/删除字段/索引和重建表
	使用 1.3 的方式
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
--table="t1_1w" \
--verbose \
--alter="add index idx_c2(c2), add index idx_c3(c3), drop index idx_c4" \
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
--execute 2>&1 | tee  /tmp/rebuild_t1_1w.log
	
	添加单个字段
		--alter="add column c2 int(10) not null default 0 comment 'c2字段来了'"
		
	添加单个索引
		--alter="add index idx_c2(c2)"

	删除单个字段
		--alter="drop column c2"
	
	重建表: 
		--alter="engine=innodb"
	
	添加多个字段
		--alter="add column c2 int(10) not null default 0 comment 'c2字段来了', add column c3 int(10) not null default 0 comment 'c3字段来了'"
	
	添加多个字段同时添加单个索引
		--alter="add column c4 int(10) not null default 0 comment 'c4字段来了', add column c5 int(10) not null default 0 comment 'c5字段来了', add index idx_c4(c4)"
		
	添加多个索引同时删除单个索引
		--alter="add index idx_c2(c2), add index idx_c3(c3), drop index idx_c4"
	
	
	