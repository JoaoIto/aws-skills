# Purpose-Built Databases

## Visão Geral

A AWS oferece **bancos de dados purpose-built** (construídos para propósito específico), cada um otimizado para um tipo particular de carga de trabalho. Ao invés de usar um único banco de dados generalista para todas as necessidades, o uso de bancos de dados purpose-built permite **melhor performance**, **menor custo** e **maior eficiência** para cada caso de uso.

Esta abordagem reflete a filosofia da AWS de **"use the right tool for the right job"** — escolher o serviço de banco de dados que melhor se adequa ao padrão de acesso, tipo de dados e requisitos de performance de cada aplicação.

## Bancos de Dados Purpose-Built da AWS

| Serviço | Tipo | Caso de Uso |
|---------|------|-------------|
| **Amazon DynamoDB** | NoSQL (Key-Value, Document) | APIs, sessões, carrinhos, IoT |
| **Amazon ElastiCache** | In-Memory (Redis/Memcached) | Cache, sessões, leaderboards |
| **Amazon Neptune** | Graph | Redes sociais, recomendações, detecção de fraude |
| **Amazon Timestream** | Time Series | IoT, monitoramento, métricas |
| **Amazon QLDB** | Ledger | Finanças, supply chain, auditoria |
| **Amazon DocumentDB** | Document (MongoDB compatível) | Aplicações MongoDB |
| **Amazon OpenSearch Service** | Search | Busca, analytics, logs |
| **Amazon Keyspaces** | NoSQL (Cassandra compatível) | Apps Cassandra |
| **Amazon MemoryDB for Redis** | In-Memory (Redis) | Apps Redis com persistência |

## Amazon DynamoDB (Purpose-Built para NoSQL)

O **Amazon DynamoDB** é um **banco de dados NoSQL serverless** que oferece **latência de single-digit milissegundos** em qualquer escala. É o banco de dados purpose-built para aplicações que precisam de **alta performance**, **escalabilidade automática** e **pagamento por uso**.

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

### Características Principais

- **Serverless**: Sem servidor para provisionar ou gerenciar
- **Latência de milissegundos**: Single-digit milliseconds em qualquer escala
- **Escalabilidade automática**: De zero a qualquer escala
- **Pay-per-request**: Pague por leitura/escrita real
- **Strong/Eventual Consistency**: Escolha entre consistência forte e eventual
- **DynamoDB Streams**: Captura mudanças em tempo real
- **Global Tables**: Replicação multi-região
- **Transações ACID**: Até 25 itens por transação

### Casos de Uso

- **API de Alta Performance**: Uma API mobile usa DynamoDB para armazenar dados de sessão e preferências do usuário, com latência de single-digit milissegundos e escala automática.

- **Carrinho de Compras**: Um site de e-commerce usa DynamoDB para armazenar carrinhos de compra temporários, com TTL para expirar após 30 dias de inatividade.

- **IoT**: Sensores IoT enviam dados para DynamoDB, que armazena e permite consultas em tempo real para monitoramento.

- **Gaming**: Um jogo usa DynamoDB para armazenar pontuações, progresso e estado do jogador, com alta performance e escala global via Global Tables.

## Amazon ElastiCache (Purpose-Built para Cache)

O **Amazon ElastiCache** é um serviço de **cache em memória** totalmente gerenciado que oferece Redis ou Memcached. É o banco de dados purpose-built para melhorar a performance de aplicações adicionando uma camada de cache entre a aplicação e o banco de dados.

### Características Principais

- **Redis**: Key-value com persistência, replicação, pub/sub
- **Memcached**: Key-value sem persistência, alta performance
- **Clusterização**: Sharding automático (Redis Cluster)
- **Multi-AZ**: Alta disponibilidade com réplica
- **Auto Discovery**: Descoberta automática de nós (Memcached)

### Casos de Uso

- **Cache de Consultas**: Uma aplicação web armazena em cache os resultados de consultas frequentes ao banco de dados, reduzindo a latência de leitura de segundos para milissegundos.

