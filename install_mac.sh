#!/bin/bash

echo "==================================================="
echo "  Real-Time Translator - macOS Installer"
echo "==================================================="

# 1. Check Python
if ! command -v python3 &> /dev/null; then
    echo "[ERROR] Python 3 is not installed."
    echo "Please install it via brew: brew install python"
    exit 1
fi

# 2. Virtual Environment
if [ ! -d ".venv" ]; then
    echo "[1/4] Creating virtual environment (.venv)..."
    python3 -m venv .venv
else
    echo "[1/4] Virtual environment exists."
fi

# 3. Activate & Install
echo "[2/4] Installing dependencies..."
source .venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt

# 4. Apple Silicon Optimization
ARCH=$(uname -m)
if [ "$ARCH" = "arm64" ]; then
    echo "[3/4] Apple Silicon (M1/M2/M3) detected!"
    echo "      Installing mlx-whisper for Metal GPU acceleration..."
    pip install mlx-whisper
else
    echo "[3/4] Intel Mac detected. Using standard larger models."
fi

# 5. Check System Dependencies
echo "[4/4] Checking system tools..."
MISSING_TOOLS=0

if ! command -v ffmpeg &> /dev/null; then
    echo "  [WARNING] ffmpeg is MISSING."
    echo "  -> Run: brew install ffmpeg"
    MISSING_TOOLS=1
else
    echo "  [OK] ffmpeg found."
fi

if [ $MISSING_TOOLS -eq 1 ]; then
    echo ""
    echo "Please install the missing tools above manually."
fi

echo ""
echo "==================================================="
echo "  Installation Complete!"
echo "  Run './start_mac.sh' to launch."
echo "==================================================="
