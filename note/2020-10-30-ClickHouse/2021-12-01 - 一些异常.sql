Dec  1 11:11:01 localhost auditd[672]: Audit daemon is low on disk space for logging
Dec  1 11:11:01 localhost auditd[672]: Audit daemon is suspending logging due to low disk space.
Dec  1 11:11:01 localhost systemd: Started Session 48497 of user root.
Dec  1 11:12:01 localhost systemd: Started Session 48498 of user root.
Dec  1 11:13:01 localhost systemd: Started Session 48499 of user root.
Dec  1 11:13:30 localhost clickhouse-server: Cannot add message to the log: Code: 243. DB::Exception: Cannot reserve 1.00 MiB, not enough space. (NOT_ENOUGH_SPACE), Stack trace (when copying this message, always include the lines below):
Dec  1 11:13:30 localhost clickhouse-server: 0. DB::Exception::Exception(std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const&, int, bool) @ 0x9b605d4 in /usr/bin/clickhouse
Dec  1 11:13:30 localhost clickhouse-server: 1. DB::MergeTreeData::reserveSpacePreferringTTLRules(std::__1::shared_ptr<DB::StorageInMemoryMetadata const> const&, unsigned long, DB::MergeTreeDataPartTTLInfos const&, long, unsigned long, bool, std::__1::shared_ptr<DB::IDisk>) const @ 0x12daa244 in /usr/bin/clickhouse
Dec  1 11:13:30 localhost clickhouse-server: 2. DB::MergeTrDec  1 11:14:26 localhost clickhouse-server: Processing configuration file '/etc/clickhouse-server/users.xml'.
Dec  1 11:14:26 localhost clickhouse-server: Saved preprocessed configuration to '/var/lib/clickhouse/preprocessed_configs/users.xml'.
Dec  1 11:14:35 localhost clickhouse-server: Cannot add message to the log: Flushing system log, 1661 entries to flush up to offset 1661
Dec  1 11:14:35 localhost clickhouse-server: Poco::Exception. Code: 1000, e.code() = 28, File access error: no space left on device: /var/log/clickhouse-server/clickhouse-server.log, Stack trace (when copying this message, always include the lines below):
Dec  1 11:14:35 localhost clickhouse-server: 0. Poco::Exception::Exception(std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const&, std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const&, int) @ 0x15dc3a73 in /usr/bin/clickhouse
Dec  1 11:14:35 localhost clickhouse-server: 1. Poco::FileImpl::handleLastErrorImpl(std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const&) @ 0x15dd6da7 in /usr/bin/clickhouse
Dec  1 11:14:35 localhost clickhouse-server: 2. ? @ 0x15ddacc6 in /usr/bin/clickhouse
Dec  1 11:14:35 localhost clickhouse-server: 3. ? @ 0x15de66e9 in /usr/bin/clickhouse
Dec  1 11:14:35 localhost clickhouse-server: 4. Poco::FileOutputStream::FileOutputStream(std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const&, unsigned int) @ 0x15de787d in /usr/bin/clickhouse
Dec  1 11:14:35 localhost clickhouse-server: 5. Poco::LogFileImpl::LogFileImpl(std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > const&) @ 0x15df0b71 in /usr/bin/clickhouse
Dec  1 11:14:35 localhost clickhouse-server: 6. Poco::FileChannel::log(Poco::Message const&) @ 0x15ddc241 in /usr/bin/clickhouse
Dec  1 11:14:35 localhost clickhouse-server: 7. DB::OwnFormattingChannel::logExtended(DB::ExtendedLogMessage const&) @ 0x117ef63d in /usr/bin/clickhouse
Dec  1 11:14:35 localhost clickhouse-server: 8. DB::OwnSplitChannel::logSplit(Poco::Message const&) @ 0x117f13b9 in /usr/bin/clickhouse
Dec  1 11:14:35 localhost clickhouse-server: 9. DB::OwnSplitChannel::tryLogSplit(Poco::Message const&) @ 0x117f11f2 in /usr/bin/clickhouse
Dec  1 11:14:35 localhost clickhouse-server: 10. DB::OwnSplitChannel::log(Poco::Message const&) @ 0x117f108f in /usr/bin/clickhouse
Dec  1 11:14:35 localhost clickhouse-server: 11. DB::SystemLog<DB::AsynchronousMetricLogElement>::flushImpl(std::__1::vector<DB::AsynchronousMetricLogElement, std::__1::allocator<DB::AsynchronousMetricLogElement> > const&, unsigned long) @ 0x12648aa2 in /usr/bin/clickhouse
Dec  1 11:14:35 localhost clickhouse-server: 12. DB::SystemLog<DB::AsynchronousMetricLogElement>::savingThreadFunction() @ 0x12647660 in /usr/bin/clickhouse
Dec  1 11:14:35 localhost clickhouse-server: 13. ThreadFromGlobalPool::ThreadFromGlobalPool<DB::SystemLog<DB::AsynchronousMetricLogElement>::startup()::'lambda'()>(DB::AsynchronousMetricLogElement&&, DB::SystemLog<DB::AsynchronousMetricLogElement>::startup()::'lambda'()&&...)::'lambda'()::operator()() @ 0x126474c0 in /usr/bin/clickhouse
Dec  1 11:14:35 localhost clickhouse-server: 14. ThreadPoolImpl<std::__1::thread>::worker(std::__1::__list_iterator<std::__1::thread, void*>) @ 0x9ba2697 in /usr/bin/clickhouse
Dec  1 11:14:35 localhost clickhouse-server: 15. ? @ 0x9ba609d in /usr/bin/clickhouse
Dec  1 11:14:35 localhost clickhouse-server: 16. start_thread @ 0x7ea5 in /usr/lib64/libpthread-2.17.so
Dec  1 11:14:35 localhost clickhouse-server: 17. clone @ 0xfe8dd in /usr/lib64/libc-2.17.so
Dec  1 11:14:35 localhost clickhouse-server: (version 21.11.4.14 (official build))
Dec  1 11:15:01 localhost systemd: Started Session 48501 of user root.
Dec  1 11:15:25 localhost systemd: clickhouse-server.service holdoff time over, scheduling restart.
Dec  1 11:15:25 localhost systemd: Stopped ClickHouse Server (analytic DBMS for big data).
Dec  1 11:15:25 localhost systemd: Started ClickHouse Server ([root@localhost log]# 





[root@localhost log]# df -h
文件系统             容量  已用  可用 已用% 挂载点
/dev/mapper/cl-root   50G   50G   20K  100% /
devtmpfs             7.8G     0  7.8G    0% /dev
tmpfs                7.8G     0  7.8G    0% /dev/shm
tmpfs                7.8G  145M  7.6G    2% /run
tmpfs                7.8G     0  7.8G    0% /sys/fs/cgroup
/dev/mapper/cl-home  873G  240G  633G   28% /home
/dev/sda1           1014M  140M  875M   14% /boot
tmpfs                1.6G     0  1.6G    0% /run/user/0




mv /var/lib/clickhouse /home/clickhouse/data


chown  clickhouse:clickhouse /home/clickhouse
chown  clickhouse:clickhouse /home/clickhouse/data
chown  clickhouse:clickhouse /home/clickhouse/data/*



https://blog.csdn.net/dzg20/article/details/116545833

