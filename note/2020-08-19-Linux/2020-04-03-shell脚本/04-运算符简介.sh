
原生bash不支持简单的数学运算, 但是可以通过其它命令来实现, 例如 awk 和 expr, 其中 expr 最常用
expr 是一款表达式计算工具, 使用它能完成表达式的求值操作

例如, 两个数相加:

val=`expr 2 + 2`
echo "两数之和为 : ${val}"

# 输出: 两数之和为 : 4

表达式和运算符之间要有空格:  例如 2+2 是不对的，必须写成 2 + 2   
完整的表达式要被 ` ` 包含，注意这个字符不是常用的单引号


支持多种运算符，包括：

	1. 算数运算符
	2. 关系运算符
	3. 布尔运算符
	4. 字符串运算符
	5. 文件测试运算符


