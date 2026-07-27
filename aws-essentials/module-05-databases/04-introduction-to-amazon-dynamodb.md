# Introduction to Amazon DynamoDB

## Visão Geral

O **Amazon DynamoDB** é um **banco de dados NoSQL key-value e document** **serverless** totalmente gerenciado. Ele oferece **latência de single-digit milissegundos** em qualquer escala, **alta disponibilidade** e **durabilidade** de 99,999% (3 nines), sem que você precise provisionar ou gerenciar servidores.

O DynamoDB é ideal para aplicações que precisam de **alta performance**, **escalabilidade automática** e **pagamento por uso** (pay-per-request), como APIs, sessões de usuário, carrinhos de compra, jogos e IoT.

## Arquitetura do DynamoDB

```
┌─────────────────────────────────────────────────────────────┐
│                    Cliente (App/API)                         │
└──────────────────────────┬────────────────────────────────────┘
                           │ PutItem / GetItem
┌──────────────────────────▼────────────────────────────────────┐
│                    DynamoDB API                               │
│  (Latência < 10ms, escala automática)                        │
└──────────────────────────┬────────────────────────────────────┘
                           │
         ┌─────────────────┼─────────────────┐
         ▼                 ▼                 ▼
  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐
  │   AZ-a      │  │   AZ-b      │  │   AZ-c      │
  │  Partition  │  │  Partition  │  │  Partition  │
  │  (dados)    │  │  (dados)    │  │  (dados)    │
  └─────────────┘  └─────────────┘  └─────────────┘
```

## Conceitos Chave

- **Tabela (Table)**: A unidade principal de armazenamento no DynamoDB. Uma tabela contém **itens** (registros) e é identificada por um **nome único**.

- **Item (Item)**: Um registro individual na tabela, equivalente a uma linha em um banco relacional. Cada item pode ter **atributos** (colunas) diferentes — o DynamoDB é **schema-less** no nível de item.

- **Atributo (Attribute)**: Uma propriedade de um item (equivalente a uma coluna). Atributos podem ser de tipos: string, número, binário, boolean, lista, mapa, conjunto (set).

- **Chave Primária (Primary Key)**: Identifica exclusivamente cada item na tabela. Dois tipos:
  - **Partição (Partition Key)**: Uma única chave (ex: `user_id`)
  - **Partição + Sort Key**: Combinação de partition key e sort key (ex: `user_id` + `timestamp`)

- **Partition Key**: Determina em qual **partição** (shard) o item é armazenado. O DynamoDB usa um hash da partition key para distribuir dados. Escolher uma partition key com **alta cardinalidade** é essencial para evitar "hot partitions".

- **Capacity Units**:
  - **Read Capacity Unit (RCU)**: Uma leitura consistente por segundo para até 4 KB
  - **Write Capacity Unit (WCU)**: Uma escrita por segundo para até 1 KB

- **Modos de Capacidade**:
  - **On-Demand**: Pague por leitura/escrita real. Ideal para cargas imprevisíveis.
  - **Provisioned**: Provisione RCUs/WCUs com antecedência. Ideal para cargas previsíveis.
  - **Auto Scaling**: Ajusta automaticamente a capacidade provisionada.

- **Consistency (Consistência)**:
  - **Eventual Consistency** (padrão): Leitura pode não refletir a escrita mais recente. Latência mais baixa.
  - **Strong Consistency**: Leitura sempre reflete a escrita mais recente. Latência ligeiramente maior.

- **Índices Secundários (Secondary Indexes)**:
  - **Global Secondary Index (GSI)**: Partition key e sort key diferentes da tabela. Permite consultas alternativas.
  - **Local Secondary Index (LSI)**: Mesma partition key, sort key diferente. Permite consultas alternativas na mesma partition.

- **DynamoDB Streams**: Captura mudanças (insert, update, delete) na tabela em tempo real. Útil para:
  - Replicação multi-região (Global Tables)
  - Processamento de eventos (Lambda)
  - Auditoria

- **Global Tables**: Replicação multi-região e multi-conta para alta disponibilidade global. As tabelas em diferentes regiões são replicadas automaticamente.

- **Transações**: O DynamoDB suporta transações ACID (até 25 itens ou 4 MB por transação). Útil para operações que precisam de consistência forte.

- **Time to Live (TTL)**: Atributo que define quando um item deve ser excluído automaticamente. Útil para sessões, caches, dados temporários.

- **Backup e Recuperação**:
  - **On-Demand Backup**: Backup manual sob demanda
  - **Point-in-Time Recovery (PITR)**: Recuperação para qualquer ponto nas últimas 24 horas

## Exemplo de Modelagem

### Tabela: `EmployeeDirectory`

| Atributo | Tipo | Descrição |
|----------|------|-----------|
| `employee_id` | String (PK) | ID único do funcionário |
| `name` | String | Nome do funcionário |
| `department` | String | Departamento |
| `email` | String | Email |
| `hire_date` | String | Data de contratação |
| `salary` | Number | Salário |

### Operações Comuns

```python
import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('EmployeeDirectory')

# Inserir um item
table.put_item(
    Item={
        'employee_id': 'emp-001',
        'name': 'João Silva',
        'department': 'Engineering',
        'email': 'joao@company.com',
        'hire_date': '2024-01-15',
        'salary': 8500
    }
)

# Ler um item
response = table.get_item(
    Key={'employee_id': 'emp-001'}
)
item = response['Item']

# Consultar por partition key
response = table.query(
    KeyConditionExpression=boto3.dynamodb.conditions.Key('employee_id').eq('emp-001')
)

# Atualizar um item
table.update_item(
    Key={'employee_id': 'emp-001'},
    UpdateExpression='SET salary = :new_salary',
    ExpressionAttributeValues={':new_salary': 9000}
)

# Deletar um item
table.delete_item(Key={'employee_id': 'emp-001'})
```

## Modelos de Preço

| Componente | Unidade | Free Tier |
|------------|---------|-----------|
| **On-Demand** | Por 1M de leituras/escritas | 25 GB/mês de armazenamento |
| **Provisioned** | Por RCU/WCU por hora | 25 GB/mês de armazenamento |
| **Armazenamento** | Por GB-mês | 25 GB/mês |
| **Backup** | Por GB-mês | — |
| **Streams** | Por 100.000 leituras | — |

## Casos de Uso

- **API de Alta Performance**: Uma API mobile usa DynamoDB para armazenar dados de sessão e preferências do usuário, com latência de single-digit milissegundos e escala automática.

- **Carrinho de Compras**: Um site de e-commerce usa DynamoDB para armazenar carrinhos de compra temporários, com TTL para expirar após 30 dias de inatividade.

- **IoT**: Sensores IoT enviam dados para DynamoDB, que armazena e permite consultas em tempo real para monitoramento.

- **Gaming**: Um jogo usa DynamoDB para armazenar pontuações, progresso e estado do jogador, com alta performance e escala global via Global Tables.

- **Processamento de Eventos**: DynamoDB Streams aciona funções Lambda para processar mudanças em tempo real (ex: atualizar índice de busa ao inserir novo item).

## Links Oficiais

- [Amazon DynamoDB Developer Guide](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Welcome.html)
- [DynamoDB Best Practices](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/best-practices.html)
