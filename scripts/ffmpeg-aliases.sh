#!/bin/bash
#
# add ffmpeg aliases to all users in the machine
#
alias ffmpeg='docker run -v=`pwd`:/tmp/ffmpeg stvfccn/ffmpeg'
alias ffprobe='docker run -it -v=`pwd`:/tmp/ffmpeg --entrypoint=ffprobe stvfccn/ffmpeg'
