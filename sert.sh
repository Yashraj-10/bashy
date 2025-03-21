#!/usr/bin/env bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <filepath> <line1> <line2>"
    exit 1
fi::

# Assign arguments to variables
filepath=$1
line1=$2
line2=$3

# Check if the file exists
if [ ! -f "$filepath" ]; then
    echo "File $filepath does not exist."
    exit 1
fi

# Check if line1 and line2 are valid numbers
if ! [[ $line1 =~ ^[0-9]+$ ]] || ! [[ $line2 =~ ^[0-9]+$ ]]; then
    echo "Both lines must be numbers."
    exit 1
fi

# Determine the start and end lines
start_line=$(( line1 < line2 ? line1 : line2 ))
end_line=$(( line1 > line2 ? line1 : line2 ))

# Extract lines before the start line
before=$(sed -n "1,$((start_line-1))p" "$filepath")

# Extract lines between start_line and end_line, sort them
sorted=$(sed -n "${start_line},${end_line}p" "$filepath" | sort)

# Extract lines after the end line
after=$(sed -n "$((end_line+1)),$ p" "$filepath")

# Remove the lines that need sorting from the file
# sed -i "${start_line},${end_line}d" "$filepath"

# Append the sorted lines and the lines after the end line
echo "$before" > "$filepath"
echo "$sorted" >> "$filepath"
echo "$after" >> "$filepath"