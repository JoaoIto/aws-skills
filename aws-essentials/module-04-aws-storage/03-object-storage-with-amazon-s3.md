# Object Storage with Amazon S3

## Visão Geral

O **Amazon S3 (Simple Storage Service)** é um serviço de **armazenamento de objetos** totalmente gerenciado que oferece **11 nines de durabilidade** (99,999999999%). Os dados são armazenados como **objetos** dentro de **buckets**, cada um com um ID único, metadados e o próprio conteúdo.

O S3 é ideal para armazenar **arquivos** (imagens, vídeos, documentos), **backups**, **websites estáticos**, **data lakes** e **arquivamento**. Ele oferece **classes de armazenamento** diferentes para otimizar custos baseado no padrão de acesso aos dados.

## Arquitetura do S3

```
┌─────────────────────────────────────────────────────────┐
│                    Amazon S3                            │
│                                                         │
│  ┌────────────────────────────────────────────────────┐ │
│  │  Bucket: employee-directory-assets                 │ │
│  │  (Region: sa-east-1)                               │ │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────┐ │ │
│  │  │  photo.jpg   │  │  resume.pdf  │  │  data.csv│ │ │
│  │  │  (Object)    │  │  (Object)    │  │  (Object)│ │ │
│  │  │  Key:        │  │  Key:        │  │  Key:    │ │ │
│  │  │  photos/1   │  │  docs/resume │  │  data/2  │ │ │
│  │  │  .jpg        │  │  .pdf        │  │  023.csv │ │ │
│  │  │  Metadata    │  │  Metadata    │  │  Meta... │ │ │
│  │  └──────────────┘  └──────────────┘  └──────────┘ │ │
│  └────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────┘
```

## Componentes Principais

| Componente | Descrição | Detalhes |
|-----------|-----------|----------|
| **Bucket** | Contêiner de nível superior para objetos | Nome único globalmente, regional |
| **Object** | Dado individual (arquivo + metadados) | Key, Value, Version ID, Metadata |
| **Key** | Nome/identificador do objeto dentro do bucket | Único por bucket |
| **Region** | Região onde o bucket está localizado | Afeta latência e custo |
| **Subresource** | Recursos adicionais (ACL, CORS, etc.) | Configurações avançadas |

## Classes de Armazenamento do S3

| Classe | Uso | Durabilidade | Disponibilidade | Custo (relativo) | Recuperação |
|--------|-----|-------------|-----------------|-----------------|-------------|
| **Standard** | Acesso frequente | 11 noves | 99,99% | Alto | Imediata |
| **Intelligent-Tiering** | Acesso variado | 11 noves | 99,9% | Médio | Imediata |
| **Standard-IA** | Acesso infrequente | 11 noves | 99,9% | Baixo | Imediata |
| **One Zone-IA** | Acesso infrequente (uma AZ) | 99,99% | 99,9% | Mais baixo | Imediata |
| **Glacier** | Arquivamento | 11 noves | 99,99% | Muito baixo | 3-5 horas |
| **Glacier Deep Archive** | Arquivamento longo prazo | 11 noves | 99,99% | Mais baixo ainda | 12 horas |

## Conceitos Chave

- **Buckets**: Um bucket é um contêiner de nível superior para objetos no S3. Os nomes de buckets devem ser **únicos globalmente** (em todas as contas e regiões da AWS). Você pode ter até 100 buckets por conta (limite expansível). Buckets podem ser configurados como **públicos** ou **privados** via políticas.

- **Objects**: Um objeto é o dado armazenado no S3, composto por **chave (key)**, **valor (value)** e **metadados**. A chave é o nome do objeto dentro do bucket. O valor é o conteúdo do arquivo. Metadados são informações adicionais (tipo de conteúdo, data de modificação, etc.).

- **Versioning**: Quando habilitado, o S3 preserva, recupera e lista automaticamente todas as versões de cada objeto em um bucket. Isso protege contra exclusões acidentais e permite rollback. Cada versão tem um **Version ID** único.

- **Lifecycle Policies**: Políticas que automatizam a transição de objetos entre classes de armazenamento e a exclusão após um período específico. Por exemplo: mover objetos do Standard para Standard-IA após 30 dias, e para Glacier após 90 dias.

