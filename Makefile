# -------------------------------------------------------
all: src
# -------------------------------------------------------
CC       = gcc
SHELL    = /bin/bash
CFLAGS  += -O2 -Wall -Werror -fPIC -I/usr/include/lua/5.1 -I/usr/include/lua5.1 -iquote.. -iquote../..
LDFLAGS += -shared
# -------------------------------------------------------
INST_PREFIX  = /usr/local
INST_BINDIR  = $(INST_PREFIX)/bin
INST_CONFDIR = $(INST_PREFIX)/etc
INST_LIBDIR  = $(INST_PREFIX)/lib/lua/5.1
INST_LUADIR  = $(INST_PREFIX)/share/lua/5.1
# -------------------------------------------------------
CFILES   := $(wildcard src/*.c)
OBJS     := $(CFILES:.c=.o)
DFILES   := $(CFILES:.c=.d)
LUAFILES := $(wildcard src/*.lua)
# -------------------------------------------------------
TARGSO := LuaBase64/c.so
TARGA  := LuaBase64/c.a
# -------------------------------------------------------
src: $(TARGSO) $(TARGA)
# -------------------------------------------------------
$(TARGA): $(OBJS)
	mkdir -pv $(dir $@)
	ar rc $@ $(OBJS)
# -------------------------------------------------------
$(TARGSO): $(OBJS)
	mkdir -pv $(dir $@)
	$(CC) $(LDFLAGS) -o $@ $(OBJS)
# -------------------------------------------------------
install: $(TARGSO) installlua installlib
# -------------------------------------------------------
installlua: $(LUAFILES)
	cp -v $< $(INST_LUADIR)/
# -------------------------------------------------------
installlib: $(TARGSO)
	mkdir -pv $(INST_LIBDIR)/LuaBase64
	cp -v $< $(INST_LIBDIR)/LuaBase64/
# -------------------------------------------------------
clean:
	rm -vf $(OBJS) $(TARGSO) $(TARGA)
# -------------------------------------------------------
.PHONY: clean install
# -------------------------------------------------------
