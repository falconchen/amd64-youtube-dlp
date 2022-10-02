#!/bin/bash

randnum=$(head -20 /dev/urandom | cksum | cut -f1 -d " ")

localDir=/mnt/tmp/Youtube/video/${randnum}
caiyunDir=/mnt/caiyunDisk/Youtube/video/`date +"%Y-%m-%d"`
nohupOutDir=/tmp/youtube-cy

echo "tmpDir: $localDir"
echo "hkcmd tail -f ${nohupOutDir}/${randnum}"

mkdir -p ${localDir} 2>/dev/null
mkdir -p ${caiyunDir} 2>/dev/null
mkdir -p ${nohupOutDir} 2>/dev/null

nohup bash -c "docker run -i --rm -v ${localDir}:/data falconchen/amd64-yt-dlp \
-f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo[ext=mp4]+(258/256/140)/bestvideo[ext=webm]+(250/249)/bestvideo[ext=webm]+bestaudio/mp4/best' \"$@\"  && \
echo \"move to ${caiyunDir}\" && \
mv -vf ${localDir}/* ${caiyunDir} && \
rm -rf ${localDir}" \
>${nohupOutDir}/${randnum} 2>&1 &

exit

#echo "delete tmp dir ${localDir}" 
#rm -rf ${localDir}
