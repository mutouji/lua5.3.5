del *.o *.obj *.lib *.exe *.dll *.exp
cl /MD /O2 /c /DLUA_BUILD_AS_DLL *.c
ren lua.obj lua.o
ren luac.obj luac.o
link /DLL /IMPLIB:lua5.3.5.lib /OUT:lua5.3.5.dll *.obj 
link /OUT:lua.exe lua.o lua5.3.5.lib 
lib /OUT:lua5.3.5-static.lib *.obj
link /OUT:luac.exe luac.o lua5.3.5-static.lib
