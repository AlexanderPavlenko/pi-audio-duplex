#!/bin/sh
# run via iSH on iPad:
cat /dev/location > /dev/null & # allows to run in background
socat TCP-LISTEN:2122,bind=0.0.0.0,fork,su=nobody,reuseaddr TCP:169.254.1.1:22 &
socat TCP-LISTEN:2150,bind=0.0.0.0,fork,su=nobody,reuseaddr TCP:169.254.1.1:2150 &
