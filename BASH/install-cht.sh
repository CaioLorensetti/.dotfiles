#!/bin/bash

# Define the destination directory
BIN_DIR="/usr/local/bin"
CHT_PATH="$BIN_DIR/cht.sh"

# Create bin directory if it doesn't exist
mkdir -p "$BIN_DIR"

# Download cht.sh script
echo "Downloading cht.sh..."
curl -s https://cht.sh/:cht.sh -o "$CHT_PATH"

# Make it executable
chmod +x "$CHT_PATH"
echo "cht.sh has been installed to $CHT_PATH"

# Ensure $HOME/bin is in PATH
if ! echo "$PATH" | grep -q "$BIN_DIR"; then
  echo "Adding $BIN_DIR to PATH in ~/.zshrc..."
  echo "export PATH=\"\$HOME/bin:\$PATH\"" >> ~/.zshrc
  source ~/.zshrc
fi

# Optional test command
echo "Running test command: cht.sh :help"
"$CHT_PATH" :help

