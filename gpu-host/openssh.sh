#!/bin/bash

apt-get update && apt-get install -y sudo openssh-server && \
   /etc/init.d/ssh start
USER=test PASS=test
useradd -d / -s /bin/bash -p $(openssl passwd -1 $PASS) -g sudo $USER