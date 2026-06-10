# BBB CAN Project

BeagleBone Black CAN communication project using Buildroot.

## Repository Structure

```
bbb-can-project/
├── buildroot/      # Buildroot submodule
├── br2-external/   # Project-specific Buildroot extensions
├── docs/
├── scripts/
└── README.md
```

## Buildroot Version

Buildroot 2025.02.14

## Initial Build

```bash
git clone --recurse-submodules git@github.com:jakovmarinovic/bbb-can-project.git

cd bbb-can-project/buildroot

make BR2_EXTERNAL=../br2-external \
     O=../output \
     beaglebone_defconfig

make BR2_EXTERNAL=../br2-external \
     O=../output
```

## Generated Images

```
output/images/
├── sdcard.img
├── MLO
├── u-boot.img
├── zImage
├── am335x-boneblack.dtb
└── rootfs.ext2
```

## Writing Image to SD card

Replace /dev/sdX with the correct SD card device

```
sudo dd if=output/images/sdcard.img \
        of=/dev/sdX \
        bs=4M \
        status=progress \
        conv=fsync
```
Verify the partitions:
```
lsblk
sudo fdisk -l /dev/sdX
```
Expected layout:

Partition 1 : FAT32 boot partition (~16 MB)
Partition 2 : Linux root filesystem (~512 MB)

## Serial Console Connection (FT232 USB-UART)

A USB-to-UART adapter was used for debugging and boot verification.

## FT232 Wiring

| FT232 Wire  | BeagleBone Black J1 Header |
|-------------|----------------------------|
| Yellow (TX) | Pin 5 (UART0 RX)           |
| Orange (RX) | Pin 4 (UART0 TX)           |
| Black (GND) | Pin 1 (GND)                |


## Serial Terminal

On the host PC:

```bash
picocom -b 115200 /dev/ttyUSB0
```
The board booted into the custom Buildroot system and presented the login prompt:

```text
Welcome to Buildroot
buildroot login:
```

## USB Gadget Serial Console (USB Device Port)

The BeagleBone Black USB device port was configured as a USB CDC ACM gadget.

A startup script is installed through the Buildroot rootfs overlay:

```
br2-external/overlays/bbb-usb-gadget/
```

At boot the script:

1. Mounts ConfigFS
2. Creates a USB gadget
3. Registers a CDC ACM serial function
4. Binds the gadget to `musb-hdrc.0`

When connected to a Linux host, the BBB appears as:

```bash
/dev/ttyACM0

```
A BusyBox getty is started on /dev/ttyGS0, allowing login over USB without a separate USB-to-UART adapter.

Host connection:
```
picocom -b 115200 /dev/ttyACM0
```
Device side:
```
/dev/ttyGS0
```


