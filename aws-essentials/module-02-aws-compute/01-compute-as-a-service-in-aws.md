# Compute as a Service in AWS

## Visão Geral

A AWS oferece diversos modelos de **computação em nuvem**, cada um com diferentes níveis de abstração, gerenciamento e flexibilidade. Esses modelos permitem que você escolha o equilíbrio certo entre **controle** e **simplicidade operacional**, dependendo das necessidades da sua aplicação.

Os principais modelos de serviço de computação são:

| Modelo | Abstração | Responsabilidade do Cliente | Responsabilidade da AWS |
|--------|-----------|----------------------------|------------------------|
| **IaaS** (Infrastructure as a Service) | Hardware virtualizado | SO, apps, dados, redes, patches | Hardware, virtualização, armazenamento físico |
| **CaaS** (Container as a Service) | Orquestração de containers | Imagens, apps, dados | Orquestração, infraestrutura subjacente |
| **FaaS** (Function as a Service) | Execução de código por evento | Código, variáveis de ambiente | Servidores, escalabilidade, runtime |

## Amazon EC2 (IaaS)

O **Amazon EC2** é o serviço de **Infrastructure as a Service (IaaS)** mais fundamental da AWS. Ele fornece **servidores virtuais (instâncias)** sob demanda, com controle total sobre o sistema operacional, armazenamento, rede e configurações.

```
┌─────────────────────────────────────────────────────────┐
│                    Cliente                              │
└──────────────────────────┬──────────────────────────────┘
                           │ HTTP/HTTPS
┌──────────────────────────▼──────────────────────────────┐
│                    Amazon EC2 (Instância)               │
│  ┌────────────────────────────────────────────────────┐  │
│  │  Sistema Operacional (Amazon Linux, Ubuntu, etc.)  │  │
│  └────────────────────────────────────────────────────┘  │
│  ┌────────────────────────────────────────────────────┐  │
│  │  Aplicação (Apache, Nginx, Python, Node.js, etc.)   │  │
│  └────────────────────────────────────────────────────┘  │
│  ┌────────────────────────────────────────────────────┐  │
│  │  Armazenamento (EBS, Instance Store)                │  │
│  └────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
```

### Características Principais

- **Controle total**: Você gerencia o SO, patches, configurações de segurança e aplicações
- **Flexibilidade**: Escolha o tipo de instância, AMI, armazenamento e configurações de rede
- **Previsibilidade**: Você paga por hora/segundo enquanto a instância está em execução
- **Responsabilidade compartilhada**: A AWS gerencia a infraestrutura física; você gerencia tudo acima do hypervisor

## AWS Lambda (FaaS)

O **AWS Lambda** é o serviço de **Function as a Service (FaaS)** da AWS. Ele permite executar código **sem provisionar ou gerenciar servidores**, acionando a execução em resposta a eventos e escalando automaticamente.

```
┌─────────────────────────────────────────────────────────┐
│                    Evento (S3, API GW, etc.)            │
└──────────────────────────┬──────────────────────────────┘
                           │
┌──────────────────────────▼──────────────────────────────┐
│                    AWS Lambda Runtime                   │
│  ┌────────────────────────────────────────────────────┐  │
│  │  Código (Python, Node.js, Java, Go, etc.)          │  │
│  └────────────────────────────────────────────────────┘  │
│  ┌────────────────────────────────────────────────────┐  │
│  │  Execução automática e escalável                   │  │
│  └────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
```

### Características Principais

- **Serverless**: Nenhum servidor para provisionar ou gerenciar
- **Pay-per-execution**: Pague apenas pelo tempo de execução (milissegundos)
- **Escalabilidade automática**: A partir de zero até milhares de invocações simultâneas
- **Stateless**: Funções não preservam estado entre invocações

## Amazon ECS / EKS (CaaS)

Os serviços de **container** da AWS (ECS e EKS) oferecem um modelo intermedário entre IaaS e FaaS, onde você gerencia **imagens de container** e **aplicações**, mas a AWS gerencia a orquestração e infraestrutura subjacente.

```
┌─────────────────────────────────────────────────────────┐
│                    Cliente                              │
└──────────────────────────┬──────────────────────────────┘
                           │
┌──────────────────────────▼──────────────────────────────┐
│                    Load Balancer                        │
└──────────────────────────┬──────────────────────────────┘
                           │
┌──────────────────────────▼──────────────────────────────┐
│                    ECS/EKS Cluster                    │
│  ┌───────────────┐  ┌───────────────┐  ┌───────────────┐ │
│  │  Container    │  │  Container    │  │  Container    │ │
│  │  (App)        │  │  (App)        │  │  (App)        │ │
│  └───────────────┘  └───────────────┘  └───────────────┘ │
└─────────────────────────────────────────────────────────┘
```

