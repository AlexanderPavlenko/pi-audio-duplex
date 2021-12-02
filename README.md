This code allows to use [Raspberry Pi 4](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/) as a USB gadget
composite of multichannel Audio input/output and Ethernet, meaning it can transform an iPad (or any other [UAC2](https://en.wikipedia.org/wiki/USB#Audio_streaming) compatible device) into a VST effect/instrument integrated into a desktop DAW – the Pi 4 is powerful enough to run [Reaper (armv7l)](https://www.reaper.fm/download.php) and its [ReaStream](https://www.reaper.fm/reaplugs/) plugin with low latency over the built-in Ethernet.

### Other versions
* [Pi Zero](https://github.com/AlexanderPavlenko/pi-audio-duplex/tree/zero-v1)
* [Pi Zero 2](https://github.com/AlexanderPavlenko/pi-audio-duplex/tree/zero-v2)
* [Pi Zero 2 with Reaper](https://github.com/AlexanderPavlenko/pi-audio-duplex/tree/zero-v2-reaper)

### Bootstrap on macOS
```shell
brew bundle # install dependencies

# export $SDCARD=diskX
# diskutil unmountDisk /dev/$SDCARD
# sudo dd bs=1m if=~/Downloads/2021-05-07-raspios-buster-armhf-lite.img of=/dev/r$SDCARD; sync
# sudo diskutil eject /dev/r$SDCARD

# on the boot partition:
# config.txt – add new line to the bottom: dtoverlay=dwc2
# cmdline.txt – insert after rootwait: modules-load=dwc2,libcomposite
# create empty file: touch ssh

# connect Ethernet cable and/or configure WiFi via wpa_supplicant.conf
# insert SD card and boot Pi 

PI_IP=$(host raspberrypi)
echo $PI_IP
PI_IP=${PI_IP##* }
ssh pi@$PI_IP
pass: raspberry

# change password, or add ~/.ssh/authorized_keys and disable password auth
# ./deploy.sh
```
[BlackHole Drivers](https://github.com/ExistentialAudio/BlackHole/wiki/Running-Multiple-BlackHole-Drivers) are no longer required, but still useful.

### Pi 4 low power mode
```shell
sudo -i
apt update
apt full-upgrade
raspi-config # Advanced Options / Bootloader Version / Latest
```
> A recent update to the Raspberry Pi 4 bootloader not only enables the low power mode for the USB hardware, allows the enabling of Network boot and enables data over the USB-C port. The lower power means it should run (without any hats) with the power supplied from a laptop.
>
> Details of how to check/update the bootloader can be found [here](https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#raspberry-pi-4-boot-eeprom).
>
> – [source](https://www.hardill.me.uk/wordpress/2019/11/02/pi4-usb-c-gadget/)

### Using Reaper via SSH X11 forwarding
```shell
# Pi
apt install jackd2 xserver-xorg fontconfig libgtk-3-dev

# Mac
open -a xquartz # "Allow network" in Preferences / Security
scp ~/.Xauthority pi@pi4:.
export DISPLAY=:0 ; ssh -v -X -S none pi@pi4
sudo nice -n -20 sudo -u pi reaper_linux_armv7l/install-reaper.sh # [R]un REAPER
```

#### Preferences
* Audio / Device
  * Audio system: JACK
  * Input channels: 4
  * Output channels: 2
  * Auto-start jackd, launch command: /home/pi/jack.sh

Once configured, Reaper can run without GUI:
1. Route USB audio channels (not sure why they called `Playback/Capture Inactive`) in AUM, or Audiobus, or whatever
2. `./start.sh`

### Alternatives
* [Dante AVIO Adapter](https://www.audinate.com/products/devices/dante-avio#USB) – seems cool and pricey
* [iConnectivity AUDIO4c](https://www.iconnectivity.com/audio4c) – multifunctional, key features include "routes audio digitally between two computing devices"
* Apple IDAM – wired output only, lossless
* [Audreio](https://audre.io/) – seems outdated without Audiobus integration
* [studiomux](https://apps.apple.com/de/app/studiomux/id966554837) – compatibility issues, redundant features

### RTP MIDI

> iOS restriction that per device we can only use 1 MIDI Network Session and it's an iOS behavior that copies the data over / merges them to all connected MIDI Network Sessions under the hood
>
> – [source](https://forum.audiob.us/discussion/39657/routing-midi-data-onto-2-or-more-midi-network-sessions-fails)

Seems to be the same problem on iPadOS. But if [there is](https://github.com/davidmoreno/rtpmidid#linux) a better RTP MIDI implementation for the Raspberry Pi OS, it may be used to relay the multiple different [MPE](https://www.midi.org/midi-articles/midi-polyphonic-expression-mpe) sessions, presented as a [USB MIDI](https://www.kernel.org/doc/html/latest/usb/gadget-testing.html#midi-function) ports.

### Credits
* [iSticktoit.net - Composite USB gadgets on the Raspberry Pi Zero](https://www.isticktoit.net/?p=1383)