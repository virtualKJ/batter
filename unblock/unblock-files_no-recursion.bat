@echo off
call :Call %*
call :Clip
goto:EOF

	See the lvl3 one. Requires a clone variant for max-depth of 3. 
	Winders dumbass and clip part will affect this too I'm sure.

:Clip
for /f "useback delims=" %%i in (`powershell get-clipboard^|find ":\"`) do (
	for %%I in ("%%~i\*") do call :unblock "%%~I" %0
	)
goto:EOF

:unblock
echo%0:%2:%1
		powershell -command unblock-file '"%~dpnx1"'
goto:EOF

:Call
for %%i in (%*) do (
	for %%I in ("%%~i\*") do call :unblock "%%~I" %0
	)
goto:EOF



