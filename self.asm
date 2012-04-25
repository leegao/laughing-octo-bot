
bin/self:     file format elf32-tradlittlemips
bin/self
architecture: mips:3000, flags 0x00000112:
EXEC_P, HAS_SYMS, D_PAGED
start address 0x000004b0

Program Header:
0x70000000 off    0x00000494 vaddr 0x00000494 paddr 0x00000494 align 2**2
         filesz 0x00000018 memsz 0x00000018 flags r--
    LOAD off    0x00000000 vaddr 0x00000000 paddr 0x00000000 align 2**16
         filesz 0x00000780 memsz 0x00000780 flags r-x
private flags = 1001: [abi=O32] [mips1] [not 32bitmode]

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .reginfo      00000018  00000494  00000494  00000494  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA, LINK_ONCE_DISCARD
  1 .text         000002d0  000004b0  000004b0  000004b0  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  2 .comment      00000012  00000000  00000000  00000780  2**0
                  CONTENTS, READONLY
  3 .debug_aranges 00000020  00000000  00000000  00000792  2**0
                  CONTENTS, READONLY, DEBUGGING
  4 .debug_pubnames 0000001e  00000000  00000000  000007b2  2**0
                  CONTENTS, READONLY, DEBUGGING
  5 .debug_info   00000320  00000000  00000000  000007d0  2**0
                  CONTENTS, READONLY, DEBUGGING
  6 .debug_abbrev 00000126  00000000  00000000  00000af0  2**0
                  CONTENTS, READONLY, DEBUGGING
  7 .debug_line   000000fa  00000000  00000000  00000c16  2**0
                  CONTENTS, READONLY, DEBUGGING
  8 .debug_frame  00000020  00000000  00000000  00000d10  2**2
                  CONTENTS, READONLY, DEBUGGING
  9 .debug_str    000000ae  00000000  00000000  00000d30  2**0
                  CONTENTS, READONLY, DEBUGGING
 10 .debug_loc    00000269  00000000  00000000  00000dde  2**0
                  CONTENTS, READONLY, DEBUGGING
 11 .mdebug.abi32 00000000  00000269  00000269  00001047  2**0
                  CONTENTS, READONLY
 12 .pdr          00000020  00000000  00000000  00001048  2**2
                  CONTENTS, READONLY
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
00000269 l    d  .mdebug.abi32	00000000 .mdebug.abi32
00000000 l    d  .pdr	00000000 .pdr
00000000 l    d  *ABS*	00000000 .shstrtab
00000000 l    d  *ABS*	00000000 .symtab
00000000 l    d  *ABS*	00000000 .strtab
00000000 l    df *ABS*	00000000 src/self.c
00100780 g       *ABS*	00000000 _fdata
00108770 g       *ABS*	00000000 _gp
000004b0 g     F .text	000002c8 __start
000004b0 g       .text	00000000 _ftext
00100780 g       *ABS*	00000000 __bss_start
00100780 g       *ABS*	00000000 _edata
00100780 g       *ABS*	00000000 _end
00100780 g       *ABS*	00000000 _fbss


Disassembly of section .text:

000004b0 <__start>:
__start():
src/self.c:20
	// core0 = line 0
	// core1 = line 1
	// at a rate of (247/248)^175 \approx 0.5, we can 'safely' be in troll mode
	// approximately 175 cycles if we detect the taunt array on one of the lines
	register char *ptr = (char *)(HOME_DATA_SEGMENT) + (core_id&1)*CACHE_LINE+1;
 4b0:	30820001 	andi	v0,a0,0x1
 4b4:	3c030010 	lui	v1,0x10
 4b8:	00022a00 	sll	a1,v0,0x8
 4bc:	34630001 	ori	v1,v1,0x1
 4c0:	00a34021 	addu	t0,a1,v1
src/self.c:15
 4c4:	00806021 	move	t4,a0
 4c8:	30c600ff 	andi	a2,a2,0xff
prefetch():
src/flamewar.h:439
}

