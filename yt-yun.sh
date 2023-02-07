#!/bin/bash

url="${@: -1}" 
vid=`docker run -i --rm falconchen/amd64-yt-dlp --get-id ${url}`

localDir=/mnt/tmp/Youtube/video/${vid}
caiyunDir=/mnt/caiyunDisk/Youtube/video/`date +"%Y-%m-%d"`
nohupOutDir=/mnt/tmp/log

echo "================"
echo $localDir
mkdir -p ${localDir} 2>/dev/null
docker run -i --rm -v ${localDir}:/data falconchen/amd64-yt-dlp \
-f '(bv*[vcodec^=vp9][height<=1024]+ba[acodec=opus])/137+ba[ext=m4a]/137+ba/302+ba[ext=m4a]/302+ba/bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo[ext=mp4]+(258/256/140)/bestvideo[ext=webm]+(250/249)/bestvideo[ext=webm]+bestaudio/mp4/best' \
$@

mkdir -p ${caiyunDir} 2>/dev/null

echo "move to ${caiyunDir}"

mkdir -p ${nohupOutDir} 2>/dev/null

mv -vf ${localDir}/* ${caiyunDir} >${nohupOutDir}/${vid} 2>&1 
rmdir ${localDir}


#echo "delete tmp dir ${localDir}" 
#rm -rf ${localDir}
