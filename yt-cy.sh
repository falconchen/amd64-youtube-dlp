#!/bin/bash

randnum=$(head -20 /dev/urandom | cksum | cut -f1 -d " ")

localDir=/mnt/tmp/Youtube/video/${randnum}
caiyunDir=/mnt/caiyunDisk/Youtube/video/`date +"%Y-%m-%d"`
nohupOutDir=/tmp/youtube-cy

echo $localDir
mkdir -p ${localDir} 2>/dev/null
docker run -i --rm -v ${localDir}:/data falconchen/amd64-yt-dlp $@

mkdir -p ${caiyunDir} 2>/dev/null

echo "move to ${caiyunDir}"

mkdir -p ${nohupOutDir} 2>/dev/null

nohup mv -vf ${localDir}/* ${caiyunDir} >${nohupOutDir}/${randnum} 2>&1 &

exit

#echo "delete tmp dir ${localDir}" 
#rm -rf ${localDir}
