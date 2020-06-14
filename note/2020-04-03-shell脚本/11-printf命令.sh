

简介
	printf 使用引用文本或空格分隔的参数, 外面可以在 printf 中使用格式化字符串, 还可以制定字符串的宽度和左右对齐方式等
	默认 printf 不会像 echo 自动添加换行符, 可以手动添加  \n 用于换行
	
语法 
	printf format-string [arguments...]
	
	参数说明
		format-string : 表示格式控制字符串
		arguments     : 表示参数列表
	

样例1
	printf "%-10s %-8s %-4s\n"   姓名   性别   体重KG
	printf "%-10s %-8s %-4.2f\n" lujb    男     55.1234
	printf "%-10s %-8s %-4.2f\n" lujbs    男     55.5678
	printf "%-10s %-8s %-4.2f\n" lujbs    男     55.9876
	
	输出
		姓名     性别   体重KG
		lujb       男      55.12
		lujbs      男      55.57
		lujbs      男      55.99
	
	%s %c %d %f 都是格式替代符
	%-10s : 指一个宽度为10个字符(-表示左对齐, 没有则表示右对齐), 任何字符都会被显示在10个字符宽的字符内, 如果不足则自动以空格填充, 超过也会将内容全部显示出来.
	%-4.2f : 指格式化为小数, 其中 .2 指保留2位小数
	
样例2
	# format-string 为双引号
	printf "%d %s\n" 1 "abc"
	# 输出： 1 abc
	
	# format-string 为单引号，跟双引号的效果一样
	printf '%d %s\n' 1 "abc"
	# 输出： 1 abc
	
	# 没有单引号也可以输出
	printf %s abcdef
	# 输出： abcdef
	
	# 格式只指定了一个参数，但多出的参数仍然会按照该格式输出， format-string 被重用
	printf %s abc def 
	# 输出：abcdef
	
	printf "%s\n" abc def
	
	# 输出：
	abc
	def
	
	printf "%s %s %s\n" a b c d e f g h i j
	# 输出：
	a b c
	d e f
	g h i
	j  
	
	
	
