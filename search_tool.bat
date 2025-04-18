@REM ============================================================================
@REM File:         Search_Tool.bat
@REM Version:      0.1.2
@REM Updated:      2025-04-14
@REM Description:  Search files or content in a folder, with logging to Desktop\Util
@REM Credits:      Based on suggestions from reddit user ConsistentHornet4
@REM               and fixes from BrainWaveCC's fork:
@REM               https://github.com/BrainWaveCC/File-Content-Searcher/blob/patch-1/Search_Tool.bat
@REM               Input handling improvement suggested by @amakvana
@REM ============================================================================
@ECHO OFF

 setlocal

 rem === Get user input ===
 call :GetFolderPath
 call :GetSearchTerm
 call :GetSearchType
 call :SetupPaths

 rem === Log and perform search ===
 call :InitLog
 if "%SEARCH_TYPE%"=="1" (
	 call :SearchContents
 ) else (
	 call :SearchFilenames
 )

 rem === Wrap up ===
 echo:
 echo Search complete. Results saved in: %LOG_FILE%
 pause
 exit /b


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
