# PostgreSQL

PostgreSQL is a powerful, open source object-relational database system with over 30 years of active development that has earned it a strong reputation for reliability, feature robustness, and performance. 

**[Website](http://www.postgresql.org)** | **[Documentation](https://www.postgresql.org/docs/)** | **[GitHub](https://github.com/postgres/postgres)**

## How to enable?

```
platys init --enable-services POSTRESQL
platys gen
```

## How to use it?

### Connect to the Postgresql CLI

``` bash
docker exec -ti postgresql psql -d demodb -U demo
```

### How to create tables and add data when starting Postgresql?

Navigate to `./init/postgresql` and create a sql file

```bash
cd ./init/postgresql
nano create_driver.sql
```

and add the following commands:

```sql
DROP TABLE IF EXISTS driver;
CREATE TABLE IF NOT EXISTS driver (id BIGINT, first_name CHARACTER VARYING(45), last_name CHARACTER VARYING(45), available CHARACTER VARYING(1), birthdate DATE, last_update TIMESTAMP);
ALTER TABLE driver ADD CONSTRAINT driver_pk PRIMARY KEY (id);

INSERT INTO "driver" ("id", "first_name", "last_name", "available", "birthdate", "last_update") VALUES (10,'Diann', 'Butler', 'Y', '10-JUN-68', CURRENT_TIMESTAMP);
INSERT INTO "driver" ("id", "first_name", "last_name", "available", "birthdate", "last_update") VALUES (11,'Micky', 'Isaacson', 'Y', '31-AUG-72' ,CURRENT_TIMESTAMP);
INSERT INTO "driver" ("id", "first_name", "last_name", "available", "birthdate", "last_update") VALUES (12,'Laurence', 'Lindsey', 'Y', '19-MAY-78' ,CURRENT_TIMESTAMP);
INSERT INTO "driver" ("id", "first_name", "last_name", "available", "birthdate", "last_update") VALUES (13,'Pam', 'Harrington', 'Y','10-JUN-68' ,CURRENT_TIMESTAMP);
INSERT INTO "driver" ("id", "first_name", "last_name", "available", "birthdate", "last_update") VALUES (14,'Brooke', 'Ferguson', 'Y','10-DEC-66' ,CURRENT_TIMESTAMP);
```

Connect to Postgresql CLI to see that the table has been created:

```
docker exec -ti postgresql psql -d demodb -U demo -c "SELECT * FROM driver"
```	