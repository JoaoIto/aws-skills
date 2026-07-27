# Amazon VPC Security

## Visão Geral

A segurança na VPC (Virtual Private Cloud) é implementada através de **múltiplas camadas de controle de acesso**, seguindo o princípio de **defense in depth** (defesa em profundidade). Os principais mecanismos de segurança da VPC são:

1. **Security Groups** (firewalls stateful no nível de instância)
2. **Network ACLs** (firewalls stateless no nível de sub-rede)
3. **VPC Flow Logs** (auditoria e monitoramento de tráfego)

Esses mecanismos trabalham juntos para controlar o tráfego de entrada e saída, detectar anomalias e fornecer visibilidade sobre o padrão de comunicação entre recursos.

## Security Groups (Stateful)

### Como Funcionam

Os **Security Groups** atuam como firewalls virtuais no nível de **instância**. Eles são **stateful** — se você permite tráfego de entrada em uma porta, a resposta de saída correspondente é automaticamente permitida, e vice-versa.

```
┌─────────────────┐        Inbound        ┌─────────────────┐
│   Internet      │ ────────────────────▶ │  Security Group │
│                 │                       │  (regra: allow   │
│                 │ ◀──────────────────── │   port 80)      │
└─────────────────┘        Outbound       └─────────┬───────┘
                                                    │
                                                    ▼
                                              ┌─────────────┐
                                              │  Instância  │
                                              │   EC2       │
                                              └─────────────┘
```

### Regras de Security Group

| Direção | Controle | Estado |
|---------|----------|--------|
| **Inbound** | Porta, protocolo, origem | Stateful (resposta automática) |
| **Outbound** | Porta, protocolo, destino | Stateful (resposta automática) |

### Características Principais

- **Stateful**: Se você permite entrada na porta 80, a saída correspondente é automaticamente permitida. Não precisa criar regras de saída explícitas para respostas.
- **Avaliação cumulativa**: Todas as regras de todos os Security Groups associados a uma instância são avaliadas. Se **qualquer regra** permitir o tráfego, ele é permitido.
- **Referência cruzada**: Um Security Group pode referenciar outro Security Group como origem/destino. Útil para permitir acesso entre instâncias (ex: app server acessa DB server).
- **Regra de negação implícita**: Por padrão, **tudo é negado** a menos que explicitamente permitido. Não existe regra "deny" explícita — apenas "allow".
- **Limite de regras**: Cada Security Group pode ter até 60 regras de inbound e 60 de outbound (limites podem ser aumentados).

### Exemplo de Configuração

| Security Group | Inbound Rules | Outbound Rules |
|----------------|---------------|----------------|
| **Web Server** | Allow TCP 80 (0.0.0.0/0), Allow TCP 443 (0.0.0.0/0), Allow TCP 22 (meu-IP) | Allow all (0.0.0.0/0) |
| **App Server** | Allow TCP 8080 (Web SG), Allow TCP 22 (meu-IP) | Allow TCP 3306 (DB SG) |
| **Database** | Allow TCP 3306 (App SG) | Allow all (0.0.0.0/0) |

## Network ACLs (Stateless)

### Como Funcionam

Os **Network ACLs (NACLs)** atuam como firewalls no nível de **sub-rede**. Eles são **stateless** — regras de entrada e saída são avaliadas independentemente. Se você permite entrada em uma porta, precisa **explicitamente** permitir a saída correspondente.

### Regras de NACL

| Direção | Controle | Estado |
|---------|----------|--------|
| **Inbound** | Porta, protocolo, origem | Stateless (não afeta outbound) |
| **Outbound** | Porta, protocolo, destino | Stateless (não afeta inbound) |

### Características Principais

- **Stateless**: Regras de entrada e saída são independentes. Você precisa criar regras de saída explícitas para permitir respostas.
- **Ordem de avaliação**: Regras são avaliadas em ordem numérica (1-32766). Números ímpares (100, 101...) são comuns para facilitar adições intermediárias.
- **Allow e Deny**: Diferente de Security Groups (apenas allow), NACLs podem ter regras **allow** e **deny**. A regra **deny** sempre vence.
- **Regra de negação implícita**: Por padrão, **tudo é negado** a menos que explicitamente permitido.
- **Um NACL por sub-rede**: Cada sub-rede pode ter apenas **um** NACL. Múltiplas sub-redes podem compartilhar o mesmo NACL.

