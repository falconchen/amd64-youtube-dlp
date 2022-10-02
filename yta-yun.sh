#!/bin/bash

vid=$(head -20 /dev/urandom | cksum | cut -f1 -d " ")
url="${@: -1}"
vid=${url#*?v=}

localDir=/mnt/tmp/Youtube/audio/${vid}
caiyunDir=/mnt/caiyunDisk/Youtube/audio/`date +"%Y-%m-%d"`
nohupOutDir=/tmp/youtube-cy

echo "================"
echo $localDir
mkdir -p ${localDir} 2>/dev/null
docker run -i --rm -v ${localDir}:/data falconchen/amd64-yt-dlp -f bestaudio --audio-format mp3 --audio-quality 0 $@

mkdir -p ${caiyunDir} 2>/dev/null

echo "move to ${caiyunDir}"

mkdir -p ${nohupOutDir} 2>/dev/null

mv -vf ${localDir}/* ${caiyunDir} >${nohupOutDir}/${vid} 2>&1 
rmdir ${localDir}


#echo "delete tmp dir ${localDir}" 
#rm -rf ${localDir}
