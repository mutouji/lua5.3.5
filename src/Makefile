# Makefile for building Lua
# See ../doc/readme.html for installation and customization instructions.

# == CHANGE THE SETTINGS BELOW TO SUIT YOUR ENVIRONMENT =======================

# Your platform. See PLATS for possible values.
PLAT= none


CC= gcc -std=gnu99
CFLAGS= -O2 -Wall -Wextra -DLUA_COMPAT_5_2 $(SYSCFLAGS) $(MYCFLAGS)
LDFLAGS= $(SYSLDFLAGS) $(MYLDFLAGS)
LIBS= -lm $(SYSLIBS) $(MYLIBS)

AR= ar rcu
RANLIB= ranlib
RM= rm -f

#ifeq ($(OS),Windows_NT)
#    OBJ_EXT=obj
#    LIB_EXT=lib
#    EXE_EXT=exe
#else
    OBJ_EXT=o
    LIB_EXT=a
    EXE_EXT=
#endif

SYSCFLAGS=
SYSLDFLAGS=
SYSLIBS=

MYCFLAGS=
MYLDFLAGS=
MYLIBS=
MYOBJS=

# == END OF USER SETTINGS -- NO NEED TO CHANGE ANYTHING BELOW THIS LINE =======

PLATS= aix bsd c89 freebsd generic linux macosx mingw posix solaris windows

LUA_A=	liblua.$(LIB_EXT)
CORE_O=	lapi.$(OBJ_EXT) lcode.$(OBJ_EXT) lctype.$(OBJ_EXT) ldebug.$(OBJ_EXT) ldo.$(OBJ_EXT) ldump.$(OBJ_EXT) lfunc.$(OBJ_EXT) lgc.$(OBJ_EXT) llex.$(OBJ_EXT) \
	lmem.$(OBJ_EXT) lobject.$(OBJ_EXT) lopcodes.$(OBJ_EXT) lparser.$(OBJ_EXT) lstate.$(OBJ_EXT) lstring.$(OBJ_EXT) ltable.$(OBJ_EXT) \
	ltm.$(OBJ_EXT) lundump.$(OBJ_EXT) lvm.$(OBJ_EXT) lzio.$(OBJ_EXT)
LIB_O=	lauxlib.$(OBJ_EXT) lbaselib.$(OBJ_EXT) lbitlib.$(OBJ_EXT) lcorolib.$(OBJ_EXT) ldblib.$(OBJ_EXT) liolib.$(OBJ_EXT) \
	lmathlib.$(OBJ_EXT) loslib.$(OBJ_EXT) lstrlib.$(OBJ_EXT) ltablib.$(OBJ_EXT) lutf8lib.$(OBJ_EXT) loadlib.$(OBJ_EXT) linit.$(OBJ_EXT)
BASE_O= $(CORE_O) $(LIB_O) $(MYOBJS)

LUA_T=	lua$(EXE_EXT)
LUA_O=	lua.$(OBJ_EXT)

LUAC_T=	luac$(EXE_EXT)
LUAC_O=	luac.$(OBJ_EXT)

ALL_O= $(BASE_O) $(LUA_O) $(LUAC_O)
ALL_T= $(LUA_A) $(LUA_T) $(LUAC_T)
ALL_A= $(LUA_A)

# Targets start here.
default: $(PLAT)

all:	$(ALL_T)

o:	$(ALL_O)

a:	$(ALL_A)

$(LUA_A): $(BASE_O)
	$(AR) $@ $(BASE_O)
	$(RANLIB) $@

$(LUA_T): $(LUA_O) $(LUA_A)
	$(CC) -o $@ $(LDFLAGS) $(LUA_O) $(LUA_A) $(LIBS)

$(LUAC_T): $(LUAC_O) $(LUA_A)
	$(CC) -o $@ $(LDFLAGS) $(LUAC_O) $(LUA_A) $(LIBS)

clean:
	$(RM) $(ALL_T) $(ALL_O)

depend:
	@$(CC) $(CFLAGS) -MM l*.c

echo:
	@echo "PLAT= $(PLAT)"
	@echo "CC= $(CC)"
	@echo "CFLAGS= $(CFLAGS)"
	@echo "LDFLAGS= $(SYSLDFLAGS)"
	@echo "LIBS= $(LIBS)"
	@echo "AR= $(AR)"
	@echo "RANLIB= $(RANLIB)"
	@echo "RM= $(RM)"

# Convenience targets for popular platforms
ALL= all

none:
	@echo "Please do 'make PLATFORM' where PLATFORM is one of these:"
	@echo "   $(PLATS)"

