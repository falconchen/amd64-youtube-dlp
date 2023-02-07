#!/bin/bash
set -x

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

title=`docker run -i --rm -v ${localDir}:/data falconchen/amd64-yt-dlp -e ${url}`
tarName="${title:0:70}-${vid}.tar"
tarName=${tarName// /_}
tarName=${tarName//|/_}
tarName=${tarName//\"/_}
tarName=${tarName//\'/_}

if [ -f "${caiyunDir}/${tarName}" ]; then
   echo "Skip, Exits on yun Disk"
   exit
fi

docker run -i --rm -v ${localDir}:/data falconchen/amd64-yt-dlp \
-f '22/(bv*[vcodec^=vp9][height<=1024]+ba[acodec=opus])/137+ba[ext=m4a]/137+ba/302+ba[ext=m4a]/302+ba/bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo[ext=mp4]+(258/256/140)/bestvideo[ext=webm]+(250/249)/bestvideo[ext=webm]+bestaudio/mp4/best' \
"$@" 

cd $localDir && \


rm -rf "${tarName}" 2>/dev/null
tar cfv "${tarName}" *

echo "move to ${caiyunDir}" && \
mv -vf "${localDir}/${tarName}" ${caiyunDir} && \
echo "remove ${localDir}" && \
rm -rf "${localDir}" \

exit

