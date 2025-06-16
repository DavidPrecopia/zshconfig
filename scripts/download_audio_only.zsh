#!/bin/zsh

if [[ -z "$1" ]]; then
  echo "Usage: $0 <video_url>"
  exit 1
fi

URL="$1"
DOWNLOAD_DIR="$HOME/Downloads"

cd "$DOWNLOAD_DIR" || exit 1

if [[ "$URL" == *"playlist"* || "$URL" == *"&list="* ]]; then
  echo "Detected playlist."
  yt-dlp -x --audio-format mp3 --yes-playlist -o "%(playlist_index)s - %(title)s.%(ext)s" "$URL"
else
  echo "Detected single video."
  yt-dlp -x --audio-format mp3 "$URL"
  filename=$(yt-dlp "$URL" --print filename)
fi