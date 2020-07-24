

select GROUP_CONCAT(COLUMN_NAME) from information_schema.COLUMNS where table_name = '' and table_schema = '';

