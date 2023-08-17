#!/bin/bash

# Function to display usage and exit
usage() {
    echo "Usage: $0 [options] source_zip destination_dir"
    echo "Options:"
    echo "  --git   : Run Git commands to init new project folders, fetch all branches and restart to HEAD"
    exit 1
}

run_git=false

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        --git)
            run_git=true
            shift
            ;;
        -h|--help)
            usage
            ;;
        --*)
            echo "Unknown option: $key"
            usage
            ;;
        *)
            break
            ;;
    esac
done

# Get source directory from command-line argument or use default value
source_zip="${1}"
# check if ${1} is empty
if [ -z "$source_zip" ]; then
    echo "Missing source zip file"
    usage
fi

# Get destination directory from command-line argument or use default value
destination_dir="${2}"
# check if ${2} is empty
if [ -z "$destination_dir" ]; then
    echo "Missing destination directory"
    usage
fi

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

find "$destination_dir" -type d -name ".git" -not -path "*/.git/*" | while read -r git_dir; do   
    # Check if the user wants to run Git commands
    if [ "$run_git" = true ]; then
        rel_path="${git_dir#$destination_dir}"
        git_script_dir=${git_dir%/.git}
        echo "Run Git commands in $destination_dir to reinitialize the projects"
        git init $git_script_dir
        git -C $git_script_dir fetch --all
        git -C $git_script_dir reset --hard HEAD
        git -C $git_script_dir clean -fd
    fi
done

# ask user if wants to delete the zip file
read -p "Do you want to delete the zip file? (y/n) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo
    rm "$source_zip"
    echo "Zip file deleted successfully"
fi