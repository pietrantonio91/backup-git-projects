#!/bin/bash

# Function to display usage and exit
usage() {
    echo "Usage: $0 source_dir [destination_dir]"
    exit 1
}

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -h|--help)
            usage
            ;;
        --*)
            echo "Unknown option: $key"
            usage
            ;;
        *)
            if [ ! -d "$key" ]; then
                echo "Unknown option or invalid directory path: $key"
                usage
            fi
            break
            ;;
    esac
done

# Get source directory from command-line argument or use default value
source_dir="${1}"
# check if ${1} is empty
if [ -z "$source_dir" ]; then
    echo "Missing source directory"
    usage
fi

# Get destination directory from command-line argument or use default value
destination_dir="${2:-$HOME/tmp-backup-projects}"

# Function to copy necessary .git files
copy_git_files() {
    # Get the relative path of the .git folder from the source directory
    rel_path="${git_dir#$source_dir}"

    echo "Copy $git_dir necessary files to $destination_dir$rel_path"
    
    # Create the corresponding subdirectories in the destination directory
    mkdir -p "$destination_dir$rel_path"
    
    # Copy the .git folder to the destination directory
    cp "$git_dir/config" "$destination_dir$rel_path"
    cp "$git_dir/HEAD" "$destination_dir$rel_path"
    cp "$git_dir/index" "$destination_dir$rel_path"
    cp -R "$git_dir/refs" "$destination_dir$rel_path"
    cp -R "$git_dir/objects" "$destination_dir$rel_path"
}

# Create the destination directory if it doesn't exist
mkdir -p "$destination_dir"

find "$source_dir" -type d -name ".git" -not -path "*/.git/*" | while read -r git_dir; do
    copy_git_files

    echo "Folders structure and .git folders have been copied to $destination_dir"
done

# Check if the user wants to run Zip commands
# Zip the new projects folder and then delete it
echo "Zipping the projects. This may take a while..."
cd "$destination_dir" && zip --quiet -r "../backup-git-projects.zip" "./"
echo "Zip file has been created in $destination_dir.zip."
echo "Cleaning up..."
cd ".."
rm -rf "$destination_dir"

echo "Folders structure and .git folders have been copied to $destination_dir"
