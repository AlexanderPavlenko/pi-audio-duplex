#!/bin/zsh

scp rc.local root@pi:/etc/rc.local
scp usb.sh root@pi:/root/usb.sh
ssh root@pi reboot