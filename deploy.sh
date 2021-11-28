#!/bin/zsh

PI=pi4
scp rc.local root@$PI:/etc/
scp usb.sh root@$PI:/root/
scp jack.sh pi@$PI:/home/pi/
scp stream.RPP pi@$PI:/home/pi/
ssh root@$PI reboot

# wget https://www.reaper.fm/files/6.x/reaper642_linux_armv7l.tar.xz
# tar xf reaper642_linux_armv7l.tar.xz