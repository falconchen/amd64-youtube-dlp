#!/bin/bash

localDir=/mnt/tmp/Youtube/video/`date +"%Y-%m-%d"`
mkdir -p ${localDir} 2>/dev/null
docker run -i --rm -v ${localDir}:/data falconchen/amd64-yt-dlp $@
