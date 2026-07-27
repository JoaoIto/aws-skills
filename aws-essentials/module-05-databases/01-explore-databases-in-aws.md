# Explore Databases in AWS

## Visão Geral

A AWS oferece uma ampla gama de **serviços de banco de dados**, cada um otimizado para diferentes tipos de dados, padrões de acesso e requisitos de performance. Esses serviços se dividem em duas categorias principais: **bancos de dados relacionais** (SQL) e **bancos de dados não relacionais** (NoSQL), além de **bancos de dados purpose-built** para casos de uso específicos.

Compreender as diferenças entre esses serviços é essencial para escolher a solução certa para cada carga de trabalho, considerando fatores como **modelo de dados**, **escalabilidade**, **performance**, **durabilidade** e **custo**.

## Categorias de Banco de Dados

| Categoria | Serviço | Tipo | Modelo de Dados |
|-----------|---------|------|-----------------|
| **Relacional** | Amazon RDS | SQL | Tabelas com esquema fixo |
| **Relacional** | Amazon Aurora | SQL | Tabelas com esquema fixo (compatível MySQL/PostgreSQL) |
| **NoSQL - Key-Value** | Amazon DynamoDB | NoSQL | Chave-valor |
| **NoSQL - Document** | Amazon DocumentDB | NoSQL | Documentos JSON |
| **NoSQL - Graph** | Amazon Neptune | NoSQL | Grafos |
| **NoSQL - Time Series** | Amazon Timestream | NoSQL | Séries temporais |
| **NoSQL - Ledger** | Amazon QLDB | NoSQL | Ledger imutável |
| **In-Memory** | Amazon ElastiCache | Cache | Key-value (Redis/Memcached) |
| **Search** | Amazon OpenSearch Service | Search | Documentos JSON |

## Amazon RDS (Relational Database Service)

O **Amazon RDS** é um serviço de banco de dados relacional **gerenciado** que simplifica a configuração, operação e escala de bancos de dados na nuvem. O RDS suporta múltiplos motores: **MySQL**, **PostgreSQL**, **MariaDB**, **Oracle**, **SQL Server** e **Amazon Aurora**.

### Características Principais

- **Totalmente gerenciado**: A AWS gerencia patches, backup automatizado, replicação e recuperação
- **Multi-AZ**: Alta disponibilidade com réplica em espera em outra AZ
- **Read Replicas**: Escala horizontal de leituras
- **Backup automatizado**: Point-in-time recovery (1-35 dias)
- **Parameter Groups**: Configurações do mecanismo de banco de dados
- **Security Groups e IAM**: Controle de acesso via rede e API

### Motores Suportados

| Motor | Compatibilidade | Uso Típico |
|-------|-----------------|------------|
| **Amazon Aurora** | MySQL 5.7, PostgreSQL 13+ | Aplicações modernas, alta performance |
| **MySQL** | MySQL padrão | Aplicações web, desenvolvimento |
| **PostgreSQL** | PostgreSQL padrão | Aplicações complexas, extensões |
| **MariaDB** | MariaDB padrão | Substituto do MySQL |
| **Oracle** | Oracle Enterprise | Aplicações corporativas |
| **SQL Server** | SQL Server padrão | Aplicações .NET, Windows |

## Amazon DynamoDB (NoSQL)

O **Amazon DynamoDB** é um **banco de dados NoSQL key-value e document** **serverless** totalmente gerenciado. Ele oferece **latência de single-digit milissegundos** em qualquer escala, **alta disponibilidade** e **durabilidade** de 99,999% (3 nines).

### Características Principais

- **Serverless**: Sem servidor para provisionar ou gerenciar
- **Latência de milissegundos**: Single-digit milliseconds em qualquer escala
- **Escalabilidade automática**: De zero a qualquer escala
- **Pay-per-request**: Pague por leitura/escrita real
- **Strong/Eventual Consistency**: Escolha entre consistência forte e eventual
- **DynamoDB Streams**: Captura mudanças em tempo real
- **Global Tables**: Replicação multi-região
- **Transações ACID**: Até 25 itens por transação

### Componentes Principais

| Componente | Descrição |
|-----------|-----------|
| **Table** | Unidade principal de armazenamento |
| **Item** | Registro individual (equivalente a uma linha) |
| **Attribute** | Propriedade de um item (equivalente a uma coluna) |
| **Partition Key** | Determina em qual partição o item é armazenado |
| **Sort Key** | Permite ordenação dentro de uma partição |
| **RCU/WCU** | Unidades de capacidade de leitura/escrita |
| **GSI/LSI** | Índices secundários globais/local |

## Amazon Aurora

O **Amazon Aurora** é um motor de banco de dados relacional **cloud-native** compatível com MySQL e PostgreSQL, mas com arquitetura otimizada para a nuvem.

### Características Principais

- **Armazenamento auto-redundante**: Dados replicados em 3 AZs automaticamente
- **Performance**: Até 5x mais rápido que MySQL padrão, 3x mais rápido que PostgreSQL
- **Escalabilidade**: Armazenamento de 10 GB a 128 TB, crescimento automático
- **Aurora Serverless**: Escalabilidade automática de zero
- **Aurora Global Database**: Replicação multi-região para DR

## Amazon ElastiCache

O **Amazon ElastiCache** é um serviço de **cache em memória** totalmente gerenciado que oferece Redis ou Memcached. É usado para melhorar a performance de aplicações adicionando uma camada de cache entre a aplicação e o banco de dados.

### Características Principais

