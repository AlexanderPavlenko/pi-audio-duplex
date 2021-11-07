#!/bin/sh
# run via https://ish.app
cat /dev/location > /dev/null & # granting "allow always" enables running in background
socat TCP-LISTEN:2122,bind=0.0.0.0,fork,su=nobody,reuseaddr,nodelay TCP:169.254.1.1:22,nodelay &
socat TCP-LISTEN:2150,bind=0.0.0.0,fork,su=nobody,reuseaddr,nodelay TCP:169.254.1.1:2150,nodelay &
