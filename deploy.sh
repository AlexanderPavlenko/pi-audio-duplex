#!/bin/zsh

PI=root@pi
scp rc.local $PI:/etc/rc.local
scp usb.sh $PI:/root/usb.sh
ssh $PI reboot