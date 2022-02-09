/* The Dining Philosophers Problem - version 2.0 */
#define N 5 /* Number of philosophers */
mtype = { UNLOCKED, LOCKED }; /* State of mutex */
mtype fork[N] = UNLOCKED; /* Mutex of forks */

/* Philosopher - Lazy person */
proctype philosopher(int id) {
	int right = id;
	int left = (id + 1) % N;
again:
	atomic { fork[right] == UNLOCKED -> fork[right] = LOCKED; };
	atomic {
		if 
		::(fork[left] == UNLOCKED) -> fork[left] = LOCKED;	
		::else -> fork[right] = UNLOCKED; goto again;
		fi;
	};
progress:	
	skip; /* EATING */
	atomic { fork[right] = UNLOCKED; }; 
	atomic { fork[left] = UNLOCKED; }; 
	goto again;
}

init {
	int cnt;
	for (cnt : 0 .. (N - 1)) { run philosopher(cnt); }
}
