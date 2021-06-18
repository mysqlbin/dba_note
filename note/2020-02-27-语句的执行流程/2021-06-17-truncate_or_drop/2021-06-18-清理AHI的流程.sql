




create  database test_db DEFAULT CHARSET utf8mb4 --UTF-8 Unicode COLLATE utf8mb4_general_ci;



use test_db;

CREATE TABLE `t` (
	  `id` int(11) NOT NULL,
	  `a` int(11) DEFAULT NULL,
	  `t_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  PRIMARY KEY (`id`),
	  KEY `t_modified`(`t_modified`)
	) ENGINE=InnoDB; 
insert into t values(5,1,'2018-11-13');

	
b ha_remove_all_nodes_to_page


(gdb) b ha_remove_all_nodes_to_page
Breakpoint 2 at 0x1c02186: file /usr/local/mysql/storage/innobase/ha/ha0ha.cc, line 414.
(gdb) info b
Num     Type           Disp Enb Address            What
1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
	breakpoint already hit 1 time
2       breakpoint     keep y   0x0000000001c02186 in ha_remove_all_nodes_to_page(hash_table_t*, unsigned long, unsigned char const*) at /usr/local/mysql/storage/innobase/ha/ha0ha.cc:414


drop table t;
(Blocked)

(gdb) c
Continuing.


mysql> drop table t;
Query OK, 0 rows affected (25.81 sec)



Thread 32 (Thread 0x7f5d002b2700 (LWP 8156)):

#0 ha_remove_all_nodes_to_page

#1 btr_search_drop_page_hash_index

#2 btr_search_drop_page_hash_when_freed

#3 fseg_free_extent

#4 fseg_free_step

#5 btr_free_but_not_root

#6 btr_free_if_exists

#7 dict_drop_index_tree

#8 row_upd_clust_step

#9 row_upd

#10 row_upd_step

#11 que_thr_step

#12 que_run_threads_low

#13 que_run_threads

#14 que_eval_sql

#15 row_drop_table_for_mysql

#16 ha_innobase::delete_table

#17 ha_delete_table

#18 mysql_rm_table_no_locks

#19 mysql_rm_table

#20 mysql_execute_command

#21 mysql_parse

#22 dispatch_command

#23 do_command

#24 handle_connection

#25 pfs_spawn_thread

#26 start_thread ()







btr_search_drop_page_hash_when_freed
	/* mysql-5.7.26\storage\innobase\btr\btr0sea.cc */

	/* 删除任何可能指向索引的自适应哈希索引条目
	可能在缓冲池中的页面，当一个页面从
	缓冲池或在文件段中释放。 */
	/** Drop any adaptive hash index entries that may point to an index
	page that may be in the buffer pool, when a page is evicted from the
	buffer pool or freed in a file segment.
	@param[in]	page_id		page id
	@param[in]	page_size	page size */
	void
	btr_search_drop_page_hash_when_freed()
	{
		btr_search_drop_page_hash_index(block);
	}





btr_search_drop_page_hash_when_freed->btr_search_drop_page_hash_index->ha_remove_all_nodes_to_page
	/* mysql-5.7.26\storage\innobase\btr\btr0sea.cc */

	/* 删除任何指向索引页的自适应哈希索引条目。 */

	/** Drop any adaptive hash index entries that point to an index page.
	@param[in,out]	block	block containing index page, s- or x-latched, or an
				index page for which we know that
				block->buf_fix_count == 0 or it is an index page which
				has already been removed from the buf_pool->page_hash
				i.e.: it is in state BUF_BLOCK_REMOVE_HASH */
	void
	btr_search_drop_page_hash_index(buf_block_t* block)
	{



		for (i = 0; i < n_cached; i++) {

			ha_remove_all_nodes_to_page(
				btr_search_sys->hash_tables[ahi_slot],
				folds[i], page);
		}
		
btr_search_drop_page_hash_when_freed->btr_search_drop_page_hash_index->ha_remove_all_nodes_to_page

	/*****************************************************************//**
	Removes from the chain determined by fold all nodes whose data pointer
	points to the page given. */
	void
	ha_remove_all_nodes_to_page(
	/*========================*/
		hash_table_t*	table,	/*!< in: hash table */
		ulint		fold,	/*!< in: fold value */
		const page_t*	page)	/*!< in: buffer page */
	{
		ha_node_t*	node;

		ut_ad(table);
		ut_ad(table->magic_n == HASH_TABLE_MAGIC_N);
		hash_assert_can_modify(table, fold);
		ut_ad(btr_search_enabled);

		node = ha_chain_get_first(table, fold);

		while (node) {
			if (page_align(ha_node_get_data(node)) == page) {

				/* Remove the hash node */

				ha_delete_hash_node(table, node);

				/* Start again from the first node in the chain
				because the deletion may compact the heap of
				nodes and move other nodes! */

				node = ha_chain_get_first(table, fold);
			} else {
				node = ha_chain_get_next(node);
			}
		}
	#ifdef UNIV_DEBUG
		/* Check that all nodes really got deleted */

		node = ha_chain_get_first(table, fold);

		while (node) {
			ut_a(page_align(ha_node_get_data(node)) != page);

			node = ha_chain_get_next(node);
		}
	#endif /* UNIV_DEBUG */
	}


btr_search_drop_page_hash_when_freed->btr_search_drop_page_hash_index->ha_remove_all_nodes_to_page->ha_delete_hash_node
	/***********************************************************//**
	Deletes a hash node. */
	void
	ha_delete_hash_node(
	/*================*/
		hash_table_t*	table,		/*!< in: hash table */
		ha_node_t*	del_node)	/*!< in: node to be deleted */
	{
		ut_ad(table);
		ut_ad(table->magic_n == HASH_TABLE_MAGIC_N);
		ut_d(ha_btr_search_latch_x_locked(table));
		ut_ad(btr_search_enabled);
	#if defined UNIV_AHI_DEBUG || defined UNIV_DEBUG
		if (table->adaptive) {
			ut_a(del_node->block->frame = page_align(del_node->data));
			ut_a(os_atomic_decrement_ulint(&del_node->block->n_pointers, 1)
				 < MAX_N_POINTERS);
		}
	#endif /* UNIV_AHI_DEBUG || UNIV_DEBUG */

		HASH_DELETE_AND_COMPACT(ha_node_t, next, table, del_node);
	}
	
