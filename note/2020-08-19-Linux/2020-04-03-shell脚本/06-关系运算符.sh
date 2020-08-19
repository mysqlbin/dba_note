
a=10
b=20

if [ $a -eq $b ]
then
	echo "$a -eq $b : 变量a 等于 变量b"
else
	echo "$a -eq $b : 变量a 不等于 变量b"
fi

if [ $a -ne $b ]
then
	echo "$a -ne $b : 变量a 不等于 变量b"
else
	echo "$a -ne $b : 变量a 等于 变量b"
fi


if [ $a -gt $b ]
then
	echo "$a -gt $b : 变量a 大于 变量b"
else
	echo "$a -gt $b : 变量a 不大于(小于) 变量b"
fi


if [ $a -lt $b ]
then
	echo "$a -lt $b : 变量a 小于 变量b"
else
	echo "$a -lt $b : 变量a 不小于(大于) 变量b"
fi


if [ $a -ge $b ]
then
	echo "$a -ge $b : 变量a 大于或等于 变量b"
else
	echo "$a -ge $b : 变量a 小于 变量b"
fi


if [ $a -le $b ]
then
	echo "$a -le $b : 变量a 小于或等于 变量b"
else
	echo "$a -le $b : 变量a 大于 变量b"
fi


输出

	10 -eq 20 : 变量a 不等于 变量b
	10 -ne 20 : 变量a 不等于 变量b
	10 -gt 20 : 变量a 不大于(小于) 变量b
	10 -lt 20 : 变量a 小于 变量b
	10 -ge 20 : 变量a 小于 变量b
	10 -le 20 : 变量a 小于或等于 变量b

