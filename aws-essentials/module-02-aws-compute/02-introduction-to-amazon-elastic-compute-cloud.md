# Introduction to Amazon Elastic Compute Cloud

## Visão Geral

O **Amazon Elastic Compute Cloud (Amazon EC2)** é o serviço de computação em nuvem da AWS que fornece **servidores virtuais (instâncias)** sob demanda. Ele oferece capacidade computacional redimensionável na nuvem, eliminando a necessidade de investimento em hardware físico e permitindo que você escale instâncias conforme a demanda.

O EC2 é o serviço de **Infrastructure as a Service (IaaS)** mais fundamental da AWS. Ele fornece controle total sobre o sistema operacional, armazenamento, rede e configuração da instância, mas exige que você gerencie patches, escalabilidade e alta disponibilidade.

## Componentes Principais do EC2

| Componente | Descrição | Detalhes |
|------------|-----------|----------|
| **Instância (Instance)** | Servidor virtual na nuvem | Executa um sistema operacional e aplicações |
| **AMI (Amazon Machine Image)** | Modelo para a instância | Contém SO, apps e configurações iniciais |
| **Tipo de Instância (Instance Type)** | Especificações de hardware | CPU, memória, armazenamento, rede |
| **Key Pair** | Autenticação SSH | Chave pública/privada para acesso à instância |
| **Security Group** | Firewall virtual | Controla tráfego de entrada e saída |
| **Elastic IP (EIP)** | IP público estático | Endereço fixo que pode ser remapeado |
| **User Data** | Script de inicialização | Executado automaticamente no primeiro boot |

## Conceitos Chave

- **Tipos de Instância**: A AWS oferece dezenas de tipos de instância otimizados para diferentes cargas de trabalho:

  | Família | Uso | Exemplo |
  |---------|-----|---------|
  | **General Purpose** (t3, t4g, m6i) | Equilíbrio entre CPU, memória e rede | t3.micro (Free Tier), m6i.large |
  | **Compute Optimized** (c5, c6i) | Alto desempenho de CPU | Processamento em lote, servidores web |
  | **Memory Optimized** (r5, r6i, x1) | Alto desempenho de memória | Bancos de dados, processamento em memória |
  | **Storage Optimized** (i3, i4i, d3) | Alta taxa de transferência de I/O | Data warehouses, sistemas de arquivos |
  | **Accelerated Computing** (p3, g4, inf1) | GPU e aceleração de hardware | ML, renderização, inferência |

- **Amazon Machine Images (AMIs)**: Uma AMI contém:
  - Um ou mais discos (snapshots) com sistema operacional e aplicações
  - Permissões de acesso (pública, privada ou compartilhada)
  - Configurações de rede e armazenamento
  - A AWS fornece AMIs oficiais para Amazon Linux 2, Ubuntu, Windows Server, etc. Você também pode criar AMIs personalizadas a partir de instâncias existentes.

- **Modelos de Preço do EC2**:
  - **On-Demand**: Pague por segundo (mínimo 1 minuto) sem compromisso. Ideal para cargas imprevisíveis.
  - **Savings Plans**: Compromisso de gasto horário por 1-3 anos. Mais flexível que Reserved Instances.
  - **Reserved Instances**: Descontos de até 75% com compromisso de 1-3 anos.
  - **Spot Instances**: Descontos de até 90% em instâncias sobressalentes. Podem ser interrompidas com aviso de 2 minutos.
  - **Dedicated Hosts**: Servidores físicos dedicados à sua conta. Útil para licenças de software por núcleo.

- **Auto Scaling**: Permite escalar automaticamente o número de instâncias com base em métricas (CPU, memória, etc.). Funciona com **Auto Scaling Groups (ASGs)** que mantêm um número mínimo e máximo de instâncias, distribuídas em múltiplas AZs.

- **Load Balancing**: O **Elastic Load Balancer (ELB)** distribui tráfego entre instâncias. Tipos:
  - **Application Load Balancer (ALB)**: Camada 7 (HTTP/HTTPS), ideal para aplicações web e microserviços.
  - **Network Load Balancer (NLB)**: Camada 4 (TCP/UDP), alta performance e baixa latência.
  - **Gateway Load Balancer (GWLB)**: Distribui appliances de segurança virtual.
  - **Classic Load Balancer (CLB)**: Legado, recomendado apenas para aplicações herdadas.

- **Grupos de Segurança (Security Groups)**: Firewalls stateful no nível de instância. Regras de inbound e outbound definem quais portas/protocolos são permitidos. Diferente de NACLs (firewalls stateless no nível de sub-rede).

## Casos de Uso

- **Hospedagem de Aplicação Web**: Uma aplicação web é implantada em instâncias EC2 por trás de um Application Load Balancer, com Auto Scaling para lidar com picos de tráfego durante promoções.

- **Migração de Data Center**: Servidores físicos são migrados para EC2 usando o AWS Application Migration Service (MGN), mantendo os mesmos sistemas operacionais e configurações.

- **Processamento em Lote**: Jobs de processamento noturno (ETL, renderização) são executados em instâncias Spot, reduzindo custos de até 90% em comparação com On-Demand.

- **Ambiente de Desenvolvimento**: Desenvolvedores usam instâncias t3.micro (Free Tier) para ambientes de desenvolvimento e teste, destruindo-as após o uso para evitar custos.

## Links Oficiais

- [Amazon EC2 User Guide](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html)
- [EC2 Instance Types](https://aws.amazon.com/ec2/instance-types/)
