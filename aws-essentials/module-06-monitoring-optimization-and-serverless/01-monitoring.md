# Monitoring

## Visão Geral

O **monitoramento** na AWS envolve coletar, analisar e agir sobre métricas, logs e eventos de recursos e aplicações. A AWS fornece ferramentas abrangentes para monitoramento, incluindo **Amazon CloudWatch**, **AWS CloudTrail**, **AWS X-Ray** e **AWS Health**, permitindo visibilidade completa sobre a saúde, performance e custos da infraestrutura.

O monitoramento é essencial para:
- **Detecção de problemas** antes que afetem os usuários
- **Otimização de performance** e custos
- **Conformidade** e auditoria
- **Resposta a incidentes** e recuperação de desastres

## Ferramentas de Monitoramento

| Ferramenta | Tipo | Uso |
|------------|------|-----|
| **Amazon CloudWatch** | Métricas e Logs | Monitoramento de recursos e aplicações |
| **AWS CloudTrail** | Auditoria | Rastreamento de chamadas de API |
| **AWS X-Ray** | Tracing | Análise de performance de aplicações |
| **AWS Health** | Status | Monitoramento de saúde dos serviços |
| **AWS Config** | Configuração | Rastreamento de mudanças de configuração |
| **AWS Trusted Advisor** | Otimização | Recomendações de otimização |

## Amazon CloudWatch

O **Amazon CloudWatch** é o serviço central de monitoramento da AWS. Ele coleta e monitora **métricas** (CPU, memória, disco, rede), **logs** (aplicação, sistema) e **eventos** (agendados, de serviços) de recursos e aplicações na AWS.

```
┌─────────────────────────────────────────────────────────┐
│                    Amazon CloudWatch                    │
│                                                         │
│  ┌───────────────┐  ┌───────────────┐  ┌───────────────┐ │
│  │  Métricas     │  │  Logs         │  │  Alarmes      │ │
│  │  (CPU, Mem,   │  │  (App, Sys)   │  │  (Thresholds) │ │
│  │  Disc, Rede)  │  │               │  │               │ │
│  └───────────────┘  └───────────────┘  └───────────────┘ │
│                                                         │
│  ┌────────────────────────────────────────────────────┐ │
│  │  EventBridge (Eventos)                              │ │
│  │  (Agendados, de Serviços)                         │ │
│  └────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────┘
```

### Conceitos Chave

- **Métricas (Metrics)**: Dados numéricos que descrevem o desempenho e o estado de recursos. Exemplos: CPUUtilization, NetworkIn, DiskReadOps. Cada métrica tem **dimensões** (ex: InstanceId) para identificar o recurso específico.

- **Namespaces**: Contêineres lógicos para métricas. Exemplos: `AWS/EC2`, `AWS/RDS`, `AWS/Lambda`. Cada serviço da AWS tem seu próprio namespace.

- **Alarmes (Alarms)**: Recursos que monitoram métricas e tomam ações quando os valores cruzam **thresholds** definidos. Ações podem incluir: notificações via SNS, paradas de instâncias, ajustes de Auto Scaling.

- **Logs (Logs)**: Registros de eventos e mensagens de aplicações e sistemas. O CloudWatch Logs coleta, armazena e permite consulta de logs. Suporta **metric filters** para extrair métricas de logs.

- **Log Groups e Log Streams**: Log groups são coleções de logs (ex: `/aws/lambda/minha-funcao`). Log streams são sequências individuais de eventos dentro de um group (ex: um stream por instância).

- **Retention Policies**: Políticas que definem quanto tempo os logs são mantidos. Pode ser de 1 dia a 10 anos, ou manter indefinidamente.

- **CloudWatch Dashboards**: Visualizações personalizadas que exibem métricas e alertas em tempo real. Úteis para monitoramento de aplicações complexas.

- **EventBridge**: Serviço de eventos que permite reagir a eventos do CloudWatch, de serviços da AWS e de eventos personalizados. Substitui o CloudWatch Events.

### Métricas Principais

| Métrica | Descrição | Uso Típico |
|---------|-----------|------------|
| **CPUUtilization** | Porcentagem de CPU utilizada | Detectar sobrecarga |
| **NetworkIn/Out** | Bytes de entrada/saída | Monitorar tráfego |
| **DiskRead/WriteOps** | Operações de I/O de disco | Detectar gargalos |
| **MemoryUtilization** | Porcentagem de memória usada | Detectar vazamento |
| **StatusCheckFailed** | Falha em health checks | Detectar instâncias com problema |

## AWS CloudTrail

O **AWS CloudTrail** é um serviço de **auditoria** que registra todas as chamadas de API feitas na sua conta AWS. Ele fornece visibilidade sobre quem fez o quê, quando e de onde, permitindo auditoria de conformidade e detecção de atividades suspeitas.

