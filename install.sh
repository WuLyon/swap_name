#!/bin/bash

echo "executing: install swap_name tool..."

# Define the directory where the script is located
SCRIPT_DIR=$(dirname "$0")

# Path to the source file
SOURCE_FILE="$SCRIPT_DIR/swap_name.py"

# Path to the target file
TARGET_FILE="/usr/local/bin/swap_name"

# Check if the source file exists
if [[ ! -f "$SOURCE_FILE" ]]; then
    echo "Error: swap_name.py not found in the script directory."
    exit 1
fi

# Copy the file to /usr/local/bin and rename it
echo "Copying swap_name.py to /usr/local/bin/swap_name..."
sudo cp "$SOURCE_FILE" "$TARGET_FILE"

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
    echo "source ~/.bashrc"
elif [[ "$USER_SHELL" == "zsh" ]]; then
    echo "source ~/.zshrc"
fi