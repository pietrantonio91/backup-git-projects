# Bash Script: Project Backup and Git Init

## Description

This Bash script allows you to create a backup of project directories and optionally initialize Git repositories for each project folder. 
The script will copy the necessary `.git` files (config, HEAD, index, refs, and objects) from the source directory to the destination directory, preserving the folder structure.

## Usage

```bash
bash backup_git.sh [OPTIONS] [SOURCE_DIR] [DESTINATION_DIR]
```

### Options

- `--git`: Run Git commands to initialize new project folders, fetch all branches, and reset to the HEAD commit.

### Arguments

- `SOURCE_DIR` (optional): The source directory containing your project folders. Default is `$HOME/projects`.
- `DESTINATION_DIR` (optional): The destination directory where the project backup will be created. Default is `$HOME/backup-projects`.

## Examples

1. To copy the project folders without running Git commands:

```bash
bash backup_git.sh /path/to/source_dir /path/to/destination_dir
```

2. To copy the project folders and run Git commands for each new project:

```bash
bash backup_git.sh --git /path/to/source_dir /path/to/destination_dir
```

3. To display usage information:

```bash
bash backup_git.sh --help
```

## Note

- The script will create the destination directory if it doesn't exist.
- Ensure you have proper permissions to read and write in the source and destination directories.
- Use this script with **caution**, as it will overwrite any existing files in the destination directory if they have the same names.

## Authors

- Alessandro Pietrantonio <pietrantonio.alessandro@gmail.com>
