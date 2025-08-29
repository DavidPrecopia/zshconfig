#!/bin/zsh

DOWNLOAD_DIR="$HOME/Downloads"
cd "$DOWNLOAD_DIR" || exit 1

for f in *.webm; do 
  ffmpeg -i "$f" -c:v libx265 -crf 20 -preset slow -pix_fmt yuv420p10le -x265-params "colorprim=bt2020:transfer=arib-std-b67:colormatrix=bt2020nc" -tag:v hvc1 -c:a aac -b:a 192k "${f%.webm}.mp4" && rm "$f";
done