__attribute__ ((unused)) static void prefetch(void *ptr) {
  /* invoke system call number 14 */
  register void *arg asm("a0") = ptr;
 4cc:	01002021 	move	a0,t0
src/flamewar.h:440
  asm __volatile__ (
 4d0:	2402000e 	li	v0,14
 4d4:	0000000c 	syscall
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
 4d8:	24020012 	li	v0,18
 4dc:	0000000c 	syscall
__start():
src/self.c:25
	prefetch(ptr);
	register int VADDR = (int)(ptr-(rdftag(ptr)-1));
	register int i = 0;
	register int k = ptr[0] == link;
	if (k){
 4e0:	81030000 	lb	v1,0(t0)
 4e4:	00000000 	nop
 4e8:	10660067 	beq	v1,a2,688 <__start+0x1d8>
 4ec:	00402021 	move	a0,v0
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
					prefetch(ptr+2*CACHE_LINE);
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
		if (core_id < 2){
 4f0:	29820002 	slti	v0,t4,2
 4f4:	14400033 	bnez	v0,5c4 <__start+0x114>
 4f8:	01041023 	subu	v0,t0,a0
src/self.c:78

			while(1){
				ptr[i] = link;
				ptr[20+i] = link;
				ptr[40+i++] = link;
				if (i == 14){
					register char x = ptr[120];
					if (core_id == 1 && x == link){
						for (k = TAUNT_SIZE/2; k < TAUNT_SIZE; k++) {
							if (HOME_STATUS->taunt[k] >= 0) {
							  hammer(HOME_STATUS->taunt[k]);
							}
						}
					}
					ptr += 2*CACHE_LINE;
					i = 1;
					ptr[0] = link;
					prefetch(ptr+2*CACHE_LINE);
				}
			}
		} else {
			//ptr = (char *)(HOME_DATA_SEGMENT) + (core_id&1)*CACHE_LINE;
			//printf("%x\n",VADDR|(int)ptr);
			k = 0;
			register unsigned long long stalls = 0;
			register char* where = (char*)(VADDR |(int)ptr);
 4fc:	24420001 	addiu	v0,v0,1
 500:	00485025 	or	t2,v0,t0
 504:	00063600 	sll	a2,a2,0x18
 508:	3c02000f 	lui	v0,0xf
 50c:	00063603 	sra	a2,a2,0x18
 510:	344eff00 	ori	t6,v0,0xff00
 514:	00001821 	move	v1,zero
 518:	00002821 	move	a1,zero
 51c:	2409000a 	li	t1,10
 520:	240b0003 	li	t3,3
 524:	240d000b 	li	t5,11
src/self.c:80
			while(1){
				ptr[60+i] = link;
 528:	01031021 	addu	v0,t0,v1
src/self.c:83
				ptr[71+i] = link;
				ptr[82+i] = link;
				ptr[100+i++] = link;
 52c:	24630001 	addiu	v1,v1,1
 530:	a0460064 	sb	a2,100(v0)
src/self.c:80
 534:	a046003c 	sb	a2,60(v0)
src/self.c:81
 538:	a0460047 	sb	a2,71(v0)
src/self.c:84
				if (i==10){
 53c:	1469fffa 	bne	v1,t1,528 <__start+0x78>
 540:	a0460052 	sb	a2,82(v0)
rdftag():
src/flamewar.h:490

__attribute__ ((unused)) static unsigned int rdftag(void *ptr) {
  /* invoke system call number 18 */
  register unsigned int ret asm("v0");
  register void *arg asm("a0") = ptr;
 544:	01402021 	move	a0,t2
src/flamewar.h:491
  asm __volatile__ (
 548:	24020012 	li	v0,18
 54c:	0000000c 	syscall
__start():
src/self.c:86
					char* tag = (char*)rdftag(where);
					ptr = tag ? tag : ptr + 2*CACHE_LINE;
 550:	10400018 	beqz	v0,5b4 <__start+0x104>
 554:	00000000 	nop
src/self.c:89
					//ptr = ptr + 2*CACHE_LINE;// + 2*CACHE_LINE;
					i = 0;
					if (core_id == 3 && k++ == 10){
 558:	118b0003 	beq	t4,t3,568 <__start+0xb8>
 55c:	00404021 	move	t0,v0
src/self.c:78
 560:	0800014a 	j	528 <__start+0x78>
 564:	00001821 	move	v1,zero
src/self.c:89
 568:	24a50001 	addiu	a1,a1,1
 56c:	14adffee 	bne	a1,t5,528 <__start+0x78>
 570:	00001821 	move	v1,zero
src/self.c:98

						// check stall performance
//						register unsigned long long delta = rdperf(PERF_CSC)-stalls;
//						stalls += delta;
//						if (delta > 400){
//
//						}
						// go into taunt checking mode
						ptr[120] = link;
 574:	a1060078 	sb	a2,120(t0)
 578:	01c03821 	move	a3,t6
 57c:	24050072 	li	a1,114
src/self.c:100
						for (k = 0; k < TAUNT_SIZE/2; k++) {
							if (HOME_STATUS->taunt[k] >= 0) {
 580:	00671021 	addu	v0,v1,a3
 584:	8044001c 	lb	a0,28(v0)
 588:	00000000 	nop
 58c:	04800003 	bltz	a0,59c <__start+0xec>
 590:	00000000 	nop
hammer():
src/flamewar.h:417
__attribute__ ((unused)) static int hammer(int id) {
  /* invoke system call number 12 */
  register int ret asm("v0");
  register int arg asm("a0") = id;
  asm __volatile__ (
 594:	2402000c 	li	v0,12
 598:	0000000c 	syscall
__start():
src/self.c:99
 59c:	24630001 	addiu	v1,v1,1
 5a0:	1465fff8 	bne	v1,a1,584 <__start+0xd4>
 5a4:	00671021 	addu	v0,v1,a3
 5a8:	00001821 	move	v1,zero
 5ac:	0800014a 	j	528 <__start+0x78>
 5b0:	00002821 	move	a1,zero
src/self.c:89
 5b4:	158bffea 	bne	t4,t3,560 <__start+0xb0>
 5b8:	25080200 	addiu	t0,t0,512
 5bc:	0800015b 	j	56c <__start+0xbc>
 5c0:	24a50001 	addiu	a1,a1,1
src/self.c:55
 5c4:	00062e00 	sll	a1,a2,0x18
 5c8:	00052e03 	sra	a1,a1,0x18
 5cc:	25020001 	addiu	v0,t0,1
 5d0:	25030002 	addiu	v1,t0,2
 5d4:	a1050000 	sb	a1,0(t0)
src/self.c:56
 5d8:	a1050014 	sb	a1,20(t0)
src/self.c:57
 5dc:	a1050028 	sb	a1,40(t0)
src/self.c:55
 5e0:	a1050001 	sb	a1,1(t0)
src/self.c:57
 5e4:	24040003 	li	a0,3
 5e8:	a0450028 	sb	a1,40(v0)
src/self.c:56
 5ec:	a0450014 	sb	a1,20(v0)
src/self.c:55
 5f0:	a1050002 	sb	a1,2(t0)
src/self.c:57
 5f4:	a0650028 	sb	a1,40(v1)
src/self.c:56
 5f8:	a0650014 	sb	a1,20(v1)
src/self.c:55
 5fc:	00881021 	addu	v0,a0,t0
src/self.c:58
 600:	2403000e 	li	v1,14
src/self.c:57
 604:	24840001 	addiu	a0,a0,1
 608:	a0450028 	sb	a1,40(v0)
src/self.c:55
 60c:	a0450000 	sb	a1,0(v0)
src/self.c:58
 610:	1483fffa 	bne	a0,v1,5fc <__start+0x14c>
 614:	a0450014 	sb	a1,20(v0)
src/self.c:60
 618:	24020001 	li	v0,1
src/self.c:59
 61c:	81030078 	lb	v1,120(t0)
src/self.c:60
 620:	11820008 	beq	t4,v0,644 <__start+0x194>
 624:	00000000 	nop
src/self.c:67
 628:	25080200 	addiu	t0,t0,512
src/self.c:69
 62c:	a1050000 	sb	a1,0(t0)
prefetch():
src/flamewar.h:439
}

__attribute__ ((unused)) static void prefetch(void *ptr) {
  /* invoke system call number 14 */
  register void *arg asm("a0") = ptr;
 630:	25040200 	addiu	a0,t0,512
src/flamewar.h:440
  asm __volatile__ (
 634:	2402000e 	li	v0,14
 638:	0000000c 	syscall
 63c:	0800017f 	j	5fc <__start+0x14c>
 640:	24040001 	li	a0,1
__start():
src/self.c:60
 644:	14c3fff8 	bne	a2,v1,628 <__start+0x178>
 648:	3c02000f 	lui	v0,0xf
 64c:	3449ff00 	ori	t1,v0,0xff00
 650:	24030072 	li	v1,114
 654:	240700e4 	li	a3,228
src/self.c:62
 658:	00691021 	addu	v0,v1,t1
 65c:	8044001c 	lb	a0,28(v0)
 660:	00000000 	nop
 664:	04800003 	bltz	a0,674 <__start+0x1c4>
 668:	00000000 	nop
hammer():
src/flamewar.h:417
__attribute__ ((unused)) static int hammer(int id) {
  /* invoke system call number 12 */
  register int ret asm("v0");
  register int arg asm("a0") = id;
  asm __volatile__ (
 66c:	2402000c 	li	v0,12
 670:	0000000c 	syscall
__start():
src/self.c:61
 674:	24630001 	addiu	v1,v1,1
 678:	1467fff8 	bne	v1,a3,65c <__start+0x1ac>
 67c:	00691021 	addu	v0,v1,t1
src/self.c:67
 680:	0800018b 	j	62c <__start+0x17c>
 684:	25080200 	addiu	t0,t0,512
src/self.c:26
 688:	29820002 	slti	v0,t4,2
 68c:	1440001e 	bnez	v0,708 <__start+0x258>
 690:	3c020010 	lui	v0,0x10
src/self.c:39
 694:	00a22021 	addu	a0,a1,v0
src/self.c:41
 698:	00063600 	sll	a2,a2,0x18
 69c:	00063603 	sra	a2,a2,0x18
 6a0:	24830002 	addiu	v1,a0,2
 6a4:	24820001 	addiu	v0,a0,1
 6a8:	a08600aa 	sb	a2,170(a0)
src/self.c:42
 6ac:	a08600b9 	sb	a2,185(a0)
src/self.c:43
 6b0:	a08600c4 	sb	a2,196(a0)
src/self.c:44
 6b4:	a08600d2 	sb	a2,210(a0)
 6b8:	2405000c 	li	a1,12
 6bc:	a04600d2 	sb	a2,210(v0)
src/self.c:41
 6c0:	a04600aa 	sb	a2,170(v0)
src/self.c:42
 6c4:	a04600b9 	sb	a2,185(v0)
src/self.c:43
 6c8:	a04600c4 	sb	a2,196(v0)
src/self.c:44
 6cc:	a06600d2 	sb	a2,210(v1)
src/self.c:41
 6d0:	a06600aa 	sb	a2,170(v1)
src/self.c:42
 6d4:	a06600b9 	sb	a2,185(v1)
src/self.c:43
 6d8:	a06600c4 	sb	a2,196(v1)
src/self.c:44
 6dc:	24030003 	li	v1,3
src/self.c:41
 6e0:	00641021 	addu	v0,v1,a0
src/self.c:44
 6e4:	24630001 	addiu	v1,v1,1
 6e8:	a04600d2 	sb	a2,210(v0)
src/self.c:41
 6ec:	a04600aa 	sb	a2,170(v0)
src/self.c:42
 6f0:	a04600b9 	sb	a2,185(v0)
src/self.c:45
 6f4:	1465fffa 	bne	v1,a1,6e0 <__start+0x230>
 6f8:	a04600c4 	sb	a2,196(v0)
src/self.c:46
 6fc:	24840200 	addiu	a0,a0,512
 700:	080001b8 	j	6e0 <__start+0x230>
 704:	00001821 	move	v1,zero
src/self.c:28
 708:	00063600 	sll	a2,a2,0x18
 70c:	00063603 	sra	a2,a2,0x18
 710:	25030002 	addiu	v1,t0,2
 714:	25020001 	addiu	v0,t0,1
 718:	a106006e 	sb	a2,110(t0)
src/self.c:29
 71c:	a1060082 	sb	a2,130(t0)
src/self.c:30
 720:	a1060096 	sb	a2,150(t0)
 724:	24050010 	li	a1,16
 728:	a0460096 	sb	a2,150(v0)
src/self.c:28
 72c:	a046006e 	sb	a2,110(v0)
src/self.c:29
 730:	a0460082 	sb	a2,130(v0)
src/self.c:30
 734:	a0660096 	sb	a2,150(v1)
src/self.c:28
 738:	a066006e 	sb	a2,110(v1)
src/self.c:29
 73c:	a0660082 	sb	a2,130(v1)
src/self.c:30
 740:	24030003 	li	v1,3
src/self.c:28
 744:	00681021 	addu	v0,v1,t0
src/self.c:30
 748:	24630001 	addiu	v1,v1,1
 74c:	a0460096 	sb	a2,150(v0)
src/self.c:28
 750:	a046006e 	sb	a2,110(v0)
src/self.c:31
 754:	1465fffb 	bne	v1,a1,744 <__start+0x294>
 758:	a0460082 	sb	a2,130(v0)
src/self.c:32
 75c:	25080200 	addiu	t0,t0,512
src/self.c:34
 760:	a1060000 	sb	a2,0(t0)
prefetch():
src/flamewar.h:439
}

__attribute__ ((unused)) static void prefetch(void *ptr) {
  /* invoke system call number 14 */
  register void *arg asm("a0") = ptr;
 764:	25040200 	addiu	a0,t0,512
src/flamewar.h:440
  asm __volatile__ (
 768:	2402000e 	li	v0,14
 76c:	0000000c 	syscall
 770:	080001d1 	j	744 <__start+0x294>
 774:	24030001 	li	v1,1
	...
