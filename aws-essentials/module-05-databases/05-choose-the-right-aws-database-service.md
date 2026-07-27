# Choose the Right AWS Database Service

## Visão Geral

A AWS oferece diversos serviços de banco de dados, cada um otimizado para casos de uso específicos. Escolher o serviço certo afeta diretamente **custo**, **performance**, **complexidade operacional** e **escalabilidade**. Este guia fornece um **framework de decisão** para ajudar você a selecionar o serviço de banco de dados ideal.

## Framework de Decisão

### 1. Qual é o tipo de dados?

| Tipo de Dados | Serviço Recomendado | Justificativa |
|---------------|---------------------|---------------|
| **Tabelas relacionais** | Amazon RDS, Aurora | Esquema fixo, SQL, ACID |
| **Documentos JSON** | DynamoDB, DocumentDB | Schema-less, flexível |
| **Grafos** | Neptune | Relacionamentos complexos |
| **Séries temporais** | Timestream | Dados com timestamp |
| **Ledger imutável** | QLDB | Integridade e auditoria |
| **Cache em memória** | ElastiCache | Latência sub-ms |
| **Busca full-text** | OpenSearch Service | Indexação e busca |

### 2. Qual é o padrão de acesso?

| Padrão | Serviço Recomendado | Justificativa |
|--------|---------------------|---------------|
| **Leitura/escrita por chave** | DynamoDB | Key-value, latência sub-ms |
| **Consultas complexas (JOINs)** | RDS, Aurora | SQL, relacionamentos |
| **Navegação de grafos** | Neptune | Traversals, conexões |
| **Inserção de séries temporais** | Timestream | Otimizado para timestamps |
| **Cache de consultas** | ElastiCache | Redis/Memcached |
| **Busca full-text** | OpenSearch Service | Indexação e busca |

### 3. Qual é a escala esperada?

| Escala | Serviço Recomendado | Justificativa |
|--------|---------------------|---------------|
| **Até 100K req/s** | RDS, DynamoDB | Escala adequada |
| **100K-1M req/s** | DynamoDB, Aurora | Escala horizontal |
| **1M+ req/s** | DynamoDB, ElastiCache | Escala ilimitada |
| **Bilhões de eventos/dia** | Timestream | Séries temporais |

### 4. Qual é o requisito de consistência?

| Requisito | Serviço Recomendado | Justificativa |
|-----------|---------------------|---------------|
| **Consistência forte** | RDS, Aurora, DynamoDB (Strong) | ACID, transações |
| **Consistência eventual** | DynamoDB (Eventual), ElastiCache | Latência mais baixa |
| **Imutabilidade** | QLDB | Ledger imutável |

## Matriz de Decisão

| Critério | RDS | Aurora | DynamoDB | ElastiCache | Neptune | Timestream | QLDB | DocumentDB | OpenSearch |
|----------|-----|--------|----------|-------------|---------|------------|------|------------|------------|
| **Tipo** | Relacional | Relacional | NoSQL | Cache | Graph | Time Series | Ledger | Document | Search |
| **Escalabilidade** | Vertical + RR | Horizontal | Horizontal | Cluster | Horizontal | Auto | Horizontal | Horizontal | Cluster |
| **Latência** | ms | sub-ms | sub-ms | sub-ms | ms | ms | ms | ms | ms |
| **Durabilidade** | 3 nines | 11 noves | 3 nines | N/A | 3 nines | 3 nines | 3 nines | 3 nines | 3 nines |
| **Schema** | Fixo | Fixo | Schema-less | Key-value | Graph | Schema-less | Schema-less | Schema-less | Schema-less |
| **Serverless** | Não | Aurora Serverless | Sim | Não | Não | Não | Não | Não | Não |
| **Custo (idle)** | Alto | Alto | Zero | Alto | Alto | Alto | Alto | Alto | Alto |
| **Caso Ideal** | Apps tradicionais | Apps modernas | Apps escaláveis | Cache | Grafos | Séries temporais | Ledger | Apps MongoDB | Busca |

## Serviços de Banco de Dados da AWS

| Serviço | Descrição | Caso de Uso |
|---------|-----------|-------------|
| **Amazon RDS** | Banco de dados relacional gerenciado | Apps tradicionais, migração |
| **Amazon Aurora** | MySQL/PostgreSQL cloud-native | Apps modernas, alta performance |
| **Amazon DynamoDB** | NoSQL serverless | APIs, sessões, IoT |
| **Amazon ElastiCache** | Cache em memória | Cache, sessões, leaderboards |
| **Amazon Neptune** | Banco de dados graph | Redes sociais, recomendações |
| **Amazon Timestream** | Banco de dados time series | IoT, monitoramento |
| **Amazon QLDB** | Ledger imutável | Finanças, supply chain |
| **Amazon DocumentDB** | MongoDB compatível | Apps MongoDB |
| **Amazon OpenSearch** | Busca e analytics | Busca, logs, analytics |
| **Amazon Keyspaces** | Cassandra compatível | Apps Cassandra |

