


Mycat分库分表存在的问题：
1. 因为我这边有挺多存储过程的， 但是Mycat对存储过程支持不友好，创建需要加注释，调用存储过程也需要加注释。

2. Mycat自身不支持高可用
 避免Mycat的单点问题的方式： 部署两个节点的 Mycat + Keepalived 做高可用。

3. 配置文件复杂，容易出错

4. 全局序列号用不了数据库表自增ID(AUTO_INCREMENT)

5. 当使用Mycat分库分表改造完成后，期间要经过一系列的测试，耗时长

6. 没有验证复杂SQL的执行

