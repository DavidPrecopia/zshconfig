#!/bin/zsh

DOWNLOAD_DIR="$HOME/Downloads"

cd "$DOWNLOAD_DIR" || exit 1

for f in *.webm; do
  [[ -e "$f" ]] || continue
  out="${f%.*}.mp4"
  echo "Converting: $f → $out"
  ffmpeg -i "$f" -c:v libx264 -crf 23 -preset fast -c:a aac -b:a 192k "$out" && rm "$f"
done