

a=10
b=20

if [ $a != $b ]
then
	echo "$a != $b : a 不等于 b"
else
	echo "$a == $b : a 不等于 b"
fi

if [ $a -lt 100 -a $b -gt 15]
then
	echo "$a 小于100 并且 $b 大于 15: 返回 true"
else
	echo "$a 小于100 并且 $b 大于 15: 返回 false"
fi

if [ $a -lt 100 -o $b -gt 100]
then 
	echo "$a 小于100 或者 $b 大于100: 返回 true"
else
	echo "$a 小于100 或者 $b 大于100: 返回 false"
fi
if [ $a -lt 100 -o $b -gt 15]
then 
	echo "$a 小于100 或者 $b 大于15: 返回 true"
else
	echo "$a 小于100 或者 $b 大于15 : 返回 false"
fi


输出:
	10 != 20 : a 不等于 b
	10 小于100 并且 20 大于 15: 返回 true
	10 小于100 或者 20 大于100: 返回 true
	10 小于100 或者 20 大于15: 返回 true
	