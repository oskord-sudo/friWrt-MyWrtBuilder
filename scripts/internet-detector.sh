#!/bin/bash
set -e

echo "=== Downloading internet-detector packages (gSpotx2f) ==="

BASE_URL="https://github.com/gSpotx2f/packages-openwrt/raw/master/25.12"

mkdir -p packages

wget -q --show-progress -O packages/internet-detector-1.7.4-r1.apk \
  "$BASE_URL/internet-detector-1.7.4-r1.apk"

wget -q --show-progress -O packages/luci-app-internet-detector-1.7.4-r1.apk \
  "$BASE_URL/luci-app-internet-detector-1.7.4-r1.apk"

wget -q --show-progress -O packages/luci-i18n-internet-detector-ru-1.7.4-r1.apk \
  "$BASE_URL/luci-i18n-internet-detector-ru-1.7.4-r1.apk"

echo "internet-detector packages downloaded"
ls -lh packages/internet-detector* packages/luci-app-internet-detector* packages/luci-i18n-internet-detector* 2>/dev/null || true
