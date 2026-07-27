# 📝 Simulado AWS Technical Essentials

> **Baseado no conteúdo oficial do AWS Technical Essentials | Fonte: AWS Skill Builder & AWS Documentation**

---

## 📋 Instruções

- **Total de questões:** 25
- **Duração sugerida:** 45 minutos
- **Formato:** Múltipla escolha (1 resposta correta) e múltipla resposta (2 respostas corretas)
- **Pontuação mínima para aprovação:** 70% (18 acertos)
- **Fontes oficiais:** [AWS Technical Essentials](https://explore.skillbuilder.aws/learn/course/1851/aws-technical-essentials) | [AWS Documentation](https://docs.aws.amazon.com/)

> ⚠️ Este simulado foi elaborado com base **exclusivamente** no conteúdo do curso AWS Technical Essentials e na documentação oficial da AWS. As respostas e explicações referenciam diretamente os serviços e conceitos ensinados nos 7 módulos do curso.

---

## Questões

### Questão 1 (Múltipla Escolha) — Módulo 1: Introdução à AWS
**Qual é o principal benefício da computação em nuvem em relação a infraestrutura on-premises tradicional?**

- A) Necessidade de investimento inicial em hardware
- B) Escalabilidade sob demanda (elasticidade)
- C) Controle total sobre o hardware físico
- D) Latência sempre menor para todos os usuários

<details>
<summary>Ver resposta</summary>

**Resposta:** B) Escalabilidade sob demanda (elasticidade)

**Explicação:** A elasticidade permite provisionar e liberar recursos automaticamente conforme a demanda, pagando apenas pelo que é utilizado. Fonte: [AWS Cloud Concepts](https://docs.aws.amazon.com/whitepapers/latest/aws-overview/key-concepts.html)

</details>

---

### Questão 2 (Múltipla Escolha) — Módulo 1: IAM
**Qual é a melhor prática para segurança de contas na AWS?**

- A) Usar o usuário root para tarefas cotidianas
- B) Conceder permissões de administrador a todos os usuários
- C) Criar usuários individuais e usar grupos para gerenciar permissões
- D) Compartilhar credenciais entre membros da equipe

<details>
<summary>Ver resposta</summary>

**Resposta:** C) Criar usuários individuais e usar grupos para gerenciar permissões

**Explicação:** O modelo de responsabilidade compartilhada inclui a prática de criar usuários individuais, usar grupos para gerenciamento de permissões e aplicar o princípio de menor privilégio. Fonte: [AWS IAM Best Practices](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html)

</details>

---

### Questão 3 (Múltipla Escolha) — Módulo 2: EC2
**Qual é a característica principal do Amazon EC2?**

- A) É um serviço de banco de dados relacional totalmente gerenciado
- B) Fornece instâncias virtuais na nuvem com capacidade de computação redimensionável
- C) Executa código sem necessidade de provisionar servidores
- D) É um serviço de armazenamento de objetos

<details>
<summary>Ver resposta</summary>

**Resposta:** B) Fornece instâncias virtuais na nuvem com capacidade de computação redimensionável

**Explicação:** Amazon EC2 (Elastic Compute Cloud) fornece capacidade de computação na nuvem redimensionável e está projetado para facilitar o acesso à computação em nuvem. Fonte: [Amazon EC2](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html)

</details>

---

### Questão 4 (Múltipla Escolha) — Módulo 2: Lambda
**Qual afirmação sobre AWS Lambda está CORRETA?**

- A) Você deve provisionar e gerenciar servidores manualmente
- B) O código é executado por até 15 minutos por invocação
- C) Você paga por hora de uso, independentemente do tempo de execução
- D) Só pode ser acionado manualmente pelo console

<details>
<summary>Ver resposta</summary>

**Resposta:** B) O código é executado por até 15 minutos por invocação

**Explicação:** AWS Lambda é um serviço de computação serverless que executa código em resposta a eventos. O tempo máximo de execução por invocação é de 15 minutos. Fonte: [AWS Lambda](https://docs.aws.amazon.com/lambda/latest/dg/lambda-overview.html)

</details>

---

### Questão 5 (Múltipla Escolha) — Módulo 2: Containers
**Qual serviço da AWS é uma solução de orquestração de containers compatível com Kubernetes?**

- A) Amazon ECS
- B) Amazon ECR
- C) Amazon EKS
- D) AWS Fargate

<details>
<summary>Ver resposta</summary>

**Resposta:** C) Amazon EKS

**Explicação:** Amazon EKS (Elastic Kubernetes Service) é um serviço gerenciado que simplifica a execução do Kubernetes na AWS. Amazon ECS é a solução nativa da AWS para orquestração. Fonte: [Amazon EKS](https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html)