- **Sessões de Usuário**: Dados de sessão de usuários são armazenados no Redis para acesso rápido e compartilhamento entre instâncias.

- **Leaderboards**: Um jogo usa Redis para armazenar rankings em tempo real, com operações de sorted set para atualização e consulta.

## Amazon Neptune (Purpose-Built para Grafos)

O **Amazon Neptune** é um serviço de banco de dados **graph** totalmente gerenciado que oferece suporte a grafos direcionados (Property Graph) e RDF (Resource Description Framework).

### Características Principais

- **Property Graph**: API compatível com Apache TinkerPop
- **RDF**: Suporte a SPARQL e Gremlin
- **Alta disponibilidade**: Replicação em 3 AZs
- **Performance**: Latência de milissegundos
- **Uso**: Redes sociais, sistemas de recomendação, detecção de fraude

### Casos de Uso

- **Rede Social**: Um aplicativo de rede social usa Neptune para armazenar relacionamentos entre usuários (amizades, seguidores) e alimentar recomendações de conexões.

- **Detecção de Fraude**: Um sistema financeiro usa Neptune para detectar padrões de fraude em redes de transações, identificando ciclos suspeitos e conexões entre contas.

- **Sistema de Recomendação**: Um serviço de streaming usa Neptune para armazenar relacionamentos entre usuários, filmes e gêneros, alimentando algoritmos de recomendação.

## Amazon Timestream (Purpose-Built para Séries Temporais)

O **Amazon Timestream** é um serviço de banco de dados **time series** totalmente gerenciado, otimizado para armazenar e analisar dados de séries temporais (IoT, aplicações, infraestrutura).

### Características Principais

- **Modelo de dados de séries temporais**: Medidas, dimensões, timestamps
- **Escalabilidade automática**: De milhares a bilhões de eventos por dia
- **Query language**: SQL compatível com análise de séries temporais
- **Mempórios de armazenamento**: Dados quentes (memória) e frios (disk)
- **Uso**: IoT, monitoramento, análise de métricas

### Casos de Uso

- **IoT**: Sensores IoT enviam dados de temperatura, umidade e pressão para Timestream, que armazena e permite consultas em tempo real para monitoramento.

- **Monitoramento de Infraestrutura**: Métricas de CPU, memória e disco de instâncias EC2 são enviadas para Timestream, permitindo análise de tendências e detecção de anomalias.

- **Aplicações de Negócio**: Métricas de negócio (vendas, conversões, engajamento) são armazenadas em Timestream para análise de tendências e previsões.

## Amazon QLDB (Purpose-Built para Ledger)

O **Amazon QLDB (Quantum Ledger Database)** é um serviço de banco de dados com **livro-razão imutável** (ledger) que oferece transparência e integridade dos dados.

### Características Principais

- **Imutabilidade**: Dados não podem ser modificados ou excluídos
- **Transparência**: Histórico completo de todas as transações
- **Criptografia**: Criptografia em repouso e em trânsito
- **SQL compatível**: Query language compatível com SQL
- **Uso**: Finanças, supply chain, governança

### Casos de Uso

- **Finanças**: Um sistema bancário usa QLDB para registrar transações financeiras com integridade imutável e auditoria completa.

- **Supply Chain**: Uma empresa usa QLDB para rastrear a jornada de produtos desde a fabricação até o consumidor final, com histórico imutável de todas as transferências.

- **Governança**: Um órgão público usa QLDB para registrar contratos, licenças e transações governamentais com transparência e integridade.

## Amazon DocumentDB (Purpose-Built para MongoDB)

O **Amazon DocumentDB** é um serviço de banco de dados **document** compatível com MongoDB, totalmente gerenciado. Ele oferece compatibilidade com APIs MongoDB, permitindo que aplicações existentes se conectem sem alterações.

### Características Principais

- **Compatível com MongoDB**: APIs, drivers e ferramentas MongoDB
- **Armazenamento distribuído**: Dados replicados em 3 AZs
- **Performance**: Latência de milissegundos
- **Escalabilidade**: Escala automática de armazenamento
- **Segurança**: Criptografia em repouso e em trânsito

