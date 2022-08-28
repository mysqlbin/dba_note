
(venv4archery) [root@VM-0-110-centos dbops]# supervisorctl stop all
qcluster: stopped
celeryworker: stopped
archery: stopped

(venv4archery) [root@VM-0-110-centos dbops]# ps aux|grep python
root      9522  0.0  0.2 574204 11596 ?        Ssl  Feb15  20:49 /usr/bin/python2 -Es /usr/sbin/tuned -l -P
root     27075  0.1  2.0 444900 79516 ?        S    Jun30  66:20 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/celery worker -A archery --loglevel=info
root     27076  0.0  0.4 207696 18028 ?        S    Jun30   7:09 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/gunicorn -w 8 -b 127.0.0.1:8000 --timeout 1200 archery.wsgi:application
root     27077  0.0  1.8 439196 73500 ?        S    Jun30   0:01 python manage.py qcluster
root     27080  0.0  2.2 453740 86296 ?        S    Jun30   2:45 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/gunicorn -w 8 -b 127.0.0.1:8000 --timeout 1200 archery.wsgi:application
root     27081  0.0  2.1 449380 83988 ?        S    Jun30   2:49 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/gunicorn -w 8 -b 127.0.0.1:8000 --timeout 1200 archery.wsgi:application
root     27082  0.0  2.1 451692 84180 ?        S    Jun30   2:41 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/gunicorn -w 8 -b 127.0.0.1:8000 --timeout 1200 archery.wsgi:application
root     27084  0.0  2.2 454532 86944 ?        S    Jun30   2:47 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/gunicorn -w 8 -b 127.0.0.1:8000 --timeout 1200 archery.wsgi:application
root     27085  0.0  2.2 453924 86576 ?        S    Jun30   2:49 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/gunicorn -w 8 -b 127.0.0.1:8000 --timeout 1200 archery.wsgi:application
root     27089  0.0  2.2 450888 85488 ?        S    Jun30   2:40 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/gunicorn -w 8 -b 127.0.0.1:8000 --timeout 1200 archery.wsgi:application
root     27093  0.0  2.1 450560 83164 ?        S    Jun30   2:44 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/gunicorn -w 8 -b 127.0.0.1:8000 --timeout 1200 archery.wsgi:application
root     27098  0.0  2.1 450576 83252 ?        S    Jun30   2:44 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/gunicorn -w 8 -b 127.0.0.1:8000 --timeout 1200 archery.wsgi:application
root     27299  0.1  2.0 447264 80120 ?        S    Jun30  93:10 python manage.py qcluster
root     27300  0.0  1.8 439860 72240 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27301  0.0  1.8 439864 72252 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27302  0.0  1.8 439868 72260 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27303  0.0  1.8 439872 72288 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27304  0.0  1.8 439876 72284 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27305  0.0  1.8 439880 72300 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27306  0.0  1.8 439884 72296 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27307  0.0  1.8 439888 72284 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27308  0.0  1.8 439892 72272 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27309  0.0  1.8 439896 72276 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27310  0.0  1.8 439900 72264 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27311  0.0  1.8 439904 72260 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27312  0.0  1.8 439908 72424 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27313  0.0  1.8 439912 72656 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27314  0.0  1.8 439916 72632 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27315  0.0  1.8 439916 72288 ?        S    Jun30   0:00 python manage.py qcluster
root     27316  0.0  2.0 446796 77816 ?        S    Jun30   0:00 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/celery worker -A archery --loglevel=info
root     27317  0.0  1.8 439660 71948 ?        Sl   Jun30  11:37 python manage.py qcluster
root     27318  0.0  1.9 442620 74848 ?        S    Jun30   0:00 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/celery worker -A archery --loglevel=info
root     27950  0.0  0.4 213152 17840 ?        Ss   Jun30  40:05 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/supervisord -c supervisord.conf
root     28000  0.0  0.0 112720   968 pts/1    S+   18:16   0:00 grep --color=auto python
(venv4archery) [root@VM-0-110-centos dbops]# ps aux|grep python
root      9522  0.0  0.2 574204 11596 ?        Ssl  Feb15  20:49 /usr/bin/python2 -Es /usr/sbin/tuned -l -P
root     27075  0.1  2.0 444900 79516 ?        S    Jun30  66:20 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/celery worker -A archery --loglevel=info
root     27076  0.0  0.4 207696 18028 ?        S    Jun30   7:09 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/gunicorn -w 8 -b 127.0.0.1:8000 --timeout 1200 archery.wsgi:application
root     27077  0.0  1.8 439196 73500 ?        S    Jun30   0:01 python manage.py qcluster
root     27080  0.0  2.2 453740 86296 ?        S    Jun30   2:45 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/gunicorn -w 8 -b 127.0.0.1:8000 --timeout 1200 archery.wsgi:application
root     27081  0.0  2.1 449380 83988 ?        S    Jun30   2:49 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/gunicorn -w 8 -b 127.0.0.1:8000 --timeout 1200 archery.wsgi:application
root     27082  0.0  2.1 451692 84180 ?        S    Jun30   2:41 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/gunicorn -w 8 -b 127.0.0.1:8000 --timeout 1200 archery.wsgi:application
root     27084  0.0  2.2 454532 86944 ?        S    Jun30   2:47 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/gunicorn -w 8 -b 127.0.0.1:8000 --timeout 1200 archery.wsgi:application
root     27085  0.0  2.2 453924 86576 ?        S    Jun30   2:49 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/gunicorn -w 8 -b 127.0.0.1:8000 --timeout 1200 archery.wsgi:application
root     27089  0.0  2.2 450888 85488 ?        S    Jun30   2:40 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/gunicorn -w 8 -b 127.0.0.1:8000 --timeout 1200 archery.wsgi:application
root     27093  0.0  2.1 450560 83164 ?        S    Jun30   2:44 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/gunicorn -w 8 -b 127.0.0.1:8000 --timeout 1200 archery.wsgi:application
root     27098  0.0  2.1 450576 83252 ?        S    Jun30   2:44 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/gunicorn -w 8 -b 127.0.0.1:8000 --timeout 1200 archery.wsgi:application
root     27299  0.1  2.0 447264 80120 ?        S    Jun30  93:10 python manage.py qcluster
root     27300  0.0  1.8 439860 72240 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27301  0.0  1.8 439864 72252 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27302  0.0  1.8 439868 72260 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27303  0.0  1.8 439872 72288 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27304  0.0  1.8 439876 72284 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27305  0.0  1.8 439880 72300 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27306  0.0  1.8 439884 72296 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27307  0.0  1.8 439888 72284 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27308  0.0  1.8 439892 72272 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27309  0.0  1.8 439896 72276 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27310  0.0  1.8 439900 72264 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27311  0.0  1.8 439904 72260 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27312  0.0  1.8 439908 72424 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27313  0.0  1.8 439912 72656 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27314  0.0  1.8 439916 72632 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27315  0.0  1.8 439916 72288 ?        S    Jun30   0:00 python manage.py qcluster
root     27316  0.0  2.0 446796 77816 ?        S    Jun30   0:00 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/celery worker -A archery --loglevel=info
root     27317  0.0  1.8 439660 71948 ?        Sl   Jun30  11:37 python manage.py qcluster
root     27318  0.0  1.9 442620 74848 ?        S    Jun30   0:00 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/celery worker -A archery --loglevel=info
root     27950  0.0  0.4 213152 17840 ?        Ss   Jun30  40:05 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/supervisord -c supervisord.conf
root     28008  0.0  0.0   6828   196 pts/1    D+   18:16   0:00 grep --color=auto python







