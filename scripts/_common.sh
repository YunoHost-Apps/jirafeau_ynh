#!/bin/bash

# Migrate files folder
find files -type f ! -name "*_count" | while read f; do bn="$(basename "$f")"; dst="files/${bn:0:8}/${bn:8:8}/${bn:16:8}/${bn:24:8}/"; mkdir -p "$dst"; mv "$f" "$dst" ; mv "${f}_count" "$dst"; done; find files -maxdepth 1 -type d -iname "?" -exec rm -rf {} \;

# Migrate links folder
find links -type f | while read link; do bn="$(basename "$link")"; mkdir "links/$bn"; mv "$link" "links/$bn/"; done; find links -maxdepth 1 -type d -iname "?" -exec rm -rf {} \;
