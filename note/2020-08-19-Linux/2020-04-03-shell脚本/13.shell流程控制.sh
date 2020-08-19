

1. if else
	1.1 if 语句语法格式
	1.2 if else 语法格式
	1.3 if else-if else 语法格式
	1.4 样例1
	1.5 样例2
	
2. for 循环
	2.1 for循环一般格式为
	2.2 样例1
	
3. while 循环
	3.1 while 循环的场景
	3.2 格式
	3.3 样例1
	3.4 样例2	
	
4. 无限循环

	
1. if else
	
	1.1 if 语句语法格式

		if condition
		then
			command1 
			command2
			...
			commandN 
		fi
		
	1.2 if else 语法格式

		if condition
		then
			command1 
			command2
			...
			commandN
		else
			command
		fi
		
	1.3 if else-if else 语法格式

		if condition1
		then
			command1
		elif condition2 
		then 
			command2
		else
			commandN
		fi
		
	1.4 样例1
		判断两个变量是否相等
		a=10
		b=20
		if [ $a -eq $b ]
		then 
		echo "a 等于 b"
		elif [ $a -gt $b ]
		then
		echo "a 大于 b" 
		elif [ $a -lt $b ]
		then
		echo "a 小于 b"
		else 
		echo "没有符合的条件"
		fi
		
		# 输出： a 小于 b
		
	1.5 样例2
		num1=$[2*3]
		num2=$[1+5]
		if test $[num1] -eq $[num2]
		then 
			echo '两个数相等'
		else
			echo '两个数不相等'
		fi

		# 输出： 两个数相等
		
2. for 循环
	
	2.1 for循环一般格式为

		for var in item1 item2 ... itemN
		do
			command1
			command2
			...
			commandN
		done		
		
		写成一行：

			for var in item1 item2 ... itemN; do command1; command2… done;

	
	2.2 样例1	
		for loop in 1 2 3 4 5
		do 
		echo "the value is: $loop"
		done
		
		# 输出：
			the value is: 1
			the value is: 2
			the value is: 3
			the value is: 4
			the value is: 5	
			
		写成一行：
		
			for loop in 1 2 3 4 5; 	do echo "the value is: $loop"; done;
			[root@mgr9 ~]# for loop in 1 2 3 4 5; do echo "the value is: $loop"; done;
			the value is: 1
			the value is: 2
			the value is: 3
			the value is: 4
			the value is: 5
			
3. while 循环

	3.1 while 循环的场景
		用于不断执行一系列命令
		用于从输入文件中读取数据 
		
	3.2 格式
		while condition
		do
			command 
		done 
	
	3.3 样例1
		int_val=1
		while(( $int_val<=5 ))
		do
			echo $int_val
			let "int_val++"
		done
		# let 命令：用于执行一个或者多个表达式，变量计算中不需要加上 $ 来表示变量
		# 输出：
			1
			2
			3
			4
			5
		
	3.4 样例2
		while循环可用于读取键盘信息。
		下面的例子中，输入信息被设置为变量FILM，按<Ctrl-D>结束循环。
		
		echo '按下 <CTRL-D> 退出'
		echo -n '输入你最喜欢的网站名: '
		while read FILM
		do
			echo "是的！$FILM 是一个好网站"
		done
		
		# 输出 
			按下 <CTRL-D> 退出
			输入你最喜欢的网站名: google
			是的！google 是一个好网站
		参考脚本笔记 <13-01.sh>
		
4. 无限循环

	无限循环语法格式：

		while :
		do
			command
		done
		
		或者

		while true
		do
			command
		done
		
		或者

		for (( ; ; ))
		
5. case
	
	5.1 简介
		Shell case语句为多选择语句。可以用case语句匹配一个值与一个模式，如果匹配成功，执行相匹配的命令。
		取值后面必须为单词in，每一模式必须以右括号结束。取值可以为变量或常数。匹配发现取值符合某一模式后，其间所有命令开始执行直至 ;;。
		取值将检测匹配的每一个模式。一旦模式匹配，则执行完匹配模式相应命令后不再继续其他模式。如果无一匹配模式，使用星号 * 捕获该值，再执行后面的命令。
			
	5.2 case语句格式如下：

		case 值 in
		模式1)
			command1
			command2
			...
			commandN
			;;
		模式2）
			command1
			command2
			...
			commandN
			;;
		esac
	
	5.3 样例
		参考脚本笔记 <13-02.sh> 

	
6. 跳出循环
	6.1 break 命令
		break 允许跳出所有循环 即 终止后面的所有循环
		样例: 参考脚本笔记 <13-03.sh> 
		
	6.2 continue 命令
		continue 用于跳出当前循环
		样例: 参考脚本笔记 <13-04.sh> 	
		
	
	

