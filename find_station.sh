#!/bin/bash
# Run this script to find weather stations for a country
# Usage: ./find_station.sh LB

COUNTRY_CODE="${1:-LB}"
DATA_DIR="$HOME/gsom-latest"

if [ ! -d "$DATA_DIR" ]; then
    echo "ERROR: $DATA_DIR not found"
    exit 1
fi

echo "Searching for stations in country: $COUNTRY_CODE"
echo "================================================"
echo ""

# Search all CSV files for this country code
for csv in "$DATA_DIR"/*.csv; do
    # Read first 2 lines and check if NAME ends with the country code
    result=$(head -2 "$csv" | tail -1 | grep ", $COUNTRY_CODE$")
    if [ -n "$result" ]; then
        station_name=$(echo "$result" | cut -d',' -f1 | sed 's/"//g')
        echo "Station: $station_name"
        echo "File: $(basename $csv)"
        echo ""
    fi
done
