#!/bin/bash

# dependencies
apt-get install -y wget xz-utils checkinstall build-essential \
    libass-dev libfreetype6-dev libtheora-dev libtool libvorbis-dev pkg-config texinfo zlib1g-dev

# download and untar ffmpeg archive
WORK=/tmp/ffmpeg
mkdir -p $WORK && cd $WORK \
&& wget $1 -O ffmpeg.tar.xz \
&& tar xvf ffmpeg.tar.xz \
&& rm ffmpeg.tar.xz \
&& cd *

# use LGPL license, without ffprobe and ffserver libraries
./configure --enable-shared --disable-yasm --disable-ffprobe --disable-ffserver && make \
&& mkdir -p /usr/local/share/doc && mkdir -p /usr/local/share/ffmpeg \
&& checkinstall -D -y --pkglicense='LGPLv2.1' --maintainer='ffmpeg' \
&& ldconfig

#clean up
cp *.deb /tmp && rm $WORK -rf