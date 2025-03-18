#!/usr/bin/env python3

import sys
import os
import uuid
import argparse

def swap(file1, file2):
    # Swap the names of two files.
    # Generate a temporary file name in the same directory and use uuid moudle to prevent naming conflicts.
    temp_name = os.path.join(os.path.dirname(file1), f"temp_file_{uuid.uuid4()}")
    if os.path.exists(temp_name):
        print(f"\033[91mError:\033[0m Temporary file '{temp_name}' already exists. Please try again.")
        sys.exit(1)

    # Attempt to swap the file names.
    try:
        os.rename(file1, temp_name)
        os.rename(file2, file1)
        os.rename(temp_name, file2)
        print(f"\n\033[92mSuccessfully swapped:\033[0m")
        print(f"    {file1} \u21c4 {file2}\n")
    except OSError as e:
        print(f"An error occurred during the swap: {e}")
        if os.path.exists(temp_name):
            print(f"Temporary file '{temp_name}' may need to be cleaned up manually.")
        

def backup(file1, file2):
    # After backing up file1, rename file2 to file1.
    backup_file = file1 + '.bak'
    
    # Check if the backup file already exists
    if os.path.exists(backup_file):
        print(f"\033[91mError:\033[0m Backup files '{backup_file}' already exist.")
        sys.exit(1)
        
    # Execute backup
    try:
        os.rename(file1, backup_file)
        os.rename(file2, file1)
        print(f"\n\033[92mSuccessfully backup and rename:\033[0m")
        print(f"    {file1} \u2192 {backup_file}")
        print(f"    {file2} \u2192 {file1}")
    except OSError as e:
        print(f"An error occurred during the backup: {e}")
    


def main():
    
    # Set up arguments
    parser = argparse.ArgumentParser(description="Swap or backup file name.")
    parser.add_argument('file1', help="First file")
    parser.add_argument('file2', help="Second file")
    parser.add_argument('-b', '--bak', action='store_true', help="Backup files instead of swapping.")
    args = parser.parse_args()

    # Get absolute paths of the files to be swapped.
    file1 = os.path.abspath(args.file1)
    file2 = os.path.abspath(args.file2)

    # Check if the files are the same.
    if file1 == file2:
        print("\033[91mError:\033[0m Cannot swap a file with itself.")
        sys.exit(1)

    # Check if the files exist.
    if not os.path.exists(file1) or not os.path.exists(file2):
        print(f"\033[91mError:\033[0m {file1} or {file2} does not exist.")
        sys.exit(1)
        
    # Determine the renaming method based on the argumet
    if args.bak:
        backup(file1, file2)
    else:
        swap(file1, file2)
        

if __name__ == "__main__":
    main()