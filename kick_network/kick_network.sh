#!/bin/bash

success_code="200"
# Restart network manager
sudo systemctl restart NetworkManager.service

# Takes a second so wait
sleep 10

# Check result
return=$(curl -s -o /dev/null -w "%{http_code}" https://www.google.com)
if [ "$return" != "$success_code" ]; then
    echo "Did not work. Check host connection"
else
    echo "Good to go"
fi