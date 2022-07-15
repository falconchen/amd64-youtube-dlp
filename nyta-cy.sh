#!/bin/bash

randnum=$(head -20 /dev/urandom | cksum | cut -f1 -d " ")

localDir=/mnt/tmp/Youtube/audio/${randnum}
caiyunDir=/mnt/caiyunDisk/Youtube/audio/`date +"%Y-%m-%d"`
nohupOutDir=/tmp/youtube-cy

echo "tmpDir: $localDir"
echo "hkcmd tail -f ${nohupOutDir}/${randnum}"

mkdir -p ${localDir} 2>/dev/null
mkdir -p ${caiyunDir} 2>/dev/null
mkdir -p ${nohupOutDir} 2>/dev/null

#nohup bash -c "docker run -i --rm -v ${localDir}:/data falconchen/amd64-yt-dlp -f bestaudio[ext=m4a]/best[ext=mp4]/best  \"$@\"  && \
nohup bash -c "docker run -i --rm -v ${localDir}:/data falconchen/amd64-yt-dlp -f bestaudio[ext=m4a]/bestaudio[ext=mp4]/bestaudio[ext=webm] \
  \"$@\"  && \
echo \"move to ${caiyunDir}\" && \
mv -vf ${localDir}/* ${caiyunDir} && \
rm -rf ${localDir}" \
>${nohupOutDir}/${randnum} 2>&1 &

exit

#echo "delete tmp dir ${localDir}" 
#rm -rf ${localDir}
