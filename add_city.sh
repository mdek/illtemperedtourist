#!/bin/bash
# Interactive script to add a new city to the Well-Tempered Traveler

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "=========================================="
echo "Add New City to Well-Tempered Traveler"
echo "=========================================="
echo ""

# Get city name
read -p "City name: " city_name
if [ -z "$city_name" ]; then
    echo "ERROR: City name cannot be empty"
    exit 1
fi

# Get country code
echo ""
echo "Enter ISO 3166-1 alpha-2 country code"
echo "Examples: US (USA), LB (Lebanon), FR (France), JP (Japan)"
read -p "Country code: " country_code
country_code=$(echo "$country_code" | tr '[:lower:]' '[:upper:]')
if [ -z "$country_code" ] || [ ${#country_code} -ne 2 ]; then
    echo "ERROR: Country code must be exactly 2 letters"
    exit 1
fi

# Get coordinates
echo ""
echo "Enter coordinates (you can find these on Google Maps)"
echo "Format: latitude,longitude"
echo "Example: 33.8959203,35.47843"
read -p "Coordinates: " coords
if [[ ! "$coords" =~ ^-?[0-9]+\.?[0-9]*,-?[0-9]+\.?[0-9]*$ ]]; then
    echo "ERROR: Invalid coordinate format"
    exit 1
fi

city_entry="$city_name|$country_code"

echo ""
echo "=========================================="
echo "Summary:"
echo "  City: $city_name"
echo "  Country: $country_code"
echo "  Coordinates: $coords"
echo "  Entry: $city_entry"
echo "=========================================="
echo ""
read -p "Add this city? (y/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Cancelled."
    exit 1
fi

# Check if city already exists
if grep -q "^$city_entry$" cities.txt 2>/dev/null; then
    echo "⚠ City already exists in cities.txt"
else
    echo "$city_entry" >> cities.txt
    echo "✓ Added to cities.txt"
fi

# Check if coordinates already exist
if grep -q "^$city_entry|" latlng.txt 2>/dev/null; then
    echo "⚠ Coordinates already exist in latlng.txt"
else
    echo "$city_entry|$coords" >> latlng.txt
    echo "✓ Added to latlng.txt"
fi

# Sort both files
sort -o cities.txt cities.txt
sort -o latlng.txt latlng.txt

echo ""
echo "✓ City configuration complete!"
echo ""
echo "Next steps:"
echo "  1. Download NOAA data if you haven't:"
echo "     ./download_noaa_data.sh"
echo ""
echo "  2. Fetch weather data for this city:"
echo "     ./refresh_data_ncei \"$city_entry\""
echo ""
