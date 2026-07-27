# Hands-On Lab: Implement and Manage Amazon DynamoDB

## Visão Geral

Neste laboratório prático, você criará uma tabela DynamoDB, inserirá dados, configurará índices secundários, habilitará streams e triggers, e testará consultas e atualizações. Este exercício demonstra os conceitos fundamentais de modelagem e gerenciamento de bancos de dados NoSQL.

### Objetivos de Aprendizagem

- Criar uma tabela DynamoDB com chave primária adequada
- Inserir, ler, atualizar e deletar itens
- Configurar índices secundários (GSI/LSI)
- Habilitar DynamoDB Streams e triggers (Lambda)
- Configurar backup e point-in-time recovery
- Testar consultas e escaneamento

### Pré-requisitos

- Conta AWS ativa (ou AWS Free Tier)
- Acesso de administrador à conta
- Navegador web com acesso ao AWS Management Console
- (Opcional) AWS CLI instalado e configurado

## Roteiro Passo a Passo

### Passo 1: Acessar o Console do DynamoDB

- [ ] Acesse o [AWS Management Console](https://console.aws.amazon.com/)
- [ ] Faça login com usuário administrador
- [ ] Na barra de busca, digite **DynamoDB** e selecione **DynamoDB**

### Passo 2: Criar a Tabela DynamoDB

- [ ] Clique em **Create table**
- [ ] Em **Table name**, digite `employee-directory`
- [ ] Em **Partition key**, digite `employee_id` (tipo: String)
- [ ] Marque **Add sort key** e digite `department` (tipo: String)
- [ ] **Table class**: Mantenha como **Standard**
- [ ] **Capacity**: Selecione **On-demand** (ideal para testes)
- [ ] Clique em **Create table**

### Passo 3: Inserir Itens (Employees)

- [ ] Com a tabela criada, clique em **Explore items** → **Create item**
- [ ] Insira o primeiro funcionário:

```json
{
  "employee_id": "emp-001",
  "department": "Engineering",
  "name": "João Silva",
  "email": "joao.silva@company.com",
  "hire_date": "2024-01-15",
  "salary": 8500,
  "skills": ["Python", "AWS", "Docker"]
}
```

- [ ] Clique em **Save**
- [ ] Insira mais dois funcionários:

```json
{
  "employee_id": "emp-002",
  "department": "Engineering",
  "name": "Maria Santos",
  "email": "maria.santos@company.com",
  "hire_date": "2023-06-10",
  "salary": 9200,
  "skills": ["Java", "Kubernetes", "GCP"]
}
```

```json
{
  "employee_id": "emp-003",
  "department": "Marketing",
  "name": "Carlos Oliveira",
  "email": "carlos.oliveira@company.com",
  "hire_date": "2024-03-20",
  "salary": 6800,
  "skills": ["SEO", "Content", "Analytics"]
}
```

- [ ] Clique em **Save** para cada um

### Passo 4: Consultar Itens

- [ ] Clique na aba **Explore items**
- [ ] Clique em **Query**
- [ ] Em **Partition key**, digite `emp-001`
- [ ] Clique em **Run**
- [ ] Verifique que o item do João Silva é retornado
- [ ] Clique em **Scan** (para ver todos os itens)
- [ ] Clique em **Run** e verifique que todos os funcionários são listados

### Passo 5: Atualizar um Item

- [ ] Na lista de itens, clique no item `emp-001`
- [ ] Clique em **Actions** → **Edit**
- [ ] Altere o salário de `8500` para `9000`
- [ ] Adicione `"AWS Certified"` à lista de skills
- [ ] Clique em **Save**
- [ ] Verifique que a atualização foi aplicada

### Passo 6: Configurar Índice Secundário (GSI)

- [ ] Clique na aba **Indexes** → **Create index**
- [ ] Em **Index name**, digite `department-index`
- [ ] Em **Partition key**, selecione `department`
- [ ] Em **Sort key**, selecione `hire_date`
- [ ] Marque **All** para projected attributes
- [ ] Clique em **Create**
- [ ] Aguarde o status mudar para **ACTIVE**
- [ ] Clique em **Explore items** → **Query**
- [ ] Em **Index**, selecione `department-index`
- [ ] Em **Partition key**, digite `Engineering`
- [ ] Clique em **Run**
- [ ] Verifique que os funcionários do Engineering são retornados

### Passo 7: Habilitar DynamoDB Streams

- [ ] Clique na aba **Exports and streams**
- [ ] Clique em **Enable stream**
- [ ] Selecione **New and old images** (para ver antes/depois)
- [ ] Clique em **Save changes**
- [ ] Aguarde o status mudar para **ENABLED**

### Passo 8: Configurar Trigger (Lambda)

- [ ] Clique na aba **Triggers** → **Create trigger**
- [ ] Clique em **Create trigger**
- [ ] Selecione **DynamoDB** como origem
- [ ] Em **DynamoDB table**, selecione `employee-directory`
- [ ] Em **Batch size**, digite `100`
- [ ] Em **Starting position**, selecione **Trim horizon**
- [ ] Clique em **Create function**
- [ ] No editor da função Lambda, cole:

```python
import json

def lambda_handler(event, context):
    for record in event['Records']:
        if record['eventName'] == 'INSERT':
            new_image = record['dynamodb']['NewImage']
            employee_id = new_image['employee_id']['S']
            print(f"Novo funcionário inserido: {employee_id}")
    return {
        'statusCode': 200,
        'body': json.dumps('Trigger executado com sucesso')
    }
```

- [ ] Clique em **Deploy**

### Passo 9: Testar o Trigger

- [ ] Volte para a tabela DynamoDB → **Explore items** → **Create item**
- [ ] Insira um novo funcionário:

```json
{
  "employee_id": "emp-004",
  "department": "HR",
  "name": "Ana Costa",
  "email": "ana.costa@company.com",
  "hire_date": "2024-05-01",
  "salary": 7200
}
```

- [ ] Clique em **Save**
- [ ] Acesse o console **CloudWatch** → **Logs** → **Log groups**
- [ ] Localize o grupo de logs da função Lambda
- [ ] Verifique que o log "Novo funcionário inserido: emp-004" aparece

### Passo 10: Configurar Backup e Recuperação

- [ ] Clique na aba **Backups** → **On-demand backup**
- [ ] Em **Backup name**, digite `employee-directory-backup-01`
- [ ] Clique em **Create backup**
- [ ] Clique na aba **Backups** → **Point-in-time recovery**
- [ ] Clique em **Edit** → marque **Enable**
- [ ] Clique em **Save**

### Passo 11: Deletar um Item

- [ ] Na lista de itens, clique no item `emp-004`
- [ ] Clique em **Actions** → **Delete**
- [ ] Confirme a exclusão
- [ ] Verifique que o item foi removido

## Verificação dos Resultados

| Verificação | Resultado Esperado |
|-------------|-------------------|
| Tabela `employee-directory` criada | ✅ Sim |
| 4 itens inseridos com sucesso | ✅ Sim |
| Consulta por partition key funciona | ✅ Sim |
| Scan retorna todos os itens | ✅ Sim |
| Atualização de salário aplicada | ✅ Sim |
| GSI `department-index` criado | ✅ Sim |
| Query no GSI retorna funcionários por departamento | ✅ Sim |
| DynamoDB Streams ativado | ✅ Sim |
| Trigger Lambda criado e configurado | ✅ Sim |
| Log do Lambda mostra inserção | ✅ Sim |
| Backup on-demand criado | ✅ Sim |
| Point-in-time recovery ativado | ✅ Sim |
| Item deletado com sucesso | ✅ Sim |

## Limpeza

Para evitar custos desnecessários:

- [ ] Exclua a tabela DynamoDB (selecionar tabela → Actions → Delete)
- [ ] Exclua a função Lambda criada
- [ ] Verifique no console DynamoDB que a tabela foi removida

## Links Oficiais

- [DynamoDB Developer Guide](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Welcome.html)
- [DynamoDB Best Practices](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/best-practices.html)
