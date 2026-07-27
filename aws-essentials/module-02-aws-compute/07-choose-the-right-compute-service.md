# Choose the Right Compute Service

## Visão Geral

A AWS oferece diversos serviços de computação, cada um otimizado para casos de uso específicos. Escolher o serviço certo afeta diretamente **custo**, **performance**, **complexidade operacional** e **escalabilidade**. Este guia fornece um **framework de decisão** para ajudar você a selecionar o serviço de computação ideal.

## Framework de Decisão

### 1. Qual é o padrão de execução?

| Padrão | Serviço Recomendado | Justificativa |
|--------|---------------------|---------------|
| **Sempre ativo** | EC2, ECS, EKS | Instâncias/containers em execução contínua |
| **Event-driven** | Lambda | Execução por evento, escala de zero |
| **Tarefa pontual** | Lambda, Batch | Execução única ou em lote |
| **Web application** | EC2 + ALB, ECS, Lambda + API GW | Depende da complexidade |

### 2. Qual é a frequência de execução?

| Frequência | Serviço Recomendado | Justificativa |
|------------|---------------------|---------------|
| **Contínuo (24/7)** | EC2, ECS, EKS | Instâncias sempre em execução |
| **Intermitente** | Lambda | Pague apenas quando executado |
| **Diário/Semanal** | Lambda, Batch | Execução programada |
| **Sporádico** | Lambda | Escala de zero, sem custo quando inativo |

### 3. Qual é o tempo de execução esperado?

| Tempo | Serviço Recomendado | Justificativa |
|-------|---------------------|---------------|
| **< 15 minutos** | Lambda | Limite máximo do Lambda |
| **15 min - 1 hora** | Lambda (com Step Functions), Batch | Lambda com orquestração |
| **1-24 horas** | EC2, Batch | Processamento em lote |
| **> 24 horas** | EC2 | Processamento contínuo |

### 4. Qual é o requisito de controle?

| Requisito | Serviço Recomendado | Justificativa |
|-----------|---------------------|---------------|
| **Controle total do SO** | EC2 | Acesso root, configurações customizadas |
| **Controle do container** | ECS, EKS | Gerenciamento de imagens e orquestração |
| **Apenas código** | Lambda | Foco exclusivo no código |
| **Nenhum controle** | Lambda | Total abstração |

## Matriz de Decisão

| Critério | EC2 | ECS/Fargate | EKS | Lambda | Batch |
|----------|-----|-------------|-----|--------|-------|
| **Tipo** | IaaS | CaaS | CaaS | FaaS | Service |
| **Abstração** | Baixa | Média | Média | Alta | Média |
| **Escalabilidade** | Manual/Auto Scaling | Automática | Automática | Automática (zero→N) | Automática |
| **Cold Start** | Não | Sim | Sim | Sim | Não |
| **Timeout** | Ilimitado | Ilimitado | Ilimitado | 15 min | Ilimitado |
| **Stateful** | Sim | Sim | Sim | Não | Sim |
| **Custo (idle)** | Alto | Médio | Médio | Zero | Zero |
| **Custo (ativo)** | Por hora | Por vCPU/memória | Por vCPU/memória | Por invocação | Por vCPU/hora |
| **Curva de Aprendizado** | Média | Alta | Muito Alta | Baixa | Média |
| **Caso Ideal** | Controle total | Microserviços | Kubernetes | Eventos | Processamento em lote |

## Serviços de Computação da AWS

| Serviço | Descrição | Caso de Uso |
|---------|-----------|-------------|
| **Amazon EC2** | Servidores virtuais sob demanda | Aplicações web, migração de data center, workloads customizados |
| **AWS Lambda** | Execução de código por evento | Processamento de eventos, APIs, automação |
| **Amazon ECS** | Orquestrador de containers (proprietário) | Microserviços, aplicações containerizadas |
| **Amazon EKS** | Orquestrador de containers (Kubernetes) | Migração de Kubernetes, multi-cloud |
| **AWS Fargate** | Serverless para containers | ECS/EKS sem gerenciar servidores |
| **AWS Batch** | Processamento em lote | Jobs de ETL, processamento de dados |
| **Amazon Lightsail** | Servidores virtuais simplificados | Desenvolvimento, pequenas aplicações |
| **AWS Elastic Beanstalk** | Platform as a Service | Deploy simplificado de aplicações |

## Cenários de Escolha

### Cenário 1: Aplicação Web de Produção

