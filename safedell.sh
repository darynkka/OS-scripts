#!/bin/bash

dir="/home/$(whoami)/safe"

if [ "$1" = "skip" ]
then
    skip=true
else
    skip=false
fi

if ! "$skip" 
then
    if [ ! -d "$dir" ]
    then
        mkdir "$dir"
        echo "Created a directory to copy files"
    fi

    for file in "$@"
    do    
        cp -r "$file" "$dir"
        echo "Copying to dir was successfully done!"
        rm -r "$file"
        echo "Deleting was successfully done"
    done
else
    for file in "$@"
    do
	if [ "$file" != "skip" ] 
	then    	
        rm -r "$file"
        echo "Skipping copying, deleting immediately"
	fi
    done
fi



