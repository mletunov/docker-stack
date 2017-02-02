#!/bin/bash

# python 3.5
apt-get -y install python3.5 python3-pip
python3 -m pip install --upgrade pip
python3 -m pip install numpy scipy tensorflow tensorflow-gpu keras

# python 2.7
apt-get -y install python2.7 python-pip
python -m pip install --upgrade pip
python -m pip install numpy scipy tensorflow tensorflow-gpu keras

# check GPUs
#from tensorflow.python.client import device_lib

#def get_available_gpus():
#    local_device_protos = device_lib.list_local_devices()
#    return [x.name for x in local_device_protos if x.device_type == 'GPU']