**Contexto**: Uma aplicação web de e-commerce precisa de alta disponibilidade, controle total do ambiente e capacidade de escalar durante picos de tráfego.

**Decisão**: **Amazon EC2 + Application Load Balancer + Auto Scaling**
- **Por quê**: O EC2 fornece controle total sobre o SO, configurações de segurança e instalação de pacotes específicos. O ALB distribui tráfego e o Auto Scaling ajusta o número de instâncias conforme a demanda.
- **Alternativa**: Para microserviços, ECS com Fargate oferece menos complexidade operacional.

### Cenário 2: Processamento de Eventos

**Contexto**: Uma aplicação precisa processar arquivos enviados ao S3 (redimensionar imagens, extrair metadados) e enviar notificações.

**Decisão**: **AWS Lambda + S3 Events + SNS**
- **Por quê**: O Lambda é acionado automaticamente quando um arquivo é enviado ao S3, processa a imagem e envia uma notificação via SNS. Pague apenas pelo processamento real, sem custo quando inativo.
- **Alternativa**: Para processamento mais longo, usar SQS + EC2 Batch.

### Cenário 3: API REST

**Contexto**: Uma API REST precisa servir dados para uma aplicação mobile, com escalabilidade automática e baixo custo.

**Decisão**: **Amazon API Gateway + AWS Lambda (Arquitetura Serverless)**
- **Por quê**: API Gateway gerencia o tráfego HTTP e aciona funções Lambda para processar requisições. Escalabilidade automática, pay-per-use e integração com Cognito para autenticação.
- **Alternativa**: Para APIs complexas com muita lógica, EC2 + ALB oferece mais controle.

### Cenário 4: Microserviços Containerizados

**Contexto**: Uma aplicação monolítica foi dividida em microserviços, cada um em um container Docker.

**Decisão**: **Amazon ECS com Fargate**
- **Por quê**: ECS orquestra os containers, Fargate elimina a necessidade de gerenciar servidores. Integração nativa com ALB, CloudWatch e IAM.
- **Alternativa**: Para equipes com experiência em Kubernetes, EKS oferece mais flexibilidade e portabilidade.

### Cenário 5: Processamento em Lote

**Contexto**: Jobs de processamento noturno (ETL, relatórios) precisam ser executados em horários específicos com alta performance.

**Decisão**: **AWS Batch**
- **Por quê**: AWS Batch gerencia a provisionamento de instâncias EC2 (incluindo Spot) para executar jobs em lote. Oferece filas, prioridades e escalabilidade automática.
- **Alternativa**: Para jobs simples, Lambda com CloudWatch Events (cron).

### Cenário 6: Migração de Data Center

**Contexto**: Uma empresa precisa migrar servidores físicos para a AWS, mantendo os mesmos sistemas operacionais e configurações.

**Decisão**: **Amazon EC2**
- **Por quê**: O EC2 fornece controle total sobre o SO, permitindo migração direta de servidores físicos usando o AWS Application Migration Service (MGN).
- **Alternativa**: Para aplicações modernas, considerar migração para containers (ECS/EKS).

## Tabela de Referência Rápida

| Serviço | Quando Usar | Quando NÃO Usar |
|---------|-------------|-----------------|
| **EC2** | Controle total do SO, migração, workloads customizados | Custos de idle, complexidade operacional |
| **Lambda** | Eventos, processamento curto, APIs simples | Processamento longo, stateful, controle do SO |
| **ECS** | Microserviços, containers, integração AWS | Experiência prévia com Kubernetes |
| **EKS** | Kubernetes existente, multi-cloud | Simplicidade, custo de orquestração |
| **Fargate** | ECS/EKS sem gerenciar servidores | Controle granular de instâncias |
| **Batch** | Processamento em lote, jobs programados | Processamento em tempo real |
| **Lightsail** | Desenvolvimento, pequenas aplicações | Produção em escala |
| **Elastic Beanstalk** | Deploy rápido, aplicações padrão | Controle total da infraestrutura |

## Links Oficiais

- [AWS Compute Services](https://aws.amazon.com/compute/)
- [Amazon EC2 User Guide](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html)
- [AWS Lambda Developer Guide](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html)
- [Amazon ECS Developer Guide](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-what-is-api.html)
- [Amazon EKS User Guide](https://docs.aws.amazon.com/eks/latest/userguide/eks-what-is.html)
- [AWS Batch User Guide](https://docs.aws.amazon.com/batch/latest/userguide/what-is-batch.html)
