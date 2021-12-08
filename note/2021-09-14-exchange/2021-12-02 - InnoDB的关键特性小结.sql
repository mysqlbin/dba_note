
change buffer 用于提升DML语句的速度，AHI用于提升查询操作的速度, double write 用于保证数据页的完整刷盘.

change buffer 、AHI、double write、预读 这4个关键特性占用的都是BP缓冲池的内存。

这些关键特性都有监控指标， 指标来源：

    1. show engine innodb status\；
    2. fpmmm 监控
    3. show global status 相关的状态值
    

