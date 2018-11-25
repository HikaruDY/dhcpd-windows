@echo off
pushd "%~dp0"

gcc -c VirtualFunction.c
IF NOT EXIST "VirtualFunction.o" call :ERR "Compile failed: VirtualFuncition.c"

pushd ..

	IF NOT EXIST "%~dp0\.patched" (
		patch -p1 < %~dp0\dhcpd.h.patch"
		patch -p1 < %~dp0\discover.c.patch"
		patch -p1 < %~dp0\socket.c.patch"
		echo.>"%~dp0\.patched"
	)

	REM //IF NOT EXIST "Makefile" call :ERR "Makefile not found. Run ./configure first"
	IF NOT EXIST "Makefile" sh configure
	IF NOT EXIST "Makefile" call :ERR "./configure failed."

	REM //Script directory
	set BASE=%~dp0
	set BASE=%BASE::=%
	set BASE=%BASE:\=/%
	set BASE=/cygdrive/%BASE%

	make %* LDFLAGS="%~dp0\VirtualFunction.o" CFLAGS="-g -O2 -Wall -fno-strict-aliasing -I%BASE%/../includes -I%BASE%/../bind/include -I%BASE% " 
popd
popd

GOTO EOF
:ERR
echo E: %~1
exit /b 1
:EOF
exit /b 0
