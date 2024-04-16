#!/bin/bash

backup_directory() {
    user_dir="$1"
    backup_dir="$2"
    exclude_files="$3"

    if [ ! -d "$user_dir" ]; then
        echo "Enter existing directory"
        return 1
    fi

    if [ ! -d "$backup_dir" ]; then
        mkdir -p "$backup_dir"
    fi

    backup_filename="backup.tar.gz"
    backup_file="$backup_dir/$backup_filename"

    if [ -n "$exclude_files" ]; then
        tar -czf "$backup_file" --exclude="$exclude_files" "$user_dir"
    else
        tar -czf "$backup_file" "$user_dir"
    fi

    echo "Backup was successfully created with name: $backup_file"
}

restore_directory() {
    backup_file="$1"
    restore_dir="$2"
    include_file="$3"

    if [ ! -f "$backup_file" ]; then
        echo "Error: $backup_file is not a file"
        return 1
    fi

    if [ -d "$restore_dir" ]; then
        read -p " $restore_dir already exists. Rewrite it? (y/n) " -n 1 -r
        echo
        if [ "$REPLY" != "y" ]; then
            return 1
        fi
    else
        mkdir -p "$restore_dir"
    fi

    if [ -n "$include_file" ]; then
        while IFS= read -r file; do
            tar -xzf "$backup_file" -C "$restore_dir" "$file"
        done < "$include_file"
    else
        tar -xzf "$backup_file" -C "$restore_dir"
    fi
    echo "Restoring complelety finished to $restore_dir"
}

while true; do
    read -p " 1 - create backup, 2 - restore from backup, 3 - exit: " choice
    case $choice in
        1)
            read -p "Enter path to dir to backup: " user_dir
            read -p "Enter path to dir where backup would be created: " backup_dir
            read -p "Enter exceptions: " exclude_files
            backup_directory "$user_dir" "$backup_dir" "$exclude_files"
            ;;
        2)
            read -p "Enter backup path: " backup_file
            read -p "Enter dir where backup would be restored: " restore_dir
            read -p "Enter exceptions: " include_file
            restore_directory "$backup_file" "$restore_dir" "$include_file"
            ;;
        3)
            echo "Bye"
            exit 0
            ;;
        *)
            echo "Invalid input. Enter number from 1 to 3"
            ;;
    esac
done