### Conceitos Chave

- **Eventos de Trilha (Trail Events)**: CloudTrail registra eventos de **gestão** (API calls de gerenciamento) e eventos de **dados** (acesso a recursos como S3, Lambda).

- **Trilhas (Trails)**: Configurações que definem onde os eventos são registrados. Pode registrar em um bucket S3, enviar para CloudWatch Logs ou ambos.

- **Eventos de Gestão**: Chamadas de API para gerenciar recursos (ex: CreateBucket, RunInstances, DeleteUser). Registrados por padrão.

- **Eventos de Dados**: Chamadas de API para acessar dados em recursos (ex: GetObject no S3, InvokeFunction no Lambda). Não registrados por padrão (precisam ser habilitados).

- **Insights**: Recurso que detecta automaticamente atividades incomuns (picos de chamadas de API, padrões inesperados).

## AWS X-Ray

O **AWS X-Ray** é um serviço de **tracing distribuído** que ajuda a analisar e depurar aplicações distribuídas, como microserviços e aplicações serverless. Ele fornece visibilidade sobre como as solicitações fluem através dos componentes da aplicação.

### Conceitos Chave

- **Traces**: Registros de solicitações individuais que fluem através da aplicação. Cada trace contém **segments** e **subsegments**.

- **Segments**: Partes de um trace que representam trabalho realizado por um componente (ex: uma função Lambda, uma instância EC2).

- **Subsegments**: Partes mais detalhadas de um segmento (ex: chamadas a serviços externos, consultas a banco de dados).

- **Service Map**: Visualização gráfica que mostra como os componentes da aplicação se conectam e a latência entre eles.

## AWS Health

O **AWS Health** é um serviço que fornece **visibilidade sobre a saúde dos serviços da AWS** e como eles afetam seus recursos. Ele fornece notificações personalizadas sobre interrupções de serviço, manutenção programada e limites de serviço.

### Conceitos Chave

- **Eventos Pessoais**: Notificações sobre como interrupções de serviço da AWS afetam seus recursos específicos.

- **Eventos Públicos**: Notificações sobre interrupções de serviço que afetam a região ou serviço em geral.

- **Notificações de Manutenção**: Avisos sobre manutenção programada que pode afetar seus recursos.

## Configuração de Monitoramento

### 1. Configurar Alarmes do CloudWatch

```
┌─────────────────────────────────────────────────────────┐
│                    CloudWatch Alarm                     │
│                                                         │
│  Métrica: CPUUtilization                                │
│  Threshold: > 80% por 5 minutos                         │
│  Ação: Enviar notificação para SNS                      │
│                                                         │
│  Métrica: StatusCheckFailed                             │
│  Threshold: > 0 por 2 minutos                           │
│  Ação: Reiniciar instância EC2                          │
└─────────────────────────────────────────────────────────┘
```

### 2. Configurar CloudTrail

- [ ] Criar uma trilha (trail) para registrar eventos de gestão
- [ ] Habilitar eventos de dados para S3 e Lambda
- [ ] Configurar bucket S3 para armazenamento de logs
- [ ] Habilitar integração com CloudWatch Logs
- [ ] Configurar notificações de eventos críticos

### 3. Configurar X-Ray

- [ ] Adicionar instrumentação X-Ray ao código da aplicação
- [ ] Configurar amostragem de traces
- [ ] Visualizar service map e traces
- [ ] Configurar alarmes baseados em latência

## Casos de Uso

- **Detecção de Problemas**: Um alarme do CloudWatch detecta que a CPU de uma instância EC2 está acima de 80% por 5 minutos, enviando uma notificação para a equipe de operações.

- **Auditoria de Conformidade**: O CloudTrail registra todas as chamadas de API, permitindo que um auditor verifique quem acessou recursos sensíveis e quando.

- **Análise de Performance**: O X-Ray revela que uma função Lambda está com alta latência devido a uma consulta lenta ao DynamoDB, permitindo otimização.

- **Monitoramento de Saúde**: O AWS Health notifica sobre uma manutenção programada em uma região, permitindo planejamento de contingência.

- **Detecção de Anomalias**: O CloudTrail Insights detecta um pico incomum de chamadas DeleteBucket, indicando possível atividade maliciosa.

## Links Oficiais

- [Amazon CloudWatch](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/WhatIsCloudWatch.html)
- [AWS CloudTrail](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-user-guide.html)
- [AWS X-Ray](https://docs.aws.amazon.com/xray/latest/devguide/xray-concepts.html)
- [AWS Health](https://docs.aws.amazon.com/health/latest/ug/what-is-health.html)