- **Static Website Hosting**: O S3 pode servir como **website estático**, fornecendo arquivos HTML, CSS, JS e imagens diretamente do bucket. Requer que o bucket seja configurado como público e tenha a função de website estática habilitada.

- **CORS (Cross-Origin Resource Sharing)**: Configuração que permite que recursos em um bucket S3 sejam acessados de domínios diferentes. Útil para aplicações web que carregam arquivos diretamente do S3.

- **Server Access Logging**: Quando habilitado, o S3 registra detalhes sobre as requisições feitas a um bucket. Os logs são armazenados em outro bucket S3 e podem ser analisados para auditoria, segurança e otimização de custos.

- **Event Notifications**: O S3 pode enviar notificações para o **Amazon SNS**, **Amazon SQS** ou **AWS Lambda** quando eventos específicos ocorrem (ex: novo objeto criado, objeto excluído). Útil para processamento de eventos.

- **Transfer Acceleration**: Usa a rede de borda da AWS (CloudFront) para acelerar uploads para o S3. Os dados são enviados para um endpoint de borda mais próximo, que encaminha para o bucket S3.

- **S3 Select**: Permite que você use SQL para extrair dados específicos de um objeto (CSV, JSON, Parquet) sem precisar baixar o arquivo completo. Reduz o volume de dados transferidos e o tempo de processamento.

## Segurança no S3

| Mecanismo | Descrição |
|-----------|-----------|
| **Bucket Policies** | Políticas JSON que controlam acesso a nível de bucket |
| **ACLs (Access Control Lists)** | Controle de acesso por usuário/conta (legado) |
| **IAM Policies** | Políticas que controlam acesso via IAM |
| **Criptografia em Repouso** | SSE-S3, SSE-KMS, SSE-C |
| **Criptografia em Trânsito** | HTTPS/TLS para transferência de dados |
| **VPC Endpoints** | Acesso ao S3 via VPC (sem internet) |
| **Block Public Access** | Bloqueio de acesso público no nível de conta/bucket |

## Criptografia no S3

| Tipo | Descrição | Chave Gerenciada Por |
|------|-----------|---------------------|
| **SSE-S3** | Criptografia gerenciada pelo S3 | AWS (chave padrão do S3) |
| **SSE-KMS** | Criptografia via AWS KMS | AWS KMS (chave gerenciada ou personalizada) |
| **SSE-C** | Criptografia com chave fornecida pelo cliente | Cliente (você fornece a chave) |
| **CSE** | Criptografia do lado do cliente | Cliente (criptografa antes do upload) |

## Casos de Uso

- **Website Estático**: Um blog ou site corporativo é hospedado no S3 com CloudFront (CDN), oferecendo 11 noves de durabilidade e custos próximos de zero. O bucket é configurado como website estático e os arquivos são servidos diretamente do S3.

- **Data Lake**: Uma empresa armazena seus dados brutos (logs, transações, arquivos) em um bucket S3, organizados por pastas. Os dados são processados posteriormente por serviços como Athena, EMR ou Redshift Spectrum.

- **Backup e Arquivamento**: Dados críticos são armazenados no S3 Standard com lifecycle policies que movem automaticamente para S3 Glacier após 90 dias, reduzindo custos de armazenamento em 70%.

- **Processamento de Mídia**: Arquivos de vídeo são enviados ao S3, acionando uma função Lambda que inicia um job no MediaConvert para transcodificação. Os arquivos processados são salvos de volta ao S3.

- **Distribuição de Software**: Um software empresa usa o S3 para distribuir pacotes de instalação, com versões organizadas por pastas e acesso controlado via políticas de bucket.

## Links Oficiais

- [Amazon S3 User Guide](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html)
- [S3 Storage Classes](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage-class-intro.html)
- [S3 Lifecycle Policies](https://docs.aws.amazon.com/AmazonS3/latest/userguide/lifecycle-configuration-examples.html)
- [S3 Security Best Practices](https://docs.aws.amazon.com/AmazonS3/latest/userguide/security-best-practices.html)
