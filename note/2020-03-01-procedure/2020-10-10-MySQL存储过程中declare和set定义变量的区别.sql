

https://www.cnblogs.com/pcheng/p/4943096.html  MySQL存储过程中declare和set定义变量的区别

https://blog.csdn.net/caomiao2006/article/details/52145792  MySql存储过程之变量declare set


https://blog.csdn.net/yao5hed/article/details/81059806  MySQL存储过程与各种变量

https://baijiahao.baidu.com/s?id=1650692532510783440&wfr=spider&for=pc   MySQL中你应该要知道的变量知识点


DROP PROCEDURE IF EXISTS temp;
DELIMITER ;;
CREATE PROCEDURE temp()
BEGIN
    DECLARE a INT DEFAULT 1;

    SET a=a+1;
    SET @b=@b+1;
    SELECT a,@b;

END
;;
DELIMITER ;


SET @b=1; 


CALL temp();




session A           session B


mysql> set @a=1;
Query OK, 0 rows affected (0.00 sec)

mysql> select @a;
+------+
| @a   |
+------+
|    1 |
+------+
1 row in set (0.00 sec)


					mysql> select @a;
					+------+
					| @a   |
					+------+
					| NULL |
					+------+
					1 row in set (0.00 sec)



set @a 表示会话变量/用户变量:
	只在当前连接中有效。
	
	
	
