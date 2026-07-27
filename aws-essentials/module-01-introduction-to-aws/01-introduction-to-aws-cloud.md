# Introduction to AWS Cloud

## Visão Geral

A **Amazon Web Services (AWS)** é a nuvem computacional mais abrangente e amplamente utilizada do mundo, oferecendo uma vasta gama de serviços — desde computação, armazenamento e bancos de dados até inteligência artificial, IoT e serviços de migração — distribuídos em **regiões** e **zonas de disponibilidade (AZs)** em mais de 80 países.

A nuvem AWS transforma o modelo tradicional de TI — onde as empresas precisam comprar, instalar e manter servidores físicos — em um modelo **elástico, sob demanda e pay-as-you-go**. Em vez de investimentos capex (capex), as organizações passam a operar com **opex**, pagando apenas pelo que utilizam.

### Conceitos Fundamentais

| Conceito | Definição | Exemplo na AWS |
|----------|-----------|----------------|
| **Computação em Nuvem** | Fornecimento de recursos computacionais (servidores, armazenamento, bancos de dados, etc.) como serviço sob demanda | Amazon EC2, Amazon S3 |
| **Elasticidade** | Capacidade de escalar recursos para cima ou para baixo automaticamente conforme a demanda | Auto Scaling, Lambda |
| **Alta Disponibilidade** | Projeto para tolerar falhas de zona ou região | Multi-AZ, Load Balancer |
| **Durabilidade** | Probabilidade de um objeto sobreviver a corrupção ou perda | S3: 99,999999999% (11 noves) |
| **Resiliência** | Capacidade de se recuperar de falhas e atender à capacidade projetada | Recovery Point Objective (RPO), Recovery Time Objective (RTO) |

## Conceitos Chave

- **Regiões da AWS**: Cada região é um conjunto isolado de zonas de disponibilidade conectadas por baixa latência. Exemplos: `us-east-1` (Norte da Virgínia), `sa-east-1` (São Paulo). As regiões são independentes e mantêm cópias de segurança entre si.

- **Zonas de Disponibilidade (AZs)**: Cada região contém múltiplas AZs (geralmente 2-6), que são data centers físicos separados com energia, resfriamento e rede redundantes. Recomenda-se distribuir workloads em pelo menos 2 AZs para alta disponibilidade.

- **Edge Locations**: Pontos de presença usados pelo Amazon CloudFront (CDN) e Route 53 para entregar conteúdo com baixa latência. Não são regiões completas — apenas caches e serviços de borda.

- **Shared Responsibility Model**: Modelo de divisão de responsabilidades entre AWS e o cliente. A **AWS é responsável pela segurança DA nuvem** (infraestrutura física, hypervisor, regiões, zonas); o **cliente é responsável pela segurança NA nuvem** (dados, identidade, configurações de segurança, redes).

- **Pricing Models**: A AWS oferece diversos modelos de preços:
  - **Pay-as-you-go**: Pague apenas pelo que consome (EC2 por hora/segundo).
  - **Reserved Instances**: Descontos de até 75% em troca de compromisso de 1-3 anos.
  - **Spot Instances**: Instâncias sobressalentes com descontos de até 90%, mas podem ser interrompidas.
  - **Savings Plans**: Compromisso de gasto por hora em troca de descontos (mais flexível que Reserved Instances).

- **AWS Free Tier**: Inclui 750 horas/mês de EC2 t2.micro ou t3.micro por 12 meses, 5 GB de armazenamento S3, 25 GB de DynamoDB, entre outros. Ideal para experimentação e aprendizado.

## Casos de Uso

- **Migratória de Data Center**: Empresas migram servidores físicos para EC2, reduzindo custos de manutenção e ganhando elasticidade. Exemplo: uma empresa move seu ERP para instâncias EC2 com Auto Scaling.

- **Hospedagem de Websites**: Um blog ou site estático pode ser hospedado em S3 + CloudFront (CDN) com custos próximos de zero, ou uma aplicação dinâmica em EC2/ECS por trás de um Application Load Balancer.

- **Backup e Arquivamento**: Dados críticos são armazenados em S3 com políticas de ciclo de vida (lifecycle) que movem automaticamente para S3 Glacier após 90 dias, reduzindo custos de armazenamento.

- **Processamento de Dados em Lote**: Jobs de processamento noturno (ETL) são executados em instâncias Spot, reduzindo custos de até 90% em comparação com instâncias sob demanda.

## Links Oficiais

- [AWS Cloud Concepts](https://docs.aws.amazon.com/whitepapers/latest/aws-overview/introduction-to-amazon-web-services.html)
- [AWS Global Infrastructure](https://docs.aws.amazon.com/whitepapers/latest/aws-overview/aws-global-infrastructure.html)
