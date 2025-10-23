# Ill-Tempered Tourist

Fork of the wonderful Well-Tempered Traveler, since I want to add a few features.  Original site hosted at [google.com/welltemperedtraveler](https://google.com/welltemperedtraveler).

## What is this?

An interactive web application that helps travelers find cities with pleasant climates year-round. Browse historical weather data (temperature and precipitation) for 196+ cities worldwide, organized by month with color-coded temperature displays.

## New Features

This fork adds comprehensive tooling for managing cities and weather data:

- **Multiple Data Sources**: Added Open-Meteo API support (free, no API key) alongside NOAA GSOM for cities not in the official dataset
- **Easy City Management**: Interactive scripts to add cities, fetch data, and bulk refresh all locations
- **Station Discovery**: Tools to search and identify correct weather station names for NOAA data
- **Local Development**: Built-in web server script to properly run the app locally (fixes CORS issues)
- **Complete Documentation**: Step-by-step guides for adding cities and troubleshooting data issues

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

## Data Sources

- **NOAA GSOM** (Primary): Global Summary of the Month archive with comprehensive coverage
- **Open-Meteo API** (Alternative): Free historical weather API, no key required, excellent for cities missing from NOAA

Both sources aggregate 10 years of historical monthly data.

## Scripts

**Data Fetching:**
- `refresh_data_ncei` - Fetch data from NOAA GSOM dataset
- `refresh_data_openmeteo` - Fetch data from Open-Meteo API (free, no key)
- `download_noaa_data.sh` - Download NOAA weather data archive

**City Management:**
- `add_city.sh` - Interactive script to add a new city
- `bulk_refresh_all_cities.sh` - Refresh weather data for all cities

**Utilities:**
- `serve.sh` - Start local web server for testing
- `find_station_fast.sh` - Find NOAA stations by country code
- `find_station_by_name.sh` - Find NOAA stations by city name
- `missing_data` - Check data quality issues
