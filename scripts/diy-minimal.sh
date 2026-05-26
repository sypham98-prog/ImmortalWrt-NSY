#!/bin/bash
set -e

# Minimal customizations for a clean NSY-G68-PLUS build.
# Run after source checkout and before make defconfig, replacing the original diy-mini.sh.

# Keep the release text neutral for a clean development base.
sed -i "s/DISTRIB_DESCRIPTION.*/DISTRIB_DESCRIPTION='%D %V %C minimal nsy-g68-plus'/g" package/base-files/files/etc/openwrt_release || true
sed -i "s/OPENWRT_RELEASE.*/OPENWRT_RELEASE=\"%D %V %C minimal nsy-g68-plus\"/g" package/base-files/files/usr/lib/os-release || true

# Leave default OpenWrt LAN IP unless you intentionally change it.
# sed -i 's/192.168.1.1/192.168.100.1/g' package/base-files/files/bin/config_generate

# Avoid pulling extra apps/themes/packages. Only update/install feeds.
./scripts/feeds update -a
./scripts/feeds install -a
