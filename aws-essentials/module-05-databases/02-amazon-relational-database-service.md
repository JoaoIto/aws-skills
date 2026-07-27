# Amazon Relational Database Service

## Visão Geral

O **Amazon Relational Database Service (Amazon RDS)** é um serviço de banco de dados relacional **gerenciado** que simplifica a configuração, operação e escala de bancos de dados na nuvem. O RDS suporta múltiplos motores de banco de dados populares: **MySQL**, **PostgreSQL**, **MariaDB**, **Oracle**, **SQL Server** e **Amazon Aurora** (compatível com MySQL/PostgreSQL).

Com o RDS, a AWS gerencia tarefas operacionais como **patches**, **backup automatizado**, **replicação** e **recuperação de desastres**, permitindo que você foque no desenvolvimento da aplicação e na otimização de consultas.

## Arquitetura do RDS

```
┌─────────────────────────────────────────────────────────────┐
│                    Região AWS                                │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │                    VPC                                   │ │
│  │  ┌───────────────┐  ┌───────────────┐                  │ │
│  │  │  AZ-a         │  │  AZ-b         │                  │ │
│  │  │  DB Instance  │  │  Standby      │                  │ │
│  │  │  (Primária)   │  │  (Multi-AZ)   │                  │ │
│  │  │               │  │               │                  │ │
│  │  │  EBS Volumes  │  │  EBS Volumes  │                  │ │
│  │  └───────────────┘  └───────────────┘                  │ │
│  └─────────────────────────────────────────────────────────┘ │
│                                                             │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │  Read Replicas (opcional)                                │ │
│  │  ┌───────────────┐  ┌───────────────┐                  │ │
│  │  │  AZ-c         │  │  AZ-d         │                  │ │
│  │  │  Read Replica │  │  Read Replica │                  │ │
│  │  └───────────────┘  └───────────────┘                  │ │
│  └─────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

## Motores de Banco de Dados Suportados

| Motor | Compatibilidade | Uso Típico |
|-------|-----------------|------------|
| **Amazon Aurora** | MySQL 5.7, PostgreSQL 13+ | Aplicações modernas, alta performance |
| **MySQL** | MySQL padrão | Aplicações web, desenvolvimento |
| **PostgreSQL** | PostgreSQL padrão | Aplicações complexas, extensões |
| **MariaDB** | MariaDB padrão | Substituto do MySQL |
| **Oracle** | Oracle Enterprise | Aplicações corporativas |
| **SQL Server** | SQL Server padrão | Aplicações .NET, Windows |

## Conceitos Chave

- **DB Instance**: Uma instância de banco de dados é um servidor virtual com o mecanismo de banco de dados instalado. Você escolhe o **tipo de instância** (CPU, memória) e o **tamanho do armazenamento**.

- **Multi-AZ (High Availability)**: Quando ativado, o RDS cria uma **réplica em espera (standby)** em outra AZ da mesma região. Em caso de falha na instância primária, o RDS **promove automaticamente** a réplica para primária. O Multi-AZ é **transparente** para a aplicação — o endpoint DNS permanece o mesmo.

- **Read Replicas**: Réplicas de leitura que permitem escalar leituras horizontalmente. Úteis para:
  - Workloads de leitura intensiva (relatórios, analytics)
  - Disaster recovery (réplica em outra região)
  - Aumento de disponibilidade
  - Limitação: réplicas são **eventualmente consistentes** (não síncronas)

- **Amazon Aurora**: Um motor de banco de dados relacional compatível com MySQL e PostgreSQL, mas com arquitetura **cloud-native**:
  - **Armazenamento auto-redundante**: Dados são replicados em 3 AZs automaticamente
  - **Performance**: Até 5x mais rápido que MySQL padrão, 3x mais rápido que PostgreSQL
  - **Escalabilidade**: Armazenamento de 10 GB a 128 TB, crescimento automático
  - **Aurora Serverless**: Escalabilidade automática de zero (ideal para cargas variáveis)

- **Backup Automatizado**: O RDS cria backups automatizados diários e mantém logs de transação. Você pode restaurar para **qualquer ponto no tempo** (point-in-time recovery) dentro da janela de retenção (1-35 dias).

- **Snapshots Manuais**: Cópias de backup que você cria manualmente e mantém até serem excluídas. Não têm limite de retenção.

- **Parameter Groups**: Grupos de parâmetros que controlam as configurações do mecanismo de banco de dados (ex: `max_connections`, `innodb_buffer_pool_size`).

- **Option Groups**: Grupos de opções que controlam recursos adicionais (ex: Oracle Advanced Security, SQL Server Analysis Services).

- **Security Groups e IAM**: O RDS é acessado via **Security Groups** (firewalls) e autenticado via **usuários do banco** ou **IAM Database Authentication** (para MySQL e PostgreSQL).

- **Escalabilidade**:
  - **Vertical**: Aumento de CPU/memória (scale up/down)
  - **Horizontal**: Read replicas para leitura
  - **Storage**: Escalabilidade automática do armazenamento (aumento, mas não diminuição)

## Configurações de Segurança

| Mecanismo | Descrição |
|-----------|-----------|
| **Security Groups** | Controlam acesso de rede (portas, IPs) |
| **IAM Policies** | Controlam acesso via API (RDS IAM Authentication) |
| **Criptografia em Repouso** | KMS para dados e logs |
| **Criptografia em Trânsito** | SSL/TLS para conexões |
| **Parameter Groups** | Configurações de segurança do mecanismo |
| **VPC** | Isolamento de rede |

## Modelos de Preço

| Componente | Unidade | Observação |
|------------|---------|------------|
| **Instance** | Por hora | Depende do tipo de instância |
| **Storage** | Por GB-mês | GP2, GP3, IOPS provisionadas |
| **I/O** | Por 1M de IOPS | Para alguns motores |
| **Backup** | Por GB-mês | Até 100% do storage provisionado |
| **Read Replicas** | Por hora | Instância adicional |

## Casos de Uso

- **Aplicação Web com Usuários**: Um site de e-commerce usa RDS (MySQL) para armazenar dados de usuários, pedidos e produtos, com Multi-AZ para alta disponibilidade.

- **Analytics com Read Replicas**: Um sistema de relatórios usa read replicas do RDS para consultas pesadas, mantendo a instância primária focada em transações.

- **Aplicação com Cargas Variáveis**: Um microserviço usa Aurora Serverless para escalar automaticamente de zero durante períodos de baixa atividade.

- **Migração de Data Center**: Um banco de dados Oracle on-premises é migrado para RDS for Oracle, mantendo compatibilidade com aplicações existentes.

## Links Oficiais

- [Amazon RDS User Guide](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Welcome.html)
- [Amazon Aurora](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Aurora.html)
- [RDS High Availability](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.MultiAZ.html)
