#!/bin/bash

# This is for AWS only
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
echo "Will execute user-data"

# Update/Install packages
aptitude -y update 
aptitude -y safe-upgrade 
aptitude -y install sun-java6-jre
aptitude -y install unzip
aptitude -y install git

# Setup go user and group
groupadd go
useradd -g go -p /home/go -m go
cd /home/go

# Download go-server ZIP install
git clone git@github.com:jdamore/go-config.git
unzip ./go-config/dist/go-server-2.4.0-14481

# Run install script
. ./go-config/bin/go-server-setup.sh