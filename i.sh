#!/bin/sh
# run via https://ish.app
# granting "allow always location" enables running in background
# fixme: audio starts cracking more when this runs not in foreground, so overall Pi Zero 2's built-in WiFi works better
cat /dev/location > /dev/null &
ncat -luv 169.254.1.2 58710 | nc -u 192.168.44.6 58710 &
ncat -luv 192.168.44.9 58710 | nc -u 169.254.1.1 58710 &
