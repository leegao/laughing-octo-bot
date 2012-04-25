
bin/self:     file format elf32-tradlittlemips
bin/self
architecture: mips:3000, flags 0x00000112:
EXEC_P, HAS_SYMS, D_PAGED
start address 0x000004b0

Program Header:
0x70000000 off    0x00000494 vaddr 0x00000494 paddr 0x00000494 align 2**2
         filesz 0x00000018 memsz 0x00000018 flags r--
    LOAD off    0x00000000 vaddr 0x00000000 paddr 0x00000000 align 2**16
         filesz 0x00000890 memsz 0x00000890 flags r-x
private flags = 1001: [abi=O32] [mips1] [not 32bitmode]

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .reginfo      00000018  00000494  00000494  00000494  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA, LINK_ONCE_DISCARD
  1 .text         000003e0  000004b0  000004b0  000004b0  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  2 .comment      00000012  00000000  00000000  00000890  2**0
                  CONTENTS, READONLY
  3 .debug_aranges 00000020  00000000  00000000  000008a2  2**0
                  CONTENTS, READONLY, DEBUGGING
  4 .debug_pubnames 0000001e  00000000  00000000  000008c2  2**0
                  CONTENTS, READONLY, DEBUGGING
  5 .debug_info   00000367  00000000  00000000  000008e0  2**0
                  CONTENTS, READONLY, DEBUGGING
  6 .debug_abbrev 00000136  00000000  00000000  00000c47  2**0
                  CONTENTS, READONLY, DEBUGGING
  7 .debug_line   0000013a  00000000  00000000  00000d7d  2**0
                  CONTENTS, READONLY, DEBUGGING
  8 .debug_frame  00000020  00000000  00000000  00000eb8  2**2
                  CONTENTS, READONLY, DEBUGGING
  9 .debug_str    0000009b  00000000  00000000  00000ed8  2**0
                  CONTENTS, READONLY, DEBUGGING
 10 .debug_loc    0000031e  00000000  00000000  00000f73  2**0
                  CONTENTS, READONLY, DEBUGGING
 11 .mdebug.abi32 00000000  0000031e  0000031e  00001291  2**0
                  CONTENTS, READONLY
 12 .pdr          00000020  00000000  00000000  00001294  2**2
                  CONTENTS, READONLY
 13 .debug_ranges 00000048  00000000  00000000  000012b4  2**0
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
0000031e l    d  .mdebug.abi32	00000000 .mdebug.abi32
00000000 l    d  .pdr	00000000 .pdr
00000000 l    d  .debug_ranges	00000000 .debug_ranges
00000000 l    d  *ABS*	00000000 .shstrtab
00000000 l    d  *ABS*	00000000 .symtab
00000000 l    d  *ABS*	00000000 .strtab
00000000 l    df *ABS*	00000000 src/self.c
00100890 g       *ABS*	00000000 _fdata
00108880 g       *ABS*	00000000 _gp
000004b0 g     F .text	000003d8 __start
000004b0 g       .text	00000000 _ftext
00100890 g       *ABS*	00000000 __bss_start
00100890 g       *ABS*	00000000 _edata
00100890 g       *ABS*	00000000 _end
00100890 g       *ABS*	00000000 _fbss


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
src/self.c:26
	prefetch(ptr);
	register int HI = rdftag(ptr)>=HIMEM ? HIMEM : 0;
	register int i = 0;
	register int k = ptr[0] == link;
	if (k){
 4dc:	81030000 	lb	v1,0(t0)
 4e0:	00000000 	nop
 4e4:	106600b0 	beq	v1,a2,7a8 <__start+0x2f8>
 4e8:	28a20002 	slti	v0,a1,2
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
 4ec:	14a0001d 	bnez	a1,564 <__start+0xb4>
 4f0:	24020001 	li	v0,1
src/self.c:55
			while(1){
				ptr[i] = link;
 4f4:	00063600 	sll	a2,a2,0x18
 4f8:	00063603 	sra	a2,a2,0x18
 4fc:	25030002 	addiu	v1,t0,2
 500:	25020001 	addiu	v0,t0,1
 504:	a1060000 	sb	a2,0(t0)
src/self.c:56
				ptr[20+i] = link;
 508:	a1060014 	sb	a2,20(t0)
src/self.c:57
				ptr[40+i++] = link;
 50c:	a1060028 	sb	a2,40(t0)
src/self.c:55
 510:	a1060001 	sb	a2,1(t0)
 514:	24050010 	li	a1,16
src/self.c:57
 518:	a0460028 	sb	a2,40(v0)
src/self.c:56
 51c:	a0460014 	sb	a2,20(v0)
src/self.c:55
 520:	a1060002 	sb	a2,2(t0)
src/self.c:57
 524:	a0660028 	sb	a2,40(v1)
src/self.c:56
 528:	a0660014 	sb	a2,20(v1)
src/self.c:57
 52c:	24030003 	li	v1,3
src/self.c:55
 530:	01031021 	addu	v0,t0,v1
src/self.c:57
 534:	24630001 	addiu	v1,v1,1
 538:	a0460028 	sb	a2,40(v0)
src/self.c:55
 53c:	a0460000 	sb	a2,0(v0)
src/self.c:58
				if (i == 16){
 540:	1465fffb 	bne	v1,a1,530 <__start+0x80>
 544:	a0460014 	sb	a2,20(v0)
src/self.c:59
					ptr += 2*CACHE_LINE;
 548:	25080200 	addiu	t0,t0,512
src/self.c:61
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
src/self.c:65
					prefetch(ptr+2*CACHE_LINE+1);
				}
			}
		} else if (core_id == 1){
 564:	10a20060 	beq	a1,v0,6e8 <__start+0x238>
 568:	24020002 	li	v0,2
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
 56c:	10a20034 	beq	a1,v0,640 <__start+0x190>
 570:	00002021 	move	a0,zero
 574:	00063600 	sll	a2,a2,0x18
 578:	00063603 	sra	a2,a2,0x18
 57c:	00002821 	move	a1,zero
src/self.c:110
			//register unsigned long long stalls = 0;
			//register char* where = ptr;
			while(1){
				ptr[60+i] = link;
				ptr[71+i] = link;
				ptr[82+i] = link;
				ptr[100+i++] = link;
				if (i==11){
					i = 0;
//					register char* tag = (char*)rdftag(ptr);
//					ptr = tag ? cache_align(tag)-HI : ptr + 2*CACHE_LINE;
					register unsigned int tag = cache_align(rdftag(ptr));
										//printf("%x\n",tag);
										ptr = tag > HOME_DATA_START && tag < HOME_DATA_END ? tag: ptr + 2*CACHE_LINE;
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
 580:	01041021 	addu	v0,t0,a0
src/self.c:114
				ptr[71+i] = link;
				ptr[82+i] = link;
				ptr[100+i++] = link;
				if (i==10){
 584:	2403000a 	li	v1,10
src/self.c:113
 588:	24840001 	addiu	a0,a0,1
 58c:	a0460064 	sb	a2,100(v0)
src/self.c:110
 590:	a046003c 	sb	a2,60(v0)
src/self.c:111
 594:	a0460047 	sb	a2,71(v0)
src/self.c:114
 598:	1483fff9 	bne	a0,v1,580 <__start+0xd0>
 59c:	a0460052 	sb	a2,82(v0)
src/self.c:116
					i = 0;
					if (k++ == 20){
 5a0:	24a50001 	addiu	a1,a1,1
 5a4:	24020015 	li	v0,21
 5a8:	10a20015 	beq	a1,v0,600 <__start+0x150>
 5ac:	3c02000f 	lui	v0,0xf
rdftag():
src/flamewar.h:490

__attribute__ ((unused)) static unsigned int rdftag(void *ptr) {
  /* invoke system call number 18 */
  register unsigned int ret asm("v0");
  register void *arg asm("a0") = ptr;
 5b0:	01002021 	move	a0,t0
src/flamewar.h:491
  asm __volatile__ (
 5b4:	24020012 	li	v0,18
 5b8:	0000000c 	syscall
__start():
src/self.c:125
						ptr[120] = link;
						for (k = 0; k < TAUNT_SIZE/2; k++) {
							if (HOME_STATUS->taunt[k] >= 0) {
								hammer(HOME_STATUS->taunt[k]);
							}
						}
						k = 0;
					}
					register unsigned int tag = cache_align(rdftag(ptr));
 5bc:	3c037fff 	lui	v1,0x7fff
 5c0:	3463ff00 	ori	v1,v1,0xff00
 5c4:	00432024 	and	a0,v0,v1
src/self.c:127
					//printf("%x\n",tag);
					ptr = tag > HOME_DATA_START && tag < HOME_DATA_END ? tag: ptr + 2*CACHE_LINE;
 5c8:	3c02ffef 	lui	v0,0xffef
 5cc:	3442ffff 	ori	v0,v0,0xffff
 5d0:	3c0301ef 	lui	v1,0x1ef
 5d4:	00821021 	addu	v0,a0,v0
 5d8:	3463fffe 	ori	v1,v1,0xfffe
 5dc:	0043102b 	sltu	v0,v0,v1
 5e0:	14400004 	bnez	v0,5f4 <__start+0x144>
 5e4:	00000000 	nop
 5e8:	25080200 	addiu	t0,t0,512
 5ec:	08000160 	j	580 <__start+0xd0>
 5f0:	00002021 	move	a0,zero
 5f4:	00804021 	move	t0,a0
 5f8:	08000160 	j	580 <__start+0xd0>
 5fc:	00002021 	move	a0,zero
src/self.c:117
 600:	a1060078 	sb	a2,120(t0)
 604:	3447ff00 	ori	a3,v0,0xff00
 608:	00001821 	move	v1,zero
 60c:	24050072 	li	a1,114
src/self.c:119
 610:	00671021 	addu	v0,v1,a3
 614:	8044001c 	lb	a0,28(v0)
 618:	00000000 	nop
 61c:	04800003 	bltz	a0,62c <__start+0x17c>
 620:	00000000 	nop
hammer():
src/flamewar.h:417
__attribute__ ((unused)) static int hammer(int id) {
  /* invoke system call number 12 */
  register int ret asm("v0");
  register int arg asm("a0") = id;
  asm __volatile__ (
 624:	2402000c 	li	v0,12
 628:	0000000c 	syscall
__start():
src/self.c:118
 62c:	24630001 	addiu	v1,v1,1
 630:	1465fff8 	bne	v1,a1,614 <__start+0x164>
 634:	00671021 	addu	v0,v1,a3
 638:	0800016c 	j	5b0 <__start+0x100>
 63c:	00002821 	move	a1,zero
src/self.c:90
 640:	00063600 	sll	a2,a2,0x18
 644:	00063603 	sra	a2,a2,0x18
 648:	25020001 	addiu	v0,t0,1
 64c:	a106003c 	sb	a2,60(t0)
src/self.c:91
 650:	a1060047 	sb	a2,71(t0)
src/self.c:92
 654:	a1060052 	sb	a2,82(t0)
src/self.c:93
 658:	a1060064 	sb	a2,100(t0)
src/self.c:90
 65c:	25030002 	addiu	v1,t0,2
src/self.c:93
 660:	a0460064 	sb	a2,100(v0)
src/self.c:90
 664:	a046003c 	sb	a2,60(v0)
src/self.c:91
 668:	a0460047 	sb	a2,71(v0)
src/self.c:92
 66c:	a0460052 	sb	a2,82(v0)
 670:	3c027fff 	lui	v0,0x7fff
src/self.c:93
 674:	a0660064 	sb	a2,100(v1)
src/self.c:90
 678:	a066003c 	sb	a2,60(v1)
src/self.c:91
 67c:	a0660047 	sb	a2,71(v1)
src/self.c:92
 680:	a0660052 	sb	a2,82(v1)
 684:	3449ff00 	ori	t1,v0,0xff00
 688:	3c03ffef 	lui	v1,0xffef
 68c:	3c0201ef 	lui	v0,0x1ef
 690:	3463ffff 	ori	v1,v1,0xffff
 694:	344afffe 	ori	t2,v0,0xfffe
src/self.c:93
 698:	24050003 	li	a1,3
 69c:	2407000b 	li	a3,11
src/self.c:90
 6a0:	00a81021 	addu	v0,a1,t0
src/self.c:93
 6a4:	24a50001 	addiu	a1,a1,1
rdftag():
src/flamewar.h:490

__attribute__ ((unused)) static unsigned int rdftag(void *ptr) {
  /* invoke system call number 18 */
  register unsigned int ret asm("v0");
  register void *arg asm("a0") = ptr;
 6a8:	01002021 	move	a0,t0
__start():
src/self.c:93
 6ac:	a0460064 	sb	a2,100(v0)
src/self.c:90
 6b0:	a046003c 	sb	a2,60(v0)
src/self.c:91
 6b4:	a0460047 	sb	a2,71(v0)
src/self.c:94
 6b8:	14a7fff9 	bne	a1,a3,6a0 <__start+0x1f0>
 6bc:	a0460052 	sb	a2,82(v0)
rdftag():
src/flamewar.h:491
__attribute__ ((unused)) static unsigned int rdftag(void *ptr) {
  /* invoke system call number 18 */
  register unsigned int ret asm("v0");
  register void *arg asm("a0") = ptr;
  asm __volatile__ (
 6c0:	24020012 	li	v0,18
 6c4:	0000000c 	syscall
__start():
src/self.c:98
 6c8:	00492024 	and	a0,v0,t1
src/self.c:100
 6cc:	00831021 	addu	v0,a0,v1
 6d0:	004a102b 	sltu	v0,v0,t2
 6d4:	25080200 	addiu	t0,t0,512
 6d8:	1040fff1 	beqz	v0,6a0 <__start+0x1f0>
 6dc:	00002821 	move	a1,zero
 6e0:	080001a8 	j	6a0 <__start+0x1f0>
 6e4:	00804021 	move	t0,a0
src/self.c:68
 6e8:	00065600 	sll	t2,a2,0x18
 6ec:	000a5603 	sra	t2,t2,0x18
 6f0:	25040002 	addiu	a0,t0,2
 6f4:	25020001 	addiu	v0,t0,1
 6f8:	3c03000f 	lui	v1,0xf
 6fc:	a10a0000 	sb	t2,0(t0)
src/self.c:69
 700:	a10a0014 	sb	t2,20(t0)
src/self.c:70
 704:	a10a0028 	sb	t2,40(t0)
src/self.c:68
 708:	a10a0001 	sb	t2,1(t0)
 70c:	3463ff00 	ori	v1,v1,0xff00
src/self.c:70
 710:	a04a0028 	sb	t2,40(v0)
src/self.c:69
 714:	a04a0014 	sb	t2,20(v0)
 718:	240b0010 	li	t3,16
src/self.c:68
 71c:	a10a0002 	sb	t2,2(t0)
src/self.c:70
 720:	a08a0028 	sb	t2,40(a0)
src/self.c:69
 724:	a08a0014 	sb	t2,20(a0)
src/self.c:70
 728:	24040003 	li	a0,3
src/self.c:68
 72c:	00881021 	addu	v0,a0,t0
src/self.c:70
 730:	24840001 	addiu	a0,a0,1
 734:	a04a0028 	sb	t2,40(v0)
src/self.c:68
 738:	a04a0000 	sb	t2,0(v0)
src/self.c:71
 73c:	148bfffb 	bne	a0,t3,72c <__start+0x27c>
 740:	a04a0014 	sb	t2,20(v0)
src/self.c:73
 744:	81020078 	lb	v0,120(t0)
 748:	00000000 	nop
 74c:	10c20008 	beq	a2,v0,770 <__start+0x2c0>
 750:	24050072 	li	a1,114
src/self.c:80
 754:	25080200 	addiu	t0,t0,512
src/self.c:82
 758:	a10a0000 	sb	t2,0(t0)
prefetch():
src/flamewar.h:439
}

__attribute__ ((unused)) static void prefetch(void *ptr) {
  /* invoke system call number 14 */
  register void *arg asm("a0") = ptr;
 75c:	25040201 	addiu	a0,t0,513
src/flamewar.h:440
  asm __volatile__ (
 760:	2402000e 	li	v0,14
 764:	0000000c 	syscall
 768:	080001cb 	j	72c <__start+0x27c>
 76c:	00002021 	move	a0,zero
 770:	00604821 	move	t1,v1
 774:	240700e4 	li	a3,228
__start():
src/self.c:75
 778:	00a91021 	addu	v0,a1,t1
 77c:	8044001c 	lb	a0,28(v0)
 780:	00000000 	nop
 784:	04800003 	bltz	a0,794 <__start+0x2e4>
 788:	00000000 	nop
hammer():
src/flamewar.h:417
__attribute__ ((unused)) static int hammer(int id) {
  /* invoke system call number 12 */
  register int ret asm("v0");
  register int arg asm("a0") = id;
  asm __volatile__ (
 78c:	2402000c 	li	v0,12
 790:	0000000c 	syscall
__start():
src/self.c:74
 794:	24a50001 	addiu	a1,a1,1
 798:	14a7fff8 	bne	a1,a3,77c <__start+0x2cc>
 79c:	00a91021 	addu	v0,a1,t1
src/self.c:80
 7a0:	080001d6 	j	758 <__start+0x2a8>
 7a4:	25080200 	addiu	t0,t0,512
src/self.c:27
 7a8:	1440001c 	bnez	v0,81c <__start+0x36c>
 7ac:	25020001 	addiu	v0,t0,1
src/self.c:42
 7b0:	00063600 	sll	a2,a2,0x18
 7b4:	00063603 	sra	a2,a2,0x18
 7b8:	25030002 	addiu	v1,t0,2
 7bc:	a10600aa 	sb	a2,170(t0)
src/self.c:43
 7c0:	a10600b9 	sb	a2,185(t0)
src/self.c:44
 7c4:	a10600c4 	sb	a2,196(t0)
src/self.c:45
 7c8:	a10600d2 	sb	a2,210(t0)
 7cc:	24040003 	li	a0,3
 7d0:	a04600d2 	sb	a2,210(v0)
src/self.c:42
 7d4:	a04600aa 	sb	a2,170(v0)
src/self.c:43
 7d8:	a04600b9 	sb	a2,185(v0)
src/self.c:44
 7dc:	a04600c4 	sb	a2,196(v0)
src/self.c:45
 7e0:	a06600d2 	sb	a2,210(v1)
src/self.c:42
 7e4:	a06600aa 	sb	a2,170(v1)
src/self.c:43
 7e8:	a06600b9 	sb	a2,185(v1)
src/self.c:44
 7ec:	a06600c4 	sb	a2,196(v1)
src/self.c:42
 7f0:	00881021 	addu	v0,a0,t0
src/self.c:46
 7f4:	2403000c 	li	v1,12
src/self.c:45
 7f8:	24840001 	addiu	a0,a0,1
 7fc:	a04600d2 	sb	a2,210(v0)
src/self.c:42
 800:	a04600aa 	sb	a2,170(v0)
src/self.c:43
 804:	a04600b9 	sb	a2,185(v0)
src/self.c:46
 808:	1483fff9 	bne	a0,v1,7f0 <__start+0x340>
 80c:	a04600c4 	sb	a2,196(v0)
src/self.c:47
 810:	25080200 	addiu	t0,t0,512
 814:	080001fc 	j	7f0 <__start+0x340>
 818:	00002021 	move	a0,zero
src/self.c:29
 81c:	00063600 	sll	a2,a2,0x18
 820:	00063603 	sra	a2,a2,0x18
 824:	25030002 	addiu	v1,t0,2
 828:	a106006e 	sb	a2,110(t0)
src/self.c:30
 82c:	a1060082 	sb	a2,130(t0)
src/self.c:31
 830:	a1060096 	sb	a2,150(t0)
 834:	24050010 	li	a1,16
 838:	a0460096 	sb	a2,150(v0)
src/self.c:29
 83c:	a046006e 	sb	a2,110(v0)
src/self.c:30
 840:	a0460082 	sb	a2,130(v0)
src/self.c:31
 844:	a0660096 	sb	a2,150(v1)
src/self.c:29
 848:	a066006e 	sb	a2,110(v1)
src/self.c:30
 84c:	a0660082 	sb	a2,130(v1)
src/self.c:31
 850:	24030003 	li	v1,3
src/self.c:29
 854:	01031021 	addu	v0,t0,v1
src/self.c:31
 858:	24630001 	addiu	v1,v1,1
 85c:	a0460096 	sb	a2,150(v0)
src/self.c:29
 860:	a046006e 	sb	a2,110(v0)
src/self.c:32
 864:	1465fffb 	bne	v1,a1,854 <__start+0x3a4>
 868:	a0460082 	sb	a2,130(v0)
src/self.c:33
 86c:	25080200 	addiu	t0,t0,512
src/self.c:35
 870:	a1060000 	sb	a2,0(t0)
prefetch():
src/flamewar.h:439
}

__attribute__ ((unused)) static void prefetch(void *ptr) {
  /* invoke system call number 14 */
  register void *arg asm("a0") = ptr;
 874:	25040201 	addiu	a0,t0,513
src/flamewar.h:440
  asm __volatile__ (
 878:	2402000e 	li	v0,14
 87c:	0000000c 	syscall
 880:	08000215 	j	854 <__start+0x3a4>
 884:	24030001 	li	v1,1
	...
