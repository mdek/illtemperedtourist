# Ill-Tempered Tourist

Fork of the wonderful Well-Tempered Traveler, since I want to add a few features.  Original site hosted at [google.com/welltemperedtraveler](https://google.com/welltemperedtraveler).

## What is this?

An interactive web application that helps travelers find cities with pleasant climates year-round. Browse historical weather data (temperature and precipitation) for 196+ cities worldwide, organized by month with color-coded temperature displays.

## Quick Start

**Note:** Due to browser CORS restrictions, you need to run a local web server (opening `index.html` directly won't work).

1. **Start the local server:**
   ```bash
   ./serve.sh
   ```

2. **Open in your browser:**
   ```
   http://localhost:8000
   ```

3. **Use the app:**
   - Search for cities by name, country, or continent
   - Click month headers to sort cities by most comfortable weather
   - Hover over cells to see detailed temperature and rainfall data

## Adding Cities

### Quick Add (Interactive)

```bash
./add_city.sh
```

This interactive script will guide you through adding a new city.

### Manual Process

1. **Download NOAA weather data** (one-time setup):
   ```bash
   ./download_noaa_data.sh
   ```

2. **Add a specific city**:

   For cities in NOAA dataset:
   ```bash
   ./refresh_data_ncei "Beirut|LB"
   ```

   For cities NOT in NOAA (or as alternative):
   ```bash
   ./refresh_data_openmeteo "Beirut|LB"
   ```

3. **Refresh all cities**:
   ```bash
   ./bulk_refresh_all_cities.sh
   ```

See [SETUP_DATA.md](SETUP_DATA.md) for detailed instructions.

## Project Structure

- `index.html` - Main web application
- `data.txt` - Weather data for all cities (JSON format)
- `cities.txt` - List of cities to track
- `latlng.txt` - Geographic coordinates
- `refresh_data_ncei` - Script to fetch NOAA weather data
- `ncei_station_names.py` - Weather station name mappings

## Data Source

Weather data comes from NOAA's Global Summary of the Month (GSOM) archive, aggregating 10 years of historical monthly data for each city.

## Scripts

- `add_city.sh` - Interactive script to add a new city
- `download_noaa_data.sh` - Download NOAA weather data archive
- `bulk_refresh_all_cities.sh` - Refresh weather data for all cities
- `refresh_data_ncei` - Fetch data for a specific city
- `missing_data` - Check data quality issues
