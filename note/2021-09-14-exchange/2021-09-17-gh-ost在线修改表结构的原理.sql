
1. 建立1个跟原表一样的新表

2. gh-ost作为伪装的从库连接到主库，并记录新增的binlog event, 用来做增量数据的迁移 

3. 以一定chunk的大小分批量迁移数据到新表中，会对数据加共享读锁:
	使用 INSERT  IGNORE INTO select lock in share mode 语句分批迁移数据到新表中  -- 这个步骤没有描述好

4. 增量数据的处理
	通过过滤新增的 binlog event 之后再应用到新表上
	
5. 等待全部数据同步完成，进行新表和原表切换。

6. 最后, 删除 _del 表.



Bin:
问下你，为什么 gh-ost 要创建 1个 跟原表表结构一样的 以 _del 结尾的表，

Bin:
再把原表重命名为 _del 表, 最后 drop _del 表.

Bin:
show /* gh-ost */ table status from `sbtest` like '_t1_2500_del';
create /* gh-ost */ table `sbtest`.`_t1_2500_del`(...........);
rename /* gh-ost */ table `sbtest`.`t1_2500` to `sbtest`.`_t1_2500_del`;
drop /* gh-ost */ table if exists `sbtest`.`_t1_2500_del`;


