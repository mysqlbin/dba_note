
https://www.cnblogs.com/nanxiang/p/15220514.html  MySQL加密解密函数AES_ENCRYPT AES_DECRYPT




select AES_ENCRYPT('123456abc','mima');


encrypt：加密，把……加密
decrypt：解密，把……解密

二、AES_ENCRYPT()加密与AES_DECRYPT()解密

	AES_ENCRYPT(‘密码’,‘钥匙’)
	AES_DECRYPT(表的字段名字,‘钥匙’)
	
	

create table t2(c1 varchar(64);
insert into t2 select hex(aes_encrypt('123456abc','mima'));

select hex(aes_encrypt('IWOMBLENENDgE' ,'ass'))


mysql> select * from t2;
+----------------------------------+
| c1                               |
+----------------------------------+
| D3AA29BA5F3185F75E492C6E17B5C0EC |
+----------------------------------+
1 row in set (0.00 sec)


解密函数 AES_DECRYPT(str,key)

解密之前先用huhex函数转一次


mysql> select aes_decrypt(unhex(c1),'mima') from t2;
+-------------------------------+
| aes_decrypt(unhex(c1),'mima') |
+-------------------------------+
| 123456abc                     |
+-------------------------------+
1 row in set (0.00 sec)






