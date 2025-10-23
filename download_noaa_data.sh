#!/bin/bash
# Helper script to download NOAA GSOM data
# Run this from a machine without proxy restrictions if needed

set -e

DATA_URL="https://www.ncei.noaa.gov/data/global-summary-of-the-month/archive/gsom-latest.tar.gz"
DOWNLOAD_DIR="$HOME"

echo "=========================================="
echo "NOAA GSOM Data Downloader"
echo "=========================================="
echo ""
echo "This script will:"
echo "  1. Download gsom-latest.tar.gz (~500MB)"
echo "  2. Extract it to $HOME/gsom-latest/"
echo ""
read -p "Continue? (y/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Cancelled."
    exit 1
fi

cd "$DOWNLOAD_DIR"

echo ""
echo "Downloading NOAA GSOM data..."
echo "URL: $DATA_URL"
echo ""

if command -v wget &> /dev/null; then
    wget --continue "$DATA_URL" -O gsom-latest.tar.gz
elif command -v curl &> /dev/null; then
    curl -L -C - "$DATA_URL" -o gsom-latest.tar.gz
else
    echo "ERROR: Neither wget nor curl is available."
    echo "Please download manually from:"
    echo "  $DATA_URL"
    echo ""
    echo "Then run:"
    echo "  tar -xzf gsom-latest.tar.gz -C $HOME/"
    exit 1
fi

echo ""
echo "Extracting data..."
# Extract directly - the tar already contains gsom-latest/ directory structure
tar -xzf gsom-latest.tar.gz

# Count extracted files
csv_count=$(find "$HOME/gsom-latest" -name "*.csv" 2>/dev/null | wc -l)

echo ""
echo "=========================================="
echo "✓ Download complete!"
echo "  Extracted $csv_count weather station files"
echo "  Location: $HOME/gsom-latest/"
echo "=========================================="
echo ""
echo "Next steps:"
echo "  cd $(dirname "$(readlink -f "$0")")"
echo "  ./refresh_data_ncei \"Beirut|LB\""
echo ""
echo "Or refresh all cities:"
echo "  ./bulk_refresh_all_cities.sh"
echo ""
