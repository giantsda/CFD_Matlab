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

if exist %file% (
set file_exist= the file exits!!!
) else (
set file_exist= the file is lost!!!
)

set cc=xsshenchen1991@163.com
set from= xsshenchen1991@gmail.com
set to= xsshenchen1991@gmail.com
set subject= FLUENT Status Updates
set message=Here is the analytics data for this week! %file_exist% filename=%size%.xml   size=%sizee%MB  Current time is %date%%time%

E:\desktop\BATCH\sendemail\sendEmail.exe -f %from% -t %to% -cc %cc% -u %subject% -m %message% -s smtp.gmail.com:587 -xu xsshenchen1991@gmail.com -xp balisong
