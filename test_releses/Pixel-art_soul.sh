#!/bin/sh
echo -ne '\033c\033]0;Pixel-art_soul\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Pixel-art_soul.x86_64" "$@"
