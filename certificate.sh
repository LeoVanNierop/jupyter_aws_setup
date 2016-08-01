#!/bin/bash



#get certification

if [ $# -eq 1 ]; then
    printf '\n' | ./certbot-auto certonly --debug --standalone -d $1
else
  echo "supply domain name as command line argument"
fi