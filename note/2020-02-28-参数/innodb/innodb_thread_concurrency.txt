

设置 innodb_thread_concurrency 参数的目的是，控制 InnoDB 的并发线程上限。
一旦并发线程数达到这个值，InnoDB 在接收到新请求的时候，就会进入等待状态，直到有线程退出。
把 innodb_thread_concurrency 设置成 3，表示 InnoDB 只允许 3 个线程并行执行。



此参数用于设置限制能够进入innodb层的线程数
建议设置成机器cpu核数的2倍，不过大多数情况下，默认值已经足够。


show variables like '%innodb_thread_concurrency%';


用sysbench做压测, num-threads参数表示 最大创建线程数
num-threads=10
在压测过程中, 通过 show processlist命令就可以看到 这10个线程数.


