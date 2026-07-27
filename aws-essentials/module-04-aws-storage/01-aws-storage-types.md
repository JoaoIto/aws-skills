# AWS Storage Types

## Visão Geral

A AWS oferece diversos **tipos de armazenamento**, cada um otimizado para casos de uso específicos. Esses tipos de armazenamento diferem em **tipo de dado**, **persistência**, **performance**, **durabilidade** e **custo**. Compreender as diferenças entre eles é essencial para escolher a solução certa para cada carga de trabalho.

Os principais tipos de armazenamento da AWS são:

| Tipo | Serviço | Descrição |
|------|---------|-----------|
| **Object Storage** | Amazon S3 | Arquivos individuais (objetos) com metadados |
| **Block Storage** | Amazon EBS | Discos virtualizados para instâncias EC2 |
| **File Storage** | Amazon EFS | Sistema de arquivos compartilhado via NFS |
| **Ephemeral Storage** | EC2 Instance Store | Armazenamento temporário conectado ao host |
| **Hybrid Storage** | AWS Storage Gateway | Conexão on-premises com serviços AWS |

## Amazon S3 (Object Storage)

O **Amazon S3 (Simple Storage Service)** é um serviço de **armazenamento de objetos** totalmente gerenciado. Os dados são armazenados como **objetos** dentro de **buckets**, cada um com um ID único, metadados e o próprio conteúdo.

```
┌─────────────────────────────────────────────────────────┐
│                    Amazon S3                            │
│                                                         │
│  ┌────────────────────────────────────────────────────┐ │
│  │  Bucket: employee-directory-assets                 │ │
│  │  ┌──────────────┐  ┌──────────────┐  ┌────────────┐ │ │
│  │  │  photo.jpg   │  │  resume.pdf  │  │  data.csv  │ │ │
│  │  │  (Object)    │  │  (Object)    │  │  (Object)  │ │ │
│  │  │  Metadata    │  │  Metadata    │  │  Metadata  │ │ │
│  │  └──────────────┘  └──────────────┘  └────────────┘ │ │
│  └────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────┘
```

### Características Principais

- **Durabilidade**: 99,999999999% (11 noves) — dados são replicados automaticamente em múltiplas AZs
- **Disponibilidade**: 99,99% (Standard), 99,9% (Intelligent-Tiering, One Zone-IA)
- **Escalabilidade**: Ilimitada — você pode armazenar qualquer quantidade de dados
- **Classes de Armazenamento**: Standard, Intelligent-Tiering, Standard-IA, One Zone-IA, Glacier, Glacier Deep Archive
- **Acesso**: Via API, console, CLI ou como website estático
- **Segurança**: Criptografia em repouso (SSE), compartilhamento via políticas, versionamento

### Classes de Armazenamento do S3

| Classe | Uso | Durabilidade | Disponibilidade | Custo (relativo) |
|--------|-----|-------------|-----------------|-----------------|
| **Standard** | Acesso frequente | 11 noves | 99,99% | Alto |
| **Intelligent-Tiering** | Acesso variado | 11 noves | 99,9% | Médio |
| **Standard-IA** | Acesso infrequente | 11 noves | 99,9% | Baixo |
| **One Zone-IA** | Acesso infrequente (uma AZ) | 99,99% | 99,9% | Mais baixo |
| **Glacier** | Arquivamento | 11 noves | 99,99% | Muito baixo |
| **Glacier Deep Archive** | Arquivamento longo prazo | 11 noves | 99,99% | Mais baixo ainda |

## Amazon EBS (Block Storage)

O **Amazon EBS (Elastic Block Store)** fornece **volumes de armazenamento em bloco** que podem ser anexados a instâncias EC2. Os volumes são **persistentes** — mesmo quando a instância é parada ou terminada, os dados nos volumes EBS permanecem.

### Tipos de Volume EBS

| Tipo | Tecnologia | Uso | IOPS Máx | Throughput Máx |
|------|------------|-----|----------|----------------|
| **gp3** | SSD | Geral (default) | 16.000 | 1.000 MB/s |
| **gp2** | SSD | Geral (legado) | 16.000 | 250 MB/s |
| **io1** | SSD | Provisioned IOPS | 64.000 | 1.000 MB/s |
| **io2** | SSD | Provisioned IOPS (alta disponibilidade) | 64.000 | 1.000 MB/s |
| **st1** | HDD | Throughput otimizado | 500 | 500 MB/s |
| **sc1** | HDD | Cold (acesso raro) | 250 | 250 MB/s |

### Características Principais

- **Persistência**: Dados sobrevivem à parada/terminação da instância
- **Snapshots**: Cópias incrementais armazenadas no S3
- **Criptografia**: Transparente via AWS KMS
- **Escalabilidade**: De 1 GB a 64 TB
- **Redimensionamento**: Online (sem interrupção)

## Amazon EFS (File Storage)

O **Amazon EFS (Elastic File System)** é um **sistema de arquivos compatível com NFS** que permite acesso simultâneo de múltiplas instâncias EC2. É **escalável automaticamente** e **totalmente gerenciado**.

### Características Principais

