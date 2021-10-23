# Timescale

An open-source time-series SQL database optimized for fast ingest and complex queries. Packaged as a PostgreSQL extension. 

**[Website](https://www.timescale.com/)** | **[Documentation](https://docs.timescale.com/)** | **[GitHub](https://github.com/timescale/timescaledb)**

### How to enable?

```
platys init --enable-services TIMESCALDEB
platys gen
```

### How to use it?

```
docker exec -it timescaledb psql -U timescaledb
```

```
CREATE TABLE IF NOT EXISTS weather_metrics (

   time TIMESTAMP WITHOUT TIME ZONE NOT NULL,
   timezone_shift int NULL,
   city_name text NULL,
   temp_c double PRECISION NULL,
   feels_like_c double PRECISION NULL,
   temp_min_c double PRECISION NULL,
   temp_max_c double PRECISION NULL,
   pressure_hpa double PRECISION NULL,
   humidity_percent double PRECISION NULL,
   wind_speed_ms double PRECISION NULL,
   wind_deg int NULL,
   rain_1h_mm double PRECISION NULL,
   rain_3h_mm double PRECISION NULL,
   snow_1h_mm double PRECISION NULL,
   snow_3h_mm double PRECISION NULL,
   clouds_percent int NULL,
   weather_type_id int NULL
);

-- Step 2: Turn into hypertable
SELECT create_hypertable('weather_metrics','time');
```

```
wget https://s3.amazonaws.com/assets.timescale.com/docs/downloads/weather_data.zip

unzip wather_data.zip
```

```
\copy weather_metrics (time, timezone_shift, city_name, temp_c, feels_like_c, temp_min_c, temp_max_c, pressure_hpa, humidity_percent, wind_speed_ms, wind_deg, rain_1h_mm, rain_3h_mm, snow_1h_mm, snow_3h_mm, clouds_percent, weather_type_id) from './data-transfer/weather_data.csv' CSV HEADER;
```

```
--------------------------------
-- Total snowfall per city
-- in past 5 years
--------------------------------
SELECT city_name, sum(snow_1h_mm)
FROM weather_metrics
WHERE time > now() - INTERVAL '5 years'
GROUP BY city_name;
```
