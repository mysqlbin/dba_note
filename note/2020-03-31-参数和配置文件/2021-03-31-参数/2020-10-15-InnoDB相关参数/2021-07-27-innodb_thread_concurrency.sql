

设置 innodb_thread_concurrency 参数的目的是，控制 InnoDB 的并发线程上限。
一旦并发线程数达到这个值，InnoDB 在接收到新请求的时候，就会进入等待状态，直到有线程退出。
把 innodb_thread_concurrency 设置成 3，表示 InnoDB 只允许 3 个线程并行执行。

