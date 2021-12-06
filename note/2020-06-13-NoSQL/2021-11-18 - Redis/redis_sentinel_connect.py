#!/usr/bin/env python
# #coding=utf-8

import redis
from redis.sentinel import Sentinel

# 连接哨兵服务器(主机名也可以用域名)
sentinel = Sentinel([('192.168.0.111', 26379),
                     ('192.168.0.112', 26379),
                     ('192.168.0.113', 26379)
                     ],
                    socket_timeout=0.5)

# 获取主服务器地址
master = sentinel.discover_master('mymaster')
print(master)

# 获取从服务器地址
slave = sentinel.discover_slaves('mymaster')
print(slave)


# 获取主服务器进行写入
master = sentinel.master_for('mymaster', socket_timeout=0.5, password='123456', db=1)
w_ret = master.set('foo', 'bar')
print(w_ret)
# 输出：True


# # 获取从服务器进行读取（默认是round-roubin 负载均衡）
slave = sentinel.slave_for('mymaster', socket_timeout=0.5, password='123456', db=1)
r_ret = slave.get('foo')
print(r_ret)
# # 输出：bar


"""
('192.168.0.111', 6379)
[('192.168.0.113', 6379), ('192.168.0.112', 6379)]
True
b'bar'
"""

"""
手动触发主实例故障迁移: sentinel failover mymaster
"""

"""
('192.168.0.113', 6379)
[('192.168.0.111', 6379), ('192.168.0.112', 6379)]
True
b'bar'

"""