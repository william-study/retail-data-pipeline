from airflow import DAG
from airflow.operators.empty import EmptyOperator
from datetime import datetime

with DAG(
    dag_id="retail_pipeline",
    start_date=datetime(2026, 1, 1),
    schedule=None,
    catchup=False
) as dag:

    bronze_task = EmptyOperator(
        task_id="bronze_layer"
    )

    silver_task = EmptyOperator(
        task_id="silver_layer"
    )

    gold_task = EmptyOperator(
        task_id="gold_layer"
    )

    bronze_task >> silver_task >> gold_task