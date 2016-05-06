CoreOS AWS Helper scripts
================

Project: [https://github.com/sstarcher/docker-awscli]
(https://github.com/sstarcher/docker-awscli)

Docker image: [https://registry.hub.docker.com/u/sstarcher/aws-tools/]
(https://registry.hub.docker.com/u/sstarcher/aws-tools/)

[![](https://badge.imagelayers.io/sstarcher/aws-tools:latest.svg)](https://imagelayers.io/?images=sstarcher/aws-tools:latest 'Get your own badge on imagelayers.io')
[![Docker Registry](https://img.shields.io/docker/pulls/sstarcher/aws-tools.svg)](https://registry.hub.docker.com/u/sstarcher/aws-tools)&nbsp;

## Basics

* Command List
```docker run -it sstarcher/aws-tools help```
* aws - direct access to awscli
* dns - allows to point a dns entry to the instance
* ebs - attaches a pre-exiting ebs volume to this instance by volume id or volume name tag
* eip - attaches a pre-exiting eip to this instance
* eni - attaches an existing interface to this server

# Eni
Configures the ENI that has been attached as a secondary interface
```
#! /bin/bash
set -e
/usr/bin/ip link set eth1 up
until ip route | grep default | grep eth1
do
  echo "Try again"
  sleep 0.5
done
ip route delete $(ip route | grep default | grep eth1);
GATEWAY=$(route -n | grep 'UG[ \t]' | awk '{print $2}')
ip route add default via $GATEWAY dev eth1 table 11
PRIVATE_IP=$(ip addr | awk '/inet/ && /eth1/{sub(/\/.*$/,"",$2); print $2}')
ip rule add from $PRIVATE_IP lookup 11
```