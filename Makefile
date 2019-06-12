# -------------------------------------------------------
all: src
# -------------------------------------------------------
LUA_VERSION  ?= 5.1
INST_PREFIX  ?= /usr/local
# -------------------------------------------------------
INC_PREFIX   ?= /usr/include
INCDIRS      ?= $(INC_PREFIX)/lua/$(LUA_VERSION) $(INC_PREFIX)/usr/include/lua$(LUA_VERSION)
# -------------------------------------------------------
CC            = gcc
LDFLAGS      += -shared -fPIC
# -------------------------------------------------------
INST_BINDIR   = $(INST_PREFIX)/bin
INST_CONFDIR  = $(INST_PREFIX)/etc
INST_LIBDIR   = $(INST_PREFIX)/lib/lua/$(LUA_VERSION)
INST_LUADIR   = $(INST_PREFIX)/share/lua/$(LUA_VERSION)
# -------------------------------------------------------
CFLAGS       += -O2
CFLAGS       += -Wall
CFLAGS       += -Werror
CFLAGS       += -fPIC
# -------------------------------------------------------
CFLAGS       += $(INCDIRS:%=-I%)
# -------------------------------------------------------
LUAFILES     := $(wildcard src/*.lua)
CFILES       := $(wildcard src/*.c)
OBJS         := $(CFILES:.c=.o)
DFILES       := $(CFILES:.c=.d)
# -------------------------------------------------------
TARGSO       := LuaBase64/c.so
TARGAR       := LuaBase64/c.a
# -------------------------------------------------------
src: $(TARGSO) $(TARGAR)
# -------------------------------------------------------
$(TARGAR): $(OBJS)
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
	rm -vf $(OBJS) $(TARGSO) $(TARGAR)
# -------------------------------------------------------
.PHONY: clean install
# -------------------------------------------------------
