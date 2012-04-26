/*
 * self.c
 *
 *  Created on: Apr 21, 2012
 *      Author: Lee
 */

#include "flamewar.h"

//80000000                                   0x7fffffff
#define cache_align(x) (((unsigned long)x) & 0x7fffff00)

/* Honest Bot. Fills its own half of memory using cores 0 and 1, 2, 3
 * Uses a simple loop with a random start address.*/
void __start(int core_id, int num_crashes, unsigned char link) {
	// core0 = line 0
	// core1 = line 1
	// at a rate of (227/228)^175 \approx 0.5, we can 'safely' be in troll mode
	// approximately 175 cycles if we detect the taunt array on one of the lines
	register char *ptr = (char *)(HOME_DATA_SEGMENT) + (core_id&1)*CACHE_LINE;
	prefetch(ptr);
	register unsigned int h = 0;
	register int i = 0;
	register int k = ptr[0] == link;
	if (k){
		if (core_id < 2){
			while(1){
				ptr[110+i] = link;
				ptr[130+i] = link;
				ptr[150+i++] = link;
				if (i == 16){
					ptr += 2*CACHE_LINE;
					i = 1;
					ptr[0] = link;
					prefetch(ptr+2*CACHE_LINE+1);
				}
			}
		} else {
			ptr = (char *)(HOME_DATA_SEGMENT) + (core_id&1)*CACHE_LINE;
			while(1){
				ptr[170+i] = link;
				ptr[185+i] = link;
				ptr[196+i] = link;
				ptr[210+i++] = link;
				if (i==12){
					ptr = ptr + 2*CACHE_LINE;
					i = 0;
				}
			}
		}
	} else {
		if (!core_id){
			while(1){
				ptr[i] = link;
				ptr[20+i] = link;
				ptr[40+i++] = link;
				if (i == 16){
					ptr += 2*CACHE_LINE;
					i = 1;
					ptr[0] = link;
					prefetch(ptr+2*CACHE_LINE+1);
				}
			}
		} else if (core_id == 1){

			while(1){
				ptr[i] = link;
				ptr[20+i] = link;
				ptr[40+i++] = link;
				if (i == 16){
					register char x = ptr[120];
					if (x == link){
						for (k = TAUNT_SIZE/2; k < TAUNT_SIZE; k++) {
							if (HOME_STATUS->taunt[k] >= 0) {
								hammer(HOME_STATUS->taunt[k]);
							}
						}
						prefetch(ptr+2*CACHE_LINE+1);
					}
					ptr += 2*CACHE_LINE;
					i = 0;
					ptr[0] = link;
					prefetch(ptr+2*CACHE_LINE+1);
				}
			}
		} else if (core_id == 2){
			while(1){
				ptr[60+i] = link;
				ptr[71+i] = link;
				ptr[82+i] = link;
				ptr[100+i++] = link;
				if (i==11){
					i = 0;
					register unsigned int tag = cache_align(rdftag(ptr));
					ptr = tag > HOME_DATA_START && tag < HOME_DATA_END ? tag: ptr + 2*CACHE_LINE;
				}
			}
		} else {
			k = 0;
			while(1){
				ptr[60+i] = link;
				ptr[71+i] = link;
				ptr[82+i] = link;
				ptr[100+i++] = link;
				if (i==10){
					i = 0;
					if (k++ == 25){
						ptr[120] = link;
						for (k = 0; k < TAUNT_SIZE/2; k++) {
							if (HOME_STATUS->taunt[k] >= 0) {
								hammer(HOME_STATUS->taunt[k]);
							}
						}
						// do a simple attack on fbi
						h++;
						if (h % 3 == 0){
							troll();
							retreat();
						} else if (h == 74) {
							// actually do an attack
							// check if rdctag(ptr|HIOLO) is in the taunt array, if not, fuck their odd cache line + 6*CACHELINE up
							// otherwise just drop a simple rickroll
							troll();
							h = rdctag(OPPONENT_DATA_START|CACHE_LINE);
							retreat();
							h = HIMEM|h;
							if (h > OPPONENT_DATA_START){
								troll();
								register unsigned char x = ((char*)h+6*CACHE_LINE)[100];
								if (x!=DDOS){
									((char*)h+6*CACHE_LINE)[100] = DDOS;
								} else {
									((char*)h+6*CACHE_LINE)[120] = DDOS;
								}
								retreat();
							} else if (((int)h - (int)OPPONENT_STATUS > 0) && ((int)h - (int)OPPONENT_STATUS < 255)) {
								// he's checking his shit, rickroll on even lines
								register unsigned char x = rand()&0x7;
								if (x == 1){
									troll();
									invalidate(h);
									retreat();
								} else if (x==0) {
									troll();
									h = rdctag(OPPONENT_DATA_START);
									retreat();
									h = HIMEM|h;
									troll();
									((char*)h)[100]=RICKROLL;
									retreat();
								}
							}
							h = 0;
						}
						k = 0;
					}
					register unsigned int tag = cache_align(rdftag(ptr));
					ptr = tag > HOME_DATA_START && tag < HOME_DATA_END ? tag: ptr + 2*CACHE_LINE;
				}
			}
		}
	}

}
