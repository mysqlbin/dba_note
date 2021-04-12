

https://www.cnblogs.com/geaozhang/p/7214257.html  MySQL IO线程及相关参数调优

https://mp.weixin.qq.com/s/i0sIfUqUUX5c_GkFTYh64Q 


coordinator控制worker。worker处理flush list，并发出写请求给io write thread.真正写文的动作在io write thread完成