aix:
	$(MAKE) $(ALL) CC="xlc" CFLAGS="-O2 -DLUA_USE_POSIX -DLUA_USE_DLOPEN" SYSLIBS="-ldl" SYSLDFLAGS="-brtl -bexpall"

bsd:
	$(MAKE) $(ALL) SYSCFLAGS="-DLUA_USE_POSIX -DLUA_USE_DLOPEN" SYSLIBS="-Wl,-E"

c89:
	$(MAKE) $(ALL) SYSCFLAGS="-DLUA_USE_C89" CC="gcc -std=c89"
	@echo ''
	@echo '*** C89 does not guarantee 64-bit integers for Lua.'
	@echo ''


freebsd:
	$(MAKE) $(ALL) SYSCFLAGS="-DLUA_USE_LINUX -DLUA_USE_READLINE -I/usr/include/edit" SYSLIBS="-Wl,-E -ledit" CC="cc"

generic: $(ALL)

linux:
	$(MAKE) $(ALL) SYSCFLAGS="-DLUA_USE_LINUX" SYSLIBS="-Wl,-E -ldl -lreadline"

macosx:
	$(MAKE) $(ALL) SYSCFLAGS="-DLUA_USE_MACOSX" SYSLIBS="-lreadline"

mingw:
	$(MAKE) "LUA_A=lua53.dll" "LUA_T=lua.exe" \
	"AR=$(CC) -shared -o" "RANLIB=strip --strip-unneeded" \
	"SYSCFLAGS=-DLUA_BUILD_AS_DLL" "SYSLIBS=" "SYSLDFLAGS=-s" lua.exe
	$(MAKE) "LUAC_T=luac.exe" luac.exe

posix:
	$(MAKE) $(ALL) SYSCFLAGS="-DLUA_USE_POSIX"
    
solaris:
	$(MAKE) $(ALL) SYSCFLAGS="-DLUA_USE_POSIX -DLUA_USE_DLOPEN -D_REENTRANT" SYSLIBS="-ldl"

windows:
	$(MAKE) $(ALL) CC="cl" SYSCFLAGS="-DLUA_USE_POSIX -DLUA_USE_DLOPEN -D_REENTRANT" SYSLIBS="-ldl"

# list targets that do not create files (but not all makes understand .PHONY)
.PHONY: all $(PLATS) default o a clean depend echo none

# DO NOT DELETE

lapi.$(OBJ_EXT): lapi.c lprefix.h lua.h luaconf.h lapi.h llimits.h lstate.h \
 lobject.h ltm.h lzio.h lmem.h ldebug.h ldo.h lfunc.h lgc.h lstring.h \
 ltable.h lundump.h lvm.h
lauxlib.$(OBJ_EXT): lauxlib.c lprefix.h lua.h luaconf.h lauxlib.h
lbaselib.$(OBJ_EXT): lbaselib.c lprefix.h lua.h luaconf.h lauxlib.h lualib.h
lbitlib.$(OBJ_EXT): lbitlib.c lprefix.h lua.h luaconf.h lauxlib.h lualib.h
lcode.$(OBJ_EXT): lcode.c lprefix.h lua.h luaconf.h lcode.h llex.h lobject.h \
 llimits.h lzio.h lmem.h lopcodes.h lparser.h ldebug.h lstate.h ltm.h \
 ldo.h lgc.h lstring.h ltable.h lvm.h
lcorolib.$(OBJ_EXT): lcorolib.c lprefix.h lua.h luaconf.h lauxlib.h lualib.h
lctype.$(OBJ_EXT): lctype.c lprefix.h lctype.h lua.h luaconf.h llimits.h
ldblib.$(OBJ_EXT): ldblib.c lprefix.h lua.h luaconf.h lauxlib.h lualib.h
ldebug.$(OBJ_EXT): ldebug.c lprefix.h lua.h luaconf.h lapi.h llimits.h lstate.h \
 lobject.h ltm.h lzio.h lmem.h lcode.h llex.h lopcodes.h lparser.h \
 ldebug.h ldo.h lfunc.h lstring.h lgc.h ltable.h lvm.h
ldo.$(OBJ_EXT): ldo.c lprefix.h lua.h luaconf.h lapi.h llimits.h lstate.h \
 lobject.h ltm.h lzio.h lmem.h ldebug.h ldo.h lfunc.h lgc.h lopcodes.h \
 lparser.h lstring.h ltable.h lundump.h lvm.h
ldump.$(OBJ_EXT): ldump.c lprefix.h lua.h luaconf.h lobject.h llimits.h lstate.h \
 ltm.h lzio.h lmem.h lundump.h
lfunc.$(OBJ_EXT): lfunc.c lprefix.h lua.h luaconf.h lfunc.h lobject.h llimits.h \
 lgc.h lstate.h ltm.h lzio.h lmem.h
