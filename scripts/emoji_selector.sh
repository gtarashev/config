#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cat $SCRIPT_DIR/emoji.txt | dmenu -l 30 -fn "Oxygen Mono:size=16" -fn "AppleColorEmoji:pixelsize=16:antialias=true:autohint=true" | cut -d " " -f 1 | tr -d "\n" | xclip -i
