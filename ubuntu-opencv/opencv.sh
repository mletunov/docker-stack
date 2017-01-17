#!/bin/bash

# dependencies
sudo apt-get -y install build-essential cmake pkg-config
sudo apt-get -y install libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev

# download and untar zipped opencv archive
WORK=/tmp/opencv
mkdir $WORK && cd $WORK
wget $1 -O opencv.tar.gz
tar xvzf opencv.tar.gz && rm opencv.tar.gz

# build and install
cd *
mkdir release
cd release
cmake -D CMAKE_BUILD_TYPE=RELEASE \
  -D CMAKE_INSTALL_PREFIX=/usr/local \
  -D WITH_QT=OFF \
  -D WITH_GTK=OFF \
  -D PYTHON2_EXECUTABLE=/usr/bin/python \
  -D BUILD_opencv_python2=ON \
  -D PYTHON3_EXECUTABLE=/usr/bin/python3 \
  -D BUILD_opencv_python3=ON \
  -D WITH_FFMPEG=ON \
  ..

make
cd ..

sudo apt-get -y install libpng12-0 libtiff5 libjasper1
sudo checkinstall -D -y --pkglicense='BSD' --maintainer='opencv' --requires='libpng12-0,libtiff5,libjasper1' make install -C release
sudo ldconfig
sudo rm $WORK -rf