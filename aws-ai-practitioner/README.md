# 🤖 AWS Artificial Intelligence Practitioner

> **Plano de Estudos AWS | Nível: Fundamental | Próximo passo após AWS Technical Essentials**

---

## 📖 Visão Geral

O **AWS Artificial Intelligence Practitioner Learning Plan** é o plano de estudos oficial da AWS para a certificação **AWS Certified AI Practitioner (AIF-C01)**. Ele abrange conceitos fundamentais de IA/ML, IA generativa, aplicações de modelos de base, responsabilidade e governança.

Este plano de estudos é o **próximo passo** após a conclusão do curso **AWS Technical Essentials**.

---

## 🏗️ Base da Infraestrutura de IA e ML na AWS

A AWS oferece um conjunto abrangente de serviços de ML e IA generativa que podem ajudar você a liberar todo o potencial dessas tecnologias transformadoras.

Nesta lição, você aprenderá sobre os vários serviços de IA e ML disponíveis na AWS, desde a compreensão de texto com o **Amazon Comprehend** até a geração de código com o **Amazon Q Developer**. Você obterá uma ampla compreensão dos recursos de cada serviço e de como eles podem ser usados para criar aplicações inovadoras e inteligentes.

Você também explorará as vantagens de usar os serviços de IA generativa da AWS e os benefícios da infraestrutura da AWS ao desenvolver aplicações de IA generativa. Por fim, você conhecerá as vantagens e desvantagens de custos e as considerações que deve ter em mente ao usar essas ferramentas poderosas.

### 📊 Pilha de Serviços de IA/ML da AWS

A AWS inova rapidamente em todo o conjunto de IA e ML, oferecendo recursos abrangentes, desde infraestrutura e ferramentas até aplicações inovadoras, como programação baseada em IA. Os clientes valorizam a abordagem da AWS que prioriza os dados, a segurança e a variedade de ofertas de nível corporativo que abrangem todas as camadas.

A pilha de serviços de IA/ML da AWS é organizada em três camadas:

#### Camada 1: Frameworks de ML

A camada de frameworks de ML desempenha um papel crucial no desenvolvimento e na implantação de modelos de machine learning. No centro da camada de frameworks está o **Amazon SageMaker IA** (o novo nome do antigo Amazon SageMaker). Ele lida especificamente com os fluxos de trabalho tradicionais de ML: criação, treinamento e implantação de modelos, oferecendo as ferramentas certas para criar, treinar e executar LLMs e outros FMs de forma eficiente e econômica.

| Serviço | Descrição |
|---------|-----------|
| **Amazon SageMaker IA** | Plataforma completa para criação, treinamento e implantação de modelos de ML, incluindo LLMs e FMs |

#### Camada 2: Serviços de IA e ML

A AWS fornece uma camada robusta de serviços de IA/ML, oferecendo soluções prontas para uso. Essa camada inclui uma ampla variedade de serviços que fornecem aos desenvolvedores recursos de IA/ML sem exigir amplo gerenciamento de infraestrutura ou conhecimento especializado.

| Serviço | Caso de Uso |
|---------|-------------|
| **Amazon Comprehend** | Processamento de linguagem natural (análise de sentimentos, extração de entidades) |
| **Amazon Translate** | Tradução automática entre 75+ idiomas |
| **Amazon Textract** | Extração de dados de documentos escaneados (tabelas, formulários) |
| **Amazon Lex** | Criação de chatbots conversacionais |
| **Amazon Polly** | Síntese de fala a partir de texto |
| **Amazon Transcribe** | Reconhecimento de fala para transcrição em texto |
| **Amazon Rekognition** | Análise de imagens e vídeos (detecção de objetos, rostos, texto) |
| **Amazon Kendra** | Pesquisa inteligente em dados organizacionais |
| **Amazon Personalize** | Sistemas de recomendação personalizados |
| **AWS DeepRacer** | Aprendizado de reforço de forma lúdica e educacional |

#### Camada 3: IA Generativa

A camada de serviços de IA generativa na pilha de IA e ML oferece um conjunto de ferramentas e serviços poderosos projetados especificamente para tarefas de IA generativa. Essa camada inclui serviços como o SageMaker JumpStart, para acelerar o desenvolvimento e a implantação de modelos. O Amazon Bedrock oferece uma variedade de FMs de alto desempenho das principais empresas de IA por meio de uma única API.

| Serviço | Descrição |
|---------|-----------|
| **Amazon SageMaker JumpStart** | Acelera o desenvolvimento e a implantação de modelos com soluções pré-configuradas |
| **Amazon Bedrock** | Acesso a FMs de alto desempenho (Anthropic, AI21, Cohere, Amazon) via API única |
| **Amazon Q** | Assistente de IA generativa para tarefas empresariais |
| **Amazon Q Developer** | Geração de código e assistência ao desenvolvedor |

---

