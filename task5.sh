#!/bin/bash

show_menu() {
    echo "1. Copy the file"
    echo "2. Delete the file"
    echo "3. Display the content of a file"
    echo "4. Exit"
}

while true; do
    show_menu
    read choice
    case $choice in
        1)
            echo "Enter file path:"
            read file_path
            echo "Enter destination:"
            read destination
            cp "$file_path" "$destination"
            echo "Copied successfully";;
        2)
            echo "Enter file path:"
            read file_path
            rm "$file_path"
            echo "Removed successfully";;
        3)
            echo "Enter file path:"
            read file_path
            cat "$file_path";;
        4)
            echo "Bye"
            exit;;
        *)
            echo "Invalid input"
    esac
done

