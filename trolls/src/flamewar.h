#ifndef _FLAMEWAR_H_
#define _FLAMEWAR_H_


/* You must provide a function with this signature.  It will be invoked by the
 * simulator four times in parallel, once by each processor core on the the
 * player's side. 
 *   core_id: indicates which core is executing the code (0 to 3).
 *   num_crashes: 0 when the program is first invoked, incremented on each crash
 *   link: the byte the player is trying to fill the memory with.
 */
void __start(int core_id, int num_crashes, unsigned char link);


/* Memory Layout 
 * =============================================================================
 *
 * The simulator has 64MB of physical memory, half dedicated to each player.
 * Each player sees its half of memory as addresses 0x00000000 to 0x01ffffff,
 * and sees its opponent's half of memory as addresses 0x80000000 to 0x81ffffff.
 *
 * Writes are not allowed to some addresses, to avoid corrupting the program code.
 * Certain addresses have special meanings: reads from these addresses are
 * redirected to various bits of simulator state and other status variables.
 * The datastructures below define what this simulator state and status
 * variables look like.
 *
 * Each core sees the following layout:
 * 0x00000000 - 0x000fffff read-only segment for code and status (1 MB)
 *     0x00000000   Start of this player's code
 *     0x000feb00   Start of mips_core_data for this player's core 0
 *     0x000ff000   Start of mips_core_data for this player's core 1
 *     0x000ff500   Start of mips_core_data for this player's core 2
 *     0x000ffa00   Start of mips_core_data for this player's core 3
 *     0x000fff00   Start of player_status for this player
 * 0x00100000 - 0x01ffffff read-write segment for this player's stacks and data (31 MB)
 * 0x02000000 - 0x7fffffff inaccessible
 * 0x80000000 - 0x000fffff read-only segment for code and status (1 MB)
 *     0x80000000   Start of opponent's code
 *     0x800feb00   Start of mips_core_data for opponent's core 0
 *     0x800ff000   Start of mips_core_data for opponent's core 1
 *     0x800ff500   Start of mips_core_data for opponent's core 2
 *     0x800ffa00   Start of mips_core_data for opponent's core 3
 *     0x800fff00   Start of player_status for opponent
 * 0x80100000 - 0x81ffffff read-write segment for opponent's stacks and data (31 MB)
 * 0x82000000 - 0xffffffff inaccessible
 *
 * Each core picks an initial stack address near the top of its player's data
 * segment, leaving 1MB of space between each of the stacks. You may change your
 * own stack location anywhere you see fit, or ignore the stack completely.
 *
 * The upper half of memory (above 0x80000000) is accessible only when trolling.
 *
 * Note: Both player's see their own code and data in the bottom half of memory
 * and their opponent's code and data in the upper half of memory. For example,
 * if player 0 stores X at 0x00100016, this will be near the start of player 0's
 * data segment.  But if player 1 is trolling and tries to dereference 0x00100016,
 * player 1 will _not_ read X, and intead will read from near the start of
 * player 1's data segment.  Player 1 should xor the opponent's pointer with
 * 0x80000000 to get a pointer it can use to access X.
 */

/* Amount of read-only memory for each player */
#define PLAYER_MEM_ROSIZE (1*1024*1024)
/* Amount of read-write memory for each player */
#define PLAYER_MEM_RWSIZE (31*1024*1024)
/* Amount of stack memory for each player */
#define STACK_SIZE (1*1024*1024)
/* Amount of total memory for each player */
#define PLAYER_MEM_SIZE   (PLAYER_MEM_ROSIZE + PLAYER_MEM_RWSIZE)

#define HOME_CODE_START (0x00000000)
#define HOME_CODE_SIZE  (PLAYER_MEM_ROSIZE)
#define HOME_CODE_END   (PLAYER_MEM_ROSIZE-1)
#define HOME_CODE_SEGMENT ((void *)HOME_CODE_START)
#define HOME_DATA_START (PLAYER_MEM_ROSIZE)
#define HOME_DATA_SIZE  (PLAYER_MEM_SIZE - PLAYER_MEM_ROSIZE)
#define HOME_DATA_END   (PLAYER_MEM_SIZE-1)
#define HOME_DATA_SEGMENT ((void *)HOME_DATA_START)

