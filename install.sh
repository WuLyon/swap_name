#!/bin/bash

echo "executing: install swap_name tool..."

# URL to download the main script.
DOWNLOAD_URL="https://raw.githubusercontent.com/WuLyon/swap_name/main/swap_name.py"

# Path to the target file.
TARGET_FILE="/usr/local/bin/swap_name"

# Download the file using curl or wget
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

# Update the configuration file based on the shell type
if [[ "$USER_SHELL" == "bash" ]]; then
    CONFIG_FILE="$HOME/.bashrc"
elif [[ "$USER_SHELL" == "zsh" ]]; then
    CONFIG_FILE="$HOME/.zshrc"
else
    echo "Error: Unsupported shell ($USER_SHELL)."
    exit 1
fi

# Add the alias to the configuration file
if ! grep -q "alias swap_name=" "$CONFIG_FILE"; then
    echo "Adding alias to $CONFIG_FILE..."
    echo 'alias swap_name="/usr/local/bin/swap_name"' >> "$CONFIG_FILE"
else
    echo "The alias 'swap_name' already exists in $CONFIG_FILE..."
    read -p "Do you want to modify it?(y/n): " REPLY
    echo

    if [[ "$REPLY" == "y" ]]; then
        echo "Updating alias in $CONFIG_FILE..."
        if [[ "$(uname)" == Darwin ]]; then
            sed -i "" 's|^alias swap_name=.*|alias swap_name="/usr/local/bin/swap_name"|' "$CONFIG_FILE"
        else
            sed -i 's|^alias swap_name=.*|alias swap_name="/usr/local/bin/swap_name"|' "$CONFIG_FILE"
        fi
    else
        echo "Installation failed. Please resolve the conflict manually and reinstall."
        exit 1
    fi
fi

# Prompt the user to reload the configuration file
echo "Installation complete!"
echo "Please run the following command to apply changes:"
if [[ "$USER_SHELL" == "bash" ]]; then
    echo -e "\033[32msource ~/.bashrc\033[0m"
elif [[ "$USER_SHELL" == "zsh" ]]; then
    echo -e "\033[32msource ~/.zshrc\033[0m"
fi