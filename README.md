# Openwrt Builder

This repository provides a deterministic, Docker-based build system for generating a custom OpenWrt image for:

Raspberry Pi 5 (BCM2712)

Dual RTL8125 2.5GbE HAT

Includig support for:
- NFS
- RTC (DS3231 example)
- NTP server
- PXE boot server

Repository Layout
.
├── Dockerfile
├── build.sh
├── openwrt.config
├── files/
│   ├── etc/config/
│   │   ├── system
│   │   ├── dhcp
│   │   ├── network
│   └── etc/exports
└── README.md

## Build Process
1. Build Docker image
docker build -t openwrt-builder .

2. Run build container
docker run --rm -it \
  -v $(pwd):/workspace \
  openwrt-builder \
  bash -c "cd /workspace && ./build.sh"


Artifacts will appear in:

openwrt/bin/targets/bcm27xx/bcm2712/

## Flashing Image
gzip -d *.img.gz
sudo dd if=*.img of=/dev/sdX bs=4M status=progress

## Upgrade Strategy
Minor Config Changes

Modify files/

Rebuild

Flash new image

OpenWrt Version Upgrade

Change:

OPENWRT_VERSION="openwrt-23.05"


to:

OPENWRT_VERSION="openwrt-24.xx"


Then:

docker run ...

## Deterministic Build Recommendations

For strict reproducibility:

Pin OpenWrt to a tag, not branch

Commit .config

Consider make download and caching dl/

Store sha256sum of output images

Optionally vendor feeds

## Validation Checklist

After boot on Raspberry Pi 5:

Verify RTL8125
ethtool -i eth1


Expected:

driver: r8125

Verify RTC
hwclock -r
