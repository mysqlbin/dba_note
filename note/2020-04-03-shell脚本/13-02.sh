#!/bin/bash
echo "输入 1 到 4 之间的数字"
echo -n "你输入的数字为: "
read NUM
case $NUM in
	1) echo "你输入了 1"
	;;
	2) echo "你输入了 2"
	;;
	3) echo "你输入了 3"
	;;
	4) echo "你输入了 4"
	;;
	*) echo "你没有输入 1 到 4 之间的数字"
esac


[root@mgr9 data]# sh 13-02.sh 
输入 1 到 4 之间的数字
你输入的数字为: 1
你输入了 1
[root@mgr9 data]# sh 13-02.sh 
输入 1 到 4 之间的数字
你输入的数字为: 5
你没有输入 1 到 4 之间的数字

