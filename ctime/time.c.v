module ctime

#flag linux -I/usr/include/
#include <time.h>

pub enum ClockID {
	realtime
	monotonic
	process_cputime_id
	thread_cputime_id
	monotonic_raw
	realtime_coarse
	boottime
	realtime_alarm
	boottime_alarm
	tai = 11
}

pub struct C.timespec {
	tv_sec  i64
	tv_nsec i64
}

fn C.clock_gettime(__clock_id ClockID, __tp &C.timespec) int
