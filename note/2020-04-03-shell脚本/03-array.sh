#!/bin/bash

1. 数组的简介
2. 定义数组
3. 读取数组
4. 获取数组的长度
5. 实践


1. 数组的简介
	支持一维数组, 不支持多维数组, 并且没有限定数组的大小
	数组元素的下标由0开始编号, 获取数组中的元素要利用下标, 下标可以是整数或算术表达式, 其值应大于或等于0
	
2. 定义数组
	用括号来表示数组, 数组元素用 "空格" 符号分割开
	定义数组的一般形式为: 
		数组名=(值1 值2 ... 值n)
	例如:
		array_name=(value0 value1 value2 value3)
		或者 
		array_name=(
		value0
		value1
		value2
		value3
		)

3. 读取数组
	读取数组元素值的一般格式是: $(数组名[下标])
	例如: valuen=${array_name[n]}
	
	使用 @ 符号可以获取数组中的所有元素, 例如: echo ${array_name[@]}
	
4. 获取数组的长度
	获取数组长度的方法与获取字符串长度的方法相同, 例如:
	
	# 取得数组元素的个数
	length=${#array_name[@]}
	# 等于
	length=${#array_name[*]}
	
	# 获取数组单个元素的长度
	lengthn=${#array_name[n]}
	
	
5. 实践
	# 定义一个数组
	db_array=(
	db1
	db2
	db3
	db4
	db5
	)
	
	# 获取数组中所有的元素
	echo ${db_array[@]}
	# 输出 db1 db2 db3 db4 db5

	# 获取数组的长度
	echo ${#db_array[@]}
	# 输出 5
	
	# 获取数组中的第1个元素
	echo ${db_array[0]}
	# 输出 db1
	
	# 获取数组单个元素的长度
	echo ${#db_array[0]}
	# 输出 3
	
	