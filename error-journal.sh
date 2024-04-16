#!/bin/bash

if [ $# -eq 0 ]; then
    date="-1 day"
else
    case "$1" in
        "day") date="-1 day" ;;
        "week") date="-1 week" ;;
        "month") date="-1 month" ;;
    esac
fi

echo "$1 statistics:"
echo "------------ERRORS-------------:"
journalctl --since "$date" --output=short-iso | awk '/error/' | sort | uniq

echo "------------WARNINGS----------"
journalctl --since "$date" --output=short-iso | awk '/warning/ ' | sort | uniq

