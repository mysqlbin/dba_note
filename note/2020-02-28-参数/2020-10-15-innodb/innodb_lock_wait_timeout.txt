
此参数用于控制锁等待的超时时间，默认为50s，如果锁等待超过50s, 被锁住的线程会退出.
这个值要注意，如果有特殊业务确实要耗时较长时，不能配置太短

show variables like '%innodb_lock_wait_timeout%';

如何体现:
ERROR 1205 (HY000): Lock wait timeout exceeded; try restarting transaction