
bin/self:     file format elf32-tradlittlemips
bin/self
architecture: mips:3000, flags 0x00000112:
EXEC_P, HAS_SYMS, D_PAGED
start address 0x000004b0

Program Header:
0x70000000 off    0x00000494 vaddr 0x00000494 paddr 0x00000494 align 2**2
         filesz 0x00000018 memsz 0x00000018 flags r--
    LOAD off    0x00000000 vaddr 0x00000000 paddr 0x00000000 align 2**16
         filesz 0x000008e0 memsz 0x000008e0 flags r-x
private flags = 1001: [abi=O32] [mips1] [not 32bitmode]

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .reginfo      00000018  00000494  00000494  00000494  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA, LINK_ONCE_DISCARD
  1 .text         00000430  000004b0  000004b0  000004b0  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  2 .comment      00000012  00000000  00000000  000008e0  2**0
                  CONTENTS, READONLY
  3 .debug_aranges 00000020  00000000  00000000  000008f2  2**0
                  CONTENTS, READONLY, DEBUGGING
  4 .debug_pubnames 0000001e  00000000  00000000  00000912  2**0
                  CONTENTS, READONLY, DEBUGGING
  5 .debug_info   0000036b  00000000  00000000  00000930  2**0
                  CONTENTS, READONLY, DEBUGGING
  6 .debug_abbrev 00000154  00000000  00000000  00000c9b  2**0
                  CONTENTS, READONLY, DEBUGGING
  7 .debug_line   0000014c  00000000  00000000  00000def  2**0
                  CONTENTS, READONLY, DEBUGGING
  8 .debug_frame  00000020  00000000  00000000  00000f3c  2**2
                  CONTENTS, READONLY, DEBUGGING
  9 .debug_str    000000a9  00000000  00000000  00000f5c  2**0
                  CONTENTS, READONLY, DEBUGGING
 10 .debug_loc    000002ea  00000000  00000000  00001005  2**0
                  CONTENTS, READONLY, DEBUGGING
 11 .mdebug.abi32 00000000  000002ea  000002ea  000012ef  2**0
                  CONTENTS, READONLY
 12 .pdr          00000020  00000000  00000000  000012f0  2**2
                  CONTENTS, READONLY
 13 .debug_ranges 00000048  00000000  00000000  00001310  2**0
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
000002ea l    d  .mdebug.abi32	00000000 .mdebug.abi32
00000000 l    d  .pdr	00000000 .pdr
00000000 l    d  .debug_ranges	00000000 .debug_ranges
00000000 l    d  *ABS*	00000000 .shstrtab
00000000 l    d  *ABS*	00000000 .symtab
00000000 l    d  *ABS*	00000000 .strtab
00000000 l    df *ABS*	00000000 src/self.c
001008e0 g       *ABS*	00000000 _fdata
001088d0 g       *ABS*	00000000 _gp
000004b0 g     F .text	0000042c __start
000004b0 g       .text	00000000 _ftext
001008e0 g       *ABS*	00000000 __bss_start
001008e0 g       *ABS*	00000000 _edata
001008e0 g       *ABS*	00000000 _end
001008e0 g       *ABS*	00000000 _fbss


Disassembly of section .text:

000004b0 <__start>:
__start():
src/self.c:21
	// core0 = line 0
	// core1 = line 1
	// at a rate of (247/248)^175 \approx 0.5, we can 'safely' be in troll mode
	// approximately 175 cycles if we detect the taunt array on one of the lines
	register char *ptr = (char *)(HOME_DATA_SEGMENT) + (core_id&1)*CACHE_LINE;
 4b0:	30820001 	andi	v0,a0,0x1
 4b4:	00021200 	sll	v0,v0,0x8
 4b8:	3c030010 	lui	v1,0x10
 4bc:	00434021 	addu	t0,v0,v1
src/self.c:16
 4c0:	00802821 	move	a1,a0
 4c4:	30c600ff 	andi	a2,a2,0xff
prefetch():
src/flamewar.h:439
}

