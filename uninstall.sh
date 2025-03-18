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
    
# Prompt the user to reload the configuration file
echo "Uninstallation complete!"
echo "Please run the following command to apply changes: "
if [[ "$USER_SHELL" == "bash" ]]; then
    echo -e "\033[32msource ~/.bashrc\033[0m"
elif [[ "$USER_SHELL" == "zsh" ]]; then
    echo -e "\033[32msource ~/.zshrc\033[0m"
fi