#define HIMEM 0x80000000

#define OPPONENT_CODE_START (HIMEM)
#define OPPONENT_CODE_SIZE	    (PLAYER_MEM_ROSIZE)
#define OPPONENT_CODE_END   (HIMEM + PLAYER_MEM_ROSIZE-1)
#define OPPONENT_CODE_SEGMENT ((void *)OPPONENT_CODE_START)
#define OPPONENT_DATA_START (HIMEM + PLAYER_MEM_ROSIZE)
#define OPPONENT_DATA_SIZE  (PLAYER_MEM_SIZE - PLAYER_MEM_ROSIZE)
#define OPPONENT_DATA_END   (HIMEM + PLAYER_MEM_SIZE-1)
#define OPPONENT_DATA_SEGMENT ((void *)OPPONENT_DATA_START)

/* How many DDoS and RickRoll each team has */
#define DDOS_PER_TEAM 15
#define RICKROLLS_PER_TEAM 30

/* The bytes representing DDOS, RickRoll, and IP Change */
#define DDOS 0xF0
#define RICKROLL  0xF1
#define IP_CHANGE 0xF2

/* Number of cycles a core will stall in the following situations */
#define STALL_TO_SETUP_DDOS 100
#define STALL_ON_IP_CHANGE 100
#define STALL_WHEN_DDOSED 1000000
#define STALL_WHEN_RICKROLLED 300
#define STALL_ON_BAD_HAMMER 100000

/* After a RickRoll is posted, opponents activate it if they post within
 * the next RICKROLL_DURATION cycles
 */
#define RICKROLL_DURATION 100


/* Cache Organization
 * =============================================================================
 *
 * Instruction fetch is assumed to use an infinitely large cache with zero
 * latency. But all load and stores to memory use a data cache. Cache hits are
 * serviced in a single cycle, with no processor stalls. Cache misses cause
 * roughly 100 cycles of processor stalling.
 *
 * The data cache is direct-mapped and physically tagged, with 4 cache lines,
 * and a 256 byte block size, for a total of 1024 bytes of cache. However, the
 * data cache is _partitioned_, with the first 2 lines used to cache the lower
 * half of physical memory, and the last 2 lines used to cache the upper half of
 * physical memory.
 *
 * One way to visualize this partitioned cache design is as two separate data
 * caches for the two halfs of physical memory. Another way to view it is as a
 * direct-mappped cache that uses bits 31 and 8 of the address to form the cache
 * line index, rather than the customary 9 and 8.
 *
 * Four bytes of cache meta-data is maintained for each cache line, including a
 * valid bit (bit 0), and a physical tag (bits 30 to 9). The unused bits are
 * reserved for internal use, so you shouldn't rely on whatever is stored there.
 * Bits 31 and 8 of addresses are used for indexing (labeled 'i'), and we
 * reserve the same bits in the cache meta-data (labeled 'r').
 *
 * Address:
 *   +---+-------------------------------------------+---+-----------------+
 *   | i |                   tag                     | i |    offset       |
 *   +---+-------------------------------------------+---+-----------------+
 *    31   30 29 28                ...        11 10 9  8  7 6 5 4 3 2 1  0     
 *
 * Cache meta-data:
 *   +---+-------------------------------------------+-----------------+---+
 *   | r |                  tag                      |    reserved     | V |
 *   +---+-------------------------------------------+-----------------+---+
 *    31   30 29 28                ...        11 10 9  8  7 6 5 4 3 2 1  0     
 *
 * To translate from a cache tag to a virtual address, you must overwrite bits 0
 * through 8 and bit 31.  Each player should clear bit 31 to zero if the tag
 * came from their own cache, or set bit 31 to one if the tag came from their
 * opponent's cache. Bits 8 should be cleared to zero if the tag came from line
 * 0, or set to one if the tag came from line 1. And bits 0 to 7 should be set
 * to the desired offset within the cache line.
 *
 * tag = cache_tag & ~HIMEM & ~(CACHE_LINE * PLAYER_CACHE_DEPTH - 1);
 * vaddr = (my_half ? 0 : HIMEMEM) | tag | desired_offset;
 *
 * The current cache tags and valid bits for each cache line are accessible in
 * the cache_tags[] arrays. If data is currently being fetched from memory to
 * fill (or replace) a cache line, the new tag and valid bit will be visible in
 * the cache_fetch_tags[] arrays. This information is also avialable via the
 * rdctag() and rdftag() system calls.
 */

