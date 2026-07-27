# Introduction to Amazon Virtual Private Cloud (Amazon VPC)

## Visão Geral

O **Amazon Virtual Private Cloud (VPC)** é um serviço que permite provisionar um **ambiente de rede virtual isolado** na nuvem AWS. Dentro de uma VPC, você tem controle total sobre o espaço de endereços IP, sub-redes, tabelas de rotas, gateways e configurações de segurança.

Uma VPC é **regional** — ela abrange todas as zonas de disponibilidade (AZs) de uma região, mas não se estende a outras regiões. Recursos em diferentes AZs da mesma VPC podem se comunicar com baixa latência.

## Componentes Principais de uma VPC

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

- **CIDR (Classless Inter-Domain Routing)**: O bloco de endereços IP da VPC é definido em notação CIDR. Exemplos:
  - `10.0.0.0/16` → 65.536 endereços (recomendado para produção)
  - `172.31.0.0/16` → 65.536 endereços (padrão da VPC default)
  - `192.168.0.0/16` → 65.536 endereços
  - O tamanho mínimo é `/28` (16 endereços) e o máximo é `/16` (65.536 endereços).

- **Sub-redes Públicas vs. Privadas**:
  - **Pública**: A tabela de rotas tem uma rota para o Internet Gateway (`0.0.0.0/0 → igw-xxx`). Recursos nessa sub-rede recebem IPs públicos (ou EIPs) e são acessíveis da internet.
  - **Privada**: A tabela de rotas **não** tem rota para o IGW. Recursos nessa sub-rede não recebem IPs públicos e não são diretamente acessíveis da internet. Acesso à internet via NAT Gateway.

- **Endereçamento IP**:
  - **IPv4**: Cada VPC e sub-rede tem um bloco IPv4. Instâncias recebem IPs privados (dentro do CIDR da sub-rede) e, opcionalmente, IPs públicos (se a sub-rede for pública).
  - **IPv6**: A AWS suporta IPv6. Você pode associar um bloco IPv6 (`/56`) à VPC e sub-redes. O IGW também fornece rota para IPv6.

- **Tabelas de Rotas**:
  - Cada VPC tem uma **tabela de rotas principal** (main route table).
  - Você pode criar tabelas de rotas adicionais e associá-las a sub-redes específicas.
  - Rotas são avaliadas na ordem de **prefixo mais específico** (longest prefix match).
  - Exemplo de rota: `0.0.0.0/0 → igw-xxx` (todo tráfego para a internet).

- **Security Groups (Stateful)**:
  - Atuam como firewalls virtuais no nível de instância.
  - **Stateful**: Se você permite entrada em uma porta, a saída correspondente é automaticamente permitida.
  - Regras de **inbound** e **outbound** são independentes, mas o estado é compartilhado.
  - Um Security Group pode referenciar outro Security Group como origem (ex: permitir acesso de instâncias em um SG específico).

- **Network ACLs (Stateless)**:
  - Atuam como firewalls no nível de sub-rede.
  - **Stateless**: Regras de entrada e saída são independentes. Se você permite entrada, precisa explicitamente permitir a saída.
  - Avaliadas em ordem numérica (números ímpares para regras, pares para NACLs).
  - Uma NACL pode ter regras **allow** e **deny**. A regra **deny** sempre vence.

- **NAT Gateway**:
  - Fornece acesso à internet para recursos em sub-redes privadas (para downloads, APIs externas).
  - **Não permite conexões de entrada** da internet para recursos privados.
  - Deve estar em uma sub-rede pública e requer um Elastic IP.
  - É gerenciado pela AWS (alta disponibilidade, escalabilidade automática).
  - Cada AZ deve ter seu próprio NAT Gateway para alta disponibilidade.

- **VPC Flow Logs**:
  - Capturam metadados de tráfego de rede (IP origem/destino, portas, protocolo, bytes, aceito/recusado).
  - Podem ser enviados para CloudWatch Logs ou S3 para análise, auditoria e troubleshooting.
  - Úteis para detectar anomalias de tráfego e investigar incidentes de segurança.

## Diagrama de Arquitetura Recomendada

```
┌─────────────────────────────────────────────────────────────┐
│                    VPC (10.0.0.0/16)                        │
│                                                             │
│  ┌───────────────┐    ┌───────────────┐    ┌───────────────┐ │
│  │  Public AZ-a  │    │  Public AZ-b  │    │  Public AZ-c  │ │
│  │  (10.0.1.0/24)│    │  (10.0.2.0/24)│    │  (10.0.3.0/24)│ │
│  │  NAT Gateway  │    │  NAT Gateway  │    │  NAT Gateway  │ │
│  └───────────────┘    └───────────────┘    └───────────────┘ │
│                                                             │
│  ┌───────────────┐    ┌───────────────┐    ┌───────────────┐ │
│  │ Private App AZ-a│  │ Private App AZ-b│  │ Private App AZ-c│ │
│  │ (10.0.10.0/24) │    │ (10.0.11.0/24) │    │ (10.0.12.0/24) │ │
│  │  EC2, ECS      │    │  EC2, ECS      │    │  EC2, ECS      │ │
│  └───────────────┘    └───────────────┘    └───────────────┘ │
│                                                             │
│  ┌───────────────┐    ┌───────────────┐    ┌───────────────┐ │
│  │ Private DB AZ-a│   │ Private DB AZ-b│   │ Private DB AZ-c│  │
│  │ (10.0.20.0/24) │    │ (10.0.21.0/24) │    │ (10.0.22.0/24) │ │
│  │  RDS, DynamoDB │    │  RDS, DynamoDB │    │  RDS, DynamoDB │ │
│  └───────────────┘    └───────────────┘    └───────────────┘ │
│                                                             │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │  Internet Gateway (IGW)                                  │ │
│  └─────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

## Casos de Uso

- **Aplicação Web de 3 Camadas**: Uma VPC com sub-redes públicas (Load Balancer), sub-redes privadas (aplicação) e sub-redes de banco de dados (isoladas). O acesso à internet é via IGW para a camada pública e NAT Gateway para as camadas privadas.

- **Ambiente Isolado para Processamento**: Uma VPC sem acesso à internet (isolada) onde jobs de processamento acessam dados via VPC endpoints (S3, DynamoDB) sem expor o tráfego à internet.

- **Conexão Híbrida**: Uma empresa conecta seu data center local à VPC via túnel VPN (VGW + Customer Gateway), permitindo que servidores locais acessem recursos na VPC como se estivessem na mesma rede.

- **Multi-Account com Peering**: Uma empresa com múltiplas contas AWS usa VPC Peering para conectar VPCs entre contas, permitindo compartilhamento de recursos (ex: banco de dados central) sem expor à internet.

## Links Oficiais

- [Amazon VPC User Guide](https://docs.aws.amazon.com/vpc/latest/userguide/vpc.html)
- [VPC Components](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-components.html)