lgc.$(OBJ_EXT): lgc.c lprefix.h lua.h luaconf.h ldebug.h lstate.h lobject.h \
 llimits.h ltm.h lzio.h lmem.h ldo.h lfunc.h lgc.h lstring.h ltable.h
linit.$(OBJ_EXT): linit.c lprefix.h lua.h luaconf.h lualib.h lauxlib.h
liolib.$(OBJ_EXT): liolib.c lprefix.h lua.h luaconf.h lauxlib.h lualib.h
llex.$(OBJ_EXT): llex.c lprefix.h lua.h luaconf.h lctype.h llimits.h ldebug.h \
 lstate.h lobject.h ltm.h lzio.h lmem.h ldo.h lgc.h llex.h lparser.h \
 lstring.h ltable.h
lmathlib.$(OBJ_EXT): lmathlib.c lprefix.h lua.h luaconf.h lauxlib.h lualib.h
lmem.$(OBJ_EXT): lmem.c lprefix.h lua.h luaconf.h ldebug.h lstate.h lobject.h \
 llimits.h ltm.h lzio.h lmem.h ldo.h lgc.h
loadlib.$(OBJ_EXT): loadlib.c lprefix.h lua.h luaconf.h lauxlib.h lualib.h
lobject.$(OBJ_EXT): lobject.c lprefix.h lua.h luaconf.h lctype.h llimits.h \
 ldebug.h lstate.h lobject.h ltm.h lzio.h lmem.h ldo.h lstring.h lgc.h \
 lvm.h
lopcodes.$(OBJ_EXT): lopcodes.c lprefix.h lopcodes.h llimits.h lua.h luaconf.h
loslib.$(OBJ_EXT): loslib.c lprefix.h lua.h luaconf.h lauxlib.h lualib.h
lparser.$(OBJ_EXT): lparser.c lprefix.h lua.h luaconf.h lcode.h llex.h lobject.h \
 llimits.h lzio.h lmem.h lopcodes.h lparser.h ldebug.h lstate.h ltm.h \
 ldo.h lfunc.h lstring.h lgc.h ltable.h
lstate.$(OBJ_EXT): lstate.c lprefix.h lua.h luaconf.h lapi.h llimits.h lstate.h \
 lobject.h ltm.h lzio.h lmem.h ldebug.h ldo.h lfunc.h lgc.h llex.h \
 lstring.h ltable.h
lstring.$(OBJ_EXT): lstring.c lprefix.h lua.h luaconf.h ldebug.h lstate.h \
 lobject.h llimits.h ltm.h lzio.h lmem.h ldo.h lstring.h lgc.h
lstrlib.$(OBJ_EXT): lstrlib.c lprefix.h lua.h luaconf.h lauxlib.h lualib.h
ltable.$(OBJ_EXT): ltable.c lprefix.h lua.h luaconf.h ldebug.h lstate.h lobject.h \
 llimits.h ltm.h lzio.h lmem.h ldo.h lgc.h lstring.h ltable.h lvm.h
ltablib.$(OBJ_EXT): ltablib.c lprefix.h lua.h luaconf.h lauxlib.h lualib.h
ltm.$(OBJ_EXT): ltm.c lprefix.h lua.h luaconf.h ldebug.h lstate.h lobject.h \
 llimits.h ltm.h lzio.h lmem.h ldo.h lstring.h lgc.h ltable.h lvm.h
lua.$(OBJ_EXT): lua.c lprefix.h lua.h luaconf.h lauxlib.h lualib.h
luac.$(OBJ_EXT): luac.c lprefix.h lua.h luaconf.h lauxlib.h lobject.h llimits.h \
 lstate.h ltm.h lzio.h lmem.h lundump.h ldebug.h lopcodes.h
lundump.$(OBJ_EXT): lundump.c lprefix.h lua.h luaconf.h ldebug.h lstate.h \
 lobject.h llimits.h ltm.h lzio.h lmem.h ldo.h lfunc.h lstring.h lgc.h \
 lundump.h
lutf8lib.$(OBJ_EXT): lutf8lib.c lprefix.h lua.h luaconf.h lauxlib.h lualib.h
lvm.$(OBJ_EXT): lvm.c lprefix.h lua.h luaconf.h ldebug.h lstate.h lobject.h \
 llimits.h ltm.h lzio.h lmem.h ldo.h lfunc.h lgc.h lopcodes.h lstring.h \
 ltable.h lvm.h
lzio.$(OBJ_EXT): lzio.c lprefix.h lua.h luaconf.h llimits.h lmem.h lstate.h \
 lobject.h ltm.h lzio.h

# (end of Makefile)
