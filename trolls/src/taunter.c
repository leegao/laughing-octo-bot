#include "flamewar.h"

/* Taunter Bot.  Doesn't try to win, but instead dedicates all its cores
 * to annoying the opponent by (a) reading and writing randomly within
 * opponent's half in order to fill opponent's cache with garbage and
 * (b) overwriting opponents registers with random values. 
 *
 * This bot can actually lose to noop, since it might randomly write the
 * opponent's link more often than its own.
 */
void __start(int core_id, int num_crashes, unsigned char link) {
  int i;

  while (1) {
    int r = rand();
    if (r & 1) { // 50% probability: overwrite opponent stack frames
      int rand_core_id = (r>>1) % 4;
      struct mips_core_data *core = &OPPONENT_CORES->core_data[rand_core_id];
      troll();
      // Grab $sp off of opponent's core data.
      // From their point of view, it's in low memory (their own)
      // But from our point of view, it's in high memory, so or it with HIMEM
      unsigned int sp = core->R[29] | HIMEM;
      if (sp != 0) {
        for (i = 0; i < 20; i++) {
          *(int *)sp = (r>>1);
          // Next line!
          sp += 4;
          // Oops, that's the end!
          if (sp >= OPPONENT_DATA_END) {
            break;
          }
        }
      }
      retreat();
    } else { // 50% probability: bogus prefetch, then write random opponent memory location
      char *ptr = OPPONENT_DATA_SEGMENT + ((r>>1) % OPPONENT_DATA_SIZE);
      troll();
      prefetch(ptr);
      prefetch(ptr + CACHE_LINE);
      for (i = 0; i < CACHE_LINE; i++) {
        ptr[i] = ((r >> 1) & 0xff);
      }
      retreat();
    }
  }
}
