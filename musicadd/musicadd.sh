#!/bin/bash

MUSIC_DIR="/remote/archive/music"
#MUSIC_DIR="/remote/archive/music/Stone Temple Pilots"
DB_NAME="music_collection"

if [ -f /tmp/find_results ]; then
  cat /dev/null > /tmp/find_results
fi

find "$MUSIC_DIR" -name '*.mp3' >> /tmp/find_results
counter=0
while read -r current_song
  do
    id3tool "$current_song" > /tmp/current_track
    track_title=$(grep -E 'Song Title' /tmp/current_track| cut -d ':' -f2 | sed 's/^[[:space:]]*//')
    track_artist=$(grep -E 'Artist' /tmp/current_track| cut -d ':' -f2 | sed 's/^[[:space:]]*//')
    track_album=$(grep -E 'Album' /tmp/current_track| cut -d ':' -f2 | sed 's/^[[:space:]]*//')
    track_filepath=$current_song
    echo "Adding $track_title by $track_artist"
    cat >> script.js <<EOF
var track = {
  Title : "$track_title",
  Artist : "$track_artist",
  Album : "$track_album",
  Filepath: "$track_filepath"
}
db.$DB_NAME.insert(track);
EOF
  mongo 127.0.0.1/$DB_NAME script.js
  rm -rf script.js
  counter=$((counter+1))
  echo "$DB_NAME should contain $counter records"
  done < /tmp/find_results
