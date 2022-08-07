#!/bin/bash


LOCAL_DIR=/mnt/tmp/Youtube/video/
EXPIRE_DAYS=3
find ${LOCAL_DIR}  -mtime +${EXPIRE_DAYS} | xargs rm -rf
