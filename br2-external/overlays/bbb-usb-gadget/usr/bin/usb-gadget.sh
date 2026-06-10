#!/bin/sh

mount -t configfs none /sys/kernel/config 2>/dev/null

G=/sys/kernel/config/usb_gadget/g1

mkdir -p $G
cd $G || exit 1

echo 0x1d6b > idVendor
echo 0x0104 > idProduct

mkdir -p strings/0x409
echo "1234567890" > strings/0x409/serialnumber
echo "Jakov" > strings/0x409/manufacturer
echo "BBB Serial Gadget" > strings/0x409/product

mkdir -p configs/c.1
mkdir -p configs/c.1/strings/0x409

echo "CDC ACM" > configs/c.1/strings/0x409/configuration
echo 120 > configs/c.1/MaxPower

mkdir -p functions/acm.usb0

ln -sf functions/acm.usb0 configs/c.1/acm.usb0

echo musb-hdrc.0 > UDC
