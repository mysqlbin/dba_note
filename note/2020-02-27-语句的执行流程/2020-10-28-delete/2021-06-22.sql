

E:\github\mysql-5.7.26\storage\innobase\row\row0upd.cc

/***********************************************************//**
Marks the clustered index record deleted and inserts the updated version
of the record to the index. This function should be used when the ordering
fields of the clustered index record change. This should be quite rare in
database applications.
@return DB_SUCCESS if operation successfully completed, else error
code or DB_LOCK_WAIT */
static MY_ATTRIBUTE((warn_unused_result))
dberr_t
row_upd_clust_rec_by_insert(
/*========================*/
	ulint		flags,  /*!< in: undo logging and locking flags */
	upd_node_t*	node,	/*!< in/out: row update node */
	dict_index_t*	index,	/*!< in: clustered index of the record */
	que_thr_t*	thr,	/*!< in: query thread */
	ibool		referenced,/*!< in: TRUE if index may be referenced in
				a foreign key constraint */
	mtr_t*		mtr)	/*!< in/out: mtr; gets committed here */
{




E:\github\mysql-5.7.26\storage\innobase\btr\btr0cur.cc
/***********************************************************//**
Marks a clustered index record deleted. Writes an undo log record to
undo log on this delete marking. Writes in the trx id field the id
of the deleting transaction, and in the roll ptr field pointer to the
undo log record created.
@return DB_SUCCESS, DB_LOCK_WAIT, or error number */
dberr_t
btr_cur_del_mark_set_clust_rec(
/*===========================*/
	ulint		flags,  /*!< in: undo logging and locking flags */
	buf_block_t*	block,	/*!< in/out: buffer block of the record */
	rec_t*		rec,	/*!< in/out: record */
	dict_index_t*	index,	/*!< in: clustered index of the record */
	const ulint*	offsets,/*!< in: rec_get_offsets(rec) */
	que_thr_t*	thr,	/*!< in: query thread */
	const dtuple_t*	entry,	/*!< in: dtuple for the deleting record */
	mtr_t*		mtr)	/*!< in/out: mini-transaction */
	MY_ATTRIBUTE((warn_unused_result));
	
	
-----------------------------------------------------------------------------------

btr_cur_del_mark_set_clust_rec->btr_rec_set_deleted_flag


/* mysql-5.7.26\storage\innobase\include\btr0cur.ic */

/* 以下函数用于设置记录的删除位 */
/******************************************************//**
The following function is used to set the deleted bit of a record. */
UNIV_INLINE
void
btr_rec_set_deleted_flag(
/*=====================*/
	rec_t*		rec,	/*!< in/out: physical record */
	page_zip_des_t*	page_zip,/*!< in/out: compressed page (or NULL) */
	ulint		flag)	/*!< in: nonzero if delete marked */
{
	if (page_rec_is_comp(rec)) {
		rec_set_deleted_flag_new(rec, page_zip, flag);
	} else {
		ut_ad(!page_zip);
		rec_set_deleted_flag_old(rec, flag);
	}
}

#endif /* !UNIV_HOTBACKUP */



更新主键索引的情况
	ha_innobase::update_row -> row_update_for_mysql -> row_upd_step -> row_upd -> row_upd_clust_step -> row_upd_clust_rec_by_insert -> btr_cur_del_mark_set_clust_rec -> row_ins_index_entry


更新非主键值，但是影响二级索引的情况
	ha_innobase::update_row -> row_update_for_mysql -> row_upd_step -> row_upd -> row_upd_sec_step -> row_upd_sec_index_entry -> btr_cur_del_mark_set_sec_rec -> row_ins_sec_index_entry


https://developer.aliyun.com/article/40971   [MySQL 学习] Innodb Optimistic Delete 简述

https://blog.csdn.net/weixin_33714884/article/details/89627823


删除记录只是打了删除标记的原因：加快执行删除语句的速度，加速语句的响应时间。



后面打个断点，追踪下 delete 语句的栈帧

	CREATE TABLE `t` (
		  `id` int(11) NOT NULL,
		  `a` int(11) DEFAULT NULL,
		  `t_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
		  PRIMARY KEY (`id`),
		  KEY `t_modified`(`t_modified`)
		) ENGINE=InnoDB; 
	insert into t values(5,1,'2018-11-13');

b ha_innobase::update_row

delete from t where id=5;


