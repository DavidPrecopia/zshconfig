#!/bin/zsh

DOWNLOAD_DIR="$HOME/Downloads"
cd "$DOWNLOAD_DIR" || exit 1
# Enable extended globbing to match multiple extensions
setopt extendedglob

# Check if there are any .mkv or .webm files in the directory
# The (N) at the end makes the pattern return nothing instead of an error if no files match
files=(*.(mkv|webm)(N))

if (( ${#files[@]} == 0 )); then
  echo "No .mkv nor .webm files found"
  exit 0
fi

for file in "${files[@]}"; do
  output="${file:r}.mp4"
  echo "Converting '$file'..."
  ffmpeg -i "$file" -c:v libx264 -crf 23 -preset fast -c:a aac -b:a 192k "$output"
  
  if [[ $? -eq 0 ]]; then
    echo "Successfully"
    rm "$file"
  else
    echo "Error converting '$file'"
  fi
done