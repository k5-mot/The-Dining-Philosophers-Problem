/* The Dining Philosophers Problem - version 3.0 */
#define N 5 /* Number of philosophers */
mtype = { UNLOCKED, LOCKED }; /* State of mutex */
mtype fork[N] = UNLOCKED; /* Mutex of forks */
chan request = [N] of { int }; /* Meal request queue */
chan ready[N] = [0] of { int }; /* Ready for meal */
chan done[N] = [0] of { int }; /* Done for meal */

/* Manager - Strict person */
proctype manager() {
	int p0, p1;
accept: 
	request?p0;
	ready[p0]!p0;
	done[p0]?p1;
	goto accept;
}

/* Philosopher - Lazy person */
proctype philosopher(int i) {
	int ack;
	int right = i;
	int left = (i + 1) % N;
again:
	request!i;  // Sends a request to coordinator.
	ready[i]?ack; // Wait until a request is granted.
	atomic { fork[right] == UNLOCKED -> fork[right] = LOCKED; };
	atomic { fork[left] == UNLOCKED -> fork[left] = LOCKED;	};
progress:	
	skip; /* EATING */
	atomic { fork[right] = UNLOCKED; }; 
	atomic { fork[left] = UNLOCKED; }; 
	done[i]!ack;
	goto again;
}

init {
	int cnt;
	run manager();
	for (cnt : 0 .. (N - 1)) { run philosopher(cnt); }
}
