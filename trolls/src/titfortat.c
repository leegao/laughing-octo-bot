#include "flamewar.h"

/* TitForTat Bot. Core 3 watches the taunt array to try and catch spies, and
 * the remaining three cores cooperate to fill our half of memory. Each time
 * a troll is noticed, we send over one of the cores to start filling opponent's
 * half of memory, while keeping at least one behind to fill our own half.
 */

void attack(int core_id, unsigned char link) {
  printf("going on the attack!\n");
  troll();
  // look at where opponent was writing, and overwrite that
  int idx = core_id; // core 0 takes cache idx 0, core 1 takes other cache idx
  int ptag = rdctag((void *)(HIMEM + CACHE_LINE * idx)); // see what is in that cache line
  ptag = ptag / (PLAYER_CACHE_DEPTH*CACHE_LINE); // just take the TAG part of it, ignore the valid bit or other low bits
  int paddr = ptag * CACHE_LINE * PLAYER_CACHE_DEPTH + idx * CACHE_LINE;
  int vaddr = paddr | HIMEM; // make sure this is pointing at high memory
  if (vaddr < OPPONENT_DATA_START) {
    vaddr = OPPONENT_DATA_START + CACHE_LINE * idx; // was looking at code, default to data
  }

  char *ptr = (char *)vaddr;

  int i = 0;
  while(1) {
    ptr[i++] = link;
  }
}

int num_attackers = 0;

void __start(int core_id, int num_crashes, unsigned char link) {

  if (core_id == 3) {
    int num_spies_seen = 0;
    while (1) {
      int i;
      for (i = 0; i < TAUNT_SIZE; i++) {
        if (HOME_STATUS->taunt[i] >= 0) {
          hammer(HOME_STATUS->taunt[i]);
          num_spies_seen++;
          if (num_spies_seen == 1) num_attackers = 1;
          else num_attackers = 2;
        }
      }
    }
  } else {
    // start on even numbered cache lines
    // (it just happens that num_attackers variable is in an odd numbered cache
    // line, so we won't overwrite our own global variable).
    unsigned char *ptr = HOME_DATA_SEGMENT; // start on even numbered cache line

    while (1) {

      int num_left = 3 - num_attackers;
      if (core_id >= num_left) attack(core_id, link);

      // each core left on our side fills 1/n of the cache line, spaced out evenly
      int share = CACHE_LINE/num_left;
      unsigned char *my_ptr = ptr + (core_id * share);
      int i;
      for (i = 0; i < share; i++) {
        my_ptr[i] = link;
      }
      ptr += 2*CACHE_LINE; // only fill even numbered lines
    }
  }

}
