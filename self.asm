
bin/self:     file format elf32-tradlittlemips
bin/self
architecture: mips:3000, flags 0x00000112:
EXEC_P, HAS_SYMS, D_PAGED
start address 0x000004b0

Program Header:
0x70000000 off    0x00000494 vaddr 0x00000494 paddr 0x00000494 align 2**2
         filesz 0x00000018 memsz 0x00000018 flags r--
    LOAD off    0x00000000 vaddr 0x00000000 paddr 0x00000000 align 2**16
         filesz 0x000009e0 memsz 0x000009e0 flags r-x
private flags = 1001: [abi=O32] [mips1] [not 32bitmode]

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .reginfo      00000018  00000494  00000494  00000494  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA, LINK_ONCE_DISCARD
  1 .text         00000530  000004b0  000004b0  000004b0  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  2 .comment      00000012  00000000  00000000  000009e0  2**0
                  CONTENTS, READONLY
  3 .debug_aranges 00000020  00000000  00000000  000009f2  2**0
                  CONTENTS, READONLY, DEBUGGING
  4 .debug_pubnames 0000001e  00000000  00000000  00000a12  2**0
                  CONTENTS, READONLY, DEBUGGING
  5 .debug_info   00000582  00000000  00000000  00000a30  2**0
                  CONTENTS, READONLY, DEBUGGING
  6 .debug_abbrev 00000161  00000000  00000000  00000fb2  2**0
                  CONTENTS, READONLY, DEBUGGING
  7 .debug_line   000001cf  00000000  00000000  00001113  2**0
                  CONTENTS, READONLY, DEBUGGING
  8 .debug_frame  00000020  00000000  00000000  000012e4  2**2
                  CONTENTS, READONLY, DEBUGGING
  9 .debug_str    000000c0  00000000  00000000  00001304  2**0
                  CONTENTS, READONLY, DEBUGGING
 10 .debug_loc    000003f0  00000000  00000000  000013c4  2**0
                  CONTENTS, READONLY, DEBUGGING
 11 .mdebug.abi32 00000000  000003f0  000003f0  000017b4  2**0
                  CONTENTS, READONLY
 12 .pdr          00000020  00000000  00000000  000017b4  2**2
                  CONTENTS, READONLY
 13 .debug_ranges 00000078  00000000  00000000  000017d4  2**0
                  CONTENTS, READONLY, DEBUGGING
SYMBOL TABLE:
00000494 l    d  .reginfo	00000000 .reginfo
000004b0 l    d  .text	00000000 .text
00000000 l    d  .comment	00000000 .comment
00000000 l    d  .debug_aranges	00000000 .debug_aranges
00000000 l    d  .debug_pubnames	00000000 .debug_pubnames
00000000 l    d  .debug_info	00000000 .debug_info
00000000 l    d  .debug_abbrev	00000000 .debug_abbrev
00000000 l    d  .debug_line	00000000 .debug_line
00000000 l    d  .debug_frame	00000000 .debug_frame
00000000 l    d  .debug_str	00000000 .debug_str
00000000 l    d  .debug_loc	00000000 .debug_loc
000003f0 l    d  .mdebug.abi32	00000000 .mdebug.abi32
00000000 l    d  .pdr	00000000 .pdr
00000000 l    d  .debug_ranges	00000000 .debug_ranges
00000000 l    d  *ABS*	00000000 .shstrtab
00000000 l    d  *ABS*	00000000 .symtab
00000000 l    d  *ABS*	00000000 .strtab
00000000 l    df *ABS*	00000000 src/self.c
001009e0 g       *ABS*	00000000 _fdata
001089d0 g       *ABS*	00000000 _gp
000004b0 g     F .text	00000530 __start
000004b0 g       .text	00000000 _ftext
001009e0 g       *ABS*	00000000 __bss_start
001009e0 g       *ABS*	00000000 _edata
001009e0 g       *ABS*	00000000 _end
001009e0 g       *ABS*	00000000 _fbss


