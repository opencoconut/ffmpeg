FROM alpine:3.6
MAINTAINER Paulo Costa <paulo.costa@fccn.pt>

#--removed openssl, added libfdk_aac, updated ffmpeg version to 3.4.2

ENV FFMPEG_VERSION=3.4.2

WORKDIR /tmp/ffmpeg

#add testing and community repositories - required for fdk-aac
RUN echo '@testing http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
  echo '@community http://nl.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && \
  echo '@edge http://nl.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories && \
  apk update && apk upgrade --no-cache --available
RUN apk add --upgrade apk-tools@edge

#install dependencies
RUN apk add --update build-base curl nasm tar bzip2 \
  zlib-dev yasm-dev lame-dev libogg-dev x264-dev libvpx-dev libvorbis-dev x265-dev freetype-dev libass-dev libwebp-dev rtmpdump-dev libtheora-dev opus-dev fdk-aac-dev@testing && \
  DIR=$(mktemp -d) && cd ${DIR} && \
  curl -s http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.gz | tar zxvf - -C . && \
  cd ffmpeg-${FFMPEG_VERSION} && \
  ./configure \
  --enable-version3 --enable-gpl --enable-nonfree --enable-small --enable-libmp3lame --enable-libfdk_aac --enable-libx264 --enable-libx265 --enable-libvpx --enable-libtheora --enable-libvorbis --enable-libopus --enable-libass --enable-libwebp --enable-librtmp --enable-postproc --enable-avresample --enable-libfreetype --disable-debug --enable-static --disable-shared && \
  make && \
  make install && \
  make distclean && \
  rm -rf ${DIR} && \
  apk del build-base curl tar bzip2 x264 openssl nasm && rm -rf /var/cache/apk/*

ENTRYPOINT ["ffmpeg"]
