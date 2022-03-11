---
technoglogies:      airflow,python
version:				1.12.0
validated-at:			23.5.2021
---

# Schedule and Run Simple Python Application

This recipe will show how to use ...

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started.md) with the following services enabled

```
platys init --enable-services AIRFLOW -s trivadis/platys-modern-data-platform -w 1.12.0
```

Now generate and start the platform 

```
platys gen

docker-compose up -d
```

## Create an Airflow DAG



`requirements.txt`

```
numpy
pillow
pymongo
requests
```

`mainDag.py`

```
from datetime import datetime
from airflow import DAG
from airflow.operators.python_operator import PythonOperator
import backend.generate as generate
import backend.download as download
import backend.md5 as md5
import backend.grayscale as grayscale
import backend.load_result as load_result
import backend.update_monitoring as update_monitoring

dag = DAG(
    "main_dag",
    description="Simple example DAG",
    # run every minutes
    schedule_interval="*/5 * * * *",
    start_date=datetime(2017, 3, 20),
    # workflow can be run in parralel
    concurrency=3,
    catchup=False,
)

generate_operator = PythonOperator(
    task_id="generate_url", python_callable=generate.generate_urls, dag=dag
)


download_operator = PythonOperator(
    task_id="download_image",
    python_callable=download.download_urls,
    dag=dag,
    provide_context=True,
)

md5_operator = PythonOperator(
    task_id="md5_image", python_callable=md5.md5, dag=dag, provide_context=True
)

grayscale_operator = PythonOperator(
    task_id="grayscale_image",
    python_callable=grayscale.grayscale,
    dag=dag,
    provide_context=True,
)

load_result_operator = PythonOperator(
    task_id="load_result_image",
    python_callable=load_result.load_result,
    dag=dag,
    provide_context=True,
)

update_monitoring_operator = PythonOperator(
    task_id="update_monitoring_image",
    python_callable=update_monitoring.update_monitoring,
    op_kwargs={"url_filepath": "/opt/backend/urls.txt"},
    dag=dag,
    provide_context=True,
)

generate_operator >> download_operator
download_operator >> md5_operator >> load_result_operator
download_operator >> grayscale_operator >> load_result_operator
load_result_operator >> update_monitoring_operator
```
