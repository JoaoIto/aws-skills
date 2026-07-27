# AWS Container Services

## Visão Geral

**Containers** são uma tecnologia de virtualização leve que permite empacotar uma aplicação e todas as suas dependências em uma unidade padronizada (container) que pode ser executada consistentemente em qualquer ambiente. A AWS oferece serviços gerenciados para **armazenar**, **orquestrar** e **executar** containers, eliminando a complexidade de gerenciar a infraestrutura de orquestração.

Os serviços de container da AWS se dividem em três categorias principais:

| Categoria | Serviço | Descrição |
|-----------|---------|-----------|
| **Container Registry** | Amazon ECR | Armazenamento e gerenciamento de imagens Docker |
| **Orquestração** | Amazon ECS | Orquestrador de containers proprietário da AWS |
| **Orquestração** | Amazon EKS | Orquestrador de containers baseado em Kubernetes (open source) |

## Amazon Elastic Container Registry (ECR)

O **Amazon ECR** é um repositório privado de imagens Docker totalmente gerenciado. Ele se integra com o ECS e EKS, e também pode ser usado com Kubernetes on-premises.

### Conceitos Chave

- **Repositórios Privados**: As imagens são armazenadas em repositórios privados, acessíveis apenas por entidades autorizadas via IAM.
- **Lifecycle Policies**: Políticas que automaticamente removem imagens antigas ou não utilizadas, mantendo o repositório limpo e reduzindo custos.
- **Scanning de Vulnerabilidades**: O ECR escaneia imagens em busca de vulnerabilidades conhecidas (CVEs) na camada do sistema operacional.
- **Cross-Account Access**: Imagens podem ser compartilhadas entre contas da AWS via políticas de repositório.

## Amazon Elastic Container Service (ECS)

O **Amazon ECS** é um orquestrador de containers **proprietário** da AWS, totalmente gerenciado. Ele não requer que você instale ou gerencie um cluster de orquestração — a AWS gerencia a camada de orquestração.

### Conceitos Chave

- **Task Definitions**: Modelos JSON que definem **o que** executar (imagens, CPU, memória, portas, volumes). Uma task definition é como um "template" para um container ou grupo de containers.

- **Tasks e Services**:
  - **Task**: Uma instância de uma task definition (equivalente a um "pod" no Kubernetes).
  - **Service**: Garante que um número especificado de tasks esteja sempre em execução, com auto-restart e integração com Load Balancers.

- **Clusters**: Grupos de instâncias EC2 (ou uso de Fargate) onde os containers são executados. O ECS agent (instalado nas instâncias) se comunica com o serviço de orquestração.

- **Launch Types**:
  - **EC2**: Você gerencia as instâncias subjacentes. Mais controle, mas mais complexidade operacional.
  - **Fargate**: Sem servidor para containers. A AWS gerencia a infraestrutura de compute. Você paga por vCPU e memória usada pelo container. Ideal para microserviços e cargas de trabalho sem estado.
  - **External**: Executa tasks em ambientes on-premises ou em outras nuvens.

- **Integration com AWS**: O ECS se integra nativamente com IAM (roles para tasks), Security Groups, Load Balancers, CloudWatch e Auto Scaling.

## Amazon Elastic Kubernetes Service (EKS)

O **Amazon EKS** é um serviço gerenciado que executa **Kubernetes** na AWS sem que você precise instalar, operar ou gerenciar o cluster de controle do Kubernetes.

### Conceitos Chave

- **Control Plane Gerenciado**: A AWS gerencia o plano de controle (API server, etcd, scheduler), incluindo patches, alta disponibilidade e backups. Você gerencia apenas os **nodes** (instâncias EC2 ou Fargate).

- **Nodes**:
  - **EC2 Nodes**: Instâncias gerenciadas pela AWS ou auto-gerenciadas. Você controla o SO, patches e configurações.
  - **Fargate**: Executa pods sem gerenciar servidores. Ideal para workloads sem estado.
  - **EC2 Node Groups**: Grupos gerenciados de instâncias EC2 para o cluster EKS.

- **Add-ons**: Componentes do Kubernetes (como CoreDNS, kube-proxy, VPC CNI) que podem ser gerenciados pela AWS, recebendo atualizações automaticamente.

- **Namespaces e RBAC**: O Kubernetes usa namespaces para isolamento lógico e Role-Based Access Control (RBAC) para gerenciar permissões dentro do cluster.

## Comparação: ECS vs EKS

| Característica | Amazon ECS | Amazon EKS |
|----------------|------------|------------|
| **Complexidade** | Baixa (proprietário) | Alta (Kubernetes) |
| **Curva de Aprendizado** | Suave | Íngreme |
| **Curadoria de Comunidade** | AWS | Comunidade Kubernetes |
| **Fargate Support** | Sim | Sim |
| **Multi-cloud** | Não | Sim (via Kubernetes padrão) |
| **Integração AWS** | Nativa e profunda | Boa, mas requer mais configuração |
| **Caso de Uso Ideal** | Aplicações AWS-native, microserviços simples | Aplicações com Kubernetes existente, multi-cloud |

## Casos de Uso

- **Microserviços com Fargate**: Uma aplicação de e-commerce é dividida em microserviços (frontend, carrinho, pagamento), cada um executado como um container no ECS com Fargate, escalando independentemente.

- **Migração para Containers**: Uma aplicação monolítica é containerizada e migrada para o ECS, usando task definitions e services para gerenciar o ciclo de vida.

- **Kubernetes On-Premises para AWS**: Uma empresa com clusters Kubernetes on-premises migra para o EKS, mantendo a mesma API e ferramentas, mas com o control plane gerenciado pela AWS.

- **CI/CD com ECR**: Pipelines de CI/CD enviam imagens para o ECR, que são então implantadas em clusters ECS ou EKS via AWS CodeDeploy ou kubectl.

## Links Oficiais

- [Amazon ECS Developer Guide](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-what-is-api.html)
- [Amazon EKS User Guide](https://docs.aws.amazon.com/eks/latest/userguide/eks-what-is.html)
- [Amazon ECR User Guide](https://docs.aws.amazon.com/AmazonECR/latest/userguide/what-is-ecr.html)
