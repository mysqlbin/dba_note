


ib_warn_row_too_big
dict_index_too_big_for_tree

dict_index_add_to_cache_w_vcol
	-> dict_index_too_big_for_tree
		-> ib_warn_row_too_big

	
/**********************************************************************
Issue a warning that the row is too big. */
void
ib_warn_row_too_big(const dict_table_t*	table)
{
	-- 如果 prefix 为 true，则把 blob 字段的前768字节存储在行记录中。
	/* If prefix is true then a 768-byte prefix is stored
	locally for BLOB fields. Refer to dict_table_get_format() */
	const bool prefix = (dict_tf_get_format(table->flags)
			     == UNIV_FORMAT_A);

	const ulint	free_space = page_get_free_space_of_empty(
		table->flags & DICT_TF_COMPACT) / 2;

	THD*	thd = current_thd;

	push_warning_printf(
		thd, Sql_condition::SL_WARNING, HA_ERR_TOO_BIG_ROW,
		"Row size too large (> %lu). Changing some columns to TEXT"
		" or BLOB %smay help. In current row format, BLOB prefix of"
		" %d bytes is stored inline.", free_space
		, prefix ? "or using ROW_FORMAT=DYNAMIC or"
		" ROW_FORMAT=COMPRESSED ": ""
		, prefix ? DICT_MAX_FIXED_COL_LEN : 0);
}



/** The size of a reference to data stored on a different page.
The reference is stored at the end of the prefix of the field
in the index record. */
#define BTR_EXTERN_FIELD_REF_SIZE	FIELD_REF_SIZE

#define FIELD_REF_SIZE 20

/** If the data don't exceed the size, the data are stored locally. */
#define BTR_EXTERN_LOCAL_STORED_MAX_SIZE	\
	(BTR_EXTERN_FIELD_REF_SIZE * 2)
	

-- 叶子索引页单行记录的最大大小
/* maximum allowed size of a record on a leaf page */
	ulint	page_rec_max;
	
	
-- mysql-5.7.26\storage\innobase\dict\dict0dict.cc