</details>

---

### Questão 6 (Múltipla Escolha) — Módulo 3: VPC
**Qual é a função principal de um Security Group na Amazon VPC?**

- A) Filtrar tráfego de entrada e saída em nível de subnet (stateless)
- B) Filtrar tráfego de entrada e saída em nível de instância (stateful)
- C) Rotear tráfego entre sub-redes diferentes
- D) Fornecer conectividade VPN entre escritórios

<details>
<summary>Ver resposta</summary>

**Resposta:** B) Filtrar tráfego de entrada e saída em nível de instância (stateful)

**Explicação:** Security Groups operam no nível da instância e são stateful — se você permite tráfego de entrada, a resposta correspondente é automaticamente permitida na saída. Fonte: [VPC Security Groups](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html)

</details>

---

### Questão 7 (Múltipla Escolha) — Módulo 3: VPC
**Qual afirmação sobre Network ACLs (NACLs) está CORRETA?**

- A) São stateful — tráfego de retorno é automaticamente permitido
- B) São stateless — tráfego de retorno deve ser explicitamente permitido
- C) São aplicados em nível de instância, não de subnet
- D) Só permitem tráfego de entrada, não de saída

<details>
<summary>Ver resposta</summary>

**Resposta:** B) São stateless — tráfego de retorno deve ser explicitamente permitido

**Explicação:** Network ACLs são firewalls stateless no nível de subnet. Diferentemente de Security Groups, se você permite tráfego de entrada, precisa explicitamente permitir o tráfego de saída de retorno. Fonte: [Network ACLs](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html)

</details>

---

### Questão 8 (Múltipla Escolha) — Módulo 4: S3
**Qual é a característica principal do Amazon S3?**

- A) Armazenamento de blocos para uso com Amazon EC2
- B) Armazenamento de arquivos compartilhados entre múltiplas instâncias EC2
- C) Armazenamento de objetos acessado via HTTP/HTTPS
- D) Armazenamento de backup para bancos de dados

<details>
<summary>Ver resposta</summary>

**Resposta:** C) Armazenamento de objetos acessado via HTTP/HTTPS

**Explicação:** Amazon S3 (Simple Storage Service) é um serviço de armazenamento de objetos projetado para armazenar e recuperar qualquer quantidade de dados. Os dados são acessados via protocolos HTTP/HTTPS. Fonte: [Amazon S3](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html)

</details>

---

### Questão 9 (Múltipla Escolha) — Módulo 4: EBS
**Qual é a diferença entre Amazon EBS e Amazon EC2 Instance Store?**

- A) EBS é volátil (perde dados quando a instância para), Instance Store é persistente
- B) EBS é persistente (sobrevive à parada da instância), Instance Store é volátil
- C) Ambos são voláteis, mas EBS é mais rápido
- D) Ambos são persistentes, mas EBS é mais barato

<details>
<summary>Ver resposta</summary>

**Resposta:** B) EBS é persistente (sobrevive à parada da instância), Instance Store é volátil

**Explicação:** Amazon EBS fornece volumes de bloco persistentes que existem independentemente do ciclo de vida da instância. Amazon EC2 Instance Store fornece armazenamento de bloco temporário que persiste apenas enquanto a instância está em execução. Fonte: [Amazon EBS](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AmazonEBS.html) | [Instance Store](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-store.html)

</details>

---

### Questão 10 (Múltipla Escolha) — Módulo 5: RDS
**Qual é o principal benefício do Amazon RDS?**

- A) É um serviço de banco de dados NoSQL totalmente gerenciado
- B) Automatiza tarefas de gerenciamento de bancos de dados relacionais (patching, backup, failover)
- C) Fornece armazenamento de objetos com versionamento
- D) É gratuito para todos os usuários da AWS

<details>
<summary>Ver resposta</summary>

**Resposta:** B) Automatiza tarefas de gerenciamento de bancos de dados relacionais (patching, backup, failover)

**Explicação:** Amazon RDS (Relational Database Service) facilita a configuração, operação e escala de um banco de dados relacional na nuvem, automatizando tarefas como patching, backup e failover. Fonte: [Amazon RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Welcome.html)

</details>

---

### Questão 11 (Múltipla Escolha) — Módulo 5: DynamoDB
**Qual é a característica principal do Amazon DynamoDB?**

- A) Banco de dados relacional com SQL compatível com PostgreSQL
- B) Banco de dados NoSQL de chave-valor e documento totalmente gerenciado
- C) Serviço de cache em memória para aplicações web
- D) Banco de dados analítico para consultas complexas

