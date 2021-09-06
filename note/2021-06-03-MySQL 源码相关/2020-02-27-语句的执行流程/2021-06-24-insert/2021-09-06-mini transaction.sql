


函数堆栈为：row_ins_clust_index_entry_low -> btr_cur_search_to_nth_level -> btr_cur_latch_leaves。


UNIV_INTERN
dberr_t
row_ins_clust_index_entry_low(
/*==========================*/
    ulint        flags,    /*!< in: undo logging and locking flags */
    ulint        mode,    /*!< in: BTR_MODIFY_LEAF or BTR_MODIFY_TREE,
                depending on whether we wish optimistic or
                pessimistic descent down the index tree */
    dict_index_t*    index,    /*!< in: clustered index */
    ulint        n_uniq,    /*!< in: 0 or index->n_uniq */
    dtuple_t*    entry,    /*!< in/out: index entry to insert */
    ulint        n_ext,    /*!< in: number of externally stored columns */
    que_thr_t*    thr)    /*!< in: query thread */
{
    /* 开启一个 mini-transaction */
    mtr_start(&mtr);
     
    -- 调用 btr_cur_latch_leaves -> btr_block_get 加 RW_X_LATCH 
    btr_cur_search_to_nth_level(index, 0, entry, PAGE_CUR_LE, mode,
                    &cursor, 0, __FILE__, __LINE__, &mtr);
     
    if (mode != BTR_MODIFY_TREE) {
        /* 不需要修改 BTR_TREE，乐观插入 */
        err = btr_cur_optimistic_insert(
            flags, &cursor, &offsets, &offsets_heap,
            entry, &insert_rec, &big_rec,
            n_ext, thr, &mtr);
    } else {
        /* 需要修改 BTR_TREE，先乐观插入，乐观插入失败则进行悲观插入 */
        err = btr_cur_optimistic_insert(
            flags, &cursor,
            &offsets, &offsets_heap,
            entry, &insert_rec, &big_rec,
            n_ext, thr, &mtr);
        if (err == DB_FAIL) {
            err = btr_cur_pessimistic_insert(
                flags, &cursor,
                &offsets, &offsets_heap,
                entry, &insert_rec, &big_rec,
                n_ext, thr, &mtr);
        }
    }
     
    /* 提交 mini-transaction */
    mtr_commit(&mtr);
}

