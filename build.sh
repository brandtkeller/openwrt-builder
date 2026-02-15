#!/usr/bin/env bash
set -euo pipefail

OPENWRT_VERSION="openwrt-23.05"

if [ ! -d openwrt ]; then
    git clone https://github.com/openwrt/openwrt.git
fi

cd openwrt
git fetch
git checkout ${OPENWRT_VERSION}

./scripts/feeds update -a
./scripts/feeds install -a

cp ../openwrt.config .config
make defconfig

cp -r ../files ./files

make -j$(nproc)

echo "Build complete."