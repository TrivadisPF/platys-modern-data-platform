---
technologies:       duckdb
version:				1.19.0
validated-at:			26.12.2025
---

# Using DuckDB

This recipe will show how to use [DuckDB](https://github.com/mcuadros/ofelia) as part of a dataplatform stack.

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started) with the needed services enabled and generate the platform:


```bash
platys init --enable-services DUCKDB -s trivadis/platys-modern-data-platform -w 1.19.0
```

create a folder and inside that folder download a sample duckdb database

```bash
mkdir db
cd db
wget https://www.timestored.com/sqlnotebook/files/duckdb-demo.duckdb
```

configure the db folder to make the database available inside the `duckdb` container

```yaml
      DUCKDB_enable: true
      DUCKDB_ui_enabled: false
      DUCKDB_db_folder: ./db
      DUCKDB_init_script:
```

It will be mapped into the `/db` folder inside the docker container.


Now generate and start the platform 

```bash
platys gen

docker-compose up -d
```

## 1. Let's us the database inside duckdb

Start duckdb using `exec` command

```bash
docker exec -ti duckdb duckdb
```

and open the database available in the `/db` folder

```sql
.open /db/duckdb-demo.duckdb
```

```sql
show tables;
```

and you should see the tables in the db

```
D show tables;
┌───────────────────────┐
│         name          │
│        varchar        │
├───────────────────────┤
│ bank_failures         │
│ boxplot               │
│ calendar              │
│ candle                │
│ christmas_cost        │
│ companies             │
│ country_stats_scatter │
│ gold_vs_bitcoin       │
│ japan_births_deaths   │
│ japan_population      │
│ metrics               │
│ niger_population      │
│ quotes                │
│ radar                 │
│ sankey                │
│ search_trends         │
│ tree                  │
├───────────────────────┤
│        17 rows        │
└───────────────────────┘
```

## 2. Running an init script

Update the `config.yml` with the following settings

```yaml
      DUCKDB_enable: true
      DUCKDB_ui_enabled: false
      DUCKDB_db_folder: ./db
      DUCKDB_init_script: duckdb-init.sql
```

Create the scirpt named `duckdb-init.sql` inside the `./init/duckdb` folder

```sql
ATTACH IF NOT EXISTS '/db/duckdb-demo.duckdb' AS demo_db;

INSTALL httpfs;
LOAD httpfs;
```

and run `platys gen` followed by `docker compose up -d`.

Once the `duckdb` service is up and running, attach to the container

```
docker attach duckdb
```

and 

```sql
show databases
```

```sql
use demo_db
show tables
```

should show the tables of the demo db, which has been loaded by the init script.


## 2. Let's run DuckDB with the UI enabled

Update the `config.yml` with the following settings

```yaml
      DUCKDB_enable: true
      DUCKDB_ui_enabled: true
      DUCKDB_db_folder: ./db
      DUCKDB_init_script: duckdb-init.sql
```

use the same init script as shown above to attach the demo database.

and run `platys gen` followed by `docker compose up -d`.

Navigate to <https://dataplatform:28249/welcome> and you should see the `demo_db` as an attached database.


