

Copying `db_ex_admin_wework`.`t_external_customer`:  15% 03:08:04 remain
2022-11-23T00:36:52 Dropping triggers...
2022-11-23T00:36:52 Dropped triggers OK.
2022-11-23T00:36:52 Dropping new table...
2022-11-23T00:37:39 Dropped new table OK.
`db_ex_admin_wework`.`t_external_customer` was not altered.
        (in cleanup) 2022-11-23T00:36:52 Error copying rows from `db_ex_admin_wework`.`t_external_customer` to `db_ex_admin_wework`.`_t_external_customer_new`: Threads_running=123 exceeds its critical threshold 50
2022-11-23T00:37:39 Dropping triggers...
2022-11-23T00:37:39 Dropped triggers OK.
`db_ex_admin_wework`.`t_external_customer` was not altered.


--critical-load="Threads_running=500"


