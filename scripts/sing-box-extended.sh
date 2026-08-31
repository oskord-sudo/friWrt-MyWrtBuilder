#!/bin/bash
set -e

echo "=== Downloading latest sing-box-extended (x86_64) ==="

LATEST_JSON=$(curl -sL https://api.github.com/repos/shtorm-7/sing-box-extended/releases/latest)
VERSION=$(echo "$LATEST_JSON" | jq -r '.tag_name')
echo "Latest: $VERSION"

mkdir -p packages

# Ищем подходящий .apk и сохраняем с оригинальным именем
URL=$(echo "$LATEST_JSON" | jq -r '
  .assets[] | 
  select(.name | test("(?i)(openwrt.*x86_64|x86_64.*openwrt|sing-box-extended.*x86_64).*\\.apk$")) | 
  .browser_download_url' | head -n1)

if [ -z "$URL" ] || [ "$URL" = "null" ]; then
  URL=$(echo "$LATEST_JSON" | jq -r '
    .assets[] | 
    select(.name | test("(?i)x86_64.*\\.apk$") and (test("android|SFA") | not)) | 
    .browser_download_url' | head -n1)
fi

if [ -z "$URL" ] || [ "$URL" = "null" ]; then
  echo "ERROR: не удалось найти .apk для x86_64"
  exit 1
fi

FILENAME=$(basename "$URL")
echo "Downloading: $URL → packages/$FILENAME"
wget -q --show-progress -O "packages/$FILENAME" "$URL"
echo "sing-box-extended downloaded as $FILENAME"
