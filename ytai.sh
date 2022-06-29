#!/bin/bash
localDir=/mnt/sda3/Youtube/audio/`date +"%Y-%m-%d"`
echo $localDir
mkdir -p ${localDir} 2>/dev/null
docker run -i --rm -v ${localDir}:/data falconchen/amd64-yt-dlp -f bestaudio -o "/data/%(channel)s_%(id)s.%(ext)s" $@
