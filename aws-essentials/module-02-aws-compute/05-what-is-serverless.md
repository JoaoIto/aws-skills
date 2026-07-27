# What is Serverless?

## Visão Geral

**Serverless** (sem servidor) é um modelo de computação em nuvem onde o provedor de serviços gerencia a **provisionamento, dimensionamento e manutenção da infraestrutura de servidores**. Apesar do nome, servidores ainda são usados — eles são apenas **abstratos** para o desenvolvedor. O foco está em **executar código sem se preocupar com a infraestrutura subjacente**.

O modelo serverless é baseado em dois pilares principais:

1. **Function as a Service (FaaS)**: Execução de código em resposta a eventos, com cobrança por tempo de execução
2. **Backend as a Service (BaaS)**: Serviços gerenciados que substituem componentes de backend tradicionais (banco de dados, autenticação, armazenamento)

```
┌─────────────────────────────────────────────────────────┐
│                    Aplicação Serverless                  │
│  ┌────────────────────────────────────────────────────┐  │
│  │  Frontend (S3 + CloudFront)                        │  │
│  └────────────────────────────────────────────────────┘  │
│  ┌────────────────────────────────────────────────────┐  │
│  │  API Gateway → Lambda Functions                    │  │
│  └────────────────────────────────────────────────────┘  │
│  ┌────────────────────────────────────────────────────┐  │
│  │  DynamoDB / S3 / SNS / SQS                         │  │
│  └────────────────────────────────────────────────────┘  │
│  ┌────────────────────────────────────────────────────┐  │
│  │  CloudWatch (monitoramento)                        │  │
│  └────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
                    ↑
            Infraestrutura gerenciada pela AWS
```

## Conceitos Chave

- **Function as a Service (FaaS)**: No modelo FaaS, você escreve **funções individuais** que são executadas em resposta a eventos. A AWS gerencia a provisionamento, escalabilidade e falência dos servidores. Você paga apenas pelo **tempo de execução** (em milissegundos) e pelo **número de invocações**.

- **Backend as a Service (BaaS)**: Serviços gerenciados que fornecem funcionalidades de backend sem que você precise gerenciar servidores. Exemplos na AWS: DynamoDB (banco de dados), S3 (armazenamento), Cognito (autenticação), SNS/SQS (mensagens).

- **Escalabilidade Automática**: No modelo serverless, a escalabilidade é **automática e ilimitada** (dentro das quotas da conta). Quando uma função Lambda é acionada, a AWS provisiona automaticamente o ambiente de execução. Quando não há mais invocações, os recursos são liberados.

- **Pay-per-Execution**: Você paga apenas quando seu código está em execução. Não há cobrança para instâncias paradas ou em espera. Isso resulta em **custos próximos de zero** para aplicações com baixa ou variável demanda.

- **Event-Driven Architecture**: As funções serverless são acionadas por **eventos** — como uploads para S3, mensagens em filas SQS, requisições HTTP via API Gateway, ou eventos programados via CloudWatch Events.

- **Stateless Functions**: Funções FaaS são **stateless** — não preservam dados entre invocações. Dados devem ser armazenados em serviços externos (DynamoDB, S3, RDS, etc.). O diretório `/tmp` (até 10 GB) pode ser usado para armazenamento temporário durante a execução.

- **Cold Start**: Quando uma função é invocada após um período de inatividade, a AWS precisa inicializar o runtime, carregar o código e executar a inicialização. Isso pode levar de 100ms a vários segundos. **Provisioned Concurrency** mantém ambientes pré-inicializados para eliminar cold starts.

- **Durability and Fault Tolerance**: O modelo serverless é **inherentemente resiliente**. A AWS replica automaticamente as funções em múltiplas zonas de disponibilidade. Se uma zona falhar, as invocações são redirecionadas para outras zonas.

## Serviços Serverless da AWS

| Serviço | Categoria | Uso |
|---------|-----------|-----|
| **AWS Lambda** | Compute (FaaS) | Execução de código por evento |
| **Amazon API Gateway** | API Management | Criação e gerenciamento de APIs REST/WebSocket |
| **Amazon DynamoDB** | Database | Banco de dados NoSQL serverless |
| **Amazon S3** | Storage | Armazenamento de objetos |
| **Amazon SNS** | Messaging | Publicação/subscrição de notificações |
| **Amazon SQS** | Messaging | Filas de mensagens |
| **AWS Step Functions** | Orchestration | Orquestração de workflows serverless |
| **Amazon EventBridge** | Events | Roteamento de eventos |
| **AWS Cognito** | Identity | Autenticação e autorização de usuários |
| **Amazon Aurora Serverless** | Database | Banco de dados relacional serverless |
| **AWS AppSync** | API | APIs GraphQL para aplicações |

