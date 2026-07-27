# Course Summary

## Visão Geral

O **AWS Technical Essentials** é o curso de introdução técnica oficial da Amazon Web Services, projetado para profissionais que estão começando sua jornada na nuvem AWS. Ao longo de **7 módulos**, o curso fornece uma fundação sólida em conceitos técnicos essenciais, arquitetura de serviços e boas práticas da nuvem AWS.

Este módulo de conclusão traz uma **revisão geral** de todos os conceitos, serviços e boas práticas abordados ao longo do curso, servindo como guia de revisão para fixação do conteúdo.

## Revisão dos Módulos

### Módulo 1: Introduction to Amazon Web Services

| Tópico | Conceitos Chave |
|--------|-----------------|
| **Introduction to AWS Cloud** | Regiões, AZs, Edge Locations, Shared Responsibility Model, Pricing Models, AWS Free Tier |
| **Security in the AWS Cloud** | Shared Responsibility Model, IAM, MFA, Root Account, Security Groups vs. NACLs, Criptografia, AWS Artifact |
| **Hosting the Employee Directory Application** | AMI, Security Groups, IAM Roles, User Data, Elastic IP, Key Pair |
| **Hands-On Lab: IAM** | Criar usuários, grupos, roles, políticas, MFA, least privilege |

### Módulo 2: AWS Compute

| Tópico | Conceitos Chave |
|--------|-----------------|
| **Compute as a Service** | IaaS, CaaS, FaaS, EC2, Lambda, ECS/EKS |
| **Introduction to EC2** | Instâncias, AMIs, tipos de instância, Key Pairs, Security Groups, modelos de preço |
| **EC2 Instance Lifecycle** | Estados (pending, running, stopping, stopped, shutting-down, terminated), custos por estado |
| **AWS Container Services** | ECR, ECS, EKS, Task Definitions, Services, Clusters, Launch Types |
| **What is Serverless?** | FaaS, BaaS, escalabilidade automática, pay-per-execution, cold start, stateless |
| **Introduction to AWS Lambda** | Funções, handlers, runtimes, triggers, cold start, provisioned concurrency, layers |
| **Choose the Right Compute Service** | Framework de decisão, comparação EC2 vs ECS vs Lambda |
| **Hands-On Lab: Launch App on EC2** | Lançar instância, configurar Security Groups, User Data, acessar aplicação |

### Módulo 3: AWS Networking

| Tópico | Conceitos Chave |
|--------|-----------------|
| **Networking in AWS** | VPC, sub-redes, IGW, NAT Gateway, route tables, VPC Peering, VPC Endpoints |
| **Introduction to Amazon VPC** | Componentes, CIDR, sub-redes públicas/privadas, Security Groups, NACLs, Flow Logs |
| **Amazon VPC Routing** | Route tables, longest prefix match, rotas locais, NAT, peering, transit gateway |
| **Amazon VPC Security** | Security Groups (stateful), NACLs (stateless), Flow Logs, comparação SG vs NACL |
| **Hands-On Lab: Create VPC** | Criar VPC, sub-redes, IGW, route tables, NAT Gateway, Security Groups, lançar EC2 |

### Módulo 4: AWS Storage

| Tópico | Conceitos Chave |
|--------|-----------------|
| **AWS Storage Types** | Object (S3), Block (EBS), File (EFS), Ephemeral (Instance Store), Hybrid (Storage Gateway) |
| **EC2 Instance Storage and EBS** | Tipos de volume EBS, snapshots, criptografia, Instance Store, comparação EBS vs Instance Store |
| **Object Storage with S3** | Buckets, objects, classes de armazenamento, versioning, lifecycle, website estático, segurança |
| **Choose the Right Storage Service** | Framework de decisão, matriz de comparação, cenários de escolha |
| **Hands-On Lab: Create S3 Bucket** | Criar bucket, versionamento, lifecycle, upload, bucket policy, website estático |

### Módulo 5: Databases

| Tópico | Conceitos Chave |
|--------|-----------------|
| **Explore Databases in AWS** | RDS, DynamoDB, Aurora, ElastiCache, DocumentDB, Neptune, Timestream, QLDB |
| **Amazon RDS** | Motores suportados, Multi-AZ, Read Replicas, backup, parameter groups, security |
| **Purpose-Built Databases** | DynamoDB, ElastiCache, Neptune, Timestream, QLDB, DocumentDB, OpenSearch |
| **Introduction to DynamoDB** | Tables, items, attributes, partition key, capacity units, streams, Global Tables |
| **Choose the Right Database Service** | Framework de decisão, matriz de comparação, cenários de escolha |
| **Hands-On Lab: Implement and Manage DynamoDB** | Criar tabela, inserir itens, GSI, streams, triggers, backup, PITR |

### Módulo 6: Monitoring, Optimization, and Serverless

