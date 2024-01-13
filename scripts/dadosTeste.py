# Imports
from pyspark.sql import SparkSession
import os
import boto3
client = boto3.client('lambda','us-east-1')
pathSource = "s3://353818015911-dados/dadosTeste.csv"
pathOutput ="s3://353818015911-dados/"

# Registra Inicio do job no CludWotch
response = client.invoke(
    FunctionName='logSLA',
    InvocationType='Event',
    # LogType='Tail',
    Payload='{\
        "metric_name": "Volumetria_bytes",\
        "namespace": "DataLakeMetricasCustomizadas",\
        "nome_tabela": "arqTeste",\
        "status": "meio",\
        "unit": "None"\
    }',
)

# Cria uma sessão Spark
spark = SparkSession.builder \
    .appName("Ingestão de Dados para teste de Log") \
    .getOrCreate()

# Configura o nível de log
spark.sparkContext.setLogLevel('ERROR')
conn = boto3.resource('s3')
object_summary = conn.ObjectSummary('353818015911-dados','dadosTeste.csv')

# bk = conn.get_bucket('')
# key = bk.lookup('')

response = client.invoke(
    FunctionName='logVolumetria',
    InvocationType='Event',
    LogType='Tail',
    Payload='{\
        "metric_name": "Volumetria_bytes",\
        "namespace": "DataLakeMetricasCustomizadas",\
        "nome_tabela": "teste",\
        "status": "inicio",\
        "step_name": "load",\
        "Volume": ' + str(object_summary.size) + ',\
        "unit": "Bytes"\
    }',
)

# Carrega o conjunto de dados no formato CSV
dfTeste = spark.read\
    .format("csv")\
    .option("header", "true")\
    .option("delimiter", ";")\
    .load(pathSource)
 
response = client.invoke(
    FunctionName='logVolumetria',
    InvocationType='Event',
    # LogType='Tail',
    Payload='{\
        "metric_name": "quantidade_registros",\
        "namespace": "DataLakeMetricasCustomizadas",\
        "nome_tabela": "teste",\
        "status": "inicio",\
        "step_name": "load",\
        "Volume": '+ str(dfTeste.count()) +',\
        "unit": "float"\
    }'
)

# Salvar o resultado em um arquivo CSV
dfTeste.write.format("parquet")\
                .mode("overwrite")\
                .save("dataTeste.parquet")

object_summary = conn.ObjectSummary('353818015911-dados','dataTeste.parquet')
# bk = conn.get_bucket('353818015911-dados')
# key = bk.lookup('')

# Encerrar a sessão Spark
spark.stop()
