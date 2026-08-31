#!/bin/bash

make info

PROFILE=""
PACKAGES=""

# База
PACKAGES+=" apk-mbedtls base-files ca-bundle ca-certificates dnsmasq-full dropbear e2fsprogs firewall4 fstools grub2-bios-setup kmod-button-hotplug kmod-nft-offload libc libgcc libustream-openssl20201210 logd mkf2fs mtd netifd nftables odhcp6c odhcpd-ipv6only partx-utils ppp ppp-mod-pppoe procd-ujail uci uclient-fetch urandom-seed urngd"

# Железо Kingdel NUC K3-2
PACKAGES+=" kmod-igc kmod-igb kmod-e1000e kmod-e1000 kmod-r8169 kmod-tg3 kmod-bnx2 kmod-amazon-ena kmod-amd-xgbe kmod-dwmac-intel kmod-forcedeth kmod-ixgbe kmod-iwlwifi iwlwifi-firmware-iwl8265 wpad-openssl kmod-nvme kmod-fs-ext4 kmod-fs-vfat kmod-fs-btrfs kmod-usb-core kmod-usb2 kmod-usb3 kmod-usb-storage kmod-usb-storage-uas kmod-drm-i915 i915-firmware i915-firmware-dmc i915-firmware-gsc i915-firmware-guc i915-firmware-huc intel-microcode kmod-thermal ethtool"

# Docker полный
PACKAGES+=" docker dockerd docker-compose containerd runc tini luci-app-dockerman luci-i18n-dockerman-ru"

# SQM + internet-detector
PACKAGES+=" sqm-scripts luci-app-sqm luci-i18n-sqm-ru kmod-sched-cake kmod-ifb kmod-nft-tproxy kmod-nft-queue kmod-inet-diag kmod-tun kmod-veth internet-detector luci-app-internet-detector luci-i18n-internet-detector-ru"

# Мониторинг
PACKAGES+=" vnstat2 vnstati2 luci-app-vnstat2 luci-i18n-vnstat2-ru nlbwmon luci-app-nlbwmon luci-i18n-nlbwmon-ru"

# LuCI + русский
PACKAGES+=" luci luci-ssl luci-i18n-base-ru luci-i18n-firewall-ru luci-i18n-package-manager-ru luci-app-package-manager luci-app-firewall"

# Утилиты
PACKAGES+=" bash curl wget-ssl tar unzip gzip jq ttyd block-mount losetup resize2fs parted coreutils coreutils-base64 coreutils-install btop ip-full bind-dig socat tcpdump zstd"

EXCLUDED=""
if [ "${RELEASE_BRANCH%:*}" == "openwrt" ]; then
    EXCLUDED+=" -dnsmasq"
fi

FILES="files"
DISABLED_SERVICES=""

export ROOTFS_PARTSIZE=512

make image PROFILE="$1" PACKAGES="$PACKAGES $EXCLUDED" FILES="$FILES" DISABLED_SERVICES="$DISABLED_SERVICES"
