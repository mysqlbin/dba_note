

MySQL 高可用
 

Replication / 半同步 （5.7+）

MGR

PXC （不太建议）

其他都是异端

 

基于VIP的高可用
　　需要额外的资源
　　　　keepalived （VRRP）

　　　　MHA 一个实际的IP （基于TCP方式的）

　　限制
　　　　VIP 必须在一个局域网中

　　　  比较难跨IDC实现

 

DNS
　　把记录存储到数据库中 （MySQL）
　　连接串信息
　　　host： xxx.xxx.net

　　    port： 3306

　　    user: xxxx

　　　password: xxxxxxxx

　　    dbname: xxx

 

　　原始一点：
　　　　Bind-DLZ

　　　　　　可控制度更好 （查询DNS记录SQL可定制）

　　　　　　据说性能非常差

　　　　PowerDNS

　　　　　　SQL schema设置规范

　　　　　　性能比Bind-DLZ 好

　　New DNS
　　　　coredns (和k8s结合笔记多)

　　集大成者
　　　　nacos （阿里开源，含DNS和服务发现）

 

 

consul
　　服务发现类
　　　　早期：zookeeper

　　　　现在：etcd (k8s结合比较紧)， consul

　　　　综合性的： nacos （阿里开源）

 

　　consul的优势：
　　　　支持多数据中心，内外网的服务采用不同的端口进行监听。

　　　　支持健康检查

　　　　支持 http 和 dns 协议接口，有DNS功能，支持 REST API

　　　　官方提供 web 管理界面

　　　　部署简单，运维友好，无依赖
