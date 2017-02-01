#!/bin/bash

# dependencies
sudo apt-get -y install autoconf automake build-essential libass-dev libfreetype6-dev \
  libtheora-dev libtool libvorbis-dev pkg-config texinfo zlib1g-dev

# download and untar zipped ffmpeg archive
WORK=/tmp/ffmpeg
mkdir $WORK && cd $WORK
wget $1 -O ffmpeg.tar.gz
tar xvzf ffmpeg.tar.gz && rm ffmpeg.tar.gz

# use LGPL license, without ffprobe and ffserver libraries
cd *
./configure --enable-shared --disable-yasm --disable-ffprobe --disable-ffserver

# build and install
make
sudo checkinstall -D -y --pkglicense='LGPLv2.1' --maintainer='ffmpeg'
sudo ldconfig
cp *.deb /tmp && rm $WORK -rf