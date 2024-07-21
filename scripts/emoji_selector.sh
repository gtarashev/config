#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
to_copy=$(cat $SCRIPT_DIR/emoji.txt | dmenu -l 30 -fn "Oxygen Mono:size=16" -fn "AppleColorEmoji:pixelsize=16:antialias=true:autohint=true" | cut -d " " -f 1 | tr -d "\n")
if [[ "$(loginctl show-session 1 -p Type | cut -d '=' -f 2)" == "wayland" ]]; then
    wl-copy -p $to_copy
else
    xclip -o $to_copy
fi
