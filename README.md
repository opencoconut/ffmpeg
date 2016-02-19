# Minimal FFmpeg Docker image built on Alpine Linux

The image is only **106.7 MB** versus ~350 MB.

Current FFmpeg version: `3.0`

## FFmpeg Build Configuration

```
ffmpeg version 3.0 Copyright (c) 2000-2016 the FFmpeg developers
  built with gcc 5.3.0 (Alpine 5.3.0)
  configuration: --enable-version3 --enable-gpl --enable-nonfree --enable-small --enable-libmp3lame --enable-libx264 --enable-libx265 --enable-libvpx --enable-libtheora --enable-libvorbis --enable-libopus --enable-libass --enable-libwebp --enable-librtmp --enable-postproc --enable-avresample --enable-libfreetype --enable-openssl --disable-debug
  libavutil      55. 17.103 / 55. 17.103
  libavcodec     57. 24.102 / 57. 24.102
  libavformat    57. 25.100 / 57. 25.100
  libavdevice    57.  0.101 / 57.  0.101
  libavfilter     6. 31.100 /  6. 31.100
  libavresample   3.  0.  0 /  3.  0.  0
  libswscale      4.  0.100 /  4.  0.100
  libswresample   2.  0.101 /  2.  0.101
  libpostproc    54.  0.100 / 54.  0.100

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

## Usage

```
$ docker run opencoconut/ffmpeg -i http://files.coconut.co.s3.amazonaws.com/test.mp4 -f webm -c:v libvpx -c:a libvorbis - > test.webm
```

To encode a local file, you can mount the current path on the Docker host's filesystem as a volume inside the container like this:

```
$ docker run -v=`pwd`:/tmp/ffmpeg opencoconut/ffmpeg -i localfile.mp4 out.webm
```

You can create an alias so you use the Docker container like if FFmpeg is installed on your computer:

In `~/.bashrc`:

```
alias ffmpeg='docker run -v=`pwd`:/tmp/ffmpeg opencoconut/ffmpeg'
```

Now we can execute FFmpeg with just:

```
$ ffmpeg -buildconf
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Author

**Bruno Celeste**

http://coconut.co

[@OpenCoconut](http://twitter.com/OpenCoconut)

You can contact me directly on Twitter [@brunoceleste](http://twitter.com/brunoceleste)
