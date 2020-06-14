
样例:
create table t(id int unsigned auto_increment primary key) auto_increment=4294967295;
insert into t values(null);
// 成功插入一行 4294967295
show create table t;
/* CREATE TABLE `t` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4294967295;
*/

insert into t values(null);
//Duplicate entry '4294967295' for key 'PRIMARY'




 


create table t4(a int) engine=InnoDB;
#gdb -p <pid of mysqld> -ex 'p dict_sys.row_id=1' --batch
gdb -p 9293 -ex 'p dict_sys.row_id=1' --batch
insert into t4 values(1);
mysql> select * from t4;
+------+
| a    |
+------+
|    1 |

#gdb -p <pid.mysqld> -ex 'p dict_sys.row_id=281474976710656' --batch
gdb -p 9293 -ex 'p dict_sys.row_id=281474976710656' --batch
insert into t4 values(2);
insert into t4 values(3);
mysql> select * from t4;
+------+
| a    |
+------+
|    2 |
|    3 |
+------+
2 rows in set (0.00 sec)




InnoDB 内部维护了一个 max_trx_id 全局变量，每次需要申请一个新的 trx_id 时，就获得 max_trx_id 的当前值，然后并将 max_trx_id 加 1。
	

InnoDB 数据可见性的核心思想：
	每一行数据都记录了更新它的 trx_id，当一个事务读到一行数据的时候，判断这个数据是否可见的方法，就是通过事务的一致性视图与这行数据的 trx_id 做对比。








	

	
	
由于只读事务不分配 trx_id，一个自然而然的结果就是 trx_id 的增加速度变慢了。

	

。




create table t5(a int primary key, c int) engine=InnoDB;
insert into t5 values(1, 1);
gdb -p 9293 -ex 'p trx_sys->max_trx_id=281474976710655' --batch


session A            session B
begin; 

select * from t5;
+---+------+
| a | c    |
+---+------+
| 1 |    1 |
+---+------+

			         update t5 set c=2 where a=1;
					 begin;
					 update t5 set c=3 where a=1;
					 				 
select * from t5;
+---+------+
| a | c    |
+---+------+
| 1 |    3 |
+---+------+

	



do {
  new_id= thread_id_counter++;
} while (!thread_ids.insert_unique(new_id).second);












	