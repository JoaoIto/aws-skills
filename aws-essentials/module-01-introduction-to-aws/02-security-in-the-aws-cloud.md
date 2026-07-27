# Security in the AWS Cloud

## Visão Geral

A segurança na nuvem AWS é baseada no princípio de **Shared Responsibility Model** (Modelo de Responsabilidade Compartilhada): a AWS é responsável pela segurança **da** nuvem (infraestrutura subjacente), enquanto o cliente é responsável pela segurança **na** nuvem (dados, identidade, configurações).

A AWS opera sob a filosofia de **defense in depth** (defesa em profundidade), empregando múltiplas camadas de controle de segurança em diferentes níveis: rede, host, aplicação e dados. Todos os serviços da AWS são lançados de forma padrão com a **configuração mais segura possível**, seguindo o princípio de **least privilege** (menor privilégio necessário).

### Pilares da Segurança na AWS

| Pilar | Descrição | Serviços Principais |
|-------|-----------|---------------------|
| **Identity & Access Management** | Controle de acesso baseado em identidade e políticas | AWS IAM, AWS SSO, AWS Organizations |
| **Detective Controls** | Monitoramento e detecção de atividades | AWS CloudTrail, Amazon GuardDuty, AWS Config |
| **Infrastructure Protection** | Proteção da infraestrutura de rede e host | AWS WAF, AWS Shield, Security Groups, NACLs |
| **Data Protection** | Criptografia e proteção de dados em repouso e em trânsito | AWS KMS, AWS Certificate Manager, S3 Encryption |
| **Incident Response** | Automação e resposta a incidentes de segurança | AWS Systems Manager, Amazon EventBridge, AWS Lambda |

## Conceitos Chave

- **Shared Responsibility Model**: A AWS gerencia a segurança **da** nuvem — hardware, software, rede, instalações e operações. O cliente gerencia a segurança **na** nuvem — dados, aplicações, sistemas operacionais, redes e identidade. Por exemplo, a AWS protege o hypervisor; o cliente configura Security Groups corretamente.

- **AWS Identity and Access Management (IAM)**: Serviço central de gerenciamento de acesso. Permite criar **usuários**, **grupos** e **funções** (roles) com políticas JSON que definem permissões. Princípios-chave:
  - **Least Privilege**: Conceda apenas as permissões mínimas necessárias.
  - **Grant Least Privilege by Default**: Políticas padrão negam tudo a menos que explicitamente permitido.
  - **Roles, não Users, para serviços**: Use roles para que serviços (como EC2) acessem outros serviços, em vez de credenciais estáticas.

- **Multi-Factor Authentication (MFA)**: Adiciona uma camada extra de segurança exigindo um segundo fator (app TOTP, token físico ou SMS) além da senha. Recomendado para **todos os usuários raiz e administradores**. A AWS oferece MFA virtual gratuita via app (Google Authenticator, Authy).

- **Root Account**: A conta raiz tem acesso irrestrito a todos os recursos. **Nunca use a conta raiz para tarefas cotidianas**. Recomenda-se: (1) ativar MFA na raiz, (2) usar usuários IAM para acesso diário, (3) nunca compartilhar credenciais de raiz.

- **Security Groups vs. Network ACLs**:
  - **Security Groups** (Stateful): Atuam como firewalls virtuais no nível de instância. São stateful — se você permite entrada, a saída correspondente é automaticamente permitida.
  - **Network ACLs** (Stateless): Atuam no nível de sub-rede. São stateless — regras de entrada e saída são independentes. Funcionam como firewall de perímetro.

- **Criptografia**: A AWS oferece criptografia em repouso (via AWS KMS) e em trânsito (via TLS). Serviços como S3, EBS e RDS oferecem criptografia por padrão ou com um clique. O **AWS Key Management Service (KMS)** gerencia chaves de criptografia de forma centralizada.

- **AWS Artifact**: Portal que fornece acesso sob demanda a relatórios de conformidade da AWS (SOC, ISO, PCI DSS, HIPAA, etc.) sem precisade de processos manuais de solicitação.

## Casos de Uso

- **Controle de Acesso Granular**: Uma equipe de desenvolvimento recebe acesso somente a recursos específicos em um ambiente de staging, usando políticas IAM com condições baseadas em tags (`Environment=staging`).

- **Auditoria de Conformidade**: Um auditor usa o AWS CloudTrail para revisar todas as chamadas de API em um período específico, verificando se houve acesso não autorizado a recursos sensíveis.

- **Proteção contra Ataques DDoS**: Uma aplicação web pública é protegida pelo AWS Shield Standard (gratuito) e AWS WAF, que bloqueia padrões maliciosos e limita taxas de requisições.

- **Criptografia de Dados Sensíveis**: Dados de clientes armazenados no RDS são criptografados com chaves gerenciadas pelo KMS, com políticas que restringem o acesso apenas a funções específicas.

## Links Oficiais

- [AWS Security Best Practices](https://docs.aws.amazon.com/whitepapers/latest/aws-security-best-practices/welcome.html)
- [Shared Responsibility Model](https://aws.amazon.com/compliance/shared-responsibility-model/)
