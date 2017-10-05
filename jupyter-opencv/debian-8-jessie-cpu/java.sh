#!/bin/bash


# install JRE 8
apt-get update \
 && apt-get install -y openjdk-8-jre-headless \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*