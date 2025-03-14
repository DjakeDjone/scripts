#!/bin/bash

set -e  # Exit immediately if a command fails

# Define the screenshot file path
SCREENSHOT_PATH=~/Downloads/screenshot.png

# Use gnome-screenshot to capture a selected area
if ! gnome-screenshot --area --file="$SCREENSHOT_PATH"; then
    notify-send "OCR Cancelled" "No screenshot was captured."
    exit 1
fi

# Check if the screenshot was taken (i.e., file is not empty)
if [ ! -s "$SCREENSHOT_PATH" ]; then
    notify-send "OCR Cancelled" "No screenshot was captured."
    exit 1
fi

# Use Tesseract to extract text and copy it to the clipboard
if tesseract "$SCREENSHOT_PATH" stdout | xclip -selection clipboard; then
    notify-send "OCR Complete" "Extracted text has been copied to the clipboard."
else
    notify-send "OCR Failed" "Text extraction encountered an error."
    exit 1
fi
