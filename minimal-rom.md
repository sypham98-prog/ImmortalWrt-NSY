# NSY-G68-PLUS Minimal ROM Plan

Source repo found from the current firmware author:

- https://github.com/xiaomeng9597/ImmortalWrt-NSY
- It builds from https://github.com/zhoufuli/immortalwrt-rk356x
- The matching board is `nsy,g68-plus` / `CONFIG_TARGET_rockchip_armv8_DEVICE_nsy_g68-plus=y`.

## Recommended path

1. Fork `xiaomeng9597/ImmortalWrt-NSY`.
2. Add `configs/g68-plus-minimal.seed.config`.
3. Add `scripts/diy-minimal.sh`.
4. Copy `.github/workflows/nsy-g68-plus.yml` to a new workflow, for example `nsy-g68-plus-minimal.yml`.
5. Change:

```yaml
CONFIG_FILE: configs/g68-plus-minimal.seed.config
DIY_SCRIPT: scripts/diy-minimal.sh
FIRMWARE_TAG: nsy-g68-plus-minimal
```

6. Run GitHub Actions build.
7. Flash only the generated image whose name contains `nsy_g68-plus`.

## Why not official OpenWrt directly?

The official OpenWrt 24.10 rockchip/armv8 image list does not appear to include `nsy_g68-plus`. The current working firmware uses a custom tree where this board and closed MTK Wi-Fi driver are present. Flashing another Rockchip image is unsafe.

## Baseline packages

This config keeps only board essentials, base router services, LuCI fallback, Wi-Fi support, firewall/DNS/DHCP, and the kernel modules needed later for GenRouter policy routing.

It intentionally excludes Passwall2, Docker, Netdata, ttyd, Diskman, smartd/mdadm/wsdd2, iStore-style extras, and Chinese-only LuCI packages.
