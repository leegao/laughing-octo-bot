#include "flamewar.h"

/* FBI Bot. Core 3 watches the taunt array to try and catch spies, and
 * the remaining three cores cooperate to fill our half of memory.
 * Since the taunt array falls in cache line 1, the three other cores 
 * are careful to only ever use cache line 0.
 */
void __start(int core_id, int num_crashes, unsigned char link) {

  if (core_id == 3) {
    while (1) {
      int i;
      for (i = 0; i < TAUNT_SIZE; i++) {
        if (HOME_STATUS->taunt[i] >= 0) {
	      hammer(HOME_STATUS->taunt[i]);
        	//printf("Saw %d\n", HOME_STATUS->taunt[i]);
        }
      }
    }
  } else {
    unsigned char *ptr = HOME_DATA_SEGMENT; // start on even cache line

    // each core fills 1/3 of the cache line, spaced out evenly
    ptr += core_id * (CACHE_LINE / 3);

    while (1) {
      int i;
      for (i = 0; i < CACHE_LINE/3; i++) {
        ptr[i] = link;
      }
      ptr += 2*CACHE_LINE; // only fill even numbered line
    }
  }

}
