


pt-archiver常用参数
--limit 10000       每次取10000行数据用pt-archive处理，Number of rows to fetch and archive per statement.
--txn-size  1000   设置1000行为一个事务提交一次，Number of rows pertransaction.
--where‘id&lt;3000‘   设置操作条件
--progress 5000     每处理5000行输出一次处理信息
--statistics       输出执行过程及最后的操作统计。（只要不加上--quiet，默认情况下pt-archive都会输出执行过程的）
--charset=UTF8     指定字符集为UTF8
--bulk-delete      批量删除source上的旧数据(例如每次1000行的批量删除操作)
--bulk-insert      批量插入数据到dest主机 (看dest的general log发现它是通过在dest主机上LOAD DATA LOCAL INFILE插入数据的)
--replace          将insert into 语句改成replace写入到dest库
--sleep 120         每次归档了limit个行记录后的休眠120秒（单位为秒）
--file ‘/root/test.txt‘：数据存放的文件，最好指定绝对路径，文件名可以灵活地组合
--purge             删除source数据库的相关匹配记录
--header            输入列名称到首行（和--file一起使用）
--no-check-charset  不指定字符集
--check-columns    检验dest和source的表结构是否一致，不一致自动拒绝执行（不加这个参数也行。默认就是执行检查的）
--no-check-columns    不检验dest和source的表结构是否一致，不一致也执行（会导致dest上的无法与source匹配的列值被置为null或者0）
--chekc-interval      默认1s检查一次
--local            不把optimize或analyze操作写入到binlog里面（防止造成主从延迟巨大）
--retries         超时或者出现死锁的话，pt-archiver进行重试的间隔（默认1s）
--no-version-check   目前为止，发现部分pt工具对阿里云RDS操作必须加这个参数
--analyze=ds      操作结束后，优化表空间（d表示dest，s表示source）
--source: 指定源表信息
--no-delete: 不删除已经归档的 rows