<details>
<summary>Ver resposta</summary>

**Resposta:** B) Banco de dados NoSQL de chave-valor e documento totalmente gerenciado

**Explicação:** Amazon DynamoDB é um serviço de banco de dados NoSQL de uso rápido e com escala totalmente gerenciado que oferece suporte a modelos de dados de chave-valor e documento. Fonte: [Amazon DynamoDB](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.NamingRulesDataTypes.html)

</details>

---

### Questão 12 (Múltipla Escolha) — Módulo 6: CloudWatch
**Qual é a função principal do Amazon CloudWatch?**

- A) Registrar e monitorar chamadas de API para recursos da AWS
- B) Monitorar recursos e aplicações da AWS, coletando métricas e logs
- C) Fornecer conectividade VPN entre redes locais e a nuvem AWS
- D) Armazenar e versionar arquivos estáticos

<details>
<summary>Ver resposta</summary>

**Resposta:** B) Monitorar recursos e aplicações da AWS, coletando métricas e logs

**Explicação:** Amazon CloudWatch é um serviço de monitoramento e observabilidade que fornece dados de diagnóstico e insights visuais para ajudar a otimizar a confiabilidade, a performance e o custo. Fonte: [Amazon CloudWatch](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/WhatIsCloudWatch.html)

</details>

---

### Questão 13 (Múltipla Escolha) — Módulo 6: CloudTrail
**Qual é a diferença entre AWS CloudTrail e Amazon CloudWatch?**

- A) CloudTrail monitora métricas de CPU, CloudWatch registra chamadas de API
- B) CloudTrail registra chamadas de API, CloudWatch monitora métricas e estado de recursos
- C) CloudTrail é gratuito, CloudWatch tem custo
- D) CloudTrail é para redes, CloudWatch é para bancos de dados

<details>
<summary>Ver resposta</summary>

**Resposta:** B) CloudTrail registra chamadas de API, CloudWatch monitora métricas e estado de recursos

**Explicação:** AWS CloudTrail é um serviço de auditoria que registra chamadas de API e ações em recursos da AWS. Amazon CloudWatch é um serviço de monitoramento que coleta métricas, logs e dados de recursos e aplicações. Fonte: [AWS CloudTrail](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-overview.html) | [Amazon CloudWatch](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/WhatIsCloudWatch.html)

</details>

---

### Questão 14 (Múltipla Escolha) — Módulo 1: Shared Responsibility Model
**No modelo de responsabilidade compartilhada da AWS, quem é responsável pelo patching do sistema operacional em uma instância EC2?**

- A) AWS
- B) Cliente
- C) Ambos compartilham a responsabilidade
- D) Nenhum — o patching não é necessário

<details>
<summary>Ver resposta</summary>

**Resposta:** B) Cliente

**Explicação:** No modelo de responsabilidade compartilhada, a AWS é responsável pela segurança DA nuvem (infraestrutura), enquanto o cliente é responsável pela segurança NO nuvem (sistema operacional, aplicações, dados). Para EC2, o cliente administra o sistema operacional, incluindo patching. Fonte: [Shared Responsibility Model](https://aws.amazon.com/compliance/shared-responsibility-model/)

</details>

---

### Questão 15 (Múltipla Escolha) — Módulo 1: Shared Responsibility Model
**Quem é responsável pela segurança física dos data centers da AWS?**

- A) O cliente
- B) A AWS
- C) Ambos compartilham
- D) Terceiros contratados pelo cliente

<details>
<summary>Ver resposta</summary>

**Resposta:** B) A AWS

**Explicação:** A AWS é responsável pela segurança física dos data centers, incluindo controle de acesso físico, monitoramento de video, proteção contra incêndios e condições ambientais. Fonte: [AWS Security](https://aws.amazon.com/security/)

</details>

---

### Questão 16 (Múltipla Escolha) — Módulo 2: Choose Compute
**Uma aplicação precisa ser executada apenas quando um arquivo é enviado ao S3. Qual serviço é mais apropriado?**

- A) Amazon EC2
- B) AWS Lambda
- C) Amazon ECS
- D) Amazon EKS

<details>
<summary>Ver resposta</summary>

**Resposta:** B) AWS Lambda

**Explicação:** AWS Lambda é ideal para processamento orientado a eventos. Quando um arquivo é enviado ao S3, um evento pode acionar uma função Lambda automaticamente, sem necessidade de servidor sempre ativo. Fonte: [AWS Lambda Use Cases](https://docs.aws.amazon.com/lambda/latest/dg/library.html)

</details>

---

### Questão 17 (Múltipla Escolha) — Módulo 4: Choose Storage
**Uma aplicação precisa de armazenamento de bloco persistente conectado a uma instância EC2. Qual serviço usar?**

- A) Amazon S3
- B) Amazon EBS
- C) Amazon EFS
- D) Amazon S3 Glacier

