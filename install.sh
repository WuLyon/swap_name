#!/bin/bash

echo "executing: install swap_name tool..."

# URL to download the main script.
DOWNLOAD_URL="https://raw.githubusercontent.com/WuLyon/swap_name/v1.1.0/swap_name.py"

# Path to the target file.
TARGET_FILE="/usr/local/bin/swap_name"

# Download the file using curl
echo "Downloading swap_name.py from $DOWNLOAD_URL..."
if command -v curl &> /dev/null; then
    # The -E parameter means preserving the current user's environment variables, 
    # which ensures that any terminal proxy configurations are retained. 
    sudo -E curl -o "$TARGET_FILE" "$DOWNLOAD_URL"
else
    echo "Error: Curl is not installed. Please install crul and try again."
    exit 1
fi

# Check if the downlaod was successful.
if [[ ! -f "$TARGET_FILE" ]]; then
    echo "Error: Failed to download swap_name.py"
    exit 1
fi

# Grant executable permissions
echo "Setting executable permissions for /usr/local/bin/swap_name..."
sudo chmod +x "$TARGET_FILE"

# Check the user's default shell
USER_SHELL=$(basename "$SHELL")

# Prompt the user to reload the configuration file
echo "Installation complete!"
echo "Please run the following command to apply changes:"
if [[ "$USER_SHELL" == "bash" ]]; then
    echo -e "\033[32msource ~/.bashrc\033[0m"
elif [[ "$USER_SHELL" == "zsh" ]]; then
    echo -e "\033[32msource ~/.zshrc\033[0m"
fi