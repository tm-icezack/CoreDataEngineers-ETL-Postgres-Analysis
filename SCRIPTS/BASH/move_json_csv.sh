#!/bin/bash
# move_json_csv.sh
# A simple script to move all CSV and JSON files into one folder

# Destination folder inside home
DEST=~/json_and_CSV

# Create destination folder if it doesn't exist
mkdir -p "$DEST"

# Move CSV files
mv *.csv "$DEST" 2>/dev/null

# Move JSON files
mv *.json "$DEST" 2>/dev/null

# Done
echo "All CSV and JSON files moved to $DEST"