/* Number of bytes per cache line */
#define CACHE_LINE 256
/* Number of caches lines per player */
#define PLAYER_CACHE_DEPTH 2  
/* Number of caches lines total */
#define TOTAL_CACHE_DEPTH 4  
/* Number of cycles penalty for missing the cache */
#define CACHE_MISS_PENALTY 100


/* Each player's status is visible in read-only memory, just at the end of their own
 * read-only code segment. You can read your own status at any time, but can only read
 * your opponent's status when you are trolling.  This datastructure is exactly 256 bytes
 * long. Some of this information is available elsewhere as well.
 */
struct player_status {
  /* Current status of cache lines for this player's half of memory. */
  unsigned int cache_tags[PLAYER_CACHE_DEPTH];
  /* Which block, if any, is currently being fetched for this player's half of memory. */
  unsigned int cache_fetch_tags[PLAYER_CACHE_DEPTH];
  /* Number of cycles remaining before the game ends. */
  unsigned int countdown;
  /* Current score for this player. */
  unsigned int score;
  /* link: The single byte link this team is trying to fill memory with.
   * num_ddos: Number of DDoSes this team has used already.
   * num_rickroll: Number of RickRolls this team has used already.
   * The padding is unused, but ensures the datastructure will exactly
   * fill 256 bytes of memory.
   */
  unsigned char link, num_ddos, num_rickroll, pad0;
  /* Each element of taunt[] will contain a core id between 0 and 3, or -1 to mean "empty".
   * Each player's taunt[] array contains evidence that their opponent is trolling them.
   * When player 0's core 2  spies on player 1, player 1's taunt[] array will somewhere
   * contain the number 2.*/
#define TAUNT_SIZE 228
  signed char taunt[TAUNT_SIZE];
} __attribute__ ((packed));


/* Each player's core's CPU registers are accessible in read-only memory, just
 * before the player_status structure in that player's read-only code segment.
 */

struct mips_coprocessor_data {
  union {
    /* Coprocessor General Purpose Registers for COP0, COP2, and COP3 */
    unsigned int CPR[32];
    /* Floating-point Registers for COP1 */
    union {
      float FGR[16]; /* seen as 16 single-precision numbers */
      double FPR[8]; /* seen as 8 double-precision numbers */
      int FWR[16];   /* seen as 16 integers */
    };
  };
  /* Coprocessor Control Registers */
  unsigned int CCR[32];
  /* Coprocessor Condition Code */
  unsigned int CpCond;
  /* padding to make the entire struct 8-byte aligned */
  unsigned int padding; 
} __attribute__ ((packed));

struct mips_perf {
  unsigned long long tsc; /* time stamp counter: number of cycles elapsed since boot */
  unsigned long long psc; /* penalty stall counter: number of cycles stalled due to penalties */
  unsigned long long csc; /* cache stall counter: number of cycles stalled waiting for cache */
  unsigned long long cac; /* catch access counter: number of memory access attempts */
  unsigned long long cmc; /* cache miss counter: number of cache misses */
} __attribute__ ((packed));

struct mips_core_data { /* This datastructure is exactly 1280 bytes long. */
  /* General Purpose Registers */
  unsigned int R[32];
  /* Registers used by integer multiplication and division */
  unsigned int LO, HI;
  /* Current and next program counter */
  unsigned int PC, nPC;
  /* Coprocessor state */
  struct mips_coprocessor_data COP[4];
  /* Peformance counters */
  struct mips_perf perf;
  /* Padding to make the data structre cache-aligned */
  unsigned char padding[40];
} __attribute__ ((packed));

struct player_cores {
  struct mips_core_data core_data[4]; /* mips_core_data for each of the 4 cores for this player */
} __attribute__ ((packed));

