#!/bin/bash

# Function to display usage and exit
usage() {
    echo "Usage: $0 [SOURCE_ZIP] [DESTINATION_DIR]"
    exit 1
}

# Get source directory from command-line argument or use default value
source_zip="${1}"

# Get destination directory from command-line argument or use default value
destination_dir="${2:-$HOME/projects}"

# check if source_zip is a file and exists
if [ ! -f "$source_zip" ]; then
    echo "Invalid file path: $source_zip"
    usage
fi

# check if destination_dir is a directory and exists
if [ ! -d "$destination_dir" ]; then
    echo "Creating destination directory: $destination_dir"
    mkdir -p "$destination_dir"
fi

# check if destination_dir is empty
if [ "$(ls -A $destination_dir)" ]; then
    echo "Destination directory is not empty: $destination_dir"
    usage
fi

echo "Unzip $source_zip to $destination_dir"
unzip -q "$source_zip" -d "$destination_dir"
echo "Backup restored successfully"

# ask user if wants to delete the zip file
read -p "Do you want to delete the zip file? (y/n) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo
    rm "$source_zip"
    echo "Zip file deleted successfully"
fi