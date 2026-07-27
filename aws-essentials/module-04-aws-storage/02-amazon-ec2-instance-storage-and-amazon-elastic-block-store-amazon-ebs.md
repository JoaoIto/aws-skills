# Amazon EC2 Instance Storage and Amazon Elastic Block Store (Amazon EBS)

## Visão Geral

A AWS oferece dois tipos de armazenamento em bloco para instâncias EC2: **Amazon EBS (Elastic Block Store)** e **EC2 Instance Store**. Ambos fornecem discos virtualizados que aparecem como dispositivos de bloco (como discos rígidos) para o sistema operacional, mas diferem em **persistência**, **performance** e **casos de uso**.

| Característica | Amazon EBS | EC2 Instance Store |
|----------------|------------|---------------------|
| **Persistência** | Sim (sobrevive à terminação da instância) | Não (perdida ao parar/terminar) |
| **Performance** | IOPS e throughput configuráveis | Máxima performance do hardware |
| **Escalabilidade** | De 1 GB a 64 TB | Fixo (depende do tipo de instância) |
| **Custo** | Pago por GB e IOPS | Incluído no preço da instância |
| **Caso ideal** | Sistema operacional, dados permanentes | Cache, dados temporários, processamento |

## Amazon EBS (Elastic Block Store)

### Como Funciona

O **Amazon EBS** fornece volumes de armazenamento em bloco que podem ser anexados a instâncias EC2. Os volumes são **persistentes** — mesmo quando a instância é parada ou terminada, os dados nos volumes EBS permanecem. Os volumes são replicados automaticamente dentro da zona de disponibilidade (AZ) para proteger contra falhas de hardware.

```
┌─────────────────┐    Anexa    ┌─────────────────┐
│  Instância EC2  │◄────────────┤  Volume EBS     │
│  (t3.medium)    │             │  (gp3, 100GB)   │
└─────────────────┘             └─────────┬───────┘
                                          │
                                          ▼
                              ┌─────────────────────┐
                              │  Dados persistem    │
                              │  após parada da     │
                              │  instância          │
                              └─────────────────────┘
```

### Tipos de Volume EBS

| Tipo | Tecnologia | Uso | IOPS Máx | Throughput Máx |
|------|------------|-----|----------|----------------|
| **gp3** | SSD | Geral (default) | 16.000 | 1.000 MB/s |
| **gp2** | SSD | Geral (legado) | 16.000 | 250 MB/s |
| **io1** | SSD | Provisioned IOPS | 64.000 | 1.000 MB/s |
| **io2** | SSD | Provisioned IOPS (alta disponibilidade) | 64.000 | 1.000 MB/s |
| **st1** | HDD | Throughput otimizado | 500 | 500 MB/s |
| **sc1** | HDD | Cold (acesso raro) | 250 | 250 MB/s |

### Conceitos Chave

- **gp3 (General Purpose SSD)**: O tipo de volume EBS mais recomendado para a maioria das cargas de trabalho. Oferece:
  - IOPS de provisionamento separado do tamanho do volume
  - IOPS base de 3.000 e throughput de 125 MB/s (sem custo adicional)
  - Pode escalar IOPS até 16.000 e throughput até 1.000 MB/s
  - Ideal para: sistemas operacionais, aplicações, bancos de dados pequenos

- **io1/io2 (Provisioned IOPS SSD)**: Para cargas de trabalho que exigem **latência consistente** e **IOPS altas**:
  - IOPS provisionadas explicitamente (100-64.000)
  - io2 oferece 99,9% de disponibilidade de volume (vs 99,5% do io1)
  - Ideal para: bancos de dados OLTP, sistemas de mensagens, aplicações críticas

- **st1 (Throughput Optimized HDD)**: Para cargas de trabalho que exigem **alta taxa de transferência** (throughput):
  - Baseado em HDD, não SSD
  - Ideal para: processamento de dados em lote, logs, data warehouses
  - Não recomendado para bancos de dados (latência variável)

- **sc1 (Cold HDD)**: Para dados acessados **raramente**:
  - Custo mais baixo por GB
  - Ideal para: backups, arquivamento, dados de longo prazo
  - Não recomendado para cargas de trabalho ativas