## Cenários de Escolha

### Cenário 1: Aplicação Web com Usuários

**Contexto**: Um site de e-commerce precisa armazenar dados de usuários, pedidos e produtos com relacionamentos complexos e consistência forte.

**Decisão**: **Amazon RDS (MySQL) ou Aurora**
- **Por quê**: Dados relacionais com JOINs entre usuários, pedidos e produtos. Necessidade de consistência forte e transações ACID.
- **Alternativa**: Para alta performance, Aurora oferece 5x mais velocidade que MySQL padrão.

### Cenário 2: API de Alta Performance

**Contexto**: Uma API mobile precisa servir milhares de requisições por segundo com latência de single-digit milissegundos.

**Decisão**: **Amazon DynamoDB**
- **Por quê**: Latência sub-ms, escalabilidade automática, serverless. Ideal para APIs com padrão de acesso por chave.
- **Alternativa**: Para cache, adicione ElastiCache entre a API e o DynamoDB.

### Cenário 3: Rede Social

**Contexto**: Um aplicativo de rede social precisa armazenar relacionamentos entre usuários e alimentar sistemas de recomendação.

**Decisão**: **Amazon Neptune**
- **Por quê**: Banco de dados graph otimizado para armazenar e consultar relacionamentos (amizades, seguidores, interações).
- **Alternativa**: Para dados de usuário, use RDS ou DynamoDB.

### Cenário 4: IoT

**Contexto**: Sensores IoT enviam milhões de eventos por dia com timestamps para monitoramento em tempo real.

**Decisão**: **Amazon Timestream**
- **Por quê**: Banco de dados time series otimizado para inserção de dados com timestamps, com análise de séries temporais integrada.
- **Alternativa**: Para dados não temporais, use DynamoDB.

### Cenário 5: Sistema Financeiro

**Contexto**: Um sistema bancário precisa registrar transações financeiras com integridade imutável e auditoria completa.

**Decisão**: **Amazon QLDB**
- **Por quê**: Ledger imutável que garante que dados não podem ser modificados ou excluídos, com histórico completo de transações.
- **Alternativa**: Para dados que precisam ser modificados, use RDS ou Aurora.

### Cenário 6: Cache de Consultas

**Contexto**: Uma aplicação web precisa reduzir a latência de leitura de consultas frequentes ao banco de dados.

**Decisão**: **Amazon ElastiCache (Redis)**
- **Por quê**: Cache em memória com latência sub-ms, suporte a estruturas de dados avançadas (sorted sets, pub/sub).
- **Alternativa**: Para cache simples, use Memcached.

### Cenário 7: Migração de MongoDB

**Contexto**: Uma empresa precisa migrar seu cluster MongoDB on-premises para a AWS sem alterar o código da aplicação.

**Decisão**: **Amazon DocumentDB**
- **Por quê**: Compatível com APIs MongoDB, drivers e ferramentas. Permite migração sem alterações no código.
- **Alternativa**: Para novas aplicações, considere DynamoDB.

### Cenário 8: Busca e Analytics

**Contexto**: Uma aplicação precisa fornecer busca full-text em documentos e analisar logs em tempo real.

**Decisão**: **Amazon OpenSearch Service**
- **Por quê**: Indexação e busca full-text, analytics em tempo real, visualização via Kibana.
- **Alternativa**: Para busca simples, use S3 Select.

## Tabela de Referência Rápida

| Serviço | Quando Usar | Quando NÃO Usar |
|---------|-------------|-----------------|
| **RDS** | Apps tradicionais, SQL, migração | Alta escala, serverless |
| **Aurora** | Apps modernas, alta performance | Apps legadas sem compatibilidade |
| **DynamoDB** | APIs, alta performance, serverless | Consultas complexas, JOINs |
| **ElastiCache** | Cache, sessões, latência sub-ms | Dados persistentes |
| **Neptune** | Grafos, relacionamentos | Dados tabulares |
| **Timestream** | Séries temporais, IoT | Dados não temporais |
| **QLDB** | Ledger, auditoria, integridade | Dados que precisam ser modificados |
| **DocumentDB** | Apps MongoDB | Novas aplicações sem MongoDB |
| **OpenSearch** | Busca, analytics, logs | Dados estruturados simples |
| **Keyspaces** | Apps Cassandra | Novas aplicações sem Cassandra |

## Links Oficiais

- [AWS Database Services](https://aws.amazon.com/database/)
- [Amazon RDS User Guide](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Welcome.html)
- [Amazon DynamoDB Developer Guide](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Welcome.html)
- [Amazon Aurora](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Aurora.html)
- [Amazon Neptune](https://docs.aws.amazon.com/neptune/latest/userguide/what-is.html)
- [Amazon Timestream](https://docs.aws.amazon.com/timestream/latest/ug/what-is-timestream.html)
- [Amazon QLDB](https://docs.aws.amazon.com/qldb/latest/developerguide/what-is.html)
