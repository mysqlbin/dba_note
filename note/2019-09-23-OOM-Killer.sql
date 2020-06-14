
Sep 22 16:22:28 mgr9 kernel: qmgr invoked oom-killer: gfp_mask=0x200da, order=0, oom_score_adj=0
Sep 22 16:22:28 mgr9 kernel: qmgr cpuset=/ mems_allowed=0
Sep 22 16:22:28 mgr9 kernel: CPU: 0 PID: 1190 Comm: qmgr Not tainted 3.10.0-693.el7.x86_64 #1
Sep 22 16:22:28 mgr9 kernel: Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
Sep 22 16:22:28 mgr9 kernel: ffff880117a9eeb0 0000000077a7b80a ffff8800d57a7988 ffffffff816a3d91
Sep 22 16:22:28 mgr9 kernel: ffff8800d57a7a18 ffffffff8169f186 ffffffff810e939c ffff8800d54dd980
Sep 22 16:22:28 mgr9 kernel: 0000000000000001 ffff8800d57a79c0 0000000000000206 ffff8800d57a7a08
Sep 22 16:22:28 mgr9 kernel: Call Trace:
Sep 22 16:22:28 mgr9 kernel: [<ffffffff816a3d91>] dump_stack+0x19/0x1b
Sep 22 16:22:28 mgr9 kernel: [<ffffffff8169f186>] dump_header+0x90/0x229
Sep 22 16:22:28 mgr9 kernel: [<ffffffff810e939c>] ? ktime_get_ts64+0x4c/0xf0
Sep 22 16:22:28 mgr9 kernel: [<ffffffff8113d36f>] ? delayacct_end+0x8f/0xb0
Sep 22 16:22:28 mgr9 kernel: [<ffffffff81186394>] oom_kill_process+0x254/0x3d0
Sep 22 16:22:28 mgr9 kernel: [<ffffffff81185e3d>] ? oom_unkillable_task+0xcd/0x120
Sep 22 16:22:28 mgr9 kernel: [<ffffffff81185ee6>] ? find_lock_task_mm+0x56/0xc0
Sep 22 16:22:28 mgr9 kernel: [<ffffffff81186bd6>] out_of_memory+0x4b6/0x4f0
Sep 22 16:22:28 mgr9 kernel: [<ffffffff8169fc8a>] __alloc_pages_slowpath+0x5d6/0x724
Sep 22 16:22:28 mgr9 kernel: [<ffffffff8118cd85>] __alloc_pages_nodemask+0x405/0x420
Sep 22 16:22:28 mgr9 kernel: [<ffffffff811d412f>] alloc_pages_vma+0xaf/0x1f0
Sep 22 16:22:28 mgr9 kernel: [<ffffffff81184f55>] ? filemap_fault+0x215/0x410
Sep 22 16:22:28 mgr9 kernel: [<ffffffff811c453d>] read_swap_cache_async+0xed/0x160
Sep 22 16:22:28 mgr9 kernel: [<ffffffff811f5396>] ? mem_cgroup_update_page_stat+0x16/0x50
Sep 22 16:22:28 mgr9 kernel: [<ffffffff811c4658>] swapin_readahead+0xa8/0x110
Sep 22 16:22:28 mgr9 kernel: [<ffffffff811b235b>] handle_mm_fault+0xadb/0xfa0
Sep 22 16:22:28 mgr9 kernel: [<ffffffff816affb4>] __do_page_fault+0x154/0x450
Sep 22 16:22:28 mgr9 kernel: [<ffffffff816b02e5>] do_page_fault+0x35/0x90
Sep 22 16:22:28 mgr9 kernel: [<ffffffff816ac508>] page_fault+0x28/0x30
Sep 22 16:22:28 mgr9 kernel: Mem-Info:
Sep 22 16:22:28 mgr9 kernel: active_anon:737874 inactive_anon:188536 isolated_anon:0#012 active_file:78 inactive_file:1315 isolated_file:0#012 unevictable:0 dirty:0 writeback:0 unstable:0#012 slab_reclaimable:4927 slab_unreclaimable:3318#012 mapped:840 shmem:764 pagetables:3854 bounce:0#012 free:21086 free_pcp:126 free_cma:0
Sep 22 16:22:28 mgr9 kernel: Node 0 DMA free:15360kB min:276kB low:344kB high:412kB active_anon:132kB inactive_anon:292kB active_file:24kB inactive_file:24kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:15992kB managed:15908kB mlocked:0kB dirty:0kB writeback:0kB mapped:96kB shmem:72kB slab_reclaimable:8kB slab_unreclaimable:36kB kernel_stack:0kB pagetables:12kB unstable:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB writeback_tmp:0kB pages_scanned:587 all_unreclaimable? yes
Sep 22 16:22:28 mgr9 kernel: lowmem_reserve[]: 0 3326 3773 3773
Sep 22 16:22:28 mgr9 kernel: Node 0 DMA32 free:61020kB min:59340kB low:74172kB high:89008kB active_anon:2747204kB inactive_anon:549484kB active_file:288kB inactive_file:5180kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:3653568kB managed:3408584kB mlocked:0kB dirty:0kB writeback:0kB mapped:3264kB shmem:2984kB slab_reclaimable:13500kB slab_unreclaimable:8244kB kernel_stack:2144kB pagetables:12604kB unstable:0kB bounce:0kB free_pcp:504kB local_pcp:504kB free_cma:0kB writeback_tmp:0kB pages_scanned:8434 all_unreclaimable? yes
Sep 22 16:22:28 mgr9 kernel: lowmem_reserve[]: 0 0 446 446
Sep 22 16:22:28 mgr9 kernel: Node 0 Normal free:7964kB min:7964kB low:9952kB high:11944kB active_anon:204160kB inactive_anon:204368kB active_file:0kB inactive_file:56kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:524288kB managed:457388kB mlocked:0kB dirty:0kB writeback:0kB mapped:0kB shmem:0kB slab_reclaimable:6200kB slab_unreclaimable:4992kB kernel_stack:672kB pagetables:2800kB unstable:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB writeback_tmp:0kB pages_scanned:374 all_unreclaimable? yes
Sep 22 16:22:28 mgr9 kernel: lowmem_reserve[]: 0 0 0 0
Sep 22 16:22:28 mgr9 kernel: Node 0 DMA: 5*4kB (UM) 4*8kB (UEM) 3*16kB (UEM) 3*32kB (UE) 1*64kB (E) 2*128kB (UE) 2*256kB (UE) 2*512kB (EM) 3*1024kB (UEM) 1*2048kB (E) 2*4096kB (M) = 15364kB
Sep 22 16:22:28 mgr9 kernel: Node 0 DMA32: 1281*4kB (UE) 1235*8kB (UEM) 900*16kB (UEM) 498*32kB (UEM) 183*64kB (UEM) 23*128kB (UE) 2*256kB (U) 1*512kB (M) 0*1024kB 0*2048kB 0*4096kB = 61020kB
Sep 22 16:22:28 mgr9 kernel: Node 0 Normal: 185*4kB (UEM) 176*8kB (UE) 108*16kB (UE) 50*32kB (UEM) 31*64kB (UEM) 4*128kB (UM) 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 7972kB
Sep 22 16:22:28 mgr9 kernel: Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
Sep 22 16:22:28 mgr9 kernel: 2868 total pagecache pages
Sep 22 16:22:28 mgr9 kernel: 702 pages in swap cache
Sep 22 16:22:28 mgr9 kernel: Swap cache stats: add 531072, delete 530370, find 3036/3506
Sep 22 16:22:28 mgr9 kernel: Free swap  = 0kB
Sep 22 16:22:28 mgr9 kernel: Total swap = 2097148kB
Sep 22 16:22:28 mgr9 kernel: 1048462 pages RAM
Sep 22 16:22:28 mgr9 kernel: 0 pages HighMem/MovableOnly
Sep 22 16:22:28 mgr9 kernel: 77992 pages reserved
Sep 22 16:22:28 mgr9 kernel: [ pid ]   uid  tgid total_vm      rss nr_ptes swapents oom_score_adj name
Sep 22 16:22:28 mgr9 kernel: [  465]     0   465     9218      794      23       46             0 systemd-journal
Sep 22 16:22:28 mgr9 kernel: [  485]     0   485    48162        0      30      618             0 lvmetad
Sep 22 16:22:28 mgr9 kernel: [  487]     0   487    11117        1      23      253         -1000 systemd-udevd
Sep 22 16:22:28 mgr9 kernel: [  616]     0   616    13874       14      27       98         -1000 auditd
Sep 22 16:22:28 mgr9 kernel: [  639]   999   639   133733       55      58     1983             0 polkitd
Sep 22 16:22:28 mgr9 kernel: [  640]    81   640     6147       54      16       64          -900 dbus-daemon
Sep 22 16:22:28 mgr9 kernel: [  645]     0   645     6062       38      17       39             0 systemd-logind
Sep 22 16:22:28 mgr9 kernel: [  646]     0   646    53572      606      43      148             0 rsyslogd
Sep 22 16:22:28 mgr9 kernel: [  657]    32   657    16250       13      35      118             0 rpcbind
Sep 22 16:22:28 mgr9 kernel: [  663]     0   663    48770        0      35      128             0 gssproxy
Sep 22 16:22:28 mgr9 kernel: [  674]     0   674    31570       27      18      129             0 crond
Sep 22 16:22:28 mgr9 kernel: [  676]     0   676    27522        1      10       33             0 agetty
Sep 22 16:22:28 mgr9 kernel: [  678]     0   678   117975      155      83      418             0 NetworkManager
Sep 22 16:22:28 mgr9 kernel: [  970]     0   970    27150        0      55      255         -1000 sshd
Sep 22 16:22:28 mgr9 kernel: [  971]     0   971   140669      102      94     2592             0 tuned
Sep 22 16:22:28 mgr9 kernel: [ 1188]     0  1188    22411       16      43      242             0 master
Sep 22 16:22:28 mgr9 kernel: [ 1190]    89  1190    22481       13      43      250             0 qmgr
Sep 22 16:22:28 mgr9 kernel: [ 2912]     0  2912    28326        0      12       88             0 mysqld_safe
Sep 22 16:22:28 mgr9 kernel: [ 4402]  1001  4402  2559163   439693    1925   505304             0 mysqld
Sep 22 16:22:28 mgr9 kernel: [ 6838]     0  6838    37727       41      77      307             0 sshd
Sep 22 16:22:28 mgr9 kernel: [ 6840]     0  6840    28892        2      13      120             0 bash
Sep 22 16:22:28 mgr9 kernel: [ 6881]     0  6881    37768       51      76      316             0 sshd
Sep 22 16:22:28 mgr9 kernel: [ 6883]     0  6883    28892        1      11      121             0 bash
Sep 22 16:22:28 mgr9 kernel: [ 8065]    89  8065    22437       12      44      238             0 pickup
Sep 22 16:22:28 mgr9 kernel: [10537]     0 10537   539601   483720     984     8833             0 mysql
Sep 22 16:22:28 mgr9 kernel: [11013]     0 11013    39413      170      32        0             0 top
Sep 22 16:22:28 mgr9 kernel: Out of memory: Kill process 4402 (mysqld) score 633 or sacrifice child
Sep 22 16:22:28 mgr9 kernel: Killed process 4402 (mysqld) total-vm:10236652kB, anon-rss:1758772kB, file-rss:0kB, shmem-rss:0kB
Sep 22 16:22:29 mgr9 systemd-logind: Removed session 185.
Sep 22 16:22:51 mgr9 systemd: Started Session 952 of user root.
Sep 22 16:22:51 mgr9 systemd-logind: New session 952 of user root.
Sep 22 16:22:51 mgr9 systemd: Starting Session 952 of user root.
Sep 22 16:23:33 mgr9 systemd: Started Session 953 of user root.
Sep 22 16:23:33 mgr9 systemd-logind: New session 953 of user root.
Sep 22 16:23:33 mgr9 systemd: Starting Session 953 of user root.


