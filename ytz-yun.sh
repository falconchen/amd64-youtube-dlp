#!/bin/bash
set -x


url="${@: -1}" 
vid=`docker run -i --rm falconchen/amd64-yt-dlp --get-id ${url}`


localDir=/mnt/tmp/Youtube/video/${vid}
caiyunDir=/mnt/alist/139yun/Youtube/video/`date +"%Y-%m-%d"`
#caiyunDir=/mnt/caiyunDisk/Youtube/video/`date +"%Y-%m-%d"`
nohupOutLog=/root/docker-configs/youtube-dlp/nyt-yun.log

echo "url: $url"
echo "tmpDir: $localDir"


mkdir -p ${localDir} 2>/dev/null
# -d 参数判断 $folder 是否存在
#if [ ! -d "${caiyunDir}"]; then
#  mkdir "$caiyunDir"
#fi

mkdir "$caiyunDir" 2>/dev/null
mkdir -p ${nohupOutDir} 2>/dev/null

title=`docker run -i --rm -v ${localDir}:/data falconchen/amd64-yt-dlp -e ${url}`
thumbnail=`docker run -i --rm -v ${localDir}:/data falconchen/amd64-yt-dlp --get-thumbnail ${url}`
thumbnail=${thumbnail//i\.ytimg\.com/txhk\.cellmean.\com\/ytimg}
thumbnail=${thumbnail//http:/https:}
echo $thumbnail
#--get-thumbnail 
zipName="${title:0:70}-${vid}.zip"
zipName=${zipName// /_}
zipName=${zipName//\//_}
zipName=${zipName//|/_}
zipName=${zipName//\"/_}
zipName=${zipName//\'/_}


if [ -f "${caiyunDir}/${zipName}" ]; then
   echo "Skip, Exits on yun Disk"
   exit
fi

docker run -i --rm -v ${localDir}:/data falconchen/amd64-yt-dlp \
-f '22/(bv*[vcodec^=vp9][height<=1024]+ba[acodec=opus])/137+ba[ext=m4a]/137+ba/302+ba[ext=m4a]/302+ba/bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo[ext=mp4]+(258/256/140)/bestvideo[ext=webm]+(250/249)/bestvideo[ext=webm]+bestaudio/mp4/best' \
"$@" 

cd $localDir && \


rm -rf "${zipName}" 2>/dev/null
zip -r "${zipName}" *

echo "move to ${caiyunDir}" 
icon="✅"
error=`mv -vf "${localDir}/${zipName}" ${caiyunDir} `
if [[ "$?" -ne "0" ]];then 
   
   echo $error
   error = "Error: ${error}, remount!"
   icon="❌"
   source /root/docker-configs/caiyun-webdav.sh
   source /root/docker-configs/alist-mount.sh

else
	error=""
fi

echo "remove ${localDir}"
rm -rf "${localDir}" 

sleep 1
#bark "☁️ ${title}" "`tail -n 3  ${nohupOutLog}`" ${thumbnail} >/dev/null 
bark "${icon}☁️ ${title}" "${error}"  ${thumbnail}  ${thumbnail//@100w_100h_1c.png/}>/dev/null 

exit

