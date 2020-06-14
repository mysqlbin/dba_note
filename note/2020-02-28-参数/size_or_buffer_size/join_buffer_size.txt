

变量join_buffer_size

Join Buffer是用来减少内表扫描次数的一种优化，但Join Buffer又没那么简单，在上一节中Inside君故意忽略了一些实现。
首先变量join_buffer_size用来控制Join Buffer的大小，调大后可以避免多次的内表扫描，从而提高性能。
也就是说，当MySQL的Join有使用到Block Nested-Loop Join，那么调大变量join_buffer_size才是有意义的。
而前面的Index Nested-Loop Join如果仅使用索引进行Join，那么调大这个变量则毫无意义。


变量join_buffer_size的默认值是256K，显然对于稍复杂的SQL是不够用的。好在这个是会话级别的变量，可以在执行前进行扩展。
Inside君建议在会话级别进行设置，而不是全局设置，因为很难给一个通用值去衡量。另外，这个内存是会话级别分配的，如果设置不好容易导致因无法分配内存而导致的宕机问题。


全局分配 join_buffer_size, 如果设置太大(20M), 如果有100个并发线程, 
那么 join buffer 占用系统的内存为 2000M, 差不多2个G. 
如果系统内存不足, 会导致 无法分配内存而导致的宕机问题.




 