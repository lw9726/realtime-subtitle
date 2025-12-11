#!/bin/bash

# Ensure we are in the script's directory
cd "$(dirname "$0")"

if [ ! -d ".venv" ]; then
    echo "[ERROR] Virtual environment not found."
    echo "Please run './install_mac.sh' first."
    exit 1
fi

echo "[Launcher] Activating environment..."
source .venv/bin/activate

echo "[Launcher] Starting App (Hot Reload Mode)..."
python reloader.py
