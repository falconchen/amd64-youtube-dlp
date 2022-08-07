#!/bin/bash


SHELL_FOLDER=/root/docker-configs/youtube-dlp
cd $SHELL_FOLDER
echo "hkcmd tail -f $SHELL_FOLDER/nyt.log"
nohup bash $SHELL_FOLDER/yti.sh "$@" >>nyt.log 2>&1 & 
exit



