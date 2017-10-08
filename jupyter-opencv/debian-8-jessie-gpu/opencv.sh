#!/bin/bash


# dependencies
apt-get -y install wget build-essential cmake checkinstall \
    pkg-config libtiff5-dev libjasper-dev libpng12-dev

pip install numpy

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
    -D INSTALL_PYTHON_EXAMPLES=OFF \
    -D BUILD_EXAMPLES=OFF \
    -D BUILD_PERF_TESTS=OFF \
    -D BUILD_TESTS=OFF \
    -D PYTHON3_EXECUTABLE=/opt/conda/bin/python3 \
    -D PYTHON3_PACKAGES_PATH=/opt/conda/lib/python3.6/site-packages \
    -D PYTHON3_INCLUDE_DIR=/opt/conda/include/python3.6m \
    -D PYTHON3_LIBRARY=/opt/conda/lib/libpython3.6m.so \
    -D BUILD_opencv_python3=ON \
    -D WITH_FFMPEG=ON \
    -D WITH_CUDA=ON \
    -D WITH_CUBLAS=ON \
    -D WITH_CUFFT=ON \
    -D CUDA_FAST_MATH=ON \
    -D ENABLE_FAST_MATH=ON \
    -D CUDA_ARCH_BIN="3.0 3.5 3.7 5.0 5.2 6.0 6.1" \
    .. \
&& make && cd .. \
&& checkinstall -D -y --pkglicense='BSD' --maintainer='opencv' --requires='libpng12-0,libtiff5,libjasper1' make install -C release \
&& ldconfig

#clean up
cp *.deb /tmp && rm $WORK -rf