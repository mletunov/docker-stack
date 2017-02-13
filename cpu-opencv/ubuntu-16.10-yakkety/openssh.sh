#!/bin/bash

if [ "$1" == "start" ]; then
    /usr/sbin/sshd -D
elif [ "$1" == "stop" ]; then
    /etc/init.d/ssh stop
elif [ "$1" == "add" ]; then
    USER=$2
    PASS=$3
    useradd -d / -s /bin/bash -p $(openssl passwd -1 $PASS) -g sudo $USER
fi