### Características Principais

- **Portabilidade**: Containers podem ser movidos entre ambientes
- **Eficiência**: Melhor densidade de recursos comparado a VMs individuais
- **Orquestração gerenciada**: ECS (proprietário) ou EKS (Kubernetes)
- **Integração AWS**: IAM, Security Groups, Load Balancers, CloudWatch

## Conceitos Chave

- **Compute as a Service**: Modelo onde a AWS fornece a capacidade computacional sob demanda, eliminando a necessidade de provisionamento manual de servidores.

- **Modelos de Serviço**:
  - **IaaS**: Você gerencia tudo acima do hypervisor (SO, apps, dados)
  - **CaaS**: Você gerencia containers e apps; AWS gerencia orquestração
  - **FaaS**: Você gerencia apenas o código; AWS gerencia tudo

- **Abstração de Infraestrutura**: Quanto mais alto o modelo de serviço, menos você precisa gerenciar. FaaS oferece a maior abstração; IaaS oferece o menor nível de abstração.

- **Escalabilidade**:
  - **IaaS (EC2)**: Escalabilidade manual ou via Auto Scaling Groups
  - **CaaS (ECS/EKS)**: Escalabilidade automática de containers
  - **FaaS (Lambda)**: Escalabilidade automática de zero até milhares de invocações

- **Modelo de Preço**:
  - **IaaS**: Pago por hora/segundo de execução da instância
  - **CaaS**: Pago por vCPU e memória dos containers
  - **FaaS**: Pago por número de invocações e tempo de execução

- **Casos de Uso por Modelo**:
  - **IaaS**: Aplicações que precisam de controle total do SO, migração de data center, workloads com requisitos específicos de sistema
  - **CaaS**: Microserviços, aplicações containerizadas, CI/CD
  - **FaaS**: Processamento de eventos, APIs serverless, automação, processamento de dados em lote

## Comparação dos Modelos

| Critério | EC2 (IaaS) | ECS/EKS (CaaS) | Lambda (FaaS) |
|----------|-----------|----------------|---------------|
| **Abstração** | Baixa (gerencia SO) | Média (gerencia containers) | Alta (gerencia apenas código) |
| **Escalabilidade** | Manual/Auto Scaling | Automática | Automática (zero → N) |
| **Preço** | Por hora de instância | Por vCPU/memória de container | Por invocação + tempo de execução |
| **Cold Start** | Não | Sim (início de container) | Sim (inicialização do runtime) |
| **Timeout** | Ilimitado | Ilimitado | 15 minutos |
| **Tamanho do Código** | Ilimitado | Até limite do container | 250 MB (compactado) |
| **Stateful** | Sim | Sim | Não (stateless) |
| **Curva de Aprendizado** | Média | Alta | Baixa |

## Casos de Uso

- **Migração de Data Center**: Uma empresa migra seus servidores físicos para EC2, mantendo os mesmos sistemas operacionais e configurações, mas ganhando elasticidade e redução de custos operacionais.

- **Microserviços com Containers**: Uma aplicação de e-commerce é dividida em microserviços (frontend, carrinho, pagamento), cada um executado como um container no ECS com Fargate, escalando independentemente conforme a demanda.

- **Processamento de Eventos**: Quando um usuário faz upload de uma foto ao S3, uma função Lambda é acionada para redimensionar a imagem e salvar as versões processadas de volta ao S3, sem necessidade de servidores em execução.

- **API Serverless**: Uma API REST é construída com API Gateway + Lambda, onde cada endpoint é uma função Lambda que processa a requisição e retorna uma resposta JSON, com custos próximos de zero durante períodos de baixa atividade.

- **Ambiente de Desenvolvimento**: Desenvolvedores usam instâncias t3.micro (Free Tier) para ambientes de desenvolvimento e teste, destruindo-as após o uso para evitar custos.

## Links Oficiais

- [AWS Compute Services](https://aws.amazon.com/compute/)
- [Amazon EC2 User Guide](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html)
- [AWS Lambda Developer Guide](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html)
- [Amazon ECS Developer Guide](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-what-is-api.html)
