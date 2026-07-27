# Amazon EC2 Instance Lifecycle

## Visão Geral

O **ciclo de vida (lifecycle)** de uma instância EC2 descreve os **estados** pelos quais uma instância passa desde o lançamento até a terminação. Compreender esse ciclo de vida é essencial para gerenciar instâncias de forma eficiente, otimizar custos e planejar a alta disponibilidade.

Uma instância EC2 pode estar em um dos seguintes estados: **pending**, **running**, **stopping**, **stopped**, **shutting-down** e **terminated**. Cada transição de estado tem implicações específicas para custos, dados e disponibilidade.

## Estados do Ciclo de Vida

```
                    ┌─────────────┐
                    │  pending    │
                    │ (iniciando) │
                    └──────┬──────┘
                           │
                    ┌──────▼──────┐
                    │  running    │
                    │ (executando)│
                    └──┬───────┬──┘
                       │       │
              ┌────────┘       └────────┐
              │                         │
       ┌──────▼──────┐         ┌───────▼───────┐
       │  stopping   │         │ shutting-down │
       │ (parando)   │         │ (encerrando)  │
       └──────┬──────┘         └───────┬───────┘
              │                         │
       ┌──────▼──────┐         ┌───────▼───────┐
       │  stopped    │         │  terminated   │
       │ (parada)    │         │ (terminada)   │
       └──────┬──────┘         └───────────────┘
              │
              └──────► (pode voltar para running)
```

### Tabela de Estados

| Estado | Descrição | Custos | Dados | Transições Possíveis |
|--------|-----------|--------|-------|---------------------|
| **pending** | Instância está sendo inicializada | Sim (a partir do primeiro segundo) | - | → running |
| **running** | Instância está em execução | Sim (por hora/segundo) | Preservados | → stopping, → shutting-down |
| **stopping** | Instância está sendo parada | Sim (até terminar) | Preservados | → stopped |
| **stopped** | Instância está parada | Não (apenas armazenamento EBS) | Preservados | → pending (reinício), → terminated |
| **shutting-down** | Instância está sendo encerrada | Sim (até terminar) | Serão perdidos | → terminated |
| **terminated** | Instância foi encerrada permanentemente | Não | Perdidos (EBS pode ser preservado) | Nenhuma (irreversível) |

## Conceitos Chave

- **Pending (Inicializando)**: Quando você lança uma instância, ela entra no estado `pending` enquanto a AWS provisiona os recursos necessários (CPU, memória, armazenamento, rede). O sistema operacional é carregado a partir da AMI selecionada.

- **Running (Executando)**: A instância está ativa e pronta para receber conexões. Você é cobrado pelo tempo de execução (por segundo ou hora, dependendo do tipo de instância). É o estado onde a aplicação está operacional.

- **Stopping (Parando)**: Quando você para uma instância, ela entra no estado `stopping` brevemente enquanto a AWS desaloca os recursos de compute (CPU, memória). Os dados no EBS são preservados. O armazenamento EBS continua sendo cobrado.

- **Stopped (Parada)**: A instância está parada, mas todos os dados no EBS são preservados. Você não é cobrado por compute (CPU/memória), apenas pelo armazenamento EBS. A instância pode ser reiniciada a qualquer momento, retomando do estado `running`.

- **Shutting-down (Encerrando)**: Quando você termina uma instância, ela entra no estado `shutting-down` enquanto a AWS libera os recursos. Este é um processo irreversível - os dados não preservados no EBS serão perdidos.

- **Terminated (Terminada)**: A instância foi permanentemente encerrada. Esta ação é **irreversível**. Os volumes EBS padrão são excluídos automaticamente, a menos que você tenha configurado o atributo `Delete on Termination` como `false`.

- **Stop vs. Terminate**:
  - **Stop**: Preserva dados no EBS, pode ser reiniciada, não paga por compute
  - **Terminate**: Elimina a instância permanentemente, dados são perdidos (a menos que EBS seja preservado)

- **Auto Scaling e Lifecycle Hooks**: Auto Scaling Groups usam hooks de ciclo de vida para pausar instâncias em estados específicos (por exemplo, `EC2_INSTANCE_LAUNCHING`, `EC2_INSTANCE_TERMINATING`), permitindo execução de scripts personalizados antes que a instância entre ou saia do pool.

- **AMI Creation**: Você pode criar uma AMI (Amazon Machine Image) a partir de uma instância em execução ou parada. A AMI captura o estado do sistema, permitindo lançar novas instâncias com a mesma configuração. É uma prática comum para backup e escalabilidade.

- **Instance Retirement**: Em raras ocasiões, a AWS pode "aposentar" (retire) uma instância devido a falhas no hardware subjacente. A AWS notifica você antes e recomenda o uso de Auto Scaling para recuperação automática.

## Modelos de Preço por Estado

| Estado | Cobrança por Compute | Cobrança por Armazenamento | Observação |
|--------|---------------------|---------------------------|------------|
| **pending** | Sim | Sim (EBS) | Cobrado a partir do primeiro segundo |
| **running** | Sim | Sim (EBS) | Cobrança principal |
| **stopping** | Sim (parcial) | Sim (EBS) | Até o processo completar |
| **stopped** | **Não** | Sim (EBS) | Apenas armazenamento |
| **shutting-down** | Sim (parcial) | Sim (EBS) | Até o processo completar |
| **terminated** | Não | Não (EBS excluído) | A menos que preservado |

## Boas Práticas

- **Parar instâncias não utilizadas**: Para ambientes de desenvolvimento/teste, pare as instâncias quando não estiverem em uso para economizar custos de compute.

- **Configurar Delete on Termination**: Para volumes EBS que contêm dados importantes, configure `Delete on Termination = false` para preservá-los mesmo após a terminação da instância.

- **Usar Auto Scaling**: Em vez de gerenciar instâncias individuais, use Auto Scaling Groups para gerenciar o ciclo de vida automaticamente, incluindo substituição de instâncias com falha.

- **Criar AMIs regulares**: Crie AMIs periódicas de instâncias críticas para facilitar a recuperação e o lançamento de novas instâncias com configurações conhecidas.

- **Usar Spot Instances com cuidado**: Spot Instances podem ser interrompidas com aviso de 2 minutos. Use o ciclo de vida de parada para salvar estado e o Auto Scaling para recuperação.

## Casos de Uso

- **Desenvolvimento e Teste**: Uma equipe para as instâncias de desenvolvimento após o expediente para economizar custos, reiniciando-as na manhã seguinte. Os dados no EBS são preservados entre as sessões.

- **Recuperação de Desastres**: Uma empresa mantém uma AMI atualizada de seu servidor de produção. Em caso de falha, ela lança rapidamente uma nova instância a partir da AMI, minimizando o tempo de inatividade.

- **Manutenção de Sistema**: Um administrador para uma instância para aplicar atualizações de kernel ou modificar configurações de hardware (como tipo de instância), minimizando o impacto na aplicação.

- **Escalabilidade com Auto Scaling**: Um Auto Scaling Group gerencia automaticamente o ciclo de vida das instâncias, lançando novas instâncias durante picos de demanda e terminando-as quando a demanda cai.

## Links Oficiais

- [EC2 Instance Lifecycle](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-lifecycle.html)
- [Stop, Start, and Terminate Instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/StopStart.html)
- [Create an AMI](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/creating-an-ami-ebs.html)
- [Auto Scaling Lifecycle Hooks](https://docs.aws.amazon.com/autoscaling/ec2/userguide/lifecycle-hooks.html)
