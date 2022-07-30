#!/bin/bash

#vid=$(head -20 /dev/urandom | cksum | cut -f1 -d " ")
url="${@: -1}" 
vid=${url#*?v=}


localDir=/mnt/tmp/Youtube/video/${vid}
caiyunDir=/mnt/caiyunDisk/Youtube/video/`date +"%Y-%m-%d"`
nohupOutDir=/mnt/tmp/log

echo "url: $url"
echo "tmpDir: $localDir"
echo "hkcmd tail -f ${nohupOutDir}/${vid}"

mkdir -p ${localDir} 2>/dev/null
mkdir -p ${caiyunDir} 2>/dev/null
mkdir -p ${nohupOutDir} 2>/dev/null

nohup bash -c "docker run -i --rm -v ${localDir}:/data falconchen/amd64-yt-dlp \
\"$@\"  && \

cd $localDir && \
zip -r ${vid}.zip *

echo \"move to ${caiyunDir}\" && \
mv -vf ${localDir}/${vid}.zip ${caiyunDir} && \
echo \"remove ${localDir}\" && \
rm -rf ${localDir}" \
>${nohupOutDir}/${vid} 2>&1 &

exit

#echo "delete tmp dir ${localDir}" 
#rm -rf ${localDir}
