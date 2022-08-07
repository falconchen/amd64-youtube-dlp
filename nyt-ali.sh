#!/bin/bash


SHELL_FOLDER=/root/docker-configs/youtube-dlp
cd $SHELL_FOLDER
echo "hkcmd tail -f $SHELL_FOLDER/ali.log"
nohup bash $SHELL_FOLDER/yt-ali.sh "$@" >>ali.log 2>&1 & 
exit



