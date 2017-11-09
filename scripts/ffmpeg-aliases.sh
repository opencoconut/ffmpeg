#!/bin/bash
#
# add ffmpeg aliases to all users in the machine
#
alias ffmpeg='docker run -v=`pwd`:/tmp/ffmpeg fccn/ffmpeg'
alias ffprobe='docker run -it -v=`pwd`:/tmp/ffmpeg --entrypoint=ffprobe fccn/ffmpeg'
