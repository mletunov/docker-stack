#!/bin/bash

# dependencies
apt-get update && apt-get -y install wget build-essential cmake \
    pkg-config libtiff5-dev libjasper-dev libpng12-dev

# download and untar opencv archive
WORK=/tmp/opencv
mkdir -p $WORK && cd $WORK \
&& wget $1 -O opencv.tar.gz \
&& tar xvf opencv.tar.gz \
&& rm opencv.tar.gz \
&& cd *

# build and install
mkdir release && cd release \
&& cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D WITH_QT=OFF \
    -D WITH_GTK=OFF \
    -D PYTHON2_EXECUTABLE=/opt/conda/envs/python2/bin/python \
    -D PYTHON2_PACKAGES_PATH=/opt/conda/envs/python2/lib/python2.7/site-packages \
    -D PYTHON2_INCLUDE_DIR=/opt/conda/envs/python2/include/python2.7 \
    -D PYTHON2_LIBRARY=/opt/conda/envs/python2/lib/libpython2.7.so \
    -D BUILD_opencv_python2=ON \
    -D PYTHON3_EXECUTABLE=/opt/conda/bin/python3 \
    -D PYTHON3_PACKAGES_PATH=/opt/conda/lib/python3.5/site-packages \
    -D PYTHON3_INCLUDE_DIR=/opt/conda/include/python3.5m \
    -D PYTHON3_LIBRARY=/opt/conda/lib/libpython3.5m.so \
    -D BUILD_opencv_python3=ON \
    -D WITH_FFMPEG=ON \
    .. \
&& make && cd .. \
&& checkinstall -D -y --pkglicense='BSD' --maintainer='opencv' --requires='libpng12-0,libtiff5,libjasper1' make install -C release \
&& ldconfig

#clean up
cp *.deb /tmp && rm $WORK -rf