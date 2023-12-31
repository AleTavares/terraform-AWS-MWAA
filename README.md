# Criar um ambiente AWS MWAA (Airflow) com Terraform
Nos ultimos dias precisei subir um ambiente de MWAA para alguns testes e me deparei com uma dificuldade em encontrar um código derraforme simples so pra subir um ambiente de teste foi então que decidi construir este código.

Estou montando um ambiente MWAA com isolamento de DAG, ou seja, que dada usuario ou grupo so vejam as DAG's que tem acesso.

Pretendo ir subindo os códigos aqui conforme for evoluindo.

# O que é o Amazon Managed Workflows for Apache Airflow?
O Amazon Managed Workflows for Apache Airflow é um serviço de orquestração gerenciado para o Apache Airflow que você pode usar para configurar e operar data pipelines na nuvem em escala. O Apache Airflow é uma ferramenta de código aberto usada para criar, agendar e monitorar programaticamente sequências de processos e tarefas conhecidas como fluxos de trabalho. Com o Amazon MWAA, você pode usar o Apache Airflow e o Python para criar fluxos de trabalho sem precisar gerenciar a infraestrutura subjacente para escalabilidade, disponibilidade e segurança. O Amazon MWAA escala automaticamente sua capacidade de execução de fluxo de trabalho para atender às suas necessidades. O Amazon MWAA se integra aos serviços AWS de segurança para ajudar a fornecer acesso rápido e seguro aos seus dados.

# Oque é o AirFow
Apache Airflow™ é uma plataforma de código aberto para desenvolvimento, agendamento e monitoramento de fluxos de trabalho orientados em lote. A estrutura Python extensível do Airflow permite criar fluxos de trabalho conectados a praticamente qualquer tecnologia. Uma interface web ajuda a gerenciar o estado dos seus fluxos de trabalho. O Airflow pode ser implantado de várias maneiras, variando desde um único processo em seu laptop até uma configuração distribuída para oferecer suporte até mesmo aos maiores fluxos de trabalho.

# Características do Apache Airflow
A principal característica do Apache Airflow é a capacidade de definir, programar e monitorar fluxos de trabalho complexos, chamados de DAGs (Directed Acyclic Graphs). O Airflow foi construído para lidar com dependências entre tarefas e para gerenciar falhas, fornecendo mecanismos de retentativa e notificações de alerta.
As tarefas e suas dependências são definidas em Python, tornando-as mais flexíveis e acessíveis. Além disso, o Airflow oferece uma interface de usuário baseada na web para visualizar e gerenciar fluxos de trabalho, o que facilita o monitoramento e a depuração de problemas.

### Vantagens do Apache Airflow

Flexibilidade: O Airflow é altamente flexível e pode se integrar a uma variedade de sistemas de backend e ferramentas de processamento de dados. Ele suporta uma ampla gama de operadores para interagir com diferentes serviços como AWS, bancos de dados, FTP, HTTP, entre outros.
Programação em Python: Como os fluxos de trabalho são programados em Python, os desenvolvedores podem usar todas as vantagens da linguagem, como facilidade de uso, capacidade de criação de scripts complexos e automação de tarefas no sistema operacional como movimentação de arquivos, por exemplo.
Escalabilidade: O Apache Airflow é escalável e pode lidar com um grande volume de fluxos de trabalho e tarefas.
Monitoramento e Notificação: A interface do usuário permite o monitoramento em tempo real dos fluxos de trabalho e o envio de notificações em caso de falhas.

### Desvantagens do Apache Airflow
Configuração e Manutenção: Configurar e manter um ambiente Airflow pode ser complicado e demorado, especialmente para grandes implementações. A otimização do desempenho pode exigir um conhecimento profundo do sistema e a resolução de problemas pode ser desafiadora devido à complexidade do Airflow.
Falta de Isolamento de Tarefas: No Airflow, as tarefas são executadas no mesmo ambiente, o que significa que uma tarefa pode afetar potencialmente o desempenho de outra. Isso contrasta com outras ferramentas de orquestração que oferecem isolamento de tarefas.
UI (User Interface) pode ser Limitada: Embora a interface do usuário seja útil para monitoramento e depuração, ela tem suas limitações. Algumas tarefas, como a visualização detalhada do progresso das tarefas ou a modificação de DAGs, podem ser complicadas.

Apesar dessas desvantagens, o Apache Airflow continua sendo uma escolha popular e poderosa para a orquestração de fluxos de trabalho. Sua flexibilidade, escalabilidade e capacidade de se integrar a uma variedade de sistemas o tornam uma ferramenta atraente.

Como acontece com qualquer ferramenta, entender suas forças e limitações é a chave para usá-la efetivamente. 

### Com isso recomendamos:
**Ler a Documentação do Apache AirFlow**
- https://airflow.apache.org/docs/apache-airflow/stable/index.html
- https://docs.aws.amazon.com/pt_br/mwaa/latest/userguide/what-is-mwaa.html

**Seguir as boas praticas de desenvolvimento**
- https://airflow.apache.org/docs/apache-airflow/stable/best-practices.html
- https://docs.aws.amazon.com/pt_br/mwaa/latest/userguide/best-practices.html

