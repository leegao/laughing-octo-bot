# List of bots to compile.
SOURCES := $(wildcard src/*.c)
ASSEMBLIES := $(patsubst src/%.c, src/%.s, $(SOURCES))
OBJECTS := $(patsubst src/%.c, obj/%.o, $(SOURCES))
TARGETS := $(patsubst src/%.c, bin/%, $(SOURCES))

# Path to the compiler.
CCTMP := $(shell which mipsel-linux-gnu-gcc 2> /dev/null)
ifdef CCTMP
	CC = mipsel-linux-gnu-gcc
else
	#CC=/courses/cs3410/mipsel-linux/bin/mipsel-linux-gcc
	CC = mipsel-linux-gcc
endif

# Turn on all warnings.
COMMONFLAGS += -Wall 

# Turn on all compiler optimizations for the standard bots.  You can add your
# bot to this list to turn on optimizations.
#
# BEWARE: This can cause your code to do very unexpected things, such as
# optimize away entire loops if the compiler doesn't think they are important.
# It also can make debugging very tricky, as the compiler will re-order
# statements as it sees fit. 
#
# You will almost certainly need to examine the assembly code produced under
# optimizations, especially wherever you use inline assembly. The "flamewar.h"
# header file, for example, required lots of cruft to convince the compiler to
# not optimize away system calls, to optimize away the initialization of
# argument registers, or to reorder inline assembly in unexpected ways.
#
FLAGS_noop = -O3
FLAGS_fbi = -O3
FLAGS_greedy = -O3
FLAGS_taunter = -O3
FLAGS_titfortat = -O3
FLAGS_self = -O5 -g

#
# You probably will not need to modify anything below here
#

# Tell compiler to disable normal system calls, dynamic libraries, indirect jumping, etc.
COMMONFLAGS += -static -mno-xgot -mno-abicalls -G 0 -Wa,-non_shared 

# Link options: Tell linker to disable normal system libraries, and use
# flamewar's unusual program layout.
LINKFLAGS = $(FLAGS) -nostartfiles -nodefaultlibs -Wl,-T,src/flamewar.x

FLAGS = $(COMMONFLAGS) $(FLAGS_$(basename $(notdir $@)))

# 'make' or 'make all' compiles everything
all: $(TARGETS)

# 'make <botname>' compiles and links just one bot
$(TARGETS): bin/%: obj/%.o src/flamewar.x Makefile src/flamewar.h
	$(CC) $(LINKFLAGS) $< -o $@

# 'make <name>.o' just compiles and assembles one file, but does not link
$(OBJECTS): obj/%.o: src/%.c src/flamewar.h Makefile
	$(CC) $(FLAGS) -c $< -o $@

# 'make <name>.s' just compiles that file, but does not assemble or link
$(ASSEMBLIES): src/%.s: src/%.c src/flamewar.h Makefile
	$(CC) $(FLAGS) -S $< -o $@

# 'make clean' deletes everything that has been compiled
clean:
	rm -f obj/*.o bin/*
