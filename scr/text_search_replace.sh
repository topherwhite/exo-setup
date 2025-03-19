#!/usr/bin/env bash
#
# Usage:
#    ./replace_string.sh <filepath> <search_string> <replace_string>
#
# Example:
#    ./replace_string.sh /path/to/file.txt old_string new_string
#
# This script modifies the file in-place (no backup).

# Ensure exactly 3 arguments were provided
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <filepath> <search_string> <replace_string>"
  exit 1
fi

FILEPATH="$1"
SEARCH_STRING="$2"
REPLACE_STRING="$3"

# Check if file exists
if [ ! -f "$FILEPATH" ]; then
  echo "Error: File '$FILEPATH' not found."
  exit 1
fi

# Use sed to replace in-place
sed -i '' "s/$SEARCH_STRING/$REPLACE_STRING/g" "$FILEPATH"

echo "All occurrences of '$SEARCH_STRING' have been replaced with '$REPLACE_STRING' in '$FILEPATH'."