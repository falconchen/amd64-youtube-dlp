#!/bin/bash

docker run -i --rm -v `pwd`:/data falconchen/amd64-yt-dlp $@
