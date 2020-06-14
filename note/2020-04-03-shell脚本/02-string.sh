#!/bin/bash

1. 单引号字符串的限制
2. 双引号的优点
3. 双引号中的字符串
4. 拼接字符串
5. 获取字符串长度
6. 提取字符串
7. 查找字符串


1. 单引号字符串的限制

	单引号里的任何字符都会原样输出，单引号字符串中的变量是无效的；
	单引号字串中不能出现单独一个的单引号（对单引号使用转义符后也不行），但可成对出现，作为字符串拼接使用。
	
2. 双引号的优点
	双引号里可以有变量
	双引号里可以出现转义字符


3. 双引号中的字符串
	your_name="lujb"
	str="i am $your_name"
	echo $str
	# 输出 i am lujb

	
	your_name="lujb"
	str="i am "$your_name""
	echo $str
	#等于
	your_name="lujb"
	str="i am "${your_name}""
	echo $str
	# 输出 i am lujb

	
	your_name="lujb"
	str="i am \"$your_name\""
	echo $str
	# 等于
	your_name="lujb"
	str="i am \"${your_name}\""
	echo $str
	# 输出 i am "lujb"


4. 拼接字符串
	# 使用双引号拼接字符串
	your_name="lujb"
	greeting="hello, "$your_name""
	greeting1="hello, ${your_name}"
	echo $greeting $greeting1
	# 输出: hello, lujb hello, lujb


	# 使用单引号拼接字符串
	greeting2='hello, '$your_name''
	greeting3='hello, ${your_name}'
	echo $greeting2 $greeting3
	# 输出: hello, hello, ${your_name}


5. 获取字符串长度
	string='abcd'
	echo ${#string}
	# 输出: 4
	
6. 提取字符串
	第一个字符的索引值为0
	以下实例从第2个字符开始截取4个字符
	string='abcd efg hijk lmn'
	echo ${string:1:4}
	# 输出 bcd 

7. 查找字符串
	以下实例查询字符 o 第一次出现的位置
	string="runoob is a great site"
	echo `expr index "${string}" o`
	# 输出 4
	
	
	
	