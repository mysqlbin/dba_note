
删除在发生错误之前创建的索引。
  数据字典必须被调用者独占锁定，
  因为事务不会被提交
  
  
** Drop indexes that were created before an error occurred.
 The data dictionary must have been locked exclusively by the caller,
 because the transaction will not be committed. */
void row_merge_drop_indexes(
    trx_t *trx,          /*!< in/out: dictionary transaction */
    dict_table_t *table, /*!< in/out: table containing the indexes */
    ibool locked)        /*!< in: TRUE=table locked,
                         FALSE=may need to do a lazy drop */
{




dict_index_remove_from_cache


-- 设置在线索引创建状态
/** Sets the status of online index creation.
@param[in,out]	index	index
@param[in]	status	status */
static inline void dict_index_set_online_status(
    dict_index_t *index, enum online_index_status status);




/**
Rename all indexes in data dictionary cache of a given table that are
specified in ha_alter_info.

@param ctx alter context, used to fetch the list of indexes to rename
@param ha_alter_info fetch the new names from here
*/
static void rename_indexes_in_cache(const ha_innobase_inplace_ctx *ctx,
                                    const Alter_inplace_info *ha_alter_info) {
  DBUG_TRACE;

  ut_ad(ctx->num_to_rename == ha_alter_info->index_rename_count);

  for (ulint i = 0; i < ctx->num_to_rename; i++) {
    KEY_PAIR *pair = &ha_alter_info->index_rename_buffer[i];
    dict_index_t *index;

    index = ctx->rename[i];

    ut_ad(strcmp(index->name, pair->old_key->name) == 0);

    rename_index_in_cache(index, pair->new_key->name);
  }
}


/** Rename a given index in the InnoDB data dictionary cache.
@param[in,out] index index to rename
@param new_name new index name */
static void rename_index_in_cache(dict_index_t *index, const char *new_name) {
  DBUG_TRACE;

  ut_ad(dict_sys_mutex_own());
  ut_ad(rw_lock_own(dict_operation_lock, RW_LOCK_X));

  size_t old_name_len = strlen(index->name);
  size_t new_name_len = strlen(new_name);

  if (old_name_len >= new_name_len) {
    /* reuse the old buffer for the name if it is large enough */
    memcpy(const_cast<char *>(index->name()), new_name, new_name_len + 1);
  } else {
    /* Free the old chunk of memory if it is at the topmost
    place in the heap, otherwise the old chunk will be freed
    when the index is evicted from the cache. This code will
    kick-in in a repeated ALTER sequences where the old name is
    alternately longer/shorter than the new name:
    1. ALTER TABLE t RENAME INDEX a TO aa;
    2. ALTER TABLE t RENAME INDEX aa TO a;
    3. go to 1. */
    index->name =
        mem_heap_strdup_replace(index->heap,
                                /* Presumed topmost element of the heap: */
                                index->name, old_name_len + 1, new_name);
  }
}




dict_stats_drop_index

rename_indexes_in_cache

https://qcsdn.com/article/334002.html



alter table t1 drop index c;

mysql> show create table t1\G;
*************************** 1. row ***************************
       Table: t1
Create Table: CREATE TABLE `t1` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `c` int(11) DEFAULT NULL,
  `d` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `c` (`c`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4
1 row in set (0.00 sec)

ERROR: 
No query specified

mysql> SELECT * FROM T1;
+----+------+------+
| id | c    | d    |
+----+------+------+
|  1 |    1 |    1 |
|  3 |    3 |    3 |
|  5 |    5 |    5 |
+----+------+------+
3 rows in set (0.00 sec)



mysql> show create table t11\G;
*************************** 1. row ***************************
       Table: t11
Create Table: CREATE TABLE `t11` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `t1` int(10) NOT NULL,
  `t2` int(10) NOT NULL,
  `order_no` varchar(64) NOT NULL DEFAULT '' COMMENT 'order no',
  `status` int(10) NOT NULL,
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
  PRIMARY KEY (`ID`),
  KEY `idx_order_no` (`order_no`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4
1 row in set (0.00 sec)

ERROR: 
No query specified

mysql> select * from t11;
+----+----+----+----------+--------+---------------------+
| ID | t1 | t2 | order_no | status | createtime          |
+----+----+----+----------+--------+---------------------+
|  2 |  2 |  2 | 123789   |      0 | 2021-07-12 11:38:13 |
|  3 |  3 |  3 | 123789   |      0 | 2021-07-12 11:39:55 |
+----+----+----+----------+--------+---------------------+
2 rows in set (0.00 sec)




alter table t11 drop index idx_status;


fil_index_tree_is_freed() 函数在重新分配索引根页面时返回假阴性，已被用于释放索引树的改进逻辑所取代。 此补丁还删除了传递给 dict_drop_index_tree() 的冗余参数。 （错误＃19710798）

b dict_stats_drop_index