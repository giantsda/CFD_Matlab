@echo off

set file_path=E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\summer_raceway\3million\3million_files\dp0\FFF-6\Fluent\
set file_name=3million_0.03_1.608-2-00073.cas.gz
set file=%file_path%%file_name%

FOR %%s IN (%file%) DO (
	ECHO File Name Only       : %%~ns
	ECHO File Size            : %%~zs
 	set  si= %%~zs
	ECHO Last-Modified Date   : %%~ts
)
set /a size=%si%
set /a sizee=%size%/1024/1024
echo %size%

set c=%DATE:~3,4%%DATE:~8,2%%DATE:~11,2%
set t=%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%
set datetime=%c%%t%
echo %datetime%
copy %file%    E:\desktop\BATCH\safe\%size%.xml