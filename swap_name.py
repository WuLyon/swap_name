#!/usr/bin/env python3

import sys
import os
import uuid

def main():
    
    if len(sys.argv) != 3:
        print("Usage: swap_name <file1> <file2>")
        sys.exit(1)

    file1 = os.path.abspath(sys.argv[1])
    file2 = os.path.abspath(sys.argv[2])
    temp_name = os.path.join(os.path.dirname(file1), f"temp_file_{uuid.uuid4()}")

    if file1 == file2:
        print("\033[91mError:\033[0m Cannot swap a file with itself.")
        sys.exit(1)

    if not os.path.exists(file1) or not os.path.exists(file2):
        print(f"\033[91mError:\033[0m {file1} or {file2} does not exist.")
        sys.exit(1)
        
    if os.path.exists(temp_name):
        print(f"\033[91mError:\033[0m Temporary file '{temp_name}' already exists. Please try again.")
        sys.exit(1)


    try:
        os.rename(file1, temp_name)
        os.rename(file2, file1)
        os.rename(temp_name, file2)
        print(f"\n\033[92mSuccessfully swapped:\033[0m")
        print(f"    {sys.argv[1]} \u21c4 {sys.argv[2]}\n")
    except OSError as e:
        print(f"An error occurred during the swap: {e}")
        if os.path.exists(temp_name):
            print(f"Temporary file '{temp_name}' may need to be cleaned up manually.")
    
    
def test():
    print(f"{uuid.uuid4()}")

if __name__ == "__main__":
    main()