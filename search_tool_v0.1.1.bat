@echo off
setlocal

:: === Get user input ===
call :GetFolderPath
call :GetSearchTerm
call :GetSearchType
call :SetupPaths

:: === Log and perform search ===
call :InitLog
if "%SEARCH_TYPE%"=="1" (
    call :SearchContents
) else (
    call :SearchFilenames
)

:: === Wrap up ===
echo.
echo Search complete. Results saved in: %LOG_FILE%
pause
exit /b


:: === Subroutines ===

:GetFolderPath
set /p SELECTED_FOLDER=Enter the folder path to search: 
set "SELECTED_FOLDER=%SELECTED_FOLDER:"=%"
if not exist "%SELECTED_FOLDER%\*" (
    echo ERROR: The folder does not exist. Exiting.
    pause
    exit /b 1
)
exit /b

:GetSearchTerm
set /p SEARCH_TERM=Enter the search term: 
exit /b

:GetSearchType
echo.
echo Choose search type:
echo 1. Search file contents
echo 2. Search filenames
set /p SEARCH_TYPE=Enter 1 or 2: 
exit /b

:SetupPaths
for /f "delims=" %%D in ('powershell -command "[Environment]::GetFolderPath('Desktop')"') do set "DESKTOP_PATH=%%D"
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
    echo Search Term: %SEARCH_TERM%
    echo Selected Folder: %SELECTED_FOLDER%
    echo.
) > "%LOG_FILE%"
exit /b

:SearchContents
echo === Matching Lines in Files === >> "%LOG_FILE%"
echo Searching file contents...
findstr /s /i /n /c:"%SEARCH_TERM%" "%SELECTED_FOLDER%\*" >> "%LOG_FILE%" 2>nul
exit /b

:SearchFilenames
echo === Matching Files === >> "%LOG_FILE%"
echo Searching filenames only...
dir /s /b "%SELECTED_FOLDER%" | find /I "%SEARCH_TERM%" >> "%LOG_FILE%"
exit /b
