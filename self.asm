
bin/self:     file format elf32-tradlittlemips
bin/self
architecture: mips:3000, flags 0x00000112:
EXEC_P, HAS_SYMS, D_PAGED
start address 0x000004b0

Program Header:
0x70000000 off    0x00000494 vaddr 0x00000494 paddr 0x00000494 align 2**2
         filesz 0x00000018 memsz 0x00000018 flags r--
    LOAD off    0x00000000 vaddr 0x00000000 paddr 0x00000000 align 2**16
         filesz 0x00000860 memsz 0x00000860 flags r-x
private flags = 1001: [abi=O32] [mips1] [not 32bitmode]

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .reginfo      00000018  00000494  00000494  00000494  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA, LINK_ONCE_DISCARD
  1 .text         000003b0  000004b0  000004b0  000004b0  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  2 .comment      00000012  00000000  00000000  00000860  2**0
                  CONTENTS, READONLY
  3 .debug_aranges 00000020  00000000  00000000  00000872  2**0
                  CONTENTS, READONLY, DEBUGGING
  4 .debug_pubnames 0000001e  00000000  00000000  00000892  2**0
                  CONTENTS, READONLY, DEBUGGING
  5 .debug_info   00000363  00000000  00000000  000008b0  2**0
                  CONTENTS, READONLY, DEBUGGING
  6 .debug_abbrev 00000136  00000000  00000000  00000c13  2**0
                  CONTENTS, READONLY, DEBUGGING
  7 .debug_line   00000138  00000000  00000000  00000d49  2**0
                  CONTENTS, READONLY, DEBUGGING
  8 .debug_frame  00000020  00000000  00000000  00000e84  2**2
                  CONTENTS, READONLY, DEBUGGING
  9 .debug_str    0000009b  00000000  00000000  00000ea4  2**0
                  CONTENTS, READONLY, DEBUGGING
 10 .debug_loc    000002c9  00000000  00000000  00000f3f  2**0
                  CONTENTS, READONLY, DEBUGGING
 11 .mdebug.abi32 00000000  000002c9  000002c9  00001208  2**0
                  CONTENTS, READONLY
 12 .pdr          00000020  00000000  00000000  00001208  2**2
                  CONTENTS, READONLY
 13 .debug_ranges 00000048  00000000  00000000  00001228  2**0
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
000002c9 l    d  .mdebug.abi32	00000000 .mdebug.abi32
00000000 l    d  .pdr	00000000 .pdr
00000000 l    d  .debug_ranges	00000000 .debug_ranges
00000000 l    d  *ABS*	00000000 .shstrtab
00000000 l    d  *ABS*	00000000 .symtab
00000000 l    d  *ABS*	00000000 .strtab
00000000 l    df *ABS*	00000000 src/self.c
00100860 g       *ABS*	00000000 _fdata
00108850 g       *ABS*	00000000 _gp
000004b0 g     F .text	000003ac __start
000004b0 g       .text	00000000 _ftext
00100860 g       *ABS*	00000000 __bss_start
00100860 g       *ABS*	00000000 _edata
00100860 g       *ABS*	00000000 _end
00100860 g       *ABS*	00000000 _fbss


Disassembly of section .text:

000004b0 <__start>:
__start():
src/self.c:20
	// core0 = line 0
	// core1 = line 1
	// at a rate of (247/248)^175 \approx 0.5, we can 'safely' be in troll mode
	// approximately 175 cycles if we detect the taunt array on one of the lines
	register char *ptr = (char *)(HOME_DATA_SEGMENT) + (core_id&1)*CACHE_LINE;
 4b0:	30820001 	andi	v0,a0,0x1
 4b4:	00021200 	sll	v0,v0,0x8
 4b8:	3c030010 	lui	v1,0x10
 4bc:	00434021 	addu	t0,v0,v1
src/self.c:15
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
rdftag():
src/flamewar.h:491
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
  asm __volatile__ (
      "addiu $2, $0, 17\n\t"
      "syscall"
      : "=r" (ret)
      : "r" (arg)
      );
  return ret;
}

