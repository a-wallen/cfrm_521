#!/bin/bash

# 1. Download Kaggle Data if missing
mkdir -p /app/data
if [ ! -f /app/data/cs-training.csv ]; then
    if [ -f /app/kaggle.json ]; then
        echo "Downloading Kaggle dataset..."
        chmod 600 /app/kaggle.json
        kaggle competitions download -c GiveMeSomeCredit -p /app/data/
        unzip -n /app/data/GiveMeSomeCredit.zip -d /app/data/
        rm /app/data/GiveMeSomeCredit.zip
    else
        echo "WARNING: kaggle.json not found! Please place it in the root directory and restart to download data."
    fi
fi

# 2. Setup git hooks inside the container
if [ -d /app/.git ]; then
    echo "Installing pre-commit hooks for Jupyter notebook stripping..."
    pre-commit install
fi

# 3. Execute the main Jupyter Lab command
exec "$@"
