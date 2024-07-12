#!/bin/bash
cat ./emoji.txt | dmenu -l 30 -fn "Oxygen Mono:size=16" -fn "AppleColorEmoji:pixelsize=16:antialias=true:autohint=true" | cut -d " " -f 1 | xclip -i
