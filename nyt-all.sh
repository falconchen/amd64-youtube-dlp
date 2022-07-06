#!/bin/bash

SHELL_FOLDER=$(cd "$(dirname "$0")";pwd)
nohup bash $SHELL_FOLDER/yt-all.sh "$@" >>all.log 2>&1 & 
exit