/* Round x up to the nearest multiple of s, where s is a power of 2 */
#define ALIGN(x, s) (((x) + ((s)-1)) & ~((s)-1))

/* Pointer to this player's status datastructure */
#define HOME_STATUS ((struct player_status *)(PLAYER_MEM_ROSIZE - ALIGN(sizeof(struct player_status), CACHE_LINE)))
/* Pointer to this player's cores datastructure */
#define HOME_CORES ((struct player_cores *)(PLAYER_MEM_ROSIZE - ALIGN(sizeof(struct player_status), CACHE_LINE) - ALIGN(sizeof(struct player_cores), CACHE_LINE)))
/* Pointer to opponent's status datastructure */
#define OPPONENT_STATUS ((struct player_status *)(HIMEM + PLAYER_MEM_ROSIZE - ALIGN(sizeof(struct player_status), CACHE_LINE)))
/* Pointer to opponent's cores datastructure */
#define OPPONENT_CORES ((struct player_cores *)(HIMEM + PLAYER_MEM_ROSIZE - ALIGN(sizeof(struct player_status), CACHE_LINE) - ALIGN(sizeof(struct player_cores), CACHE_LINE)))




// Null pointer definition; normally in system headers, but we don't use those.
#define NULL ((void *)0)

// print a null-terminated string (puts and prints are identical)
__attribute__ ((unused)) static int puts(char *c);
__attribute__ ((unused)) static int prints(char *c);

// print formatted data; accepts only a few of the standard formatting specifiers,
// without any of the fancy stuff (e.g. %08x is not accepted, only %x):
// %d, %x, %u         for int in decimal, hex, or unsigned
// %lld, %llx, %llu   for long long int in decimal, hex, or unsigned
// %s                 for strings
// %p                 for pointers
// %f, %g             for double in scientific or decimal notation
// %%		      for a percent sign
__attribute__ ((unused, noinline)) static int printf(char *fmt, ...);

// print a single character
__attribute__ ((unused)) static int putc(char c);

// return a pseudo-random number
__attribute__ ((unused)) static unsigned int rand(void);

// go into troll mode so that you can read or write high memory
__attribute__ ((unused)) static void troll(void);

// accuse opponent core of trolling; returns 1 for success, 0 for false accusation
// if the opponent's core is trolling, it will be given the BANHAMMER (halted forever);
// otherwise, this core will be penalized by stalling some number of cycles
#define FALSE_ACCUSATION_PENALTY 100000
__attribute__ ((unused)) static int hammer(int opponent_core_id);

// retreat from troll mode
__attribute__ ((unused)) static void retreat(void);

// start prefetching data block containing ptr into cache; returns immediately
// This only works if the bot currently has access to the data block.
// For each cache line, there can be at most one outstanding fetch in progress.
// Prefetch requests are ignored if a fetch is already in progress for a line,
// and actual data fetch requests (e.g. from load/store instructions, rather
// than prefetch requests) supersede prefetch requests.
__attribute__ ((unused)) static void prefetch(void *ptr);

// remove any data block containing ptr from cache.
// This only works if the bot currently has access to the data block.
__attribute__ ((unused)) static void invalidate(void *ptr);

// read one of the current core's performance counters (also in datastructures above)
#define PERF_TSC 0
#define PERF_PSC 1
#define PERF_CSC 2
#define PERF_CAC 3
#define PERF_CMC 4
__attribute__ ((unused)) static unsigned long long rdperf(int counter_id);

// read the cache tag for the line where ptr would go
__attribute__ ((unused)) static unsigned int rdctag(void *ptr);

// read the cache tag currently being fetched into the line where ptr would go
__attribute__ ((unused)) static unsigned int rdftag(void *ptr);

// stops the program using a BREAK instruction;
// useful when debugging, otherwise fatal
__attribute__ ((unused)) static void breakpoint(void);


/* the rest of this file contains the implementations of the above functions */

__attribute__ ((unused, noinline)) static int printf(char *fmt, ...) {
  /* invoke system call number 22 */
  register int ret asm("v0");
  register void *arglist asm("a0") = &fmt;
  asm __volatile__ (
      "addiu $2, $0, 22\n\t"
      "syscall"
      : "=r" (ret)
      : "r" (arglist)
      );
  return ret;
}