### Exemplo de Configuração de NACL

| Número | Direção | Tipo | Porta | Origem/Destino | Ação |
|--------|---------|------|-------|----------------|------|
| 100 | Inbound | TCP | 80 | 0.0.0.0/0 | ALLOW |
| 101 | Inbound | TCP | 443 | 0.0.0.0/0 | ALLOW |
| 102 | Inbound | TCP | 22 | meu-IP/32 | ALLOW |
| 103 | Inbound | ALL | ALL | 0.0.0.0/0 | DENY |
| 100 | Outbound | TCP | 80 | 0.0.0.0/0 | ALLOW |
| 101 | Outbound | TCP | 443 | 0.0.0.0/0 | ALLOW |
| 102 | Outbound | ALL | ALL | 0.0.0.0/0 | DENY |

## VPC Flow Logs

### Como Funcionam

Os **VPC Flow Logs** capturam metadados sobre o tráfego IP que entra e sai dos recursos em uma VPC. Eles não capturam o conteúdo do tráfego (payload), apenas informações sobre o fluxo.

### Campos Capturados

| Campo | Descrição |
|-------|-----------|
| **Version** | Versão do formato do log |
| **Account ID** | ID da conta AWS |
| **Interface ID** | ID da interface de rede (ENI) |
| **Src Addr** | Endereço IP de origem |
| **Dst Addr** | Endereço IP de destino |
| **Src Port** | Porta de origem |
| **Dst Port** | Porta de destino |
| **Protocol** | Protocolo (TCP=6, UDP=17, ICMP=1) |
| **Packets** | Número de pacotes |
| **Bytes** | Número de bytes |
| **Start/End** | Timestamp de início/fim do fluxo |
| **Action** | ACCEPT ou REJECT |
| **Log Status** | OK, NODATA, ou SKIPDATA |

### Destinos dos Logs

- **CloudWatch Logs**: Para visualização em tempo real, alertas e análise interativa.
- **S3**: Para armazenamento de longo prazo, análise com Athena, backup e compliance.

### Casos de Uso

- **Detecção de Anomalias**: Identificar padrões de tráfego incomuns (ex: tentativas de varredura de portas).
- **Auditoria de Segurança**: Revisar quais recursos estão recebendo conexões e de onde vêm.
- **Troubleshooting**: Diagnosticar problemas de conectividade (ex: tráfego sendo rejeitado por NACL).
- **Compliance**: Demonstrar conformidade com requisitos de auditoria de rede.

## Comparação: Security Groups vs. Network ACLs

| Característica | Security Groups | Network ACLs |
|----------------|-----------------|--------------|
| **Nível** | Instância (ENI) | Sub-rede |
| **Stateful** | Sim | Não |
| **Regras de negação** | Não (apenas allow) | Sim (allow e deny) |
| **Ordem de avaliação** | Cumulativa (todas as regras) | Numérica (1-32766) |
| **Avaliação** | Todas as regras são processadas | Primeira regra que corresponde vence |
| **Limite de regras** | 60 inbound + 60 outbound | 20 inbound + 20 outbound |
| **Uso típico** | Controle granular de acesso | Controle de perímetro, bloqueio de IP |

## Casos de Uso

- **Controle de Acesso Granular**: Security Groups permitem que instâncias de uma camada (ex: app) acessem apenas as portas necessárias em outra camada (ex: database), referenciando o SG da camada de app como origem.

- **Bloqueio de IP Malicioso**: Network ACLs são usadas para bloquear blocos de IP conhecidos por atividades maliciosas (ex: scanners de porta) antes mesmo de chegar às instâncias.

- **Isolamento de Sub-redes**: Sub-redes de banco de dados têm NACLs restritas (apenas tráfego da sub-rede de aplicação) e Security Groups que permitem acesso apenas da camada de aplicação.

- **Auditoria de Conformidade**: VPC Flow Logs são enviados para S3 e analisados com Athena para relatórios de conformidade, mostrando quais recursos recebem conexões externas.

## Links Oficiais

- [Security Groups](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html)
- [Network ACLs](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_ACLs.html)
- [VPC Flow Logs](https://docs.aws.amazon.com/vpc/latest/userguide/flow-logs.html)
