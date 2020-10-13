

SELECT table_schema,table_name,(data_length/1024/1024/1024) AS data_mb,(index_length/1024/1024/1024) AS index_mb,((data_length + index_length)/1024/1024/1024) AS all_mb,table_rows FROM 
information_schema.tables  where table_schema = 'lialia_db' and table_name='table_abcgamebbbbbbabtail_history';
select * from information_schema.statistics where TABLE_SCHEMA='lialia_db' and table_name='table_abcgamebbbbbbabtail_history';
select * from mysql.innodb_table_stats  where database_name='lialia_db' and table_name = 'table_abcgamebbbbbbabtail_history';
select * from mysql.innodb_index_stats  where database_name='lialia_db' and table_name = 'table_abcgamebbbbbbabtail_history';
show index from table_name;

