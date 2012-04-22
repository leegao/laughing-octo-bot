#include "flamewar.h"

void print_status(char *team, struct player_status *s)
{
  printf("%s status mapped at %p\n", team, s);
  int i;
  for (i = 0; i < PLAYER_CACHE_DEPTH; i++) {
    printf("  cache_tags[%d] = 0x%x\n", i, s->cache_tags[i]);
    printf("  cache_fetch_tags[%d] = 0x%x\n", i, s->cache_fetch_tags[i]);
  }
  printf("  countdown = %d\n", s->countdown);
  printf("  score = %d\n", s->score);
  printf("  link = %d\n", s->link);
  for (i = 0; i < TAUNT_SIZE; i += 4) {
    printf("  taunt = %d %d %d %d\n", s->taunt[i], s->taunt[i+1], s->taunt[i+2], s->taunt[i+3]);
  }
}

void print_core(struct mips_core_data *core)
{
  printf("  core is mapped at %p\n", core);
  int i;
  for (i = 0; i < 32; i++)
    printf("    R[%d] = 0x%x\n", i, core->R[i]);
  printf("  LO = 0x%x\n", core->LO);
  printf("  HI = 0x%x\n", core->HI);
  printf("  PC = 0x%x\n", core->PC);
  printf("  nPC = 0x%x\n", core->nPC);
  printf("  tsc = %lld\n", core->perf.tsc);
  printf("  psc = %lld\n", core->perf.psc);
  printf("  csc = %lld\n", core->perf.csc);
  printf("  cac = %lld\n", core->perf.cac);
  printf("  cmc = %lld\n", core->perf.cmc);
}

void print_cores(char *team, struct player_cores *cores)
{
  int i;
  for (i = 0; i < 4; i++) {
    printf("%s core[%d]:\n", team, i);
    print_core(&cores->core_data[i]);
  }
}

void __start1(int core_id, int num_crashes, unsigned char link) {
  printf("core id = %d, num_crashes = %d, link = %d\n", core_id, num_crashes, link);

  printf("PLAYER_MEM_ROSIZE = 0x%x\n", PLAYER_MEM_ROSIZE);
  printf("PLAYER_MEM_RWSIZE = 0x%x\n", PLAYER_MEM_RWSIZE);
  printf("PLAYER_MEM_SIZE = 0x%x\n", PLAYER_MEM_SIZE);

  printf("HOME_CODE_START = 0x%x\n", HOME_CODE_START);
  printf("HOME_CODE_SIZE = 0x%x\n", HOME_CODE_SIZE);
  printf("HOME_CODE_END = 0x%x\n", HOME_CODE_END);
  printf("HOME_CODE_SEGMENT = 0x%x\n", HOME_CODE_SEGMENT);
  printf("HOME_DATA_START = 0x%x\n", HOME_DATA_START);
  printf("HOME_DATA_SIZE = 0x%x\n", HOME_DATA_SIZE);
  printf("HOME_DATA_END = 0x%x\n", HOME_DATA_END);
  printf("HOME_DATA_SEGMENT = 0x%x\n", HOME_DATA_SEGMENT);

  printf("HIMEM = 0x%x\n", HIMEM);

  printf("OPPONENT_CODE_START = 0x%x\n", OPPONENT_CODE_START);
  printf("OPPONENT_CODE_SIZE = 0x%x\n", OPPONENT_CODE_SIZE);
  printf("OPPONENT_CODE_END = 0x%x\n", OPPONENT_CODE_END);
  printf("OPPONENT_CODE_SEGMENT = 0x%x\n", OPPONENT_CODE_SEGMENT);
  printf("OPPONENT_DATA_START = 0x%x\n", OPPONENT_DATA_START);
  printf("OPPONENT_DATA_SIZE = 0x%x\n", OPPONENT_DATA_SIZE);
  printf("OPPONENT_DATA_END = 0x%x\n", OPPONENT_DATA_END);
  printf("OPPONENT_DATA_SEGMENT = 0x%x\n", OPPONENT_DATA_SEGMENT);

  printf("CACHE_LINE = 0x%x\n", CACHE_LINE);
  printf("PLAYER_CACHE_DEPTH = 0x%x\n", PLAYER_CACHE_DEPTH);
  printf("TOTAL_CACHE_DEPTH = 0x%x\n", TOTAL_CACHE_DEPTH);
  printf("CACHE_MISS_PENALTY = 0x%x\n", CACHE_MISS_PENALTY);

  printf("player_status size = %d\n", sizeof(struct player_status));
  troll();
  print_status("opponent", OPPONENT_STATUS);
  retreat();
  print_status("home", HOME_STATUS);

  printf("mips_core_data size = %d\n", sizeof(struct mips_core_data));
  troll();
  print_cores("opponent", OPPONENT_CORES);
  retreat();
  print_cores("home", HOME_CORES);
}

void __start(int core_id, int num_crashes, unsigned char link) {
  if (core_id == 0)
    __start1(core_id, num_crashes, link);
  while (1);
}
