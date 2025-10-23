#!/bin/bash
# Fast station finder using grep
# Usage: ./find_station_fast.sh LB

COUNTRY_CODE="${1:-LB}"
DATA_DIR="$HOME/gsom-latest"

if [ ! -d "$DATA_DIR" ]; then
    echo "ERROR: $DATA_DIR not found"
    exit 1
fi

echo "Searching for stations in country: $COUNTRY_CODE"
echo "================================================"
echo ""

# Use grep to search all CSVs at once - much faster
cd "$DATA_DIR"
grep -h ", $COUNTRY_CODE$" *.csv 2>/dev/null | head -20 | while read line; do
    station_name=$(echo "$line" | cut -d',' -f1 | sed 's/"//g')
    echo "Station: $station_name"
done

echo ""
echo "Done."
