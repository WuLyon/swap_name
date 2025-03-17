#!/bin/bash

echo "Executing: uninstall swap_name tool..."
TARGET_FILE="/usr/local/bin/swap_name"

# Check if the target file exists and remove it
if [[ -f "$TARGET_FILE" ]]; then
    echo "Removing $TARGET_FILE..."
    sudo rm $TARGET_FILE
else
    echo "$TARGET_FILE does not exist."
fi

# Check the user's default shell
USER_SHELL=$(basename $SHELL)
if [[ "$USER_SHELL" == "bash" ]]; then
    CONFIG_FILE="$HOME/.bashrc"
elif [[ "$USER_SHELL" == "zsh" ]]; then
    CONFIG_FILE="$HOME/.zshrc"
else
    echo "Error: Unsupported shell ($USER_SHELL)."
    exit 1
fi

# Remove the alias from the configuration file
if grep -q "alias swap_name=" "$CONFIG_FILE"; then
    echo "Removing alias from $CONFIG_FILE..."
    if [[ "$(uname)" == Darwin ]]; then
        sed -i "" '/^alias swap_name=/d' "$CONFIG_FILE"
    else
        sed -i '/^alias swap_name=/d' "$CONFIG_FILE"
    fi
else
    echo "Alias not found in $CONFIG_FILE."
fi
    
# Prompt the user to reload the configuration file
echo "Uninstallation complete!"
echo "Please run the following command to apply changes: "
if [[ "$USER_SHELL" == "bash" ]]; then
    echo "source ~/.bashrc"
elif [[ "$USER_SHELL" == "zsh" ]]; then
    echo "source ~/.zshrc"
fi