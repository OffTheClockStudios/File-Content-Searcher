@echo off
setlocal enabledelayedexpansion

:: Ask user for search folder
echo Enter the folder path to search: 
set /p SELECTED_FOLDER= 

:: Remove unnecessary quotes
set "SELECTED_FOLDER=!SELECTED_FOLDER:"=!"

:: Validate folder path
if not exist "!SELECTED_FOLDER!\*" (
    echo ERROR: The folder does not exist. Exiting.
    pause
    exit /b
)

:: Ask user for search term
set /p SEARCH_TERM=Enter the search term: 

:: Ask user what to search: contents or filenames
echo.
echo Choose search type:
echo 1. Search file contents
echo 2. Search filenames
set /p SEARCH_TYPE=Enter 1 or 2: 

:: Get user's desktop path
for /f "delims=" %%D in ('powershell -command "[System.Environment]::GetFolderPath('Desktop')"') do set "DESKTOP_PATH=%%D"

:: Define "Util" folder path
set "UTIL_PATH=!DESKTOP_PATH!\Util"

:: Check if "Util" folder exists, create if not
if not exist "!UTIL_PATH!" (
    mkdir "!UTIL_PATH!"
)

:: Set log file name based on choice
if "!SEARCH_TYPE!"=="1" (
    set "LOG_FILE=!UTIL_PATH!\search_content_log.txt"
) else (
    set "LOG_FILE=!UTIL_PATH!\search_filename_log.txt"
)

:: Clear log file
echo. > "!LOG_FILE!"

:: Log search criteria
(
    echo Search Term: !SEARCH_TERM!
    echo Selected Folder: !SELECTED_FOLDER!
    echo.
) > "!LOG_FILE!"

:: Perform selected search
if "!SEARCH_TYPE!"=="1" (
    echo === Matching Lines in Files === >> "!LOG_FILE!"
    echo Searching file contents...
    findstr /s /i /n /c:"!SEARCH_TERM!" "!SELECTED_FOLDER!\*" >> "!LOG_FILE!" 2>nul
) else (
    echo === Matching Files === >> "!LOG_FILE!"
    echo Searching filenames only...
    dir /s /b "!SELECTED_FOLDER!" | find /I "!SEARCH_TERM!" >> "!LOG_FILE!"
)

:: Notify user
echo.
echo Search complete. Results saved in: !LOG_FILE!
pause