- **Protocolo**: NFS v4.1
- **Escalabilidade**: Automática, de 1 KB a 100 TB (sem limite prático)
- **Performance**: Geral, Max I/O, Fast Snapshot Restore
- **Throughput**: Escalável automaticamente
- **Durabilidade**: 3 nines (99,9%)
- **Uso**: Compartilhamento de arquivos entre instâncias, CMS, processamento de dados

## EC2 Instance Store (Ephemeral Storage)

O **EC2 Instance Store** fornece armazenamento em bloco **ephemeral** (temporário) conectado fisicamente ao host da instância. O armazenamento está disponível como dispositivos de bloco que o sistema operacional pode montar.

### Características Principais

- **Alta Performance**: NVMe SSD ou HDD diretamente conectado ao host
- **Não Persistente**: Dados são perdidos ao parar/terminar a instância
- **Fixo ao Tipo de Instância**: Tamanho e número determinados pelo tipo de instância
- **Não Redimensionável**: Não pode ser modificado após o lançamento
- **Não Pode ser Desanexado**: Vinculado à instância que a criou

### Tipos de Instância com Instance Store

| Família | Tipo de Armazenamento | Uso |
|---------|----------------------|-----|
| **i3/i3en** | NVMe SSD | Bancos de dados, data warehouses, cache |
| **im4gn** | NVMe SSD (ARM) | Bancos de dados, alta performance |
| **d3/d3en** | HDD | Data warehouses, processamento em lote |
| **p3/p4** | NVMe SSD | Machine Learning, renderização |

## AWS Storage Gateway (Hybrid Storage)

O **AWS Storage Gateway** conecta ambientes on-premises aos serviços de armazenamento da AWS via protocols padrão (NFS, SMB, iSCSI). É uma solução **híbrida** que permite acesso aos serviços da AWS sem reescrever aplicações.

### Tipos de Gateway

| Tipo | Protocolo | Uso |
|------|-----------|-----|
| **File Gateway** | NFS, SMB | Compartilhamento de arquivos via S3 |
| **Volume Gateway** | iSCSI | Volumes EBS para backup via S3 |
| **Tape Gateway** | iSCSI | Fitas virtuais para backup via S3 Glacier |

## Comparação dos Tipos de Armazenamento

| Critério | S3 | EBS | EFS | Instance Store | Storage Gateway |
|----------|----|-----|-----|----------------|-----------------|
| **Tipo** | Object | Block | File | Block | Hybrid |
| **Persistência** | Permanente | Permanente | Permanente | Temporário | Permanente |
| **Escalabilidade** | Ilimitada | Até 64 TB | Ilimitada | Fixo | Depende do gateway |
| **Compartilhamento** | Sim | Não | Sim | Não | Sim |
| **Durabilidade** | 11 noves | 3 nines | 3 nines | N/A | 11 noves (S3) |
| **Latência** | ms | sub-ms | ms | sub-ms | Depende |
| **Custo (por GB)** | Baixo | Médio | Alto | Incluso | Médio |
| **Caso ideal** | Arquivos, backups | Disco EC2 | Compartilhamento | Cache temporário | On-premises |

## Conceitos Chave

- **Object vs. Block vs. File**:
  - **Object (S3)**: Dados armazenados como objetos com metadados. Ideal para arquivos, backups, websites estáticos.
  - **Block (EBS)**: Discos virtualizados. Ideal para sistemas operacionais, bancos de dados, aplicações que precisam de sistemas de arquivos.
  - **File (EFS)**: Sistema de arquivos compartilhado via NFS. Ideal para compartilhamento entre instâncias.

- **Persistência**: S3, EBS, EFS e Storage Gateway são persistentes. Instance Store não é persistente.

- **Escalabilidade**: S3 e EFS são escaláveis automaticamente. EBS tem limite de tamanho. Instance Store é fixo.

- **Durabilidade**: S3 oferece 11 noves de durabilidade. EBS, EFS e Storage Gateway oferecem 3 nines.

- **Custo**: S3 é o mais barato por GB. Instance Store é incluso no preço da instância. EBS e EFS têm custos por GB e IOPS.

## Casos de Uso

- **Website Estático**: Um blog ou site corporativo é hospedado no S3 com CloudFront (CDN), oferecendo 11 noves de durabilidade e custos próximos de zero.

- **Banco de Dados**: Um banco de dados PostgreSQL roda em uma instância EC2 com volumes EBS io2 (provisioned IOPS) para latência consistente e snapshots para backup.

- **Compartilhamento de Arquivos**: Múltiplas instâncias EC2 acessam arquivos simultaneamente via Amazon EFS, com escalabilidade automática.

- **Cache Temporário**: Uma aplicação de processamento usa Instance Store como cache temporário para arquivos intermediários, com resultados finais salvos no S3.

- **Integração On-Premises**: Uma empresa usa AWS Storage Gateway para conectar seu data center local aos serviços de armazenamento da AWS, usando protocols padrão (NFS, SMB, iSCSI).

## Links Oficiais

- [AWS Storage Services](https://docs.aws.amazon.com/whitepapers/latest/aws-overview/storage-services.html)
- [Amazon S3 User Guide](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html)
- [Amazon EBS](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AmazonEBS.html)
- [Amazon EFS](https://docs.aws.amazon.com/efs/latest/ug/what-is.html)
- [AWS Storage Gateway](https://docs.aws.amazon.com/storage-gateway/latest/userguide/what-is-storage-gateway.html)
