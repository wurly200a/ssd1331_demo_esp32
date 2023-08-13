#!/bin/bash

if [ $(dirname $0) = . ]; then
echo "This script should be run in one directory above."
exit
fi

if [ -z "$IDF_PATH" ]; then
. $HOME/esp/esp-idf/export.sh
fi

SRC_DIR=lcdgfx
SRC_GIT_URL=https://github.com/lexus2k/lcdgfx.git
SRC_GIT_TAG=v1.1.5

if [ ! -d ${SRC_DIR} ]; then
    mkdir -p $(dirname ${SRC_DIR})
    git clone ${SRC_GIT_URL} -b ${SRC_GIT_TAG} ${SRC_DIR}
fi

cd ${SRC_DIR}
idf.py set-target esp32

# File path
file_path="examples/demos/ssd1331_demo/ssd1331_demo.ino"
# Line number to comment out
line_number=37
# Content of the new line
new_line="DisplaySSD1331_96x64x8_SPI display(4,{-1, 17, 16, 0,18,23});"
# Temporary file names
temp_unix_file="${file_path}.unix"
temp_windows_file="${file_path}.windows"
# Copy the original file and convert line endings to Unix format
cp --no-preserve=mode,timestamps "$file_path" "$temp_unix_file"
sed -i 's/\r$//' "$temp_unix_file"
# Check if the new line is a duplicate of an existing line
is_duplicate=$(awk -v new_line="$new_line" '{
    if ($0 == new_line) {
        print "true"
        exit
    }
}' "$temp_unix_file")
# Exit the script if there is a duplicate
if [ "$is_duplicate" == "true" ]; then
    echo "The new line already exists. Not adding it."
else
    awk -v line_number="$line_number" -v new_line="$new_line" '{
        if (NR == line_number) {
            print "//" $0
            print new_line
        } else {
            print $0
        }
    }' "$temp_unix_file" > "$temp_windows_file"
    # Convert line endings back to Windows format
    sed -i 's/$/\r/' "$temp_windows_file"
    # Overwrite the original file with the recovered Windows-format file
    mv "$temp_windows_file" "$file_path"
fi
# Remove temporary files
rm "$temp_unix_file"

cd tools
./build_and_run.sh -p esp32 demos/ssd1331_demo
