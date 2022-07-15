#!/bin/bash


#SHELL_FOLDER=$(cd "$(dirname "$0")";pwd)
SHELL_FOLDER=/root/docker-configs/youtube-dlp
cd $SHELL_FOLDER
nohup bash $SHELL_FOLDER/yt-all.sh "$@" >>all.log 2>&1 & 
exit



