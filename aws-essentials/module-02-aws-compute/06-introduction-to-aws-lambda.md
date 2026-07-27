# Introduction to AWS Lambda

## Visão Geral

O **AWS Lambda** é o serviço de **Function as a Service (FaaS)** da AWS. Ele permite executar código **sem provisionar ou gerenciar servidores**, acionando a execução em resposta a eventos e escalando automaticamente. Você paga apenas pelo tempo de execução efetivo (em milissegundos) e pelo número de invocações — sem custo quando a função está inativa.

O Lambda suporta múltiplas linguagens de programação e runtimes, e pode ser integrado a dezenas de serviços da AWS para criar arquiteturas serverless completas.

## Como o Lambda Funciona

```
Evento → Lambda Runtime → Handler → Código → Resposta
```

1. Um **evento** (de S3, API Gateway, CloudWatch, etc.) aciona a função
2. A AWS provisiona um **ambiente de execução** (runtime) com o código carregado
3. O **handler** (entry point) recebe o evento e o contexto
4. O **código** é executado
5. A **resposta** é retornada ao serviço que acionou a função

## Conceitos Chave

- **Função (Function)**: A unidade básica de execução no Lambda. Uma função contém:
  - **Código**: O código-fonte (JavaScript, Python, Java, Go, .NET, Ruby, etc.)
  - **Handler**: O ponto de entrada (ex: `index.handler` em Node.js, `lambda_function.lambda_handler` em Python)
  - **Runtime**: O ambiente de execução (Node.js 18.x, Python 3.11, Java 11, etc.)
  - **Timeout**: Tempo máximo de execução (1 segundo a 15 minutos)
  - **Memória**: Quantidade de memória alocada (128 MB a 10 GB) — afeta CPU e rede proporcionalmente

- **Gatilhos (Triggers)**: Serviços ou eventos que acionam a função. Principais gatilhos:
  - **Amazon S3**: Upload, modificação ou exclusão de objetos
  - **Amazon DynamoDB**: Inserção, atualização ou remoção de itens
  - **Amazon SQS**: Recebimento de mensagens em filas
  - **Amazon SNS**: Recebimento de notificações
  - **Amazon API Gateway**: Requisições HTTP/HTTPS
  - **Amazon EventBridge / CloudWatch Events**: Eventos programados (cron) ou de serviços
  - **Amazon Kinesis**: Processamento de streams de dados
  - **AWS Step Functions**: Orquestração de workflows

- **Configuração de Memória e CPU**: No Lambda, a **memória alocada determina a CPU** atribuída à função. Quanto mais memória, mais CPU e rede disponíveis. A AWS recomenda ajustar a memória para equilibrar custo e desempenho — mais memória pode reduzir o tempo de execução, resultando em custo total menor.

- **Cold Start**: Quando uma função é invocada após um período de inatividade, a AWS precisa:
  1. Inicializar o runtime (carregar o interpretador da linguagem)
  2. Carregar o código da função
  3. Executar o código de inicialização (fora do handler)
  4. Invocar o handler com o evento

  Isso pode levar de 100ms a vários segundos. **Provisioned Concurrency** mantém ambientes pré-inicializados para eliminar cold starts.

- **Stateless**: Funções Lambda são **stateless** — não preservam dados entre invocações. Dados devem ser armazenados em serviços externos (DynamoDB, S3, RDS, etc.). O diretório `/tmp` (até 10 GB) pode ser usado para armazenamento temporário durante a execução.

- **Concorrência**: O Lambda escala automaticamente com a concorrência. Por padrão, a concorrência é **ilimitada** (exceto quota de conta). Você pode definir **reserved concurrency** para limitar ou garantir capacidade, e **provisioned concurrency** para manter ambientes pré-aquecidos.

- **Layers**: Pacotes reutilizáveis de código ou dependências (bibliotecas, SDKs personalizados) que podem ser anexados a múltiplas funções. Útil para compartilhar código comuns (ex: cliente HTTP, utilitários).

- **Ambiente de Execução e Contexto**: O objeto `context` fornecido ao handler contém metadados sobre a invocação (request ID, tempo restante, função, log group, etc.). Útil para logging e monitoramento.

## Exemplo de Código

### Python (Hello World)

```python
import json

def lambda_handler(event, context):
    # Log do evento recebido
    print(f"Evento recebido: {json.dumps(event)}")
    
    # Processar o evento
    nome = event.get('nome', 'Mundo')
    
    return {
        'statusCode': 200,
        'body': json.dumps({
            'mensagem': f'Olá, {nome}!',
            'requestId': context.aws_request_id
        })
    }
```

### Node.js (Hello World)

```javascript
exports.handler = async (event, context) => {
    console.log('Evento recebido:', JSON.stringify(event));
    
    const nome = event.nome || 'Mundo';
    
    return {
        statusCode: 200,
        body: JSON.stringify({
            mensagem: `Olá, ${nome}!`,
            requestId: context.awsRequestId
        })
    };
};
```

## Modelos de Preço

| Componente | Unidade de Medida | Preço (aproximado) |
|------------|-------------------|-------------------|
| **Invocações** | Por 1M de invocações | $1.00 por 1M (após 1M grátis/mês) |
| **Tempo de Execução** | 1ms, com 1ms de granularidade | $0.0000166667 por GB-s |
| **Provisioned Concurrency** | Por hora de concorrência provisionada | $0.0083333 por hora por GB-alocado |

> **Free Tier**: 1M invocações grátis/mês + 400.000 GB-s de tempo de execução grátis/mês (por 12 meses).

## Limites (Quotas)

| Limite | Valor |
|--------|-------|
| **Timeout máximo** | 15 minutos |
| **Memória máxima** | 10 GB |
| **Tamanho do deployment** | 250 MB (compactado), 50 MB (via console) |
| **Tamanho do /tmp** | 10 GB |
| **Concorrência por região** | 1.000 (padrão), expansível |
| **Número de funções** | 1.000 (padrão), expansível |
| **Camadas por função** | 5 |
| **Aliases por função** | 10 |

## Casos de Uso

- **Processamento de Imagens**: Quando um usuário faz upload de uma foto ao S3, uma função Lambda redimensiona a imagem para thumbnails e salva as versões processadas de volta ao S3.

- **APIs Serverless**: Uma API REST é construída com API Gateway + Lambda, onde cada endpoint é uma função Lambda que processa a requisição e retorna uma resposta JSON.

- **Automação de Segurança**: Uma função Lambda é acionada por alertas do GuardDuty para isolar automaticamente uma instância EC2 comprometida, revogando seus Security Groups.

- **Processamento de Logs**: Logs do CloudWatch são processados por uma função Lambda que extrai métricas, detecta padrões anômalos e envia alertas via SNS.

- **Webhooks e Integrações**: Uma função Lambda recebe webhooks de serviços de terceiros (como Stripe, GitHub) via API Gateway, validando e processando os eventos recebidos.

## Links Oficiais

- [AWS Lambda Developer Guide](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html)
- [Lambda Pricing](https://aws.amazon.com/lambda/pricing/)
