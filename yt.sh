#!/bin/bash

localDir=/mnt/tmp/Youtube/video/`date +"%Y-%m-%d"`
yterDir=/mnt/tmp/Youtube/yter
echo "----------"
echo $localDir
mkdir -p ${localDir} 2>/dev/null
mkdir -p ${yterDir} 2>/dev/null
docker run -i --rm -v ${localDir}:/data -v ${yterDir}:/yter falconchen/amd64-yt-dlp --embed-subs  -f '200/bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo[ext=mp4]+(258/256/140)/bestvideo[ext=webm]+(250/249)/bestvideo[ext=webm]+bestaudio/mp4/best' --exec "echo \"${@: -1}\" > /yter/%(id)s" $@
