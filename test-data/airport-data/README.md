
# Airport Data

The data in this folder has been downloaded from <https://ourairports.com/data/>.

It can be combined with the data in `../flight-data`.

## Airports (csv, json, avro, parquet)

```
root
 |-- id: integer (nullable = true)
 |-- ident: string (nullable = true)
 |-- type: string (nullable = true)
 |-- name: string (nullable = true)
 |-- latitude_deg: double (nullable = true)
 |-- longitude_deg: double (nullable = true)
 |-- elevation_ft: integer (nullable = true)
 |-- continent: string (nullable = true)
 |-- iso_country: string (nullable = true)
 |-- iso_region: string (nullable = true)
 |-- municipality: string (nullable = true)
 |-- scheduled_service: string (nullable = true)
 |-- gps_code: string (nullable = true)
 |-- iata_code: string (nullable = true)
 |-- local_code: string (nullable = true)
 |-- home_link: string (nullable = true)
 |-- wikipedia_link: string (nullable = true)
 |-- keywords: string (nullable = true)
```

## Airport Comments (csv)

```
root
 |-- id: string (nullable = true)
 |--  "threadRef": string (nullable = true)
 |--  "airportRef": string (nullable = true)
 |--  "airportIdent": string (nullable = true)
 |--  "date": string (nullable = true)
 |--  "memberNickname": string (nullable = true)
 |--  "subject": string (nullable = true)
 |--  "body": string (nullable = true)
```
 
## Airport Frequencies (csv)

```
root
 |-- id: integer (nullable = true)
 |-- airport_ref: integer (nullable = true)
 |-- airport_ident: string (nullable = true)
 |-- type: string (nullable = true)
 |-- description: string (nullable = true)
 |-- frequency_mhz: double (nullable = true)
```
 
## Countries (csv)
 
```
root
 |-- id: integer (nullable = true)
 |-- code: string (nullable = true)
 |-- name: string (nullable = true)
 |-- continent: string (nullable = true)
 |-- wikipedia_link: string (nullable = true)
 |-- keywords: string (nullable = true)
```

## Regions (csv)

```
root
 |-- id: integer (nullable = true)
 |-- code: string (nullable = true)
 |-- local_code: string (nullable = true)
 |-- name: string (nullable = true)
 |-- continent: string (nullable = true)
 |-- iso_country: string (nullable = true)
 |-- wikipedia_link: string (nullable = true)
 |-- keywords: string (nullable = true)
```

## Runways (csv)

```
root
 |-- id: integer (nullable = true)
 |-- airport_ref: integer (nullable = true)
 |-- airport_ident: string (nullable = true)
 |-- length_ft: integer (nullable = true)
 |-- width_ft: integer (nullable = true)
 |-- surface: string (nullable = true)
 |-- lighted: integer (nullable = true)
 |-- closed: integer (nullable = true)
 |-- le_ident: string (nullable = true)
 |-- le_latitude_deg: double (nullable = true)
 |-- le_longitude_deg: double (nullable = true)
 |-- le_elevation_ft: integer (nullable = true)
 |-- le_heading_degT: double (nullable = true)
 |-- le_displaced_threshold_ft: integer (nullable = true)
 |-- he_ident: string (nullable = true)
 |-- he_latitude_deg: double (nullable = true)
 |-- he_longitude_deg: double (nullable = true)
 |-- he_elevation_ft: integer (nullable = true)
 |-- he_heading_degT: double (nullable = true)
 |-- he_displaced_threshold_ft: integer (nullable = true)
```

## Navaids (csv)

```
root
 |-- id: integer (nullable = true)
 |-- filename: string (nullable = true)
 |-- ident: string (nullable = true)
 |-- name: string (nullable = true)
 |-- type: string (nullable = true)
 |-- frequency_khz: integer (nullable = true)
 |-- latitude_deg: double (nullable = true)
 |-- longitude_deg: double (nullable = true)
 |-- elevation_ft: integer (nullable = true)
 |-- iso_country: string (nullable = true)
 |-- dme_frequency_khz: integer (nullable = true)
 |-- dme_channel: string (nullable = true)
 |-- dme_latitude_deg: double (nullable = true)
 |-- dme_longitude_deg: double (nullable = true)
 |-- dme_elevation_ft: integer (nullable = true)
 |-- slaved_variation_deg: double (nullable = true)
 |-- magnetic_variation_deg: double (nullable = true)
 |-- usageType: string (nullable = true)
 |-- power: string (nullable = true)
 |-- associated_airport: string (nullable = true)
```


 
 