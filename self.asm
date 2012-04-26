
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
  7 .debug_line   000001cc  00000000  00000000  00001113  2**0
                  CONTENTS, READONLY, DEBUGGING
  8 .debug_frame  00000020  00000000  00000000  000012e0  2**2
                  CONTENTS, READONLY, DEBUGGING
  9 .debug_str    000000c0  00000000  00000000  00001300  2**0
                  CONTENTS, READONLY, DEBUGGING
 10 .debug_loc    000003e5  00000000  00000000  000013c0  2**0
                  CONTENTS, READONLY, DEBUGGING
 11 .mdebug.abi32 00000000  000003e5  000003e5  000017a5  2**0
                  CONTENTS, READONLY
 12 .pdr          00000020  00000000  00000000  000017a8  2**2
                  CONTENTS, READONLY
 13 .debug_ranges 00000078  00000000  00000000  000017c8  2**0
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
000003e5 l    d  .mdebug.abi32	00000000 .mdebug.abi32
00000000 l    d  .pdr	00000000 .pdr
00000000 l    d  .debug_ranges	00000000 .debug_ranges
00000000 l    d  *ABS*	00000000 .shstrtab
00000000 l    d  *ABS*	00000000 .symtab
00000000 l    d  *ABS*	00000000 .strtab
00000000 l    df *ABS*	00000000 src/self.c
001009e0 g       *ABS*	00000000 _fdata
001089d0 g       *ABS*	00000000 _gp
000004b0 g     F .text	0000052c __start
000004b0 g       .text	00000000 _ftext
001009e0 g       *ABS*	00000000 __bss_start
001009e0 g       *ABS*	00000000 _edata
001009e0 g       *ABS*	00000000 _end
001009e0 g       *ABS*	00000000 _fbss


Disassembly of section .text:

000004b0 <__start>:
__start():
src/self.c:37
	// core0 = line 0
	// core1 = line 1
	// at a rate of (227/228)^175 \approx 0.5, we can 'safely' be in troll mode
	// approximately 175 cycles if we detect the taunt array on one of the lines
	register char *ptr = (char *)(HOME_DATA_SEGMENT) + (core_id&1)*CACHE_LINE;
 4b0:	30820001 	andi	v0,a0,0x1
 4b4:	00021200 	sll	v0,v0,0x8
 4b8:	3c030010 	lui	v1,0x10
 4bc:	00434821 	addu	t1,v0,v1
