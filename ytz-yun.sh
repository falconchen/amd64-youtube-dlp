#!/bin/bash

url="${@: -1}" 
vid=`docker run -i --rm falconchen/amd64-yt-dlp --get-id ${url}`


localDir=/mnt/tmp/Youtube/video/${vid}
caiyunDir=/mnt/caiyunDisk/Youtube/video/`date +"%Y-%m-%d"`
nohupOutDir=/mnt/tmp/log

echo "url: $url"
echo "tmpDir: $localDir"
echo "hkcmd tail -f ${nohupOutDir}/${vid}"

mkdir -p ${localDir} 2>/dev/null
mkdir -p ${caiyunDir} 2>/dev/null
mkdir -p ${nohupOutDir} 2>/dev/null

docker run -i --rm -v ${localDir}:/data falconchen/amd64-yt-dlp \
-f '22/(bv*[vcodec^=vp9][height<=1024]+ba[acodec=opus])/137+ba[ext=m4a]/137+ba/302+ba[ext=m4a]/302+ba/bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo[ext=mp4]+(258/256/140)/bestvideo[ext=webm]+(250/249)/bestvideo[ext=webm]+bestaudio/mp4/best' \
"$@" 

cd $localDir && \
title=`docker run -i --rm -v ${localDir}:/data falconchen/amd64-yt-dlp -e ${url}`
zipName="${title:0:42}-${vid}.zip"
rm -rf "${zipName}" 2>/dev/null
zip -r "${zipName}" *

echo "move to ${caiyunDir}" && \
mv -vf "${localDir}/${zipName}" ${caiyunDir} && \
echo "remove ${localDir}" && \
rm -rf "${localDir}" \

exit

