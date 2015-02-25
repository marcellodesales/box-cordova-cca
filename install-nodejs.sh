#!/bin/sh

# Add repository
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo apt-get update -y

# Install nodejs
sudo apt-get install -y nodejs

# Install global nodejs packages
sudo npm install -g gulp-cli
sudo npm install -g cordova ionic
sudo npm install -g bower
