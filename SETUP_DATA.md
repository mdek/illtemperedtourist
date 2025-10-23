# Setting Up Weather Data for Cities

## Quick Start: Adding Beirut (or any city)

### Option 1: Download NOAA GSOM Data (Recommended)

1. **Download the data archive:**
   - Visit: https://www.ncei.noaa.gov/data/global-summary-of-the-month/archive/
   - Download: `gsom-latest.tar.gz`
   - Or use command line from a machine without proxy restrictions:
     ```bash
     wget https://www.ncei.noaa.gov/data/global-summary-of-the-month/archive/gsom-latest.tar.gz
     ```

2. **Extract to the correct location:**
   ```bash
   cd ~
   tar -xzf gsom-latest.tar.gz
   # This creates ~/gsom-latest/ directory with CSV files
   ```

3. **Add weather data for Beirut:**
   ```bash
   cd /home/user/illtemperedtourist
   ./refresh_data_ncei "Beirut|LB"
   ```

4. **Verify the data was added:**
   ```bash
   grep "^Beirut" data.txt
   ```

### Option 2: Use Open-Meteo API (Recommended if NOAA doesn't have your city)

Open-Meteo is free and doesn't require an API key. Great for cities not in NOAA dataset.

```bash
cd /home/user/illtemperedtourist
./refresh_data_openmeteo "Beirut|LB"
```

This works for ANY city in cities.txt with coordinates in latlng.txt.

### Option 3: Use OpenWeatherMap API

If you have an OpenWeatherMap API key:

1. **Set your API key:**
   ```bash
   export OPEN_WEATHER_API_KEY="your_api_key_here"
   ```

2. **Run the OpenWeatherMap refresh script:**
   ```bash
   cd /home/user/illtemperedtourist/old_sources
   ./refresh_data_openweathermap
   ```

Note: This option is in the `old_sources` directory and may need updates.

### Option 4: Bulk Add All Cities Script

To refresh data for all cities at once:

```bash
cd /home/user/illtemperedtourist
./bulk_refresh_all_cities.sh
```

(Script created below)

## Adding a Completely New City

1. **Add to cities.txt:**
   ```
   Beirut|LB
   ```

2. **Add to latlng.txt:**
   ```
   Beirut|LB|33.8959203,35.47843
   ```

3. **Check if station name mapping is needed:**
   - Run `./refresh_data_ncei "Beirut|LB"`
   - If it says "Didn't find an exact match", check the suggested station names
   - Add mapping to `ncei_station_names.py`:
     ```python
     NAMES = {
         "Beirut|LB": "EXACT STATION NAME FROM OUTPUT",
     }
     ```

4. **Re-run the refresh script:**
   ```bash
   ./refresh_data_ncei "Beirut|LB"
   ```

## Troubleshooting

### "Didn't find an exact match"
The script will show you all matching stations for that country. Pick the correct one and add it to `ncei_station_names.py`.

### "X missing data points, not updating"
If there are 5 or more missing data points, the script won't update data.txt. You can:
- Try a different weather station
- Modify the threshold in `refresh_data_ncei` (line 117)
- Accept missing data by lowering the threshold

### Country code mismatch
Some country codes differ between ISO and NCEI. Check `ncei_station_names.py` NCEI_COUNTRY_CODES mapping.

## File Structure

```
cities.txt          - List of cities: "CityName|CC"
latlng.txt          - Coordinates: "CityName|CC|lat,lng"
data.txt            - Weather data (auto-generated)
ncei_station_names.py - Station name overrides
refresh_data_ncei   - Main data fetch script
~/gsom-latest/      - NOAA CSV data files
```
