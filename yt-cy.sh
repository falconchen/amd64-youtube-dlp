#!/bin/bash

randnum=$(head -20 /dev/urandom | cksum | cut -f1 -d " ")

localDir=/mnt/tmp/Youtube/video/${randnum}
caiyunDir=/mnt/caiyunDisk/Youtube/video/`date +"%Y-%m-%d"`

echo $localDir
mkdir -p ${localDir} 2>/dev/null
docker run -i --rm -v ${localDir}:/data falconchen/amd64-yt-dlp $@

mkdir -p ${caiyunDir} 2>/dev/null

echo "copy to ${caiyunDir}"
cp -ru ${localDir}/* ${caiyunDir}

echo "delete tmp dir ${localDir}" 
rm -rf ${localDir}