__attribute__ ((unused)) static unsigned int rdftag(void *ptr) {
  /* invoke system call number 18 */
  register unsigned int ret asm("v0");
  register void *arg asm("a0") = ptr;
  asm __volatile__ (
 4d4:	24020012 	li	v0,18
 4d8:	0000000c 	syscall
__start():
src/self.c:25
	prefetch(ptr);
	register int HI = rdftag(ptr)>=HIMEM ? HIMEM : 0;
	register int i = 0;
	register int k = ptr[0] == link;
	if (k){
 4dc:	81030000 	lb	v1,0(t0)
 4e0:	00000000 	nop
 4e4:	106600a4 	beq	v1,a2,778 <__start+0x2c8>
 4e8:	00402021 	move	a0,v0
src/self.c:52
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
 4ec:	14a0001d 	bnez	a1,564 <__start+0xb4>
 4f0:	24020001 	li	v0,1
src/self.c:54
			while(1){
				ptr[i] = link;
 4f4:	00063600 	sll	a2,a2,0x18
 4f8:	00063603 	sra	a2,a2,0x18
 4fc:	25030002 	addiu	v1,t0,2
 500:	25020001 	addiu	v0,t0,1
 504:	a1060000 	sb	a2,0(t0)
src/self.c:55
				ptr[20+i] = link;
 508:	a1060014 	sb	a2,20(t0)
src/self.c:56
				ptr[40+i++] = link;
 50c:	a1060028 	sb	a2,40(t0)
src/self.c:54
 510:	a1060001 	sb	a2,1(t0)
 514:	24050010 	li	a1,16
src/self.c:56
 518:	a0460028 	sb	a2,40(v0)
src/self.c:55
 51c:	a0460014 	sb	a2,20(v0)
src/self.c:54
 520:	a1060002 	sb	a2,2(t0)
src/self.c:56
 524:	a0660028 	sb	a2,40(v1)
src/self.c:55
 528:	a0660014 	sb	a2,20(v1)
src/self.c:56
 52c:	24030003 	li	v1,3
src/self.c:54
 530:	01031021 	addu	v0,t0,v1
src/self.c:56
 534:	24630001 	addiu	v1,v1,1
 538:	a0460028 	sb	a2,40(v0)
src/self.c:54
 53c:	a0460000 	sb	a2,0(v0)
src/self.c:57
				if (i == 16){
 540:	1465fffb 	bne	v1,a1,530 <__start+0x80>
 544:	a0460014 	sb	a2,20(v0)
src/self.c:58
					ptr += 2*CACHE_LINE;
 548:	25080200 	addiu	t0,t0,512
src/self.c:60
					i = 1;
					ptr[0] = link;
 54c:	a1060000 	sb	a2,0(t0)
prefetch():
src/flamewar.h:439
}

__attribute__ ((unused)) static void prefetch(void *ptr) {
  /* invoke system call number 14 */
  register void *arg asm("a0") = ptr;
 550:	25040201 	addiu	a0,t0,513
src/flamewar.h:440
  asm __volatile__ (
 554:	2402000e 	li	v0,14
 558:	0000000c 	syscall
 55c:	0800014c 	j	530 <__start+0x80>
 560:	24030001 	li	v1,1
__start():
src/self.c:64
					prefetch(ptr+2*CACHE_LINE+1);
				}
			}
		} else if (core_id == 1){
 564:	10a20054 	beq	a1,v0,6b8 <__start+0x208>
 568:	3c028000 	lui	v0,0x8000
src/self.c:85

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
 56c:	24030002 	li	v1,2
 570:	10a3002e 	beq	a1,v1,62c <__start+0x17c>
 574:	00824824 	and	t1,a0,v0
 578:	00063600 	sll	a2,a2,0x18
 57c:	00063603 	sra	a2,a2,0x18
 580:	00002021 	move	a0,zero
 584:	00002821 	move	a1,zero
src/self.c:106
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
 588:	01041021 	addu	v0,t0,a0
src/self.c:110
				ptr[71+i] = link;
				ptr[82+i] = link;
				ptr[100+i++] = link;
				if (i==10){
 58c:	2403000a 	li	v1,10
src/self.c:109
 590:	24840001 	addiu	a0,a0,1
 594:	a0460064 	sb	a2,100(v0)
src/self.c:106
 598:	a046003c 	sb	a2,60(v0)
src/self.c:107
 59c:	a0460047 	sb	a2,71(v0)
src/self.c:110
 5a0:	1483fff9 	bne	a0,v1,588 <__start+0xd8>
 5a4:	a0460052 	sb	a2,82(v0)
src/self.c:112
					i = 0;
					if (k++ == 20){
 5a8:	24a50001 	addiu	a1,a1,1
 5ac:	24020015 	li	v0,21
 5b0:	10a2000e 	beq	a1,v0,5ec <__start+0x13c>
 5b4:	3c02000f 	lui	v0,0xf
rdftag():
src/flamewar.h:490

__attribute__ ((unused)) static unsigned int rdftag(void *ptr) {
  /* invoke system call number 18 */
  register unsigned int ret asm("v0");
  register void *arg asm("a0") = ptr;
 5b8:	01002021 	move	a0,t0
src/flamewar.h:491
  asm __volatile__ (
 5bc:	24020012 	li	v0,18
 5c0:	0000000c 	syscall
__start():
src/self.c:123
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
 5c4:	10400006 	beqz	v0,5e0 <__start+0x130>
 5c8:	00401821 	move	v1,v0
 5cc:	2402ff00 	li	v0,-256
 5d0:	00621024 	and	v0,v1,v0
 5d4:	00494023 	subu	t0,v0,t1
 5d8:	08000162 	j	588 <__start+0xd8>
 5dc:	00002021 	move	a0,zero
 5e0:	25080200 	addiu	t0,t0,512
 5e4:	08000162 	j	588 <__start+0xd8>
 5e8:	00002021 	move	a0,zero
src/self.c:113
 5ec:	a1060078 	sb	a2,120(t0)
 5f0:	3447ff00 	ori	a3,v0,0xff00
 5f4:	00001821 	move	v1,zero
 5f8:	24050072 	li	a1,114
src/self.c:115
 5fc:	00671021 	addu	v0,v1,a3
 600:	8044001c 	lb	a0,28(v0)
 604:	00000000 	nop
 608:	04800003 	bltz	a0,618 <__start+0x168>
 60c:	00000000 	nop
hammer():
src/flamewar.h:417
__attribute__ ((unused)) static int hammer(int id) {
  /* invoke system call number 12 */
  register int ret asm("v0");
  register int arg asm("a0") = id;
  asm __volatile__ (
 610:	2402000c 	li	v0,12
 614:	0000000c 	syscall
__start():
src/self.c:114
 618:	24630001 	addiu	v1,v1,1
 61c:	1465fff8 	bne	v1,a1,600 <__start+0x150>
 620:	00671021 	addu	v0,v1,a3
 624:	0800016e 	j	5b8 <__start+0x108>
 628:	00002821 	move	a1,zero
src/self.c:89
 62c:	00063600 	sll	a2,a2,0x18
 630:	00063603 	sra	a2,a2,0x18
 634:	25030002 	addiu	v1,t0,2
 638:	25020001 	addiu	v0,t0,1
 63c:	a106003c 	sb	a2,60(t0)
src/self.c:90
 640:	a1060047 	sb	a2,71(t0)
src/self.c:91
 644:	a1060052 	sb	a2,82(t0)
src/self.c:92
 648:	a1060064 	sb	a2,100(t0)
 64c:	2405000b 	li	a1,11
 650:	a0460064 	sb	a2,100(v0)
src/self.c:89
 654:	a046003c 	sb	a2,60(v0)
src/self.c:90
 658:	a0460047 	sb	a2,71(v0)
src/self.c:91
 65c:	a0460052 	sb	a2,82(v0)
 660:	2407ff00 	li	a3,-256
src/self.c:92
 664:	a0660064 	sb	a2,100(v1)
src/self.c:89
 668:	a066003c 	sb	a2,60(v1)
src/self.c:90
 66c:	a0660047 	sb	a2,71(v1)
src/self.c:91
 670:	a0660052 	sb	a2,82(v1)
src/self.c:92
 674:	24030003 	li	v1,3
src/self.c:89
 678:	00681021 	addu	v0,v1,t0
src/self.c:92
 67c:	24630001 	addiu	v1,v1,1
rdftag():
src/flamewar.h:490

__attribute__ ((unused)) static unsigned int rdftag(void *ptr) {
  /* invoke system call number 18 */
  register unsigned int ret asm("v0");
  register void *arg asm("a0") = ptr;
 680:	01002021 	move	a0,t0
__start():
src/self.c:92
 684:	a0460064 	sb	a2,100(v0)
src/self.c:89
 688:	a046003c 	sb	a2,60(v0)
src/self.c:90
 68c:	a0460047 	sb	a2,71(v0)
src/self.c:93
 690:	1465fff9 	bne	v1,a1,678 <__start+0x1c8>
 694:	a0460052 	sb	a2,82(v0)
rdftag():
src/flamewar.h:491
__attribute__ ((unused)) static unsigned int rdftag(void *ptr) {
  /* invoke system call number 18 */
  register unsigned int ret asm("v0");
  register void *arg asm("a0") = ptr;
  asm __volatile__ (
 698:	24020012 	li	v0,18
 69c:	0000000c 	syscall
__start():
src/self.c:96
 6a0:	00001821 	move	v1,zero
 6a4:	25080200 	addiu	t0,t0,512
 6a8:	1040fff3 	beqz	v0,678 <__start+0x1c8>
 6ac:	00472024 	and	a0,v0,a3
 6b0:	0800019e 	j	678 <__start+0x1c8>
 6b4:	00894023 	subu	t0,a0,t1
src/self.c:67
 6b8:	00065600 	sll	t2,a2,0x18
 6bc:	000a5603 	sra	t2,t2,0x18
 6c0:	25040002 	addiu	a0,t0,2
 6c4:	25020001 	addiu	v0,t0,1
 6c8:	3c03000f 	lui	v1,0xf
 6cc:	a10a0000 	sb	t2,0(t0)
src/self.c:68
 6d0:	a10a0014 	sb	t2,20(t0)
src/self.c:69
 6d4:	a10a0028 	sb	t2,40(t0)
src/self.c:67
 6d8:	a10a0001 	sb	t2,1(t0)
 6dc:	3463ff00 	ori	v1,v1,0xff00
src/self.c:69
 6e0:	a04a0028 	sb	t2,40(v0)
src/self.c:68
 6e4:	a04a0014 	sb	t2,20(v0)
 6e8:	240b0010 	li	t3,16
src/self.c:67
 6ec:	a10a0002 	sb	t2,2(t0)
src/self.c:69
 6f0:	a08a0028 	sb	t2,40(a0)
src/self.c:68
 6f4:	a08a0014 	sb	t2,20(a0)
src/self.c:69
 6f8:	24040003 	li	a0,3
src/self.c:67
 6fc:	00881021 	addu	v0,a0,t0
src/self.c:69
 700:	24840001 	addiu	a0,a0,1
 704:	a04a0028 	sb	t2,40(v0)
src/self.c:67
 708:	a04a0000 	sb	t2,0(v0)
src/self.c:70
 70c:	148bfffb 	bne	a0,t3,6fc <__start+0x24c>
 710:	a04a0014 	sb	t2,20(v0)
src/self.c:72
 714:	81020078 	lb	v0,120(t0)
 718:	00000000 	nop
 71c:	10c20008 	beq	a2,v0,740 <__start+0x290>
 720:	24050072 	li	a1,114
src/self.c:79
 724:	25080200 	addiu	t0,t0,512
src/self.c:81
 728:	a10a0000 	sb	t2,0(t0)
prefetch():
src/flamewar.h:439
}

__attribute__ ((unused)) static void prefetch(void *ptr) {
  /* invoke system call number 14 */
  register void *arg asm("a0") = ptr;
 72c:	25040201 	addiu	a0,t0,513
src/flamewar.h:440
  asm __volatile__ (
 730:	2402000e 	li	v0,14
 734:	0000000c 	syscall
 738:	080001bf 	j	6fc <__start+0x24c>
 73c:	00002021 	move	a0,zero
 740:	00604821 	move	t1,v1
 744:	240700e4 	li	a3,228
__start():
src/self.c:74
 748:	00a91021 	addu	v0,a1,t1
 74c:	8044001c 	lb	a0,28(v0)
 750:	00000000 	nop
 754:	04800003 	bltz	a0,764 <__start+0x2b4>
 758:	00000000 	nop
hammer():
src/flamewar.h:417
__attribute__ ((unused)) static int hammer(int id) {
  /* invoke system call number 12 */
  register int ret asm("v0");
  register int arg asm("a0") = id;
  asm __volatile__ (
 75c:	2402000c 	li	v0,12
 760:	0000000c 	syscall
__start():
src/self.c:73
 764:	24a50001 	addiu	a1,a1,1
 768:	14a7fff8 	bne	a1,a3,74c <__start+0x29c>
 76c:	00a91021 	addu	v0,a1,t1
src/self.c:79
 770:	080001ca 	j	728 <__start+0x278>
 774:	25080200 	addiu	t0,t0,512
src/self.c:26
 778:	28a20002 	slti	v0,a1,2
 77c:	1440001c 	bnez	v0,7f0 <__start+0x340>
 780:	25020001 	addiu	v0,t0,1
src/self.c:41
 784:	00063600 	sll	a2,a2,0x18
 788:	00063603 	sra	a2,a2,0x18
 78c:	25030002 	addiu	v1,t0,2
 790:	a10600aa 	sb	a2,170(t0)
src/self.c:42
 794:	a10600b9 	sb	a2,185(t0)
src/self.c:43
 798:	a10600c4 	sb	a2,196(t0)
src/self.c:44
 79c:	a10600d2 	sb	a2,210(t0)
 7a0:	24040003 	li	a0,3
 7a4:	a04600d2 	sb	a2,210(v0)
src/self.c:41
 7a8:	a04600aa 	sb	a2,170(v0)
src/self.c:42
 7ac:	a04600b9 	sb	a2,185(v0)
src/self.c:43
 7b0:	a04600c4 	sb	a2,196(v0)
src/self.c:44
 7b4:	a06600d2 	sb	a2,210(v1)
src/self.c:41
 7b8:	a06600aa 	sb	a2,170(v1)
src/self.c:42
 7bc:	a06600b9 	sb	a2,185(v1)
src/self.c:43
 7c0:	a06600c4 	sb	a2,196(v1)
src/self.c:41
 7c4:	00881021 	addu	v0,a0,t0
src/self.c:45
 7c8:	2403000c 	li	v1,12
src/self.c:44
 7cc:	24840001 	addiu	a0,a0,1
 7d0:	a04600d2 	sb	a2,210(v0)
src/self.c:41
 7d4:	a04600aa 	sb	a2,170(v0)
src/self.c:42
 7d8:	a04600b9 	sb	a2,185(v0)
src/self.c:45
 7dc:	1483fff9 	bne	a0,v1,7c4 <__start+0x314>
 7e0:	a04600c4 	sb	a2,196(v0)
src/self.c:46
 7e4:	25080200 	addiu	t0,t0,512
 7e8:	080001f1 	j	7c4 <__start+0x314>
 7ec:	00002021 	move	a0,zero
src/self.c:28
 7f0:	00063600 	sll	a2,a2,0x18
 7f4:	00063603 	sra	a2,a2,0x18
 7f8:	25030002 	addiu	v1,t0,2
 7fc:	a106006e 	sb	a2,110(t0)
src/self.c:29
 800:	a1060082 	sb	a2,130(t0)
src/self.c:30
 804:	a1060096 	sb	a2,150(t0)
 808:	24050010 	li	a1,16
 80c:	a0460096 	sb	a2,150(v0)
src/self.c:28
 810:	a046006e 	sb	a2,110(v0)
src/self.c:29
 814:	a0460082 	sb	a2,130(v0)
src/self.c:30
 818:	a0660096 	sb	a2,150(v1)
src/self.c:28
 81c:	a066006e 	sb	a2,110(v1)
src/self.c:29
 820:	a0660082 	sb	a2,130(v1)
src/self.c:30
 824:	24030003 	li	v1,3
src/self.c:28
 828:	01031021 	addu	v0,t0,v1
src/self.c:30
 82c:	24630001 	addiu	v1,v1,1
 830:	a0460096 	sb	a2,150(v0)
src/self.c:28
 834:	a046006e 	sb	a2,110(v0)
src/self.c:31
 838:	1465fffb 	bne	v1,a1,828 <__start+0x378>
 83c:	a0460082 	sb	a2,130(v0)
src/self.c:32
 840:	25080200 	addiu	t0,t0,512
src/self.c:34
 844:	a1060000 	sb	a2,0(t0)
prefetch():
src/flamewar.h:439
}

__attribute__ ((unused)) static void prefetch(void *ptr) {
  /* invoke system call number 14 */
  register void *arg asm("a0") = ptr;
 848:	25040201 	addiu	a0,t0,513
src/flamewar.h:440
  asm __volatile__ (
 84c:	2402000e 	li	v0,14
 850:	0000000c 	syscall
 854:	0800020a 	j	828 <__start+0x378>
 858:	24030001 	li	v1,1
_ftext():
 85c:	00000000 	nop
