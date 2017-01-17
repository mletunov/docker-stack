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
  ..

make
cd ..

sudo apt-get -y install libpng12-0 libtiff5 libjasper1
sudo checkinstall -D -y --pkglicense='BSD' --maintainer='opencv' --requires='libpng12-0,libtiff5,libjasper1' make install -C release
sudo ldconfig
sudo rm $WORK -rf