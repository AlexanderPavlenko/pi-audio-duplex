This code allows to use Raspberry Pi Zero as a USB gadget
composite of Ethernet and Audio input/output.

Alternatives:

* [Dante AVIO Adapter](https://www.audinate.com/products/devices/dante-avio#USB) – seems cool and pricey
* Zoom H2N recorder – wired input only, analog line
* Apple IDAM – wired output only, lossless
* [Audreio](https://audre.io/) – seems outdated without Audiobus integration

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

# to disable LED add to /boot/config.txt
dtparam=act_led_trigger=none
dtparam=act_led_activelow=on

# to disable wireless add to /boot/config.txt
dtoverlay=disable-wifi
dtoverlay=disable-bt

ping raspberrypi.local
ssh pi@169.254.X.Y
pass: raspberry

# after deploy.sh change cmdline.txt: modules-load=dwc2,libcomposite
```