## Arquitetura Serverless Típica

```
┌─────────────────────────────────────────────────────────────┐
│                    Cliente (Web/Mobile)                     │
└──────────────────────────┬────────────────────────────────────┘
                           │ HTTPS
┌──────────────────────────▼────────────────────────────────────┐
│                    Amazon CloudFront (CDN)                   │
└──────────────────────────┬────────────────────────────────────┘
                           │
┌──────────────────────────▼────────────────────────────────────┐
│                    Amazon S3 (Static Assets)                 │
└──────────────────────────────────────────────────────────────┘
                           │
┌──────────────────────────▼────────────────────────────────────┐
│                    Amazon API Gateway                        │
│  (Autenticação via Cognito)                                  │
└──────────────────────────┬────────────────────────────────────┘
                           │
          ┌────────────────┼────────────────┐
          ▼                ▼                ▼
┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐
│  Lambda         │ │  Lambda         │ │  Lambda         │
│  (Processa      │ │  (Valida       │ │  (Notifica     │
│  Pedido)        │ │  Dados)        │ │  Resultado)    │
└─────────────────┘ └─────────────────┘ └─────────────────┘
          │                │                │
          ▼                ▼                ▼
┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐
│  DynamoDB       │ │  S3             │ │  SNS            │
│  (Dados)        │ │  (Arquivos)    │ │  (Notificações) │
└─────────────────┘ └─────────────────┘ └─────────────────┘
```

## Vantagens do Serverless

| Vantagem | Descrição |
|----------|-----------|
| **Sem gestão de servidores** | A AWS gerencia provisionamento, patches, escalabilidade e falências |
| **Custo por uso** | Pague apenas pelo tempo de execução e número de invocações |
| **Escalabilidade automática** | De zero a milhares de invocações sem intervenção manual |
| **Alta disponibilidade** | Replicação automática em múltiplas zonas de disponibilidade |
| **Time-to-market** | Foco no código, não na infraestrutura |
| **Resiliência** | Recuperação automática de falhas |

## Desvantagens e Considerações

| Consideração | Descrição |
|-------------|-----------|
| **Cold Start** | Latência adicional na primeira invocação após período de inatividade |
| **Vendor Lock-in** | Forte dependência dos serviços específicos da AWS |
| **Debugging** | Mais complexo de debugar devido à natureza distribuída |
| **Timeout** | Limite de 15 minutos para funções Lambda |
| **Stateful** | Funções são stateless — dados externos são necessários |
| **Observabilidade** | Requer ferramentas específicas (CloudWatch, X-Ray) |

## Comparação: Serverless vs. Traditional

| Critério | Serverless | Traditional (EC2) |
|----------|-----------|-------------------|
| **Provisionamento** | Automático | Manual |
| **Escalabilidade** | Automática | Manual (Auto Scaling) |
| **Custo (baixa demanda)** | Muito baixo | Alto (instância parada) |
| **Custo (alta demanda)** | Pode ser mais alto | Mais previsível |
| **Complexidade operacional** | Baixa | Alta |
| **Cold Start** | Sim | Não |
| **Controle do SO** | Nenhum | Total |
| **Timeout** | 15 minutos | Ilimitado |

## Casos de Uso

- **Processamento de Imagens**: Quando um usuário faz upload de uma foto ao S3, uma função Lambda redimensiona a imagem para thumbnails e salva as versões processadas de volta ao S3.

- **APIs Serverless**: Uma API REST é construída com API Gateway + Lambda, onde cada endpoint é uma função Lambda que processa a requisição e retorna uma resposta JSON.

- **Automação de Segurança**: Uma função Lambda é acionada por alertas do GuardDuty para isolar automaticamente uma instância EC2 comprometida, revogando seus Security Groups.

- **Processamento de Logs**: Logs do CloudWatch são processados por uma função Lambda que extrai métricas, detecta padrões anômalos e envia alertas via SNS.

- **Webhooks e Integrações**: Uma função Lambda recebe webhooks de serviços de terceiros (como Stripe, GitHub) via API Gateway, validando e processando os eventos recebidos.

## Links Oficiais

- [AWS Serverless](https://aws.amazon.com/serverless/)
- [AWS Lambda Developer Guide](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html)
- [Serverless Application Model (SAM)](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html)
- [AWS Well-Architected - Serverless](https://docs.aws.amazon.com/wellarchitected/latest/serverless-lens/welcome.html)
