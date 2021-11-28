#!/usr/bin/bash

cd /sys/kernel/config/usb_gadget/ || fail
mkdir -p lexi && cd lexi || fail

echo 0x1d6b > idVendor # Linux Foundation
echo 0x0104 > idProduct # Multifunction Composite Gadget
echo 0x0100 > bcdDevice # v1.0.0
echo 0x0200 > bcdUSB # USB2
mkdir -p strings/0x409
echo "fedcba9876543210" > strings/0x409/serialnumber
echo "Lexi" > strings/0x409/manufacturer
echo "Raspberry Pi" > strings/0x409/product
mkdir -p configs/c.1/strings/0x409
echo "ECM + UAC2" > configs/c.1/strings/0x409/configuration
echo 250 > configs/c.1/MaxPower

# Ethernet
# https://www.kernel.org/doc/html/latest/usb/gadget-testing.html#ecm-function
mkdir -p functions/ecm.usb0
# first byte of address must be even
echo "48:6f:73:74:50:43" > functions/ecm.usb0/host_addr
echo "42:61:64:55:53:42" > functions/ecm.usb0/dev_addr
ln -s functions/ecm.usb0 configs/c.1/

# UAC2 audio
# https://www.kernel.org/doc/html/latest/usb/gadget-testing.html#uac2-function
mkdir -p functions/uac2.usb0
echo 3 > functions/uac2.usb0/c_ssize
echo 3 > functions/uac2.usb0/p_ssize
echo 48000 > functions/uac2.usb0/c_srate
echo 48000 > functions/uac2.usb0/p_srate
# USB Device Class Definition for Audio Devices: 4.1 Audio Channel Cluster Descriptor
# fail: "11011110011".to_i(2) = 1779 # Side Right, Side Left, -, Front Right of Center, Front Left of Center, Back Right, Left, -, -, Front Right, Left
# fail: "111110111".to_i(2) = 503 # Back Center, Front Right of Center, Front Left of Center, Back Right, Left, -, Front Center, Front Right, Left
# fail: "11111111".to_i(2) = 255
# fail: "1111111111".to_i(2) = 1023
# works: "11110011".to_i(2) = 243 # Front Right of Center, Front Left of Center, Back Right, Left, -, -, Front Right, Left
# but ALSA fails: "cannot set period size to 256 frames for capture"
echo 51 > functions/uac2.usb0/c_chmask
echo 3 > functions/uac2.usb0/p_chmask
ln -s functions/uac2.usb0 configs/c.1/

# End functions
ls /sys/class/udc > UDC

ifconfig usb0 169.254.1.1 netmask 255.255.0.0 up
#route add -net default gw 169.254.1.2
