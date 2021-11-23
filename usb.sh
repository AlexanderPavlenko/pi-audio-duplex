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
echo "Raspberry Pi Zero" > strings/0x409/product
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
echo 44100 > functions/uac2.usb0/c_srate
echo 44100 > functions/uac2.usb0/p_srate
# USB Device Class Definition for Audio Devices: 4.1 Audio Channel Cluster Descriptor
# "110011".to_i(2) = 51 # Back Right, Left, -, -, Front Right, Left
echo 51 > functions/uac2.usb0/c_chmask
echo 3 > functions/uac2.usb0/p_chmask
ln -s functions/uac2.usb0 configs/c.1/

# End functions
ls /sys/class/udc > UDC

ifconfig usb0 169.254.1.1 netmask 255.255.0.0 up
#route add -net default gw 169.254.1.2
