#!/bin/bash
# Update apt-get
apt-get update

export DEBIAN_FRONTEND=noninteractive

# We need unzip
apt-get install -y ruby build-essential ruby-dev ruby-augeas

# Ruby
cd /home/infrastructure
gem install bundler
bundler install
