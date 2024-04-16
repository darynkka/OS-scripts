#!/bin/bash
echo "Enter any arguments"
echo "1.1"
for argument in "$@" 
do 
  echo "$argument"
done 

echo "1.2(1,3,2,4)"
echo "$1"
echo "$3"
echo "$2"
echo "$4"


echo "1.3"
for argument in $(printf "%s\n" "$@" | sort) 
do 
  echo -n  "$argument "
done 
exit 0
