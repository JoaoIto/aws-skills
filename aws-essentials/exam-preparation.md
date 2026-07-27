# 📝 Preparação para o Exame AWS Certified Cloud Practitioner (CLF-C02)

> **Baseado no Curso AWS Technical Essentials | Nível: Fundamental | Próximo passo após a conclusão do curso**

---

## 📌 Introdução

O **AWS Technical Essentials** é o curso de base ideal para quem está iniciando na AWS. Ao finalizar seus 7 módulos, você possui a fundação teórica e prática necessária para enfrentar o **exame de certificação mais fundamental da AWS: o AWS Certified Cloud Practitioner (CLF-C02)**.

Este documento serve como seu **guia de preparação para o exame**, contendo:

- Especificações oficiais do exame (baseado no **Exam Guide oficial da AWS**)
- Matriz de domínios com pesos e foco de estudo
- Mapeamento entre os módulos do curso e os domínios do exame
- **Dicas de Ouro para a Prova** — as pegadinhas mais comuns cobradas pela banca

> 🔗 **Fonte oficial**: [AWS Certified Cloud Practitioner (CLF-C02) Exam Guide](https://d1.awsstatic.com/training-and-certification/docs-cloud-practitioner/AWS-Certified-Cloud-Practitioner_Exam-Guide.pdf)

---

## 📋 Especificações Oficiais do Exame

| Característica | Detalhe |
|----------------|---------|
| **Nome do Exame** | AWS Certified Cloud Practitioner (CLF-C02) |
| **Duração** | 140 minutos (2h 20min) |
| **Número de Questões** | 50 questões contabilizadas + 15 questões não contabilizadas (piloto) |
| **Formato** | Múltipla escolha e múltipla resposta |
| **Pontuação Mínima para Aprovação** | 700 (em escala de 100–1.000) |
| **Modelo de Pontuação** | Compensatório (não é necessário acertar cada domínio individualmente) |
| **Idioma** | Disponível em múltiplos idiomas (recomendado: inglês) |
| **Taxa** | USD 100 |
| **Recomendação de Experiência** | Até 6 meses de exposição à AWS (design, implementação e/ou operações) |

### Tipos de Questão

1. **Múltipla Escolha (Multiple Choice)**
   - Uma resposta correta e três incorretas (distratores)
   - Exemplo: "Qual serviço da AWS é um serviço de armazenamento de objetos?"

2. **Múltipla Resposta (Multiple Response)**
   - Duas ou mais respostas corretas entre cinco ou mais opções
   - Exemplo: "Escolha DUAS vantagens do Amazon S3 sobre o Amazon EBS"
   - ⚠️ **Sem pontuação parcial** — se você acertar apenas uma das duas, a questão conta como errada

### Modelo de Pontuação Compensatório

O exame utiliza um modelo **compensatório**, o que significa que:

- Você **não precisa acertar 70% em cada domínio individualmente**
- A pontuação final é calculada em escala (100–1.000)
- Questões em branco contam como **erradas** (não há penalidade por chute)
- Questões piloto (não contabilizadas) são usadas para calibrar futuras versões do exame

---

## 📊 Matriz de Domínios do Exame (CLF-C02)

| Domínio | % do Exame | Foco de Estudo |
|---------|------------|----------------|
| **Domínio 1: Conceitos de Nuvem (Cloud Concepts)** | 24% | Valor da nuvem AWS, Well-Architected Framework, migração, economia de nuvem |
| **Domínio 2: Segurança e Conformidade (Security and Compliance)** | 30% | Modelo de responsabilidade compartilhada, IAM, criptografia, conformidade |
| **Domínio 3: Tecnologia e Serviços em Nuvem (Cloud Technology and Services)** | 34% | Serviços principais: EC2, S3, RDS, VPC, Lambda, DynamoDB, CloudWatch |
| **Domínio 4: Preços, Suporte e Billing** | 12% | Modelos de preços, AWS Budgets, Support Plans, TCO |

### Detalhamento por Domínio

#### Domínio 1: Conceitos de Nuvem (24%)
- **1.1** Definir os benefícios da nuvem AWS (economias de escala, alta disponibilidade, elasticidade, agilidade)
- **1.2** Identificar princípios de design (Well-Architected Framework — 6 pilares: Excelência Operacional, Segurança, Confiabilça, Eficiência de Performance, Otimização de Custos, Sustentabilidade)
- **1.3** Entender estratégias de migração (AWS CAF, AWS Snowball, replicação de banco de dados)
- **1.4** Entender economia de nuvem (custos fixos vs variáveis, BYOL vs licenças incluídas, direcionamento de recursos, serviços gerenciados)

#### Domínio 2: Segurança e Conformidade (30%)
- **2.1** Entender o modelo de responsabilidade compartilhada (quem é responsável por quê, como muda por serviço)
- **2.2** Entender segurança, governança e conformidade (AWS Artifact, criptografia, logs de segurança)
- **2.3** Definir recursos de segurança e conformidade (IAM, grupos de segurança, NACLs, AWS Shield, GuardDuty, Inspector, Security Hub)

#### Domínio 3: Tecnologia e Serviços em Nuvem (34%)
- **3.1** Demonstrar conhecimento de serviços de computação (EC2, Lambda, ECS, EKS, Elastic Beanstalk)
- **3.2** Demonstrar conhecimento de serviços de rede (VPC, Subnets, Route 53, CloudFront, ALB/NLB, VPN, Direct Connect)
- **3.3** Demonstrar conhecimento de serviços de armazenamento (S3, EBS, EFS, Glacier, Storage Gateway, Snow Family)
- **3.4** Demonstrar conhecimento de serviços de banco de dados (RDS, DynamoDB, Aurora, Redshift, ElastiCache, DocumentDB)
- **3.5** Demonstrar conhecimento de serviços de monitoramento e confiabilidade (CloudWatch, CloudTrail, Config, Auto Scaling, ELB)

#### Domínio 4: Preços, Suporte e Billing (12%)
- **4.1** Comparar modelos de preços da AWS (On-Demand, Reserved, Spot, Savings Plans)
- **4.2** Comparar planos de suporte (Basic, Developer, Business, Enterprise)
- **4.3** Identificar ferramentas de gestão de custos (AWS Pricing Calculator, Cost Explorer, Budgets, TCO Calculator)

---

## 🗺️ Mapeamento: Curso AWS Technical Essentials → Domínios do Exame

| Módulo do Curso | Tópicos Principais | Domínios do Exame Cobertos |
|-----------------|--------------------|----------------------------|
| **Módulo 1: Introdução à AWS** | Cloud concepts, segurança, IAM, responsabilidade compartilhada | Domínio 1 (24%), Domínio 2 (30%) |
| **Módulo 2: Computação** | EC2, Lambda, ECS, EKS, ciclo de vida, serverless | Domínio 3 (34%) |
| **Módulo 3: Rede** | VPC, rotas, grupos de segurança, NACLs | Domínio 2 (30%), Domínio 3 (34%) |
| **Módulo 4: Armazenamento** | S3, EBS, Instance Store, tipos de armazenamento | Domínio 3 (34%) |
| **Módulo 5: Banco de Dados** | RDS, DynamoDB, bancos purpose-built | Domínio 3 (34%) |
| **Módulo 6: Monitoramento e Otimização** | CloudWatch, otimização, alta disponibilidade, serverless | Domínio 3 (34%), Domínio 4 (12%) |
| **Módulo 7: Resumo** | Revisão geral | Todos os domínios |

---

## 📚 Recursos de Estudo Recomendados

| Recurso | Tipo | Link |
|---------|------|------|
| **AWS Skill Builder - AWS Technical Essentials** | Curso | https://explore.skillbuilder.aws/learn/course/1851/aws-technical-essentials |
| **AWS Certified Cloud Practitioner Exam Guide (CLF-C02)** | Guia Oficial | https://d1.awsstatic.com/training-and-certification/docs-cloud-practitioner/AWS-Certified-Cloud-Practitioner_Exam-Guide.pdf |
| **AWS Official Practice Exam** | Simulado | https://skillbuilder.aws/learn/JSJ5VBDBRG/official-practice-exam-aws-certified-cloud-practitioner-clfc02--english/FHCY1FNYXJ |
| **Documentação AWS** | Referência | https://docs.aws.amazon.com/ |
| **AWS Well-Architected Framework** | Whitepaper | https://aws.amazon.com/architecture/well-architected/ |
| **AWS Whitepapers** | Referência | https://aws.amazon.com/whitepapers/ |

---

## 📌 Dicas de Ouro para a Prova

> *"As pegadinhas mais comuns cobradas pela banca sobre este curso base"*

### 1. Gestão de Tempo — Estratégia de 3 Passadas

| Passada | Duração | Estratégia |
|---------|---------|------------|
| **1ª Passada** | ~60 min (≈55 seg/q) | Responda o que é fácil. Marque "para revisar" se travar. |
| **2ª Passada** | ~20 min | Retorne apenas às questões marcadas. |
| **Revisão** | ~10 min | Verifique se todas têm resposta. Confira contagens em múltipla resposta. |

**⚠️ Regra de Ouro:** Nunca gaste mais de 3 minutos em uma única questão. Se travar, marque a resposta mais plausível e avance. A linha de aprovação é ~36–38 acertos de 50 questões.

**💡 Dica:** Faça o exame em inglês. Apenas alterne para seu idioma nativo em questões travadas — traduções mal feitas podem confundir mais.

### 2. Pegadinhas nos Tipos de Questão

#### a) Múltipla Resposta (Multiple Response)
- **Procure sempre** "Choose TWO" ou "Choose THREE" no enunciado
- **Leia a última linha** — a diferença visual da múltipla resposta é sutil
- **Sem pontuação parcial:** acertar apenas uma das duas respostas corretas conta como **errado**
- **Estratégia:** Se não consegue identificar ambas, marque a mais certa + a mais plausível

#### b) Negações e Perguntas Negativas
- Exemplo: *"Qual dos seguintes a AWS **não** é responsável?"*
- **Erro comum:** memorizar apenas "o que a AWS **é** responsável" e cair na negação
- **Técnica:** quando vir uma negação (NOT, EXCEPT, EXCEPT FOR), aponte com o dedo e relia o enunciado

#### c) Palavras-Chave BEST / MOST / PRIMARY
- Perguntas como *"qual é a **mais apropriada**?"* são frequentes
- **Erro comum:** múltiplas opções parecem corretas
- **Técnica:** identifique a palavra-chave que a questão enfatiza (custo, segurança, performance, carga operacional) e reduza a partir disso

#### d) Palavras-Tronco em Cenários
| Frase no Cenário | Pense em |
|-------------------|----------|
| "quer manter o data center…" | Híbrido (Outposts, VPN, Direct Connect) |
| "…precisa de operação 24/7" | Alta disponibilidade (Multi-AZ, Auto Scaling) |
| "…minimizar custos" | Otimização de custos (Spot, RI, Glacier) |
| "…resposta imediata" | On-Demand, SLA em tempo real (Suporte Business/Enterprise) |

### 3. Pares de Serviços Confundidos — Memorize as Diferenças

#### Segurança e Auditoria
| Serviço A | Serviço B | Diferença-Chave |
|-----------|-----------|-----------------|
| **CloudTrail** | **CloudWatch** | Quem fez a chamada de API vs estado de recursos e métricas |
| **CloudTrail** | **Config** | Quem chamou vs mudanças de configuração de recursos |
| **GuardDuty** | **Inspector** | Detecção de atividade vs varredura de vulnerabilidades |
| **GuardDuty** | **Macie** | Atividade de todos os recursos vs dados sensíveis no S3 |
| **WAF** | **Shield** | Ataques web (Camada 7) vs DDoS (Camadas 3/4) |
| **KMS** | **CloudHSM** | Chaves gerenciadas vs HSM dedicado (regulação rigorosa) |
| **Secrets Manager** | **Parameter Store** | Rotação automática vs configuração geral |

#### Computação
| Serviço A | Serviço B | Diferença-Chave |
|-----------|-----------|-----------------|
| **EC2** | **Lightsail** | Flexível/complexo vs simples/flat-rate |
| **EC2** | **Lambda** | Máquina virtual vs evento-driven (limite 15 min) |
| **Lambda** | **Fargate** | Unidade de função vs unidade de container |
| **ECS** | **EKS** | Orquestração nativa AWS vs Kubernetes |
| **Elastic Beanstalk** | **CloudFormation** | Deploy automático de app vs IaC |
| **Beanstalk** | **OpsWorks** | Abstração AWS vs Chef/Puppet |

#### Armazenamento
| Serviço A | Serviço B | Diferença-Chave |
|-----------|-----------|-----------------|
| **S3** | **EBS** | Objeto (HTTP) vs bloco (disco EC2) |
| **S3** | **EFS** | Objeto vs arquivo (montagem compartilhada) |
| **EBS** | **EFS** | Um EC2 vs múltiplos EC2 simultaneamente |
| **EFS** | **FSx** | Linux NFS vs Windows/Lustre |
| **S3 Standard-IA** | **S3 One Zone-IA** | Multi-AZ vs AZ única (backups recriáveis) |
| **Glacier Instant** | **Flexible** | **Deep Archive** | Imediato vs minutos-a-horas vs 12 horas |
| **Storage Gateway** | **Snow Family** | Gateway online vs dispositivo offline |

#### Rede
| Serviço A | Serviço B | Diferença-Chave |
|-----------|-----------|-----------------|
| **Security Group** | **NACL** | Stateful (instância) vs stateless (subnet) |
| **ALB** | **NLB** | Camada 7 (HTTP) vs Camada 4 (TCP/UDP, IP estático) |
| **VPN** | **Direct Connect** | Configuração rápida, barata vs linha dedicada, estável |
| **CloudFront** | **Global Accelerator** | Cache de CDN vs roteamento global (IP estático) |
| **Route 53** | **CloudFront** | DNS/roteamento vs cache de borda |

#### Banco de Dados
| Serviço A | Serviço B | Diferença-Chave |
|-----------|-----------|-----------------|
| **RDS** | **Aurora** | Engines padrão vs nativo AWS (5x performance) |
| **RDS** | **DynamoDB** | Relacional vs NoSQL |
| **DynamoDB** | **DocumentDB** | Key-value vs compatível MongoDB |
| **Redshift** | **RDS** | OLAP (analítica) vs OLTP (transacional) |
| **ElastiCache Redis** | **Memcached** | Persistência/replicação/Pub-Sub vs cache simples |
| **Redshift** | **Athena** | DW (carregar depois consultar) vs consulta direta no S3 |

#### Custos e Operações
| Serviço A | Serviço B | Diferença-Chave |
|-----------|-----------|-----------------|
| **RI** | **Savings Plans** | Compromisso com tipo específico vs compromisso com gasto horário ($/h) |
| **Dedicated Host** | **Dedicated Instance** | Servidor físico vs instância single-tenant |
| **Pricing Calculator** | **Cost Explorer** | Pre-estimação vs visualização de tendências |
| **Cost Explorer** | **AWS Budgets** | Tendências vs alertas de orçamento |
| **Trusted Advisor** | **Well-Architected Tool** | Verificações automatizadas em 5 categorias vs autoavaliação por 6 pilares |

### 4. Técnicas para Reduzir Respostas

#### a) Fixe-se na Palavra-Chave da Questão
Quando duas respostas parecem corretas, reduza para a que corresponde à palavra-chave enfatizada (custo, segurança, performance, carga operacional).

> **Exemplo:** *"Run EC2 as cheaply as possible while tolerating interruption"* → **Spot Instance**

#### b) Elimine Respostas Anti-Padrão Primeiro
Risque estas quase automaticamente:
- ❌ "Usar o usuário root para trabalho diário"
- ❌ "Conceder AdministratorAccess a todos os usuários"
- ❌ "Codificar access keys no código"
- ❌ "Armazenar access keys em EC2 para chamar S3"
- ❌ "Rodar um DB de produção em Spot"
- ❌ "Private Cloud é a opção mais segura"
- ❌ "Usar AWS Artifact para verificar conformidade de cargas de trabalho do cliente"

#### c) "Gerenciado vs Auto-Administrado"
A resposta que prefere um **serviço gerenciado** é frequentemente correta. A resposta que transfere a carga operacional para a AWS é geralmente mais próxima da correta (ex: "Use RDS para MySQL" vs "administre seu próprio MySQL em EC2").

### 5. Erros Mais Comuns que Fazem Candidatos Falarem

| # | Erro | Como Evitar |
|---|------|-------------|
| **1** | **Tratar o CLF-C02 como exame de memorização** | Estude conceitos primeiro, depois aprenda como os serviços os implementam. Entenda o espectro de EC2 (controle total) a Lambda (serverless). |
| **2** | **Ignorar estratégia de questões baseadas em cenário** | Leia o cenário duas vezes. Primeira passada: contexto de negócio e restrições. Segunda passada: mapeie requisitos técnicos. |
| **3** | **Subpreparação nos domínios de maior peso** | Aloque tempo de estudo proporcional aos pesos (34% Tecnologia, 30% Segurança). Foque em *quando* usar serviços, não apenas em *o quê*. |
| **4** | **Leitura superficial de enunciados** | Destaque frases-chave antes de olhar as opções. "Most cost-effective", "most secure", "quickest to implement" exigem prioridades diferentes. |
| **5** | **Agendar a prova antes da maturidade real** | Agende apenas após dominar questões complexas que exigem equilibrar múltiplos fatores, não apenas identificar serviços. |
| **6** | **Materiais de estudo desatualizados** | Verifique se os materiais têm menos de 12 meses. Cross-reference com a documentação oficial atual. |

### 6. Checklist Final Antes do Exame

- [ ] Revisei o **Shared Responsibility Model** (quem é responsável por quê em EC2, RDS, Lambda)
- [ ] Memorizei as **diferenças entre pares de serviços** (tabela acima)
- [ ] Entendo **quando usar** cada tipo de armazenamento (S3, EBS, EFS, Glacier)
- [ ] Sei escolher entre **EC2, Lambda, ECS, Fargate** baseado no cenário
- [ ] Domino os **modelos de preço** (On-Demand, Reserved, Spot, Savings Plans)
- [ ] Conheço os **planos de suporte** (Basic, Developer, Business, Enterprise)
- [ ] Revisei os **6 pilares do Well-Architected Framework**
- [ ] Pratiquei **questões de múltipla resposta** (sem pontuação parcial)
- [ ] Fiz pelo menos **um exame de prática oficial** (AWS Official Practice Exam)

---

## 🔗 Referências Oficiais

- **AWS Certified Cloud Practitioner (CLF-C02) Exam Guide**: https://d1.awsstatic.com/training-and-certification/docs-cloud-practitioner/AWS-Certified-Cloud-Practitioner_Exam-Guide.pdf
- **AWS Skill Builder - AWS Technical Essentials**: https://explore.skillbuilder.aws/learn/course/1851/aws-technical-essentials
- **AWS Official Practice Exam CLF-C02**: https://skillbuilder.aws/learn/JSJ5VBDBRG/official-practice-exam-aws-certified-cloud-practitioner-clfc02--english/FHCY1FNYXJ
- **AWS Well-Architected Framework**: https://aws.amazon.com/architecture/well-architected/
- **Documentação AWS**: https://docs.aws.amazon.com/
- **AWS Whitepapers**: https://aws.amazon.com/whitepapers/

---

> **Regra de Ouro**: Todo conteúdo neste repositório é baseado na documentação oficial da AWS. As dicas de prova são compiladas de fontes confiáveis e atualizadas, mas sempre cross-reference com o **Exam Guide oficial da AWS** para a informação mais current.
