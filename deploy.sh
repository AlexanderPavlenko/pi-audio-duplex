#!/bin/zsh

PI=pi-wifi
scp rc.local root@$PI:/etc/
scp usb.sh root@$PI:/root/
scp jack.sh pi@$PI:/home/pi/
scp stream.RPP pi@$PI:/home/pi/
ssh root@$PI reboot