src/self.c:32
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
src/self.c:42
	prefetch(ptr);
	register unsigned int h = 0;
	register int i = 0;
	register int k = ptr[0] == link;
	if (k){
 4d4:	81230000 	lb	v1,0(t1)
 4d8:	00000000 	nop
 4dc:	10660107 	beq	v1,a2,8fc <__start+0x44c>
 4e0:	28a20002 	slti	v0,a1,2
src/self.c:72
        // If we segfault, optimistically hope that we've filled the lower half of memory for each cache line
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
        // core 0 and core 2 fills as many lines as possible
        // core 1 and 3 fills, then checks taunt, and finally core 3 may go on the offense
		if (!core_id){
 4e4:	14a0001d 	bnez	a1,55c <__start+0xac>
 4e8:	24020001 	li	v0,1
src/self.c:74
			while(1){
				ptr[i] = link;
 4ec:	00063600 	sll	a2,a2,0x18
 4f0:	00063603 	sra	a2,a2,0x18
 4f4:	25230002 	addiu	v1,t1,2
 4f8:	25220001 	addiu	v0,t1,1
 4fc:	a1260000 	sb	a2,0(t1)
src/self.c:75
				ptr[20+i] = link;
 500:	a1260014 	sb	a2,20(t1)
src/self.c:76
				ptr[40+i++] = link;
 504:	a1260028 	sb	a2,40(t1)
src/self.c:74
 508:	a1260001 	sb	a2,1(t1)
 50c:	24050010 	li	a1,16
src/self.c:76
 510:	a0460028 	sb	a2,40(v0)
src/self.c:75
 514:	a0460014 	sb	a2,20(v0)
src/self.c:74
 518:	a1260002 	sb	a2,2(t1)
src/self.c:76
 51c:	a0660028 	sb	a2,40(v1)
src/self.c:75
 520:	a0660014 	sb	a2,20(v1)
src/self.c:76
 524:	24030003 	li	v1,3
src/self.c:74
 528:	01231021 	addu	v0,t1,v1
src/self.c:76
 52c:	24630001 	addiu	v1,v1,1
 530:	a0460028 	sb	a2,40(v0)
src/self.c:74
 534:	a0460000 	sb	a2,0(v0)
src/self.c:77
				if (i == 16){
 538:	1465fffb 	bne	v1,a1,528 <__start+0x78>
 53c:	a0460014 	sb	a2,20(v0)
src/self.c:78
					ptr += 2*CACHE_LINE;
 540:	25290200 	addiu	t1,t1,512
src/self.c:80
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
src/self.c:84
					prefetch(ptr+2*CACHE_LINE+1);
				}
			}
		} else if (core_id == 1){
 55c:	10a200b4 	beq	a1,v0,830 <__start+0x380>
 560:	24020002 	li	v0,2
src/self.c:106

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
 564:	10a20088 	beq	a1,v0,788 <__start+0x2d8>
 568:	00004021 	move	t0,zero
 56c:	00063600 	sll	a2,a2,0x18
 570:	00063603 	sra	a2,a2,0x18
 574:	00002021 	move	a0,zero
 578:	00002821 	move	a1,zero
src/self.c:121
			while(1){
				ptr[60+i] = link;
				ptr[71+i] = link;
				ptr[82+i] = link;
				ptr[100+i++] = link;
				if (i==11){
					i = 0;
					register unsigned int tag = cache_align(rdftag(ptr));// automatically sync up with the core 0
					ptr = tag > HOME_DATA_START && tag < HOME_DATA_END ? tag: ptr + 2*CACHE_LINE;
				}
			}
		} else {
			k = 0;
			while(1){
				ptr[60+i] = link;
 57c:	01241021 	addu	v0,t1,a0
src/self.c:125
				ptr[71+i] = link;
				ptr[82+i] = link;
				ptr[100+i++] = link;
				if (i==10){
 580:	2403000a 	li	v1,10
src/self.c:124
 584:	24840001 	addiu	a0,a0,1
 588:	a0460064 	sb	a2,100(v0)
src/self.c:121
 58c:	a046003c 	sb	a2,60(v0)
src/self.c:122
 590:	a0460047 	sb	a2,71(v0)
src/self.c:125
 594:	1483fff9 	bne	a0,v1,57c <__start+0xcc>
 598:	a0460052 	sb	a2,82(v0)
src/self.c:127
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
src/self.c:178
						ptr[120] = link;
						for (k = 0; k < TAUNT_SIZE/2; k++) {
							if (HOME_STATUS->taunt[k] >= 0) {
								hammer(HOME_STATUS->taunt[k]);
							}
						}
						// do a simple attack on fbi
						h++;
						if (h % 3 == 0){
							troll(); // this might buy us a bit of time
							retreat();
						}
                        if (h == 60) {
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
 5b8:	3c037fff 	lui	v1,0x7fff
 5bc:	3463ff00 	ori	v1,v1,0xff00
 5c0:	00432024 	and	a0,v0,v1
src/self.c:179
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
src/self.c:128
 5fc:	a1260078 	sb	a2,120(t1)
 600:	3447ff00 	ori	a3,v0,0xff00
 604:	00001821 	move	v1,zero
 608:	24050072 	li	a1,114
src/self.c:130
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
src/self.c:129
 628:	24630001 	addiu	v1,v1,1
 62c:	1465fff8 	bne	v1,a1,610 <__start+0x160>
 630:	00671021 	addu	v0,v1,a3
src/self.c:136
 634:	3c02aaaa 	lui	v0,0xaaaa
 638:	3442aaab 	ori	v0,v0,0xaaab
src/self.c:135
 63c:	25080001 	addiu	t0,t0,1
src/self.c:136
 640:	01020019 	multu	t0,v0
 644:	00001010 	mfhi	v0
 648:	00021042 	srl	v0,v0,0x1
 64c:	00021840 	sll	v1,v0,0x1
 650:	00621821 	addu	v1,v1,v0
 654:	15030006 	bne	t0,v1,670 <__start+0x1c0>
 658:	2402003c 	li	v0,60
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
__start():
src/self.c:140
 66c:	2402003c 	li	v0,60
 670:	1502ffce 	bne	t0,v0,5ac <__start+0xfc>
 674:	00002821 	move	a1,zero
troll():
src/flamewar.h:401
}

__attribute__ ((unused)) static void troll(void) {
  /* invoke system call number 11 */
  asm __volatile__ (
 678:	2402000b 	li	v0,11
 67c:	0000000c 	syscall
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
 680:	3c038010 	lui	v1,0x8010
 684:	34640100 	ori	a0,v1,0x100
src/flamewar.h:478
  asm __volatile__ (
 688:	24020011 	li	v0,17
 68c:	0000000c 	syscall
src/flamewar.h:484
      "addiu $2, $0, 17\n\t"
      "syscall"
      : "=r" (ret)
      : "r" (arg)
      );
  return ret;
 690:	00402021 	move	a0,v0
retreat():
src/flamewar.h:428
 694:	2402000d 	li	v0,13
 698:	0000000c 	syscall
__start():
src/self.c:147
 69c:	3c058000 	lui	a1,0x8000
 6a0:	00852025 	or	a0,a0,a1
src/self.c:148
 6a4:	34630001 	ori	v1,v1,0x1
 6a8:	0083182b 	sltu	v1,a0,v1
 6ac:	1460000d 	bnez	v1,6e4 <__start+0x234>
 6b0:	3c027ff0 	lui	v0,0x7ff0
troll():
src/flamewar.h:401
}

__attribute__ ((unused)) static void troll(void) {
  /* invoke system call number 11 */
  asm __volatile__ (
 6b4:	2402000b 	li	v0,11
 6b8:	0000000c 	syscall
__start():
src/self.c:151
 6bc:	90830664 	lbu	v1,1636(a0)
 6c0:	240200f0 	li	v0,240
 6c4:	10620025 	beq	v1,v0,75c <__start+0x2ac>
 6c8:	2402fff0 	li	v0,-16
src/self.c:152
 6cc:	a0820664 	sb	v0,1636(a0)
retreat():
src/flamewar.h:428
}

__attribute__ ((unused)) static void retreat(void) {
  /* invoke system call number 13 */
  asm __volatile__ (
 6d0:	2402000d 	li	v0,13
 6d4:	0000000c 	syscall
 6d8:	00004021 	move	t0,zero
 6dc:	0800016b 	j	5ac <__start+0xfc>
 6e0:	00002821 	move	a1,zero
__start():
src/self.c:157
 6e4:	344200ff 	ori	v0,v0,0xff
 6e8:	00821021 	addu	v0,a0,v0
 6ec:	2c4200fe 	sltiu	v0,v0,254
 6f0:	10400018 	beqz	v0,754 <__start+0x2a4>
 6f4:	00004021 	move	t0,zero
rand():
src/flamewar.h:387

__attribute__ ((unused)) static unsigned int rand(void) {
  /* invoke system call number 6 */
  register unsigned ret asm("v0");
  asm __volatile__ (
 6f8:	24020006 	li	v0,6
 6fc:	0000000c 	syscall
__start():
src/self.c:159
 700:	30430007 	andi	v1,v0,0x7
src/self.c:160
 704:	24020001 	li	v0,1
 708:	10620016 	beq	v1,v0,764 <__start+0x2b4>
 70c:	00000000 	nop
src/self.c:164
 710:	1460000f 	bnez	v1,750 <__start+0x2a0>
 714:	00000000 	nop
troll():
src/flamewar.h:401
}

__attribute__ ((unused)) static void troll(void) {
  /* invoke system call number 11 */
  asm __volatile__ (
 718:	2402000b 	li	v0,11
 71c:	0000000c 	syscall
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
 720:	3c048010 	lui	a0,0x8010
src/flamewar.h:478
  asm __volatile__ (
 724:	24020011 	li	v0,17
 728:	0000000c 	syscall
src/flamewar.h:484
      "addiu $2, $0, 17\n\t"
      "syscall"
      : "=r" (ret)
      : "r" (arg)
      );
  return ret;
 72c:	00402021 	move	a0,v0
retreat():
src/flamewar.h:428
 730:	2402000d 	li	v0,13
 734:	0000000c 	syscall
troll():
src/flamewar.h:401
 738:	2402000b 	li	v0,11
 73c:	0000000c 	syscall
__start():
src/self.c:170
 740:	2403fff1 	li	v1,-15
 744:	00852025 	or	a0,a0,a1
 748:	080001b4 	j	6d0 <__start+0x220>
 74c:	a0830064 	sb	v1,100(a0)
retreat():
src/flamewar.h:428
}

__attribute__ ((unused)) static void retreat(void) {
  /* invoke system call number 13 */
  asm __volatile__ (
 750:	00004021 	move	t0,zero
 754:	0800016b 	j	5ac <__start+0xfc>
 758:	00002821 	move	a1,zero
src/self.c:154
 75c:	080001b4 	j	6d0 <__start+0x220>
 760:	a0820678 	sb	v0,1656(a0)
troll():
src/flamewar.h:401
}

__attribute__ ((unused)) static void troll(void) {
  /* invoke system call number 11 */
  asm __volatile__ (
 764:	2402000b 	li	v0,11
 768:	0000000c 	syscall
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
 76c:	2402000f 	li	v0,15
 770:	0000000c 	syscall
retreat():
src/flamewar.h:428
 774:	2402000d 	li	v0,13
 778:	0000000c 	syscall
 77c:	00004021 	move	t0,zero
 780:	0800016b 	j	5ac <__start+0xfc>
 784:	00002821 	move	a1,zero
__start():
src/self.c:108
 788:	00063600 	sll	a2,a2,0x18
 78c:	00063603 	sra	a2,a2,0x18
 790:	25220001 	addiu	v0,t1,1
 794:	a126003c 	sb	a2,60(t1)
src/self.c:109
 798:	a1260047 	sb	a2,71(t1)
src/self.c:110
 79c:	a1260052 	sb	a2,82(t1)
src/self.c:111
 7a0:	a1260064 	sb	a2,100(t1)
src/self.c:108
 7a4:	25230002 	addiu	v1,t1,2
src/self.c:111
 7a8:	a0460064 	sb	a2,100(v0)
src/self.c:108
 7ac:	a046003c 	sb	a2,60(v0)
src/self.c:109
 7b0:	a0460047 	sb	a2,71(v0)
src/self.c:110
 7b4:	a0460052 	sb	a2,82(v0)
 7b8:	3c027fff 	lui	v0,0x7fff
src/self.c:111
 7bc:	a0660064 	sb	a2,100(v1)
src/self.c:108
 7c0:	a066003c 	sb	a2,60(v1)
src/self.c:109
 7c4:	a0660047 	sb	a2,71(v1)
src/self.c:110
 7c8:	a0660052 	sb	a2,82(v1)
 7cc:	3448ff00 	ori	t0,v0,0xff00
 7d0:	3c03ffef 	lui	v1,0xffef
 7d4:	3c0201ef 	lui	v0,0x1ef
 7d8:	3463ffff 	ori	v1,v1,0xffff
 7dc:	344afffe 	ori	t2,v0,0xfffe
src/self.c:111
 7e0:	24050003 	li	a1,3
 7e4:	2407000b 	li	a3,11
src/self.c:108
 7e8:	00a91021 	addu	v0,a1,t1
src/self.c:111
 7ec:	24a50001 	addiu	a1,a1,1
rdftag():
src/flamewar.h:490

__attribute__ ((unused)) static unsigned int rdftag(void *ptr) {
  /* invoke system call number 18 */
  register unsigned int ret asm("v0");
  register void *arg asm("a0") = ptr;
 7f0:	01202021 	move	a0,t1
__start():
src/self.c:111
 7f4:	a0460064 	sb	a2,100(v0)
src/self.c:108
 7f8:	a046003c 	sb	a2,60(v0)
src/self.c:109
 7fc:	a0460047 	sb	a2,71(v0)
src/self.c:112
 800:	14a7fff9 	bne	a1,a3,7e8 <__start+0x338>
 804:	a0460052 	sb	a2,82(v0)
rdftag():
src/flamewar.h:491
__attribute__ ((unused)) static unsigned int rdftag(void *ptr) {
  /* invoke system call number 18 */
  register unsigned int ret asm("v0");
  register void *arg asm("a0") = ptr;
  asm __volatile__ (
 808:	24020012 	li	v0,18
 80c:	0000000c 	syscall
__start():
src/self.c:114
 810:	00482024 	and	a0,v0,t0
src/self.c:115
 814:	00831021 	addu	v0,a0,v1
 818:	004a102b 	sltu	v0,v0,t2
 81c:	25290200 	addiu	t1,t1,512
 820:	1040fff1 	beqz	v0,7e8 <__start+0x338>
 824:	00002821 	move	a1,zero
 828:	080001fa 	j	7e8 <__start+0x338>
 82c:	00804821 	move	t1,a0
src/self.c:87
 830:	00065600 	sll	t2,a2,0x18
 834:	000a5603 	sra	t2,t2,0x18
 838:	25240002 	addiu	a0,t1,2
 83c:	25220001 	addiu	v0,t1,1
 840:	3c03000f 	lui	v1,0xf
 844:	a12a0000 	sb	t2,0(t1)
src/self.c:88
 848:	a12a0014 	sb	t2,20(t1)
src/self.c:89
 84c:	a12a0028 	sb	t2,40(t1)
src/self.c:87
 850:	a12a0001 	sb	t2,1(t1)
 854:	3463ff00 	ori	v1,v1,0xff00
src/self.c:89
 858:	a04a0028 	sb	t2,40(v0)
src/self.c:88
 85c:	a04a0014 	sb	t2,20(v0)
 860:	240b0010 	li	t3,16
src/self.c:87
 864:	a12a0002 	sb	t2,2(t1)
src/self.c:89
 868:	a08a0028 	sb	t2,40(a0)
src/self.c:88
 86c:	a08a0014 	sb	t2,20(a0)
src/self.c:89
 870:	24040003 	li	a0,3
src/self.c:87
 874:	00891021 	addu	v0,a0,t1
src/self.c:89
 878:	24840001 	addiu	a0,a0,1
 87c:	a04a0028 	sb	t2,40(v0)
src/self.c:87
 880:	a04a0000 	sb	t2,0(v0)
src/self.c:90
 884:	148bfffb 	bne	a0,t3,874 <__start+0x3c4>
 888:	a04a0014 	sb	t2,20(v0)
src/self.c:92
 88c:	81220078 	lb	v0,120(t1)
 890:	00000000 	nop
 894:	10c20008 	beq	a2,v0,8b8 <__start+0x408>
 898:	24050072 	li	a1,114
src/self.c:100
 89c:	25290200 	addiu	t1,t1,512
src/self.c:102
 8a0:	a12a0000 	sb	t2,0(t1)
prefetch():
src/flamewar.h:439
}

__attribute__ ((unused)) static void prefetch(void *ptr) {
  /* invoke system call number 14 */
  register void *arg asm("a0") = ptr;
 8a4:	25240201 	addiu	a0,t1,513
src/flamewar.h:440
  asm __volatile__ (
 8a8:	2402000e 	li	v0,14
 8ac:	0000000c 	syscall
 8b0:	0800021d 	j	874 <__start+0x3c4>
 8b4:	00002021 	move	a0,zero
 8b8:	00604021 	move	t0,v1
 8bc:	240700e4 	li	a3,228
__start():
src/self.c:94
 8c0:	00a81021 	addu	v0,a1,t0
 8c4:	8044001c 	lb	a0,28(v0)
 8c8:	00000000 	nop
 8cc:	04800003 	bltz	a0,8dc <__start+0x42c>
 8d0:	00000000 	nop
hammer():
src/flamewar.h:417
__attribute__ ((unused)) static int hammer(int id) {
  /* invoke system call number 12 */
  register int ret asm("v0");
  register int arg asm("a0") = id;
  asm __volatile__ (
 8d4:	2402000c 	li	v0,12
 8d8:	0000000c 	syscall
__start():
src/self.c:93
 8dc:	24a50001 	addiu	a1,a1,1
 8e0:	14a7fff8 	bne	a1,a3,8c4 <__start+0x414>
 8e4:	00a81021 	addu	v0,a1,t0
prefetch():
src/flamewar.h:439
}

__attribute__ ((unused)) static void prefetch(void *ptr) {
  /* invoke system call number 14 */
  register void *arg asm("a0") = ptr;
 8e8:	25240201 	addiu	a0,t1,513
src/flamewar.h:440
  asm __volatile__ (
 8ec:	2402000e 	li	v0,14
 8f0:	0000000c 	syscall
src/self.c:100
 8f4:	08000228 	j	8a0 <__start+0x3f0>
 8f8:	25290200 	addiu	t1,t1,512
__start():
src/self.c:44
 8fc:	1440001c 	bnez	v0,970 <__start+0x4c0>
 900:	25220001 	addiu	v0,t1,1
src/self.c:59
 904:	00063600 	sll	a2,a2,0x18
 908:	00063603 	sra	a2,a2,0x18
 90c:	25230002 	addiu	v1,t1,2
 910:	a12600aa 	sb	a2,170(t1)
src/self.c:60
 914:	a12600b9 	sb	a2,185(t1)
src/self.c:61
 918:	a12600c4 	sb	a2,196(t1)
src/self.c:62
 91c:	a12600d2 	sb	a2,210(t1)
 920:	24040003 	li	a0,3
 924:	a04600d2 	sb	a2,210(v0)
src/self.c:59
 928:	a04600aa 	sb	a2,170(v0)
src/self.c:60
 92c:	a04600b9 	sb	a2,185(v0)
src/self.c:61
 930:	a04600c4 	sb	a2,196(v0)
src/self.c:62
 934:	a06600d2 	sb	a2,210(v1)
src/self.c:59
 938:	a06600aa 	sb	a2,170(v1)
src/self.c:60
 93c:	a06600b9 	sb	a2,185(v1)
src/self.c:61
 940:	a06600c4 	sb	a2,196(v1)
src/self.c:59
 944:	00891021 	addu	v0,a0,t1
src/self.c:63
 948:	2403000c 	li	v1,12
src/self.c:62
 94c:	24840001 	addiu	a0,a0,1
 950:	a04600d2 	sb	a2,210(v0)
src/self.c:59
 954:	a04600aa 	sb	a2,170(v0)
src/self.c:60
 958:	a04600b9 	sb	a2,185(v0)
src/self.c:63
 95c:	1483fff9 	bne	a0,v1,944 <__start+0x494>
 960:	a04600c4 	sb	a2,196(v0)
src/self.c:64
 964:	25290200 	addiu	t1,t1,512
 968:	08000251 	j	944 <__start+0x494>
 96c:	00002021 	move	a0,zero
src/self.c:46
 970:	00063600 	sll	a2,a2,0x18
 974:	00063603 	sra	a2,a2,0x18
 978:	25230002 	addiu	v1,t1,2
 97c:	a126006e 	sb	a2,110(t1)
src/self.c:47
 980:	a1260082 	sb	a2,130(t1)
src/self.c:48
 984:	a1260096 	sb	a2,150(t1)
 988:	24050010 	li	a1,16
 98c:	a0460096 	sb	a2,150(v0)
src/self.c:46
 990:	a046006e 	sb	a2,110(v0)
src/self.c:47
 994:	a0460082 	sb	a2,130(v0)
src/self.c:48
 998:	a0660096 	sb	a2,150(v1)
src/self.c:46
 99c:	a066006e 	sb	a2,110(v1)
src/self.c:47
 9a0:	a0660082 	sb	a2,130(v1)
src/self.c:48
 9a4:	24030003 	li	v1,3
src/self.c:46
 9a8:	01231021 	addu	v0,t1,v1
src/self.c:48
 9ac:	24630001 	addiu	v1,v1,1
 9b0:	a0460096 	sb	a2,150(v0)
src/self.c:46
 9b4:	a046006e 	sb	a2,110(v0)
src/self.c:49
 9b8:	1465fffb 	bne	v1,a1,9a8 <__start+0x4f8>
 9bc:	a0460082 	sb	a2,130(v0)
src/self.c:50
 9c0:	25290200 	addiu	t1,t1,512
src/self.c:52
 9c4:	a1260000 	sb	a2,0(t1)
prefetch():
src/flamewar.h:439
}

__attribute__ ((unused)) static void prefetch(void *ptr) {
  /* invoke system call number 14 */
  register void *arg asm("a0") = ptr;
 9c8:	25240201 	addiu	a0,t1,513
src/flamewar.h:440
  asm __volatile__ (
 9cc:	2402000e 	li	v0,14
 9d0:	0000000c 	syscall
 9d4:	0800026a 	j	9a8 <__start+0x4f8>
 9d8:	24030001 	li	v1,1
_ftext():
 9dc:	00000000 	nop
