FROM gliderlabs/alpine:3.3
MAINTAINER Bruno Celeste <bruno@coconut.co>

ENV FFMPEG_VERSION=git

WORKDIR /tmp/ffmpeg

RUN apk add --update build-base curl nasm tar bzip2 git \
  zlib-dev openssl-dev yasm-dev lame-dev libogg-dev x264-dev libvpx-dev libvorbis-dev x265-dev freetype-dev libass-dev libwebp-dev rtmpdump-dev libtheora-dev opus-dev && \

  DIR=$(mktemp -d) && cd ${DIR} && \

  git clone git://source.ffmpeg.org/ffmpeg.git ffmpeg-${FFMPEG_VERSION} && \
  cd ffmpeg-${FFMPEG_VERSION} && \
  ./configure \
  --enable-version3 --enable-gpl --enable-nonfree --enable-small --enable-libmp3lame --enable-libx264 --enable-libx265 --enable-libvpx --enable-libtheora --enable-libvorbis --enable-libopus --enable-libass --enable-libwebp --enable-librtmp --enable-postproc --enable-avresample --enable-libfreetype --enable-openssl --disable-debug && \
  make && \
  make install && \
  make distclean && \

  rm -rf ${DIR} && \
  apk del build-base curl tar bzip2 git x264 openssl nasm && rm -rf /var/cache/apk/*

ENTRYPOINT ["ffmpeg"]