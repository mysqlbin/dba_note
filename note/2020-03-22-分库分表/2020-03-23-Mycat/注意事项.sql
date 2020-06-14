

注意事项：

Ø Order by字段必须出现在select中（MyCat先将结果取出，然后排序）

Ø Group by务必使用标准语法 select count(1),type from tab_a group by type;

Ø MyCat的一些自带函数 sum,min,max等可以正确使用，但多分片执行的avg有bug，执行的结果是错误的

Ø 谨慎使用子查询，外层查询没有分片查询条件， 则会在所有分片上执行(子查询内外层的表一样较为特殊)
