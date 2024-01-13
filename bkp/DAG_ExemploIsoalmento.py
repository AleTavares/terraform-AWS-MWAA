# [Inicio import_module]
from datetime import timedelta
from textwrap import dedent

# O objeto DAG; precisaremos disso para instanciar um DAG
from airflow import DAG

# Operators; we need this to operate!
from airflow.operators.bash import BashOperator
from airflow.utils.dates import days_ago
from airflow.providers.amazon.aws.operators.glue import GlueJobOperator

# 
# [Fim import_module]

# [Inicio default_args]
# Esses argumentos serão repassados ​​​​para cada operador
# Você pode substituí-los por tarefa durante a inicialização do operador
default_args = {
    'owner': 'tavares',
    'depends_on_past': False,
    #'email': ['airflow@example.com'],
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
    # 'queue': 'bash_queue',
    # 'pool': 'backfill',
    # 'priority_weight': 10,
    # 'end_date': datetime(2016, 1, 1),
    # 'wait_for_downstream': False,
    # 'dag': dag,
    # 'sla': timedelta(hours=2),
    # 'execution_timeout': timedelta(seconds=300),
    # 'on_failure_callback': some_function,
    # 'on_success_callback': some_other_function,
    # 'on_retry_callback': another_function,
    # 'sla_miss_callback': yet_another_function,
    # 'trigger_rule': 'all_success'
}
# [Fim default_args]

# Configuração Job Glue
job_name = "Hello-Word"
region_name= "us-east-1"
iam_role_name="glue-airflow-role"

# [Inicio instantiate_dag]
with DAG(
    'Exemplo_DAG_Roule_DataEngenir',
    default_args=default_args,
    description='Esta DAG é exibida para os Usuarios que estiverem com a Roule DataEngenir e para os Admin',
    schedule_interval=timedelta(days=1),
    start_date=days_ago(2),
    tags=['Exemplo'],
    access_control={
        'DataEngenir': {
            'can_read', 'can_edit'
        }
    }

) as dag:
    # [Fim instantiate_dag]

    run_glue_job = GlueJobOperator(
        task_id="hello_word",
        job_name=job_name,
        region_name= region_name,
        script_location="s3://353818015911-glue-jobs/scripts/helloword.py",
        s3_bucket="353818015911-glue-jobs",
        iam_role_name=iam_role_name,
        aws_conn_id="aws_default",
        create_job_kwargs={"GlueVersion": "3.0",
                           "WorkerType": "G.1X",
                           "NumberOfWorkers": 4,},      
    )

    run_glue_job
# [END tutorial]