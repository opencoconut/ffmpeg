# FFmpeg Docker image

Minimal FFmpeg Docker image built on Alpine Linux, a fork from the [opencoconut/ffmpeg]( https://github.com/opencoconut/ffmpeg) project.

**changes:** removed openssl, added libfdk_aac, updated ffmpeg version to 3.3.2

## About

FFmpeg version 3.3.2

```
ffmpeg version 3.3.2 Copyright (c) 2000-2017 the FFmpeg developers
  built with gcc 6.3.0 (Alpine 6.3.0)
  configuration: --enable-version3 --enable-gpl --enable-nonfree --enable-small --enable-libmp3lame --enable-libfdk_aac --enable-libx264 --enable-libx265 --enable-libvpx --enable-libtheora --enable-libvorbis --enable-libopus --enable-libass --enable-libwebp --enable-librtmp --enable-postproc --enable-avresample --enable-libfreetype --disable-debug
  libavutil      55. 58.100 / 55. 58.100
  libavcodec     57. 89.100 / 57. 89.100
  libavformat    57. 71.100 / 57. 71.100
  libavdevice    57.  6.100 / 57.  6.100
  libavfilter     6. 82.100 /  6. 82.100
  libavresample   3.  5.  0 /  3.  5.  0
  libswscale      4.  6.100 /  4.  6.100
  libswresample   2.  7.100 /  2.  7.100
  libpostproc    54.  5.100 / 54.  5.100

  configuration:
    --enable-version3
    --enable-gpl
    --enable-nonfree
    --enable-small
    --enable-libmp3lame
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
    --enable-openssl
    --disable-debug
```

## Install

Clone this project and build the docker image locally using the Makefile.
```bash
git clone https://github.com/fccn/ffmpeg.git
cd ffmpeg
make image
```

You can also create the image by yourself using the following docker command:
```bash
docker build -t <your image name>

```

## Usage

Assuming you used the makefile to create the docker image, or that the image you created was named **fccn/ffmpeg** you can encode a remote file like this:

```
$ docker run fccn/ffmpeg -i http://files.coconut.co.s3.amazonaws.com/test.mp4 -f webm -c:v libvpx -c:a libvorbis - > test.webm
```

To encode a local file, you can mount the current path on the Docker host's filesystem as a volume inside the container like this:

```
$ docker run -v=`pwd`:/tmp/ffmpeg fccn/ffmpeg -i localfile.mp4 out.webm
```

You can create an alias so you use the Docker container like if FFmpeg is installed on your computer:

In `~/.bashrc`:

```
alias ffmpeg='docker run -v=`pwd`:/tmp/ffmpeg fccn/ffmpeg'
alias ffprobe='docker run -it -v=`pwd`:/tmp/ffmpeg --entrypoint=ffprobe fccn/ffmpeg'
```

Now we can execute FFmpeg with just:

```
$ ffmpeg -buildconf
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
