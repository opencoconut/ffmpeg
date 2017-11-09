# FFmpeg Docker image

Minimal FFmpeg Docker image built on Alpine Linux, a fork from the [opencoconut/ffmpeg]( https://github.com/opencoconut/ffmpeg) project.

**changes:** removed openssl, added libfdk_aac, updated ffmpeg version to 3.3.2

## About

FFmpeg version 3.3.2

```
ffmpeg version 3.3.2 Copyright (c) 2000-2017 the FFmpeg developers
  built with gcc 6.3.0 (Alpine 6.3.0)
  configuration: --enable-version3 --enable-gpl --enable-nonfree --enable-small --enable-libmp3lame --enable-libfdk_aac --enable-libx264 --enable-libx265 --enable-libvpx --enable-libtheora --enable-libvorbis --enable-libopus --enable-libass --enable-libwebp --enable-librtmp --enable-postproc --enable-avresample --enable-libfreetype --disable-debug --enable-static --disable-shared

  configuration:
    --enable-version3
    --enable-gpl
    --enable-nonfree
    --enable-small
    --enable-libmp3lame
    --enable-libfdk_aac
    --enable-libx264
    --enable-libx265
    --enable-libvpx
    --enable-libtheora
    --enable-libvorbis
    --enable-libopus
    --enable-libass
    --enable-libwebp
    --enable-librtmp
    --enable-postproc
    --enable-avresample
    --enable-libfreetype
    --disable-debug
    --enable-static
    --disable-shared
  libavutil      55. 58.100 / 55. 58.100
  libavcodec     57. 89.100 / 57. 89.100
  libavformat    57. 71.100 / 57. 71.100
  libavdevice    57.  6.100 / 57.  6.100
  libavfilter     6. 82.100 /  6. 82.100
  libavresample   3.  5.  0 /  3.  5.  0
  libswscale      4.  6.100 /  4.  6.100
  libswresample   2.  7.100 /  2.  7.100
  libpostproc    54.  5.100 / 54.  5.100

```
Image size is 119MB

## Install

Clone this project and build the docker image locally using the Makefile.
```sh
$ git clone https://github.com/fccn/ffmpeg.git
$ cd ffmpeg
$ make image
```

This creates a new image named *fccn/ffmpeg*. You can create the image by yourself using the following docker command:
```sh
$ docker build -t <your image name>

```
The examples below consider the image is named *fccn/ffmpeg*

To use this Docker container like FFmpeg is installed on your machine, you can create an alias to use a Docker container from this image:

To make it available for a single user, in `~/.bashrc` do:

```
alias ffmpeg='docker run -v=`pwd`:/tmp/ffmpeg fccn/ffmpeg'
alias ffprobe='docker run -it -v=`pwd`:/tmp/ffmpeg --entrypoint=ffprobe fccn/ffmpeg'
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

Assuming that the image created was named **fccn/ffmpeg** you can encode a remote file like this:

```sh
$ docker run fccn/ffmpeg -i http://files.coconut.co.s3.amazonaws.com/test.mp4 -f webm -c:v libvpx -c:a libvorbis - > test.webm
```

or if you enabled the aliases, like this:

```sh
$ ffmpeg -i http://files.coconut.co.s3.amazonaws.com/test.mp4 -f webm -c:v libvpx -c:a libvorbis test.webm
```

To encode a local file, you can mount the current path on the Docker host's filesystem as a volume inside the container like this:

```sh
$ docker run -v=`pwd`:/tmp/ffmpeg fccn/ffmpeg -i localfile.mp4 out.webm
```

or if you enabled the aliases:

```sh
$ ffmpeg -i localfile.mp4 out.webm
```

## Author
Original Version from Bruno Celeste (http://coconut.co)
- Twitter: @OpenCoconut,  @brunoceleste

Modification by Paulo Costa

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/fccn/ffmpeg/tags).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
