#!/bin/bash
while :
do
	echo -n "输入 1 到 5 之间的数字: "
	read NUM
	case $NUM in
		1|2|3|4|5) echo "你输入的数字为 $NUM !"
		;;
		*) echo "你输入的数字不是 1 到 5 之间的数字, 游戏结束"
			break
		;;
		
	esac

done

[root@mgr9 data]# sh 13-03.sh 
输入 1 到 5 之间的数字: 1
你输入的数字为 1 !
输入 1 到 5 之间的数字: 5
你输入的数字为 5 !
输入 1 到 5 之间的数字: 7
你输入的数字不是 1 到 5 之间的数字, 游戏结束
[root@mgr9 data]# 