<details>
<summary>Ver resposta</summary>

**Resposta:** B) Amazon EBS

**Explicação:** Amazon EBS fornece volumes de armazenamento em bloco persistentes que podem ser montados como discos em instâncias EC2. S3 é armazenamento de objetos, EFS é armazenamento de arquivos. Fonte: [Amazon EBS](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AmazonEBS.html)

</details>

---

### Questão 18 (Múltipla Escolha) — Módulo 5: Choose Database
**Uma aplicação precisa de um banco de dados NoSQL com latência de milissegundos e escala automática. Qual serviço usar?**

- A) Amazon RDS
- B) Amazon DynamoDB
- C) Amazon Redshift
- D) Amazon ElastiCache

<details>
<summary>Ver resposta</summary>

**Resposta:** B) Amazon DynamoDB

**Explicação:** Amazon DynamoDB é um banco de dados NoSQL de chave-valor e documento que oferece latência de milissegundos em escala de unidades de processamento (milhões de solicitações por segundo). Fonte: [Amazon DynamoDB](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.ReadWriteConsistency.html)

</details>

---

### Questão 19 (Múltipla Escolha) — Módulo 6: High Availability
**Qual recurso ajuda a garantir alta disponibilidade para uma aplicação em múltiplas zonas de disponibilidade?**

- A) Amazon S3
- B) Auto Scaling
- C) Amazon EBS
- D) AWS Lambda

<details>
<summary>Ver resposta</summary>

**Resposta:** B) Auto Scaling

**Explicação:** Auto Scaling ajuda a garantir que você tenha o número correto de instâncias EC2 disponíveis para lidar com a carga, distribuindo-as automaticamente em múltiplas zonas de disponibilidade para alta disponibilidade. Fonte: [Auto Scaling](https://docs.aws.amazon.com/autoscaling/ec2/userguide/what-is-auto-scaling.html)

</details>

---

### Questão 20 (Múltipla Escolha) — Módulo 4: S3
**Qual é a diferença entre S3 Standard e S3 Standard-IA?**

- A) Standard-IA tem custo de recuperação mais alto, Standard não
- B) Standard-IA é para dados acessados com frequência, Standard é para acesso infrequente
- C) Standard-IA oferece disponibilidade mais baixa (99.9%)
- D) Standard não suporta versionamento

<details>
<summary>Ver resposta</summary>

**Resposta:** A) Standard-IA tem custo de recuperação mais alto, Standard não

**Explicação:** S3 Standard é para dados acessados com frequência. S3 Standard-IA (Infrequent Access) é para dados acessados com menos frequência, com custo de armazenamento menor mas custo de recuperação mais alto. Fonte: [S3 Storage Classes](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage-class-intro.html)

</details>

---

### Questão 21 (Múltipla Escolha) — Módulo 3: VPC
**Qual é a função de um Internet Gateway na VPC?**

- A) Conectar a VPC a uma rede local via VPN
- B) Fornecer conectividade entre a VPC e a internet
- C) Filtrar pacotes de entrada e saída
- D) Balancear carga entre instâncias

<details>
<summary>Ver resposta</summary>

**Resposta:** B) Fornecer conectividade entre a VPC e a internet

**Explicação:** Um Internet Gateway é um componente de redes virtualizadas que fornece conectividade entre a VPC e a internet. Ele permite o tráfego de saída e entrada para recursos que possuem IP público. Fonte: [Internet Gateway](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Internet_Gateway.html)

</details>

---

### Questão 22 (Múltipla Escolha) — Módulo 5: RDS vs DynamoDB
**Qual é a principal diferença entre Amazon RDS e Amazon DynamoDB?**

- A) RDS é NoSQL, DynamoDB é relacional
- B) RDS é relacional, DynamoDB é NoSQL
- C) Ambos são relacionais, mas RDS é gerenciado e DynamoDB não
- D) Ambos são NoSQL, mas RDS é mais rápido

<details>
<summary>Ver resposta</summary>

**Resposta:** B) RDS é relacional, DynamoDB é NoSQL

**Explicação:** Amazon RDS é um serviço de banco de dados relacional que suporta SQL. Amazon DynamoDB é um banco de dados NoSQL de chave-valor e documento. Fonte: [Amazon RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Welcome.html) | [Amazon DynamoDB](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.NamingRulesDataTypes.html)

</details>

---

