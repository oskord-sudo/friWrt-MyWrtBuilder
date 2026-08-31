#!/bin/bash

make info

PROFILE=""
PACKAGES=""

PACKAGES+=" apk-mbedtls base-files ca-bundle ca-certificates dnsmasq-full dropbear e2fsprogs firewall4 fstools grub2-bios-setup kmod-button-hotplug kmod-nft-offload libc libgcc libustream-openssl20201210 logd mkf2fs mtd netifd nftables odhcp6c odhcpd-ipv6only partx-utils ppp ppp-mod-pppoe procd-ujail uci uclient-fetch urandom-seed urngd"

PACKAGES+=" kmod-igc kmod-igb kmod-e1000e kmod-e1000 kmod-r8169 kmod-tg3 kmod-bnx2 kmod-amazon-ena kmod-amd-xgbe kmod-dwmac-intel kmod-forcedeth kmod-ixgbe kmod-iwlwifi iwlwifi-firmware-iwl8265 wpad-openssl kmod-nvme kmod-fs-ext4 kmod-fs-vfat kmod-fs-btrfs kmod-usb-core kmod-usb2 kmod-usb3 kmod-usb-storage kmod-usb-storage-uas kmod-drm-i915 i915-firmware i915-firmware-dmc i915-firmware-gsc i915-firmware-guc i915-firmware-huc intel-microcode kmod-thermal ethtool"

PACKAGES+=" docker dockerd docker-compose containerd runc tini luci-app-dockerman luci-i18n-dockerman-ru"

PACKAGES+=" sqm-scripts luci-app-sqm luci-i18n-sqm-ru kmod-sched-cake kmod-ifb kmod-nft-tproxy kmod-nft-queue kmod-inet-diag kmod-tun kmod-veth internet-detector luci-app-internet-detector luci-i18n-internet-detector-ru btop ip-full bind-dig curl"

PACKAGES+=" luci luci-ssl luci-i18n-base-ru luci-i18n-firewall-ru luci-i18n-package-manager-ru luci-app-package-manager luci-app-firewall"

PACKAGES+=" htop nano bash curl wget-ssl tar unzip gzip jq ttyd openssh-sftp-server screen block-mount losetup resize2fs parted zram-swap coreutils coreutils-base64"

EXCLUDED=""
if [ "${RELEASE_BRANCH%:*}" == "openwrt" ]; then
    EXCLUDED+=" -dnsmasq"
fi

FILES="files"
DISABLED_SERVICES=""

# Увеличиваем размер rootfs (в мегабайтах)
export ROOTFS_PARTSIZE=512

make image PROFILE="$1" PACKAGES="$PACKAGES $EXCLUDED" FILES="$FILES" DISABLED_SERVICES="$DISABLED_SERVICES"