### 💡 Vantagens e Benefícios das Soluções de IA da AWS

De pequenas startups a grandes empresas, as organizações confiam na AWS para inovar com poderosas ferramentas de IA. A AWS oferece recursos de segurança e privacidade de alto nível para manter seus dados seguros e oferece acesso aos modelos de IA mais avançados disponíveis.

Com a AWS, você pode criar e desenvolver suas próprias aplicações de IA personalizadas que usam IA generativa. Essas aplicações podem ser personalizadas de acordo com suas necessidades específicas. A AWS ajuda você a aproveitar a tecnologia de IA generativa e criar algo verdadeiramente único e personalizado.

| Benefício | Detalhe |
|-----------|---------|
| **Segurança e privacidade** | Recursos robustos de segurança, atributos de conformidade específicos do setor e modelo de responsabilidade compartilhada |
| **Dados protegidos** | Seus dados não são usados para treinar modelos de base sem sua permissão |
| **Acesso a FMs de ponta** | Acesso aos modelos de IA mais avançados disponíveis no mercado |
| **Infraestrutura escalável** | Infraestrutura segura e compatível para criar aplicações de IA |
| **Personalização** | Criação de aplicações de IA totalmente personalizadas para suas necessidades específicas |
| **Desenvolvimento responsável** | Serviços e ferramentas que apoiam o desenvolvimento e a implantação responsáveis de soluções de IA tradicionais e generativas |

---

### 💰 Considerações sobre Custos

Ao trabalhar com serviços de IA e ML na AWS, é essencial entender as várias considerações de custo envolvidas. As vantagens e desvantagens podem afetar fatores como capacidade de resposta, disponibilidade, redundância, desempenho, cobertura regional, modelos de preços, throughput e a capacidade de usar modelos personalizados.

<details>
<summary><strong>📌 Capacidade de resposta e disponibilidade</strong></summary>

A capacidade de resposta (latência) e a disponibilidade dos serviços de IA podem variar significativamente dependendo do serviço escolhido, da região da AWS e do volume de solicitações. Serviços gerenciados oferecem alta disponibilidade, mas podem ter latência variável. Já soluções self-hosted permitem otimização de latência, mas exigem gestão de alta disponibilidade.

</details>

<details>
<summary><strong>📌 Redundância e cobertura regional</strong></summary>

A disponibilidade de serviços de IA e ML varia por região da AWS. Alguns serviços (como o Amazon Bedrock) podem não estar disponíveis em todas as regiões, o que afeta a estratégia de redundância e a latência para os usuários finais. É importante verificar a disponibilidade regional antes de arquitetar a solução.

</details>

<details>
<summary><strong>📌 Desempenho</strong></summary>

O desempenho dos modelos de IA depende de fatores como tamanho do modelo, otimização de inferência, uso de acelerares (GPU/Neuron) e arquitetura da solução. O provisionamento inadequado pode levar a custos elevados ou à capacidade de resposta insatisfatória.

</details>

<details>
<summary><strong>📌 Preços baseados em tokens</strong></summary>

Muitos serviços de IA generativa (como o Amazon Bedrock e o Amazon Q) utilizam modelos de preçagem baseados em tokens — tanto para entrada (input) quanto para saída (output). O custo varia por modelo e região. É essencial monitorar o número de tokens consumidos para controlar os custos.

</details>

<details>
<summary><strong>📌 Throughput provisionado</strong></summary>

Alguns serviços permitem provisionar throughput (por exemplo, via Amazon SageMaker ou Amazon Bedrock com Provisioned Throughput), oferecendo previsibilidade de custos e capacidade de resposta para cargas de trabalho com demanda consistente. Isso pode ser mais econômico que o pagamento por demanda para workloads estáveis.

</details>

<details>
<summary><strong>📌 Modelos personalizados</strong></summary>

O uso de modelos personalizados (fine-tuning ou modelos próprios) pode oferecer melhor desempenho para domínios específicos, mas envolve custos adicionais de treinamento, armazenamento e inferência. A decisão entre modelos pré-treinados e personalizados deve equilibrar precisão, custo e complexidade operacional.

</details>

> **Dica:** Ao avaliar cuidadosamente seus requisitos e workload específicos, você pode tomar decisões informadas e otimizar suas implantações de IA da AWS para equilibrar custos, desempenho e outros requisitos de forma eficaz.

---

## 📚 Sumário (Table of Contents)