| Tópico | Conceitos Chave |
|--------|-----------------|
| **Monitoring** | CloudWatch, CloudTrail, X-Ray, AWS Health, métricas, alarmes, logs |
| **Optimization** | Cost Explorer, Budgets, Trusted Advisor, Compute Optimizer, Savings Plans, Auto Scaling |
| **Alternate Serverless Architecture** | Lambda, API Gateway, DynamoDB, S3, CloudFront, Cognito, arquitetura serverless |
| **Hands-On Lab: Configure High Availability** | Launch Template, ALB, Target Group, Auto Scaling Group, scaling policies, health checks |

## Principais Conceitos Revisados

### Conceitos de Fundamentos

- **Shared Responsibility Model**: A AWS é responsável pela segurança **da** nuvem; o cliente é responsável pela segurança **na** nuvem.
- **Regiões e AZs**: Regiões são isoladas; AZs são data centers separados dentro de uma região.
- **Pricing Models**: Pay-as-you-go, Reserved Instances, Spot Instances, Savings Plans.
- **AWS Free Tier**: 750 horas/mês de EC2 t2.micro, 5 GB de S3, 25 GB de DynamoDB por 12 meses.

### Conceitos de Segurança

- **IAM**: Usuários, grupos, roles, políticas, MFA, least privilege.
- **Security Groups**: Firewalls stateful no nível de instância.
- **Network ACLs**: Firewalls stateless no nível de sub-rede.
- **Criptografia**: KMS para chaves, SSE para S3, EBS encryption.

### Conceitos de Computação

- **EC2**: Instâncias, AMIs, tipos de instância, ciclo de vida, modelos de preço.
- **Lambda**: Funções, triggers, cold start, stateless, pay-per-execution.
- **Containers**: ECS, EKS, ECR, task definitions, services, Fargate.
- **Serverless**: FaaS, BaaS, escalabilidade automática, event-driven.

### Conceitos de Rede

- **VPC**: Rede virtual isolada, sub-redes, route tables, IGW, NAT Gateway.
- **Security**: Security Groups, NACLs, VPC Flow Logs.
- **Conectividade**: VPC Peering, VPN, Direct Connect, Transit Gateway.
- **Endpoints**: Gateway Endpoints, Interface Endpoints.

### Conceitos de Armazenamento

- **S3**: Object storage, 11 nines de durabilidade, classes de armazenamento, lifecycle.
- **EBS**: Block storage, tipos de volume, snapshots, criptografia.
- **EFS**: File storage, NFS, escalabilidade automática.
- **Instance Store**: Ephemeral storage, alta performance, não persistente.

### Conceitos de Banco de Dados

- **RDS**: Banco de dados relacional gerenciado, Multi-AZ, Read Replicas.
- **DynamoDB**: NoSQL serverless, latência sub-ms, escalabilidade automática.
- **Aurora**: MySQL/PostgreSQL cloud-native, 5x performance.
- **Purpose-Built**: Neptune (graph), Timestream (time series), QLDB (ledger).

### Conceitos de Monitoramento e Otimização

- **CloudWatch**: Métricas, logs, alarmes, dashboards.
- **CloudTrail**: Auditoria de chamadas de API.
- **X-Ray**: Tracing distribuído.
- **Optimization**: Cost Explorer, Trusted Advisor, Savings Plans, Auto Scaling.

## Framework de Decisão de Serviços

### Computação

| Caso de Uso | Serviço Recomendado |
|-------------|---------------------|
| Controle total do SO | EC2 |
| Eventos, processamento curto | Lambda |
| Microserviços | ECS/EKS |
| Processamento em lote | Batch |

### Armazenamento

| Caso de Uso | Serviço Recomendado |
|-------------|---------------------|
| Arquivos, backups | S3 |
| Disco para EC2 | EBS |
| Compartilhamento de arquivos | EFS |
| Cache temporário | Instance Store |
| Integração on-premises | Storage Gateway |

### Banco de Dados

| Caso de Uso | Serviço Recomendado |
|-------------|---------------------|
| Apps tradicionais | RDS |
| Apps modernas, alta performance | Aurora |
| APIs, alta performance | DynamoDB |
| Cache, latência sub-ms | ElastiCache |
| Grafos, relacionamentos | Neptune |
| Séries temporais, IoT | Timestream |
| Ledger, auditoria | QLDB |

## Boas Práticas Revisadas

- **Security**: Least privilege, MFA, criptografia, defense in depth
- **High Availability**: Multi-AZ, Auto Scaling, Load Balancing
- **Cost Optimization**: Right-sizing, Spot Instances, Savings Plans, Auto Scaling
- **Performance**: Right service selection, caching, CDN
- **Reliability**: Backup, disaster recovery, monitoring
- **Operational Excellence**: Automation, monitoring, incident response

## Links Oficiais

- [AWS Skill Builder - AWS Technical Essentials](https://explore.skillbuilder.aws/learn/course/1851/aws-technical-essentials)
- [AWS Documentation](https://docs.aws.amazon.com/)
- [AWS Well-Architected Framework](https://docs.aws.amazon.com/wellarchitected/latest/ug/welcome.html)
- [AWS Whitepapers](https://aws.amazon.com/whitepapers/)
