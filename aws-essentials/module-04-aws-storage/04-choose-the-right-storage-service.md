# Choose the Right Storage Service

## Visão Geral

A AWS oferece diversos serviços de armazenamento, cada um otimizado para casos de uso específicos. Escolher o serviço certo afeta diretamente **custo**, **performance**, **durabilidade** e **complexidade operacional**. Este guia fornece um **framework de decisão** para ajudar você a selecionar o serviço de armazenamento ideal.

## Framework de Decisão

### 1. Qual é o tipo de dados?

| Tipo de Dados | Serviço Recomendado | Justificativa |
|---------------|---------------------|---------------|
| **Arquivos (objetos)** | Amazon S3 | Arquivos individuais, alta durabilidade |
| **Discos (blocos)** | Amazon EBS | Discos para instâncias EC2 |
| **Arquivos compartilhados** | Amazon EFS | Compartilhamento via NFS |
| **Sistemas de arquivos Windows** | Amazon FSx | Compatibilidade com Windows/SMB |
| **Dados temporários** | EC2 Instance Store | Alta performance, não persistente |

### 2. Qual é o padrão de acesso?

| Padrão | Serviço Recomendado | Classe de Armazenamento |
|--------|---------------------|------------------------|
| **Acesso frequente** | S3 Standard | Standard |
| **Acesso infrequente** | S3 Standard-IA | Standard-IA |
| **Acesso raro** | S3 One Zone-IA | One Zone-IA |
| **Arquivamento** | S3 Glacier | Glacier |
| **Arquivamento longo prazo** | S3 Glacier Deep Archive | Deep Archive |

### 3. Qual é o requisito de performance?

| Requisito | Serviço Recomendado |
|-----------|---------------------|
| **Latência sub-milissegundo** | EC2 Instance Store |
| **IOPS altas (10.000+)** | EBS io1/io2 |
| **Alta taxa de transferência** | EBS st1, S3 |
| **Latência de milissegundos** | EBS gp3, S3 Standard |

## Matriz de Decisão

| Critério | S3 | EBS | Instance Store | EFS | FSx | Storage Gateway |
|----------|----|-----|----------------|-----|-----|-----------------|
| **Tipo** | Object | Block | Block | File | File | Hybrid |
| **Persistência** | Permanente | Permanente | Temporário | Permanente | Permanente | Permanente |
| **Escalabilidade** | Ilimitada | Até 64 TB | Fixo | Ilimitada | Até 12 TB | Depende do gateway |
| **Compartilhamento** | Sim | Não | Não | Sim | Sim | Sim |
| **Durabilidade** | 11 noves | 3 nines | N/A | 3 nines | 3 nines | 11 noves (S3) |
| **Latência** | ms | sub-ms | sub-ms | ms | ms | Depende |
| **Custo (por GB)** | Baixo | Médio | Incluso | Médio | Alto | Médio |
| **Caso ideal** | Arquivos, backups | Disco EC2 | Cache temporário | Compartilhamento | Windows/Linux | On-premises |

## Cenários de Escolha

### Cenário 1: Banco de Dados de Produção

**Contexto**: Um banco de dados MySQL de produção precisa de alta performance de I/O, latência consistente e backup regular.

**Decisão**: **Amazon EBS io2 (Provisioned IOPS)**
- **Por quê**: O EBS io2 oferece IOPS provisionadas (até 64.000), latência consistente e 99,9% de disponibilidade de volume.
- **Backup**: Snapshots incrementais para backup e recuperação.
- **Alternativa**: Para workloads com alta performance local, instâncias com Instance Store podem ser consideradas, mas com risco de perda de dados.

### Cenário 2: Site Estático

**Contexto**: Um blog ou site corporativo precisa servir arquivos HTML, CSS, JS e imagens com alta disponibilidade e baixo custo.

**Decisão**: **Amazon S3 + CloudFront**
- **Por quê**: O S3 oferece 11 noves de durabilidade, custo próximo de zero para sites de baixo tráfego, e pode servir como website estático.
- **CDN**: CloudFront acelera o acesso global.
- **Alternativa**: Para sites dinâmicos, EC2 ou Lambda@Edge.

### Cenário 3: Compartilhamento de Arquivos entre Instâncias

**Contexto**: Múltiplas instâncias EC2 precisam acessar os mesmos arquivos simultaneamente (ex: processamento de imagens em paralelo).

**Decisão**: **Amazon EFS**
- **Por quê**: O EFS é um sistema de arquivos NFS que permite acesso simultâneo de múltiplas instâncias. Escalável automaticamente.
- **Alternativa**: Para compartilhamento entre contas, S3 com acesso via API.

### Cenário 4: Backup e Arquivamento

**Contexto**: Dados de backup precisam ser armazenados por longos períodos (7-10 anos) com custo mínimo.

**Decisão**: **Amazon S3 Glacier Deep Archive**
- **Por quê**: Custo mais baixo por GB, ideal para dados acessados raramente.
- **Recuperação**: 12 horas para acesso.
- **Lifecycle**: Política automática que move dados do S3 Standard para Glacier após 90 dias.

### Cenário 5: Processamento de Dados em Lote

**Contexto**: Jobs de processamento noturno precisam de alta taxa de transferência para ler/escrever grandes volumes de dados.

**Decisão**: **Amazon EBS st1 (Throughput Optimized HDD)**
- **Por quê**: Alta taxa de transferência (até 500 MB/s), ideal para processamento sequencial de dados.
- **Alternativa**: Para dados muito grandes, S3 com processamento via Athena ou EMR.

### Cenário 6: Integração On-Premises

**Contexto**: Uma empresa precisa conectar seu data center local aos serviços de armazenamento da AWS, usando protocols padrão (NFS, SMB, iSCSI).

**Decisão**: **AWS Storage Gateway**
- **Por quê**: Permite acesso aos serviços de armazenamento da AWS via protocols padrão, sem necessidade de reescrever aplicações.
- **Tipo**: Gateway de Arquivo (para NFS/SMB) ou Gateway de Volume (para iSCSI).

## Tabela de Referência Rápida

| Serviço | Quando Usar | Quando NÃO Usar |
|---------|-------------|-----------------|
| **S3** | Arquivos, backups, websites estáticos, data lakes | Dados que precisam de sistema de arquivos (NFS) |
| **EBS** | Disco para EC2, bancos de dados, sistemas operacionais | Dados temporários, compartilhamento entre instâncias |
| **Instance Store** | Cache, dados temporários, alta performance | Dados que precisam persistir |
| **EFS** | Compartilhamento de arquivos entre instâncias | Acesso a arquivos individuais (use S3) |
| **FSx** | Sistemas de arquivos Windows/Linux | Armazenamento de objetos |
| **Storage Gateway** | Integração on-premises | Acesso direto via API |

## Links Oficiais

- [AWS Storage Services](https://docs.aws.amazon.com/whitepapers/latest/aws-overview/storage-services.html)
- [Amazon S3 Storage Classes](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage-class-intro.html)
- [Amazon EBS Volume Types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSVolumeTypes.html)
