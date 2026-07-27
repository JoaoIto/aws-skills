# Alternate Serverless Employee Directory Application Architecture

## Visão Geral

Esta arquitetura **serverless** é uma alternativa à arquitetura tradicional da Employee Directory Application (baseada em EC2). Em vez de gerenciar servidores, a aplicação usa **AWS Lambda**, **Amazon API Gateway**, **Amazon DynamoDB** e **Amazon S3** para fornecer uma solução **sem servidor**, com **escalabilidade automática**, **custo por uso** e **alta disponibilidade** inerentes.

A migração para serverless elimina a necessidade de gerenciar instâncias EC2, Auto Scaling Groups e Load Balancers, reduzindo a complexidade operacional e os custos durante períodos de baixa atividade.

## Arquitetura Serverless

```
┌─────────────────────────────────────────────────────────────────┐
│                    Cliente (Web/Mobile)                         │
└──────────────────────────┬──────────────────────────────────────┘
                           │ HTTPS
┌──────────────────────────▼──────────────────────────────────────┐
│                    Amazon CloudFront (CDN)                       │
└──────────────────────────┬──────────────────────────────────────┘
                           │
┌──────────────────────────▼──────────────────────────────────────┐
│                    Amazon S3 (Static Assets)                   │
│  (index.html, CSS, JS, imagens)                                 │
└─────────────────────────────────────────────────────────────────┘
                           │
┌──────────────────────────▼──────────────────────────────────────┐
│                    Amazon API Gateway                          │
│  (Autenticação via Cognito)                                    │
└──────────────────────────┬──────────────────────────────────────┘
                           │
          ┌────────────────┼────────────────┐
          ▼                ▼                ▼
┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐
│  Lambda         │ │  Lambda         │ │  Lambda         │
│  (List         │ │  (Get/Create    │ │  (Update/      │
│  Employees)    │ │  Employee)      │ │  Delete)       │
└─────────────────┘ └─────────────────┘ └─────────────────┘
          │                │                │
          ▼                ▼                ▼
┌───────────────────────────────────────────────────────────────┐
│                    Amazon DynamoDB                            │
│  Table: EmployeeDirectory                                      │
│  (employee_id PK, department SK)                               │
└───────────────────────────────────────────────────────────────┘
                           │
┌──────────────────────────▼──────────────────────────────────────┐
│                    DynamoDB Streams                             │
└──────────────────────────┬──────────────────────────────────────┘
                           │
┌──────────────────────────▼──────────────────────────────────────┐
│                    Lambda (Trigger)                             │
│  (Processa mudanças: notificações, auditoria)                  │
└─────────────────────────────────────────────────────────────────┘
```

## Componentes Principais

| Componente | Serviço | Função |
|-----------|---------|--------|
| **Frontend** | S3 + CloudFront | Website estático com CDN |
| **API** | API Gateway | Gerenciamento de endpoints REST |
| **Autenticação** | Cognito | Autenticação de usuários |
| **Backend** | Lambda | Processamento de requisições |
| **Banco de Dados** | DynamoDB | Armazenamento de dados |
| **Eventos** | DynamoDB Streams | Processamento de mudanças |
| **Monitoramento** | CloudWatch | Métricas, logs e alarmes |
| **Auditoria** | CloudTrail | Rastreamento de chamadas de API |

## Como Funciona

### 1. Frontend (S3 + CloudFront)

O frontend da aplicação (HTML, CSS, JavaScript) é hospedado no **Amazon S3** como um website estático. O **Amazon CloudFront** (CDN) acelera o acesso global, servindo os arquivos do edge location mais próximo do usuário.

```javascript
// Exemplo de chamada API do frontend
const response = await fetch('https://api-id.execute-api.sa-east-1.amazonaws.com/prod/employees', {
    method: 'GET',
    headers: {
        'Authorization': `Bearer ${idToken}`,
        'Content-Type': 'application/json'
    }
});
const employees = await response.json();
```

### 2. API Gateway

O **Amazon API Gateway** expõe endpoints REST para a aplicação:

| Endpoint | Método | Função Lambda | Descrição |
|----------|--------|---------------|-----------|
| `/employees` | GET | ListEmployees | Lista todos os funcionários |
| `/employees` | POST | CreateEmployee | Cria um novo funcionário |
| `/employees/{id}` | GET | GetEmployee | Obtém um funcionário específico |
| `/employees/{id}` | PUT | UpdateEmployee | Atualiza um funcionário |
| `/employees/{id}` | DELETE | DeleteEmployee | Remove um funcionário |

### 3. Lambda Functions

Cada endpoint é atendido por uma **função Lambda** que processa a requisição e interage com o DynamoDB:

```python
import json
import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('EmployeeDirectory')

def lambda_handler(event, context):
    # Listar todos os funcionários
    response = table.scan()
    employees = response['Items']
    
    return {
        'statusCode': 200,
        'headers': {
            'Access-Control-Allow-Origin': '*'
        },
        'body': json.dumps(employees)
    }
```

### 4. DynamoDB

O **Amazon DynamoDB** armazena os dados dos funcionários com alta performance e escalabilidade:

