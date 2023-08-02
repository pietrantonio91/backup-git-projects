#!/bin/bash

# Function to display usage and exit
usage() {
    echo "Usage: $0 [OPTIONS] [SOURCE_DIR] [DESTINATION_DIR]"
    echo "Options:"
    echo "  --git   : Run Git commands to init new project folders, fetch all branches and restart to HEAD"
    exit 1
}

# Variable to check if the user wants to run Git commands
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
            if [ ! -d "$key" ]; then
                echo "Unknown option or invalid directory path: $key"
                usage
            fi
            break
            ;;
    esac
done

# Get source directory from command-line argument or use default value
source_dir="${1:-$HOME/projects}"

# Get destination directory from command-line argument or use default value
destination_dir="${2:-$HOME/backup-projects}"

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
    
    # Check if the user wants to run Git commands
    if [ "$run_git" = true ]; then
        # Enter the new projects folders and run Git commands
        cd "$destination_dir$rel_path/.."
        git init
        git fetch --all
        git reset --hard HEAD
        git clean -fd
        # Return to the source directory
        cd "$source_dir"
    fi
done

echo "Folders structure and .git folders have been copied to $destination_dir"