- **Snapshots**: Cópias pontuais de volumes EBS. São:
  - **Incrementais**: Apenas blocos alterados desde o último snapshot são salvos
  - **Armazenados no S3**: Pagamento por GB armazenado
  - **Rápidos para restaurar**: Novos volumes são criados a partir de snapshots
  - **Usados para AMI**: Snapshots de volumes raiz são usados para criar AMIs

- **Criptografia EBS**: Volumes EBS podem ser criptografados com chaves do AWS KMS. A criptografia é transparente para o sistema operacional e não afeta significativamente a performance.

## EC2 Instance Store

### Como Funciona

O **EC2 Instance Store** fornece armazenamento em bloco **ephemeral** (temporário) que é conectado fisicamente ao **host** da instância. O armazenamento está disponível como dispositivos de bloco que o sistema operacional pode montar.

```
┌─────────────────┐    Conexão    ┌─────────────────┐
│  Instância EC2  │◄──────────────┤  Instance Store │
│  (i3.xlarge)    │               │  (NVMe SSD)     │
└─────────────────┘               └─────────┬───────┘
                                          │
                                          ▼
                              ┌─────────────────────┐
                              │  Dados perdidos ao  │
                              │  parar/terminar     │
                              │  a instância        │
                              └─────────────────────┘
```

### Características Principais

- **Alta Performance**: Instance Store oferece a **máxima performance** de I/O, especialmente em instâncias otimizadas para armazenamento (i3, i3en, im4gn). Usa NVMe SSD ou HDD diretamente conectado ao host.

- **Não Persistente**: Dados no Instance Store são **perdidos** quando:
  - A instância é **parada** (stop)
  - A instância é **terminada** (terminate)
  - Há uma **falha de hardware** no host
  - A instância é **migrada** para outro host

- **Fixo ao Tipo de Instância**: O tamanho e número de volumes de Instance Store são determinados pelo **tipo de instância**. Por exemplo, uma `i3.xlarge` tem 1 volume NVMe de 475 GB.

- **Não Redimensionável**: Você não pode redimensionar ou modificar volumes de Instance Store após o lançamento da instância.

- **Não Pode ser Desanexado**: Ao contrário de volumes EBS, volumes de Instance Store **não podem ser desanexados** ou reanexados a outras instâncias.

### Tipos de Instância com Instance Store

| Família | Tipo de Armazenamento | Uso |
|---------|----------------------|-----|
| **i3/i3en** | NVMe SSD | Bancos de dados, data warehouses, cache de alta performance |
| **im4gn** | NVMe SSD (ARM) | Bancos de dados, aplicações de alta performance |
| **d3/d3en** | HDD | Data warehouses, processamento de dados em lote |
| **p3/p4** | NVMe SSD | Machine Learning, renderização |

## Comparação: EBS vs. Instance Store

| Critério | EBS | Instance Store |
|----------|-----|----------------|
| **Persistência** | Sim | Não |
| **Performance** | Boa (configurável) | Excelente (máxima do hardware) |
| **Redimensionamento** | Sim (online) | Não |
| **Desanexar/Reanexar** | Sim | Não |
| **Criptografia** | Sim (KMS) | Não |
| **Snapshots** | Sim | Não |
| **Custo** | Pago por GB + IOPS | Incluído no preço da instância |
| **Caso ideal** | Dados permanentes, SO | Cache, dados temporários |

## Casos de Uso

- **Banco de Dados com EBS**: Um banco de dados PostgreSQL roda em uma instância EC2 com volumes EBS io2 (provisioned IOPS) para latência consistente e snapshots para backup.

- **Cache com Instance Store**: Uma aplicação de processamento de dados usa Instance Store como cache temporário para arquivos intermediários, com resultados finais salvos no S3.

- **Data Warehouse com Instance Store**: Um cluster de data warehouse (Redshift ou EMR) usa instâncias com Instance Store para armazenamento local de alta performance durante consultas complexas.

- **Web Server com EBS**: Um servidor web Apache/Nginx roda em uma instância EC2 com volume EBS gp3 para o sistema operacional e arquivos de aplicação, com snapshots para backup.

## Links Oficiais

- [Amazon EBS](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AmazonEBS.html)
- [EC2 Instance Store](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-store.html)
- [EBS Volume Types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSVolumeTypes.html)
