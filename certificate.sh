#!/bin/bash

#get certification
printf '\n' | ./certbot-auto certonly --debug --standalone -d external_host