
1. 文件包含
2. Shell 文件包含的语法格式
3. 实例 

1. 文件包含
	Shell 也可以包含外部脚本。这样可以很方便的封装一些公用的代码作为一个独立的文件。
	
2. Shell 文件包含的语法格式

	. filename   # 注意点号(.)和文件名中间有一空格

	或

	source filename
	
3. 实例 
	创建两个 shell 脚本文件
	
	test1.sh:
		url="http://www.runoob.com"
		
	test2.sh:
	
		#使用 . 号来引用test1.sh 文件
		. ./test1.sh

		# 或者使用以下包含文件代码
		# source ./test1.sh
		
		echo "菜鸟教程官网地址：$url"
		
	为 test2.sh 添加可执行权限并执行：

		chmod +x test2.sh 
		./test2.sh 
		菜鸟教程官网地址：http://www.runoob.com
		
	
	参考脚本笔记 <16-01.sh> <16-02.sh>
	