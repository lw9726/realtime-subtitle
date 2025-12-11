@echo off
title Real-Time Translator Installer

echo ===================================================
echo   Real-Time Translator - Windows Installer
echo ===================================================

:: Check for Python
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Python is not found in PATH!
    echo Please install Python 3.10+ from python.org and ensure "Add to PATH" is checked.
    pause
    exit /b
)

:: Create Virtual Environment
if not exist .venv (
    echo [1/3] Creating virtual environment (.venv)...
    python -m venv .venv
) else (
    echo [1/3] Virtual environment already exists.
)

:: Activate and Install
echo [2/3] Activating environment and installing dependencies...
call .venv\Scripts\activate.bat

python -m pip install --upgrade pip
pip install -r requirements.txt

:: Check FFmpeg (Optional check, hard to verify in bat easily without which, but we can warn)
echo [3/3] Checking FFmpeg...
ffmpeg -version >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo [WARNING] FFmpeg is not found in PATH.
    echo Whisper requires FFmpeg to process audio.
    echo Please download FFmpeg from https://ffmpeg.org/download.html and add it to your PATH.
    echo.
) else (
    echo FFmpeg found.
)

echo.
echo ===================================================
echo   Installation Complete! 
echo   Run 'start_windows.bat' to launch the app.
echo ===================================================
pause
