#!/bin/bash

# python 3.5
apt-get -y install python3.5 python3-pip
python3 -m pip install --upgrade pip
python3 -m pip install numpy scipy tensorflow keras

# python 2.7
apt-get -y install python2.7 python-pip
python -m pip install --upgrade pip
python -m pip install numpy scipy tensorflow keras