/****************************************************************//**
If a record of this index might not fit on a single B-tree page,
return TRUE.
@return TRUE if the index record could become too big */
static
ibool
dict_index_too_big_for_tree(
/*========================*/
	const dict_table_t*	table,		/*!< in: table */
	const dict_index_t*	new_index,	/*!< in: index */
	bool			strict)		/*!< in: TRUE=report error if
						records could be too big to
						fit in an B-tree page */
{
	ulint	comp;
	ulint	i;
	/* maximum possible storage size of a record */
	ulint	rec_max_size;
	/* maximum allowed size of a record on a leaf page */
	ulint	page_rec_max;
	/* maximum allowed size of a node pointer record */
	ulint	page_ptr_max;

	/* FTS index consists of auxiliary tables, they shall be excluded from
	index row size check */
	if (new_index->type & DICT_FTS) {
		return(false);
	}

	DBUG_EXECUTE_IF(
		"ib_force_create_table",
		return(FALSE););

	comp = dict_table_is_comp(table);

	const page_size_t	page_size(dict_table_page_size(table));

	if (page_size.is_compressed()
	    && page_size.physical() < univ_page_size.physical()) {
		/* On a compressed page, two records must fit in the
		uncompressed page modification log. On compressed pages
		with size.physical() == univ_page_size.physical(),
		this limit will never be reached. */
		ut_ad(comp);
		/* The maximum allowed record size is the size of
		an empty page, minus a byte for recoding the heap
		number in the page modification log.  The maximum
		allowed node pointer size is half that. */
		page_rec_max = page_zip_empty_size(new_index->n_fields,
						   page_size.physical());
		if (page_rec_max) {
			page_rec_max--;
		}
		page_ptr_max = page_rec_max / 2;
		/* On a compressed page, there is a two-byte entry in
		the dense page directory for every record.  But there
		is no record header. */
		rec_max_size = 2;
	} else {
		/* The maximum allowed record size is half a B-tree
		page(16k for 64k page size).  No additional sparse
		page directory entry will be generated for the first
		few user records. */
		page_rec_max = srv_page_size == UNIV_PAGE_SIZE_MAX
			? REC_MAX_DATA_SIZE - 1
			: page_get_free_space_of_empty(comp) / 2;
		page_ptr_max = page_rec_max;
		/* Each record has a header. */
		rec_max_size = comp
			? REC_N_NEW_EXTRA_BYTES
			: REC_N_OLD_EXTRA_BYTES;
	}

	if (comp) {
		/* Include the "null" flags in the
		maximum possible record size. */
		rec_max_size += UT_BITS_IN_BYTES(new_index->n_nullable);
	} else {
		/* For each column, include a 2-byte offset and a
		"null" flag.  The 1-byte format is only used in short
		records that do not contain externally stored columns.
		Such records could never exceed the page limit, even
		when using the 2-byte format. */
		rec_max_size += 2 * new_index->n_fields;
	}

	/* Compute the maximum possible record size. */
	for (i = 0; i < new_index->n_fields; i++) {
		const dict_field_t*	field
			= dict_index_get_nth_field(new_index, i);
		const dict_col_t*	col
			= dict_field_get_col(field);
		ulint			field_max_size;
		ulint			field_ext_max_size;

		/* In dtuple_convert_big_rec(), variable-length columns
		that are longer than BTR_EXTERN_LOCAL_STORED_MAX_SIZE
		may be chosen for external storage.

		Fixed-length columns, and all columns of secondary
		index records are always stored inline. */

		/* Determine the maximum length of the index field.
		The field_ext_max_size should be computed as the worst
		case in rec_get_converted_size_comp() for
		REC_STATUS_ORDINARY records. */

		field_max_size = dict_col_get_fixed_size(col, comp);
		if (field_max_size && field->fixed_len != 0) {
			/* dict_index_add_col() should guarantee this */
			ut_ad(!field->prefix_len
			      || field->fixed_len == field->prefix_len);
			/* Fixed lengths are not encoded
			in ROW_FORMAT=COMPACT. */
			field_ext_max_size = 0;
			goto add_field_size;
		}

		field_max_size = dict_col_get_max_size(col);
		field_ext_max_size = field_max_size < 256 ? 1 : 2;

		if (field->prefix_len) {
			if (field->prefix_len < field_max_size) {
				field_max_size = field->prefix_len;
			}
		} else if (field_max_size > BTR_EXTERN_LOCAL_STORED_MAX_SIZE
			   && dict_index_is_clust(new_index)) {
			
			
			-- 如果变长字段的最大值大于40 （溢出页指针的2倍），则这个字段在页内只保留40个字节，且长度变量设置为1，即总共占用41个字节。
			-- 有源码的加持，理解起来会更加容易。
			
			/*
			#define BTR_EXTERN_FIELD_REF_SIZE	FIELD_REF_SIZE

			#define FIELD_REF_SIZE 20

			#define BTR_EXTERN_LOCAL_STORED_MAX_SIZE	(BTR_EXTERN_FIELD_REF_SIZE * 2)
			*/
	
			/* In the worst case, we have a locally stored
			column of BTR_EXTERN_LOCAL_STORED_MAX_SIZE bytes.
			The length can be stored in one byte.  If the
			column were stored externally, the lengths in
			the clustered index page would be
			BTR_EXTERN_FIELD_REF_SIZE and 2. */
			field_max_size = BTR_EXTERN_LOCAL_STORED_MAX_SIZE;
			field_ext_max_size = 1;
		}

		if (comp) {
			/* Add the extra size for ROW_FORMAT=COMPACT.
			For ROW_FORMAT=REDUNDANT, these bytes were
			added to rec_max_size before this loop. */
			rec_max_size += field_ext_max_size;
		}
add_field_size:
		rec_max_size += field_max_size;
		
		-- 检查叶子索引页的大小限制
		/* Check the size limit on leaf pages. */
		if (rec_max_size >= page_rec_max) {
			ib::error_or_warn(strict)
				<< "Cannot add field " << field->name
				<< " in table " << table->name
				<< " because after adding it, the row size is "
				<< rec_max_size
				<< " which is greater than maximum allowed"
				" size (" << page_rec_max
				<< ") for a record on index leaf page.";

			return(TRUE);
		}

		/* Check the size limit on non-leaf pages.  Records
		stored in non-leaf B-tree pages consist of the unique
		columns of the record (the key columns of the B-tree)
		and a node pointer field.  When we have processed the
		unique columns, rec_max_size equals the size of the
		node pointer record minus the node pointer column. */
		if (i + 1 == dict_index_get_n_unique_in_tree(new_index)
		    && rec_max_size + REC_NODE_PTR_SIZE >= page_ptr_max) {

			return(TRUE);
		}
	}

	return(FALSE);
}



