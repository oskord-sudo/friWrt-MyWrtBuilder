#!/bin/bash
set -e

echo "=== Downloading latest Tachyon ==="

LATEST_JSON=$(curl -sL https://api.github.com/repos/Dushnilin/tachyon/releases/latest)
VERSION=$(echo "$LATEST_JSON" | jq -r '.tag_name')
echo "Latest Tachyon: $VERSION"

mkdir -p packages

echo "$LATEST_JSON" | jq -r '.assets[] | select(.name | endswith(".apk")) | .browser_download_url' | while read -r url; do
  [ -z "$url" ] && continue
  filename=$(basename "$url")
  echo "→ $filename"
  wget -q --show-progress -O "packages/$filename" "$url"
done

echo "Tachyon packages downloaded"
ls -lh packages/*tachyon* 2>/dev/null || true
