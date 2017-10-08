#/bin/bash


sudo apt-get install -y linux-virtual linux-cloud-tools-virtual && \
sudo apt-get purge -y linux*azure && \
sudo apt-get autoremove -y && \
sudo apt-get clean && \
sudo reboot