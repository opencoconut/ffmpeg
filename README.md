# FFmpeg Docker image

[![Build Status](https://dev.azure.com/pcosta-fccn/Docker%20base%20images/_apis/build/status/fccn.ffmpeg?branchName=master)](https://dev.azure.com/pcosta-fccn/Docker%20base%20images/_build/latest?definitionId=3?branchName=master)

Minimal FFmpeg Docker image built on Alpine Linux, started as a fork from the [opencoconut/ffmpeg]( https://github.com/opencoconut/ffmpeg) project. Since version 4 it uses concepts from
[jrottenberg/ffmpeg:4.0-scratch](https://hub.docker.com/r/jrottenberg/ffmpeg/) for multi-stage building and FFmpeg libs compilation stage.

## About

FFmpeg version 4.1.3 running on Alpine 3.8

```
  
  ffmpeg version 4.1.3 Copyright (c) 2000-2019 the FFmpeg developers
  ffprobe version 4.1.3 Copyright (c) 2007-2018 the FFmpeg developers
  
  built with gcc 6.4.0 (Alpine 6.4.0)
  configuration: --disable-debug --disable-doc --disable-ffplay --enable-shared --enable-avresample --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-gpl --enable-libass --enable-libfreetype --enable-libvidstab --enable-libmp3lame --enable-libopenjpeg --enable-libopus --enable-libtheora --enable-libvorbis --enable-libvpx --enable-libx265 --enable-libxvid --enable-libx264 --enable-nonfree --enable-openssl --enable-libfdk_aac --enable-libkvazaar --enable-libaom --extra-libs=-lpthread --enable-postproc --enable-small --enable-version3 --extra-cflags=-I/opt/ffmpeg/include --extra-ldflags=-L/opt/ffmpeg/lib --extra-libs=-ldl --prefix=/opt/ffmpeg
  libavutil      56. 22.100 / 56. 22.100
  libavcodec     58. 35.100 / 58. 35.100
  libavformat    58. 20.100 / 58. 20.100
  libavdevice    58.  5.100 / 58.  5.100
  libavfilter     7. 40.101 /  7. 40.101
  libavresample   4.  0.  0 /  4.  0.  0
  libswscale      5.  3.100 /  5.  3.100
  libswresample   3.  3.100 /  3.  3.100
  libpostproc    55.  3.100 / 55.  3.100

  configuration:
    --disable-debug
    --disable-doc
    --disable-ffplay
    --enable-shared
    --enable-avresample
    --enable-libopencore-amrnb
    --enable-libopencore-amrwb
    --enable-gpl
    --enable-libass
    --enable-libfreetype
    --enable-libvidstab
    --enable-libmp3lame
    --enable-libopenjpeg
    --enable-libopus
    --enable-libtheora
    --enable-libvorbis
    --enable-libvpx
    --enable-libx265
    --enable-libxvid
    --enable-libx264
    --enable-nonfree
    --enable-openssl
    --enable-libfdk_aac
    --enable-libkvazaar
    --enable-libaom
    --extra-libs=-lpthread
    --enable-postproc
    --enable-small
    --enable-version3
    --extra-cflags=-I/opt/ffmpeg/include
    --extra-ldflags=-L/opt/ffmpeg/lib
    --extra-libs=-ldl
    --prefix=/opt/ffmpeg
```

## Install

Clone this project and build the docker image locally using the Makefile.
```sh
$ git clone https://github.com/fccn/ffmpeg.git
$ cd ffmpeg
$ make build
```

This creates a new image named *stvfccn/ffmpeg*. You can create the image by yourself using the following docker command:
```sh
$ docker build -t <your image name>

```
The examples below consider the image is named *stvfccn/ffmpeg*

To use this Docker container like FFmpeg is installed on your machine, you can create an alias to use a Docker container from this image:

To make it available for a single user, in `~/.bashrc` do:

```
alias ffmpeg='docker run -v=`pwd`:/tmp/ffmpeg stvfccn/ffmpeg'
alias ffprobe='docker run -it -v=`pwd`:/tmp/ffmpeg --entrypoint=ffprobe stvfccn/ffmpeg'
```

After reloading the console or calling `source ~/.bashrc`, FFmpeg can be called like:

```
$ ffmpeg -buildconf
```

If you want to make the aliases available to all users, add the file provided in **scripts/ffmpeg-aliases.sh** to */etc/profile.d/*
```sh
$ cp scripts/ffmpeg-aliases.sh /etc/profile.d/
$ source /etc/profile.d/ffmpeg-aliases.sh
```

To build the image and enable the system aliases do:
```sh
$ make dist
```

## Usage

This image is available on docker hub as [stvfccn/ffmpeg](https://hub.docker.com/r/stvfccn/ffmpeg). To encode a remote file run:

```sh
$ docker run stvfccn/ffmpeg -i http://files.coconut.co.s3.amazonaws.com/test.mp4 -f webm -c:v libvpx -c:a libvorbis - > test.webm
```

or if you enabled the aliases, like this:

```sh
$ ffmpeg -i http://files.coconut.co.s3.amazonaws.com/test.mp4 -f webm -c:v libvpx -c:a libvorbis test.webm
```

To encode a local file, you can mount the current path on the Docker host's filesystem as a volume inside the container like this:

```sh
$ docker run -v=`pwd`:/tmp/ffmpeg stvfccn/ffmpeg -i localfile.mp4 out.webm
```

or if you enabled the aliases:

```sh
$ ffmpeg -i localfile.mp4 out.webm
```

### Build image

A build version of this image is also available on docker hub under the *:build-{version}* or *:build-latest* tags. You can use this image to copy the FFMpeg libs and binaries to your images by adding the following line to your Dockerfile:

```
COPY --from stvfccn/ffmpeg:build-latest /

```

## Author
Original Version from Bruno Celeste (http://coconut.co)
- Twitter: @OpenCoconut,  @brunoceleste

Multi-stage build adapted from [jrottenberg/ffmpeg:4.0-scratch](https://hub.docker.com/r/jrottenberg/ffmpeg/)

Modification by Paulo Costa

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/fccn/ffmpeg/tags).

### changelog
- 3.0.X - removed openssl, added libfdk_aac, updated FFmpeg version to 3.4.2
- 4.0.0 - using multi-stage build with ffmpeg compilation, updated to FFmpeg 4.0.2, pushed image to docker hub

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
