#include "flamewar.h"

/* Greedy Bot. Fills its own half of memory using cores 0 and 1,
 * and fills the opponent's half using cores 2 and 3.
 * Uses a simple loop with a random start address.
 */
void __start(int core_id, int num_crashes, unsigned char link) {

  char *ptr = (char *)HOME_DATA_SEGMENT + (rand() % HOME_DATA_SIZE);

  if (core_id >= 2) {
    ptr += HIMEM;  // move pointer to opponent's half of memory
    troll();
  }

  int i = 0;
  while (1) {
    ptr[i++] = link;
  }
}