| Atributo | Tipo | Descrição |
|----------|------|-----------|
| `employee_id` | String (PK) | ID único do funcionário |
| `department` | String (SK) | Departamento |
| `name` | String | Nome do funcionário |
| `email` | String | Email |
| `hire_date` | String | Data de contratação |
| `salary` | Number | Salário |

### 5. DynamoDB Streams + Lambda Trigger

O **DynamoDB Streams** captura mudanças na tabela e aciona uma função Lambda para processamento adicional:

```python
def lambda_handler(event, context):
    for record in event['Records']:
        if record['eventName'] == 'INSERT':
            new_image = record['dynamodb']['NewImage']
            employee_id = new_image['employee_id']['S']
            # Enviar notificação, atualizar índice, etc.
            print(f"Novo funcionário: {employee_id}")
```

## Conceitos Chave

- **Serverless**: Nenhum servidor para provisionar ou gerenciar. A AWS gerencia a infraestrutura de compute, armazenamento e rede.

- **Pay-per-Use**: Você paga apenas pelo tempo de execução das funções Lambda, pelo número de invocações da API Gateway e pelo armazenamento no DynamoDB. Custo próximo de zero durante períodos de baixa atividade.

- **Escalabilidade Automática**: A aplicação escala automaticamente de zero até milhares de requisições simultâneas. Nenhuma configuração de Auto Scaling ou Load Balancer é necessária.

- **Alta Disponibilidade**: A AWS replica automaticamente os componentes em múltiplas zonas de disponibilidade. A aplicação é inerentemente resiliente a falhas.

- **Cold Start**: Quando uma função Lambda é invocada após um período de inatividade, pode haver latência adicional (cold start). **Provisioned Concurrency** pode ser usada para mitigar isso.

- **Stateless Functions**: Funções Lambda são stateless — não preservam dados entre invocações. Dados são armazenados no DynamoDB.

- **Event-Driven**: A aplicação responde a eventos (requisições HTTP, mudanças no DynamoDB) de forma reativa.

## Comparação: Arquitetura Tradicional vs. Serverless

| Critério | Tradicional (EC2) | Serverless |
|----------|-------------------|------------|
| **Servidores** | Gerenciados pelo cliente | Gerenciados pela AWS |
| **Escalabilidade** | Auto Scaling Groups | Automática (zero → N) |
| **Custo (idle)** | Alto (instância parada) | Zero |
| **Custo (ativo)** | Por hora de instância | Por invocação + tempo |
| **Complexidade** | Alta (ASG, ALB, SG) | Baixa (Lambda + API GW) |
| **Cold Start** | Não | Sim (mitigável) |
| **Timeout** | Ilimitado | 15 minutos |
| **Controle do SO** | Total | Nenhum |
| **Alta Disponibilidade** | Configurada manualmente | Automática |

## Vantagens da Arquitetura Serverless

| Vantagem | Descrição |
|----------|-----------|
| **Sem gestão de servidores** | A AWS gerencia provisionamento, patches, escalabilidade |
| **Custo por uso** | Pague apenas pelo tempo de execução e número de invocações |
| **Escalabilidade automática** | De zero a milhares de requisições sem intervenção manual |
| **Alta disponibilidade** | Replicação automática em múltiplas zonas de disponibilidade |
| **Time-to-market** | Foco no código, não na infraestrutura |
| **Resiliência** | Recuperação automática de falhas |
| **Integração AWS** | Nativa e profunda com serviços da AWS |

## Considerações e Limitações

| Consideração | Descrição |
|-------------|-----------|
| **Cold Start** | Latência adicional na primeira invocação após período de inatividade |
| **Vendor Lock-in** | Forte dependência dos serviços específicos da AWS |
| **Debugging** | Mais complexo de debugar devido à natureza distribuída |
| **Timeout** | Limite de 15 minutos para funções Lambda |
| **Stateful** | Funções são stateless — dados externos são necessários |
| **Observabilidade** | Requer ferramentas específicas (CloudWatch, X-Ray) |
| **Tamanho do Código** | Limite de 250 MB (compactado) para funções Lambda |

## Casos de Uso

- **API de Alta Performance**: Uma API mobile usa Lambda + API Gateway + DynamoDB para servir milhares de requisições por segundo com latência de single-digit milissegundos.

- **Processamento de Eventos**: Quando um funcionário é inserido no DynamoDB, o DynamoDB Streams aciona uma função Lambda que envia uma notificação de boas-vindas via SNS.

- **Website Estático**: O frontend da aplicação é hospedado no S3 com CloudFront, oferecendo acesso global com baixa latência e custos próximos de zero.

- **Autenticação de Usuários**: O Amazon Cognito gerencia a autenticação de usuários, integrando-se com o API Gateway para proteger os endpoints.

- **Monitoramento e Alertas**: O CloudWatch coleta métricas de invocação do Lambda e configura alarmes para detectar erros ou latência anormal.

## Links Oficiais

- [AWS Serverless](https://aws.amazon.com/serverless/)
- [AWS Lambda Developer Guide](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html)
- [Amazon API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html)
- [Amazon DynamoDB Developer Guide](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Welcome.html)
- [Amazon Cognito](https://docs.aws.amazon.com/cognito/latest/developerguide/what-is-amazon-cognito.html)
- [Serverless Application Model (SAM)](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html)
