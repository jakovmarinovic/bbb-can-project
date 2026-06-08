# BBB CAN Project

BeagleBone Black CAN communication project using Buildroot.

## Repository Structure

```text
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

```text
output/images/
├── sdcard.img
├── MLO
├── u-boot.img
├── zImage
├── am335x-boneblack.dtb
└── rootfs.ext2
```

## Target Hardware

- BeagleBone Black
- CAN cape (to be integrated)
