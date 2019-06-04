#!/bin/bash
curl -s whatismyip.host | grep ipaddress | head -1 | cut -d '>' -f2 | cut -d '<' -f1 > /home/sthompson/Dropbox/cloud/currentip.txt
date >> /home/sthompson/Dropbox/cloud/currentip.txt