__attribute__ ((unused)) static int puts(char *str) {
  return prints(str);
}

__attribute__ ((unused)) static int prints(char *str) {
  /* invoke system call number 2 */
  register int ret asm("v0");
  register char *arg asm("a0") = str;
  asm __volatile__ (
      "addiu $2, $0, 2\n\t"
      "syscall"
      : "=r" (ret)
      : "r" (arg)
     );
  return ret;
}

__attribute__ ((unused)) static int putc(char c) {
  /* invoke system call number 3 */
  register int ret asm("v0");
  register char arg asm("a0") = c;
  asm __volatile__ (
      "addiu $2, $0, 3\n\t"
      "syscall"
      : "=r" (ret)
      : "r" (arg)
     );
  return ret;
}

__attribute__ ((unused)) static unsigned int rand(void) {
  /* invoke system call number 6 */
  register unsigned ret asm("v0");
  asm __volatile__ (
      ".set push\n\t"
      ".set noreorder\n\t"
      "addiu $2, $0, 6\n\t"
      "syscall\n\t"
      ".set pop\n\t"
      : "=r" (ret)
      :
      );
  return ret;
}

__attribute__ ((unused)) static void troll(void) {
  /* invoke system call number 11 */
  asm __volatile__ (
      ".set push\n\t"
      ".set noreorder\n\t"
      "addiu $2, $0, 11\n\t"
      "syscall\n\t"
      ".set pop\n\t"
      :
      :
      : "v0"
      );
}

__attribute__ ((unused)) static int hammer(int id) {
  /* invoke system call number 12 */
  register int ret asm("v0");
  register int arg asm("a0") = id;
  asm __volatile__ (
      "addiu $2, $0, 12\n\t"
      "syscall"
      : "=r" (ret)
      : "r" (arg)
      );
  return ret;
}

__attribute__ ((unused)) static void retreat(void) {
  /* invoke system call number 13 */
  asm __volatile__ (
      "addiu $2, $0, 13\n\t"
      "syscall"
      :
      :
      : "v0"
      );
}

__attribute__ ((unused)) static void prefetch(void *ptr) {
  /* invoke system call number 14 */
  register void *arg asm("a0") = ptr;
  asm __volatile__ (
      "addiu $2, $0, 14\n\t"
      "syscall"
      :
      : "r" (arg)
      : "v0"
      );
}

__attribute__ ((unused)) static void invalidate(void *ptr) {
  /* invoke system call number 15 */
  register void *arg asm("a0") = ptr;
  asm __volatile__ (
      "addiu $2, $0, 15\n\t"
      "syscall"
      :
      : "r" (arg)
      : "v0"
      );
}

__attribute__ ((unused)) static unsigned long long rdperf(int counter_id) {
  /* invoke system call number 16 */
  register int arg asm("a0") = counter_id;
  register long long ret asm("v0");
  asm __volatile__ (
      "addiu $2, $0, 16\n\t"
      "syscall"
      : "=r" (ret)
      : "r" (arg)
      );
  return ret;
}

__attribute__ ((unused)) static unsigned int rdctag(void *ptr) {
  /* invoke system call number 17 */
  register unsigned int ret asm("v0");
  register void *arg asm("a0") = ptr;
  asm __volatile__ (
      "addiu $2, $0, 17\n\t"
      "syscall"
      : "=r" (ret)
      : "r" (arg)
      );
  return ret;
}

__attribute__ ((unused)) static unsigned int rdftag(void *ptr) {
  /* invoke system call number 18 */
  register unsigned int ret asm("v0");
  register void *arg asm("a0") = ptr;
  asm __volatile__ (
      "addiu $2, $0, 18\n\t"
      "syscall"
      : "=r" (ret)
      : "r" (arg)
      );
  return ret;
}

__attribute__ ((unused)) static void breakpoint(void) {
  /* insert a BREAK instruction */
  asm __volatile__ ("break");
}

#endif // _FLAMEWAR_H_
