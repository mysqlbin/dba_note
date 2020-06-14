


The data_locks table shows data locks held and requested. For information about which lock requests are blocked by which held locks, 

LOCK_TYPE

	The type of lock.
	The value is storage engine dependent. For InnoDB, permitted values are RECORD for a row-level lock, TABLE for a table-level lock.
	
	TABLE
	RECORD
	
	
LOCK_STATUS

	The status of the lock request.

	The value is storage engine dependent. For InnoDB, permitted values are GRANTED (lock is held) and WAITING (lock is being waited for).

	
LOCK_MODE

	How the lock is requested.
		如何申请锁

	The value is storage engine dependent. For InnoDB, permitted values are S[,GAP], X[,GAP], IS[,GAP], IX[,GAP], AUTO_INC, and UNKNOWN. 
		该值取决于存储引擎, 在InnoDB中, 允许的值有 S[,GAP], X[,GAP], IS[,GAP], IX[,GAP], AUTO_INC, and UNKNOWN.
		S
		X
		IS
		IX
		AUTO_INC
		gap lock 
		REC_NOT_GAP
		INSERT_INTENTION
		
	Lock modes other than AUTO_INC and UNKNOWN indicate gap locks, if present. For information about S, X, IS, IX, and gap locks, refer to Section 15.7.1, “InnoDB Locking”.
	


InnoDB Locking
	https://dev.mysql.com/doc/refman/8.0/en/innodb-locking.html
	This section describes lock types used by InnoDB.

	Shared and Exclusive Locks

	Intention Locks

	Record Locks

	Gap Locks

	Next-Key Locks

	Insert Intention Locks

	AUTO-INC Locks

	Predicate Locks for Spatial Indexes

	
相关参考
	https://dev.mysql.com/doc/refman/8.0/en/data-locks-table.html
	
	