

https://blog.csdn.net/SJZYLC/article/details/80990024  使用MySQL驱动对MYSQL进行update操作时返回值注意UseAffectedRows
https://www.jb51.net/article/50103.htm                 MySQL中SELECT+UPDATE处理并发更新问题解决方案分享


vipMember = SELECT * FROM vip_member WHERE uid=1001 LIMIT 1 # 查uid为1001的会员
cur_end_at = vipMember.end_at
if vipMember.end_at < NOW():
   UPDATE vip_member SET start_at=NOW(), end_at=DATE_ADD(NOW(), INTERVAL 1 MONTH), active_status=1, updated_at=NOW() WHERE uid=1001 AND end_at=cur_end_at
else:
   UPDATE vip_member SET end_at=DATE_ADD(end_at, INTERVAL 1 MONTH), active_status=1, updated_at=NOW() WHERE uid=1001 AND end_at=cur_end_at
   
   
这样可以根据UPDATE返回值来判断是否更新成功，如果返回值是0则表明存在并发更新，那么只需要重试一下就好了。  


如 SQL1 ：update task_info SET task_status=2 where id=?

useAffectedRows的作用在于是否用受影响的行数替代查找到的行数来返回数据，默认 false。
	指定这个值后，更新时会返回更新的行数，按照 SQL1 执行update操作也会返回正常值，即第一次返回1，第二次返回0.
	

"UPDATE返回值来判断是否更新成功，如果返回值是0则表明存在并发更新", 这里描述不准确


类似 jdbc对mysqlURL进行修改，添加参数useAffectedRows=true, 当update语句返回值为0: 是指 更新时会返回更新的行数为0
	
参考 https://blog.csdn.net/SJZYLC/article/details/80990024 

