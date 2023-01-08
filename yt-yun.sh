#!/bin/bash

url="${@: -1}" 
vid=`docker run -i --rm falconchen/amd64-yt-dlp --get-id ${url}`

localDir=/mnt/tmp/Youtube/video/${vid}
caiyunDir=/mnt/caiyunDisk/Youtube/video/`date +"%Y-%m-%d"`
nohupOutDir=/mnt/tmp/log

echo "================"
echo $localDir
mkdir -p ${localDir} 2>/dev/null
docker run -i --rm -v ${localDir}:/data falconchen/amd64-yt-dlp $@

mkdir -p ${caiyunDir} 2>/dev/null

echo "move to ${caiyunDir}"

mkdir -p ${nohupOutDir} 2>/dev/null

mv -vf ${localDir}/* ${caiyunDir} >${nohupOutDir}/${vid} 2>&1 
rmdir ${localDir}


#echo "delete tmp dir ${localDir}" 
#rm -rf ${localDir}