Disassembly of section .text:

000004b0 <__start>:
__start():
src/self.c:21
	// core0 = line 0
	// core1 = line 1
	// at a rate of (227/228)^175 \approx 0.5, we can 'safely' be in troll mode
	// approximately 175 cycles if we detect the taunt array on one of the lines
	register char *ptr = (char *)(HOME_DATA_SEGMENT) + (core_id&1)*CACHE_LINE;
 4b0:	30820001 	andi	v0,a0,0x1
 4b4:	00021200 	sll	v0,v0,0x8
 4b8:	3c030010 	lui	v1,0x10
 4bc:	00434821 	addu	t1,v0,v1
src/self.c:16
 4c0:	00802821 	move	a1,a0
 4c4:	30c600ff 	andi	a2,a2,0xff
prefetch():
src/flamewar.h:439
}

__attribute__ ((unused)) static void prefetch(void *ptr) {
  /* invoke system call number 14 */
  register void *arg asm("a0") = ptr;
 4c8:	01202021 	move	a0,t1
src/flamewar.h:440
  asm __volatile__ (
 4cc:	2402000e 	li	v0,14
 4d0:	0000000c 	syscall
__start():
src/self.c:26
	prefetch(ptr);
	register unsigned int h = 0;
	register int i = 0;
	register int k = ptr[0] == link;
	if (k){
 4d4:	81230000 	lb	v1,0(t1)
 4d8:	00000000 	nop
 4dc:	10660108 	beq	v1,a2,900 <__start+0x450>
 4e0:	28a20002 	slti	v0,a1,2
src/self.c:53
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
 4e4:	14a0001d 	bnez	a1,55c <__start+0xac>
 4e8:	24020001 	li	v0,1
src/self.c:55
			while(1){
				ptr[i] = link;
 4ec:	00063600 	sll	a2,a2,0x18
 4f0:	00063603 	sra	a2,a2,0x18
 4f4:	25230002 	addiu	v1,t1,2
 4f8:	25220001 	addiu	v0,t1,1
 4fc:	a1260000 	sb	a2,0(t1)
src/self.c:56
				ptr[20+i] = link;
 500:	a1260014 	sb	a2,20(t1)
src/self.c:57
				ptr[40+i++] = link;
 504:	a1260028 	sb	a2,40(t1)
src/self.c:55
 508:	a1260001 	sb	a2,1(t1)
 50c:	24050010 	li	a1,16
src/self.c:57
 510:	a0460028 	sb	a2,40(v0)
src/self.c:56
 514:	a0460014 	sb	a2,20(v0)
src/self.c:55
 518:	a1260002 	sb	a2,2(t1)
src/self.c:57
 51c:	a0660028 	sb	a2,40(v1)
src/self.c:56
 520:	a0660014 	sb	a2,20(v1)
src/self.c:57
 524:	24030003 	li	v1,3
src/self.c:55
 528:	01231021 	addu	v0,t1,v1
src/self.c:57
 52c:	24630001 	addiu	v1,v1,1
 530:	a0460028 	sb	a2,40(v0)
src/self.c:55
 534:	a0460000 	sb	a2,0(v0)
src/self.c:58
				if (i == 16){
 538:	1465fffb 	bne	v1,a1,528 <__start+0x78>
 53c:	a0460014 	sb	a2,20(v0)
src/self.c:59
					ptr += 2*CACHE_LINE;
 540:	25290200 	addiu	t1,t1,512
src/self.c:61
					i = 1;
					ptr[0] = link;
 544:	a1260000 	sb	a2,0(t1)
prefetch():
src/flamewar.h:439
}

__attribute__ ((unused)) static void prefetch(void *ptr) {
  /* invoke system call number 14 */
  register void *arg asm("a0") = ptr;
 548:	25240201 	addiu	a0,t1,513
src/flamewar.h:440
  asm __volatile__ (
 54c:	2402000e 	li	v0,14
 550:	0000000c 	syscall
 554:	0800014a 	j	528 <__start+0x78>
 558:	24030001 	li	v1,1
__start():
src/self.c:65
					prefetch(ptr+2*CACHE_LINE+1);
				}
			}
		} else if (core_id == 1){
 55c:	10a200b5 	beq	a1,v0,834 <__start+0x384>
 560:	24020002 	li	v0,2
src/self.c:98

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
//						for (k=0; k<20; k++){
//							if(ptr[121] == link){
//								puts("HELPING WITH DDOS");
//								// help with ddos
//								troll();
//								for(k=0; k<250; k++)
//									invalidate(OPPONENT_STATUS);
//								retreat();
//								puts("PHEW");
//							}
//						}
					}
					ptr += 2*CACHE_LINE;
					i = 0;
					ptr[0] = link;
					prefetch(ptr+2*CACHE_LINE+1);
				}
			}
		} else if (core_id == 2){
 564:	10a20089 	beq	a1,v0,78c <__start+0x2dc>
 568:	00004021 	move	t0,zero
 56c:	00063600 	sll	a2,a2,0x18
 570:	00063603 	sra	a2,a2,0x18
 574:	00002021 	move	a0,zero
 578:	00002821 	move	a1,zero
src/self.c:113
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
 57c:	01241021 	addu	v0,t1,a0
src/self.c:117
				ptr[71+i] = link;
				ptr[82+i] = link;
				ptr[100+i++] = link;
				if (i==10){
 580:	2403000a 	li	v1,10
src/self.c:116
 584:	24840001 	addiu	a0,a0,1
 588:	a0460064 	sb	a2,100(v0)
src/self.c:113
 58c:	a046003c 	sb	a2,60(v0)
src/self.c:114
 590:	a0460047 	sb	a2,71(v0)
src/self.c:117
 594:	1483fff9 	bne	a0,v1,57c <__start+0xcc>
 598:	a0460052 	sb	a2,82(v0)
src/self.c:119
					i = 0;
					if (k++ == 25){
 59c:	24a50001 	addiu	a1,a1,1
 5a0:	2402001a 	li	v0,26
 5a4:	10a20015 	beq	a1,v0,5fc <__start+0x14c>
 5a8:	3c02000f 	lui	v0,0xf
rdftag():
src/flamewar.h:490

__attribute__ ((unused)) static unsigned int rdftag(void *ptr) {
  /* invoke system call number 18 */
  register unsigned int ret asm("v0");
  register void *arg asm("a0") = ptr;
 5ac:	01202021 	move	a0,t1
src/flamewar.h:491
  asm __volatile__ (
 5b0:	24020012 	li	v0,18
 5b4:	0000000c 	syscall
__start():
src/self.c:170
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
							//printf("%x, %x, %x\n",h,OPPONENT_STATUS, ((int)h - (int)OPPONENT_STATUS > 0) && ((int)h - (int)OPPONENT_STATUS < 255));
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
 5b8:	3c037fff 	lui	v1,0x7fff
 5bc:	3463ff00 	ori	v1,v1,0xff00
 5c0:	00432024 	and	a0,v0,v1
src/self.c:171
					ptr = tag > HOME_DATA_START && tag < HOME_DATA_END ? tag: ptr + 2*CACHE_LINE;
 5c4:	3c02ffef 	lui	v0,0xffef
 5c8:	3442ffff 	ori	v0,v0,0xffff
 5cc:	3c0301ef 	lui	v1,0x1ef
 5d0:	00821021 	addu	v0,a0,v0
 5d4:	3463fffe 	ori	v1,v1,0xfffe
 5d8:	0043102b 	sltu	v0,v0,v1
 5dc:	14400004 	bnez	v0,5f0 <__start+0x140>
 5e0:	00000000 	nop
 5e4:	25290200 	addiu	t1,t1,512
 5e8:	0800015f 	j	57c <__start+0xcc>
 5ec:	00002021 	move	a0,zero
 5f0:	00804821 	move	t1,a0
 5f4:	0800015f 	j	57c <__start+0xcc>
 5f8:	00002021 	move	a0,zero
src/self.c:120
 5fc:	a1260078 	sb	a2,120(t1)
 600:	3447ff00 	ori	a3,v0,0xff00
 604:	00001821 	move	v1,zero
 608:	24050072 	li	a1,114
src/self.c:122
 60c:	00671021 	addu	v0,v1,a3
 610:	8044001c 	lb	a0,28(v0)
 614:	00000000 	nop
 618:	04800003 	bltz	a0,628 <__start+0x178>
 61c:	00000000 	nop
hammer():
src/flamewar.h:417
__attribute__ ((unused)) static int hammer(int id) {
  /* invoke system call number 12 */
  register int ret asm("v0");
  register int arg asm("a0") = id;
  asm __volatile__ (
 620:	2402000c 	li	v0,12
 624:	0000000c 	syscall
__start():
src/self.c:121
 628:	24630001 	addiu	v1,v1,1
 62c:	1465fff8 	bne	v1,a1,610 <__start+0x160>
 630:	00671021 	addu	v0,v1,a3
src/self.c:128
 634:	3c02aaaa 	lui	v0,0xaaaa
 638:	3442aaab 	ori	v0,v0,0xaaab
src/self.c:127
 63c:	25080001 	addiu	t0,t0,1
src/self.c:128
 640:	01020019 	multu	t0,v0
 644:	00001010 	mfhi	v0
 648:	00021042 	srl	v0,v0,0x1
 64c:	00021840 	sll	v1,v0,0x1
 650:	00621821 	addu	v1,v1,v0
 654:	15030007 	bne	t0,v1,674 <__start+0x1c4>
 658:	2402004a 	li	v0,74
troll():
src/flamewar.h:401
}

__attribute__ ((unused)) static void troll(void) {
  /* invoke system call number 11 */
  asm __volatile__ (
 65c:	2402000b 	li	v0,11
 660:	0000000c 	syscall
retreat():
src/flamewar.h:428
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
 664:	2402000d 	li	v0,13
 668:	0000000c 	syscall
 66c:	0800016b 	j	5ac <__start+0xfc>
 670:	00002821 	move	a1,zero
__start():
src/self.c:131
 674:	1502ffcd 	bne	t0,v0,5ac <__start+0xfc>
 678:	00002821 	move	a1,zero
troll():
src/flamewar.h:401
}

__attribute__ ((unused)) static void troll(void) {
  /* invoke system call number 11 */
  asm __volatile__ (
 67c:	2402000b 	li	v0,11
 680:	0000000c 	syscall
rdctag():
src/flamewar.h:477
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
 684:	3c038010 	lui	v1,0x8010
 688:	34640100 	ori	a0,v1,0x100
src/flamewar.h:478
  asm __volatile__ (
 68c:	24020011 	li	v0,17
 690:	0000000c 	syscall
src/flamewar.h:484
      "addiu $2, $0, 17\n\t"
      "syscall"
      : "=r" (ret)
      : "r" (arg)
      );
  return ret;
 694:	00402021 	move	a0,v0
retreat():
src/flamewar.h:428
 698:	2402000d 	li	v0,13
 69c:	0000000c 	syscall
__start():
src/self.c:139
 6a0:	3c058000 	lui	a1,0x8000
 6a4:	00852025 	or	a0,a0,a1
src/self.c:140
 6a8:	34630001 	ori	v1,v1,0x1
 6ac:	0083182b 	sltu	v1,a0,v1
 6b0:	1460000d 	bnez	v1,6e8 <__start+0x238>
 6b4:	3c027ff0 	lui	v0,0x7ff0
troll():
src/flamewar.h:401
}

__attribute__ ((unused)) static void troll(void) {
  /* invoke system call number 11 */
  asm __volatile__ (
 6b8:	2402000b 	li	v0,11
 6bc:	0000000c 	syscall
__start():
src/self.c:143
 6c0:	90830664 	lbu	v1,1636(a0)
 6c4:	240200f0 	li	v0,240
 6c8:	10620025 	beq	v1,v0,760 <__start+0x2b0>
 6cc:	2402fff0 	li	v0,-16
src/self.c:144
 6d0:	a0820664 	sb	v0,1636(a0)
retreat():
src/flamewar.h:428
}

__attribute__ ((unused)) static void retreat(void) {
  /* invoke system call number 13 */
  asm __volatile__ (
 6d4:	2402000d 	li	v0,13
 6d8:	0000000c 	syscall
 6dc:	00004021 	move	t0,zero
 6e0:	0800016b 	j	5ac <__start+0xfc>
 6e4:	00002821 	move	a1,zero
__start():
src/self.c:149
 6e8:	344200ff 	ori	v0,v0,0xff
 6ec:	00821021 	addu	v0,a0,v0
 6f0:	2c4200fe 	sltiu	v0,v0,254
 6f4:	10400018 	beqz	v0,758 <__start+0x2a8>
 6f8:	00004021 	move	t0,zero
rand():
src/flamewar.h:387

__attribute__ ((unused)) static unsigned int rand(void) {
  /* invoke system call number 6 */
  register unsigned ret asm("v0");
  asm __volatile__ (
 6fc:	24020006 	li	v0,6
 700:	0000000c 	syscall
__start():
src/self.c:151
 704:	30430007 	andi	v1,v0,0x7
src/self.c:152
 708:	24020001 	li	v0,1
 70c:	10620016 	beq	v1,v0,768 <__start+0x2b8>
 710:	00000000 	nop
src/self.c:156
 714:	1460000f 	bnez	v1,754 <__start+0x2a4>
 718:	00000000 	nop
troll():
src/flamewar.h:401
}

__attribute__ ((unused)) static void troll(void) {
  /* invoke system call number 11 */
  asm __volatile__ (
 71c:	2402000b 	li	v0,11
 720:	0000000c 	syscall
rdctag():
src/flamewar.h:477
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
 724:	3c048010 	lui	a0,0x8010
src/flamewar.h:478
  asm __volatile__ (
 728:	24020011 	li	v0,17
 72c:	0000000c 	syscall
src/flamewar.h:484
      "addiu $2, $0, 17\n\t"
      "syscall"
      : "=r" (ret)
      : "r" (arg)
      );
  return ret;
 730:	00402021 	move	a0,v0
retreat():
src/flamewar.h:428
 734:	2402000d 	li	v0,13
 738:	0000000c 	syscall
troll():
src/flamewar.h:401
 73c:	2402000b 	li	v0,11
 740:	0000000c 	syscall
__start():
src/self.c:162
 744:	2403fff1 	li	v1,-15
 748:	00852025 	or	a0,a0,a1
 74c:	080001b5 	j	6d4 <__start+0x224>
 750:	a0830064 	sb	v1,100(a0)
retreat():
src/flamewar.h:428
}

__attribute__ ((unused)) static void retreat(void) {
  /* invoke system call number 13 */
  asm __volatile__ (
 754:	00004021 	move	t0,zero
 758:	0800016b 	j	5ac <__start+0xfc>
 75c:	00002821 	move	a1,zero
src/self.c:146
 760:	080001b5 	j	6d4 <__start+0x224>
 764:	a0820678 	sb	v0,1656(a0)
troll():
src/flamewar.h:401
}

__attribute__ ((unused)) static void troll(void) {
  /* invoke system call number 11 */
  asm __volatile__ (
 768:	2402000b 	li	v0,11
 76c:	0000000c 	syscall
invalidate():
src/flamewar.h:452
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
 770:	2402000f 	li	v0,15
 774:	0000000c 	syscall
retreat():
src/flamewar.h:428
 778:	2402000d 	li	v0,13
 77c:	0000000c 	syscall
 780:	00004021 	move	t0,zero
 784:	0800016b 	j	5ac <__start+0xfc>
 788:	00002821 	move	a1,zero
__start():
src/self.c:100
 78c:	00063600 	sll	a2,a2,0x18
 790:	00063603 	sra	a2,a2,0x18
 794:	25220001 	addiu	v0,t1,1
 798:	a126003c 	sb	a2,60(t1)
src/self.c:101
 79c:	a1260047 	sb	a2,71(t1)
src/self.c:102
 7a0:	a1260052 	sb	a2,82(t1)
src/self.c:103
 7a4:	a1260064 	sb	a2,100(t1)
src/self.c:100
 7a8:	25230002 	addiu	v1,t1,2
src/self.c:103
 7ac:	a0460064 	sb	a2,100(v0)
src/self.c:100
 7b0:	a046003c 	sb	a2,60(v0)
src/self.c:101
 7b4:	a0460047 	sb	a2,71(v0)
src/self.c:102
 7b8:	a0460052 	sb	a2,82(v0)
 7bc:	3c027fff 	lui	v0,0x7fff
src/self.c:103
 7c0:	a0660064 	sb	a2,100(v1)
src/self.c:100
 7c4:	a066003c 	sb	a2,60(v1)
src/self.c:101
 7c8:	a0660047 	sb	a2,71(v1)
src/self.c:102
 7cc:	a0660052 	sb	a2,82(v1)
 7d0:	3448ff00 	ori	t0,v0,0xff00
 7d4:	3c03ffef 	lui	v1,0xffef
 7d8:	3c0201ef 	lui	v0,0x1ef
 7dc:	3463ffff 	ori	v1,v1,0xffff
 7e0:	344afffe 	ori	t2,v0,0xfffe
src/self.c:103
 7e4:	24050003 	li	a1,3
 7e8:	2407000b 	li	a3,11
src/self.c:100
 7ec:	00a91021 	addu	v0,a1,t1
src/self.c:103
 7f0:	24a50001 	addiu	a1,a1,1
rdftag():
src/flamewar.h:490

__attribute__ ((unused)) static unsigned int rdftag(void *ptr) {
  /* invoke system call number 18 */
  register unsigned int ret asm("v0");
  register void *arg asm("a0") = ptr;
 7f4:	01202021 	move	a0,t1
__start():
src/self.c:103
 7f8:	a0460064 	sb	a2,100(v0)
src/self.c:100
 7fc:	a046003c 	sb	a2,60(v0)
src/self.c:101
 800:	a0460047 	sb	a2,71(v0)
src/self.c:104
 804:	14a7fff9 	bne	a1,a3,7ec <__start+0x33c>
 808:	a0460052 	sb	a2,82(v0)
rdftag():
src/flamewar.h:491
__attribute__ ((unused)) static unsigned int rdftag(void *ptr) {
  /* invoke system call number 18 */
  register unsigned int ret asm("v0");
  register void *arg asm("a0") = ptr;
  asm __volatile__ (
 80c:	24020012 	li	v0,18
 810:	0000000c 	syscall
__start():
src/self.c:106
 814:	00482024 	and	a0,v0,t0
src/self.c:107
 818:	00831021 	addu	v0,a0,v1
 81c:	004a102b 	sltu	v0,v0,t2
 820:	25290200 	addiu	t1,t1,512
 824:	1040fff1 	beqz	v0,7ec <__start+0x33c>
 828:	00002821 	move	a1,zero
 82c:	080001fb 	j	7ec <__start+0x33c>
 830:	00804821 	move	t1,a0
src/self.c:68
 834:	00065600 	sll	t2,a2,0x18
 838:	000a5603 	sra	t2,t2,0x18
 83c:	25240002 	addiu	a0,t1,2
 840:	25220001 	addiu	v0,t1,1
 844:	3c03000f 	lui	v1,0xf
 848:	a12a0000 	sb	t2,0(t1)
src/self.c:69
 84c:	a12a0014 	sb	t2,20(t1)
src/self.c:70
 850:	a12a0028 	sb	t2,40(t1)
src/self.c:68
 854:	a12a0001 	sb	t2,1(t1)
 858:	3463ff00 	ori	v1,v1,0xff00
src/self.c:70
 85c:	a04a0028 	sb	t2,40(v0)
src/self.c:69
 860:	a04a0014 	sb	t2,20(v0)
 864:	240b0010 	li	t3,16
src/self.c:68
 868:	a12a0002 	sb	t2,2(t1)
src/self.c:70
 86c:	a08a0028 	sb	t2,40(a0)
src/self.c:69
 870:	a08a0014 	sb	t2,20(a0)
src/self.c:70
 874:	24040003 	li	a0,3
src/self.c:68
 878:	00891021 	addu	v0,a0,t1
src/self.c:70
 87c:	24840001 	addiu	a0,a0,1
 880:	a04a0028 	sb	t2,40(v0)
src/self.c:68
 884:	a04a0000 	sb	t2,0(v0)
src/self.c:71
 888:	148bfffb 	bne	a0,t3,878 <__start+0x3c8>
 88c:	a04a0014 	sb	t2,20(v0)
src/self.c:73
 890:	81220078 	lb	v0,120(t1)
 894:	00000000 	nop
 898:	10c20008 	beq	a2,v0,8bc <__start+0x40c>
 89c:	24050072 	li	a1,114
src/self.c:92
 8a0:	25290200 	addiu	t1,t1,512
src/self.c:94
 8a4:	a12a0000 	sb	t2,0(t1)
prefetch():
src/flamewar.h:439
}

__attribute__ ((unused)) static void prefetch(void *ptr) {
  /* invoke system call number 14 */
  register void *arg asm("a0") = ptr;
 8a8:	25240201 	addiu	a0,t1,513
src/flamewar.h:440
  asm __volatile__ (
 8ac:	2402000e 	li	v0,14
 8b0:	0000000c 	syscall
 8b4:	0800021e 	j	878 <__start+0x3c8>
 8b8:	00002021 	move	a0,zero
 8bc:	00604021 	move	t0,v1
 8c0:	240700e4 	li	a3,228
__start():
src/self.c:75
 8c4:	00a81021 	addu	v0,a1,t0
 8c8:	8044001c 	lb	a0,28(v0)
 8cc:	00000000 	nop
 8d0:	04800003 	bltz	a0,8e0 <__start+0x430>
 8d4:	00000000 	nop
hammer():
src/flamewar.h:417
__attribute__ ((unused)) static int hammer(int id) {
  /* invoke system call number 12 */
  register int ret asm("v0");
  register int arg asm("a0") = id;
  asm __volatile__ (
 8d8:	2402000c 	li	v0,12
 8dc:	0000000c 	syscall
__start():
src/self.c:74
 8e0:	24a50001 	addiu	a1,a1,1
 8e4:	14a7fff8 	bne	a1,a3,8c8 <__start+0x418>
 8e8:	00a81021 	addu	v0,a1,t0
prefetch():
src/flamewar.h:439
}

__attribute__ ((unused)) static void prefetch(void *ptr) {
  /* invoke system call number 14 */
  register void *arg asm("a0") = ptr;
 8ec:	25240201 	addiu	a0,t1,513
src/flamewar.h:440
  asm __volatile__ (
 8f0:	2402000e 	li	v0,14
 8f4:	0000000c 	syscall
src/self.c:92
 8f8:	08000229 	j	8a4 <__start+0x3f4>
 8fc:	25290200 	addiu	t1,t1,512
__start():
src/self.c:27
 900:	1440001c 	bnez	v0,974 <__start+0x4c4>
 904:	25220001 	addiu	v0,t1,1
src/self.c:42
 908:	00063600 	sll	a2,a2,0x18
 90c:	00063603 	sra	a2,a2,0x18
 910:	25230002 	addiu	v1,t1,2
 914:	a12600aa 	sb	a2,170(t1)
src/self.c:43
 918:	a12600b9 	sb	a2,185(t1)
src/self.c:44
 91c:	a12600c4 	sb	a2,196(t1)
src/self.c:45
 920:	a12600d2 	sb	a2,210(t1)
 924:	24040003 	li	a0,3
 928:	a04600d2 	sb	a2,210(v0)
src/self.c:42
 92c:	a04600aa 	sb	a2,170(v0)
src/self.c:43
 930:	a04600b9 	sb	a2,185(v0)
src/self.c:44
 934:	a04600c4 	sb	a2,196(v0)
src/self.c:45
 938:	a06600d2 	sb	a2,210(v1)
src/self.c:42
 93c:	a06600aa 	sb	a2,170(v1)
src/self.c:43
 940:	a06600b9 	sb	a2,185(v1)
src/self.c:44
 944:	a06600c4 	sb	a2,196(v1)
src/self.c:42
 948:	00891021 	addu	v0,a0,t1
src/self.c:46
 94c:	2403000c 	li	v1,12
src/self.c:45
 950:	24840001 	addiu	a0,a0,1
 954:	a04600d2 	sb	a2,210(v0)
src/self.c:42
 958:	a04600aa 	sb	a2,170(v0)
src/self.c:43
 95c:	a04600b9 	sb	a2,185(v0)
src/self.c:46
 960:	1483fff9 	bne	a0,v1,948 <__start+0x498>
 964:	a04600c4 	sb	a2,196(v0)
src/self.c:47
 968:	25290200 	addiu	t1,t1,512
 96c:	08000252 	j	948 <__start+0x498>
 970:	00002021 	move	a0,zero
src/self.c:29
 974:	00063600 	sll	a2,a2,0x18
 978:	00063603 	sra	a2,a2,0x18
 97c:	25230002 	addiu	v1,t1,2
 980:	a126006e 	sb	a2,110(t1)
src/self.c:30
 984:	a1260082 	sb	a2,130(t1)
src/self.c:31
 988:	a1260096 	sb	a2,150(t1)
 98c:	24050010 	li	a1,16
 990:	a0460096 	sb	a2,150(v0)
src/self.c:29
 994:	a046006e 	sb	a2,110(v0)
src/self.c:30
 998:	a0460082 	sb	a2,130(v0)
src/self.c:31
 99c:	a0660096 	sb	a2,150(v1)
src/self.c:29
 9a0:	a066006e 	sb	a2,110(v1)
src/self.c:30
 9a4:	a0660082 	sb	a2,130(v1)
src/self.c:31
 9a8:	24030003 	li	v1,3
src/self.c:29
 9ac:	01231021 	addu	v0,t1,v1
src/self.c:31
 9b0:	24630001 	addiu	v1,v1,1
 9b4:	a0460096 	sb	a2,150(v0)
src/self.c:29
 9b8:	a046006e 	sb	a2,110(v0)
src/self.c:32
 9bc:	1465fffb 	bne	v1,a1,9ac <__start+0x4fc>
 9c0:	a0460082 	sb	a2,130(v0)
src/self.c:33
 9c4:	25290200 	addiu	t1,t1,512
src/self.c:35
 9c8:	a1260000 	sb	a2,0(t1)
prefetch():
src/flamewar.h:439
}

__attribute__ ((unused)) static void prefetch(void *ptr) {
  /* invoke system call number 14 */
  register void *arg asm("a0") = ptr;
 9cc:	25240201 	addiu	a0,t1,513
src/flamewar.h:440
  asm __volatile__ (
 9d0:	2402000e 	li	v0,14
 9d4:	0000000c 	syscall
 9d8:	0800026b 	j	9ac <__start+0x4fc>
 9dc:	24030001 	li	v1,1
