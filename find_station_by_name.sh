#!/bin/bash
# Find station by city name
# Usage: ./find_station_by_name.sh BEIRUT

SEARCH_NAME="${1:-BEIRUT}"
DATA_DIR="$HOME/gsom-latest"

if [ ! -d "$DATA_DIR" ]; then
    echo "ERROR: $DATA_DIR not found"
    exit 1
fi

echo "Searching for stations matching: $SEARCH_NAME"
echo "================================================"
echo ""

# Search for the city name in station names
cd "$DATA_DIR"
grep -ih "$SEARCH_NAME" *.csv 2>/dev/null | head -20 | while read line; do
    station_name=$(echo "$line" | cut -d',' -f1 | sed 's/"//g')
    echo "Station: $station_name"
done

echo ""
echo "Done."
