# Networking in AWS

## Visão Geral

A **Amazon Virtual Private Cloud (VPC)** é o serviço de rede da AWS que permite provisionar um **ambiente de rede virtual isolado** na nuvem. Dentro de uma VPC, você tem controle total sobre o espaço de endereços IP, sub-redes, tabelas de rotas, gateways e configurações de segurança.

A rede AWS é organizada em **regiões** e **zonas de disponibilidade (AZs)**. Cada região é um conjunto isolado de AZs conectadas por baixa latência. Uma VPC abrange todas as AZs de uma região, permitindo que recursos em diferentes AZs se comuniquem com baixa latência.

## Arquitetura de Rede da AWS

```
┌─────────────────────────────────────────────────────────────────┐
│                    Região AWS (ex: sa-east-1)                   │
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │                    VPC (10.0.0.0/16)                    │   │
│  │                                                         │   │
│  │  ┌───────────────┐    ┌───────────────┐    ┌──────────┐ │   │
│  │  │  AZ-a         │    │  AZ-b         │    │  AZ-c    │ │   │
│  │  │  Subnet Pública│    │  Subnet Pública│    │  Subnet  │ │   │
│  │  │  (10.0.1.0/24) │    │  (10.0.2.0/24) │    │  Pública │ │   │
│  │  │  ALB, NAT GW   │    │  ALB, NAT GW   │    │  (10.0.3│ │   │
│  │  └───────┬───────┘    └───────┬───────┘    │  .0/24)  │ │   │
│  │          │                    │            └──────────┘ │   │
│  │  ┌───────▼───────┐    ┌───────▼───────┐    ┌──────────┐ │   │
│  │  │  Subnet Privada│    │  Subnet Privada│    │  Subnet  │ │   │
│  │  │  (10.0.10.0/24)│    │  (10.0.11.0/24)│    │  Privada │ │   │
│  │  │  EC2, RDS      │    │  EC2, RDS      │    │  (10.0.1│ │   │
│  │  └───────────────┘    └───────────────┘    │  2.0/24) │ │   │
│  │                                             └──────────┘ │   │
│  │  ┌─────────────────────────────────────────┐            │   │
│  │  │  Internet Gateway (IGW)               │            │   │
│  │  └─────────────────────────────────────────┘            │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │  Edge Locations (CloudFront)                             │   │
│  └─────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘
```

## Componentes Principais

| Componente | Descrição | Características |
|-----------|-----------|-----------------|
| **VPC** | Rede virtual isolada | CIDR bloqueável (16-28 bits), regional |
| **Sub-rede** | Segmento de rede em uma AZ | Pública ou privada |
| **Internet Gateway (IGW)** | Acesso à internet | Horizontalmente escalável, redundante |
| **Route Table** | Define rotas de tráfego | Associada a sub-redes |
| **Security Group** | Firewall stateful | No nível de instância |
| **Network ACL** | Firewall stateless | No nível de sub-rede |
| **Elastic IP** | IP público estático | Pode ser remapeado |
| **NAT Gateway** | Acesso à internet para subnets privadas | Gerenciado, alta disponibilidade |
| **Virtual Private Gateway** | Conexão VPN | Conexão com on-premises |
| **Peering Connection** | Conexão entre VPCs | Tráfego privado |

## Conceitos Chave

- **Regiões e AZs**: Cada região é um conjunto isolado de zonas de disponibilidade conectadas por baixa latência. Exemplos: `us-east-1` (Norte da Virgínia), `sa-east-1` (São Paulo). As regiões são independentes e mantêm cópias de segurança entre si. Cada região contém múltiplas AZs (geralmente 2-6), que são data centers físicos separados com energia, resfriamento e rede redundantes.

- **CIDR (Classless Inter-Domain Routing)**: O bloco de endereços IP da VPC é definido em notação CIDR. Exemplos:
  - `10.0.0.0/16` → 65.536 endereços (recomendado para produção)
  - `172.31.0.0/16` → 65.536 endereços (padrão da VPC default)
  - `192.168.0.0/16` → 65.536 endereços
  - O tamanho mínimo é `/28` (16 endereços) e o máximo é `/16` (65.536 endereços).

- **Sub-redes Públicas vs. Privadas**:
  - **Pública**: A tabela de rotas tem uma rota para o Internet Gateway (`0.0.0.0/0 → igw-xxx`). Recursos nessa sub-rede recebem IPs públicos (ou EIPs) e são acessíveis da internet.
  - **Privada**: A tabela de rotas **não** tem rota para o IGW. Recursos nessa sub-rede não recebem IPs públicos e não são diretamente acessíveis da internet. Acesso à internet via NAT Gateway.

- **Tabelas de Rotas**:
  - Cada VPC tem uma **tabela de rotas principal** (main route table).
  - Você pode criar tabelas de rotas adicionais e associá-las a sub-redes específicas.
  - Rotas são avaliadas na ordem de **prefixo mais específico** (longest prefix match).
  - Exemplo de rota: `0.0.0.0/0 → igw-xxx` (todo tráfego para a internet).

- **Internet Gateway (IGW)**: Ponto de entrada/saída para o tráfego entre a VPC e a internet. É **horizontalmente escalável** e **redundante**. Uma IGW pode ser associada a apenas uma VPC, mas uma VPC pode ter apenas uma IGW.

- **NAT Gateway**: Fornece acesso à internet para recursos em sub-redes privadas (para downloads, APIs externas). **Não permite conexões de entrada** da internet para recursos privados. Deve estar em uma sub-rede pública e requer um Elastic IP. É gerenciado pela AWS (alta disponibilidade, escalabilidade automática). Cada AZ deve ter seu próprio NAT Gateway para alta disponibilidade.

- **VPC Peering**: Conexão entre duas VPCs que permite o tráfego privado entre elas. Funciona em qualquer região, mas VPCs em regiões diferentes têm latência adicional. O tráfego não atravessa a internet pública.

- **VPC Endpoints**: Permitem conectar a VPC a serviços da AWS (como S3, DynamoDB) sem atravessar a internet. Existem dois tipos:
  - **Gateway Endpoints**: Para S3 e DynamoDB (gratuitos)
  - **Interface Endpoints**: Para outros serviços (usam ENIs, cobrados por hora)

## Casos de Uso

- **Aplicação Web de 3 Camadas**: Uma VPC com sub-redes públicas (Load Balancer), sub-redes privadas (aplicação) e sub-redes de banco de dados (isoladas). O acesso à internet é via IGW para a camada pública e NAT Gateway para as camadas privadas.

- **Ambiente Isolado para Processamento**: Uma VPC sem acesso à internet (isolada) onde jobs de processamento acessam dados via VPC endpoints (S3, DynamoDB) sem expor o tráfego à internet.

- **Conexão Híbrida**: Uma empresa conecta seu data center local à VPC via túnel VPN (VGW + Customer Gateway), permitindo que servidores locais acessem recursos na VPC como se estivessem na mesma rede.

- **Multi-Account com Peering**: Uma empresa com múltiplas contas AWS usa VPC Peering para conectar VPCs entre contas, permitindo compartilhamento de recursos (ex: banco de dados central) sem expor à internet.

## Links Oficiais

- [Amazon VPC User Guide](https://docs.aws.amazon.com/vpc/latest/userguide/vpc.html)
- [VPC Components](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-components.html)
- [VPC Peering](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-peering.html)
- [VPC Endpoints](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-endpoints.html)
