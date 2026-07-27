# Optimization

## Visão Geral

A **otimização** na AWS envolve ajustar recursos para **minimizar custos**, **maximizar performance** e **garantir eficiência operacional**. A AWS fornece ferramentas e serviços para identificar oportunidades de otimização, desde o uso de instâncias até a arquitetura de aplicações.

## Ferramentas de Otimização

| Ferramenta | Tipo | Uso |
|------------|------|-----|
| **AWS Cost Explorer** | Custos | Análise e visualização de custos |
| **AWS Budgets** | Custos | Alertas de orçamento |
| **AWS Trusted Advisor** | Performance/Custo | Recomendações de otimização |
| **Compute Optimizer** | Performance | Recomendações de instâncias |
| **Savings Plans** | Custos | Descontos para compromisso de gasto |
| **Auto Scaling** | Performance | Escalabilidade automática |

## Conceitos Chave

- **AWS Cost Explorer**: Ferramenta que permite visualizar, analisar e otimizar custos da AWS. Recursos:
  - **Gráficos de custo por serviço**: Identificar quais serviços consomem mais recursos
  - **Análise de tendências**: Comparar custos ao longo do tempo
  - **Previsão de custos**: Estimar custos futuros baseados em padrões históricos
  - **Análise de EC2**: Identificar instâncias subutilizadas

- **AWS Budgets**: Permite definir orçamentos personalizados e receber notificações quando os custos ultrapassam limites. Tipos:
  - **Budget de Custo**: Limite total de gastos
  - **Budget de Uso**: Limite de uso de recursos (ex: horas de EC2)
  - **Budget de RIs**: Limite de Reserved Instances

- **AWS Trusted Advisor**: Ferramenta que fornece recomendações de otimização em 5 pilares:
  - **Custo**: Identificar recursos subutilizados
  - **Performance**: Verificar se recursos estão configurados para performance
  - **Segurança**: Identificar vulnerabilidades de segurança
  - **Fault Tolerance**: Verificar alta disponibilidade
  - **Service Limits**: Alertar sobre limites de serviço

- **AWS Compute Optimizer**: Usa machine learning para recomendar os tipos de instância ideais para cargas de trabalho, com base em padrões de uso histórico.

- **Savings Plans**: Modelo de preço que oferece descontos de até 72% em troca de compromisso de gasto horário por 1-3 anos. Dois tipos:
  - **Compute Savings Plans**: Flexível, aplica-se a EC2, Fargate, Lambda
  - **EC2 Instance Savings Plans**: Específico para tipos de instância, oferece maiores descontos

- **Auto Scaling**: Permite escalar automaticamente o número de instâncias com base em métricas (CPU, memória, etc.). Benefícios:
  - **Economia de custos**: Reduz instâncias quando a demanda é baixa
  - **Alta disponibilidade**: Mantém capacidade durante picos
  - **Performance**: Garante recursos disponíveis quando necessário

- **Right-Sizing**: Processo de selecionar o tipo de instância adequado para a carga de trabalho. Erros comuns:
  - **Over-provisioning**: Instâncias maiores que necessário (gasto excessivo)
  - **Under-provisioning**: Instâncias menores que necessário (performance insuficiente)

## Estratégias de Otimização de Custos

### 1. Otimização de Instâncias EC2

| Estratégia | Descrição | Economia Potencial |
|------------|-----------|-------------------|
| **Right-Sizing** | Reduzir instâncias sobrecarregadas | 10-30% |
| **Reserved Instances** | Compromisso de 1-3 anos | 20-75% |
| **Spot Instances** | Instâncias sobressalentes | 50-90% |
| **Savings Plans** | Compromisso de gasto | 20-72% |
| **Auto Scaling** | Escalar conforme demanda | 20-50% |

### 2. Otimização de Armazenamento

| Estratégia | Descrição | Economia Potencial |
|------------|-----------|-------------------|
| **Lifecycle Policies** | Transição entre classes de armazenamento | 20-70% |
| **EBS Volume Types** | Usar tipos adequados (gp3 vs io1) | 10-30% |
| **S3 Intelligent-Tiering** | Migração automática entre classes | 20-40% |
| **Snapshot Cleanup** | Remover snapshots antigos | 10-20% |

### 3. Otimização de Banco de Dados

| Estratégia | Descrição | Economia Potencial |
|------------|-----------|-------------------|
| **RDS Right-Sizing** | Ajustar tipo de instância | 10-30% |
| **Aurora Serverless** | Escalar de zero | 30-70% |
| **DynamoDB On-Demand** | Pague por uso | 20-50% |
| **Read Replicas** | Escalar leitura | 10-20% |

## Framework de Otimização

### 1. Medir

- Use **CloudWatch** para coletar métricas de CPU, memória, disco e rede
- Use **Cost Explorer** para analisar padrões de custo
- Use **Trusted Advisor** para identificar problemas

### 2. Analisar

- Identifique recursos subutilizados (CPU < 10%, memória < 30%)
- Identifique picos de custo inesperados
- Verifique se as instâncias estão corretas para a carga

### 3. Otimizar

- **Right-size** instâncias para a carga real
- Use **Spot Instances** para workloads tolerantes a interrupção
- Ative **Auto Scaling** para ajuste dinâmico
- Use **Savings Plans** para cargas estáveis

### 4. Monitorar

- Configure **alarmes** para métricas críticas
- Monitore **custos** com budgets e notificações
- Revise regularmente as recomendações do **Trusted Advisor**

## Casos de Uso

- **Otimização de Web Application**: Uma aplicação web em EC2 usa Auto Scaling para escalar entre 2-10 instâncias conforme a demanda, reduzindo custos em 40% durante períodos de baixa atividade.

- **Migração para Spot Instances**: Um cluster de processamento em lote usa Spot Instances com fallback para On-Demand, reduzindo custos de 90%.

- **Otimização de Armazenamento**: Dados antigos no S3 são movidos automaticamente para S3 Glacier via lifecycle policies, reduzindo custos de armazenamento em 70%.

- **Serverless para Cargas Variáveis**: Uma API com tráfego imprevisível migra de EC2 para Lambda + DynamoDB on-demand, reduzindo custos em 60% e eliminando a necessidade de gerenciamento de servidores.

## Links Oficiais

- [AWS Cost Explorer](https://docs.aws.amazon.com/costExplorer/latest/userguide/what-is-cost-explorer.html)
- [AWS Trusted Advisor](https://docs.aws.amazon.com/awssupport/latest/user/trusted-advisor.html)
- [Compute Optimizer](https://docs.aws.amazon.com/compute-optimizer/latest/ug/what-is-compute-optimizer.html)
