
1. 简介
2. 数值测试
3. 字符串测试

1. 简介
	test 命令用于检查某个条件是否成立，它可以进行数值、字符和文件和三个方面的测试
	
2. 数值测试
	
	num1=100
	num2=100
	if test $[num1] -eq $[num2]
	then
		echo '两个数相等'
	else
		echo '两个数不相等'
	fi
	
	# 输出： 两个数相等
	
	if test $num -eq $num2
	then
		echo '两个数相等'
	else
		echo '两个数不相等'
	fi
	
	# 输出： 两个数相等
	
	不使用 test
		if [ $num1 -eq $num2 ]
		then
			echo "两个数相等"
		else
			echo "两个数不相等"
		fi
		
		# 输出：两个数相等
		
	
	代码中 [] 执行基本的算数运算，如
	a=5
	b=6
	result=$[a+b]
	echo "result 为：${result}"
	
	# 输出： result 为：11

3. 字符串测试
	num1='lujb'
	num2='lujb'
	if test $num1 = $num2
	then 
		echo '两个字符串相等'
	else
		echo '两个字符串不相等'
	fi
	
	# 输出： 两个字符串相等

	