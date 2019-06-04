#!/bin/bash

# Install the GPG key
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -

# Set apt to work with https sources
sudo apt-get install apt-transport-https

# Select a channel
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

# Update the cache and install sublime-text
sudo apt-get update
sudo apt-get install sublime-text
