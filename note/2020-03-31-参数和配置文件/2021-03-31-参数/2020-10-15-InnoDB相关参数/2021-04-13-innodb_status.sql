

innodb_status_file = 1
# 注意: 开启 innodb_status_output & innodb_status_output_locks 后, 可能会导致log-error文件增长较快
innodb_status_output = 0
innodb_status_output_locks = 0


--innodb-status-file启动选项控制InnoDB是否在数据目录中创建一个名为innodb_status.pid的文件，并大约每15秒将SHOW ENGINE INNODB STATUS输出写入该文件。

默认情况下，不会创建innodb_status.pid文件。 要创建它，请使用--innodb-status-file选项启动mysqld。 正常关闭服务器后，InnoDB会删除文件。 如果发生异常关闭，则可能必须手动删除状态文件。

--innodb-status-file选项仅供临时使用，因为SHOW ENGINE INNODB STATUS输出生成会影响性能，并且innodb_status.pid文件会随着时间变得很大。


-rw-r----- 1 mysql mysql      65396 2020-05-28 02:00 innodb_status.1629
-rw-r----- 1 mysql mysql      45188 2019-09-13 09:04 innodb_status.2088
-rw-r----- 1 mysql mysql          0 2020-05-28 10:08 innodb_status.22533
-rw-r----- 1 mysql mysql      74856 2020-08-28 16:45 innodb_status.24572
-rw-r----- 1 mysql mysql      71235 2019-02-28 10:57 innodb_status.2539
-rw-r----- 1 mysql mysql      67524 2021-04-13 10:46 innodb_status.25576
-rw-r----- 1 mysql mysql      70340 2020-10-06 07:27 innodb_status.29640
-rw-r----- 1 mysql mysql      35835 2019-01-21 18:20 innodb_status.5374
-rw-r----- 1 mysql mysql       5986 2018-11-07 15:48 innodb_status.6073
-rw-r----- 1 mysql mysql      35591 2019-05-01 22:42 innodb_status.6266







