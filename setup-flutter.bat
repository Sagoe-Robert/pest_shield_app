@echo off
REM Pest Shield App - Flutter Setup Script
setlocal enabledelayedexpansion

echo.
echo ========================================
echo Pest Shield App - Flutter Setup
echo ========================================
echo.

REM Check if Flutter directory exists
if not exist "C:\flutter" (
    echo Flutter SDK not found at C:\flutter
    echo Attempting to extract from downloaded ZIP...
    
    REM Try to extract flutter-stable.zip with 7z or PowerShell
    if exist "C:\Users\Robby\Downloads\flutter-stable.zip" (
        echo Found flutter-stable.zip, extracting...
        powershell -Command "Expand-Archive -Path 'C:\Users\Robby\Downloads\flutter-stable.zip' -DestinationPath 'C:\' -Force"
        if exist "C:\flutter-stable" (
            ren "C:\flutter-stable" flutter
            echo Extraction complete!
        )
    ) else (
        echo flutter-stable.zip not found
        exit /b 1
    )
)

REM Add Flutter to PATH
set PATH=C:\flutter\bin;C:\Program Files\Git\bin;C:\Program Files\Git\cmd;%PATH%

REM Change to frontend directory
cd /d "c:\Users\Robby\Downloads\Final Project\pest_shield_app\frontend"

REM Run flutter pub get
echo.
echo Running: flutter pub get
echo.
flutter pub get

if %errorlevel% equ 0 (
    echo.
    echo ========================================
    echo ✅ Flutter dependencies installed!
    echo ========================================
    echo.
    echo You can now run:
    echo   flutter run
    echo.
) else (
    echo.
    echo ❌ Error installing Flutter dependencies
    echo.
)

endlocal
pause