### Questão 23 (Múltipla Escolha) — Módulo 6: Serverless Architecture
**Qual é o principal benefício da arquitetura serverless?**

- A) Controle total sobre o servidor físico
- B) Elimina a necessidade de gerenciar servidores e paga-se apenas pelo uso
- C) Latência sempre zero para todas as solicitações
- D) Compatibilidade garantida com todos os frameworks

<details>
<summary>ver resposta</summary>

**Resposta:** B) Elimina a necessidade de gerenciar servidores e paga-se apenas pelo uso

**Explicação:** A arquitetura serverless (como AWS Lambda) elimina a necessidade de provisionar e gerenciar servidores. Você paga apenas pelo tempo de execução do código, não por servidores ocios. Fonte: [Serverless Computing](https://aws.amazon.com/serverless/)

</details>

---

### Questão 24 (Múltipla Escolha) — Módulo 4: Storage Gateway
**Qual serviço fornece conectividade entre armazenamento local e a nuvem AWS?**

- A) AWS Direct Connect
- B) Amazon Storage Gateway
- C) Amazon CloudFront
- D) Amazon S3

<details>
<summary>Ver resposta</summary>

**Resposta:** B) Amazon Storage Gateway

**Explicação:** Amazon Storage Gateway conecta a infraestrutura de armazenamento local à nuvem AWS, permitindo backup e migrar dados para a nuvem. Fonte: [AWS Storage Gateway](https://docs.aws.amazon.com/storagegateway/latest/ag/what-is-storage-gateway.html)

</details>

---

### Questão 25 (Múltipla Escolha) — Módulo 2: Elastic Beanstalk
**Qual é a diferença entre AWS Elastic Beanstalk e AWS CloudFormation?**

- A) Elastic Beanstalk é para IaC, CloudFormation é para deploy de aplicações
- B) Elastic Beanstalk automatiza o deploy de aplicações, CloudFormation provisiona infraestrutura
- C) Ambos fazem a mesma coisa
- D) Elastic Beanstalk é mais antigo que CloudFormation

<details>
<summary>Ver resposta</summary>

**Resposta:** B) Elastic Beanstalk automatiza o deploy de aplicações, CloudFormation provisiona infraestrutura

**Explicação:** AWS Elastic Beanstalk é um serviço de orquestração que facilita o deploy de aplicações, abstraindo a complexidade de provisionamento. AWS CloudFormation é uma ferramenta de Infrastructure as Code (IaC) para provisionar e gerenciar recursos da AWS. Fonte: [Elastic Beanstalk](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/Welcome.html) | [CloudFormation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/Welcome.html)

</details>

---

## 📊 Gabarito

| Questão | Resposta | Domínio |
|---------|----------|---------|
| 1 | B | Cloud Concepts |
| 2 | C | Security & Compliance |
| 3 | B | Technology & Services |
| 4 | B | Technology & Services |
| 5 | C | Technology & Services |
| 6 | B | Security & Compliance |
| 7 | B | Security & Compliance |
| 8 | C | Technology & Services |
| 9 | B | Technology & Services |
| 10 | B | Technology & Services |
| 11 | B | Technology & Services |
| 12 | B | Technology & Services |
| 13 | B | Technology & Services |
| 14 | B | Security & Compliance |
| 15 | B | Security & Compliance |
| 16 | B | Technology & Services |
| 17 | B | Technology & Services |
| 18 | B | Technology & Services |
| 19 | B | Technology & Services |
| 20 | A | Technology & Services |
| 21 | B | Technology & Services |
| 22 | B | Technology & Services |
| 23 | B | Technology & Services |
| 24 | B | Technology & Services |
| 25 | B | Technology & Services |

**Pontuação:** 18-25 acertos = Aprovado (72-100%) | 14-17 acertos = Reprovado (56-68%) | 0-13 acertos = Reprovado (0-52%)

---

## 🔗 Referências Oficiais

- **AWS Technical Essentials**: https://explore.skillbuilder.aws/learn/course/1851/aws-technical-essentials
- **AWS Documentation**: https://docs.aws.amazon.com/
- **AWS Well-Architected Framework**: https://aws.amazon.com/architecture/well-architected/
- **AWS Exam Guide CLF-C02**: https://d1.awsstatic.com/training-and-certification/docs-cloud-practitioner/AWS-Certified-Cloud-Practitioner_Exam-Guide.pdf

---

> **Nota**: Este simulado foi elaborado com base exclusivamente no conteúdo do curso AWS Technical Essentials e na documentação oficial da AWS. As questões cobrem todos os 7 módulos do curso e estão alinhadas aos domínios do exame CLF-C02.
