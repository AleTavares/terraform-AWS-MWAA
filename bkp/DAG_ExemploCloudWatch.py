from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.utils.dates import days_ago
from datetime import datetime
import os,json,boto3,psutil,socket

def publish_metric(client,name,value,cat,unit='None'):
    environment_name = os.getenv("teste-airflow")
    value_number=float(value)
    hostname = socket.gethostname()
    ip_address = socket.gethostbyname(hostname)
    print('writing value',value_number,'to metric',name)
    response = client.put_metric_data(
        Namespace='MWAA-Custom',
        MetricData=[
            {
                'MetricName': name,
                'Dimensions': [
                    {
                        'Name': 'Environment',
                        'Value': str(environment_name)
                    },
                    {
                        'Name': 'Category',
                        'Value': str(cat)
                    },       
                    {
                        'Name': 'Host',
                        'Value': str(ip_address)
                    },                                     
                ],
                'Timestamp': datetime.now(),
                'Value': value_number,
                'Unit': unit
            },
        ]
    )
    print(response)
    return response

def python_fn(**kwargs):
    client = boto3.client('cloudwatch')

    cpu_stats = psutil.cpu_stats()
    print('cpu_stats', cpu_stats)

    virtual = psutil.virtual_memory()
    cpu_times_percent = psutil.cpu_times_percent(interval=0)

    publish_metric(client=client, name='memoria_virtual_total', cat='memoria_virtual', value=virtual.total, unit='Bytes')
    publish_metric(client=client, name='memoria_virtual_disponivel', cat='memoria_virtual', value=virtual.available, unit='Bytes')
    publish_metric(client=client, name='memoria_virtual_usada', cat='memoria_virtual', value=virtual.used, unit='Bytes')
    publish_metric(client=client, name='memoria_virtual_livre', cat='memoria_virtual', value=virtual.free, unit='Bytes')
    publish_metric(client=client, name='memoria_virtual_ativa', cat='memoria_virtual', value=virtual.active, unit='Bytes')
    publish_metric(client=client, name='memoria_virtual_inativa', cat='memoria_virtual', value=virtual.inactive, unit='Bytes')
    publish_metric(client=client, name='memoria_virtual_percentual', cat='memoria_virtual', value=virtual.percent, unit='Percent')

    publish_metric(client=client, name='percentual_tempo_cpu_usuario', cat='percentual_tempo_cpu', value=cpu_times_percent.user, unit='Percent')
    publish_metric(client=client, name='percentual_tempo_cpu_sistema', cat='percentual_tempo_cpu', value=cpu_times_percent.system, unit='Percent')
    publish_metric(client=client, name='percentual_tempo_cpu_idle', cat='percentual_tempo_cpu', value=cpu_times_percent.idle, unit='Percent')

    return "OK"


with DAG(dag_id=os.path.basename(__file__).replace(".py", ""), schedule_interval='*/5 * * * *', catchup=False, start_date=days_ago(1)) as dag:
    t = PythonOperator(task_id="memory_test", python_callable=python_fn, provide_context=True)