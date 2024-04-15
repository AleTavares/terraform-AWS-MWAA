# Instancia AWS MWAA com Terraform
A idéia deste projeto é criar uma Instancia de MWAA (Amazon Managed Workflows for Apache Airflow) na AWS para utilizarmos como orquestrador no projeto de plataforma de dados.


# Pré requisito
- Uma conta AWS com permissões apropriadas para criar recursos como instâncias Ec2, instâncias RDS e acesso Terraform.
- Terraform instalado em sua máquina local.

# Utilizando o Repo
No arquivo terraform.tfvas vai encontrar as variaveis:
```terraform
region      = "us-east-2" # Região onde Serão criado os Recursos
bucket_name = "mwaa" # Nome do Buckt que será criado para armazenar os Artefatos do MWAA
name        = "orquestrador-plataforma" # Nome da Instancia de MWAA
``` 
> [!NOTE]
> As pariveis podem ser alteradas de acordo com as necessidades

- Abra um terminal com git instalado

- Clone o repositorio para a sua maquina
```bash
git clone https://github.com/AleTavares/terraform-AWS-MWAA.git
```

- acesse a pasta do projeto
```bash
cd terraform-AWS-MWAA
```
> [!NOTE]
>Crie as chaves de acesso da AWS e coloque nas variaveis de ambiente:
> ```bash
> export AWS_ACCESS_KEY_ID=[access key gerada na AWS]
> export AWS_SECRET_ACCESS_KEY=[ secret key gerada na AWS]
> ```

- inicialize o Terraform
```bash
terraform init
```

- Gere o plano de execução do Terraform
``` bash
terraform plan -out plan.out
```

- Aplique o plano de Execução do Terraform
``` bash
terraform apply plan.out
```

Feito estes passos ele vai criar os recursos na AWS e gerar o endpoint da IDE do AirFlow

> [!CAUTION]
>Não se esqueça de destruir o recurso após utilizar para que não seja cobrado desnecessariamente
> ```bash
> terraform destroy
> ```
> confirme a destruição dos recursos