@echo off
set path=%~dp0;%PATH%

		:: Works well, have it set to a depth of 3 ::
set app=
call :Call %*
call :Clip
goto:EOF
		:: Might have to ping-pong-putz for windows ::
:Clip
set sauce=%0
for /f "useback delims=" %%i in (`powershell get-clipboard^|find ":\"`) do call :clone "%%~i"
goto:EOF


:Call
set sauce=%0
for %%i in (%*) do  call :clone "%%~i"
goto:EOF


:clone
call :APP
for /f "useback delims=" %%i in (`%app% lsf "%~1"`) do call :unblock "%~dpnx1\%%~i" %sauce::=%
goto:EOF


:unblock
set /a uCount+=1
echo%0:%2		%time: =0%	:	{%uCount%}
echo:%~nx1
echo:%~dp1
		powershell -command unblock-file '"%~dpnx1"'
echo:
goto:EOF






:APP
echo:
if defined app goto:rcloneVARS

for %%i in (rclone fclone) do (
	for %%I in (%%i.exe) do (
		call set %%i=%%~$PATH:I
		)
	)
echo:
if defined fclone (set app=%FCLONE%) else if defined rclone set app=%Rclone%
	(if defined app (echo:Found %APP%) else echo:^*clones not found & goto:EOF)

:rcloneVARS
set exec= %app% lsf 
set rclone_use_mmap=true
set rclone_fast_list=true
set rclone_max_depth=3
set rclone_files_only=true
set rclone_no_traverse=true
set rclone_absolute=true
goto:EOF










 unused shitz



for /f "useback delims=" %%i in (`%app% lsf "%~1"`) do call :unblock "%~dp1%%~i" %sauce::=%



echo%0:%2:%time: =0%&echo:%1










:ScanParentDirs
for %%i in (%*) do (call :unblock "%%~i"
	for /D %%D in ("%%~dpi*") do (
		for %%I in ("%%~D\*") do call :unblock "%%~I" %0
		)
	)
goto:EOF


:getFiles
echo%0:%*
for %%i in ("%~1\*") do call :unblock "%%~i" %0
goto:EOF

:sleepy3
powershell start-sleep -s 3
goto:EOF


Never tested clone get shit


for %%i in (%*) do (
	for /D %%D in ("%%~i\*") do (
		for /f "useback delims=" %%I in (`call %exec% "%%~D"`) do echo:%%~I
		)
	)

pause
goto:EOF