| Módulo | Status | Link |
|--------|--------|------|
| **Fundamentals of Machine Learning and Artificial Intelligence** | ✅ Em andamento | [fundamentals-ml-ai/fundamentals-ml-ai.md](https://github.com/JoaoIto/aws-skills/blob/main/aws-ai-practitioner/fundamentals-ml-ai/readme.md) |
| **Exploring Artificial Intelligence Use Cases and Applications** | ✅ Concluído | [use-cases/readme.md](https://github.com/JoaoIto/aws-skills/blob/main/aws-ai-practitioner/use-cases/readme.md) |
| **Guidelines for Responsible AI** | ✅ Concluído | [responsible-AI/readme.md](https://github.com/JoaoIto/aws-skills/blob/main/aws-ai-practitioner/responsible-AI/readme.md) |
| Fundamentals of Generative AI | ⏳ Pendente | — |
| Applications of Foundation Models | ⏳ Pendente | — |
| Security, Compliance, and Governance | ⏳ Pendente | — |

---

## 📜 Certificados e PDFs

| Curso | Certificado |
|-------|-------------|
| **Fundamentals of Machine Learning and Artificial Intelligence** | [<img src="https://raw.githubusercontent.com/JoaoIto/aws-skills/refs/heads/main/aws-ai-practitioner/fundamentals-ml-ai/docs/Fundamentals%20of%20Machine%20Learning%20and%20Artificial%20Intelligence-png.png" width="100"/>](https://github.com/JoaoIto/aws-skills/blob/main/aws-ai-practitioner/fundamentals-ml-ai/docs/Fundamentals%20of%20Machine%20Learning%20and%20Artificial%20Intelligence.pdf) |
| **Exploring Artificial Intelligence Use Cases and Applications** | [<img src="https://raw.githubusercontent.com/JoaoIto/aws-skills/refs/heads/main/aws-ai-practitioner/use-cases/docs/Exploring%20Artificial%20Intelligence%20Use%20Cases%20and%20Applications-png.png" width="100"/>](https://github.com/JoaoIto/aws-skills/blob/main/aws-ai-practitioner/use-cases/docs/Exploring%20Artificial%20Intelligence%20Use%20Cases%20and%20Applications.pdf) |
| **Guidelines for Responsible AI** | [<img src="https://raw.githubusercontent.com/JoaoIto/aws-skills/refs/heads/main/aws-ai-practitioner/responsible-AI/docs/responsible-AI-png.png" width="100"/>](https://github.com/JoaoIto/aws-skills/blob/main/aws-ai-practitioner/responsible-AI/docs/responsible-AI.pdf) |
| Fundamentals of Generative AI | ⏳ Pendente |
| Applications of Foundation Models | ⏳ Pendente |
| Security, Compliance, and Governance | ⏳ Pendente |

---

## 🗺️ Roadmap de Certificações

```
┌─────────────────────────────────────────────────────────────────┐
│                    ROADMAP DE CERTIFICAÇÕES                     │
└─────────────────────────────────────────────────────────────────┘

  [1] AWS Technical Essentials
      └── STATUS: ✅ CONCLUÍDO

  [2] AWS Artificial Intelligence Practitioner Learning Plan  ← ATUAL
      └── Fundamentos de ML e IA
      └── Casos de Uso de IA
      └── IA Generativa
      └── Modelos de Base
      └── IA Responsável
      └── Segurança e Governança
      └── STATUS: 🔄 EM ANDAMENTO

  [3] AWS Cloud Practitioner Essentials
      └── STATUS: ⏳ PENDENTE

  [4] AWS Solutions Architect – Associate
      └── STATUS: ⏳ PENDENTE
```

---

## 📂 Estrutura do Diretório

```
aws-ai-practitioner/
├── README.md                              # Este arquivo
├── fundamentals-ml-ai/                    # Módulo 1
│   └── fundamentals-ml-ai.md              # Documentação técnica
├── use-cases/                             # Módulo 2
│   └── readme.md                          # Documentação técnica
├── generative-ai/                         # Módulo 3 (planejado)
├── foundation-models/                     # Módulo 4 (planejado)
├── responsible-ai/                        # Módulo 5
│   └── readme.md                          # Documentação técnica
└── security-governance/                   # Módulo 6 (planejado)
```

---

## 🏆 Certificação e Conquistas

| Detalhe | Informação |
|---------|------------|
| **Certificação** | AWS Certified AI Practitioner (AIF-C01) |
| **Plataforma** | AWS Skill Builder |
| **Status** | 🔄 Em andamento |
| **Guia de Exame** | [Ver PDF oficial](../docs/aif-c01-exam-guide.pdf) |

---

## 🔗 Referências Oficiais

- **AWS AI Practitioner Learning Plan**: https://explore.skillbuilder.aws/
- **AWS Certified AI Practitioner (AIF-C01) Exam Guide**: https://d1.awsstatic.com/training-and-certification/docs-ai-practitioner/AWS-Certified-AI-Practitioner_Exam-Guide.pdf ([PDF local](../docs/aif-c01-exam-guide.pdf))
- **Amazon SageMaker Documentation**: https://docs.aws.amazon.com/sagemaker/
- **AWS AI Services**: https://aws.amazon.com/ai/

---

> **Regra de Ouro**: Todo conteúdo neste repositório é baseado na documentação oficial da AWS. Novos tópicos são pesquisados profundamente antes de serem documentados.
