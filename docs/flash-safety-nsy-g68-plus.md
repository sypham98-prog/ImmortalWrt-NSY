# Flash Safety Procedure for NSY-G68-PLUS

This build is intentionally staged so the router is not flashed automatically.

## Hard rule

Do not flash any image unless all checks pass:

1. The GitHub Actions run completed successfully.
2. The firmware filename contains `nsy_g68-plus`.
3. `build.config` contains:
   - `CONFIG_TARGET_rockchip_armv8_DEVICE_nsy_g68-plus=y`
   - `CONFIG_TARGET_PROFILE="DEVICE_nsy_g68-plus"`
4. The manifest does not contain removed bundles such as:
   - `luci-app-passwall2`
   - `docker`, `dockerd`, `docker-compose`
   - `netdata`
   - `ttyd`, `luci-app-ttyd`
   - `luci-app-diskman`
   - `smartd`, `smartmontools`, `mdadm`, `wsdd2`
   - `luci-app-openclash`
5. The image passes OpenWrt test mode on the router:

```sh
sysupgrade -T /tmp/<image-name>.img.gz
```

Only after that should a real flash be considered:

```sh
sysupgrade -n /tmp/<image-name>.img.gz
```

`-n` is intentional for a clean base. It discards old overlay config.

## Before flashing

Save a fresh backup from the currently working router:

```sh
sysupgrade -b /tmp/backup-before-minimal-rom.tar.gz
```

Copy the backup off the router before flashing.

Also record the current board and storage layout:

```sh
ubus call system board
cat /proc/cmdline
lsblk
cat /proc/partitions
```

## Expected router after clean flash

Default OpenWrt/ImmortalWrt LAN IP is expected to be:

```text
192.168.1.1
```

Use a direct Ethernet connection and set your PC to DHCP or a static IP in `192.168.1.0/24` if needed.

## Recovery note

This device is Rockchip/eMMC based. If a flash fails badly, recovery may require the Rockchip flashing tool and the correct loader/image. Keep the known-working images under `D:\Openwrt\NSY-G68-PLUS\OS`.
