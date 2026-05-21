#!/bin/bash
set -e

# ── Input
DEVICE="$1"
ROM_URL="$2"
PIXELDRAIN_KEY="$3"
UPLOAD_FILES="$4"
BASE_DIR=$(pwd)
WORK_DIR="DumprX_$DEVICE"

# ── Clone DumprX
echo ">> Cloning DumprX..."
git clone https://github.com/DumprX/DumprX "$WORK_DIR"

# ── Download ROM
echo ">> Downloading ROM..."
curl -L "$ROM_URL" -o "$WORK_DIR/$DEVICE.zip"

# ── Execute Dump
echo ">> Dumping ROM..."
cd "$WORK_DIR"
./dumper.sh "$DEVICE.zip"

# ── Upload
echo ">> Uploading files..."
eval "EXPANDED_FILES=($UPLOAD_FILES)"

for file in "${EXPANDED_FILES[@]}"; do
    if [[ -f "$file" ]]; then
        echo "Uploading $file..."
        curl -T "$file" -u ":$PIXELDRAIN_KEY" https://pixeldrain.com/api/file/
        echo ""
    else
        echo "WARNING: File not found, skipping: $file"
    fi
done

# ── Cleanup
echo ">> Cleaning up..."
cd "$BASE_DIR"
rm -rf "$WORK_DIR"

# Done Bang
echo ">> Done!"