(venv4archery) [root@VM-0-110-centos dbops]# supervisorctl reload
Restarted supervisord
(venv4archery) [root@VM-0-110-centos dbops]# 
(venv4archery) [root@VM-0-110-centos dbops]# 
(venv4archery) [root@VM-0-110-centos dbops]# 
(venv4archery) [root@VM-0-110-centos dbops]# 
(venv4archery) [root@VM-0-110-centos dbops]# 
(venv4archery) [root@VM-0-110-centos dbops]# 
(venv4archery) [root@VM-0-110-centos dbops]# ps aux|grep python
root      9522  0.0  0.2 574204 11596 ?        Ssl  Feb15  20:49 /usr/bin/python2 -Es /usr/sbin/tuned -l -P
root     27075  0.1  2.0 444900 79516 ?        S    Jun30  66:20 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/celery worker -A archery --loglevel=info
root     27076  0.0  0.4 207696 18028 ?        S    Jun30   7:09 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/gunicorn -w 8 -b 127.0.0.1:8000 --timeout 1200 archery.wsgi:application
root     27077  0.0  1.8 439196 73500 ?        S    Jun30   0:01 python manage.py qcluster
root     27080  0.0  2.2 453740 86296 ?        S    Jun30   2:45 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/gunicorn -w 8 -b 127.0.0.1:8000 --timeout 1200 archery.wsgi:application
root     27081  0.0  2.1 449380 83988 ?        S    Jun30   2:49 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/gunicorn -w 8 -b 127.0.0.1:8000 --timeout 1200 archery.wsgi:application
root     27082  0.0  2.1 451692 84180 ?        S    Jun30   2:41 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/gunicorn -w 8 -b 127.0.0.1:8000 --timeout 1200 archery.wsgi:application
root     27084  0.0  2.2 454532 86944 ?        S    Jun30   2:47 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/gunicorn -w 8 -b 127.0.0.1:8000 --timeout 1200 archery.wsgi:application
root     27085  0.0  2.2 453924 86576 ?        S    Jun30   2:49 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/gunicorn -w 8 -b 127.0.0.1:8000 --timeout 1200 archery.wsgi:application
root     27089  0.0  2.2 450888 85488 ?        S    Jun30   2:40 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/gunicorn -w 8 -b 127.0.0.1:8000 --timeout 1200 archery.wsgi:application
root     27093  0.0  2.1 450560 83164 ?        S    Jun30   2:44 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/gunicorn -w 8 -b 127.0.0.1:8000 --timeout 1200 archery.wsgi:application
root     27098  0.0  2.1 450576 83252 ?        S    Jun30   2:44 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/gunicorn -w 8 -b 127.0.0.1:8000 --timeout 1200 archery.wsgi:application
root     27299  0.1  2.0 447264 80120 ?        S    Jun30  93:10 python manage.py qcluster
root     27300  0.0  1.8 439860 72240 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27301  0.0  1.8 439864 72252 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27302  0.0  1.8 439868 72260 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27303  0.0  1.8 439872 72288 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27304  0.0  1.8 439876 72284 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27305  0.0  1.8 439880 72300 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27306  0.0  1.8 439884 72296 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27307  0.0  1.8 439888 72284 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27308  0.0  1.8 439892 72272 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27309  0.0  1.8 439896 72276 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27310  0.0  1.8 439900 72264 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27311  0.0  1.8 439904 72260 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27312  0.0  1.8 439908 72424 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27313  0.0  1.8 439912 72656 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27314  0.0  1.8 439916 72632 ?        Sl   Jun30   0:00 python manage.py qcluster
root     27315  0.0  1.8 439916 72288 ?        S    Jun30   0:00 python manage.py qcluster
root     27316  0.0  2.0 446796 77816 ?        S    Jun30   0:00 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/celery worker -A archery --loglevel=info
root     27317  0.0  1.8 439660 71948 ?        Sl   Jun30  11:37 python manage.py qcluster
root     27318  0.0  1.9 442620 74848 ?        S    Jun30   0:00 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/celery worker -A archery --loglevel=info
root     27950  0.0  0.4 213152 17860 ?        Ss   Jun30  40:05 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/supervisord -c supervisord.conf
root     28596 62.6  2.1 444164 82672 ?        S    18:19   0:01 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/celery worker -A archery --loglevel=info
root     28597  9.6  0.4 207696 19340 ?        S    18:19   0:00 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/gunicorn -w 8 -b 127.0.0.1:8000 --timeout 1200 archery.wsgi:application
root     28598 57.3  2.0 439720 78288 ?        S    18:19   0:01 python manage.py qcluster
root     28793  6.0  1.8 440112 73012 ?        S    18:19   0:00 python manage.py qcluster
root     28794  0.0  1.8 440056 71652 ?        S    18:19   0:00 python manage.py qcluster
root     28795  0.0  1.8 440060 71652 ?        S    18:19   0:00 python manage.py qcluster
root     28796  0.0  1.8 440064 71652 ?        S    18:19   0:00 python manage.py qcluster
root     28797  0.0  1.8 440068 71660 ?        S    18:19   0:00 python manage.py qcluster
root     28798  0.0  1.8 440072 71660 ?        S    18:19   0:00 python manage.py qcluster
root     28799  0.0  1.8 440076 71664 ?        S    18:19   0:00 python manage.py qcluster
root     28800  0.0  1.8 440080 71668 ?        S    18:19   0:00 python manage.py qcluster
root     28801  0.0  1.8 440084 71680 ?        S    18:19   0:00 python manage.py qcluster
root     28802  0.0  1.8 440088 71676 ?        S    18:19   0:00 python manage.py qcluster
root     28803  0.0  1.8 440092 71692 ?        S    18:19   0:00 python manage.py qcluster
root     28804  0.0  1.8 440096 71692 ?        S    18:19   0:00 python manage.py qcluster
root     28805  0.0  1.8 440100 71680 ?        S    18:19   0:00 python manage.py qcluster
root     28806  0.0  1.8 440104 71684 ?        S    18:19   0:00 python manage.py qcluster
root     28807  0.0  1.8 440108 71684 ?        S    18:19   0:00 python manage.py qcluster
root     28808  0.0  1.8 440112 71692 ?        S    18:19   0:00 python manage.py qcluster
root     28809  0.0  1.8 440112 71716 ?        S    18:19   0:00 python manage.py qcluster
root     28810  0.0  1.8 440112 71976 ?        S    18:19   0:00 python manage.py qcluster
root     28811  0.0  1.9 443292 75452 ?        S    18:19   0:00 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/celery worker -A archery --loglevel=info
root     28812  0.0  1.9 443292 75484 ?        S    18:19   0:00 /data/dbops/venv4archery/bin/python /data/dbops/venv4archery/bin/celery worker -A archery --loglevel=info
root     28814  0.0  0.0 112720   968 pts/1    S+   18:19   0:00 grep --color=auto python





解决办法：
	先 supervisorctl stop all 
	再 kill 进程 
	最后 supervisorctl start all 
	
	supervisord -c supervisord.conf
	
	
	