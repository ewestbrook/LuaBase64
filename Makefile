# -------------------------------------------------------
all: src
# -------------------------------------------------------
CC       = gcc
SHELL    = /bin/bash
CFLAGS  += -O0 -ggdb -Wall -Werror -fPIC -I/usr/include/lua/5.1 -I/usr/include/lua5.1 -iquote.. -iquote../..
LDFLAGS += -shared
# -------------------------------------------------------
INST_PREFIX  = /usr/local
INST_BINDIR  = $(INST_PREFIX)/bin
INST_CONFDIR = $(INST_PREFIX)/etc
INST_LIBDIR  = $(INST_PREFIX)/lib/lua/5.1
INST_LUADIR  = $(INST_PREFIX)/share/lua/5.1
# -------------------------------------------------------
CFILES   := $(wildcard $(shell find src -name "*.c"))
OBJS     := $(CFILES:.c=.o)
DFILES   := $(CFILES:.c=.d)
LUAFILES := $(wildcard src/*.lua)
# -------------------------------------------------------
src: c.so c.a
# -------------------------------------------------------
c.a: $(OBJS)
	ar rc $@ $(OBJS)
# -------------------------------------------------------
c.so: $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $(OBJS)
# -------------------------------------------------------
install: c.so
	mkdir -pv $(INST_LIBDIR)/luab64
	cp -v $< $(INST_LIBDIR)/luab64/
# -------------------------------------------------------
clean:
	@rm -vf $(shell find . -name '*.o' -o -name '*.so')
# -------------------------------------------------------
.PHONY: clean
# -------------------------------------------------------
