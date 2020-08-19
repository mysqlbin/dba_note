
a=10
b=20

val=`expr $a + $b`
echo "a + b : ${val}"

val=`expr $a - $b`
echo "a - b : ${val}"

val=`expr $a \* $b`
echo "a * b : ${val}"

val=`expr $b / $a`
echo "b / a : ${val}"

val=`expr $b % $a`
echo "b % a : ${val}"


if [ $a == $b ]
then
	echo "a 等于 b"
fi

if [ $a != $b ]
then
	echo "a 不等于 b"
fi

输出:
	a + b : 30
	a - b : -10
	a * b : 200
	b / a : 2
	b % a : 0
	a 不等于 b

