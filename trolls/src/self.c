/*
 * self.c
 *
 *  Created on: Apr 21, 2012
 *      Author: Lee
 */

#include "flamewar.h"

#define cache_align(x) (((int)x) & 0xffffff00)

/* Honest Bot. Fills its own half of memory using cores 0 and 1, 2, 3
 * Uses a simple loop with a random start address.
 */
void __start(int core_id, int num_crashes, unsigned char link) {
	// core0 = line 0
	// core1 = line 1
	// at a rate of (247/248)^175 \approx 0.5, we can 'safely' be in troll mode
	// approximately 175 cycles if we detect the taunt array on one of the lines
	register char *ptr = (char *)(HOME_DATA_SEGMENT) + (core_id&1)*CACHE_LINE;
	prefetch(ptr);
	register int HI = rdftag(ptr)>=HIMEM ? HIMEM : 0;
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
					}
					ptr += 2*CACHE_LINE;
					i = 0;
					ptr[0] = link;
					prefetch(ptr+2*CACHE_LINE+1);
				}
			}
		} else if (core_id == 2){
			//register unsigned long long stalls = 0;
			//register char* where = ptr;
			while(1){
				ptr[60+i] = link;
				ptr[71+i] = link;
				ptr[82+i] = link;
				ptr[100+i++] = link;
				if (i==11){
					i = 0;
					register char* tag = (char*)rdftag(ptr);
					ptr = tag ? cache_align(tag)-HI : ptr + 2*CACHE_LINE;
				}
			}
		} else {
			//ptr = (char *)(HOME_DATA_SEGMENT) + (core_id&1)*CACHE_LINE;
			//printf("%x\n",VADDR|(int)ptr);
			k = 0;
			//register unsigned long long stalls = 0;
			//register char* where = (char*)(VADDR |(int)ptr);
			while(1){
				ptr[60+i] = link;
				ptr[71+i] = link;
				ptr[82+i] = link;
				ptr[100+i++] = link;
				if (i==10){
					i = 0;
					if (k++ == 20){
						ptr[120] = link;
						for (k = 0; k < TAUNT_SIZE/2; k++) {
							if (HOME_STATUS->taunt[k] >= 0) {
								hammer(HOME_STATUS->taunt[k]);
							}
						}
						k = 0;
					}
					register char* tag = (char*)rdftag(ptr);
					//printf("%x\n",rdftag(ptr));
					ptr = tag ? cache_align(tag)-HI : ptr + 2*CACHE_LINE;
				}
			}
		}
	}

}
