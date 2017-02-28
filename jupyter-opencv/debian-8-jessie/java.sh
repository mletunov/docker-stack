#!/bin/bash

# install JAVA
apt-get update && apt-get install -y default-jre

# install coursier
curl -L -o coursier https://git.io/vgvpD && chmod +x coursier
mv coursier /usr/local/bin/coursier