- **Redis**: Key-value com persistência, replicação, pub/sub
- **Memcached**: Key-value sem persistência, alta performance
- **Clusterização**: Sharding automático (Redis Cluster)
- **Multi-AZ**: Alta disponibilidade com réplica
- **Auto Discovery**: Descoberta automática de nós (Memcached)

## Amazon DocumentDB

O **Amazon DocumentDB** é um serviço de banco de dados **document** compatível com MongoDB, totalmente gerenciado. Ele oferece compatibilidade com APIs MongoDB, permitindo que aplicações existentes se conectem sem alterações.

### Características Principais

- **Compatível com MongoDB**: APIs, drivers e ferramentas MongoDB
- **Armazenamento distribuído**: Dados replicados em 3 AZs
- **Performance**: Latência de milissegundos
- **Escalabilidade**: Escala automática de armazenamento
- **Segurança**: Criptografia em repouso e em trânsito

## Amazon Neptune

O **Amazon Neptune** é um serviço de banco de dados **graph** totalmente gerenciado que oferece suporte a grafos direcionados (Property Graph) e RDF (Resource Description Framework).

### Características Principais

- **Property Graph**: API compatível com Apache TinkerPop
- **RDF**: Suporte a SPARQL e Gremlin
- **Alta disponibilidade**: Replicação em 3 AZs
- **Performance**: Latência de milissegundos
- **Uso**: Redes sociais, sistemas de recomendação, detecção de fraude

## Amazon Timestream

O **Amazon Timestream** é um serviço de banco de dados **time series** totalmente gerenciado, otimizado para armazenar e analisar dados de séries temporais (IoT, aplicações, infraestrutura).

### Características Principais

- **Modelo de dados de séries temporais**: Medidas, dimensões, timestamps
- **Escalabilidade automática**: De milhares a bilhões de eventos por dia
- **Query language**: SQL compatível com análise de séries temporais
- **Mempórios de armazenamento**: Dados quentes (memória) e frios (disk)
- **Uso**: IoT, monitoramento, análise de métricas

## Amazon QLDB

O **Amazon QLDB (Quantum Ledger Database)** é um serviço de banco de dados com **livro-razão imutável** (ledger) que oferece transparência e integridade dos dados.

### Características Principais

- **Imutabilidade**: Dados não podem ser modificados ou excluídos
- **Transparência**: Histórico completo de todas as transações
- **Criptografia**: Criptografia em repouso e em trânsito
- **SQL compatível**: Query language compatível com SQL
- **Uso**: Finanças, supply chain, governança

## Comparação dos Serviços

| Critério | RDS | DynamoDB | Aurora | ElastiCache | DocumentDB | Neptune |
|----------|-----|----------|--------|-------------|------------|---------|
| **Tipo** | Relacional | NoSQL | Relacional | Cache | Document | Graph |
| **Escalabilidade** | Vertical + Read Replicas | Horizontal | Horizontal | Cluster | Horizontal | Horizontal |
| **Latência** | ms | sub-ms | sub-ms | sub-ms | ms | ms |
| **Durabilidade** | 3 nines | 3 nines | 11 nines | N/A | 3 nines | 3 nines |
| **Schema** | Fixo | Schema-less | Fixo | Key-value | Schema-less | Graph |
| **Serverless** | Não | Sim | Aurora Serverless | Não | Não | Não |
| **Caso Ideal** | Apps tradicionais | Apps escaláveis | Apps modernas | Cache | Apps MongoDB | Grafos |

## Conceitos Chave

- **Bancos de Dados Relacionais (SQL)**: Usam tabelas com esquema fixo, suportam SQL e ACID. Ideais para aplicações com relacionamentos complexos e requisitos de consistência forte.

- **Bancos de Dados NoSQL**: Não usam esquema fixo, oferecem escalabilidade horizontal e flexibilidade de modelo de dados. Tipos: key-value, document, graph, time series, ledger.

- **Serverless**: Bancos de dados serverless (DynamoDB on-demand, Aurora Serverless) escalam automaticamente de zero e cobram por uso real.

- **High Availability**: A maioria dos serviços da AWS oferece replicação automática em múltiplas AZs para alta disponibilidade.

- **Durabilidade**: A AWS replica dados em múltiplas AZs para proteger contra perda de dados. S3 e Aurora oferecem 11 nines de durabilidade.

- **Performance**: Bancos de dados em memória (ElastiCache) oferecem a menor latência. Bancos de dados gerenciados oferecem performance previsível.

## Casos de Uso

- **Aplicação Web com Usuários**: Um site de e-commerce usa RDS (MySQL) para armazenar dados de usuários, pedidos e produtos, com Multi-AZ para alta disponibilidade.

- **API de Alta Performance**: Uma API mobile usa DynamoDB para armazenar dados de sessão e preferências do usuário, com latência de single-digit milissegundos e escala automática.

- **Data Lake**: Uma empresa armazena seus dados brutos no S3 e usa Athena para consultas ad-hoc, sem necessidade de provisionar um cluster de banco de dados.

- **Rede Social**: Um aplicativo de rede social usa Neptune para armazenar relacionamentos entre usuários (amizades, seguidores) e alimentar recomendações.

- **IoT**: Sensores IoT enviam dados para Timestream, que armazena e permite consultas em tempo real para monitoramento.

- **Finanças**: Um sistema bancário usa QLDB para registrar transações financeiras com integridade imutável e auditoria completa.

## Links Oficiais

- [AWS Database Services](https://aws.amazon.com/database/)
- [Amazon RDS User Guide](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Welcome.html)
- [Amazon DynamoDB Developer Guide](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Welcome.html)
- [Amazon Aurora](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Aurora.html)
- [Amazon ElastiCache](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/Welcome.html)
