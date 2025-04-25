@REM ============================================================================
@REM File:         Search_Tool.bat
@REM Version:      0.1.3
@REM Updated:      2025-04-25
@REM Description:  Search files or content in a folder with logging; now loops  
@REM               (choice: 1=reuse folder, 2=new folder)  
@REM Credits:      reddit user ConsistentHornet4 (improvement suggestions)
@REM               @BrainWaveCC fork (term-handling correction)
@REM               @amakvana (issue raised to utilize CHOICE for input)
@REM ============================================================================

@ECHO OFF

 setlocal

:MainLoop
    rem — ask for folder
    call :GetFolderPath

:SearchLoop
    rem — ask for term & type each iteration
    call :GetSearchTerm
    call :GetSearchType
    call :SetupPaths

    rem — run & log
    call :InitLog
    if "%SEARCH_TYPE%"=="1" (
        call :SearchContents
    ) else (
        call :SearchFilenames
    )

    rem — done, ask if we reuse this folder
    echo.
    echo Search complete. Results saved in: %LOG_FILE%
    choice /c 12 /n /m "1=Search again using the same folder    2=Select a new folder"
    rem ERRORLEVEL will be 1 if they press “1”, 2 if they press “2”
    if "%ERRORLEVEL%"=="1" (
        cls
        goto SearchLoop
    ) else (
        cls
        goto MainLoop
    )

 rem === Subroutines ===

:GetFolderPath
 set /p "SELECTED_FOLDER=Enter the folder path to search: "
 set "SELECTED_FOLDER=%SELECTED_FOLDER:"=%"
 if not exist "%SELECTED_FOLDER%" (
	 echo ERROR: The folder does not exist. Exiting.
	 pause
	 exit /b 1
 )
 exit /b


:GetSearchTerm
 set /p "SEARCH_TERM=Enter the search term: "
 exit /b


:GetSearchType
 echo(
 echo(Choose search type:
 echo(1. Search file contents 
 echo(2. Search filenames 
 choice /c 12 /n /m "Enter option: "
 set "SEARCH_TYPE=%ERRORLEVEL%"
exit /b


:SetupPaths
 for /f "delims=" %%D in ('powershell -command "[Environment]::GetFolderPath('Desktop')"') do set "DESKTOP_PATH=%%~D"
 set "UTIL_PATH=%DESKTOP_PATH%\Util"
 if not exist "%UTIL_PATH%" (
	 mkdir "%UTIL_PATH%"
 )
 if "%SEARCH_TYPE%"=="1" (
	 set "LOG_FILE=%UTIL_PATH%\search_content_log.txt"
 ) else (
	 set "LOG_FILE=%UTIL_PATH%\search_filename_log.txt"
 )
 exit /b


:InitLog
 (
    echo Search Term: "%SEARCH_TERM%"
    echo Selected Folder: "%SELECTED_FOLDER%"
    echo.
 ) >"%LOG_FILE%"
 exit /b


:SearchContents
 echo === Matching Lines in Files === >>"%LOG_FILE%"
 echo Searching file contents...
 findstr /s /i /n /c:"%SEARCH_TERM%" "%SELECTED_FOLDER%\*" >>"%LOG_FILE%" 2>nul
 exit /b


:SearchFilenames
 echo === Matching Files === >>"%LOG_FILE%"
 echo Searching filenames only...
 dir /s /b "%SELECTED_FOLDER%" | find /I "%SEARCH_TERM%" >>"%LOG_FILE%"
 exit /b