/** Adds an index to the dictionary cache, with possible indexing newly
added column.
@param[in,out]	table	table on which the index is
@param[in,out]	index	index; NOTE! The index memory
			object is freed in this function!
@param[in]	add_v	new virtual column that being added along with
			an add index call
@param[in]	page_no	root page number of the index
@param[in]	strict	TRUE=refuse to create the index
			if records could be too big to fit in
			an B-tree page
@return DB_SUCCESS, DB_TOO_BIG_RECORD, or DB_CORRUPTION */
dberr_t
dict_index_add_to_cache_w_vcol(
	dict_table_t*		table,
	dict_index_t*		index,
	const dict_add_v_col_t* add_v,
	ulint			page_no,
	ibool			strict)
{
	dict_index_t*	new_index;
	ulint		n_ord;
	ulint		i;

	ut_ad(index);
	ut_ad(mutex_own(&dict_sys->mutex) || dict_table_is_intrinsic(table));
	ut_ad(index->n_def == index->n_fields);
	ut_ad(index->magic_n == DICT_INDEX_MAGIC_N);
	ut_ad(!dict_index_is_online_ddl(index));
	ut_ad(!dict_index_is_ibuf(index));

	ut_d(mem_heap_validate(index->heap));
	ut_a(!dict_index_is_clust(index)
	     || UT_LIST_GET_LEN(table->indexes) == 0);

	if (!dict_index_find_cols(table, index, add_v)) {

		dict_mem_index_free(index);
		return(DB_CORRUPTION);
	}

	/* Build the cache internal representation of the index,
	containing also the added system fields */

	if (index->type == DICT_FTS) {
		new_index = dict_index_build_internal_fts(table, index);
	} else if (dict_index_is_clust(index)) {
		new_index = dict_index_build_internal_clust(table, index);
	} else {
		new_index = dict_index_build_internal_non_clust(table, index);
	}

	/* Set the n_fields value in new_index to the actual defined
	number of fields in the cache internal representation */

	new_index->n_fields = new_index->n_def;
	new_index->trx_id = index->trx_id;
	new_index->set_committed(index->is_committed());
	new_index->allow_duplicates = index->allow_duplicates;
	new_index->nulls_equal = index->nulls_equal;
	new_index->disable_ahi = index->disable_ahi;

	if (dict_index_too_big_for_tree(table, new_index, strict)) {

		if (strict) {
			dict_mem_index_free(new_index);
			dict_mem_index_free(index);
			return(DB_TOO_BIG_RECORD);
		} else if (current_thd != NULL) {
			/* Avoid the warning to be printed
			during recovery. */
			ib_warn_row_too_big(table);
		}
	}

	n_ord = new_index->n_uniq;

	/* Flag the ordering columns and also set column max_prefix */

	for (i = 0; i < n_ord; i++) {
		const dict_field_t*	field
			= dict_index_get_nth_field(new_index, i);

		/* Check the column being added in the index for
		the first time and flag the ordering column. */
		if (field->col->ord_part == 0 ) {
			field->col->max_prefix = field->prefix_len;
			field->col->ord_part = 1;
		} else if (field->prefix_len == 0) {
			/* Set the max_prefix for a column to 0 if
			its prefix length is 0 (for this index)
			even if it was a part of any other index
			with some prefix length. */
			field->col->max_prefix = 0;
		} else if (field->col->max_prefix != 0
			   && field->prefix_len
			   > field->col->max_prefix) {
			/* Set the max_prefix value based on the
			prefix_len. */
			field->col->max_prefix = field->prefix_len;
		}
		ut_ad(field->col->ord_part == 1);
	}

	new_index->stat_n_diff_key_vals =
		static_cast<ib_uint64_t*>(mem_heap_zalloc(
			new_index->heap,
			dict_index_get_n_unique(new_index)
			* sizeof(*new_index->stat_n_diff_key_vals)));

	new_index->stat_n_sample_sizes =
		static_cast<ib_uint64_t*>(mem_heap_zalloc(
			new_index->heap,
			dict_index_get_n_unique(new_index)
			* sizeof(*new_index->stat_n_sample_sizes)));

	new_index->stat_n_non_null_key_vals =
		static_cast<ib_uint64_t*>(mem_heap_zalloc(
			new_index->heap,
			dict_index_get_n_unique(new_index)
			* sizeof(*new_index->stat_n_non_null_key_vals)));

	new_index->stat_index_size = 1;
	new_index->stat_n_leaf_pages = 1;

	/* Add the new index as the last index for the table */

	UT_LIST_ADD_LAST(table->indexes, new_index);
	new_index->table = table;
	new_index->table_name = table->name.m_name;
	new_index->search_info = btr_search_info_create(new_index->heap);

	new_index->page = page_no;
	rw_lock_create(index_tree_rw_lock_key, &new_index->lock,
		       SYNC_INDEX_TREE);

	/* Intrinsic table are not added to dictionary cache instead are
	cached to session specific thread cache. */
	if (!dict_table_is_intrinsic(table)) {
		dict_sys->size += mem_heap_get_size(new_index->heap);
	}

	/* Check if key part of the index is unique. */
	if (dict_table_is_intrinsic(table)) {

		new_index->rec_cache.fixed_len_key = true;
		for (i = 0; i < new_index->n_uniq; i++) {

			const dict_field_t*	field;
			field = dict_index_get_nth_field(new_index, i);

			if (!field->fixed_len) {
				new_index->rec_cache.fixed_len_key = false;
				break;
			}
		}

		new_index->rec_cache.key_has_null_cols = false;
		for (i = 0; i < new_index->n_uniq; i++) {

			const dict_field_t*	field;
			field = dict_index_get_nth_field(new_index, i);

			if (!(field->col->prtype & DATA_NOT_NULL)) {
				new_index->rec_cache.key_has_null_cols = true;
				break;
			}
		}
	}

	dict_mem_index_free(index);

	return(DB_SUCCESS);
}





