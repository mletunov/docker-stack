#!/bin/bash

# install JRE 8
echo 'deb http://deb.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list

JAVA_DEBIAN_VERSION="8u121-b13-1~bpo8+1"
CA_CERTIFICATES_JAVA_VERSION="20161107~bpo8+1"

apt-get update && apt-get install -y \
    openjdk-8-jre-headless="$JAVA_DEBIAN_VERSION" \
    ca-certificates-java="$CA_CERTIFICATES_JAVA_VERSION" \
    && rm -rf /etc/apt/sources.list.d/* \
    && rm -rf /var/lib/apt/lists/*

/var/lib/dpkg/info/ca-certificates-java.postinst configure