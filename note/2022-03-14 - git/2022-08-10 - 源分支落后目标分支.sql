feature/online_self_service 落后  test/20220808



xiaoe@LAPTOP-EEB0MEGN MINGW64 /d/project/code/db-work (feature/online_self_service)
$ git checkout test/20220808
Switched to a new branch 'test/20220808'
Branch 'test/20220808' set up to track remote branch 'test/20220808' from 'origin'.

xiaoe@LAPTOP-EEB0MEGN MINGW64 /d/project/code/db-work (test/20220808)
$ git pull
Already up to date.

---------------------------------------------------------------------

xiaoe@LAPTOP-EEB0MEGN MINGW64 /d/project/code/db-work (test/20220808)
$ git checkout feature/online_self_service
Switched to branch 'feature/online_self_service'
Your branch is up to date with 'origin/feature/online_self_service'.

xiaoe@LAPTOP-EEB0MEGN MINGW64 /d/project/code/db-work (feature/online_self_service)
$ git merge  test/20220808
Already up to date!
Merge made by the 'recursive' strategy.

xiaoe@LAPTOP-EEB0MEGN MINGW64 /d/project/code/db-work (feature/online_self_service)
$ git status
On branch feature/online_self_service
Your branch is ahead of 'origin/feature/online_self_service' by 2 commits.
  (use "git push" to publish your local commits)

Untracked files:
  (use "git add <file>..." to include in what will be committed)

        nohup.out

nothing added to commit but untracked files present (use "git add" to track)

xiaoe@LAPTOP-EEB0MEGN MINGW64 /d/project/code/db-work (feature/online_self_service)
$ git push
Enumerating objects: 1, done.
Counting objects: 100% (1/1), done.
Writing objects: 100% (1/1), 247 bytes | 22.00 KiB/s, done.
Total 1 (delta 0), reused 0 (delta 0)
remote:
remote: To create a merge request for feature/online_self_service, visit:
remote:   ............
remote:
To talkcheap.xiaoeknow.com:plat/db-work.git
   1c93701..6c4a768  feature/online_self_service -> feature/online_self_service



------------------------------------------------------------------------------------------------------------------------------

xiaoe@LAPTOP-EEB0MEGN MINGW64 /d/project/code/db-work (feature/online_self_service)
$ git merge test/20220808
Already up to date.

xiaoe@LAPTOP-EEB0MEGN MINGW64 /d/project/code/db-work (feature/online_self_service)
$ git pull
remote: Enumerating objects: 1, done.
remote: Counting objects: 100% (1/1), done.
remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (1/1), done.
From talkcheap.xiaoeknow.com:plat/db-work
   669bc63..3e169e8  test/20220808 -> origin/test/20220808
Already up to date.

xiaoe@LAPTOP-EEB0MEGN MINGW64 /d/project/code/db-work (feature/online_self_service)
$ git merge test/20220808
Already up to date.

xiaoe@LAPTOP-EEB0MEGN MINGW64 /d/project/code/db-work (feature/online_self_service)
$



