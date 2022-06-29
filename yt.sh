#!/bin/bash
echo $PATH

localDir=/mnt/sda3/Youtube/video/`date +"%Y-%m-%d"`
echo $localDir
mkdir -p ${localDir} 2>/dev/null
docker run -i --rm -v ${localDir}:/data falconchen/amd64-yt-dlp $@
