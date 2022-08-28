shell> df -h
Filesystem      Size  Used Avail Use% Mounted on
devtmpfs         16G     0   16G   0% /dev
tmpfs            16G  176K   16G   1% /dev/shm
tmpfs            16G  1.1M   16G   1% /run
tmpfs            16G     0   16G   0% /sys/fs/cgroup
/dev/vda1        99G   88G  6.9G  93% /
tmpfs           3.2G     0  3.2G   0% /run/user/1001
tmpfs           3.2G     0  3.2G   0% /run/user/0
/dev/vdb1       493G  387G   81G  83% /newdata

shell> find . -mtime +30 -type f | xargs rm -rf 

shell> df -h
Filesystem      Size  Used Avail Use% Mounted on
devtmpfs         16G     0   16G   0% /dev
tmpfs            16G  176K   16G   1% /dev/shm
tmpfs            16G  1.1M   16G   1% /run
tmpfs            16G     0   16G   0% /sys/fs/cgroup
/dev/vda1        99G   42G   53G  45% /
tmpfs           3.2G     0  3.2G   0% /run/user/1001
tmpfs           3.2G     0  3.2G   0% /run/user/0
/dev/vdb1       493G  387G   81G  83% /newdata