### Casos de Uso

- **Migração de MongoDB**: Uma empresa migra seu cluster MongoDB on-premises para o DocumentDB, mantendo a mesma API e ferramentas, mas com o plano de controle gerenciado pela AWS.

- **Aplicações MongoDB**: Aplicações existentes que usam MongoDB podem ser facilmente migradas para o DocumentDB sem alterações no código.

## Amazon OpenSearch Service (Purpose-Built para Busca)

O **Amazon OpenSearch Service** é um serviço gerenciado que oferece **OpenSearch** (fork do Elasticsearch) para busca, analytics e visualização de dados.

### Características Principais

- **Busca full-text**: Indexação e busca de texto completo
- **Analytics**: Análise de logs, métricas e dados estruturados
- **Visualização**: Kibana integrado para dashboards
- **Escalabilidade**: Escala automática de armazenamento e compute
- **Segurança**: Criptografia, autenticação e autorização

### Casos de Uso

- **Busca em Aplicação**: Uma aplicação web usa OpenSearch para fornecer busca full-text em documentos, produtos ou artigos.

- **Análise de Logs**: Logs de aplicação e infraestrutura são enviados para OpenSearch, permitindo análise em tempo real e visualização via Kibana.

- **Monitoramento**: Métricas de infraestrutura são indexadas no OpenSearch para análise de tendências e detecção de anomalias.

## Comparação: Banco de Dados Generalista vs. Purpose-Built

| Critério | Banco de Dados Generalista (RDS) | Purpose-Built |
|----------|----------------------------------|---------------|
| **Performance** | Boa para cargas gerais | Excelente para caso específico |
| **Custo** | Pode ser mais alto | Mais baixo para o caso de uso |
| **Complexidade** | Baixa (familiar) | Pode ser mais alta (novo serviço) |
| **Escalabilidade** | Limitada (vertical) | Alta (horizontal) |
| **Latência** | ms | sub-ms (alguns) |
| **Caso Ideal** | Apps tradicionais | Apps modernas, casos específicos |

## Framework de Escolha

### 1. Qual é o tipo de dados?

| Tipo de Dados | Serviço Recomendado |
|---------------|---------------------|
| **Tabelas relacionais** | Amazon RDS, Aurora |
| **Documentos JSON** | DynamoDB, DocumentDB |
| **Grafos** | Neptune |
| **Séries temporais** | Timestream |
| **Ledger imutável** | QLDB |
| **Cache em memória** | ElastiCache |
| **Busca full-text** | OpenSearch Service |

### 2. Qual é o padrão de acesso?

| Padrão | Serviço Recomendado |
|--------|---------------------|
| **Leitura/escrita por chave** | DynamoDB |
| **Consultas complexas** | RDS, Aurora |
| **Navegação de grafos** | Neptune |
| **Inserção de séries temporais** | Timestream |
| **Cache de consultas** | ElastiCache |
| **Busca full-text** | OpenSearch Service |

### 3. Qual é a escala esperada?

| Escala | Serviço Recomendado |
|--------|---------------------|
| **Até 100K req/s** | RDS, DynamoDB |
| **100K-1M req/s** | DynamoDB, Aurora |
| **1M+ req/s** | DynamoDB, ElastiCache |
| **Bilhões de eventos/dia** | Timestream |

## Links Oficiais

- [AWS Database Services](https://aws.amazon.com/database/)
- [Amazon DynamoDB Developer Guide](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Welcome.html)
- [Amazon Neptune](https://docs.aws.amazon.com/neptune/latest/userguide/what-is.html)
- [Amazon Timestream](https://docs.aws.amazon.com/timestream/latest/ug/what-is-timestream.html)
- [Amazon QLDB](https://docs.aws.amazon.com/qldb/latest/developerguide/what-is.html)
- [Amazon ElastiCache](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/Welcome.html)