__attribute__ ((unused)) static void prefetch(void *ptr) {
  /* invoke system call number 14 */
  register void *arg asm("a0") = ptr;
 4c8:	01002021 	move	a0,t0
src/flamewar.h:440
  asm __volatile__ (
 4cc:	2402000e 	li	v0,14
 4d0:	0000000c 	syscall
__start():
src/self.c:26
	prefetch(ptr);
	register int h = 0;
	register int i = 0;
	register int k = ptr[0] == link;
	if (k){
 4d4:	81030000 	lb	v1,0(t0)
 4d8:	00000000 	nop
 4dc:	106600c7 	beq	v1,a2,7fc <__start+0x34c>
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
 4f4:	25030002 	addiu	v1,t0,2
 4f8:	25020001 	addiu	v0,t0,1
 4fc:	a1060000 	sb	a2,0(t0)
src/self.c:56
				ptr[20+i] = link;
 500:	a1060014 	sb	a2,20(t0)
src/self.c:57
				ptr[40+i++] = link;
 504:	a1060028 	sb	a2,40(t0)
src/self.c:55
 508:	a1060001 	sb	a2,1(t0)
 50c:	24050010 	li	a1,16
src/self.c:57
 510:	a0460028 	sb	a2,40(v0)
src/self.c:56
 514:	a0460014 	sb	a2,20(v0)
src/self.c:55
 518:	a1060002 	sb	a2,2(t0)
src/self.c:57
 51c:	a0660028 	sb	a2,40(v1)
src/self.c:56
 520:	a0660014 	sb	a2,20(v1)
src/self.c:57
 524:	24030003 	li	v1,3
src/self.c:55
 528:	01031021 	addu	v0,t0,v1
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
 540:	25080200 	addiu	t0,t0,512
src/self.c:61
					i = 1;
					ptr[0] = link;
 544:	a1060000 	sb	a2,0(t0)
prefetch():
src/flamewar.h:439
}

__attribute__ ((unused)) static void prefetch(void *ptr) {
  /* invoke system call number 14 */
  register void *arg asm("a0") = ptr;
 548:	25040201 	addiu	a0,t0,513
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
 55c:	10a20077 	beq	a1,v0,73c <__start+0x28c>
 560:	24020002 	li	v0,2
src/self.c:86

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
 564:	10a2004b 	beq	a1,v0,694 <__start+0x1e4>
 568:	00004821 	move	t1,zero
 56c:	00063600 	sll	a2,a2,0x18
 570:	00063603 	sra	a2,a2,0x18
 574:	00002021 	move	a0,zero
 578:	00002821 	move	a1,zero
src/self.c:101
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
 57c:	01041021 	addu	v0,t0,a0
src/self.c:105
				ptr[71+i] = link;
				ptr[82+i] = link;
				ptr[100+i++] = link;
				if (i==10){
 580:	2403000a 	li	v1,10
src/self.c:104
 584:	24840001 	addiu	a0,a0,1
 588:	a0460064 	sb	a2,100(v0)
src/self.c:101
 58c:	a046003c 	sb	a2,60(v0)
src/self.c:102
 590:	a0460047 	sb	a2,71(v0)
src/self.c:105
 594:	1483fff9 	bne	a0,v1,57c <__start+0xcc>
 598:	a0460052 	sb	a2,82(v0)
src/self.c:107
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
 5ac:	01002021 	move	a0,t0
src/flamewar.h:491
  asm __volatile__ (
 5b0:	24020012 	li	v0,18
 5b4:	0000000c 	syscall
__start():
src/self.c:125
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
						} else if (h == 100) {
							// actually do an attack
							h = 0;
						}
						k = 0;
					}
					register unsigned int tag = cache_align(rdftag(ptr));
 5b8:	3c037fff 	lui	v1,0x7fff
 5bc:	3463ff00 	ori	v1,v1,0xff00
 5c0:	00432024 	and	a0,v0,v1
src/self.c:126
					ptr = tag > HOME_DATA_START && tag < HOME_DATA_END ? tag: ptr + 2*CACHE_LINE;
 5c4:	3c02ffef 	lui	v0,0xffef
 5c8:	3442ffff 	ori	v0,v0,0xffff
 5cc:	3c0301ef 	lui	v1,0x1ef
 5d0:	00821021 	addu	v0,a0,v0
 5d4:	3463fffe 	ori	v1,v1,0xfffe
 5d8:	0043102b 	sltu	v0,v0,v1
 5dc:	14400004 	bnez	v0,5f0 <__start+0x140>
 5e0:	00000000 	nop
 5e4:	25080200 	addiu	t0,t0,512
 5e8:	0800015f 	j	57c <__start+0xcc>
 5ec:	00002021 	move	a0,zero
 5f0:	00804021 	move	t0,a0
 5f4:	0800015f 	j	57c <__start+0xcc>
 5f8:	00002021 	move	a0,zero
src/self.c:108
 5fc:	a1060078 	sb	a2,120(t0)
 600:	3447ff00 	ori	a3,v0,0xff00
 604:	00001821 	move	v1,zero
 608:	24050072 	li	a1,114
src/self.c:110
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
src/self.c:109
 628:	24630001 	addiu	v1,v1,1
 62c:	1465fff8 	bne	v1,a1,610 <__start+0x160>
 630:	00671021 	addu	v0,v1,a3
src/self.c:116
 634:	3c025555 	lui	v0,0x5555
src/self.c:115
 638:	25290001 	addiu	t1,t1,1
src/self.c:116
 63c:	34425556 	ori	v0,v0,0x5556
 640:	01220018 	mult	t1,v0
 644:	000927c3 	sra	a0,t1,0x1f
 648:	00001010 	mfhi	v0
 64c:	00441023 	subu	v0,v0,a0
 650:	00021840 	sll	v1,v0,0x1
 654:	00621821 	addu	v1,v1,v0
 658:	15230007 	bne	t1,v1,678 <__start+0x1c8>
 65c:	24020064 	li	v0,100
troll():
src/flamewar.h:401
}

__attribute__ ((unused)) static void troll(void) {
  /* invoke system call number 11 */
  asm __volatile__ (
 660:	2402000b 	li	v0,11
 664:	0000000c 	syscall
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
 668:	2402000d 	li	v0,13
 66c:	0000000c 	syscall
 670:	0800016b 	j	5ac <__start+0xfc>
 674:	00002821 	move	a1,zero
__start():
src/self.c:119
 678:	11220003 	beq	t1,v0,688 <__start+0x1d8>
 67c:	00000000 	nop
 680:	0800016b 	j	5ac <__start+0xfc>
 684:	00002821 	move	a1,zero
 688:	00004821 	move	t1,zero
 68c:	0800016b 	j	5ac <__start+0xfc>
 690:	00002821 	move	a1,zero
src/self.c:88
 694:	00063600 	sll	a2,a2,0x18
 698:	00063603 	sra	a2,a2,0x18
 69c:	25020001 	addiu	v0,t0,1
 6a0:	a106003c 	sb	a2,60(t0)
src/self.c:89
 6a4:	a1060047 	sb	a2,71(t0)
src/self.c:90
 6a8:	a1060052 	sb	a2,82(t0)
src/self.c:91
 6ac:	a1060064 	sb	a2,100(t0)
src/self.c:88
 6b0:	25030002 	addiu	v1,t0,2
src/self.c:91
 6b4:	a0460064 	sb	a2,100(v0)
src/self.c:88
 6b8:	a046003c 	sb	a2,60(v0)
src/self.c:89
 6bc:	a0460047 	sb	a2,71(v0)
src/self.c:90
 6c0:	a0460052 	sb	a2,82(v0)
 6c4:	3c027fff 	lui	v0,0x7fff
src/self.c:91
 6c8:	a0660064 	sb	a2,100(v1)
src/self.c:88
 6cc:	a066003c 	sb	a2,60(v1)
src/self.c:89
 6d0:	a0660047 	sb	a2,71(v1)
src/self.c:90
 6d4:	a0660052 	sb	a2,82(v1)
 6d8:	3449ff00 	ori	t1,v0,0xff00
 6dc:	3c03ffef 	lui	v1,0xffef
 6e0:	3c0201ef 	lui	v0,0x1ef
 6e4:	3463ffff 	ori	v1,v1,0xffff
 6e8:	344afffe 	ori	t2,v0,0xfffe
src/self.c:91
 6ec:	24050003 	li	a1,3
 6f0:	2407000b 	li	a3,11
src/self.c:88
 6f4:	00a81021 	addu	v0,a1,t0
src/self.c:91
 6f8:	24a50001 	addiu	a1,a1,1
rdftag():
src/flamewar.h:490

__attribute__ ((unused)) static unsigned int rdftag(void *ptr) {
  /* invoke system call number 18 */
  register unsigned int ret asm("v0");
  register void *arg asm("a0") = ptr;
 6fc:	01002021 	move	a0,t0
__start():
src/self.c:91
 700:	a0460064 	sb	a2,100(v0)
src/self.c:88
 704:	a046003c 	sb	a2,60(v0)
src/self.c:89
 708:	a0460047 	sb	a2,71(v0)
src/self.c:92
 70c:	14a7fff9 	bne	a1,a3,6f4 <__start+0x244>
 710:	a0460052 	sb	a2,82(v0)
rdftag():
src/flamewar.h:491
__attribute__ ((unused)) static unsigned int rdftag(void *ptr) {
  /* invoke system call number 18 */
  register unsigned int ret asm("v0");
  register void *arg asm("a0") = ptr;
  asm __volatile__ (
 714:	24020012 	li	v0,18
 718:	0000000c 	syscall
__start():
src/self.c:94
 71c:	00492024 	and	a0,v0,t1
src/self.c:95
 720:	00831021 	addu	v0,a0,v1
 724:	004a102b 	sltu	v0,v0,t2
 728:	25080200 	addiu	t0,t0,512
 72c:	1040fff1 	beqz	v0,6f4 <__start+0x244>
 730:	00002821 	move	a1,zero
 734:	080001bd 	j	6f4 <__start+0x244>
 738:	00804021 	move	t0,a0
src/self.c:68
 73c:	00065600 	sll	t2,a2,0x18
 740:	000a5603 	sra	t2,t2,0x18
 744:	25040002 	addiu	a0,t0,2
 748:	25020001 	addiu	v0,t0,1
 74c:	3c03000f 	lui	v1,0xf
 750:	a10a0000 	sb	t2,0(t0)
src/self.c:69
 754:	a10a0014 	sb	t2,20(t0)
src/self.c:70
 758:	a10a0028 	sb	t2,40(t0)
src/self.c:68
 75c:	a10a0001 	sb	t2,1(t0)
 760:	3463ff00 	ori	v1,v1,0xff00
src/self.c:70
 764:	a04a0028 	sb	t2,40(v0)
src/self.c:69
 768:	a04a0014 	sb	t2,20(v0)
 76c:	240b0010 	li	t3,16
src/self.c:68
 770:	a10a0002 	sb	t2,2(t0)
src/self.c:70
 774:	a08a0028 	sb	t2,40(a0)
src/self.c:69
 778:	a08a0014 	sb	t2,20(a0)
src/self.c:70
 77c:	24040003 	li	a0,3
src/self.c:68
 780:	00881021 	addu	v0,a0,t0
src/self.c:70
 784:	24840001 	addiu	a0,a0,1
 788:	a04a0028 	sb	t2,40(v0)
src/self.c:68
 78c:	a04a0000 	sb	t2,0(v0)
src/self.c:71
 790:	148bfffb 	bne	a0,t3,780 <__start+0x2d0>
 794:	a04a0014 	sb	t2,20(v0)
src/self.c:73
 798:	81020078 	lb	v0,120(t0)
 79c:	00000000 	nop
 7a0:	10c20008 	beq	a2,v0,7c4 <__start+0x314>
 7a4:	24050072 	li	a1,114
src/self.c:80
 7a8:	25080200 	addiu	t0,t0,512
src/self.c:82
 7ac:	a10a0000 	sb	t2,0(t0)
prefetch():
src/flamewar.h:439
}

__attribute__ ((unused)) static void prefetch(void *ptr) {
  /* invoke system call number 14 */
  register void *arg asm("a0") = ptr;
 7b0:	25040201 	addiu	a0,t0,513
src/flamewar.h:440
  asm __volatile__ (
 7b4:	2402000e 	li	v0,14
 7b8:	0000000c 	syscall
 7bc:	080001e0 	j	780 <__start+0x2d0>
 7c0:	00002021 	move	a0,zero
 7c4:	00604821 	move	t1,v1
 7c8:	240700e4 	li	a3,228
__start():
src/self.c:75
 7cc:	00a91021 	addu	v0,a1,t1
 7d0:	8044001c 	lb	a0,28(v0)
 7d4:	00000000 	nop
 7d8:	04800003 	bltz	a0,7e8 <__start+0x338>
 7dc:	00000000 	nop
hammer():
src/flamewar.h:417
__attribute__ ((unused)) static int hammer(int id) {
  /* invoke system call number 12 */
  register int ret asm("v0");
  register int arg asm("a0") = id;
  asm __volatile__ (
 7e0:	2402000c 	li	v0,12
 7e4:	0000000c 	syscall
__start():
src/self.c:74
 7e8:	24a50001 	addiu	a1,a1,1
 7ec:	14a7fff8 	bne	a1,a3,7d0 <__start+0x320>
 7f0:	00a91021 	addu	v0,a1,t1
src/self.c:80
 7f4:	080001eb 	j	7ac <__start+0x2fc>
 7f8:	25080200 	addiu	t0,t0,512
src/self.c:27
 7fc:	1440001c 	bnez	v0,870 <__start+0x3c0>
 800:	25020001 	addiu	v0,t0,1
src/self.c:42
 804:	00063600 	sll	a2,a2,0x18
 808:	00063603 	sra	a2,a2,0x18
 80c:	25030002 	addiu	v1,t0,2
 810:	a10600aa 	sb	a2,170(t0)
src/self.c:43
 814:	a10600b9 	sb	a2,185(t0)
src/self.c:44
 818:	a10600c4 	sb	a2,196(t0)
src/self.c:45
 81c:	a10600d2 	sb	a2,210(t0)
 820:	24040003 	li	a0,3
 824:	a04600d2 	sb	a2,210(v0)
src/self.c:42
 828:	a04600aa 	sb	a2,170(v0)
src/self.c:43
 82c:	a04600b9 	sb	a2,185(v0)
src/self.c:44
 830:	a04600c4 	sb	a2,196(v0)
src/self.c:45
 834:	a06600d2 	sb	a2,210(v1)
src/self.c:42
 838:	a06600aa 	sb	a2,170(v1)
src/self.c:43
 83c:	a06600b9 	sb	a2,185(v1)
src/self.c:44
 840:	a06600c4 	sb	a2,196(v1)
src/self.c:42
 844:	00881021 	addu	v0,a0,t0
src/self.c:46
 848:	2403000c 	li	v1,12
src/self.c:45
 84c:	24840001 	addiu	a0,a0,1
 850:	a04600d2 	sb	a2,210(v0)
src/self.c:42
 854:	a04600aa 	sb	a2,170(v0)
src/self.c:43
 858:	a04600b9 	sb	a2,185(v0)
src/self.c:46
 85c:	1483fff9 	bne	a0,v1,844 <__start+0x394>
 860:	a04600c4 	sb	a2,196(v0)
src/self.c:47
 864:	25080200 	addiu	t0,t0,512
 868:	08000211 	j	844 <__start+0x394>
 86c:	00002021 	move	a0,zero
src/self.c:29
 870:	00063600 	sll	a2,a2,0x18
 874:	00063603 	sra	a2,a2,0x18
 878:	25030002 	addiu	v1,t0,2
 87c:	a106006e 	sb	a2,110(t0)
src/self.c:30
 880:	a1060082 	sb	a2,130(t0)
src/self.c:31
 884:	a1060096 	sb	a2,150(t0)
 888:	24050010 	li	a1,16
 88c:	a0460096 	sb	a2,150(v0)
src/self.c:29
 890:	a046006e 	sb	a2,110(v0)
src/self.c:30
 894:	a0460082 	sb	a2,130(v0)
src/self.c:31
 898:	a0660096 	sb	a2,150(v1)
src/self.c:29
 89c:	a066006e 	sb	a2,110(v1)
src/self.c:30
 8a0:	a0660082 	sb	a2,130(v1)
src/self.c:31
 8a4:	24030003 	li	v1,3
src/self.c:29
 8a8:	01031021 	addu	v0,t0,v1
src/self.c:31
 8ac:	24630001 	addiu	v1,v1,1
 8b0:	a0460096 	sb	a2,150(v0)
src/self.c:29
 8b4:	a046006e 	sb	a2,110(v0)
src/self.c:32
 8b8:	1465fffb 	bne	v1,a1,8a8 <__start+0x3f8>
 8bc:	a0460082 	sb	a2,130(v0)
src/self.c:33
 8c0:	25080200 	addiu	t0,t0,512
src/self.c:35
 8c4:	a1060000 	sb	a2,0(t0)
prefetch():
src/flamewar.h:439
}

__attribute__ ((unused)) static void prefetch(void *ptr) {
  /* invoke system call number 14 */
  register void *arg asm("a0") = ptr;
 8c8:	25040201 	addiu	a0,t0,513
src/flamewar.h:440
  asm __volatile__ (
 8cc:	2402000e 	li	v0,14
 8d0:	0000000c 	syscall
 8d4:	0800022a 	j	8a8 <__start+0x3f8>
 8d8:	24030001 	li	v1,1
_ftext():
 8dc:	00000000 	nop
