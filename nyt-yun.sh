#!/bin/bash


SHELL_FOLDER=/root/docker-configs/youtube-dlp
cd $SHELL_FOLDER
echo "hkcmd tail -f $SHELL_FOLDER/nyt-yun.log"
nohup bash $SHELL_FOLDER/yt-yun.sh "$@" >>nyt-yun.log 2>&1 & 
exit



