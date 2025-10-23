#!/bin/bash
# Bulk refresh weather data for all cities in cities.txt

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Check if gsom-latest directory exists
if [ ! -d "$HOME/gsom-latest" ]; then
    echo "ERROR: $HOME/gsom-latest directory not found!"
    echo "Please download and extract the NOAA GSOM data first."
    echo "See SETUP_DATA.md for instructions."
    exit 1
fi

# Count CSV files
csv_count=$(find "$HOME/gsom-latest" -name "*.csv" 2>/dev/null | wc -l)
if [ "$csv_count" -eq 0 ]; then
    echo "ERROR: No CSV files found in $HOME/gsom-latest"
    echo "Please extract the gsom-latest.tar.gz file."
    exit 1
fi

echo "Found $csv_count weather station CSV files"
echo ""

# Read cities and process each one
total=0
updated=0
skipped=0
failed=0

while IFS= read -r city_line; do
    # Skip empty lines and comments
    if [[ -z "$city_line" || "$city_line" =~ ^# ]]; then
        continue
    fi

    total=$((total + 1))
    city_name=$(echo "$city_line" | cut -d'|' -f1)

    echo "[$total] Processing: $city_line"

    # Check if city already has data
    if grep -q "^$city_line:" data.txt 2>/dev/null; then
        existing_data=$(grep "^$city_line:" data.txt)
        # Check if it's empty data {}
        if [[ "$existing_data" =~ :\{\}$ ]]; then
            echo "    → No data yet, fetching..."
            if ./refresh_data_ncei "$city_line" 2>&1 | tee /tmp/refresh_output.txt; then
                if grep -q "not updating" /tmp/refresh_output.txt; then
                    echo "    ✗ Skipped (too much missing data)"
                    skipped=$((skipped + 1))
                else
                    echo "    ✓ Updated"
                    updated=$((updated + 1))
                fi
            else
                echo "    ✗ Failed"
                failed=$((failed + 1))
            fi
        else
            echo "    → Already has data, skipping"
            skipped=$((skipped + 1))
        fi
    else
        echo "    → Not in data.txt, fetching..."
        if ./refresh_data_ncei "$city_line" 2>&1 | tee /tmp/refresh_output.txt; then
            if grep -q "not updating" /tmp/refresh_output.txt; then
                echo "    ✗ Skipped (too much missing data)"
                skipped=$((skipped + 1))
            else
                echo "    ✓ Updated"
                updated=$((updated + 1))
            fi
        else
            echo "    ✗ Failed"
            failed=$((failed + 1))
        fi
    fi
    echo ""
done < cities.txt

echo "============================================"
echo "Summary:"
echo "  Total cities: $total"
echo "  Updated: $updated"
echo "  Skipped: $skipped"
echo "  Failed: $failed"
echo "============================================"
