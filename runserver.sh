#!/bin/bash
while true; do { echo -e 'HTTP/1.1 200 OK\r\n'; cat /tmp/certbot/public_html/.well-known/acme-challenge/Ph_6XjD1VJuJlPMG56YUWhBGzrJHAo1iVgJ6UaPp7vs; } | nc -l 80; done
