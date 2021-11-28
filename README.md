This code allows to use [Raspberry Pi Zero 2](https://www.raspberrypi.com/products/raspberry-pi-zero-2-w/) as a USB gadget
composite of Ethernet and multichannel Audio input/output.

[Branch for Raspberry Pi Zero.](https://github.com/AlexanderPavlenko/pi-audio-duplex/tree/zero-v1)

[Branch for Raspberry Pi Zero 2.](https://github.com/AlexanderPavlenko/pi-audio-duplex/tree/zero-v2)

Turns out the Zero 2 is powerful enough to run [Reaper (armv7l)](https://www.reaper.fm/download.php) and its [ReaStream](https://www.reaper.fm/reaplugs/) plugin with low latency, even over the built-in WiFi (depends on signal strength).

Reaper preferences:
* Audio / Device
  * Audio system: JACK
  * Auto-start jackd, launch command: /home/pi/jack.sh
  * Auto-connect

Alternatives:

* [Dante AVIO Adapter](https://www.audinate.com/products/devices/dante-avio#USB) – seems cool and pricey
* [iConnectivity AUDIO4c](https://www.iconnectivity.com/audio4c) – multifunctional, key features include "routes audio digitally between two computing devices"
* Apple IDAM – wired output only, lossless
* [Audreio](https://audre.io/) – seems outdated without Audiobus integration
* [studiomux](https://apps.apple.com/de/app/studiomux/id966554837) – compatibility issues, redundant features

Credits:
* [iSticktoit.net - Composite USB gadgets on the Raspberry Pi Zero](https://www.isticktoit.net/?p=1383)

Raspberry Pi bootstrap on macOS:
```shell
# export $SDCARD=diskX
# diskutil unmountDisk /dev/$SDCARD
# sudo dd bs=1m if=~/Downloads/2021-05-07-raspios-buster-armhf-lite.img of=/dev/r$SDCARD; sync
# sudo diskutil eject /dev/r$SDCARD

# config.txt – add new line to the bottom: dtoverlay=dwc2
# cmdline.txt – insert after rootwait: modules-load=dwc2,g_ether
# create empty file: touch ssh

# on raspberry A+, maybe: dtoverlay=dwc2,dr_mode=peripheral
# https://github.com/raspberrypi/firmware/blob/master/boot/overlays/README#L800

# to disable wireless add to /boot/config.txt
#dtoverlay=disable-wifi
dtoverlay=disable-bt

ping raspberrypi.local
ssh pi@169.254.X.Y
pass: raspberry

# after deploy.sh change cmdline.txt: modules-load=dwc2,libcomposite
```

`RpIn` and `RpOut` are [BlackHole Drivers](https://github.com/ExistentialAudio/BlackHole/wiki/Running-Multiple-BlackHole-Drivers).

### Using Reaper via SSH X11 forwarding
```shell
# Pi
apt install xserver-xorg # probably only for `xauth`

# Mac
open -a xquartz # "Allow network" in Preferences / Security
scp ~/.Xauthority pi@pi-wifi:/home/pi/.Xauthority
export DISPLAY=:0 ; ssh -v -X -S none pi@pi-wifi
reaper_linux_armv7l/install-reaper.sh # [R]un REAPER
```