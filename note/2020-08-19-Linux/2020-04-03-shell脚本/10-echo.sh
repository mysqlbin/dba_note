
1. 显示普通字符串
2. 显示转义字符
3. 显示变量
4. 换行显示
5. 显示不换行
6. 显示结果定向至文件
7. 原样输出字符串, 不进行转义或取变量(用单引号)
8. 显示命令执行结果

1. 显示普通字符串
	echo "It is a test"  等于 echo It is a test
	
2. 显示转义字符
	echo "\"It is a test\""
	
	输出: "It is a test"

3. 显示变量
	read 命令从标准输入中读取一行, 并把输入行的每个字段的值指定给 shell 变量
	
	#!/bin/sh
	read name
	echo "$name It is a test"

	以上代码保存为 test.sh，name 接收标准输入的变量，结果将是:

	[root@www ~]# sh test.sh
	OK                     #标准输入
	OK It is a test        #输出

	[root@kp04 ~]# sh test.sh
	AA BB CC                  #标准输入
	AA BB CC It is a test     #输出
	
4. 换行显示
	echo -e "OK! \n"  # -e 开启转义, \n 换行
	echo "It is a test"
	
	#输出
	OK! 

	It is a test

5. 显示不换行
	echo -e "OK! \c"  # -e 开启转义, \c 不换行
	echo "It is a test"
	
	#输出
	OK! It is a test

6. 显示结果定向至文件
	echo "It is a test" > a.txt
	
	[root@kp04 ~]# echo "It is a test" > a.txt
	[root@kp04 ~]# cat a.txt 
	It is a test

7. 原样输出字符串, 不进行转义或取变量(用单引号)
	
	echo  '$name\"'

	[root@kp04 ~]# echo  '$name\"'
	$name\"

8. 显示命令执行结果
	echo `date`
	[root@kp04 ~]# echo `date`
	Tue Feb 4 14:49:44 CST 2020

		
	