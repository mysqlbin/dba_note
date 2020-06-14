1. 标准输入
2. 标准输出
3. STDIN/STDOUT/STDERR
4. 输出重定向
5. 输入重定向
6. 重定向深入讲解
7. /dev/null 文件


1. 标准输入
	一个命令通常从一个叫标准输入的地方读取输入, 默认情况下, 这是你的终端

2. 标准输出
	一个命令通常将其输出写入到标准输出, 默认情况下, 这是你的终端
	
3. STDIN/STDOUT/STDERR
	文件描述符 0 通常是标准输入（STDIN），1 是标准输出（STDOUT），2 是标准错误输出（STDERR）。
	
4. 输出重定向
	语法: 
		command1 > file1
	含义: 
		执行 command1 然后将输出的内容存入 file1 
	
	注意事项:
		任何file1内的已经存在的内容将被新内容替代。如果要将新内容添加在文件末尾，请使用>>操作符。
		
	样例: 
		shell> who > users
		
		执行上面的 who 命令，它将命令的完整的输出重定向在用户文件中(users)
		执行后，并没有在终端输出信息，这是因为输出已被从默认的标准输出设备（终端）重定向到指定的文件。
		
		使用 cat 命令查看文件内容:
			[root@kp04 ~]# cat users 
			root     pts/0        2020-04-14 10:07 (192.168.0.71)
			root     pts/1        2020-04-14 10:14 (192.168.0.71)
			
		输出重定向会覆盖文件内容:
			echo "666 objk" > users
			[root@kp04 ~]# echo "666 objk" > users
			[root@kp04 ~]# cat users 
			666 objk
			
		如果不希望文件内容被覆盖，可以使用 >> 追加到文件末尾，例如：
		
			who > users
			echo "666 objk" >> users
			
			[root@kp04 ~]# cat users 
			root     pts/0        2020-04-14 10:07 (192.168.0.71)
			root     pts/1        2020-04-14 10:14 (192.168.0.71)
			666 objk
		
5. 输入重定向

	语法: 
		Unix 命令也可以从文件获取输入，语法为：

		command1 < file1	
		
	样例
		
		who > users
		
		统计 users 文件的行数,执行以下命令：
			[root@kp04 ~]# wc -l users
			2 users
		
		也可以将输入重定向到 users 文件：
			[root@kp04 ~]# wc -l < users
			2
			[root@kp04 ~]# cat users 
			root     pts/0        2020-04-14 10:07 (192.168.0.71)
			root     pts/1        2020-04-14 10:14 (192.168.0.71)
			
		上面两个例子的结果不同：第一个例子，会输出文件名；第二个不会，因为它仅仅知道从标准输入读取内容。
		
	
6. 重定向深入讲解
	一般情况下，每个 Unix/Linux 命令运行时都会打开三个文件：

		标准输入文件(stdin) ：stdin  的文件描述符为0，Unix程序默认从stdin读取数据。
		标准输出文件(stdout)：stdout 的文件描述符为1，Unix程序默认向stdout输出数据。
		标准错误文件(stderr)：stderr 的文件描述符为2，Unix程序会向stderr流中写入错误信息。
	默认情况下，command > file 将 stdout 重定向到 file，command < file 将stdin 重定向到 file。
	
	样例
		command 2 > file  : 表示 stderr 重定向到 file
		command 2 >> file : 表示 stderr 追加到 file 文件末尾
		command > file 2>&1 或者 command >> file 2>&1 : 表示 stdout 和 stderr 合并后重定向到 file
		command < file1 >file2 : 表示 对 stdin 和 stdout 都重定向, command 命令将 stdin 重定向到 file1，将 stdout 重定向到 file2。
		
7. /dev/null 文件
		
	如果希望执行某个命令，但又不希望在屏幕上显示输出结果，那么可以将输出重定向到 /dev/null：
		command > /dev/null
		
	/dev/null 是一个特殊的文件，写入到它的内容都会被丢弃；如果尝试从该文件读取内容，那么什么也读不到。但是 /dev/null 文件非常有用，将命令的输出重定向到它，会起到"禁止输出"的效果。

	如果希望屏蔽 stdout 和 stderr，可以这样写：

		command > /dev/null 2>&1
		
	
		