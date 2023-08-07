# Bash Script: Project Backup and Git Init

## Description

This Bash script allows you to create a backup of project directories and optionally initialize Git repositories for each project folder. 
The script will copy the necessary `.git` files (config, HEAD, index, refs, and objects) from the source directory to the destination directory, preserving the folder structure.

## Real-life usage

You can use this package to create a backup of your projects that you want to move to another folder on your computer or directly to another computer.
With the **Backup** script you can create a zip file containing your projects on which you use Git as a versioning system (the script only backs up the .git folders, not the entire project).
With the **Restore** script, you can rebuild the folder structure of your projects in a folder you specify (on your new computer, for example). The script can also take care of reinitializing your Git projects so you don't have to run `git clone` on all folders.

## Backup

```bash
bash backup_git.sh [OPTIONS] [SOURCE_DIR] [DESTINATION_DIR]
```

### Options

- `--git`: Run Git commands to initialize new project folders, fetch all branches, and reset to the HEAD commit.

### Arguments

- `SOURCE_DIR` (optional): The source directory containing your project folders. Default is `$HOME/projects`.
- `DESTINATION_DIR` (optional): The destination directory where the project backup will be created. Default is `$HOME/backup-projects`.

### Backup Examples

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

### Note

- The **backup script** will create the destination directory if it doesn't exist.
- Ensure you have proper permissions to read and write in the source and destination directories.
- Use this script with **caution**, as it will overwrite any existing files in the destination directory if they have the same names.

## Restore

```bash
bash restore_backup.sh [SOURCE_ZIP] [DESTINATION_DIR]
```

### Arguments

- `SOURCE_ZIP` (required): The source zip file containing your projects backup (See: **Backup**).
- `DESTINATION_DIR` (optional): The destination directory where the projects backup will be unzipped. Default is `$HOME/projects`.

## Authors

- Alessandro Pietrantonio <pietrantonio.alessandro@gmail.com>

## TODO
- [ ] Run git commands after restoration