# Bash Script: Project Backup and Git Init

<p align="center">
<img alt="Static Badge" src="https://img.shields.io/badge/license-GPL_v3-green">
<img alt="Static Badge" src="https://img.shields.io/badge/version-v0.0.1-blue">
</p>

## Description

This Bash script allows you to create a backup of project directories and optionally initialize Git repositories for each project folder. 
The script will copy the necessary `.git` files (config, HEAD, index, refs, and objects) from the source directory to the destination directory, preserving the folder structure.

## Real-life usage

You can use this package to create a backup of your projects that you want to move to another folder on your computer or directly to another computer.
With the **Backup** script you can create a zip file containing your projects on which you use Git as a versioning system (the script only backs up the .git folders, not the entire project).
With the **Restore** script, you can rebuild the folder structure of your projects in a folder you specify (on your new computer, for example). The script can also take care of reinitializing your Git projects so you don't have to run `git clone` on all folders.

---
## Backup

```bash
bash backup_git.sh source_dir [destination_dir]
```

#### Arguments

- `source_dir`: The source directory containing your project folders.
- `destination_dir` (optional): The temporary destination directory where the project backup will be created. This directory is automatically destroyed at the end. Default is `$HOME/tmp-backup-projects`.

### Backup Examples

1. To copy the project folders in the default tmp directory:

```bash
bash backup_git.sh /path/to/source_dir
```

2. To use a custom tmp directory:

```bash
bash backup_git.sh /path/to/source_dir /path/to/destination_dir
```

3. To display usage information:

```bash
bash backup_git.sh --help
```

### Note

- The **backup script** will create the destination directory if it doesn't exist.
- Ensure you have proper permissions to read and write in the source and destination directories.
- Use this script with **caution**, as it will overwrite any existing files in the **destination directory** if they have the same names.

---

## Restore

```bash
bash restore_backup.sh [options] source_zip destination_dir
```

### Options

- `--git`: Reinitialize Git repositories in the destination directory. Default is `false`.
- `--help`|`-h`: Display usage information.

### Arguments

- `source_zip`: The source zip file containing your projects backup (See: **Backup**).
- `destination_dir`: The destination directory where the projects backup will be unzipped.

---

## Authors

- Alessandro Pietrantonio <pietrantonio.alessandro@gmail.com>

## License

This project is licensed under the GNU General Public License v3 - see the [LICENSE](LICENSE) file for details.
