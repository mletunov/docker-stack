#!/bin/bash

# install nvidia driver
# apt-cache search nvidia | grep -P '^nvidia-[0-9]+\s' - nvidia proprietary driver list
sudo apt-get update && sudo apt-get install -y nvidia-375
sudo systemctl enable multi-user.target
sudo systemctl set-default multi-user.target
# sudo apt install nvidia-current - maybe works
# nvidia-driver installs X11 libraries and after reboot system will start with GUI, multi-user.target turn off GUI
# reboot is needed after intall!

# install last stable docker 
sudo curl -fsSL https://get.docker.com/ | sh
# sudo usermod -aG docker $(whoami) - allow to launch docker without specify sudo
# sudo usermod -aG docker username - allow to launch docker without sudo by specified user (username)
# relogin after that!

# install nvidia docker plugin to use GPU into containers
# nvidia-docker_1.0.0
wget -O nvidia-docker.deb https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.1/nvidia-docker_1.0.1-1_amd64.deb && \
sudo apt-get install -y ./nvidia-docker.deb && rm nvidia-docker.deb

# nvidia-smi - all information about GPU and installed driver
# NV_GPU=0,1 nvidia-docker run ... - run container with nvidia driver working with GPU 0 and 1, specifying GPU helps to isolate GPU from each other