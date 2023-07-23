#!/bin/bash

# Set the default directory to the current directory if no argument is provided
directory="${1:-.}"

# Check if the directory exists
if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' not found."
    exit 1
fi

# Use find command to delete empty directories in the given directory
find "$directory" -type d -empty -delete

echo "Empty directories in '$directory' have been deleted."
