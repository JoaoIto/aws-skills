# Amazon VPC Routing

## Visão Geral

O **roteamento na VPC** determina como o tráfego de rede flui entre os diferentes componentes da rede virtual e para fora da VPC. As **tabelas de rotas** (route tables) definem as regras que controlam para onde o tráfego é direcionado, com base no endereço de destino (CIDR).

Cada sub-rede na VPC deve estar associada a uma tabela de rotas. A AWS fornece uma **tabela de rotas principal** (main route table) por padrão, mas você pode criar tabelas de rotas adicionais para controlar o tráfego de sub-redes específicas.

## Como o Roteamento Funciona

```
┌─────────────────────────────────────────────────────────────┐
│                    VPC (10.0.0.0/16)                        │
│                                                             │
│  ┌───────────────┐    ┌───────────────┐    ┌───────────────┐ │
│  │  Public AZ-a  │    │  Public AZ-b  │    │  Public AZ-c  │ │
│  │  (10.0.1.0/24)│    │  (10.0.2.0/24)│    │  (10.0.3.0/24)│ │
│  │  Route:       │    │  Route:       │    │  Route:       │ │
│  │  0.0.0.0/0→IGW│    │  0.0.0.0/0→IGW│    │  0.0.0.0/0→IGW│ │
│  └───────────────┘    └───────────────┘    └───────────────┘ │
│                                                             │
│  ┌───────────────┐    ┌───────────────┐    ┌───────────────┐ │
│  │ Private App AZ-a│  │ Private App AZ-b│  │ Private App AZ-c│ │
│  │ (10.0.10.0/24) │    │ (10.0.11.0/24) │    │ (10.0.12.0/24) │ │
│  │  Route:       │    │  Route:       │    │  Route:       │ │
│  │  0.0.0.0/0→NAT│    │  0.0.0.0/0→NAT│    │  0.0.0.0/0→NAT│ │
│  └───────────────┘    └───────────────┘    └───────────────┘ │
│                                                             │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │  Internet Gateway (IGW)                                  │ │
│  └─────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

## Componentes de Roteamento

| Componente | Função | Observação |
|-----------|--------|------------|
| **Route Table** | Define rotas para sub-redes | Cada sub-rede tem uma tabela associada |
| **Route** | Regra de roteamento (destino → alvo) | CIDR de destino + alvo (IGW, NAT, etc.) |
| **Internet Gateway** | Rota para internet | Alvo: `igw-xxx` |
| **NAT Gateway** | Rota para internet (sub-redes privadas) | Alvo: `nat-xxx` |
| **Virtual Private Gateway** | Rota para VPN/Direct Connect | Alvo: `vgw-xxx` |
| **Peering Connection** | Rota para outra VPC | Alvo: `pcx-xxx` |
| **VPC Endpoint** | Rota para serviços AWS | Alvo: `vpce-xxx` |
| **Transit Gateway** | Rota para múltiplas VPCs | Alvo: `tgw-xxx` |

## Conceitos Chave

- **Route Tables**: Cada VPC tem uma **tabela de rotas principal** (main route table). Você pode criar tabelas de rotas adicionais e associá-las a sub-redes específicas. Cada sub-rede pode estar associada a apenas **uma** tabela de rotas (exceto a tabela principal, que é a associada por padrão).

- **Longest Prefix Match**: Rotas são avaliadas na ordem de **prefixo mais específico** (longest prefix match). Por exemplo, se uma tabela de rotas tem `10.0.0.0/16 → local` e `0.0.0.0/0 → igw-xxx`, o tráfego para `10.0.1.5` seguirá a rota mais específica (`/16`), enquanto o tráfego para `203.0.113.1` seguirá a rota menos específica (`/0`).

- **Rotas Locais**: A VPC cria automaticamente uma rota local para o próprio CIDR da VPC (ex: `10.0.0.0/16 → local`). Esta rota permite que recursos dentro da VPC se comuniquem entre si. **Não pode ser removida**.

- **Rotas para Internet**: Para permitir acesso à internet, adicione uma rota `0.0.0.0/0 → igw-xxx` (Internet Gateway) para sub-redes públicas, ou `0.0.0.0/0 → nat-xxx` (NAT Gateway) para sub-redes privadas.

- **NAT Gateway**: Fornece acesso à internet para recursos em sub-redes privadas, mas **não permite conexões de entrada** da internet. O NAT Gateway deve estar em uma sub-rede pública e requer um Elastic IP. Cada AZ deve ter seu próprio NAT Gateway para alta disponibilidade.

- **VPC Peering**: Permite o tráfego privado entre duas VPCs. Para configurar, adicione uma rota na tabela de rotas de cada VPC apontando para a conexão de peering (`pcx-xxx`). **Importante**: Não é possível ter rotas sobrepostas (CIDR) entre VPCs conectadas por peering.

- **VPC Endpoints**: Permite que recursos na VPC acessem serviços da AWS (S3, DynamoDB) sem atravessar a internet. O endpoint adiciona uma rota na tabela de rotas apontando para o endpoint (`vpce-xxx`).

- **Transit Gateway**: Um hub central que conecta múltiplas VPCs e conexões on-premises. Simplifica a topologia de rede, eliminando a necessidade de múltiplas conexões de peering entre VPCs.

- **Route Propagation**: Quando você configura um Virtual Private Gateway (VGW) para VPN, as rotas são **propagadas automaticamente** para as tabelas de rotas associadas. Isso permite que recursos na VPC acessem a rede on-premises sem configurar rotas manualmente.

## Tabela de Rotas para Sub-redes Públicas

| Destination | Target | Descrição |
|-------------|--------|-----------|
| `10.0.0.0/16` | `local` | Tráfego dentro da VPC (automático) |
| `0.0.0.0/0` | `igw-xxx` | Todo tráfego para a internet |

## Tabela de Rotas para Sub-redes Privadas

| Destination | Target | Descrição |
|-------------|--------|-----------|
| `10.0.0.0/16` | `local` | Tráfego dentro da VPC (automático) |
| `0.0.0.0/0` | `nat-xxx` | Todo tráfego para a internet via NAT |

## Tabela de Rotas para Sub-redes Isoladas (sem internet)

| Destination | Target | Descrição |
|-------------|--------|-----------|
| `10.0.0.0/16` | `local` | Tráfego dentro da VPC (automático) |
| `pl-xxx` | `vpce-xxx` | Acesso a serviços AWS via endpoint |

## Casos de Uso

- **Aplicação Web de 3 Camadas**: Sub-redes públicas (ALB) têm rota `0.0.0.0/0 → IGW`. Sub-redes privadas (app) têm rota `0.0.0.0/0 → NAT Gateway`. Sub-redes de banco de dados (isoladas) não têm rota para internet, apenas acesso local e via VPC endpoint para S3.

- **Ambiente Isolado para Processamento**: Uma VPC sem IGW ou NAT Gateway. Sub-redes têm apenas a rota local e VPC endpoints para S3 e DynamoDB. Recursos podem processar dados sem acesso à internet.

- **Conexão Híbrida**: Uma VPC conectada ao data center via VPN. Rotas são propagadas automaticamente do VGW, permitindo que recursos na VPC acessem servidores locais e vice-versa.

- **Multi-Account com Peering**: Duas VPCs em contas diferentes são conectadas via VPC Peering. Cada VPC tem uma rota para o CIDR da outra VPC apontando para a conexão de peering (`pcx-xxx`).

## Links Oficiais

- [Route Tables](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html)
- [Internet Gateway](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Internet_Gateway.html)
- [NAT Gateway](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway.html)
- [VPC Peering](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-peering.html)
- [VPC Endpoints](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-endpoints.html)
- [Transit Gateway](https://docs.aws.amazon.com/vpc/latest/userguide/transit-gateway.html)
