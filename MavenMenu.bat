@echo off

REM
REM Command line main menu. To edit this file, use encoding DOS (CP 437).
REM
REM Author: Cris Stanza, 19-Aug-2015
REM

set PROJECT_NAME=Maven Menu
set WSDL=http://www.example.com/service?wsdl

set ARTIFACT_ID=mavenmenu
set GROUP_ID=io.github.crisstanza
set VERSION=1.0.0

set MAIN_PACKAGE=%GROUP_ID%
set MAIN_CLASS=Main

set CP=.
set CP=%CP%;.\lib\example.jar
set CP=%CP%;%USERPROFILE%\.m2\repository\junit\junit\4.12\junit-4.12.jar
set CP=%CP%;%USERPROFILE%\.m2\repository\io\github\crisstanza\jchron\1.0\jchron-1.0.jar

:MAIN_MENU
	cls
	echo.
	echo         ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
	echo         º          %PROJECT_NAME% - %VERSION%          º
	echo         ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
	echo.
	echo.
	echo   Maven options:
	echo   ÄÄÄÄÄÄÄÄÄÄÄÄÄ
	echo.
	echo     [G] Generate archetype
	echo     [c] Clean       [i] Install   [k] Install (skip tests)
	echo     [s] Source      [t] Test      [r] Run
	echo.
	echo   Shortcuts: [ci] [csi] [ck] [csk]
	echo.
	echo.
	echo   WSImport options:
	echo   ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	echo.
	echo     [g] Generate    [f] Fix       [d] Delete
	echo.
	echo.
	echo   Native options:
	echo   ÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	echo.
	echo     [1] Compile     [2] Run       [3] Clean
	echo     [T] Terminal    [l] LEIA-ME   [q] quit
	echo.
	echo.

	set /p OPTION="> "

	if [%OPTION%] == [G] goto OPTION_G
	if [%OPTION%] == [c] goto OPTION_C
	if [%OPTION%] == [i] goto OPTION_I
	if [%OPTION%] == [ci] goto OPTION_CI
	if [%OPTION%] == [csi] goto OPTION_CSI
	if [%OPTION%] == [k] goto OPTION_K
	if [%OPTION%] == [ck] goto OPTION_CK
	if [%OPTION%] == [csk] goto OPTION_CSK
	if [%OPTION%] == [s] goto OPTION_S
	if [%OPTION%] == [r] goto OPTION_R
	if [%OPTION%] == [t] goto OPTION_T

	if [%OPTION%] == [g] goto OPTION_WSIMPORT_G
	if [%OPTION%] == [f] goto OPTION_F
	if [%OPTION%] == [d] goto OPTION_D

	if [%OPTION%] == [1] goto OPTION_1
	if [%OPTION%] == [2] goto OPTION_2
	if [%OPTION%] == [3] goto OPTION_3
	if [%OPTION%] == [T] goto OPTION_NATIVE_T
	if [%OPTION%] == [l] goto OPTION_NATIVE_L
	if [%OPTION%] == [q] goto OPTION_Q
	
	goto MAIN_MENU

:END_OF_OPTION
	pause
:END_OF_OPTION_NON_PAUSED
	set OPTION=
	goto MAIN_MENU

:OPTION_G
	echo.
	call mvn archetype:generate -DgroupId=%GROUP_ID% -DartifactId=%ARTIFACT_ID% -Dversion=%VERSION% -DpackageName=%MAIN_PACKAGE% -DinteractiveMode=false
	echo.
	goto END_OF_OPTION

:OPTION_C
	echo.
	cd %ARTIFACT_ID%
	call mvn clean
	echo.
	cd ..
	goto END_OF_OPTION

:OPTION_I
	echo.
	cd %ARTIFACT_ID%
	call mvn install
	echo.
	cd ..
	goto END_OF_OPTION

:OPTION_CI
	echo.
	cd %ARTIFACT_ID%
	call mvn clean install
	echo.
	cd ..
	goto END_OF_OPTION

:OPTION_CSI
	echo.
	cd %ARTIFACT_ID%
	call mvn clean source:jar install
	echo.
	cd ..
	goto END_OF_OPTION

:OPTION_K
	echo.
	cd %ARTIFACT_ID%
	call mvn install -Dmaven.test.skip=true
	echo.
	cd ..
	goto END_OF_OPTION

:OPTION_CK
	echo.
	cd %ARTIFACT_ID%
	call mvn clean install -Dmaven.test.skip=true
	echo.
	cd ..
	goto END_OF_OPTION

:OPTION_CSK
	echo.
	cd %ARTIFACT_ID%
	call mvn clean source:jar install -Dmaven.test.skip=true
	echo.
	cd ..
	goto END_OF_OPTION

:OPTION_T
	echo.
	cd %ARTIFACT_ID%
	call mvn test
	echo.
	cd ..
	goto END_OF_OPTION

:OPTION_S
	echo.
	cd %ARTIFACT_ID%
	call mvn source:jar
	echo.
	cd ..
	goto END_OF_OPTION

:OPTION_R
	echo.
	cd %ARTIFACT_ID%
	call mvn exec:java -Dexec.mainClass="%MAIN_PACKAGE%.%MAIN_CLASS%"
	echo.
	cd ..
	goto END_OF_OPTION

:OPTION_WSIMPORT_G
	echo.
	cd %ARTIFACT_ID%
	wsimport -Xdebug -verbose -b http://www.w3.org/2001/XMLSchema.xsd -s .\src\main\java.wsimport -d .\target\classes -keep -extension %WSDL%
	cd ..
	echo.
	goto END_OF_OPTION

:OPTION_F
	echo.
	cd %ARTIFACT_ID%
	dir /s /b .\src\main\java.wsimport\*.java > .\target\files.wsimport.txt
	java -cp .\target\classes;%CP% %MAIN_PACKAGE%.util.FileSystemUtil .\target\files.wsimport.txt
	cd ..
	echo.
	goto END_OF_OPTION

:OPTION_D
	echo.
	cd %ARTIFACT_ID%
	if exist .\src\main\java.wsimport rmdir /s/q .\src\main\java.wsimport
	md .\src\main\java.wsimport
	echo.
	cd ..
	goto END_OF_OPTION

:OPTION_1
	echo.
	cd %ARTIFACT_ID%
	if not exist .\target md .\target
	if not exist .\target\classes md .\target\classes
	dir /s /b *.java > .\target\files.txt
	javac -encoding UTF-8 -sourcepath .\src\main\java -d .\target\classes -cp .\src\main\java;%CP% @.\target\files.txt
	cd ..
	goto END_OF_OPTION

:OPTION_2
	echo.
	cls
	cd %ARTIFACT_ID%
	java -cp .\target\classes;%CP% %MAIN_PACKAGE%.%MAIN_CLASS%
	cd ..
	echo.
	goto END_OF_OPTION

:OPTION_3
	echo.
	cd %ARTIFACT_ID%
	if exist .\target rmdir /s/q .\target
	md .\target
	md .\target\classes
	cd ..
	goto END_OF_OPTION

:OPTION_NATIVE_T
	echo.
	cmd
	goto END_OF_OPTION_NON_PAUSED

:OPTION_NATIVE_L
	cls
	echo.
	type LEIA-ME.txt
	echo.
	goto END_OF_OPTION

:OPTION_Q
	echo.
	goto END

:END
	REM pause
