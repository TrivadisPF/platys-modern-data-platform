---
technoglogies:      streamsets
version:				1.12.0
validated-at:			10.5.2021
---

# Using Dev Simulator Orgin to simulate streaming data

This recipe will show how to use a public docker image for Oracle XE. This is instead of the "normal" way of refering to a private repository for the Oracle database docker images, due to licensing requirements by Oracle. 

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```
platys init --enable-services STREAMSETS,KAFKA,KAFKA_AKHQ -s trivadis/platys-modern-data-platform -w 1.12.0
```

Edit the `config.yml` and add the following configuration settings.

```
      STREAMSETS_stage_libs: 'streamsets-datacollector-apache-kafka_2_7-lib'
```

Now generate data platform and download the Streamsets Custom origin to the right folder. 

```
platys gen
```

Download and unpack the Dev Simulator custom origin

```
cd plugins/streamsets/user-libs

wget https://github.com/TrivadisPF/streamsets-dev-simulator/releases/download/0.7.0/dev-simulator-0.7.0.tar.gz 

tar -xvzf dev-simulator-0.7.0.tar.gz 
rm dev-simulator-0.7.0.tar.gz 

cd ../../..
```

Download the data and unpack into `data-transfer` folder

```
cd data-transfer
wget https://github.com/TrivadisPF/platys-modern-data-platform/raw/master/cookbooks/recipes/using-dev-simulator-origin/data.tar.gz

tar -xvzf data.tar.gz
rm data.tar.gz
```

Start the platform:

```
docker-compose up -d
```

## Using Relative from Anchor Time mode 

You can find the StreamSets pipeline in the folder `streamsets`.

### without header

`relative-anchor-without-header.csv`

```
1,10,1
5,10,2
10,10,3
15,10,4
20,10,5
```

Streamsets: `RelativeAnchorTimeWithoutHeader`

Dev Simulator Properties (only the ones which have to change from the defaults):

* **Files**
  * **Files Directory:** `/data-transfer/data`
  * **File Name Pattern:** `relative-anchor-without-header.csv`
  * **Different Record Types?:** `false`
* **Event Time**
  * **Timestamp Mode:** `Relative from Anchor Timestamp`
  * **Timestamp Field:** `/0`
  * **Relative Time Resolution:** `seconds`
  * **Anchor Time is Now?:** `true`
* **Data Format**
  * **Header Line:** `No Header Line`


### with header

Input File: `relative-anchor-with-header.csv`

```
time,id,value
1,10,1
5,10,2
10,10,3
15,10,4
20,10,5
```

Streamsets: `RelativeAnchorTimeWithHeader`

Dev Simulator Properties (only the ones which have to change from the defaults):

* **Files**
  * **Files Directory:** `/data-transfer/data`
  * **File Name Pattern:** `relative-anchor-with-header.csv`
  * **Different Record Types?:** `false` 
* **Event Time**
  * **Timestamp Mode:** `Relative from Anchor Timestamp`
  * **Timestamp Field:** `/time`
  * **Relative Time Resolution:** `seconds`
  * **Anchor Time is Now?:** `true`
* **Data Format**
  * **Header Line:** `With Header Line`
  
## Using Relative from Previous Event 

### with header

Input File: `relative-previous-event-with-header.csv`

```
time,id,value
0,10,1
5,10,2
5,10,3
5,10,4
5,10,5
```

Streamsets: `RelativePrevEventTimeWithHeader`

Dev Simulator Properties (only the ones which have to change from the defaults):

* **Files**
  * **Files Directory:** `/data-transfer/data`
  * **File Name Pattern:** `relative-previous-event-with-header.csv `
  * **Different Record Types?:** `false` 
* **Event Time**
  * **Timestamp Mode:** `Relative from Previous Event`
  * **Timestamp Field:** `/time`
  * **Relative Time Resolution:** `seconds`
  * **Anchor Time is Now?:** `true`
* **Data Format**
  * **Header Line:** `With Header Line`

## Using Relative from Anchor - with multiple record types in same file

### without header

`relative-anchor-without-header-with-muliple-types-one-file.csv`

```
0,A,10,1
5,A,10,2
10,A,10,3
11,B,10,4
15,B,10,5
17,A,10,3
```

Streamsets: `RelativeAnchorTimeWithoutHeaderMultiTypeOneFile `

Dev Simulator Properties (only the ones which have to change from the defaults):

* **Files**
  * **Files Directory:** `/data-transfer/data`
  * **File Name Pattern:** `relative-anchor-without-header-with-muliple-types-one-file.csv`
  * **Different Record Types?:** `true` 
* **Event Time**
  * **Timestamp Mode:** `Relative from Anchor Timestamp`
  * **Timestamp Field:** `/0`
  * **Relative Time Resolution:** `seconds`
  * **Anchor Time is Now?:** `true`
* **Multi Record Types**
  * **Data Types:** 
     * **Descriminator value 1:** `A`
     * **Descriminator value 2:** `B`
  * **Descriminator field:** `/1`
* **Data Format**
  * **Header Line:** `No Header Line`

### with header

`relative-anchor-with-header-with-muliple-types-one-file.csv`

```csv
time,descriminator,id,value
0,A,10,1
5,A,10,2
10,A,10,3
11,B,10,4
15,B,10,5
17,A,10,3
```

Streamsets: `RelativeAnchorTimeWithHeaderMultiTypeOneFile `

Dev Simulator Properties (only the ones which have to change from the defaults):

* **Files**
  * **Files Directory:** `/data-transfer/data`
  * **File Name Pattern:** `relative-anchor-with-header-with-muliple-types-one-file.csv`
  * **Different Record Types?:** `true` 
* **Event Time**
  * **Timestamp Mode:** `Relative from Anchor Timestamp`
  * **Timestamp Field:** `/time`
  * **Relative Time Resolution:** `seconds`
  * **Anchor Time is Now?:** `true`
* **Multi Record Types**
  * **Data Types:** 
     * **Descriminator value 1:** `A`
     * **Descriminator value 2:** `B`
  * **Descriminator field:** `/descriminator`
* **Data Format**
  * **Header Line:** `With Header Line`

## Using Relative from Anchor - with multiple record types in file per type

### with header

`relative-anchor-with-header-with-muliple-types-fileA.csv`

```csv
0,A,10,1
5,A,10,2
10,A,10,3
17,A,10,3
```

`relative-anchor-with-header-with-muliple-types-fileB.csv`

```csv
11,B,10,4
15,B,10,5
```

Streamsets: `RelativeAnchorTimeWithHeaderMultiTypeMultiFile`

Dev Simulator Properties (only the ones which have to change from the defaults):

* **Files**
  * **Files Directory:** `/data-transfer/data`
  * **File Name Pattern:** `relative-anchor-with-header-with-muliple-types-file*.csv`
  * **Different Record Types?:** `true` 
* **Event Time**
  * **Timestamp Mode:** `Relative from Anchor Timestamp`
  * **Timestamp Field:** `/time`
  * **Relative Time Resolution:** `seconds`
  * **Anchor Time is Now?:** `true`
* **Multi Record Types**
  * **Data Types:** 
     * **Descriminator value 1:** `A`
     * **Descriminator value 2:** `B`
  * **Descriminator field:** `/descriminator`
* **Data Format**
  * **Header Line:** `With Header Line`