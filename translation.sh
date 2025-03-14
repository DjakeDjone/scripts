#!/bin/bash

# Check to ensure required commands are available
for cmd in xclip trans notify-send; do
    if ! command -v "$cmd" &>/dev/null; then
        echo "Error: $cmd is not installed. Exiting."
        exit 1
    fi
done

# Get the selected text from primary selection.
# xclip is used with the primary selection buffer.
selected_text=$(xclip -o -selection primary)

# Check if selected_text is empty.
if [ -z "$selected_text" ]; then
    notify-send "Translation Error" "No text selected."
    exit 1
fi

# Translate the selected text to German.
# The -b flag outputs only the translated text.
translated_text=$(trans -b -t de "$selected_text")

# Check if translation succeeded.
if [ -z "$translated_text" ]; then
    notify-send "Translation Error" "Translation failed."
    exit 1
fi

# Send a notification with the translated text.
notify-send "Translated Text (German)" "$translated_text"
